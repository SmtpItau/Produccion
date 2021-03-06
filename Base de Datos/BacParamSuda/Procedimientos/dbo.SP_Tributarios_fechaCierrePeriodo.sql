USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_Tributarios_fechaCierrePeriodo]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Tributarios_fechaCierrePeriodo]
   (   @xxFechaProceso	       datetime
   ,   @xxFechaCierrePeriodo   datetime   OUTPUT
   ,   @xxFechaInicioPeriodo   datetime   OUTPUT
   ,   @xxFechaCierreMes	   datetime   OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   -->     [1.0] Fecha de Proceso ... Deberia llegar como parametro
   declare @dfechaproceso     datetime
       set @dfechaproceso     = @xxFechaProceso	--> (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))

   -->     [2.0] Fecha de Cierre año anterior, se determina a partir del periodo dado por la fecha de proceso [1.0]
   declare @dfechacierre      datetime	
       set @dfechacierre      = ltrim(rtrim( datepart(year, dateadd(year, -1, @dfechaproceso)) )) + '1231'

   -->     [3.0] Lee la tabla de feriados para el mes de corte en dura (DICIEMBRE)
   declare @dferiados	      varchar(100)
       set @dferiados         = (select fedic from bacparamsuda.dbo.feriado where feano = year(@dfechacierre) and feplaza = 6)

   -->     [4.0] Lee el ultimo día del año con respecto a los feriados para determinar la ultima fecha con datos.
   declare @lastday           char(2)
       set @lastday           = case when len( ltrim(rtrim( datepart(day, @dfechacierre) )) ) = 1 then '0' else '' end
			      + ltrim(rtrim( datepart(day, @dfechacierre) ))

   -->     [5.0] Realiza el cliclo a partir del [3.0] y [4.0] para identificar el ultimo dia con datos
   while 2 > 1
   begin
      --> [5.0.1] Identifique que el día esta registrado como feriado
      if charindex( @LastDay , @dFeriados) > 0
         set @dFechaCierre = dateadd( day, -1, @dFechaCierre )	--> [5.0.2] Lee el día anterior a la fecha generada
      else
         break                                                  --> [5.0.3] Fecha valida y Rompe el Ciclo

      --> [5.0.4]  Lee el día anterir al cierre de año determinado
      set @LastDay	= CASE WHEN LEN( LTRIM(RTRIM( DATEPART(DAY, @dFechaCierre) )) ) = 1 THEN '0' ELSE '' END
			+ LTRIM(RTRIM( DATEPART(DAY, @dFechaCierre) ))
   end

   -->	[5.1] Retorna el Valor Calculado	
   set @xxFechaCierrePeriodo = @dFechaCierre 

   -->	[6.0] Determina el Inicio del Periodo en Observación
   DECLARE @dFechaAux	DATETIME
       --> [6.0.1] A la fecha Recibida, se le descuenta la cantidad de meses transcurridos -1.
       SET @dFechaAux		= DATEADD(MONTH, ((DATEPART(MONTH, @dfechaproceso )-1)*-1), @dfechaproceso) 
       --> [6.0.2] A la fecha Calculada, se le restan los días transcurridos -1.
       SET @dFechaAux		= DATEADD(DAY,   ((DATEPART(DAY,   @dFechaAux     )-1)*-1), @dFechaAux)

       --> [6.1] Retorna el Valor Calculado
       SET @xxFechaInicioPeriodo = @dFechaAux


	--> [7.0] Determina Fecha de Cierre de Mes
	DECLARE @dFechaAnalisis			DATETIME
		SET @dFechaAnalisis			= @xxFechaProceso

	-->	[7.1] Fecha de Cierre de Mes Actual
	DECLARE @dFechaCierreMesActual	DATETIME
		SET @dFechaCierreMesActual	= DATEADD( DAY, -1, DATEADD( DAY, DAY(DATEADD(MONTH, 1, @dFechaAnalisis )) *-1, DATEADD(MONTH, 1, @dFechaAnalisis )))
		SET @dFechaCierreMesActual	= DATEADD( DAY, DAY(DATEADD(MONTH, 1, @dFechaAnalisis )) *-1, DATEADD(MONTH, 1, @dFechaAnalisis ))

	-->	[7.2] Determina los Feriados, para generar la fecha exacta de los Datos
	DECLARE	@nAño		INT;		SET @nAño		= YEAR( @dFechaCierreMesActual )
	DECLARE @nMes		CHAR(2);	SET @nMes		= DATEPART(MONTH, @dFechaCierreMesActual ) ;	SET @nMes = CASE WHEN LEN(@nMes) = 1 THEN '0' ELSE '' END + @nMes
	DECLARE @nDia		CHAR(2);	SET @nDia		= DATEPART(DAY, @dFechaCierreMesActual )
	DECLARE	@nPlaza		INT;		SET @nPlaza		= 6
	
--	DECLARE @dFeriados	CHAR(50);	
		SET @dFeriados	= ''

	SELECT	@dFeriados	= CASE	WHEN @nMes = 01 THEN isnull( feene, ' ')
								WHEN @nMes = 02 THEN isnull( fefeb, ' ') 
								WHEN @nMes = 03 THEN isnull( femar, ' ')
								WHEN @nMes = 04 THEN isnull( feabr, ' ')
								WHEN @nMes = 05 THEN isnull( femay, ' ')
								WHEN @nMes = 06 THEN isnull( fejun, ' ')
								WHEN @nMes = 07 THEN isnull( fejul, ' ')
								WHEN @nMes = 08 THEN isnull( feago, ' ')
								WHEN @nMes = 09 THEN isnull( fesep, ' ')
								WHEN @nMes = 10 THEN isnull( feoct, ' ')
								WHEN @nMes = 11 THEN isnull( fenov, ' ')
								WHEN @nMes = 12 THEN isnull( fedic, ' ')
						END
	FROM   BacParamSuda.dbo.FERIADO 
	WHERE  FeAno		= @nAño
	AND    FePlaza		= @nPlaza

	WHILE 1 = 1
	BEGIN

		IF  ( CHARINDEX( @nDia, @dFeriados ) = 0 )
		and (	( DATEPART(weekday, @dFechaCierreMesActual ) <> 1 )
			or	( DATEPART(weekday, @dFechaCierreMesActual ) <> 7 )
			)
		BEGIN
			BREAK
		END
	
		SET @nDia = @nDia - 1

	END

	SET @dFechaCierreMesActual	=  LTRIM(RTRIM( @nAño ))
								+  LTRIM(RTRIM( @nMes )) 
								+  LTRIM(RTRIM( @nDia ))
	
	SET @xxFechaCierreMes		= @dFechaCierreMesActual

   --> Fin del Proceso <--

END
GO

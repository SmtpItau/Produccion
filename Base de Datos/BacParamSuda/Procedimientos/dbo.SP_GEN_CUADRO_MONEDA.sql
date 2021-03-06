USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_CUADRO_MONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_GEN_CUADRO_MONEDA '20141010',994

CREATE PROCEDURE [dbo].[SP_GEN_CUADRO_MONEDA]
   (   
		 @fecha_origen datetime
		,@codmon int 
   ) 
AS  
BEGIN

SET NOCOUNT ON
/* The following script, save only valid dates and  input the records in temporary table*/
CREATE TABLE #TempFechasCuadroMonedas
(
	fecha			datetime,
	codMon			int,
	nombreMon		char(8),
	valorMoneda		float,
	feriadoCL		char(1),
	feriadoUS		char(1),
	feriadoEN		char(1),
)

/*-------------------------------------------------------------*/
/* DECLARACION DE VARIABLES DEL SP								*/
/*-------------------------------------------------------------*/
DECLARE @iCount				int
DECLARE @FecTemporal		datetime
DECLARE @FechaOrigenTemp	datetime


DECLARE @PlazaCL			varchar(5)
DECLARE @PlazaUS			varchar(5) 
DECLARE @PlazaEN			varchar(5)

/*-------------------------------------------------------------*/
/* SETEO DE VARIABLES DEL SP								   */
/*-------------------------------------------------------------*/
SET @PlazaCL	= ';6;'
SET @PlazaUS	= ';225;'
SET @PlazaEN	= ';510;'
SET @iCount = 1

-- GUARDO FECHA ORIGINAL 
SET @FechaOrigenTemp  = @fecha_origen
/*-------------------------------------------------------------*/
/* REALIZA BUSQUEDA DE FECHAS PREVIAS A LA FIJACIÓN DEL FLUJO  */
/*-------------------------------------------------------------*/
  --**************************PRD21657
   declare @fecaux datetime
   declare @fCL datetime
   declare @fUS datetime
   declare @fEN datetime
   declare @fecCL as table(fec datetime)
   declare @fecUS as table(fec datetime)
   declare @fecEN as table(fec datetime)
  --**************************PRD21657

SET @FecTemporal = (SELECT dateadd(day,-1,@FechaOrigenTemp))
WHILE (@iCount < 4) 
BEGIN 
  	/*IF(DATEPART(WEEKDAY,@FecTemporal) = 7 OR DATEPART(WEEKDAY,@FecTemporal) = 1) 
      BEGIN
         SET @FecTemporal = (SELECT dateadd(day,-1,@FecTemporal))
      END
	ELSE
	BEGIN*/
		set @fUS=  @FecTemporal
		set @fCL=  @FecTemporal
		set @fEN=  @FecTemporal
		SET @fecaux=@FecTemporal
		insert into @fecUS
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
		insert into @fecCL
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL 
		insert into @fecEN
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN

		INSERT INTO  #TempFechasCuadroMonedas (fecha,codMon,nombreMon,valorMoneda,feriadoUS,feriadoCL,feriadoEN)
			(  
			SELECT mc.vmfecha as fecha,vmcodigo,mon.mnnemo,mc.vmvalor
					,iif(@fUS=@fecaux,'-','X') AS feriadoUS
					,iif(@fCL=@fecaux,'-','X') AS feriadoCL
					,iif(@fEN=@fecaux,'-','X') AS feriadoEN
				FROM MONEDA mon
				INNER JOIN VALOR_MONEDA mc ON mc.vmcodigo = mon.mncodmon
				/*INNER JOIN VALOR_MONEDA_CONTABLE mc ON mc.Codigo_Moneda = mon.mncodmon
				DE ACUERDO A SOLICITUD PRD21657
				*/

			WHERE vmcodigo  = @codmon
					AND vmfecha in (@FecTemporal)
		)
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		delete from @fecUS
		delete from @fecCL
		delete from @fecEN
		SET @iCount = @iCount + 1  
	--END
END

/*--------------------------------------------------------------------*/
/* INSERTO REGISTRO CON LA FECHA PRINCIPAL DE CONSULTA (FEC PROCESO)  */
/*--------------------------------------------------------------------*/

   set @fUS= @fecha_origen
   set @fCL= @fecha_origen
   set @fEN= @fecha_origen
   
  insert into @fecUS
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
  insert into @fecCL
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL 
  insert into @fecEN
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN



INSERT INTO  #TempFechasCuadroMonedas(fecha,codMon,nombreMon,valorMoneda,feriadoUS,feriadoCL,feriadoEN)
(  
	SELECT mc.vmfecha as fecha,vmcodigo,mon.mnnemo,mc.vmvalor
					,iif(@fUS=@fecha_origen,'-','X') AS feriadoUS
					,iif(@fCL=@fecha_origen,'-','X') AS feriadoCL
					,iif(@fEN=@fecha_origen,'-','X') AS feriadoEN
				FROM MONEDA mon
				INNER JOIN VALOR_MONEDA mc ON mc.vmcodigo = mon.mncodmon
				/*INNER JOIN VALOR_MONEDA_CONTABLE mc ON mc.Codigo_Moneda = mon.mncodmon*/

			WHERE vmcodigo  = @codmon
					AND vmfecha in (@fecha_origen)
)
delete from @fecUS
delete from @fecCL
delete from @fecEN
/*-----------------------------------------------------------------*/
/* REALIZA BUSQUEDA DE FECHAS POSTERIORES A LA FIJACIÓN DEL FLUJO  */
/*-----------------------------------------------------------------*/
set @iCount=1
SET @FecTemporal = (SELECT dateadd(day,1,@FechaOrigenTemp))
WHILE (@iCount < 4) 
BEGIN 
  	/*IF(DATEPART(WEEKDAY,@FecTemporal) = 7 OR DATEPART(WEEKDAY,@FecTemporal) = 1) 
      BEGIN
         SET @FecTemporal = (SELECT dateadd(day,1,@FecTemporal))
      END
	ELSE
	BEGIN*/
		set @fUS=  @FecTemporal
		set @fCL=  @FecTemporal
		set @fEN=  @FecTemporal
		SET @fecaux=@FecTemporal
		insert into @fecUS
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
		insert into @fecCL
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL
		insert into @fecEN
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN

		INSERT INTO  #TempFechasCuadroMonedas (fecha,codMon,nombreMon,valorMoneda,feriadoUS,feriadoCL,feriadoEN) 
			(  
			SELECT mc.vmfecha as fecha,vmcodigo,mon.mnnemo,mc.vmvalor
					,iif(@fUS=@fecaux,'-','X') AS feriadoUS
					,iif(@fCL=@fecaux,'-','X') AS feriadoCL
					,iif(@fEN=@fecaux,'-','X') AS feriadoEN
				FROM MONEDA mon
				INNER JOIN VALOR_MONEDA mc ON mc.vmcodigo = mon.mncodmon
				/*INNER JOIN VALOR_MONEDA_CONTABLE mc ON mc.Codigo_Moneda = mon.mncodmon
				DE ACUERDO A SOLICITUD PRD21657
				*/

			WHERE vmcodigo  = @codmon
					AND vmfecha in (@FecTemporal)
		)
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		delete from @fecUS
		delete from @fecCL
		delete from @fecEN
		SET @iCount = @iCount + 1  
	--END
END

/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/
/* RETORNO LOS REGISTROS DEL QUERY				               */
/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/
SELECT fecha, codMon,nombreMon,valorMoneda,feriadoCL,feriadoUS,feriadoEN	FROM #TempFechasCuadroMonedas 
ORDER BY fecha

/*-------------------------------------------------------------*/
/* ELIMINACION TABLA TEMPORAL    				               */
/*-------------------------------------------------------------*/
DROP TABLE #TempFechasCuadroMonedas
SET NOCOUNT OFF
END

GO

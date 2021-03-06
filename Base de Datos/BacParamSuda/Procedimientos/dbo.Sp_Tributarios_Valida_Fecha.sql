USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_Valida_Fecha]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Tributarios_Valida_Fecha]
	(	@dFechaAnalisis		DATETIME	
	,	@dExtrae			INT = 0
	)
AS
BEGIN

	DECLARE @dFechaProceso			DATETIME
		SET @dFechaProceso			= ( SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock) )

	DECLARE @dFechaAnterior			DATETIME
		SET @dFechaAnterior			= ( SELECT acfecante FROM BacFwdSuda.dbo.MFAC with(nolock) )

	if @dExtrae = 1
	begin
		select @dFechaAnterior
		return 0
	end

	IF @dFechaAnalisis >= @dFechaProceso
	BEGIN
		SELECT -1, 'La fecha de Análisis, debe ser menor a la fecha de Proceso. ' + convert(char(10), @dFechaProceso, 103)
		RETURN -1
	END

	IF ( DATEPART(weekday, @dFechaAnalisis ) = 1 )
	BEGIN
		SELECT -1, 'La fecha de analisis, no debe ser un día Domingo.'
		RETURN -1
	END

	IF ( DATEPART(weekday, @dFechaAnalisis ) = 7 )
	BEGIN
		SELECT -1, 'La fecha de analisis, no debe ser un día Sabado.'
		RETURN -1
	END

	DECLARE @iStatus	INT;		SET	@iStatus	= 0
	DECLARE	@nAño		INT;		SET @nAño		= YEAR( @dFechaAnalisis  )
	DECLARE @nMes		CHAR(2);	SET @nMes		= DATEPART(MONTH, @dFechaAnalisis  ) ;	SET @nMes = CASE WHEN LEN(@nMes) = 1 THEN '0' ELSE '' END + @nMes
	DECLARE @nDia		CHAR(2);	SET @nDia		= DATEPART(DAY, @dFechaAnalisis  )
	DECLARE	@nPlaza		INT;		SET @nPlaza		= 6

	DECLARE @dFeriados	CHAR(50);	
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

	IF  ( CHARINDEX( @nDia, @dFeriados ) <> 0 )
	BEGIN
		SELECT -1, 'Fecha de analisis, no es hábil'
		RETURN -1
	END

	SELECT 0, 'Fecha se encuentra dentro de los parametros aceptables.', @dFechaAnterior
	RETURN 0

END
GO

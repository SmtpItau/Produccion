USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FERIADO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_FERIADO]
			(
			@nPais		NUMERIC(05)	,
			@nPlaza		NUMERIC(05)	,
			@dFecha		DATETIME
			)
AS BEGIN 

SET NOCOUNT ON
SET DATEFORMAT dmy
	DECLARE @dFecha_aux	DATETIME
	SET DATEFIRST 1

	CREATE TABLE #mes
		(
		dia_nun		INT	,
		fecha		DATETIME,
		feriado		CHAR(01)
		)

	SELECT @dFecha_aux = @dFecha
	WHILE MONTH(@dFecha_aux) <= MONTH(@dFecha) AND YEAR(@dFecha_aux) <= YEAR(@dFecha)  BEGIN
		IF EXISTS(SELECT fecha 	FROM FERIADO	WHERE	plaza	= @nPlaza	AND
								Pais	= @nPais	AND
								fecha	= @dFecha_aux) BEGIN
				INSERT INTO #mes
				SELECT DATEPART(dw, @dFecha_aux),
					@dFecha_aux		,
					'S'
		END ELSE BEGIN
				INSERT INTO #mes
				SELECT DATEPART(dw, @dFecha_aux),
					@dFecha_aux		,
					'N'
		END

		SELECT 	@dFecha_aux = @dFecha_aux +1

	END

	UPDATE #mes SET feriado = 'S' WHERE ((dia_nun = 7) OR (dia_nun = 6))


	SELECT 	dia_nun	,
		'dia'   = DAY(fecha)	,
		feriado	
	FROM #mes ORDER BY fecha

SET NOCOUNT OFF
END





GO

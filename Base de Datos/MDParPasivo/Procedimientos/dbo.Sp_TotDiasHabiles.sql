USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TotDiasHabiles]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TotDiasHabiles]
			(
			@nRutcli NUMERIC(09,0)	,
			@nCodCli NUMERIC(05)	,
			@dFecini DATETIME	,
			@dFecven DATETIME       ,
                        @nPlaza  NUMERIC(05)    ,
                        @nPais   NUMERIC(05)    ,
                        @oResultado CHAR(2) OUTPUT
			)
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	DECLARE	@nTipcli	NUMERIC	(05)
	DECLARE	@iDias		INTEGER
	DECLARE @dFecha_aux	DATETIME

	SET DATEFIRST 1

	
	SELECT	@nTipcli	= cltipcli
	FROM	CLIENTE
	WHERE	clrut 		= @nRutcli	AND
		clcodigo	= @nCodCli


	CREATE TABLE #Periodo_Time
		(
		fecha		DATETIME
		)

	SELECT @dFecha_aux = @dFecini

	WHILE @dFecha_aux <= @dFecven BEGIN
		IF NOT EXISTS(SELECT fecha FROM FERIADO 
						WHERE	plaza	= @nPlaza AND
							Pais	= @nPais  AND
							fecha	= @dFecha_aux) BEGIN

			IF DATEPART(dw, @dFecha_aux) <> 6 AND DATEPART(dw, @dFecha_aux)<> 7 BEGIN
				INSERT INTO #Periodo_Time
				SELECT 	@dFecha_aux
			END
		END
		SELECT 	@dFecha_aux = @dFecha_aux +1
	END
	
	SELECT @iDias = COUNT(fecha)  FROM #Periodo_Time

	IF @iDias < 4 AND @nTipcli <> 1   -- VB+- Se cambio por c¢digos de FOX tipcli =1 es banco 
		SELECT	@oResultado = 'NO'
	ELSE
		SELECT	@oResultado = 'OK'

SET NOCOUNT OFF
END





GO

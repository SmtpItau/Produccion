USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_LIMITES_DE_PERMANENCIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_LIMITES_DE_PERMANENCIA]	( 
	@NUMOPER     NUMERIC(9),
	@CORRELA     NUMERIC(5),
	@CARTERA     NUMERIC(5),
	@TIPO        NUMERIC(1)
)
AS
BEGIN

SET NOCOUNT ON

	DECLARE  @MINIMO INT
	DECLARE  @MAXIMO INT

	SELECT	'Instrumento' = CONVERT(VARCHAR(10),inserie)
	  INTO	#TEMP_1
	  FROM	MDCP, VIEW_INSTRUMENTO
	 WHERE	cpcodigo	= incodigo 
	   AND	cpnumdocu	= @NUMOPER 
	   AND	cpcorrela	= @CORRELA

	IF @TIPO = 1
	BEGIN

		IF NOT EXISTS(	SELECT * FROM VIEW_TBLimper, #TEMP_1
						WHERE	CONVERT(NUMERIC(05),cartera)					= CONVERT(NUMERIC(05),@CARTERA) 
						  AND	CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento)	= CONVERT(VARCHAR(10),#TEMP_1.Instrumento))
		BEGIN
				SELECT 'NO','No Existe Limite de Permanencia para el Instrumento '
				RETURN

		END
		ELSE BEGIN

				SELECT @MINIMO       = CONVERT(NUMERIC(06),plazo_minimo)
				  FROM VIEW_TBLimper, #TEMP_1
				 WHERE CONVERT(NUMERIC(05),cartera)						= CONVERT(NUMERIC(05),@CARTERA) 
				   AND CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento)	= CONVERT(VARCHAR(10),#TEMP_1.Instrumento)

				SELECT 'SI',@MINIMO

		END

	END ELSE
	BEGIN


		IF NOT EXISTS(	SELECT * FROM VIEW_TBLimper, #TEMP_1
						 WHERE CONVERT(NUMERIC(05),cartera)						= CONVERT(NUMERIC(05),@CARTERA) 
						   AND CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento)	= CONVERT(VARCHAR(10),#TEMP_1.Instrumento))
		BEGIN
				SELECT 'NO','No Existe Limite de Permanencia para el Instrumento '
	        	RETURN
		END
		ELSE 
		BEGIN
				SELECT @MAXIMO  = CONVERT(NUMERIC(06),plazo_maximo)
				  FROM VIEW_TBLimper,#TEMP_1
				 WHERE cartera = @CARTERA 
				  AND  CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento) = CONVERT(VARCHAR(10),#TEMP_1.Instrumento)

				SELECT 'SI',@MAXIMO

		END
	END
	DROP TABLE #TEMP_1
	-----------------------------------------------------------------------


	SET NOCOUNT OFF

END
-- Base de Datos -- 
GO

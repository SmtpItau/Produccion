USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_LIMITE_DE_PERMANECIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_LIMITE_DE_PERMANECIA] ( 
	@NUMOPER     NUMERIC(9),
	@CORRELA     NUMERIC(5),
    @CARTERA     NUMERIC(5),
    @TIPO        NUMERIC(1)
)

AS

BEGIN

	SET NOCOUNT ON

	SELECT 'Instrumento' = CONVERT(VARCHAR(10),inserie)
	  INTO #TEMP_1
	  FROM MDCP, VIEW_INSTRUMENTO
	 WHERE cpcodigo		= incodigo  
	   AND cpnumdocu	= @NUMOPER  
	   AND cpcorrela	= @CORRELA

	IF @TIPO = 1
	BEGIN

			SELECT 'Minimo'       = CONVERT(NUMERIC(06),plazo_minimo)
			  FROM VIEW_TBLimper, #TEMP_1
			 WHERE CONVERT(NUMERIC(05),cartera)						= CONVERT(NUMERIC(05),@CARTERA)  
			   AND CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento)	= CONVERT(VARCHAR(10),#TEMP_1.Instrumento)
	END 
	ELSE
	BEGIN

			SELECT 'Maximo'  = CONVERT(NUMERIC(06),plazo_maximo)
			  FROM VIEW_TBLimper, #TEMP_1
			 WHERE cartera = @CARTERA  
			   AND CONVERT(VARCHAR(10),VIEW_TBLimper.Instrumento) = CONVERT(VARCHAR(10),#TEMP_1.Instrumento)
            
	END

	DROP TABLE #TEMP_1

	SET NOCOUNT OFF

END
GO

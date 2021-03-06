USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_NUMFOLIO_GARANTIAS_OTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_NUMFOLIO_GARANTIAS_OTORGADAS]
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @nNumFolio 	NUMERIC(10)

	IF (SELECT ACNumGarantiasOtorgadas FROM dbo.tbl_Parametros_Gral_Garantias) IS NULL
	BEGIN
		SELECT @nNumFolio = 1
		INSERT INTO BacParamSuda.dbo.tbl_Parametros_Gral_Garantias(SubjectEmail, AcNumGarantias,
						AcNumGarantiasOtorgadas, MensajeEmail, UltPeriodoInterfaces)
		VALUES('', 0, @nNumFolio, '', '')
	END
	ELSE
	BEGIN
		SELECT @nNumFolio = (SELECT ACNumGarantiasOtorgadas FROM bacparamsuda.dbo.tbl_parametros_gral_garantias)
		SET @nNumFolio = @nNumFolio + 1
		UPDATE BacParamSuda.dbo.tbl_Parametros_Gral_Garantias
		SET ACNumGarantiasOtorgadas = @nNumFolio
	END
	SELECT @nNumFolio AS NumFolio
	SET NOCOUNT OFF
END

GO

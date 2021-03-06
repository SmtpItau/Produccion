USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_NUMFOLIO_GARANTIAS_CONSTITUIDAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GAR_NUMFOLIO_GARANTIAS_CONSTITUIDAS]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @nNumFolio NUMERIC(10)

	IF (SELECT AcNumGarantias FROM BacParamSuda.dbo.tbl_Parametros_Gral_Garantias) IS NULL
	BEGIN
		SELECT @nNumFolio = 1
		INSERT INTO BacParamSuda.dbo.tbl_Parametros_Gral_Garantias(SubjectEmail, AcNumGarantias,
						AcNumGarantiasOtorgadas, MensajeEmail, UltPeriodoInterfaces)
		VALUES('',@nNumFolio, 0, '', '')
	END
	ELSE
	BEGIN
		SELECT @nNumFolio = (SELECT AcNumGarantias FROM BacParamSuda.dbo.tbl_Parametros_Gral_Garantias)
		SET @nNumFolio = @nNumFolio + 1
		UPDATE BacParamSuda.dbo.tbl_Parametros_Gral_Garantias
		SET AcNumGarantias = @nNumFolio
	END
	SELECT @nNumFolio AS NumFolio
	SET NOCOUNT OFF
END
GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_FOLIOASOCIACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_FOLIOASOCIACION]
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @nNumFolio 	NUMERIC(18)


	SELECT @nNumFolio = (SELECT FolioAsocia FROM bacparamsuda.dbo.tbl_parametros_gral_garantias)
	IF @nNumFolio IS NULL
		SELECT @nNumFolio = 0
	SET @nNumFolio = @nNumFolio + 1

	UPDATE BacParamSuda.dbo.tbl_Parametros_Gral_Garantias
	SET FolioAsocia = @nNumFolio

	SELECT @nNumFolio AS NumFolio
	SET NOCOUNT OFF
END
GO

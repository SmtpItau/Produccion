USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ENVIOS_EMAILGTIAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_ENVIOS_EMAILGTIAS]
	(	@borraAntiguos	CHAR(1)='N'
	)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE Bacparamsuda..tbl_Garantias_Faltantes
	SET Avisado = 'S'
	WHERE Avisado <> 'S'
	IF @borraAntiguos = 'S'
		DELETE FROM Bacparamsuda..tbl_Garantias_Faltantes
		WHERE Avisado = 'S'
END
GO

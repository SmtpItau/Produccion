USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANT_GARANTIAS_FALTANTES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CANT_GARANTIAS_FALTANTES]
AS
BEGIN
	SET NOCOUNT ON
	SELECT 	COUNT(*)
	FROM 	Bacparamsuda..tbl_Garantias_Faltantes
	WHERE Avisado <> 'S'
END
GO

USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacriePais_AyudaCodPais]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacriePais_AyudaCodPais]
AS
BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	SELECT  codigo_pais,
		nombre 

	FROM PAIS ORDER BY codigo_pais,nombre
	
	SET NOCOUNT OFF
END













GO

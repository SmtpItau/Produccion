USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Area]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Busca_Area]
AS 
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


SELECT codigo_area
      ,descripcion
FROM   AREA_PRODUCTO
END




GO

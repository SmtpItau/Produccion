USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtieneSubGrupos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <21-08-2013>      
-- Description: <OBTIENE LOS SUBGRUPOS PERTENECIENTES A UN GRUPO DE REPORTES>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtieneSubGrupos]
       
 @id_grupo as int  
      
AS      
	SELECT	ID_SUBGRUPO,
			NOMBRE
	FROM	REPORTES_SUBGRUPO 
	WHERE	ID_GRUPO = @ID_GRUPO
	ORDER BY NOMBRE
GO

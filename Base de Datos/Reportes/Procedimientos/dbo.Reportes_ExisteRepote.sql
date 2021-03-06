USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ExisteRepote]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <JAVIER SANHUEZA>      
-- Create date: <29-05-2013>      
-- Description: <BUSCA SI EXISTE UN REGISTRO POR NOMBRE_ARCHIVO, ID_GRUPO>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ExisteRepote]
       
(@archivo		nvarchar(50),
@id_grupo		int)
      
AS      
	SELECT	*
	FROM	REPORTES
	WHERE	NOMBRE_ARCHIVO	= @archivo AND
			ID_GRUPO		= @id_grupo
GO

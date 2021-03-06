USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_BuscaReportes]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <JAVIER SANHUEZA>      
-- Create date: <22-08-2013>      
-- Description: <BUSCA REPORTES POR ID_GRUPO, DESCRIPCION, NOMBRE, NOMBRE_ARCHIVO>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_BuscaReportes]
       
(@descripcion	nvarchar(50),
@id_grupo		int)

      
AS  
	SELECT	
			NOMBRE,
			ID_REPORTE AS ID,
			NOMBRE_ARCHIVO,
			 CASE VISIBLE
				WHEN 0 THEN 'No'
				WHEN 1 THEN 'Si'
			 END as VISIBLE,
			 CASE PERMITEMAIL
				WHEN 0 THEN 'No'
				WHEN 1 THEN 'Si'
			 END as PERMITEMAIL
	FROM	REPORTES
	WHERE
			id_grupo = @id_grupo 
			and(nombre like '%'+ @descripcion +'%' )
	--		or nombre_archivo like '%'+ @descripcion +'%')
GO

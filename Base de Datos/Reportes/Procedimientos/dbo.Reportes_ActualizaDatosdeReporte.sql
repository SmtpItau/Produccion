USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ActualizaDatosdeReporte]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <JAVIER SANHUEZA>      
-- Create date: <27-05-2013>      
-- Description: <ACUALIZA DATOS DE UN REPORTE>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ActualizaDatosdeReporte]
       
(@id_reporte	int,
@descripcion	nvarchar(50),
@nombre			nvarchar(50),
--@ruta			nvarchar(255),
@archivo		nvarchar(50),
@id_grupo		int,
@id_subgrupo	int,
@id_conexion	int,
@visible		int,
@mail			int,
@asunto			nvarchar(200),
@body			nvarchar(500))
      
AS      
	UPDATE	REPORTES
	SET		DESCRIPCION		= @descripcion,
			NOMBRE			= @nombre,
--			RUTA			= @ruta,
			NOMBRE_ARCHIVO	= @archivo,
			ID_GRUPO		= @id_grupo,
			ID_SUBGRUPO		= @ID_SUBGRUPO,
			ID_CONEXION		= @id_conexion,
--			METODO			= @metodo,
			VISIBLE			= @visible,
			PERMITEMAIL		= @mail,
			MAIL_ASUNTO		= @asunto,
			MAIL_BODY		= @body
	WHERE	ID_REPORTE = @id_reporte
GO

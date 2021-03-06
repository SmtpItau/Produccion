USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReportePorID]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <JAVIER SANHUEZA>      
-- Create date: <27-05-2013>      
-- Description: <OBTIENE DATOS DE UN REPORTE BUSCANDO POR ID>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerReportePorID]
       
 @id_reporte as int  
      
AS      
	SELECT   REP.DESCRIPCION,
			 REP.NOMBRE,
			 REP.NOMBRE_ARCHIVO,
			 REP.ID_GRUPO,
			 REP.ID_SUBGRUPO,
			 REP.ID_CONEXION,
			 REP.METODO,
			 REP.VISIBLE,
			 REP.PERMITEMAIL,
			 REP.MAIL_ASUNTO,
			 REP.MAIL_BODY
	FROM	 REPORTES REP
	WHERE	 ID_REPORTE = @id_reporte
GO

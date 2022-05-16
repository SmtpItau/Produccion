USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReportesporSubGrupos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <21-08-2013>      
-- Description: <OBTIENE LOS REPORTES PERTENECIENTES A UN SUBGRUPO DE REPORTES>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerReportesporSubGrupos]
       
 @id_subgrupo as int  
      
AS      
	SELECT	ID_REPORTE,
			NOMBRE
	FROM	REPORTES 
	WHERE	ID_SUBGRUPO = @id_subgrupo
GO

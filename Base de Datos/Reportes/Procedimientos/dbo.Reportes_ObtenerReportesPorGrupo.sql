USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReportesPorGrupo]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <24-05-2013>      
-- Description: <OBTIENE LOS REPORTES PERTENECIENTES A UN GRUPO>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerReportesPorGrupo]
       
 @id_grupo as int  
      
AS      
BEGIN      
 SET NOCOUNT ON;      
    
	SELECT   NOMBRE,
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
	FROM	 REPORTES
	WHERE	 ID_GRUPO = @id_grupo
	--AND		 VISIBLE <> 0
	ORDER BY NOMBRE

END
GO

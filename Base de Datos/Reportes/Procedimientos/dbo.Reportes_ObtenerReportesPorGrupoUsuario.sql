USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReportesPorGrupoUsuario]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  <EDUARDO CASTILLO>            
-- Create date: <27-05-2013>            
-- Description: <OBTIENE LOS REPORTES PERTENECIENTES A UN GRUPO Y A UN USUARIO>            
-- =============================================            
CREATE PROCEDURE [dbo].[Reportes_ObtenerReportesPorGrupoUsuario]      
             
 @id_grupo as int,    
 @id_usuario as int    
            
AS            
BEGIN            
 SET NOCOUNT ON;            
          
 SELECT  R.NOMBRE,      
   R.ID_REPORTE AS ID    
       
 FROM  REPORTES  R INNER JOIN PERFILERIA_USUARIO_REPORTE UR     
 ON   UR.ID_REPORTE = R.ID_REPORTE    
 WHERE  R.ID_GRUPO = @id_grupo      
 AND  UR.ID_USUARIO = @id_usuario    
 AND  R.VISIBLE <> 0      
     
 ORDER BY R.NOMBRE      
       
END
GO

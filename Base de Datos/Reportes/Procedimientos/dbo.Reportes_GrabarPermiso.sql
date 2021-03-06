USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_GrabarPermiso]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <23-05-2013>      
-- Description: <GRABA O ACTULIZA LOS PERMISOS A LOS REPORTES PARA EL USUARIO>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_GrabarPermiso]
       
 @id_usuario as int,    
 @id_reporte as int,    
 @acceso  as int    
      
AS      
BEGIN      
 SET NOCOUNT ON;      
 DECLARE @id_usuario_reporte AS INT    
 SELECT  @id_usuario_reporte = 0    
    
 SELECT  @id_usuario_reporte =     
   (     
    SELECT  COUNT(ID_USUARIO_REPORTE)    
    FROM PERFILERIA_USUARIO_REPORTE     
    WHERE ID_USUARIO = @id_usuario     
    AND  ID_REPORTE = @id_reporte    
   )    
       
          
 IF @id_usuario_reporte = 0 AND @acceso = 1    
  INSERT INTO PERFILERIA_USUARIO_REPORTE (ID_USUARIO, ID_REPORTE) VALUES (@id_usuario, @id_reporte)    
 ELSE    
  IF @id_usuario_reporte = 1 AND @acceso = 0    
  BEGIN    
   DELETE FROM PERFILERIA_USUARIO_REPORTE WHERE ID_USUARIO = @id_usuario AND ID_REPORTE = @id_reporte    
  END    
END
GO

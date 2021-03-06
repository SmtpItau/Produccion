USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerAccesoReportesPorUsuario]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  <EDUARDO CASTILLO>        
-- Create date: <24-05-2013>        
-- Description: <LOS REPORTES A LOS QUE EL USUARIO TIENE ACCESO>  
-- =============================================        
CREATE PROCEDURE [dbo].[Reportes_ObtenerAccesoReportesPorUsuario]   
  
@id_usuario as int,  
@id_grupo as int  
  
AS        
BEGIN        
 SET NOCOUNT ON;        
  
  
SELECT R.ID_REPORTE AS ID ,   
  R.NOMBRE AS REPORTE,  
  RG.NOMBRE AS [GRUPO DE REPORTES],  
  (SELECT 1 FROM PERFILERIA_USUARIO_REPORTE WHERE ID_REPORTE = R.ID_REPORTE AND ID_USUARIO =@ID_USUARIO ) AS ACCESO  
    
FROM REPORTES R INNER JOIN REPORTES_GRUPO RG ON R.ID_GRUPO = RG.ID_GRUPO  
WHERE R.ID_GRUPO = @id_grupo  
AND R.VISIBLE = 1
  
  
END
GO

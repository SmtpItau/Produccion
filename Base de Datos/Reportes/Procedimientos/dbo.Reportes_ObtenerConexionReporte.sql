USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerConexionReporte]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <24-05-2013>      
-- Description: <OBTIENE UNA CONEXION A LA BASE DE DATOS UTILIZADA POR EL REPORTE>
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerConexionReporte]
       @id_conexion as int
AS      
BEGIN      
 SET NOCOUNT ON;      
    
	SELECT   NOMBRE	  AS NOMBRE,
			 SERVIDOR,
			 BASEDATOS,
			 USUARIO,
			 PASSWORD
			
	FROM	 REPORTES_CONEXION
	WHERE	 ID_CONEXION = @id_conexion
	ORDER BY NOMBRE

END
GO

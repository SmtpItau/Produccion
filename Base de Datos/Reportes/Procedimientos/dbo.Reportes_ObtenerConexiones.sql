USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerConexiones]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  <EDUARDO CASTILLO>        
-- Create date: <24-05-2013>        
-- Description: <RETORNA EL LISTADO DE CONEXIONES>  
-- =============================================        
CREATE PROCEDURE [dbo].[Reportes_ObtenerConexiones]   
  
  
AS        
BEGIN        
 SET NOCOUNT ON;        
       
 SELECT   ID_CONEXION AS ID,
		  NOMBRE			  
 FROM	  REPORTES_CONEXION  
 ORDER BY NOMBRE  
END
GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerGrupos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  <EDUARDO CASTILLO>    
-- Create date: <22-05-2013>    
-- Description: <OBTIENE LOS GRUPOS DE REPORTE>    
-- =============================================    
CREATE PROCEDURE [dbo].[Reportes_ObtenerGrupos]  
         
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
        
 select id_grupo AS ID, Nombre as NOMBRE, visible AS visible from reportes_grupo
 order by Orden    
END
GO

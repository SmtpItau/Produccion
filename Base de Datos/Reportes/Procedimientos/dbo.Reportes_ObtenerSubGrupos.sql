USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerSubGrupos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <JAVIER SANHUEZA>  
-- Create date: <23-08-2013>  
-- Description: <OBTIENE LOS SUBGRUPOS DE REPORTE>  
-- =============================================  
CREATE PROCEDURE [dbo].[Reportes_ObtenerSubGrupos]
   
@id_grupo as int
    
AS  
BEGIN  
 SET NOCOUNT ON;  
      
 select Id_SubGrupo AS ID,
		Nombre as NOMBRE 
 from Reportes_SubGrupo
 where Id_Grupo = @id_grupo
 order by nombre  
END
GO

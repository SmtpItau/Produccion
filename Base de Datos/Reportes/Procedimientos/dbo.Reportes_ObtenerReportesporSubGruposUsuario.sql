USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerReportesporSubGruposUsuario]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================        
-- Author:  <EDUARDO CASTILLO>        
-- Create date: <21-08-2013>        
-- Description: <OBTIENE LOS REPORTES PERTENECIENTES A UN SUBGRUPO DE REPORTES POR USUARIO>        
-- =============================================        
CREATE PROCEDURE [dbo].[Reportes_ObtenerReportesporSubGruposUsuario]  
         
 @id_subgrupo as int,
 @id_usuario as int
        
AS        
 SELECT R.ID_REPORTE,   R.NOMBRE  
 FROM	REPORTES R INNER JOIN perfileria_usuario_reporte PUR
 ON		PUR.ID_REPORTE	= R.ID_REPORTE
 AND	PUR.ID_USUARIO	= @ID_USUARIO
 AND	R.ID_SUBGRUPO	= @id_subgrupo
 ORDER BY R.NOMBRE

GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerParametrosporReporte]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Javier Sanhueza>      
-- Create date: <27-08-2013>      
-- Description: <OBTIENE LOS PARAMETROS ASOCIADOS A UN REPORTE>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerParametrosporReporte]
       
 @id_reporte as int  
      
AS      
BEGIN      
 SET NOCOUNT ON;      
    
	SELECT
		RELACION.id_reporte AS id_reporte,
		RELACION.id_parametro AS id_parametro,
		PARAMETROS.parametro AS parametro,
		PARAMETROS.tipo_dato AS tipo_dato,
		PARAMETROS.alias AS alias,
		PARAMETROS.query AS query,
		PARAMETROS.tipo_parametro AS tipo_parametro
	FROM reportes_relacion RELACION
	INNER JOIN reportes_parametros PARAMETROS
	ON RELACION.Id_Parametro = PARAMETROS.ID_PARAMETRO
	WHERE RELACION.id_reporte = @id_reporte
	ORDER BY PARAMETROS.parametro

END
GO

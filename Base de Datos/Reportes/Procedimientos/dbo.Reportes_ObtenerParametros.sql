USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerParametros]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Javier Sanhueza>      
-- Create date: <27-08-2013>      
-- Description: <OBTIENE TODOS LOS REGISTROS DE PARAMETROS>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ObtenerParametros]
       

AS      
BEGIN      
 SET NOCOUNT ON;      
    
	SELECT   ID_PARAMETRO AS ID,
			 PARAMETRO,
			 TIPO_DATO,
			 ALIAS,
			 QUERY,
			 TIPO_PARAMETRO
	FROM	 Reportes_Parametros
	ORDER BY PARAMETRO

END
GO

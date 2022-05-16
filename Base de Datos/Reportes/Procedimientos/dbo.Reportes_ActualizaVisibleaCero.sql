USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ActualizaVisibleaCero]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <JAVIER SANHUEZA>      
-- Create date: <23-08-2013>      
-- Description: <ACUALIZA REPORTE DEJANDO CAMPO VISIBLE EN 0 = NO>      
-- =============================================      
CREATE PROCEDURE [dbo].[Reportes_ActualizaVisibleaCero]
       
@id_reporte	int
      
AS      
	UPDATE	REPORTES
	SET		VISIBLE		= 0
	WHERE	ID_REPORTE	= @id_reporte
GO

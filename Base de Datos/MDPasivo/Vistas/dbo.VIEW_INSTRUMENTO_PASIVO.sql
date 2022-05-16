USE [MDPasivo]
GO
/****** Object:  View [dbo].[VIEW_INSTRUMENTO_PASIVO]    Script Date: 16-05-2022 11:43:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_INSTRUMENTO_PASIVO]
AS
	SELECT	codigo_instrumento 
	,	nombre_instrumento             
	,	codigo_producto 
	,	glosa    
	,	codigo_contable
	FROM	MDPASIVO..INSTRUMENTO_PASIVO

GO

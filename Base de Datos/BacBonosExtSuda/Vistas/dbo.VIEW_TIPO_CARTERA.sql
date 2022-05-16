USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_TIPO_CARTERA]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_TIPO_CARTERA]
AS
	SELECT	rcsistema 
	,	rccodpro
	,	rcrut  
	,	rcdv  
	,	rcnombre 
	,	rcnumcorr
	FROM	BACPARAMSUDA..TIPO_CARTERA
	WHERE	rcsistema	= 'BEX'

GO

USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[VIEW_TIPO_CARTERA]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_TIPO_CARTERA]
AS
   SELECT 
         rcsistema	,
         rccodpro	,
         rcrut		,
         rcdv		,
         rcnombre	,
         rcnumcorr
   FROM  BACPARAMSUDA..TIPO_CARTERA
   WHERE rcsistema	= 'PCS'

GO

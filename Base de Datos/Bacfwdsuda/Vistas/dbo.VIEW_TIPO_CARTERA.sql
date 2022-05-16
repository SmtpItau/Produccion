USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TIPO_CARTERA]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_TIPO_CARTERA]
AS
   SELECT 
         rcsistema ,
         'RCCODPRO' = CONVERT( NUMERIC(5),rccodpro) ,
         rcrut  ,
         rcdv  ,
         rcnombre ,
         rcnumcorr
   FROM  BACPARAMSUDA..TIPO_CARTERA
   WHERE rcsistema='BFW'


GO

USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TIPO_CARTERA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TIPO_CARTERA]
AS
   SELECT *
   FROM  BACPARAMSUDA..TIPO_CARTERA
   WHERE rcsistema='BTR'
   
GO

USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_LIMITES_TASAS]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_LIMITES_TASAS]
AS
 SELECT * FROM BACPARAMSUDA..LIMITES_TASAS

GO

USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_REGION]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_REGION]
AS SELECT codigo_region
      ,   codigo_pais
      ,   nombre
      FROM BACPARAMSUDA..REGION

GO

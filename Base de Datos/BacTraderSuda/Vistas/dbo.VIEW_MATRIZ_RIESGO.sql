USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MATRIZ_RIESGO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MATRIZ_RIESGO]
AS 
select * from bacparamsuda..MATRIZ_RIESGO

GO

USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[view_Linea_por_plazo]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_Linea_por_plazo]
AS 
select * from bacparamsuda..Linea_por_plazo

GO

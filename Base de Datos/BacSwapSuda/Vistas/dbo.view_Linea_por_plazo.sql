USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_Linea_por_plazo]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_Linea_por_plazo]
AS 
select * from bacparamsuda..Linea_por_plazo

GO

USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_Tasas]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_Tasas]
AS
SELECT * FROM bacparamsuda..tabla_general_detalle where tbcateg = 1042

GO

USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CARTERA]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VIEW_CARTERA]
AS
SELECT *
FROM bacswapsuda..CARTERA with (nolock)
GO

USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_Cliente]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_Cliente]
AS
	SELECT	* 
	FROM	bacparamsuda..Cliente

GO

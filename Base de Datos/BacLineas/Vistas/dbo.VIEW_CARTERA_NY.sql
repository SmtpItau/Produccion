USE [BacLineas]
GO
/****** Object:  View [dbo].[VIEW_CARTERA_NY]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VIEW_CARTERA_NY]
AS 
	SELECT * FROM bacswapNY..CARTERA Where Estado <> 'C' -- C= Cotización

GO

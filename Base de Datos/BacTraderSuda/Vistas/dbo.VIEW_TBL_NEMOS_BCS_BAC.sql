USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TBL_NEMOS_BCS_BAC]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TBL_NEMOS_BCS_BAC] 
AS
	SELECT * 
	FROM BACPARAMSUDA..TBL_NEMOS_BCS_BAC 

GO

USE [BacCamSuda]
GO
/****** Object:  View [dbo].[TMP_CLIENTE]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TMP_CLIENTE]
AS 
	SELECT * FROM bacparamsuda..cliente
GO

USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VIEW_MDMH]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MDMH]
AS

	SELECT * FROM Bactradersuda.dbo.MDMH with (nolock)

	
GO

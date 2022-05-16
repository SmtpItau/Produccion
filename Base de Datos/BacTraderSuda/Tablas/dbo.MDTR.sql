USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDTR]    Script Date: 13-05-2022 12:16:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDTR](
	[trfecha] [datetime] NULL,
	[trserie] [char](12) NULL,
	[trvaldes] [numeric](5, 2) NULL,
	[trvalhas] [numeric](5, 2) NULL,
	[trtasas] [numeric](7, 4) NULL,
	[tremisor] [numeric](10, 0) NULL
) ON [PRIMARY]
GO

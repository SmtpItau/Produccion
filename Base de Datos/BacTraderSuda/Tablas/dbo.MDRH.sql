USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDRH]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDRH](
	[rhfecha] [datetime] NULL,
	[rhvaldes] [numeric](5, 2) NULL,
	[rhvalhas] [numeric](5, 2) NULL,
	[rhfinic] [datetime] NULL,
	[rhfvenc] [datetime] NULL
) ON [PRIMARY]
GO

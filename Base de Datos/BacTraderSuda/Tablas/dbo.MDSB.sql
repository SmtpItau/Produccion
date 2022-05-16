USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDSB]    Script Date: 13-05-2022 12:16:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDSB](
	[rmserie] [char](12) NULL,
	[rmfactor] [float] NULL,
	[rmtasa1] [numeric](9, 4) NULL,
	[rmtasa2] [numeric](9, 4) NULL,
	[rmtasa3] [numeric](9, 4) NULL,
	[rmtmtir] [numeric](9, 4) NULL
) ON [PRIMARY]
GO

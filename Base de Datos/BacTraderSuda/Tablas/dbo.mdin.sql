USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdin]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdin](
	[incodigo] [numeric](3, 0) NOT NULL,
	[inserie] [char](12) NOT NULL,
	[inglosa] [char](40) NOT NULL,
	[inrutemi] [numeric](9, 0) NOT NULL,
	[inmonemi] [numeric](3, 0) NOT NULL,
	[inbasemi] [numeric](3, 0) NOT NULL,
	[inprog] [char](8) NOT NULL,
	[inrefnomi] [char](1) NOT NULL,
	[inmdse] [char](1) NOT NULL,
	[inmdtd] [char](1) NOT NULL,
	[inmdpr] [char](1) NOT NULL,
	[intipfec] [numeric](1, 0) NOT NULL,
	[intasest] [numeric](3, 0) NOT NULL,
	[intipo] [char](3) NOT NULL,
	[inemision] [char](3) NOT NULL,
	[ineleg] [char](1) NULL,
	[inlargoms] [int] NULL,
	[inedw] [numeric](3, 0) NULL,
	[incontab] [char](1) NULL,
	[intiporig] [char](3) NOT NULL,
	[intotalemitido] [float] NULL,
	[insecuritytype] [char](2) NULL,
	[insecuritytype2] [char](4) NULL
) ON [PRIMARY]
GO

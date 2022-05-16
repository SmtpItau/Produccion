USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MBTABLAS]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MBTABLAS](
	[tbcateg] [numeric](4, 0) NOT NULL,
	[tbcodigo1] [char](6) NOT NULL,
	[tbtasa] [numeric](3, 0) NOT NULL,
	[tbfecha] [datetime] NOT NULL,
	[tbvalor] [numeric](8, 6) NOT NULL,
	[tbglosa] [char](50) NOT NULL,
	[nemo] [char](10) NOT NULL
) ON [PRIMARY]
GO

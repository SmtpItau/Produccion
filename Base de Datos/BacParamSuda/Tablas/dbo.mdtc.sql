USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[mdtc]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdtc](
	[TBCATEG] [numeric](4, 0) NOT NULL,
	[TBCODIGO1] [char](6) NOT NULL,
	[TBTASA] [numeric](3, 0) NOT NULL,
	[TBFECHA] [datetime] NOT NULL,
	[TBVALOR] [numeric](18, 6) NOT NULL,
	[TBGLOSA] [char](50) NOT NULL,
	[NEMO] [char](10) NOT NULL
) ON [PRIMARY]
GO

USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TABLA_GENERAL_GLOBALPCTRADER]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_GENERAL_GLOBALPCTRADER](
	[ctcateg] [numeric](5, 0) NOT NULL,
	[ctdescrip] [char](25) NOT NULL,
	[ctindcod] [char](1) NOT NULL,
	[ctindtasa] [char](1) NOT NULL,
	[ctindfech] [char](1) NOT NULL,
	[ctindvalor] [char](1) NOT NULL,
	[ctindglosa] [char](1) NOT NULL,
	[tbSistema] [char](3) NULL,
	[tbcodtab] [numeric](5, 0) NULL,
	[tbglosa] [char](25) NULL,
	[tbtipmnt] [char](1) NULL
) ON [PRIMARY]
GO

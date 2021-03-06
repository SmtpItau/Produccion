USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDNS0525]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDNS0525](
	[nsrutcart] [numeric](9, 0) NOT NULL,
	[nsnumdocu] [numeric](10, 0) NOT NULL,
	[nscorrela] [numeric](3, 0) NOT NULL,
	[nsrutemi] [numeric](9, 0) NOT NULL,
	[nsmonemi] [numeric](3, 0) NOT NULL,
	[nstasemi] [numeric](9, 4) NOT NULL,
	[nsbasemi] [numeric](3, 0) NOT NULL,
	[nsfecemi] [datetime] NOT NULL,
	[nsfecven] [datetime] NOT NULL,
	[nsserie] [char](12) NOT NULL,
	[nscodigo] [numeric](3, 0) NOT NULL,
	[corresponsal] [char](4) NOT NULL
) ON [PRIMARY]
GO

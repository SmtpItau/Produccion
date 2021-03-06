USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CORTES_PAGOS_FLI]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CORTES_PAGOS_FLI](
	[corutcart] [numeric](9, 0) NOT NULL,
	[conumdocu] [numeric](10, 0) NOT NULL,
	[cocorrela] [numeric](3, 0) NOT NULL,
	[conumoper] [numeric](10, 0) NOT NULL,
	[corrpago] [numeric](3, 0) NOT NULL,
	[cocantcort] [numeric](19, 4) NOT NULL,
	[comtocort] [numeric](19, 4) NOT NULL,
	[costatreg] [char](1) NOT NULL,
	[cotipoper] [char](3) NOT NULL,
	[cotipocartera] [numeric](2, 0) NULL,
	[coreproceso] [char](1) NULL,
	[cotippago] [char](1) NOT NULL
) ON [PRIMARY]
GO

USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ResFusion_MONEDA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResFusion_MONEDA](
	[mncodmon] [numeric](5, 0) NOT NULL,
	[mnnemo] [char](8) NULL,
	[mnsimbol] [char](5) NULL,
	[mnglosa] [char](35) NULL,
	[mncodsuper] [numeric](3, 0) NULL,
	[mnnemsuper] [char](8) NULL,
	[mncodbanco] [numeric](5, 0) NULL,
	[mnnembanco] [char](3) NULL,
	[mnbase] [numeric](3, 0) NULL,
	[mnredondeo] [numeric](2, 0) NULL,
	[mndecimal] [numeric](2, 0) NULL,
	[mncodpais] [numeric](3, 0) NULL,
	[mnrrda] [char](1) NULL,
	[mnfactor] [numeric](9, 0) NULL,
	[mnrefusd] [char](1) NULL,
	[mnlocal] [char](1) NULL,
	[mnextranj] [char](1) NULL,
	[mnvalor] [char](1) NULL,
	[mnrefmerc] [char](1) NULL,
	[mningval] [numeric](3, 0) NULL,
	[mntipmon] [char](1) NULL,
	[mnperiodo] [numeric](2, 0) NULL,
	[mnmx] [char](1) NULL,
	[mncodfox] [char](6) NULL,
	[mnvalfox] [numeric](5, 0) NULL,
	[mncodcor] [numeric](7, 0) NULL,
	[codigo_pais] [numeric](5, 0) NULL,
	[mniso_coddes] [char](5) NULL,
	[mnlimite] [numeric](19, 4) NULL,
	[mncodcorrespC] [numeric](10, 0) NULL,
	[mncodcorrespV] [numeric](10, 0) NULL,
	[mncanasta] [char](2) NULL,
	[MNCTACAMB] [char](10) NOT NULL,
	[mncodBancoC] [numeric](10, 0) NOT NULL,
	[mncodBancoV] [numeric](10, 0) NOT NULL,
	[mncoddcv] [int] NULL,
	[mnClasificaRiesgoPais] [char](10) NOT NULL,
	[mnsinacofi] [char](5) NOT NULL,
	[mncodbkb] [char](4) NOT NULL
) ON [PRIMARY]
GO

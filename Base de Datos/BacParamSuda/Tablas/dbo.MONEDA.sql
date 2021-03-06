USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MONEDA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA](
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
	[mncodbkb] [char](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[mncodmon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnnemo__64F971E5]  DEFAULT ('') FOR [mnnemo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnsimbol__65ED961E]  DEFAULT ('') FOR [mnsimbol]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnglosa__66E1BA57]  DEFAULT ('') FOR [mnglosa]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mncodsup__67D5DE90]  DEFAULT (0) FOR [mncodsuper]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnnemsup__68CA02C9]  DEFAULT ('') FOR [mnnemsuper]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mncodban__69BE2702]  DEFAULT (0) FOR [mncodbanco]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnnemban__6AB24B3B]  DEFAULT ('') FOR [mnnembanco]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnbase__6BA66F74]  DEFAULT (0) FOR [mnbase]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnredond__6C9A93AD]  DEFAULT (0) FOR [mnredondeo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mndecima__6D8EB7E6]  DEFAULT (0) FOR [mndecimal]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mncodpai__6E82DC1F]  DEFAULT (0) FOR [mncodpais]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnrrda__6F770058]  DEFAULT ('') FOR [mnrrda]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnfactor__706B2491]  DEFAULT (0) FOR [mnfactor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnrefusd__715F48CA]  DEFAULT ('') FOR [mnrefusd]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnlocal__72536D03]  DEFAULT ('') FOR [mnlocal]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnextran__7347913C]  DEFAULT ('') FOR [mnextranj]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnvalor__743BB575]  DEFAULT ('') FOR [mnvalor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnrefmer__752FD9AE]  DEFAULT ('') FOR [mnrefmerc]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mningval__7623FDE7]  DEFAULT (0) FOR [mningval]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mntipmon__77182220]  DEFAULT ('') FOR [mntipmon]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnperiod__780C4659]  DEFAULT (0) FOR [mnperiodo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnmx__79006A92]  DEFAULT ('') FOR [mnmx]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mncodfox__79F48ECB]  DEFAULT ('') FOR [mncodfox]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mnvalfox__7AE8B304]  DEFAULT (0) FOR [mnvalfox]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mncodcor__7BDCD73D]  DEFAULT (0) FOR [mncodcor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Codigo_P__7CD0FB76]  DEFAULT (0) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__Mniso_Co__7DC51FAF]  DEFAULT ('') FOR [mniso_coddes]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncanasta]  DEFAULT ('') FOR [mncanasta]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF__MONEDA__MNCTACAM__3BB9C735]  DEFAULT (0) FOR [MNCTACAMB]
GO
ALTER TABLE [dbo].[MONEDA] ADD  DEFAULT (0) FOR [mncodBancoC]
GO
ALTER TABLE [dbo].[MONEDA] ADD  DEFAULT (0) FOR [mncodBancoV]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [df_Moneda_MnCodDcv]  DEFAULT (0) FOR [mncoddcv]
GO
ALTER TABLE [dbo].[MONEDA] ADD  DEFAULT ('') FOR [mnClasificaRiesgoPais]
GO
ALTER TABLE [dbo].[MONEDA] ADD  DEFAULT ('001') FOR [mnsinacofi]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [df_moneda_mncodbkb]  DEFAULT ('') FOR [mncodbkb]
GO

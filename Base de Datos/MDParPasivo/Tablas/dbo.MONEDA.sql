USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MONEDA]    Script Date: 16-05-2022 11:12:33 ******/
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
	[mnrrda] [char](1) NULL,
	[mnfactor] [float] NOT NULL,
	[mnrefusd] [char](1) NULL,
	[mnlocal] [char](1) NULL,
	[mnextranj] [char](1) NULL,
	[mnvalor] [char](1) NULL,
	[mnrefmerc] [char](1) NULL,
	[mntipmon] [char](1) NULL,
	[mnperiodo] [numeric](2, 0) NULL,
	[mnmx] [char](1) NULL,
	[mncodfox] [char](6) NULL,
	[mnvalfox] [numeric](5, 0) NULL,
	[mncodcor] [numeric](7, 0) NULL,
	[codigo_pais] [numeric](5, 0) NULL,
	[codigo_canasta] [numeric](3, 0) NOT NULL,
	[codigo_variabilidad] [char](3) NOT NULL,
	[estado] [char](1) NOT NULL,
	[tipo_indicador] [int] NOT NULL,
	[codigo_fuenteinformacion] [numeric](10, 0) NOT NULL,
	[flag_factorderiesgo] [int] NOT NULL,
	[ocurrencia] [numeric](2, 0) NOT NULL,
	[CodDivEsp] [numeric](2, 0) NOT NULL,
	[canasta] [char](1) NOT NULL,
	[moneda_canasta] [numeric](3, 0) NOT NULL,
	[mnglosa2] [char](5) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncodmon]  DEFAULT ((0)) FOR [mncodmon]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnnemo]  DEFAULT ('') FOR [mnnemo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnsimbol]  DEFAULT ('') FOR [mnsimbol]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnglosa]  DEFAULT ('') FOR [mnglosa]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncodsuper]  DEFAULT ((0)) FOR [mncodsuper]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnnemsuper]  DEFAULT ('') FOR [mnnemsuper]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncodbanco]  DEFAULT ((0)) FOR [mncodbanco]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnnembanco]  DEFAULT ('') FOR [mnnembanco]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnbase]  DEFAULT ((0)) FOR [mnbase]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnredondeo]  DEFAULT ((0)) FOR [mnredondeo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mndecimal]  DEFAULT ((0)) FOR [mndecimal]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnrrda]  DEFAULT ('') FOR [mnrrda]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnfactor]  DEFAULT ((0)) FOR [mnfactor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnrefusd]  DEFAULT ('') FOR [mnrefusd]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnlocal]  DEFAULT ('') FOR [mnlocal]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnextranj]  DEFAULT ('') FOR [mnextranj]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnvalor]  DEFAULT ('') FOR [mnvalor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnrefmerc]  DEFAULT ('') FOR [mnrefmerc]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mntipmon]  DEFAULT ('') FOR [mntipmon]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnperiodo]  DEFAULT ((0)) FOR [mnperiodo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnmx]  DEFAULT ('') FOR [mnmx]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncodfox]  DEFAULT ('') FOR [mncodfox]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnvalfox]  DEFAULT ((0)) FOR [mnvalfox]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mncodcor]  DEFAULT ((0)) FOR [mncodcor]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_codigo_pais]  DEFAULT ((0)) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_codigo_canasta]  DEFAULT ((0)) FOR [codigo_canasta]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_codigo_variabilidad]  DEFAULT ('') FOR [codigo_variabilidad]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_estado]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_tipo_indicador]  DEFAULT ((0)) FOR [tipo_indicador]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_codigo_fuenteinformacion]  DEFAULT ((0)) FOR [codigo_fuenteinformacion]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_flag_factorderiesgo]  DEFAULT ((0)) FOR [flag_factorderiesgo]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_ocurrencia]  DEFAULT ((0)) FOR [ocurrencia]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_CodDivEsp]  DEFAULT ((0)) FOR [CodDivEsp]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_canasta]  DEFAULT ('') FOR [canasta]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_moneda_canasta]  DEFAULT ((0)) FOR [moneda_canasta]
GO
ALTER TABLE [dbo].[MONEDA] ADD  CONSTRAINT [DF_MONEDA_mnglosa2]  DEFAULT ('') FOR [mnglosa2]
GO

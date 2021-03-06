USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[cortes]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cortes](
	[cornumoper] [numeric](10, 0) NOT NULL,
	[corcorrela] [numeric](3, 0) NOT NULL,
	[corfecvcto] [datetime] NOT NULL,
	[cormonto] [numeric](21, 4) NOT NULL,
	[cormontocomp] [numeric](21, 4) NOT NULL,
	[cormontodia] [numeric](21, 4) NOT NULL,
	[corprecio] [float] NOT NULL,
	[corpreciodia] [float] NOT NULL,
	[correscnv] [numeric](21, 4) NOT NULL,
	[corsaldo] [numeric](21, 0) NOT NULL,
	[corsaldoAcu] [numeric](21, 0) NOT NULL,
	[corsalAcum] [numeric](21, 4) NOT NULL,
	[correajac] [numeric](21, 0) NOT NULL,
	[corresclp] [numeric](21, 0) NOT NULL,
	[corultimo] [char](1) NOT NULL,
	[cortastab] [float] NOT NULL,
	[corestado] [numeric](1, 0) NOT NULL,
	[corbase] [numeric](4, 0) NOT NULL,
	[cointeresac] [numeric](21, 0) NOT NULL,
	[correajayer] [numeric](21, 0) NOT NULL,
	[corinteresayer] [numeric](21, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__cornumop__28C48C4D]  DEFAULT (0) FOR [cornumoper]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corcorre__29B8B086]  DEFAULT (0) FOR [corcorrela]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corfecvc__2AACD4BF]  DEFAULT (' ') FOR [corfecvcto]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__cormonto__2BA0F8F8]  DEFAULT (0) FOR [cormonto]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__cormonto__2C951D31]  DEFAULT (0) FOR [cormontocomp]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__cormonto__2D89416A]  DEFAULT (0) FOR [cormontodia]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corpreci__2E7D65A3]  DEFAULT (0) FOR [corprecio]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corpreci__2F7189DC]  DEFAULT (0) FOR [corpreciodia]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__correscn__3065AE15]  DEFAULT (0) FOR [correscnv]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corsaldo__3159D24E]  DEFAULT (0) FOR [corsaldo]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corsaldo__324DF687]  DEFAULT (0) FOR [corsaldoAcu]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corsalAc__33421AC0]  DEFAULT (0) FOR [corsalAcum]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__correaja__34363EF9]  DEFAULT (0) FOR [correajac]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__correscl__352A6332]  DEFAULT (0) FOR [corresclp]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corultim__361E876B]  DEFAULT (' ') FOR [corultimo]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__cortasta__3712ABA4]  DEFAULT (0) FOR [cortastab]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corestad__3806CFDD]  DEFAULT (0) FOR [corestado]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF__cortes__corbase__3D73F9C2]  DEFAULT (360) FOR [corbase]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF_cortes_intereses]  DEFAULT (0) FOR [cointeresac]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF_cortes_correajayer]  DEFAULT (0) FOR [correajayer]
GO
ALTER TABLE [dbo].[cortes] ADD  CONSTRAINT [DF_cortes_corinteresayer]  DEFAULT (0) FOR [corinteresayer]
GO

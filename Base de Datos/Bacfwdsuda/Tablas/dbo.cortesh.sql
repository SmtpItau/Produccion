USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[cortesh]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cortesh](
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
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__cornumo__39EF184F]  DEFAULT (0) FOR [cornumoper]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corcorr__3AE33C88]  DEFAULT (0) FOR [corcorrela]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corfecv__3BD760C1]  DEFAULT (' ') FOR [corfecvcto]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__cormont__3CCB84FA]  DEFAULT (0) FOR [cormonto]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__cormont__3DBFA933]  DEFAULT (0) FOR [cormontocomp]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__cormont__3EB3CD6C]  DEFAULT (0) FOR [cormontodia]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corprec__3FA7F1A5]  DEFAULT (0) FOR [corprecio]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corprec__409C15DE]  DEFAULT (0) FOR [corpreciodia]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corresc__41903A17]  DEFAULT (0) FOR [correscnv]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corsald__42845E50]  DEFAULT (0) FOR [corsaldo]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corsald__43788289]  DEFAULT (0) FOR [corsaldoAcu]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corsalA__446CA6C2]  DEFAULT (0) FOR [corsalAcum]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__correaj__4560CAFB]  DEFAULT (0) FOR [correajac]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corresc__4654EF34]  DEFAULT (0) FOR [corresclp]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corulti__4749136D]  DEFAULT (' ') FOR [corultimo]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__cortast__483D37A6]  DEFAULT (0) FOR [cortastab]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__coresta__49315BDF]  DEFAULT (0) FOR [corestado]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF__cortesh__corbase__5086CE36]  DEFAULT (360) FOR [corbase]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF_cortesh_intereses]  DEFAULT (0) FOR [cointeresac]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF_cortesh_correajayer]  DEFAULT (0) FOR [correajayer]
GO
ALTER TABLE [dbo].[cortesh] ADD  CONSTRAINT [DF_cortesh_corinteresayer]  DEFAULT (0) FOR [corinteresayer]
GO

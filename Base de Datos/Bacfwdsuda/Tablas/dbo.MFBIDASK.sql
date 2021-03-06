USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MFBIDASK]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MFBIDASK](
	[moneda] [numeric](3, 0) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[periodo] [numeric](3, 0) NOT NULL,
	[bid] [float] NOT NULL,
	[ask] [float] NOT NULL,
	[factor] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__moneda__02FC7413]  DEFAULT (0) FOR [moneda]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__fecha__03F0984C]  DEFAULT (' ') FOR [fecha]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__period__04E4BC85]  DEFAULT (0) FOR [periodo]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__bid__05D8E0BE]  DEFAULT (0) FOR [bid]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__ask__06CD04F7]  DEFAULT (0) FOR [ask]
GO
ALTER TABLE [dbo].[MFBIDASK] ADD  CONSTRAINT [DF__mfbidask__factor__07C12930]  DEFAULT (0) FOR [factor]
GO

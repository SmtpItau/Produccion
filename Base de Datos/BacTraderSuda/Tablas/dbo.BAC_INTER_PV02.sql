USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_INTER_PV02]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_INTER_PV02](
	[id_sistema] [char](3) NOT NULL,
	[informat] [char](8) NOT NULL,
	[method] [char](6) NOT NULL,
	[lon_sho] [char](5) NOT NULL,
	[asset_al] [char](3) NOT NULL,
	[risk_cla] [char](13) NOT NULL,
	[product] [char](10) NOT NULL,
	[bucket] [char](4) NOT NULL,
	[currency] [char](3) NOT NULL,
	[llave] [char](1) NOT NULL,
	[pv01] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__id_si__06ADD4BD]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__infor__07A1F8F6]  DEFAULT ('') FOR [informat]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__metho__08961D2F]  DEFAULT ('') FOR [method]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__lon_s__098A4168]  DEFAULT ('') FOR [lon_sho]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__asset__0A7E65A1]  DEFAULT ('') FOR [asset_al]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__risk___0B7289DA]  DEFAULT ('') FOR [risk_cla]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__produ__0C66AE13]  DEFAULT ('') FOR [product]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__bucke__0D5AD24C]  DEFAULT ('') FOR [bucket]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__curre__0E4EF685]  DEFAULT ('') FOR [currency]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter__llave__0F431ABE]  DEFAULT ('') FOR [llave]
GO
ALTER TABLE [dbo].[BAC_INTER_PV02] ADD  CONSTRAINT [DF__bac_inter___pv01__10373EF7]  DEFAULT (0) FOR [pv01]
GO

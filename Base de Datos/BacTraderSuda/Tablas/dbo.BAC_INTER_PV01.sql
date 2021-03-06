USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_INTER_PV01]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_INTER_PV01](
	[id_sistema] [char](3) NOT NULL,
	[header] [char](2) NOT NULL,
	[san] [char](3) NOT NULL,
	[emer_mark] [char](4) NOT NULL,
	[latamericam] [char](4) NOT NULL,
	[trading] [char](3) NOT NULL,
	[ano] [char](10) NOT NULL,
	[idc] [char](1) NOT NULL,
	[ir] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter__id_si__2CD37DA5]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter__heade__2DC7A1DE]  DEFAULT ('') FOR [header]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter_P__san__2EBBC617]  DEFAULT ('') FOR [san]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter__emer___2FAFEA50]  DEFAULT ('') FOR [emer_mark]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter__latam__30A40E89]  DEFAULT ('') FOR [latamericam]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter__tradi__319832C2]  DEFAULT ('') FOR [trading]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter_P__ano__328C56FB]  DEFAULT ('') FOR [ano]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter_P__idc__33807B34]  DEFAULT ('') FOR [idc]
GO
ALTER TABLE [dbo].[BAC_INTER_PV01] ADD  CONSTRAINT [DF__bac_inter_PV__ir__34749F6D]  DEFAULT (0) FOR [ir]
GO

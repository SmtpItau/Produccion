USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[Usuario_Bac_Otc]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Bac_Otc](
	[Sistema] [char](10) NOT NULL,
	[Usuario_Bac] [char](15) NOT NULL,
	[Usuario_Exo] [char](40) NOT NULL,
	[Cartera_Bac] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Usuario_Bac_Otc] ADD  CONSTRAINT [DF__Usuario_B__Siste__1F6473EE]  DEFAULT (' ') FOR [Sistema]
GO
ALTER TABLE [dbo].[Usuario_Bac_Otc] ADD  CONSTRAINT [DF__Usuario_B__Usuar__20589827]  DEFAULT (' ') FOR [Usuario_Bac]
GO
ALTER TABLE [dbo].[Usuario_Bac_Otc] ADD  CONSTRAINT [DF__Usuario_B__Usuar__214CBC60]  DEFAULT (' ') FOR [Usuario_Exo]
GO
ALTER TABLE [dbo].[Usuario_Bac_Otc] ADD  CONSTRAINT [DF__Usuario_B__Carte__2240E099]  DEFAULT (0) FOR [Cartera_Bac]
GO

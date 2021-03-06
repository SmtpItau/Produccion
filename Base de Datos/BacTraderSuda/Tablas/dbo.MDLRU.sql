USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRU]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRU](
	[lrucliente] [numeric](9, 0) NOT NULL,
	[lrupatrim] [float] NOT NULL,
	[lrufacsol] [float] NOT NULL,
	[lruporpatr] [float] NOT NULL,
	[lrulbpatr] [float] NOT NULL,
	[lruporcart] [float] NOT NULL,
	[lrulinpatr] [float] NOT NULL,
	[lrulincart] [float] NOT NULL,
	[lrulinbase] [float] NOT NULL,
	[lrulinocup] [float] NOT NULL,
	[lrusaldo] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lruclient__5BED93EA]  DEFAULT (0) FOR [lrucliente]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrupatrim__5CE1B823]  DEFAULT (0.0) FOR [lrupatrim]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrufacsol__5DD5DC5C]  DEFAULT (0.0) FOR [lrufacsol]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lruporpat__5ECA0095]  DEFAULT (0.0) FOR [lruporpatr]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrulbpatr__5FBE24CE]  DEFAULT (0.0) FOR [lrulbpatr]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lruporcar__60B24907]  DEFAULT (0.0) FOR [lruporcart]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrulinpat__61A66D40]  DEFAULT (0.0) FOR [lrulinpatr]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrulincar__629A9179]  DEFAULT (0.0) FOR [lrulincart]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrulinbas__638EB5B2]  DEFAULT (0.0) FOR [lrulinbase]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrulinocu__6482D9EB]  DEFAULT (0.0) FOR [lrulinocup]
GO
ALTER TABLE [dbo].[MDLRU] ADD  CONSTRAINT [DF__mdlru__lrusaldo__6576FE24]  DEFAULT (0.0) FOR [lrusaldo]
GO

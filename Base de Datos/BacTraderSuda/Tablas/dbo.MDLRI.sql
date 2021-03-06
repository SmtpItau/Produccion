USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRI]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRI](
	[lricodigo] [numeric](4, 0) NOT NULL,
	[lricodplz] [numeric](4, 0) NOT NULL,
	[lriporcci] [float] NOT NULL,
	[lrilbaseci] [float] NOT NULL,
	[lrilocupci] [float] NOT NULL,
	[lrisaldoci] [float] NOT NULL,
	[lriporccp] [float] NOT NULL,
	[lrilbasecp] [float] NOT NULL,
	[lrilocupcp] [float] NOT NULL,
	[lrisaldocp] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lricodigo__422DC1E7]  DEFAULT (0) FOR [lricodigo]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lricodplz__4321E620]  DEFAULT (0) FOR [lricodplz]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lriporcci__44160A59]  DEFAULT (0.0) FOR [lriporcci]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrilbasec__450A2E92]  DEFAULT (0.0) FOR [lrilbaseci]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrilocupc__45FE52CB]  DEFAULT (0.0) FOR [lrilocupci]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrisaldoc__46F27704]  DEFAULT (0.0) FOR [lrisaldoci]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lriporccp__47E69B3D]  DEFAULT (0.0) FOR [lriporccp]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrilbasec__48DABF76]  DEFAULT (0.0) FOR [lrilbasecp]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrilocupc__49CEE3AF]  DEFAULT (0.0) FOR [lrilocupcp]
GO
ALTER TABLE [dbo].[MDLRI] ADD  CONSTRAINT [DF__mdlri__lrisaldoc__4AC307E8]  DEFAULT (0.0) FOR [lrisaldocp]
GO

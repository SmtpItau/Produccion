USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLCR]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLCR](
	[lcrcodigo] [char](10) NOT NULL,
	[lcrvalor] [float] NOT NULL,
	[lcrtipo] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLCR] ADD  CONSTRAINT [DF__mdlcr__lcrcodigo__76D69450]  DEFAULT (' ') FOR [lcrcodigo]
GO
ALTER TABLE [dbo].[MDLCR] ADD  CONSTRAINT [DF__mdlcr__lcrvalor__77CAB889]  DEFAULT (0.0) FOR [lcrvalor]
GO
ALTER TABLE [dbo].[MDLCR] ADD  CONSTRAINT [DF__mdlcr__lcrtipo__78BEDCC2]  DEFAULT (' ') FOR [lcrtipo]
GO

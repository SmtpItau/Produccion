USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBCORRELATIVOS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBCORRELATIVOS](
	[fecha] [datetime] NOT NULL,
	[tabla] [varchar](30) NOT NULL,
	[codigo] [numeric](6, 0) NOT NULL,
	[glosa] [varchar](30) NOT NULL,
	[inicial] [numeric](7, 0) NOT NULL,
	[actual] [numeric](7, 0) NOT NULL,
	[pendiente] [numeric](7, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__fecha__15702A09]  DEFAULT ('') FOR [fecha]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__tabla__16644E42]  DEFAULT ('') FOR [tabla]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__codig__1758727B]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__glosa__184C96B4]  DEFAULT ('') FOR [glosa]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__inici__1940BAED]  DEFAULT (0) FOR [inicial]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__actua__1A34DF26]  DEFAULT (0) FOR [actual]
GO
ALTER TABLE [dbo].[TBCORRELATIVOS] ADD  CONSTRAINT [DF__tbCorrela__pendi__1B29035F]  DEFAULT (0) FOR [pendiente]
GO

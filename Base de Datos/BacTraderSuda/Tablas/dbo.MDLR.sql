USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLR]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLR](
	[lrrutcl] [numeric](9, 0) NOT NULL,
	[lrmax_glob] [numeric](19, 0) NOT NULL,
	[lrexp_glob] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLR] ADD  CONSTRAINT [DF__mdlr__lrrutcl__005FFE8A]  DEFAULT (0) FOR [lrrutcl]
GO
ALTER TABLE [dbo].[MDLR] ADD  CONSTRAINT [DF__mdlr__lrmax_glob__015422C3]  DEFAULT (0) FOR [lrmax_glob]
GO
ALTER TABLE [dbo].[MDLR] ADD  CONSTRAINT [DF__mdlr__lrexp_glob__024846FC]  DEFAULT (' ') FOR [lrexp_glob]
GO

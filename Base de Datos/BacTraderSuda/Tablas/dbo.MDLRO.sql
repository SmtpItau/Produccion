USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDLRO]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLRO](
	[lronumoper] [numeric](10, 0) NOT NULL,
	[lrotipoper] [char](3) NOT NULL,
	[lroobslim] [varchar](255) NOT NULL,
	[lroobsapr] [char](200) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLRO] ADD  CONSTRAINT [DF__mdlro__lronumope__4D9F7493]  DEFAULT (0) FOR [lronumoper]
GO
ALTER TABLE [dbo].[MDLRO] ADD  CONSTRAINT [DF__mdlro__lrotipope__4E9398CC]  DEFAULT (' ') FOR [lrotipoper]
GO
ALTER TABLE [dbo].[MDLRO] ADD  CONSTRAINT [DF__mdlro__lroobslim__4F87BD05]  DEFAULT (' ') FOR [lroobslim]
GO
ALTER TABLE [dbo].[MDLRO] ADD  CONSTRAINT [DF__mdlro__lroobsapr__507BE13E]  DEFAULT (' ') FOR [lroobsapr]
GO

USE [MDPasivo]
GO
/****** Object:  Table [dbo].[EMISOR]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMISOR](
	[emcodigo] [numeric](9, 0) NOT NULL,
	[emrut] [numeric](9, 0) NOT NULL,
	[emdv] [char](1) NOT NULL,
	[emnombre] [char](40) NOT NULL,
	[emgeneric] [char](10) NOT NULL,
	[emdirecc] [char](40) NULL,
	[emcomuna] [numeric](4, 0) NULL,
	[emtipo] [char](3) NOT NULL,
	[emglosa] [char](20) NULL,
	[embonos] [char](20) NULL,
	[estado] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emcodigo]  DEFAULT ((0)) FOR [emcodigo]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emrut]  DEFAULT ((0)) FOR [emrut]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emdv]  DEFAULT ('') FOR [emdv]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emnombre]  DEFAULT ('') FOR [emnombre]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emgeneric]  DEFAULT ('') FOR [emgeneric]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emdirecc]  DEFAULT ('') FOR [emdirecc]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emcomuna]  DEFAULT ((0)) FOR [emcomuna]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emtipo]  DEFAULT ('') FOR [emtipo]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_emglosa]  DEFAULT ('') FOR [emglosa]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_embonos]  DEFAULT ('') FOR [embonos]
GO
ALTER TABLE [dbo].[EMISOR] ADD  CONSTRAINT [DF_EMISOR_estado]  DEFAULT ('') FOR [estado]
GO

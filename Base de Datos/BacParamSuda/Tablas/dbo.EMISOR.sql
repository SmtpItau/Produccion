USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[EMISOR]    Script Date: 13-05-2022 10:58:09 ******/
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
	[clasificacion1] [char](40) NOT NULL,
	[clasificacion2] [char](40) NOT NULL,
	[tipo_corto1] [char](30) NOT NULL,
	[tipo_largo1] [char](30) NOT NULL,
	[tipo_corto2] [char](30) NOT NULL,
	[tipo_largo2] [char](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emrut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [clasificacion1]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [clasificacion2]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [tipo_corto1]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [tipo_largo1]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [tipo_corto2]
GO
ALTER TABLE [dbo].[EMISOR] ADD  DEFAULT (' ') FOR [tipo_largo2]
GO

USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_SITEMAP_ROLES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_SITEMAP_ROLES](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_site] [int] NOT NULL,
	[id_role] [nvarchar](30) NOT NULL,
	[is_find] [bit] NULL,
	[is_print] [bit] NULL,
	[is_write] [bit] NULL,
	[is_erase] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_site] ASC,
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_SITEMAP_ROLES] ADD  DEFAULT ((0)) FOR [is_find]
GO
ALTER TABLE [dbo].[FWK_SITEMAP_ROLES] ADD  DEFAULT ((0)) FOR [is_print]
GO
ALTER TABLE [dbo].[FWK_SITEMAP_ROLES] ADD  DEFAULT ((0)) FOR [is_write]
GO
ALTER TABLE [dbo].[FWK_SITEMAP_ROLES] ADD  DEFAULT ((0)) FOR [is_erase]
GO

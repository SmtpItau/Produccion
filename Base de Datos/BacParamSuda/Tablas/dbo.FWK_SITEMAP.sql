USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_SITEMAP]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_SITEMAP](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_site] [int] NOT NULL,
	[titulo] [varchar](60) NOT NULL,
	[descripcion] [varchar](512) NULL,
	[URL] [varchar](512) NULL,
	[roles] [varchar](512) NULL,
	[id_site_parent] [int] NULL,
	[args] [varchar](50) NULL,
	[orden] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

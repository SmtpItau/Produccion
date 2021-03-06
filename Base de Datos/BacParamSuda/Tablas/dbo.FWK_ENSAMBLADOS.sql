USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_ENSAMBLADOS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_ENSAMBLADOS](
	[id_file] [nvarchar](100) NOT NULL,
	[version] [varchar](30) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[DATA] [varbinary](max) NOT NULL,
	[created_ticks] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_file] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_ENSAMBLADOS] ADD  DEFAULT ((0)) FOR [created_ticks]
GO

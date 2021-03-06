USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_REPOSITORIO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_REPOSITORIO](
	[id_file] [nvarchar](100) NOT NULL,
	[extension] [varchar](6) NOT NULL,
	[version] [varchar](30) NOT NULL,
	[created_ticks] [varchar](30) NULL,
	[DATA] [varbinary](1) NOT NULL,
	[is_optional] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_file] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_REPOSITORIO] ADD  DEFAULT ((0)) FOR [created_ticks]
GO
ALTER TABLE [dbo].[FWK_REPOSITORIO] ADD  DEFAULT ((0)) FOR [is_optional]
GO

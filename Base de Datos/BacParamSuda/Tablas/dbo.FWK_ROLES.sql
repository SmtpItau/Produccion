USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_ROLES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_ROLES](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_role] [nvarchar](30) NOT NULL,
	[descripcion] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

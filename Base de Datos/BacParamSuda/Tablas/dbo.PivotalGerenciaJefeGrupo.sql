USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalGerenciaJefeGrupo]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalGerenciaJefeGrupo](
	[Gerencia] [nvarchar](50) NOT NULL,
	[JefeGrupo] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Gerencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

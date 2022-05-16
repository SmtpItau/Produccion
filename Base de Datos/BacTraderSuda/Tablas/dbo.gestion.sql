USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[gestion]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gestion](
	[CODIGO_INS] [nvarchar](21) NULL,
	[INSTRUMENT] [char](10) NULL,
	[OPERA] [nvarchar](21) NULL,
	[CODIGO] [nvarchar](10) NULL,
	[GLOSA] [nvarchar](120) NULL,
	[CRITERIO] [nvarchar](32) NULL,
	[TIPOPERAC] [nvarchar](19) NULL
) ON [PRIMARY]
GO

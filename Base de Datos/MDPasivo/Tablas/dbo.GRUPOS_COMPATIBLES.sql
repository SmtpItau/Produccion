USE [MDPasivo]
GO
/****** Object:  Table [dbo].[GRUPOS_COMPATIBLES]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPOS_COMPATIBLES](
	[id_grupo] [int] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Area] [varchar](20) NOT NULL
) ON [PRIMARY]
GO

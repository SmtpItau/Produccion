USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[GRUPO_PRODUCTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_PRODUCTO](
	[codigo_grupo] [char](10) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[riesgo] [char](10) NOT NULL
) ON [PRIMARY]
GO

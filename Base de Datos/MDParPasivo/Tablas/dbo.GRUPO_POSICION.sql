USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[GRUPO_POSICION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_POSICION](
	[codigo_grupo] [varchar](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[plazo_desde] [numeric](5, 0) NOT NULL,
	[plazo_hasta] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MODELO_DE_BONOS]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MODELO_DE_BONOS](
	[codigo_modelo] [int] NOT NULL,
	[nemotecnico] [char](15) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO

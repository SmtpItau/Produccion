USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[RELACION_CAMPO_SUBPRODUCTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_CAMPO_SUBPRODUCTO](
	[codigo_campo] [char](5) NOT NULL,
	[nombre_campo] [char](25) NOT NULL,
	[tabla_relacion] [varchar](50) NOT NULL,
	[campo_consulta] [varchar](255) NOT NULL
) ON [PRIMARY]
GO

USE [MDPasivo]
GO
/****** Object:  Table [dbo].[FUENTE_INFORMACION]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUENTE_INFORMACION](
	[codigo_fuenteinformacion] [numeric](10, 0) NOT NULL,
	[nemotecnico] [char](15) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO

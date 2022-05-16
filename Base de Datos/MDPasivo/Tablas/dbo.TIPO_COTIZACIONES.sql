USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_COTIZACIONES]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_COTIZACIONES](
	[codigo_tipodecotizacion] [int] NOT NULL,
	[nemotecnico] [char](15) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO

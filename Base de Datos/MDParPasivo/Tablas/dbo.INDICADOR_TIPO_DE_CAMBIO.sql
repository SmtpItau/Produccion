USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[INDICADOR_TIPO_DE_CAMBIO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDICADOR_TIPO_DE_CAMBIO](
	[mncodmon] [numeric](5, 0) NOT NULL,
	[codigo_monedacotizacion] [int] NOT NULL,
	[codigo_monedabase] [int] NOT NULL
) ON [PRIMARY]
GO

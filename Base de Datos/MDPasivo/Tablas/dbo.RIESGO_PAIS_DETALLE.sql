USE [MDPasivo]
GO
/****** Object:  Table [dbo].[RIESGO_PAIS_DETALLE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIESGO_PAIS_DETALLE](
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[fechainicio] [datetime] NOT NULL,
	[fechafinal] [datetime] NOT NULL,
	[montooperacion] [numeric](19, 0) NOT NULL,
	[usuario] [varchar](10) NOT NULL
) ON [PRIMARY]
GO

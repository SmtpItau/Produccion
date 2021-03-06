USE [MDPasivo]
GO
/****** Object:  Table [dbo].[INDICADOR_BONO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDICADOR_BONO](
	[mncodmon] [numeric](5, 0) NOT NULL,
	[codigo_modelo] [int] NOT NULL,
	[codigo_tipointereses] [int] NOT NULL,
	[codigo_frecuenciatasa] [int] NOT NULL,
	[codigo_convenciondiasbase] [int] NOT NULL,
	[codigo_tipodecotizacion] [int] NOT NULL,
	[codigo_moneda] [int] NOT NULL,
	[tasa_emision] [float] NOT NULL,
	[numero_cupones] [int] NOT NULL,
	[numero_amortizaciones] [int] NOT NULL,
	[codigo_modeloindicadorbono] [int] NOT NULL
) ON [PRIMARY]
GO

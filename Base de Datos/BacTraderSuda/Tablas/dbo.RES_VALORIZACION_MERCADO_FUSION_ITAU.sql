USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[RES_VALORIZACION_MERCADO_FUSION_ITAU]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RES_VALORIZACION_MERCADO_FUSION_ITAU](
	[fecha_valorizacion] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[rmrutcart] [numeric](9, 0) NOT NULL,
	[rmnumdocu] [numeric](10, 0) NOT NULL,
	[rmnumoper] [numeric](10, 0) NOT NULL,
	[rmcorrela] [numeric](3, 0) NOT NULL,
	[rmcodigo] [numeric](5, 0) NOT NULL,
	[rminstser] [char](10) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[moneda_emision] [numeric](3, 0) NOT NULL,
	[valor_nominal] [numeric](19, 4) NOT NULL,
	[tasa_compra] [numeric](8, 4) NOT NULL,
	[tasa_mercado] [numeric](19, 4) NULL,
	[tasa_market] [numeric](8, 4) NOT NULL,
	[tasa_market1] [numeric](8, 4) NOT NULL,
	[tasa_market2] [numeric](8, 4) NOT NULL,
	[valor_presente] [numeric](19, 4) NULL,
	[valor_mercado] [numeric](19, 4) NULL,
	[valor_market] [numeric](19, 4) NULL,
	[valor_market1] [numeric](19, 4) NULL,
	[valor_market2] [numeric](19, 4) NULL,
	[diferencia_mercado] [numeric](19, 4) NULL,
	[diferencia_market] [numeric](19, 4) NULL,
	[diferencia_market1] [numeric](19, 4) NULL,
	[diferencia_market2] [numeric](19, 4) NULL,
	[tmfecemi] [datetime] NULL,
	[tmfecven] [datetime] NULL,
	[tmseriado] [char](1) NULL,
	[tmmascara] [char](12) NULL,
	[PorcjeCob] [numeric](5, 2) NOT NULL,
	[OrigenCurva] [char](2) NOT NULL,
	[ValorMercadoParPrx] [numeric](19, 4) NOT NULL,
	[ValorMercadoCLPParPrx] [numeric](19, 4) NOT NULL,
	[Convexidad] [float] NOT NULL,
	[Duration_Mod] [float] NOT NULL,
	[VpComp] [float] NOT NULL,
	[ID_NIVEL_DE_RIESGO] [varchar](2) NOT NULL
) ON [PRIMARY]
GO

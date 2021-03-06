USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CarteraCorregidaVentas]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarteraCorregidaVentas](
	[mofecpro] [datetime] NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL,
	[Correla] [numeric](3, 0) NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[ValorVenta] [float] NULL,
	[moutilidad] [numeric](19, 4) NULL,
	[moperdida] [numeric](19, 4) NULL,
	[UtilidadOriginal] [numeric](19, 4) NULL,
	[PerdidaOriginal] [numeric](19, 4) NULL,
	[movpresen] [numeric](19, 4) NOT NULL,
	[ValorCartera] [numeric](19, 4) NOT NULL,
	[Serie] [char](12) NOT NULL,
	[Resultado_Dif_Precio] [numeric](21, 4) NOT NULL,
	[Resultado_Dif_Mercado] [numeric](21, 4) NOT NULL,
	[ResDifPrecio] [numeric](21, 4) NOT NULL,
	[ResDifMercado] [numeric](21, 4) NOT NULL,
	[TirVenta] [numeric](19, 4) NOT NULL,
	[tasa_compra] [numeric](8, 4) NOT NULL,
	[cptircomp] [numeric](19, 4) NULL,
	[inserie] [char](12) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[iRegistro] [bigint] NULL,
	[GlosaCartera] [char](50) NOT NULL
) ON [PRIMARY]
GO

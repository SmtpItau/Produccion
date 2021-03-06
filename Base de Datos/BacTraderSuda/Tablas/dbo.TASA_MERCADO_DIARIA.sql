USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TASA_MERCADO_DIARIA]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_MERCADO_DIARIA](
	[fecha_proceso] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tmrutcart] [numeric](9, 0) NOT NULL,
	[tmrutemis] [numeric](9, 0) NOT NULL,
	[tmcodigo] [numeric](3, 0) NOT NULL,
	[tminstser] [char](10) NOT NULL,
	[tmmonemis] [numeric](3, 0) NOT NULL,
	[tmgenemis] [char](6) NOT NULL,
	[tmnominal] [numeric](19, 4) NOT NULL,
	[tmfecvcto] [datetime] NOT NULL,
	[tasa_mercado] [numeric](8, 4) NOT NULL,
	[tasa_market] [numeric](8, 4) NOT NULL,
	[tasa_market1] [numeric](8, 4) NOT NULL,
	[tasa_market2] [numeric](8, 4) NOT NULL,
	[tasa_mercado_cierre] [numeric](8, 4) NOT NULL,
	[tasa_market_cierre] [numeric](8, 4) NOT NULL
) ON [PRIMARY]
GO

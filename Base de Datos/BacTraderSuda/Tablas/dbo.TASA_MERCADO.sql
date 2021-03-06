USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TASA_MERCADO]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_MERCADO](
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
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tmgen__085A1EC0]  DEFAULT ('') FOR [tmgenemis]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tmnom__094E42F9]  DEFAULT (0) FOR [tmnominal]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tmfec__0A426732]  DEFAULT ('') FOR [tmfecvcto]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0B368B6B]  DEFAULT (0) FOR [tasa_mercado]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0C2AAFA4]  DEFAULT (0) FOR [tasa_market]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0D1ED3DD]  DEFAULT (0) FOR [tasa_market1]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0E12F816]  DEFAULT (0) FOR [tasa_market2]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0F071C4F]  DEFAULT (0) FOR [tasa_mercado_cierre]
GO
ALTER TABLE [dbo].[TASA_MERCADO] ADD  CONSTRAINT [DF__TASA_MERC__tasa___0FFB4088]  DEFAULT (0) FOR [tasa_market_cierre]
GO

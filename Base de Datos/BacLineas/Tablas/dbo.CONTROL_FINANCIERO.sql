USE [BacLineas]
GO
/****** Object:  Table [dbo].[CONTROL_FINANCIERO]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROL_FINANCIERO](
	[capitalyreserva] [numeric](19, 4) NOT NULL,
	[capitalbasico] [numeric](19, 4) NOT NULL,
	[monedacontrol] [numeric](5, 0) NOT NULL,
	[valormoneda] [numeric](10, 4) NOT NULL,
	[numerotraspaso] [numeric](10, 0) NOT NULL,
	[porcenconriesgo] [numeric](10, 4) NOT NULL,
	[porcensinriesgo] [numeric](10, 4) NOT NULL,
	[porceninvext] [numeric](10, 4) NOT NULL,
	[montoconriesgo] [numeric](19, 4) NOT NULL,
	[montosinriesgo] [numeric](19, 4) NOT NULL,
	[invexttotal] [numeric](19, 4) NOT NULL,
	[invextocupado] [numeric](19, 4) NOT NULL,
	[invextdisponible] [numeric](19, 4) NOT NULL,
	[invextexceso] [numeric](19, 4) NOT NULL,
	[primertramo] [numeric](19, 4) NOT NULL,
	[segundotramo] [numeric](19, 4) NOT NULL,
	[tercertramo] [numeric](19, 4) NOT NULL,
	[margeninstitucion] [numeric](19, 4) NOT NULL,
	[totalcarteraLchr] [numeric](19, 4) NOT NULL,
	[totalporfolio] [numeric](19, 4) NOT NULL,
	[cajapesos] [numeric](19, 4) NOT NULL,
	[cajabcch] [numeric](19, 4) NOT NULL,
	[totalinversiones] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Capit__00A18C5A]  DEFAULT (0) FOR [capitalyreserva]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Capit__0195B093]  DEFAULT (0) FOR [capitalbasico]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Moned__0289D4CC]  DEFAULT (0) FOR [monedacontrol]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Valor__037DF905]  DEFAULT (0) FOR [valormoneda]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Numer__04721D3E]  DEFAULT (0) FOR [numerotraspaso]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Porce__05664177]  DEFAULT (0) FOR [porcenconriesgo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Porce__065A65B0]  DEFAULT (0) FOR [porcensinriesgo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Porce__074E89E9]  DEFAULT (0) FOR [porceninvext]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Monto__0842AE22]  DEFAULT (0) FOR [montoconriesgo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Monto__0936D25B]  DEFAULT (0) FOR [montosinriesgo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__InvEx__0A2AF694]  DEFAULT (0) FOR [invexttotal]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__InvEx__0B1F1ACD]  DEFAULT (0) FOR [invextocupado]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__InvEx__0C133F06]  DEFAULT (0) FOR [invextdisponible]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__InvEx__0D07633F]  DEFAULT (0) FOR [invextexceso]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Prime__0DFB8778]  DEFAULT (0) FOR [primertramo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Segun__0EEFABB1]  DEFAULT (0) FOR [segundotramo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Terce__0FE3CFEA]  DEFAULT (0) FOR [tercertramo]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Marge__10D7F423]  DEFAULT (0) FOR [margeninstitucion]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Total__11CC185C]  DEFAULT (0) FOR [totalcarteraLchr]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Total__12C03C95]  DEFAULT (0) FOR [totalporfolio]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__CajaP__13B460CE]  DEFAULT (0) FOR [cajapesos]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__CajaB__14A88507]  DEFAULT (0) FOR [cajabcch]
GO
ALTER TABLE [dbo].[CONTROL_FINANCIERO] ADD  CONSTRAINT [DF__CONTROL_F__Total__159CA940]  DEFAULT (0) FOR [totalinversiones]
GO

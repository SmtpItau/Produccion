USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VALOR_INSTITUCIONAL]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALOR_INSTITUCIONAL](
	[entidad] [varchar](2) NOT NULL,
	[capitalyreserva] [numeric](19, 0) NOT NULL,
	[capitalbasico] [numeric](19, 0) NOT NULL,
	[primertramo] [numeric](19, 0) NOT NULL,
	[segundotramo] [numeric](19, 0) NOT NULL,
	[tercertramo] [numeric](19, 0) NOT NULL,
	[margeninst] [numeric](19, 0) NOT NULL,
	[carteralchr] [numeric](19, 0) NOT NULL,
	[totalporfolio] [numeric](19, 0) NOT NULL,
	[porcentajelamina] [numeric](8, 4) NOT NULL,
	[totallamina] [numeric](19, 0) NOT NULL,
	[porcentajecertif] [numeric](8, 4) NOT NULL,
	[totalcertif] [numeric](8, 4) NOT NULL,
	[riesgoglobalinv] [numeric](19, 0) NOT NULL,
	[riesgoglobaltotal] [numeric](19, 0) NOT NULL,
	[riesgoglobalocupado] [numeric](19, 0) NOT NULL,
	[riesgoglobaldisponi] [numeric](19, 0) NOT NULL,
	[cajapesos] [numeric](19, 0) NOT NULL,
	[cajabcchpesos] [numeric](19, 0) NOT NULL,
	[inversiones] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[entidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Capit__6069C6F2]  DEFAULT (0) FOR [capitalyreserva]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Capit__615DEB2B]  DEFAULT (0) FOR [capitalbasico]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Prime__62520F64]  DEFAULT (0) FOR [primertramo]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Segun__6346339D]  DEFAULT (0) FOR [segundotramo]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Terce__643A57D6]  DEFAULT (0) FOR [tercertramo]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Marge__652E7C0F]  DEFAULT (0) FOR [margeninst]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Carte__6622A048]  DEFAULT (0) FOR [carteralchr]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Total__6716C481]  DEFAULT (0) FOR [totalporfolio]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Porce__680AE8BA]  DEFAULT (0) FOR [porcentajelamina]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Total__68FF0CF3]  DEFAULT (0) FOR [totallamina]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Porce__69F3312C]  DEFAULT (0) FOR [porcentajecertif]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Total__6AE75565]  DEFAULT (0) FOR [totalcertif]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Riesg__6BDB799E]  DEFAULT (0) FOR [riesgoglobalinv]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Riesg__6CCF9DD7]  DEFAULT (0) FOR [riesgoglobaltotal]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Riesg__6DC3C210]  DEFAULT (0) FOR [riesgoglobalocupado]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Riesg__6EB7E649]  DEFAULT (0) FOR [riesgoglobaldisponi]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__CajaP__6FAC0A82]  DEFAULT (0) FOR [cajapesos]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__CajaB__70A02EBB]  DEFAULT (0) FOR [cajabcchpesos]
GO
ALTER TABLE [dbo].[VALOR_INSTITUCIONAL] ADD  CONSTRAINT [DF__VALOR_INS__Inver__719452F4]  DEFAULT (0) FOR [inversiones]
GO

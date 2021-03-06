USE [BacTraderSuda]
GO
/****** Object:  Table [bacuser].[PAGOS_FLI_ANULADO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[PAGOS_FLI_ANULADO](
	[PAFECPRO] [datetime] NOT NULL,
	[PARUTCART] [numeric](9, 0) NOT NULL,
	[PANUMDOCU] [numeric](10, 0) NOT NULL,
	[PACORRELA] [numeric](3, 0) NOT NULL,
	[PANUMOPER] [numeric](10, 0) NOT NULL,
	[PANUMPAGO] [numeric](3, 0) NOT NULL,
	[PAPTIPOPAGO] [char](1) NOT NULL,
	[PAINSTSER] [char](12) NOT NULL,
	[PACODIGO] [numeric](3, 0) NOT NULL,
	[PANOMINAL] [numeric](19, 4) NOT NULL,
	[PAVPRESEN] [numeric](19, 4) NOT NULL,
	[PATIPOBONO] [char](1) NOT NULL,
	[PACONDPACTO] [char](3) NOT NULL,
	[PAHORA] [char](15) NOT NULL,
	[PAUSUARIO] [char](12) NOT NULL,
	[PATERMINAL] [char](12) NOT NULL,
	[PASTATUS] [char](1) NOT NULL,
	[PAPAPELETA] [numeric](3, 0) NOT NULL,
	[PACONTRATO] [numeric](3, 0) NOT NULL,
	[PAMEDIODEPAGOI] [char](15) NOT NULL,
	[PAFECUCUP] [datetime] NOT NULL,
	[PAFECPCUP] [datetime] NOT NULL,
	[PADURAT] [float] NOT NULL,
	[PADURMOD] [float] NOT NULL,
	[PACONVEX] [float] NOT NULL,
	[PATIPOCARTERA] [numeric](2, 0) NOT NULL,
	[PAMONEMI] [numeric](3, 0) NOT NULL,
	[PAMONPACT] [numeric](3, 0) NOT NULL,
	[PAFORPAGI] [numeric](3, 0) NOT NULL,
	[PAREPROCESO] [char](1) NOT NULL,
	[PASWREPROCESO] [char](1) NOT NULL,
	[PACODORIGEN] [numeric](5, 0) NOT NULL,
	[PATIR] [numeric](9, 4) NOT NULL,
	[PVPVENT] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tbl_vc_arrendadas_detalle]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_vc_arrendadas_detalle](
	[Folio] [numeric](18, 0) NOT NULL,
	[Numdocu] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Nemotecnico] [varchar](12) NOT NULL,
	[Nominal] [numeric](19, 4) NOT NULL,
	[TIR] [numeric](19, 4) NOT NULL,
	[PVP] [numeric](19, 4) NOT NULL,
	[ValorPresente] [numeric](19, 4) NOT NULL,
	[ValorMercadoP] [numeric](19, 4) NOT NULL,
	[ValorMercadoH] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

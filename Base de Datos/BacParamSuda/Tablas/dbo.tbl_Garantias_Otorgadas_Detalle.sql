USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_Garantias_Otorgadas_Detalle]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Garantias_Otorgadas_Detalle](
	[Folio] [numeric](10, 0) NOT NULL,
	[Numdocu] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](3, 0) NOT NULL,
	[Nemotecnico] [varchar](12) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[TIR] [numeric](9, 4) NOT NULL,
	[VPAR] [numeric](10, 6) NOT NULL,
	[ValorPresente] [numeric](21, 4) NOT NULL,
	[TirMercado] [numeric](9, 4) NOT NULL,
	[ValorMercado] [numeric](21, 4) NOT NULL,
	[FactorMultiplicativo] [numeric](18, 4) NULL,
 CONSTRAINT [PK_tbl_Garantias_Otorgadas_Detalle_01] PRIMARY KEY CLUSTERED 
(
	[Folio] ASC,
	[Numdocu] ASC,
	[Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

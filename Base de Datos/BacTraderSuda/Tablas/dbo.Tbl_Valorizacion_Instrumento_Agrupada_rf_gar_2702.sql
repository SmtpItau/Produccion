USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Tbl_Valorizacion_Instrumento_Agrupada_rf_gar_2702]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada_rf_gar_2702](
	[Garantia_Numero] [numeric](9, 0) NOT NULL,
	[NumeroDocumento] [numeric](9, 0) NOT NULL,
	[CorrelativoDocumento] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](15) NOT NULL,
	[Mascara] [varchar](15) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Seriado] [char](1) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[Tir] [numeric](10, 4) NOT NULL,
	[ValorProceso] [numeric](21, 4) NOT NULL,
	[ValorProxProceso] [numeric](21, 4) NOT NULL,
	[CapitalCompra] [float] NOT NULL,
	[InteresCompra] [float] NOT NULL,
	[ReajusteCompra] [float] NOT NULL,
	[InteresAcumCp] [float] NOT NULL,
	[ReajusteAcumCp] [float] NOT NULL,
	[ValorCompra] [float] NOT NULL,
	[ValorCompraUm] [float] NOT NULL,
	[ValorCompraUm100] [float] NOT NULL,
	[ValorVencimiento] [float] NOT NULL,
	[Capital] [float] NOT NULL,
	[Interes] [float] NOT NULL,
	[Reajuste] [float] NOT NULL,
	[Interes_Mes] [float] NOT NULL,
	[Reajuste_Mes] [float] NOT NULL,
	[Interes_Acum] [float] NOT NULL,
	[Reajuste_Acum] [float] NOT NULL,
	[Amortizacion] [float] NOT NULL,
	[InteresCupon] [float] NOT NULL,
	[ReajusteCupon] [float] NOT NULL,
	[Flujo] [float] NOT NULL,
	[PrimaDescuento] [float] NOT NULL,
	[ValorTasaEmision] [float] NOT NULL,
	[Valorcompraum_original] [float] NOT NULL,
	[Valorcompraoriginal] [float] NOT NULL,
	[TasaMercado] [float] NOT NULL,
	[ValorMercado] [float] NOT NULL,
	[DiferenciaMercado] [float] NOT NULL
) ON [PRIMARY]
GO

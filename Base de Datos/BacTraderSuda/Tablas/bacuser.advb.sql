USE [BacTraderSuda]
GO
/****** Object:  Table [bacuser].[advb]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[advb](
	[capitalcompra] [numeric](38, 6) NULL,
	[valorcompraum] [numeric](38, 6) NULL,
	[ValorProceso] [numeric](38, 6) NULL,
	[ValorProxProceso] [numeric](38, 6) NULL,
	[interes_acum] [numeric](38, 6) NULL,
	[Reajuste_Acum] [numeric](38, 6) NULL,
	[InteresAcumCp] [numeric](38, 6) NULL,
	[reajusteacumcp] [numeric](38, 6) NULL,
	[interes] [numeric](38, 6) NULL,
	[Reajuste] [numeric](38, 6) NULL,
	[NumeroDocumento] [numeric](9, 0) NOT NULL,
	[CorrelativoDocumento] [numeric](9, 0) NOT NULL,
	[Garantia_Correlativo] [numeric](9, 0) NOT NULL,
	[Garantia_Numero] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO

USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[CntContabiliza]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CntContabiliza](
	[CntSisCod] [varchar](3) NOT NULL,
	[CntTipoMovimiento] [varchar](3) NOT NULL,
	[CntTipoOperacion] [varchar](5) NOT NULL,
	[CntInstrumento] [varchar](10) NOT NULL,
	[CntMoneda] [varchar](5) NOT NULL,
	[CntContrato] [numeric](10, 0) NOT NULL,
	[CntComponente] [numeric](8, 0) NOT NULL,
	[CntFolio] [numeric](10, 0) NOT NULL,
	[CntCarteraNormativa] [varchar](3) NULL,
	[CntSubCarteraNormativa] [varchar](3) NULL,
	[CntExtNacional] [numeric](1, 0) NULL,
	[CntFormaPagoRecibir] [numeric](5, 0) NULL,
	[CntFormaPagoEntregar] [numeric](5, 0) NULL,
	[CntCmpContraparteCartera] [numeric](5, 0) NULL,
	[CntValorStrike] [numeric](20, 4) NULL,
	[CntValorStrikeML] [numeric](20, 0) NULL,
	[CntSubyacente] [numeric](20, 4) NULL,
	[CntSubyacenteML] [numeric](20, 0) NULL,
	[CntPagarML] [numeric](20, 0) NULL,
	[CntRecibirML] [numeric](20, 0) NULL,
	[CntCompRecibirML] [numeric](20, 0) NULL,
	[CntCompPagarML] [numeric](20, 0) NULL,
	[CntCompPosImpML] [numeric](20, 0) NULL,
	[CntCompNegImpML] [numeric](20, 0) NULL,
	[CntAVRNegML] [numeric](20, 0) NULL,
	[CntAVRPosML] [numeric](20, 0) NULL,
	[CntReversoAVRNegML] [numeric](20, 0) NULL,
	[CntReversoAVRPosML] [numeric](20, 0) NULL,
	[CntPagar] [numeric](20, 4) NULL,
	[CntRecibir] [numeric](20, 4) NULL,
	[CntCompPagar] [numeric](20, 4) NULL,
	[CntCompRecibir] [numeric](20, 4) NULL,
	[CntUtiPrima] [numeric](20, 4) NULL,
	[CntUtiPrimaML] [numeric](20, 4) NULL,
	[CntPerPrima] [numeric](20, 4) NULL,
	[CntPerPrimaML] [numeric](20, 4) NULL,
	[CntRevRecibirML] [numeric](20, 4) NULL,
	[CntRevEntregarML] [numeric](20, 4) NULL,
	[CntRevRecibir] [numeric](20, 4) NULL,
	[CntRevEntregar] [numeric](20, 4) NULL,
	[CntEFisRevRecibirML] [numeric](20, 4) NULL,
	[CntEFisRevEntregarML] [numeric](20, 4) NULL,
	[CntBancoNoBanco] [numeric](1, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[CntSisCod] ASC,
	[CntTipoMovimiento] ASC,
	[CntTipoOperacion] ASC,
	[CntInstrumento] ASC,
	[CntMoneda] ASC,
	[CntContrato] ASC,
	[CntComponente] ASC,
	[CntFolio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

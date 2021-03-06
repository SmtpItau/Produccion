USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[MoEncContrato]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoEncContrato](
	[MoNumFolio] [numeric](8, 0) NOT NULL,
	[MoTipoTransaccion] [varchar](10) NULL,
	[MoNumContrato] [numeric](8, 0) NULL,
	[MoFechaContrato] [datetime] NULL,
	[MoEstado] [varchar](1) NULL,
	[MoCarteraFinanciera] [varchar](6) NULL,
	[MoLibro] [varchar](6) NULL,
	[MoCarNormativa] [varchar](6) NULL,
	[MoSubCarNormativa] [varchar](6) NULL,
	[MoRutCliente] [numeric](9, 0) NULL,
	[MoCodigo] [numeric](9, 0) NULL,
	[MoTipoContrapartida] [varchar](8) NULL,
	[MoOperador] [varchar](15) NULL,
	[MoCodEstructura] [varchar](10) NULL,
	[MoCVEstructura] [varchar](1) NULL,
	[MoSistema] [varchar](3) NULL,
	[MoMonPrimaTrf] [numeric](5, 0) NULL,
	[MoPrimaTrf] [float] NULL,
	[MoPrimaTrfML] [float] NULL,
	[MoMonPrimaCosto] [numeric](5, 0) NULL,
	[MoPrimaCosto] [float] NULL,
	[MoPrimaCostoML] [float] NULL,
	[MoCodMonPagPrima] [numeric](5, 0) NULL,
	[MoPrimaInicial] [float] NULL,
	[MofPagoPrima] [numeric](3, 0) NULL,
	[MoMonCarryPrima] [numeric](5, 0) NULL,
	[MoCarryPrima] [float] NULL,
	[MoParM2Spot] [float] NULL,
	[MoParMdaPrima] [float] NULL,
	[MoFechaPagoPrima] [datetime] NULL,
	[MoFecValorizacion] [datetime] NULL,
	[MoMon_vr] [numeric](5, 0) NULL,
	[MoVr] [float] NULL,
	[MoMondelta] [numeric](5, 0) NULL,
	[MoMon_gamma] [numeric](5, 0) NULL,
	[MoMon_vega] [numeric](5, 0) NULL,
	[MoMon_vanna] [numeric](5, 0) NULL,
	[MoMon_volga] [numeric](5, 0) NULL,
	[MoMon_theta] [numeric](5, 0) NULL,
	[MoMon_rho] [numeric](5, 0) NULL,
	[MoMon_rhof] [numeric](5, 0) NULL,
	[MoMon_charm] [numeric](5, 0) NULL,
	[MoMon_zomma] [numeric](5, 0) NULL,
	[MoMon_speed] [numeric](5, 0) NULL,
	[MoPrimaBSSpotCont] [float] NULL,
	[MoDeltaSpotCont] [float] NULL,
	[MoDeltaForwardCont] [float] NULL,
	[MoGammaSpotCont] [float] NULL,
	[MoVegaCont] [float] NULL,
	[MoVannaSpotCont] [float] NULL,
	[MoVolgaCont] [float] NULL,
	[MoThetaCont] [float] NULL,
	[MoRhoDomCont] [float] NULL,
	[MoRhoForCont] [float] NULL,
	[MoCharmSpotCont] [float] NULL,
	[MoZommaSpotCont] [float] NULL,
	[MoSpeedSpotCont] [float] NULL,
	[MoFechaUnwind] [datetime] NULL,
	[MoNominalUnwind] [numeric](21, 4) NULL,
	[MoUnwindMon] [numeric](5, 0) NULL,
	[MoUnwind] [numeric](21, 4) NULL,
	[MoUnwindML] [numeric](21, 4) NULL,
	[MoFormPagoUnwind] [numeric](3, 0) NULL,
	[MoUnwindTransfMon] [numeric](5, 0) NULL,
	[MoUnwindTransf] [numeric](21, 4) NULL,
	[MoUnwindTransfML] [numeric](21, 4) NULL,
	[MoVr_Costo] [float] NULL,
	[MoGlosa] [varchar](80) NULL,
	[MoUnwindCostoMon] [numeric](5, 0) NULL,
	[MoUnwindCosto] [numeric](21, 4) NULL,
	[MoUnwindCostoML] [numeric](21, 4) NULL,
	[MoGammaFwdCont] [float] NULL,
	[MoVannaFwdCont] [float] NULL,
	[MoCharmFwdCont] [float] NULL,
	[MoZommaFwdCont] [float] NULL,
	[MoSpeedFwdCont] [float] NULL,
	[MoImpreso] [varchar](1) NULL,
	[MoPrimaInicialML] [numeric](21, 4) NULL,
	[MoFechaCreacionRegistro] [datetime] NULL,
	[MoResultadoVentasML] [numeric](21, 4) NULL,
	[MoRelacionaPAE] [numeric](1, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MoNumFolio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MoEncContrato] ADD  CONSTRAINT [DF_MoEncContrato_MoRelacionaPAE]  DEFAULT ((0)) FOR [MoRelacionaPAE]
GO

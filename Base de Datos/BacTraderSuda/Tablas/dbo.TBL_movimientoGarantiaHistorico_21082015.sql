USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBL_movimientoGarantiaHistorico_21082015]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_movimientoGarantiaHistorico_21082015](
	[NumeroGarantia] [numeric](10, 0) NOT NULL,
	[CorrelativoGarantia] [numeric](10, 0) NOT NULL,
	[FechaIngresoGarantia] [datetime] NOT NULL,
	[IdEstadoGarantia] [int] NOT NULL,
	[FechaRespaldo] [datetime] NOT NULL,
	[FechaMovimiento] [datetime] NOT NULL,
	[HoraMovimientoGarantia] [datetime] NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[TipoMovimiento] [int] NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[CodigoCliente] [int] NOT NULL,
	[Instrumento] [varchar](12) NOT NULL,
	[Mascara] [varchar](12) NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[MonedaEmision] [numeric](3, 0) NOT NULL,
	[RutEmisor] [numeric](10, 0) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[TIR] [numeric](10, 4) NOT NULL,
	[VPAR] [numeric](10, 2) NOT NULL,
	[VPVP] [float] NOT NULL,
	[ValorPresente] [numeric](21, 0) NOT NULL,
	[ValorPresenteHaircut] [numeric](21, 0) NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL,
	[NumeroOperacionInstrumento] [numeric](10, 0) NOT NULL,
	[CorrelativoInstrumento] [numeric](10, 0) NOT NULL,
	[Haircut] [numeric](10, 4) NOT NULL,
	[ValorActualizadoCLP] [numeric](21, 7) NOT NULL,
	[ValorActualizadoUSD] [numeric](21, 7) NOT NULL,
	[TipoCambio] [numeric](8, 4) NOT NULL,
	[Paridad] [numeric](8, 4) NOT NULL,
	[IdEstadoMovimiento] [int] NOT NULL
) ON [PRIMARY]
GO

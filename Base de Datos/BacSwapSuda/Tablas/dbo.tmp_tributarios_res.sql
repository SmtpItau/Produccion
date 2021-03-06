USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[tmp_tributarios_res]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_tributarios_res](
	[FechaAnalisis] [datetime] NOT NULL,
	[FechaCierre] [datetime] NOT NULL,
	[FechaSuscripcion] [datetime] NOT NULL,
	[FechaLiquidacion] [datetime] NOT NULL,
	[FolioContrato] [numeric](21, 0) NOT NULL,
	[Correlativo] [numeric](21, 0) NOT NULL,
	[NewRegistro] [int] NOT NULL,
	[Origen] [char](3) NOT NULL,
	[TipoOperacion] [varchar](5) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[RutCliente] [numeric](15, 0) NOT NULL,
	[CodCliente] [numeric](15, 0) NOT NULL,
	[CtaAVR] [varchar](20) NOT NULL,
	[CtaPatrimonio] [varchar](20) NOT NULL,
	[CtaResultado] [varchar](20) NOT NULL,
	[CtaCaja] [varchar](20) NOT NULL,
	[nMontoAVRNeto] [numeric](21, 4) NOT NULL,
	[nMontoAVRProceso] [numeric](21, 4) NOT NULL,
	[nMontoCaja] [numeric](21, 4) NOT NULL,
	[nMontoPatrimonio] [numeric](21, 4) NOT NULL,
	[nMontoResultado] [numeric](21, 4) NOT NULL,
	[nMontoLiquidacion] [numeric](21, 4) NOT NULL,
	[nMontoSaldoAvrTermino] [numeric](21, 4) NOT NULL,
	[nSignoAvr] [char](1) NOT NULL,
	[iSaldo] [int] NOT NULL,
	[nMonedaOperacion] [int] NOT NULL,
	[nMonedaConversion] [int] NOT NULL
) ON [PRIMARY]
GO

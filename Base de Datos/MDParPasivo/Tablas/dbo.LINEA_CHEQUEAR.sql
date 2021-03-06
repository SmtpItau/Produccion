USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LINEA_CHEQUEAR]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_CHEQUEAR](
	[FechaOperacion] [datetime] NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Numerodocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[MontoTransaccion] [float] NOT NULL,
	[MontoOriginal] [float] NOT NULL,
	[TipoCambio] [float] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Rut_Emisor] [numeric](9, 0) NOT NULL,
	[Moneda_Emision] [numeric](3, 0) NOT NULL,
	[FechaVctoInst] [datetime] NOT NULL,
	[InCodigo] [numeric](5, 0) NOT NULL,
	[Seriado] [char](1) NOT NULL,
	[Compensacion] [char](1) NOT NULL,
	[Tipo_Riesgo] [char](1) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[Pago_Cheque] [char](1) NOT NULL,
	[Rut_Cheque] [numeric](9, 0) NOT NULL,
	[FechaVctoCheque] [datetime] NOT NULL,
	[FactorVenta] [numeric](19, 8) NOT NULL,
	[FormaPago] [numeric](3, 0) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Moneda2] [numeric](3, 0) NULL,
	[Moneda1] [numeric](5, 0) NOT NULL,
	[nCorrelativoFRP] [int] NOT NULL,
	[MontoMX2] [float] NOT NULL
) ON [PRIMARY]
GO

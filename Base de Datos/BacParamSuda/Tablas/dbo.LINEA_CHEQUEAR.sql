USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_CHEQUEAR]    Script Date: 13-05-2022 10:58:09 ******/
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
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[TipoCambio] [numeric](19, 4) NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Rut_Emisor] [numeric](9, 0) NOT NULL,
	[Moneda_Emision] [numeric](3, 0) NOT NULL,
	[FechaVctoInst] [datetime] NOT NULL,
	[InCodigo] [numeric](5, 0) NOT NULL,
	[Seriado] [char](1) NOT NULL,
	[MonedaOperacion] [numeric](5, 0) NOT NULL,
	[Tipo_Riesgo] [char](1) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[Pago_Cheque] [char](1) NOT NULL,
	[Rut_Cheque] [numeric](9, 0) NOT NULL,
	[FechaVctoCheque] [datetime] NOT NULL,
	[FactorVenta] [numeric](19, 8) NOT NULL,
	[Cod_Emisor] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF__LINEA_CHE__Cod_E__10A54BFE]  DEFAULT (0) FOR [Cod_Emisor]
GO

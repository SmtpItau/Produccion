USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_CHEQUEAR]    Script Date: 13-05-2022 10:44:28 ******/
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
	[Cod_Emisor] [numeric](9, 0) NOT NULL,
	[FormaPago] [numeric](3, 0) NOT NULL,
	[Tir] [float] NOT NULL,
	[TasaPacto] [float] NOT NULL,
	[Instser] [char](12) NOT NULL,
	[Avr] [numeric](15, 0) NULL,
	[PrcLCR] [float] NULL,
	[Resultado] [float] NULL,
	[MetodoLCR] [numeric](5, 0) NOT NULL,
	[Garantia] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF__LINEA_CHE__Cod_E__10A54BFE]  DEFAULT (0) FOR [Cod_Emisor]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF__linea_che__Forma__4A7CE7D8]  DEFAULT (0) FOR [FormaPago]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF_LINEA_CHEQUEAR_TasaTir]  DEFAULT (0) FOR [Tir]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF_LINEA_CHEQUEAR_TasaPacto]  DEFAULT (0) FOR [TasaPacto]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF_LINEA_CHEQUEAR_Instser]  DEFAULT ('') FOR [Instser]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  DEFAULT (0) FOR [Avr]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  DEFAULT (0.0) FOR [PrcLCR]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  DEFAULT (0.0) FOR [Resultado]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF_LINEA_CHEQUEAR_MetodoLCR]  DEFAULT ((0)) FOR [MetodoLCR]
GO
ALTER TABLE [dbo].[LINEA_CHEQUEAR] ADD  CONSTRAINT [DF_LINEA_CHEQUEAR_Garantia]  DEFAULT ((0)) FOR [Garantia]
GO

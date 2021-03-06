USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[cartera_c08]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartera_c08](
	[Numero_Operacion] [numeric](7, 0) NOT NULL,
	[Numero_Flujo] [numeric](3, 0) NOT NULL,
	[Tipo_Flujo] [numeric](1, 0) NOT NULL,
	[Tipo_Swap] [numeric](1, 0) NOT NULL,
	[Fecha_Inicio_Flujo] [datetime] NOT NULL,
	[Fecha_Vence_Flujo] [datetime] NOT NULL,
	[Fecha_Inicio] [datetime] NOT NULL,
	[fecha_fijacion_tasa] [datetime] NOT NULL,
	[Compra_capital] [numeric](19, 4) NOT NULL,
	[Compra_Amortiza] [numeric](19, 4) NOT NULL,
	[Compra_Saldo] [numeric](19, 4) NOT NULL,
	[Compra_Moneda] [numeric](3, 0) NOT NULL,
	[Compra_Interes] [numeric](19, 4) NOT NULL,
	[Compra_Codigo_Tasa] [numeric](3, 0) NOT NULL,
	[Compra_Valor_tasa] [numeric](10, 6) NOT NULL,
	[Compra_Base] [numeric](3, 0) NOT NULL,
	[Compra_Spread] [numeric](10, 6) NOT NULL,
	[Venta_capital] [numeric](19, 4) NOT NULL,
	[Venta_Amortiza] [numeric](19, 4) NOT NULL,
	[Venta_Saldo] [numeric](19, 4) NOT NULL,
	[Venta_Moneda] [numeric](3, 0) NOT NULL,
	[Venta_Interes] [numeric](19, 4) NOT NULL,
	[Venta_Codigo_Tasa] [numeric](3, 0) NOT NULL,
	[Venta_Valor_tasa] [numeric](10, 6) NOT NULL,
	[Venta_Base] [numeric](3, 0) NOT NULL,
	[Venta_Spread] [numeric](10, 6) NOT NULL,
	[Plazo] [numeric](5, 0) NULL,
	[DiasBase] [numeric](5, 0) NULL,
	[TasaMTM] [numeric](12, 8) NULL,
	[MontoC08] [numeric](19, 4) NULL,
	[ValorParMon] [numeric](19, 4) NULL,
	[MontoC08CLP] [numeric](19, 0) NULL,
	[Marca] [varchar](1) NOT NULL,
	[PeriodoInt] [numeric](12, 10) NULL,
	[PeriodoIntReal] [numeric](9, 0) NULL,
	[Estado_Flujo] [numeric](1, 0) NOT NULL,
	[Compra_Flujo_Adicional] [float] NOT NULL,
	[Venta_Flujo_Adicional] [float] NOT NULL,
	[IntercPrinc] [int] NOT NULL,
	[FechaLiquidacion] [datetime] NOT NULL,
	[Fecha_Termino] [datetime] NOT NULL,
	[Dias_Reset] [int] NOT NULL,
	[FeriadoFlujoChile] [int] NOT NULL,
	[FeriadoFlujoEEUU] [int] NOT NULL,
	[FeriadoFlujoEnglan] [int] NOT NULL,
	[OrigenCurva] [char](2) NOT NULL,
	[registrocorrelativo] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO

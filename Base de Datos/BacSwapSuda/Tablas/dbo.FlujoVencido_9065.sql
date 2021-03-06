USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[FlujoVencido_9065]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlujoVencido_9065](
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[Fecha_Cierre] [datetime] NOT NULL,
	[Fecha_inicio_flujo] [datetime] NOT NULL,
	[fecha_vence_flujo] [datetime] NOT NULL,
	[compra_capital] [numeric](19, 4) NOT NULL,
	[compra_amortiza] [numeric](19, 4) NOT NULL,
	[compra_interes] [numeric](19, 4) NOT NULL,
	[compra_saldo] [numeric](19, 4) NOT NULL,
	[compra_Flujo_Adicional] [float] NOT NULL,
	[venta_capital] [numeric](19, 4) NOT NULL,
	[venta_amortiza] [numeric](19, 4) NOT NULL,
	[venta_interes] [numeric](19, 4) NOT NULL,
	[venta_saldo] [numeric](19, 4) NOT NULL,
	[venta_Flujo_Adicional] [float] NOT NULL
) ON [PRIMARY]
GO

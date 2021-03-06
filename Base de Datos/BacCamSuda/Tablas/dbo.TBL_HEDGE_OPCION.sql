USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_OPCION]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_OPCION](
	[fecha_proceso] [datetime] NOT NULL,
	[numero_contrato] [numeric](8, 0) NOT NULL,
	[numero_componente] [numeric](6, 0) NOT NULL,
	[vinculacion] [varchar](15) NOT NULL,
	[tipo_opcion] [varchar](15) NOT NULL,
	[subyacente] [varchar](5) NOT NULL,
	[payoff] [varchar](15) NOT NULL,
	[compra_venta] [varchar](3) NOT NULL,
	[vencimiento] [datetime] NOT NULL,
	[par_monedas] [varchar](7) NOT NULL,
	[moneda_1] [numeric](5, 0) NOT NULL,
	[monto_1] [numeric](21, 6) NOT NULL,
	[moneda_2] [numeric](5, 0) NOT NULL,
	[monto_2] [numeric](21, 6) NOT NULL,
	[strike] [float] NOT NULL,
	[modalidad] [varchar](1) NOT NULL,
	[moneda_comp] [numeric](5, 0) NOT NULL,
	[tipo_ejercicio] [varchar](2) NOT NULL,
	[valor_mercado_clp] [numeric](21, 4) NOT NULL,
	[delta_usd] [float] NOT NULL
) ON [PRIMARY]
GO

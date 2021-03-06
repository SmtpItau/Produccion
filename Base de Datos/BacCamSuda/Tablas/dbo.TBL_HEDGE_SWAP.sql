USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_SWAP]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_SWAP](
	[fecha_Proceso] [datetime] NOT NULL,
	[numero_operacion] [numeric](5, 0) NOT NULL,
	[tipo_flujo] [numeric](5, 0) NOT NULL,
	[tipo_swap] [numeric](5, 0) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[Clnombre] [char](70) NOT NULL,
	[compra_moneda] [numeric](19, 4) NOT NULL,
	[venta_moneda] [numeric](19, 4) NOT NULL,
	[compra_mercado_clp] [numeric](19, 4) NOT NULL,
	[venta_mercado_clp] [numeric](19, 4) NOT NULL,
	[operador] [char](10) NOT NULL
) ON [PRIMARY]
GO

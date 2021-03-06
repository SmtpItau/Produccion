USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_CUENTA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_CUENTA](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_moneda1] [numeric](5, 0) NOT NULL,
	[codigo_moneda2] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](12) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[tipo_emisor] [char](3) NOT NULL,
	[codigo_plazo] [char](3) NOT NULL,
	[tipo_cliente] [numeric](5, 0) NOT NULL,
	[modalidad] [char](1) NOT NULL,
	[tipo_mercado] [numeric](5, 0) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Forma_Pago] [numeric](2, 0) NOT NULL,
	[descripcion] [varchar](80) NOT NULL,
	[cuenta_capital] [char](12) NOT NULL,
	[cuenta_interes] [char](12) NOT NULL,
	[cuenta_reajuste] [char](12) NOT NULL,
	[cuenta_res_interes] [char](12) NOT NULL,
	[cuenta_res_reajuste] [char](12) NOT NULL,
	[producto_interfaz] [char](5) NOT NULL,
	[cuenta_p17] [char](12) NOT NULL,
	[producto_p17] [char](10) NOT NULL,
	[codigo_p17] [char](10) NOT NULL,
	[moneda_contable] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

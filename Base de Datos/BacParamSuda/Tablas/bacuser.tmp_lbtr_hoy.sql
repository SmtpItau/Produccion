USE [BacParamSuda]
GO
/****** Object:  Table [bacuser].[tmp_lbtr_hoy]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[tmp_lbtr_hoy](
	[fecha] [datetime] NOT NULL,
	[sistema] [char](3) NOT NULL,
	[tipo_mercado] [char](12) NOT NULL,
	[tipo_operacion] [char](6) NOT NULL,
	[estado_envio] [char](1) NOT NULL,
	[numero_operacion] [numeric](9, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[moneda] [numeric](5, 0) NOT NULL,
	[monto_operacion] [numeric](21, 4) NOT NULL,
	[forma_pago] [numeric](5, 0) NOT NULL,
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[liquidada] [char](1) NOT NULL,
	[RecRutBanco] [numeric](10, 0) NULL,
	[RecCodBanco] [numeric](10, 0) NULL,
	[RecCodSwift] [varchar](20) NULL,
	[RecDireccion] [varchar](70) NULL,
	[RecCtaCte] [varchar](20) NULL,
	[Tipo_Movimiento] [char](1) NOT NULL,
	[GlosaAnticipo] [varchar](150) NULL
) ON [PRIMARY]
GO

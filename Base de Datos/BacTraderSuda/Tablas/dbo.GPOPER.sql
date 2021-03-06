USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GPOPER]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPOPER](
	[fecha_pago] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](10, 0) NOT NULL,
	[tipo_movimiento] [char](1) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_rut] [numeric](3, 0) NOT NULL,
	[monto_operacion] [float] NOT NULL,
	[moneda] [char](3) NOT NULL,
	[numero_documento] [numeric](10, 0) NOT NULL,
	[forma_pago] [char](4) NOT NULL,
	[nombre_cliente] [char](40) NOT NULL,
	[estado] [char](1) NOT NULL,
	[tipo_canje] [char](1) NOT NULL,
	[codigo_banco] [numeric](3, 0) NULL,
	[fecha_cobro] [datetime] NULL,
	[glosa] [char](40) NULL,
	[tipo_ingreso] [char](1) NULL,
	[correla_pago] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

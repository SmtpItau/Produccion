USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CARTERA_MANUAL]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_MANUAL](
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[producto] [char](5) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_vence] [datetime] NOT NULL,
	[monto_operacion] [numeric](21, 4) NOT NULL,
	[moneda_primaria] [numeric](3, 0) NOT NULL,
	[moneda_secundaria] [numeric](3, 0) NOT NULL,
	[modalidad_pago] [char](1) NOT NULL,
	[fecha_proceso] [datetime] NOT NULL
) ON [PRIMARY]
GO

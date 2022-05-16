USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CARTERA_LINEAS_STAR]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_LINEAS_STAR](
	[fecha_proceso] [datetime] NOT NULL,
	[id_sistema] [char](5) NOT NULL,
	[producto] [char](5) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[numero_operacion_STAR] [numeric](10, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_vence] [datetime] NOT NULL,
	[monto_operacion] [numeric](21, 4) NOT NULL,
	[moneda_primaria] [numeric](3, 0) NOT NULL,
	[moneda_secundaria] [numeric](3, 0) NOT NULL,
	[modalidad_pago] [char](1) NOT NULL
) ON [PRIMARY]
GO

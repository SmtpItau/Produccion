USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[GESTION_TESORERIA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GESTION_TESORERIA](
	[id_sistema] [char](3) NOT NULL,
	[codigo_familia] [numeric](4, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[activo_pasivo] [char](7) NOT NULL,
	[tipo_cartera] [char](25) NOT NULL,
	[sub_grupo] [char](60) NOT NULL,
	[forma_pago_ini] [numeric](3, 0) NOT NULL,
	[foma_pago_fin] [numeric](3, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL
) ON [PRIMARY]
GO

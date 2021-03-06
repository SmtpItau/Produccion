USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LINEA_TRANSACCION_DETALLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TRANSACCION_DETALLE](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[NumeroCorre_Detalle] [numeric](10, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_Grupo] [char](10) NOT NULL,
	[Tipo_Detalle] [varchar](1) NOT NULL,
	[Tipo_Movimiento] [varchar](1) NOT NULL,
	[Linea_Transsaccion] [varchar](6) NOT NULL,
	[MontoTransaccion] [float] NOT NULL,
	[MontoExceso] [float] NOT NULL,
	[PlazoDesde] [numeric](5, 0) NOT NULL,
	[PlazoHasta] [numeric](5, 0) NOT NULL,
	[Actualizo_Linea] [varchar](1) NOT NULL,
	[Error] [varchar](1) NOT NULL,
	[codigo_excepcion] [char](2) NOT NULL,
	[Mensaje_Error] [varchar](255) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

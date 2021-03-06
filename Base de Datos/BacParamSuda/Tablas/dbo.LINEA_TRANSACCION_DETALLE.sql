USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_TRANSACCION_DETALLE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TRANSACCION_DETALLE](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[NumeroCorre_Detalle] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Tipo_Detalle] [varchar](1) NOT NULL,
	[Tipo_Movimiento] [varchar](1) NOT NULL,
	[Linea_Transsaccion] [varchar](6) NOT NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[MontoExceso] [numeric](19, 4) NOT NULL,
	[PlazoDesde] [numeric](5, 0) NOT NULL,
	[PlazoHasta] [numeric](5, 0) NOT NULL,
	[Actualizo_Linea] [varchar](1) NOT NULL,
	[Error] [varchar](1) NOT NULL,
	[Mensaje_Error] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumeroOperacion] ASC,
	[NumeroDocumento] ASC,
	[NumeroCorrelativo] ASC,
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC,
	[Id_Sistema] ASC,
	[NumeroCorre_Detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Tipo___47FFA289]  DEFAULT ('') FOR [Tipo_Detalle]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Tipo___48F3C6C2]  DEFAULT ('') FOR [Tipo_Movimiento]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Linea__49E7EAFB]  DEFAULT ('') FOR [Linea_Transsaccion]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Monto__4ADC0F34]  DEFAULT (0) FOR [MontoTransaccion]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Monto__4BD0336D]  DEFAULT (0) FOR [MontoExceso]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Actua__4CC457A6]  DEFAULT ('') FOR [Actualizo_Linea]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Error__4DB87BDF]  DEFAULT ('') FOR [Error]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__Mensa__4EACA018]  DEFAULT ('') FOR [Mensaje_Error]
GO

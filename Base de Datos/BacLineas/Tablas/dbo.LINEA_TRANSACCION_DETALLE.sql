USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_TRANSACCION_DETALLE]    Script Date: 13-05-2022 10:44:29 ******/
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
	[Error] [varchar](1) NULL,
	[Mensaje_Error] [varchar](255) NULL,
	[moneda] [numeric](5, 0) NOT NULL,
	[forma_pago] [numeric](3, 0) NOT NULL,
	[Grupo_Emisor] [char](5) NULL,
	[instrumento] [numeric](5, 0) NULL,
 CONSTRAINT [PK__LINEA_TRANSACCIO__3D77F275] PRIMARY KEY CLUSTERED 
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
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__moned__618048C1]  DEFAULT (0) FOR [moneda]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF__LINEA_TRA__forma__62746CFA]  DEFAULT (0) FOR [forma_pago]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  CONSTRAINT [DF_LINEA_TRANSACCION_DETALLE_Grupo_Emisor]  DEFAULT ('') FOR [Grupo_Emisor]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION_DETALLE] ADD  DEFAULT (0) FOR [instrumento]
GO

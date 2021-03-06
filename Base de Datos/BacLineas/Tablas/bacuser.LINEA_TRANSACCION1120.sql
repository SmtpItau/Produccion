USE [BacLineas]
GO
/****** Object:  Table [bacuser].[LINEA_TRANSACCION1120]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[LINEA_TRANSACCION1120](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Tipo_Operacion] [varchar](2) NOT NULL,
	[Tipo_Riesgo] [varchar](1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[MontoOriginal] [numeric](19, 4) NOT NULL,
	[TipoCambio] [numeric](8, 4) NOT NULL,
	[MatrizRiesgo] [numeric](8, 4) NOT NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Activo] [char](1) NOT NULL,
	[APROBACION1] [char](15) NOT NULL,
	[APROBACION2] [char](15) NOT NULL,
	[APROBACION3] [char](15) NOT NULL,
	[APROBACION4] [char](15) NOT NULL,
	[Resultado] [float] NOT NULL,
	[MetodoLCR] [numeric](5, 0) NOT NULL,
	[Garantia] [float] NOT NULL
) ON [PRIMARY]
GO

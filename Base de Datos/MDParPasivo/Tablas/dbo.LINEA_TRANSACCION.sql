USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LINEA_TRANSACCION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TRANSACCION](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Grupo] [char](10) NOT NULL,
	[Tipo_Operacion] [varchar](2) NOT NULL,
	[Tipo_Riesgo] [varchar](1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[MontoOriginal] [float] NOT NULL,
	[TipoCambio] [float] NOT NULL,
	[MatrizRiesgo] [numeric](8, 4) NOT NULL,
	[MontoTransaccion] [float] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Activo] [char](1) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LIMITE_TRANSACCION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TRANSACCION](
	[FechaOperacion] [datetime] NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[InCodigo] [numeric](5, 0) NOT NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Check_Operacion] [varchar](1) NOT NULL,
	[Check_Instrumento] [varchar](1) NOT NULL,
	[Tipo_control] [char](10) NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

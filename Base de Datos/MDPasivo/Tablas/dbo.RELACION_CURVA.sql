USE [MDPasivo]
GO
/****** Object:  Table [dbo].[RELACION_CURVA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_CURVA](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Tipo_Operacion] [char](1) NOT NULL,
	[Codigo_Instrumento] [numeric](5, 0) NOT NULL,
	[Codigo_Moneda1] [numeric](5, 0) NOT NULL,
	[Codigo_Moneda2] [numeric](5, 0) NOT NULL,
	[Rut_Emisor] [numeric](9, 0) NOT NULL,
	[Codigo_Emisor] [numeric](5, 0) NOT NULL,
	[Codigo_Curva] [char](15) NOT NULL,
	[Plazo_Desde] [numeric](10, 4) NOT NULL,
	[Plazo_Hasta] [numeric](10, 4) NOT NULL,
	[Evento] [char](1) NOT NULL,
	[Defecto] [char](1) NOT NULL,
	[Rango_por] [char](1) NOT NULL,
	[Area] [char](5) NOT NULL
) ON [PRIMARY]
GO

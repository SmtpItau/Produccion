USE [BacLineas]
GO
/****** Object:  Table [bacuser].[LINEA_PRODUCTO_POR_PLAZO0621]    Script Date: 13-05-2022 10:44:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[LINEA_PRODUCTO_POR_PLAZO0621](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[incodigo] [numeric](5, 0) NULL,
	[mncodmon] [numeric](5, 0) NOT NULL,
	[codigo] [numeric](3, 0) NOT NULL,
	[plazodesde] [numeric](5, 0) NOT NULL,
	[Plazohasta] [numeric](5, 0) NOT NULL,
	[Porcentaje] [numeric](8, 4) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

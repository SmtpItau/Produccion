USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_PRODUCTO_POR_PLAZO]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_PRODUCTO_POR_PLAZO](
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
ALTER TABLE [dbo].[LINEA_PRODUCTO_POR_PLAZO]  WITH NOCHECK ADD  CONSTRAINT [FK__LINEA_PRODUCTO_P__1B02DEE0] FOREIGN KEY([Id_Sistema], [Codigo_Producto])
REFERENCES [dbo].[PRODUCTO_SISTEMA] ([Id_Sistema], [Codigo_Producto])
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO_POR_PLAZO] CHECK CONSTRAINT [FK__LINEA_PRODUCTO_P__1B02DEE0]
GO

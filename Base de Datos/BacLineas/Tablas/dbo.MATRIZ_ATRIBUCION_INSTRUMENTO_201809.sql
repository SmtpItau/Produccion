USE [BacLineas]
GO
/****** Object:  Table [dbo].[MATRIZ_ATRIBUCION_INSTRUMENTO_201809]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATRIZ_ATRIBUCION_INSTRUMENTO_201809](
	[Usuario] [char](15) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[Monto_Maximo_Operacion] [numeric](19, 4) NOT NULL,
	[Monto_Maximo_Acumulado] [numeric](19, 4) NOT NULL,
	[Acumulado_Diario] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

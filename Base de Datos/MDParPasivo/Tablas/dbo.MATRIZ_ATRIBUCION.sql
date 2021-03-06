USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MATRIZ_ATRIBUCION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATRIZ_ATRIBUCION](
	[tipo_usuario] [char](15) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[MontoInicio] [numeric](19, 4) NOT NULL,
	[MontoFinal] [numeric](19, 4) NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL,
	[InCodigo] [numeric](5, 0) NOT NULL,
	[Codigo_Control] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MATRIZ_ATRIBUCION] ADD  CONSTRAINT [DF_MATRIZ_ATRIBUCION_CODIGO_CONTROL]  DEFAULT ('') FOR [Codigo_Control]
GO

USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[matriz_atribucion_instrumento_paso]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matriz_atribucion_instrumento_paso](
	[Usuario] [char](15) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Incodigo] [numeric](3, 0) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[MontoInicio] [numeric](19, 4) NOT NULL,
	[MontoFinal] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

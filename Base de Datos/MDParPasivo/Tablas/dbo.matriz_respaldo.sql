USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[matriz_respaldo]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matriz_respaldo](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_instrumento] [numeric](5, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[codigo_moneda2] [numeric](5, 0) NOT NULL,
	[dias_grupo_desde] [numeric](6, 0) NOT NULL,
	[dias_grupo_hasta] [numeric](6, 0) NOT NULL,
	[dias_desde] [numeric](6, 0) NOT NULL,
	[dias_hasta] [numeric](6, 0) NOT NULL,
	[porcentaje] [float] NOT NULL
) ON [PRIMARY]
GO

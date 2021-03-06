USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PORCENTAJE_COMPUTABLE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PORCENTAJE_COMPUTABLE](
	[codigo_intervalo] [numeric](5, 0) NOT NULL,
	[codigo_canasta] [numeric](5, 0) NOT NULL,
	[rango_desde] [char](6) NOT NULL,
	[rango_hasta] [char](6) NOT NULL,
	[porcentaje] [numeric](10, 4) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[id_Sistema] [char](3) NOT NULL
) ON [PRIMARY]
GO

USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TASAS_MAXIMAS_CONVENCIONAL]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASAS_MAXIMAS_CONVENCIONAL](
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_Moneda] [numeric](5, 0) NOT NULL,
	[DiasDesde] [numeric](5, 0) NOT NULL,
	[DiasHasta] [numeric](5, 0) NOT NULL,
	[MontoMinimo] [numeric](19, 4) NOT NULL,
	[MontoMaximo] [numeric](19, 4) NOT NULL,
	[TasaMinima] [numeric](8, 4) NOT NULL,
	[TasaMaxima] [numeric](8, 4) NOT NULL
) ON [PRIMARY]
GO

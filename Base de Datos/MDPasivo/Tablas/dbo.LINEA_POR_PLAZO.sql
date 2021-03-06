USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LINEA_POR_PLAZO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_POR_PLAZO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[PlazoDesde] [numeric](5, 0) NOT NULL,
	[PlazoHasta] [numeric](5, 0) NOT NULL,
	[Porcentaje] [numeric](8, 4) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL,
	[ConRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[ConRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[ConRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[ConRiesgoExceso] [numeric](19, 4) NOT NULL,
	[SinRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[SinRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[SinRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[SinRiesgoExceso] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

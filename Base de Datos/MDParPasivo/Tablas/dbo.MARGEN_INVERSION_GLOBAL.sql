USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MARGEN_INVERSION_GLOBAL]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARGEN_INVERSION_GLOBAL](
	[rut_cartera] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [varchar](5) NOT NULL,
	[seriado] [char](1) NOT NULL,
	[plazo_desde] [numeric](7, 0) NOT NULL,
	[plazo_hasta] [numeric](7, 0) NOT NULL,
	[porcentaje_asignado] [numeric](8, 4) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

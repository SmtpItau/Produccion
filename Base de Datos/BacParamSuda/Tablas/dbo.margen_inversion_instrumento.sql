USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[margen_inversion_instrumento]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[margen_inversion_instrumento](
	[rut_cartera] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[instrumento] [numeric](3, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[porcentaje_asignado] [numeric](8, 4) NOT NULL,
	[porcentaje_adicional] [numeric](8, 4) NOT NULL,
	[porcentaje_utilizado] [numeric](8, 4) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalAdicional] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO

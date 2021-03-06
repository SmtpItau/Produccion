USE [BacLineas]
GO
/****** Object:  Table [bacuser].[LINEA_GENERAL0106]    Script Date: 13-05-2022 10:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[LINEA_GENERAL0106](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[FechaAsignacion] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[FechaFinContrato] [datetime] NOT NULL,
	[Bloqueado] [varchar](1) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[Monto_Linea_Threshold] [numeric](19, 4) NOT NULL,
	[iMonedaThreshold] [smallint] NOT NULL
) ON [PRIMARY]
GO

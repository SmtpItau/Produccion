USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_GENERAL]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_GENERAL](
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
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  CONSTRAINT [DF_LINEA_GENERAL_moneda]  DEFAULT (' ') FOR [Moneda]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  DEFAULT (0) FOR [Monto_Linea_Threshold]
GO
ALTER TABLE [dbo].[LINEA_GENERAL] ADD  DEFAULT ((13)) FOR [iMonedaThreshold]
GO

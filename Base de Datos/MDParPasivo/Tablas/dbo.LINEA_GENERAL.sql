USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LINEA_GENERAL]    Script Date: 16-05-2022 11:12:33 ******/
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
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL,
	[RutCasaMatriz] [numeric](9, 0) NOT NULL,
	[CodigoCasaMatriz] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO

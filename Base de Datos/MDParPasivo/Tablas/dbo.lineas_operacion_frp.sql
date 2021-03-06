USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[lineas_operacion_frp]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lineas_operacion_frp](
	[NumeroOperacion] [numeric](19, 0) NOT NULL,
	[NumeroDocumento] [numeric](19, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](19, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Grupo] [char](10) NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Factor_Riesgo] [numeric](18, 4) NOT NULL,
	[CorrelativoFrp] [int] NOT NULL
) ON [PRIMARY]
GO

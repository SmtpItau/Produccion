USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[INVERSION_EXTERIOR_DETALLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVERSION_EXTERIOR_DETALLE](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[TipodeOperacion] [varchar](5) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaFinal] [datetime] NOT NULL,
	[MontoOperacion] [numeric](19, 0) NOT NULL,
	[Usuario] [varchar](10) NOT NULL
) ON [PRIMARY]
GO

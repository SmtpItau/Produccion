USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_Detalle_Pactos]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_Detalle_Pactos](
	[IDDetalleParametros] [int] IDENTITY(1,1) NOT NULL,
	[Sistema] [varchar](50) NOT NULL,
	[CodIBS] [int] NOT NULL,
	[Cartera] [varchar](50) NOT NULL,
	[Moneda] [varchar](10) NOT NULL,
	[Serie] [varchar](10) NOT NULL,
	[TipoCliente] [int] NULL,
	[TipoCriterio] [int] NOT NULL
) ON [Reportes_Data_01]
GO

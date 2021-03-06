USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_Detalle_RentaFija]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_Detalle_RentaFija](
	[IDDetalleParametros] [int] IDENTITY(1,1) NOT NULL,
	[Sistema] [varchar](50) NULL,
	[CodIBS] [int] NULL,
	[Cartera] [char](1) NULL,
	[TipoInstrumento] [varchar](10) NULL,
	[Moneda] [varchar](10) NULL,
	[TipoEmisor] [int] NULL,
	[TipoCriterio] [int] NOT NULL
) ON [Reportes_Data_01]
GO

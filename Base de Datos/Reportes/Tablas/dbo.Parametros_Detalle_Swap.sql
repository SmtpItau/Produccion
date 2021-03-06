USE [Reportes]
GO
/****** Object:  Table [dbo].[Parametros_Detalle_Swap]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parametros_Detalle_Swap](
	[IDDetalleParametros] [int] IDENTITY(1,1) NOT NULL,
	[Sistema] [varchar](50) NULL,
	[CodIBS] [int] NOT NULL,
	[TipoSwap] [int] NOT NULL,
	[MonedaActiva] [varchar](10) NOT NULL,
	[MonedaPasiva] [varchar](10) NOT NULL,
	[CarteraNormativa] [char](1) NOT NULL,
	[TipoCriterio] [int] NOT NULL
) ON [Reportes_Data_01]
GO

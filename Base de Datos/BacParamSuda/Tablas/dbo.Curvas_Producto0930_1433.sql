USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Curvas_Producto0930_1433]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curvas_Producto0930_1433](
	[CodigoCurva] [varchar](20) NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Instrumento] [varchar](20) NOT NULL,
	[Emisor] [varchar](10) NOT NULL,
	[CurAlter] [varchar](20) NOT NULL,
	[Spread] [char](1) NOT NULL,
	[CurSpread] [varchar](20) NOT NULL,
	[TasaDesde] [float] NOT NULL,
	[TasaHasta] [float] NOT NULL,
	[TipoTasa] [char](1) NOT NULL,
	[TipoBase] [int] NOT NULL,
	[Indicador] [int] NOT NULL
) ON [PRIMARY]
GO

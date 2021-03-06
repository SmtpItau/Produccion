USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CURVAS_PRODUCTO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVAS_PRODUCTO](
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
	[Indicador] [int] NOT NULL,
	[CURVA_SAT] [nvarchar](50) NOT NULL,
 CONSTRAINT [Pk_CurvasProducto] PRIMARY KEY CLUSTERED 
(
	[CodigoCurva] ASC,
	[Modulo] ASC,
	[Producto] ASC,
	[Moneda] ASC,
	[Instrumento] ASC,
	[Emisor] ASC,
	[TasaDesde] ASC,
	[TasaHasta] ASC,
	[TipoTasa] ASC,
	[TipoBase] ASC,
	[Indicador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Curva]  DEFAULT ('') FOR [CodigoCurva]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Instrumento]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Emisor]  DEFAULT ('') FOR [Emisor]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_CurAlternativa]  DEFAULT ('*') FOR [CurAlter]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Spread]  DEFAULT ('N') FOR [Spread]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_CurvSpread]  DEFAULT ('*') FOR [CurSpread]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_TDesde]  DEFAULT (0.0) FOR [TasaDesde]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Thasta]  DEFAULT (0.0) FOR [TasaHasta]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Tiptasa]  DEFAULT ('N') FOR [TipoTasa]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [dfCurvasProd_Tipbase]  DEFAULT (0) FOR [TipoBase]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [df_CurvasProd_Indicador]  DEFAULT ((-1)) FOR [Indicador]
GO
ALTER TABLE [dbo].[CURVAS_PRODUCTO] ADD  CONSTRAINT [CURVA_SAT]  DEFAULT ('') FOR [CURVA_SAT]
GO

USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_DESCALCE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_DESCALCE](
	[Codigo] [numeric](3, 0) NOT NULL,
	[Glosa] [char](25) NULL,
	[Afecta_Posicion_Contable] [char](1) NULL,
	[Afecta_Descalce_Tc] [char](1) NULL,
	[Codigo_Producto] [char](5) NULL,
	[afecta_contable] [char](1) NOT NULL,
	[codigo_comercio] [char](1) NOT NULL
) ON [PRIMARY]
GO

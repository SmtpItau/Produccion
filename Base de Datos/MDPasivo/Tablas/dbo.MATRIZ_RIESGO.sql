USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MATRIZ_RIESGO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MATRIZ_RIESGO](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_instrumento] [numeric](5, 0) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[codigo_moneda2] [numeric](5, 0) NOT NULL,
	[dias_grupo_desde] [numeric](6, 0) NOT NULL,
	[dias_grupo_hasta] [numeric](6, 0) NOT NULL,
	[dias_desde] [numeric](6, 0) NOT NULL,
	[dias_hasta] [numeric](6, 0) NOT NULL,
	[porcentaje] [float] NOT NULL,
	[codigo_grupo] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MATRIZ_RIESGO] ADD  CONSTRAINT [DF_MATRIZ_RIESGO_codigo_grupo]  DEFAULT ('') FOR [codigo_grupo]
GO

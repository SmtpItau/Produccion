USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CALIDAD_JURIDICA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALIDAD_JURIDICA](
	[Codigo_Calidad] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL,
	[codigo_calidad_contable] [char](3) NOT NULL,
	[tipo_mercado] [char](2) NOT NULL,
	[sector] [char](10) NOT NULL
) ON [PRIMARY]
GO

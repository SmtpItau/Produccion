USE [BacLineas]
GO
/****** Object:  Table [dbo].[GRUPO_POSICION_DETALLE]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_POSICION_DETALLE](
	[codigo_grupo] [varchar](5) NOT NULL,
	[sistema] [varchar](3) NOT NULL,
	[rut_emisor] [numeric](10, 0) NOT NULL,
	[tipo_emisor] [int] NOT NULL,
	[codigo_instrumento] [numeric](9, 0) NOT NULL,
	[codigo_moneda] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[Glosa_Tipo_Emisor] [char](50) NOT NULL,
	[Condicion] [char](20) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRUPO_POSICION_DETALLE] ADD  DEFAULT ('') FOR [Glosa_Tipo_Emisor]
GO
ALTER TABLE [dbo].[GRUPO_POSICION_DETALLE] ADD  DEFAULT ('') FOR [Condicion]
GO

USE [MDPasivo]
GO
/****** Object:  Table [dbo].[GRUPO_PRODUCTO_DETALLE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_PRODUCTO_DETALLE](
	[codigo_grupo] [char](10) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[codigo_instrumento] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO

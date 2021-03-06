USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[INTERFAZ]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INTERFAZ](
	[codigo_cartera] [numeric](10, 0) NOT NULL,
	[rut_entidad] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[codigo_Interfaz] [numeric](3, 0) NOT NULL,
	[nombre] [varchar](50) NULL,
	[descripcion] [varchar](50) NOT NULL,
	[ruta_acceso] [varchar](200) NULL,
	[tipo_interfaz] [char](1) NOT NULL
) ON [PRIMARY]
GO

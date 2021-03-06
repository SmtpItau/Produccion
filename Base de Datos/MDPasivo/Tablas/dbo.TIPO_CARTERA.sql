USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_CARTERA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_CARTERA](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_Cartera] [int] NOT NULL,
	[Descripcion] [char](50) NULL,
	[Clasificacion_Qh] [char](1) NOT NULL,
	[Estado] [numeric](1, 0) NOT NULL,
	[Codigo_Grupo_Cartera] [char](5) NOT NULL,
	[RESPONSABLE] [char](20) NOT NULL,
	[LIBRO] [char](10) NOT NULL
) ON [PRIMARY]
GO

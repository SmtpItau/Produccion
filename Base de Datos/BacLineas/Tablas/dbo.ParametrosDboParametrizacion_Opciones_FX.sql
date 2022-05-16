USE [BacLineas]
GO
/****** Object:  Table [dbo].[ParametrosDboParametrizacion_Opciones_FX]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametrosDboParametrizacion_Opciones_FX](
	[Par_Monedas] [varchar](50) NULL,
	[Tipo_Cambio] [int] NULL,
	[Curva_1] [varchar](50) NULL,
	[Curva_2] [varchar](50) NULL,
	[Moneda_Valorizacion] [int] NULL,
	[Codigo_Vol] [int] NULL
) ON [PRIMARY]
GO

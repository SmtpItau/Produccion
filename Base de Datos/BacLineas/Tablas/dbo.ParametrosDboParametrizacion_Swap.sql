USE [BacLineas]
GO
/****** Object:  Table [dbo].[ParametrosDboParametrizacion_Swap]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametrosDboParametrizacion_Swap](
	[Tasa] [int] NULL,
	[Moneda] [int] NULL,
	[Producto] [int] NULL,
	[Curva_Descuento] [nvarchar](50) NULL,
	[Curva_Forward] [nvarchar](50) NULL
) ON [PRIMARY]
GO

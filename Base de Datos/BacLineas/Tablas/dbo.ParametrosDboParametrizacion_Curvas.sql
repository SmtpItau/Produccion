USE [BacLineas]
GO
/****** Object:  Table [dbo].[ParametrosDboParametrizacion_Curvas]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametrosDboParametrizacion_Curvas](
	[Curva] [nvarchar](255) NULL,
	[Codigo] [numeric](38, 0) NULL,
	[Producto] [nvarchar](255) NULL,
	[Moneda] [nvarchar](255) NULL,
	[Local] [nvarchar](2) NULL
) ON [PRIMARY]
GO

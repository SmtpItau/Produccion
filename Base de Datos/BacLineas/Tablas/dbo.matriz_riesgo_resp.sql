USE [BacLineas]
GO
/****** Object:  Table [dbo].[matriz_riesgo_resp]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matriz_riesgo_resp](
	[Codigo_Producto] [char](5) NOT NULL,
	[Moneda] [numeric](3, 0) NOT NULL,
	[diasdesde] [numeric](5, 0) NOT NULL,
	[diashasta] [numeric](5, 0) NOT NULL,
	[porcentaje] [numeric](8, 4) NOT NULL,
	[Contra_Moneda] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO

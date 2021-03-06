USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[OpeSINTasa]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpeSINTasa](
	[Numero_Operacion] [numeric](7, 0) NULL,
	[Numero_Flujo] [numeric](3, 0) NULL,
	[Tipo_Flujo] [numeric](1, 0) NULL,
	[Moneda] [numeric](3, 0) NULL,
	[Plazo] [float] NULL,
	[Sistema] [char](3) NULL,
	[Producto] [char](5) NULL,
	[Tipo_Tasa] [char](5) NULL,
	[Base] [numeric](5, 0) NULL,
	[Glosa] [char](100) NULL
) ON [PRIMARY]
GO

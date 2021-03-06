USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CONTROL_LIMITES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROL_LIMITES](
	[Fecha] [datetime] NOT NULL,
	[Hora] [char](8) NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Producto] [char](10) NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Monto_Limite] [numeric](19, 4) NOT NULL,
	[Monto_Producto] [numeric](19, 4) NOT NULL,
	[Plazo] [numeric](5, 0) NULL,
	[Trader] [char](10) NULL,
	[Trader_Autorizador] [char](10) NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[TIPO_CARTERA] [numeric](5, 0) NULL
) ON [PRIMARY]
GO

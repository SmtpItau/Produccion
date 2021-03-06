USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VALOR_DEFECTO]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALOR_DEFECTO](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [varchar](5) NOT NULL,
	[codigo_area] [varchar](5) NOT NULL,
	[compra_forma_pagomn] [numeric](3, 0) NOT NULL,
	[compra_forma_pagomx] [numeric](3, 0) NOT NULL,
	[compra_codigo_oma] [numeric](3, 0) NOT NULL,
	[compra_codigo_comercio] [char](6) NOT NULL,
	[compra_codigo_concepto] [char](3) NOT NULL,
	[venta_forma_pagomn] [numeric](3, 0) NOT NULL,
	[venta_forma_pagomx] [numeric](3, 0) NOT NULL,
	[venta_codigo_oma] [numeric](3, 0) NOT NULL,
	[venta_codigo_comercio] [char](6) NOT NULL,
	[venta_codigo_concepto] [char](3) NOT NULL,
	[contabiliza] [char](1) NOT NULL,
	[monto_operacion] [numeric](19, 4) NOT NULL,
	[codigo_moneda] [numeric](5, 0) NOT NULL,
	[Corres_Compra] [numeric](10, 0) NOT NULL,
	[Corres_Venta] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALOR_DEFECTO] ADD  DEFAULT (0) FOR [Corres_Compra]
GO
ALTER TABLE [dbo].[VALOR_DEFECTO] ADD  DEFAULT (0) FOR [Corres_Venta]
GO

USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_RECEPCION_PAGOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_RECEPCION_PAGOS](
	[tipo_operacion] [char](4) NULL,
	[operacion] [numeric](10, 0) NULL,
	[correlativo] [numeric](5, 0) NULL,
	[moneda] [numeric](3, 0) NULL,
	[monto] [float] NULL,
	[forma_pago] [char](4) NULL
) ON [PRIMARY]
GO

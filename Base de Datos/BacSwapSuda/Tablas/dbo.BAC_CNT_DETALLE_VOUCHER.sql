USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_DETALLE_VOUCHER]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[Moneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO

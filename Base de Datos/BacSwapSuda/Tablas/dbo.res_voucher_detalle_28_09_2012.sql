USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[res_voucher_detalle_28_09_2012]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[res_voucher_detalle_28_09_2012](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[Moneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO

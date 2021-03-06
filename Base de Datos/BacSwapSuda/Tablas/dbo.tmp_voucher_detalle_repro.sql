USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[tmp_voucher_detalle_repro]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_voucher_detalle_repro](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[Moneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO

USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[detalle_voucher_cnt]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_voucher_cnt](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[Moneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO

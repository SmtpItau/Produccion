USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE](
	[Numero_Voucher] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Cuenta] [char](20) NOT NULL,
	[Tipo_Monto] [char](1) NOT NULL,
	[Monto] [float] NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL,
 CONSTRAINT [PkVoucherDetalleBalance] PRIMARY KEY CLUSTERED 
(
	[Numero_Voucher] ASC,
	[Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_numero_voucher]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_correlativo]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_cuenta]  DEFAULT ('') FOR [Cuenta]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_tipo_monto]  DEFAULT ('') FOR [Tipo_Monto]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_monto]  DEFAULT (0) FOR [Monto]
GO
ALTER TABLE [dbo].[BAC_CNT_DETALLE_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalancedetalle_moneda]  DEFAULT (0) FOR [Moneda]
GO

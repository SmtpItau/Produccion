USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[DETALLE_VOUCHER_CNT_BALANCE]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE](
	[Numero_Voucher] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Cuenta] [varchar](20) NOT NULL,
	[Tipo_Monto] [char](1) NOT NULL,
	[Monto] [float] NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL,
 CONSTRAINT [Pk_Detalle_Voucher_Cnt_Balance] PRIMARY KEY CLUSTERED 
(
	[Numero_Voucher] ASC,
	[Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Numero_Voucher]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Correlativo]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Cuenta]  DEFAULT ('') FOR [Cuenta]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Tipo_Monto]  DEFAULT ('') FOR [Tipo_Monto]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Monto]  DEFAULT (0.0) FOR [Monto]
GO
ALTER TABLE [dbo].[DETALLE_VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfDetalleVoucherBalance_Moneda]  DEFAULT (0.0) FOR [Moneda]
GO

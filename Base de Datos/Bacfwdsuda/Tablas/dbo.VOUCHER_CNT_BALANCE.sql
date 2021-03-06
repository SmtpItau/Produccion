USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[VOUCHER_CNT_BALANCE]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOUCHER_CNT_BALANCE](
	[Numero_Voucher] [numeric](9, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Glosa] [varchar](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [varchar](5) NOT NULL,
	[Operacion] [numeric](9, 0) NOT NULL,
	[Folio_Perfil] [numeric](5, 0) NOT NULL,
 CONSTRAINT [Pk_Voucher_Cnt_Balance] PRIMARY KEY CLUSTERED 
(
	[Numero_Voucher] ASC,
	[Fecha_Ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Numero_Voucher]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Fecha_Ingreso]  DEFAULT ('') FOR [Fecha_Ingreso]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Glosa]  DEFAULT ('') FOR [Glosa]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Tipo_Voucher]  DEFAULT ('') FOR [Tipo_Voucher]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Tipo_Operacion]  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Operacion]  DEFAULT (0) FOR [Operacion]
GO
ALTER TABLE [dbo].[VOUCHER_CNT_BALANCE] ADD  CONSTRAINT [dfVoucherCntBalance_Folio_Perfil]  DEFAULT (0) FOR [Folio_Perfil]
GO

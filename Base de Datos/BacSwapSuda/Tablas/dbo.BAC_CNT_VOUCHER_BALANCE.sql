USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_VOUCHER_BALANCE]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE](
	[Numero_Voucher] [numeric](9, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Glosa] [char](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [varchar](5) NOT NULL,
	[Operacion] [numeric](9, 0) NOT NULL,
	[Folio_Perfil] [numeric](5, 0) NOT NULL,
 CONSTRAINT [PkVoucherBalance] PRIMARY KEY CLUSTERED 
(
	[Numero_Voucher] ASC,
	[Fecha_Ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_numero_voucher]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_fecha_ingreso]  DEFAULT ('') FOR [Fecha_Ingreso]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_glosa]  DEFAULT ('') FOR [Glosa]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_tipo_voucher]  DEFAULT ('') FOR [Tipo_Voucher]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_tipo_operacion]  DEFAULT (0) FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_operacion]  DEFAULT (0) FOR [Operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER_BALANCE] ADD  CONSTRAINT [dfvoucherbalance_folio_perfil]  DEFAULT (0) FOR [Folio_Perfil]
GO

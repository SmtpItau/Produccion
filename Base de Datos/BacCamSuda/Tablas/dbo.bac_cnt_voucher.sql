USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[bac_cnt_voucher]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_voucher](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Fecha_Contable] [datetime] NOT NULL,
	[Glosa] [varchar](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Documento] [numeric](10, 0) NOT NULL,
	[codigo_producto] [char](7) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[codigo_cliente] [numeric](18, 0) NOT NULL,
	[Mercado] [char](4) NOT NULL,
	[Moneda_Operacion] [char](3) NOT NULL,
	[Tipo_Cambio] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bac_cnt_voucher] ADD  CONSTRAINT [DF_bac_cnt_voucher_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[bac_cnt_voucher] ADD  CONSTRAINT [DF_bac_cnt_voucher_codigo_cliente]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[bac_cnt_voucher] ADD  CONSTRAINT [DF_bac_cnt_voucher_Mercado]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[bac_cnt_voucher] ADD  CONSTRAINT [DF_bac_cnt_voucher_Moneda_Operacion]  DEFAULT (' ') FOR [Moneda_Operacion]
GO
ALTER TABLE [dbo].[bac_cnt_voucher] ADD  CONSTRAINT [DF_bac_cnt_voucher_Forma_Pago]  DEFAULT (0) FOR [Tipo_Cambio]
GO

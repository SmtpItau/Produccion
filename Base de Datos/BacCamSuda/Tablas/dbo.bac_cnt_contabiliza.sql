USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[bac_cnt_contabiliza]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_contabiliza](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[Documento] [numeric](10, 0) NOT NULL,
	[codigo_instrumento] [char](10) NOT NULL,
	[moneda_instrumento] [char](6) NOT NULL,
	[Codigo_Moneda] [char](3) NOT NULL,
	[Monto_Origen] [float] NOT NULL,
	[Monto_Dolar] [float] NOT NULL,
	[Monto_Pesos] [float] NOT NULL,
	[Forma_Pago_Mn] [numeric](3, 0) NOT NULL,
	[Forma_Pago_Mx] [numeric](3, 0) NOT NULL,
	[Forma_Pago_Us] [numeric](3, 0) NOT NULL,
	[Fecha_Proceso] [datetime] NOT NULL,
	[Fecha_Contable] [datetime] NOT NULL,
	[Tipo_Mercado] [char](4) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[Codigo_cliente] [numeric](9, 0) NOT NULL,
	[Tipo_Cambio] [numeric](19, 4) NOT NULL,
	[Moneda_Conversion] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Codig__6A008029]  DEFAULT ('') FOR [Codigo_Moneda]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Monto__6AF4A462]  DEFAULT (0) FOR [Monto_Origen]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Monto__6BE8C89B]  DEFAULT (0) FOR [Monto_Dolar]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Monto__6CDCECD4]  DEFAULT (0) FOR [Monto_Pesos]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Forma__6DD1110D]  DEFAULT (0) FOR [Forma_Pago_Mn]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Forma__6EC53546]  DEFAULT (0) FOR [Forma_Pago_Mx]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Forma__6FB9597F]  DEFAULT (0) FOR [Forma_Pago_Us]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF_bac_cnt_contabiliza_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF_bac_cnt_contabiliza_Codigo_cliente]  DEFAULT (0) FOR [Codigo_cliente]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF_bac_cnt_contabiliza_Tipo_Cambio]  DEFAULT (0) FOR [Tipo_Cambio]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [df_Moneda_Conversion]  DEFAULT (0) FOR [Moneda_Conversion]
GO

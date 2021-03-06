USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_OPERACIONES]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_OPERACIONES](
	[id_sistema] [char](3) NOT NULL,
	[fecha_operacion] [datetime] NOT NULL,
	[tipo_operacion] [char](4) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[codigo_rut] [numeric](5, 0) NULL,
	[monto_operacion] [float] NULL,
	[moneda] [char](4) NULL,
	[forma_pago] [char](4) NULL,
	[retiro] [char](3) NULL,
	[cerrada] [char](1) NULL,
	[situacion] [char](1) NULL,
	[fecha_pago] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[entidad] [numeric](10, 0) NULL,
	[moneda_mx] [char](4) NULL,
	[monto_mx] [float] NULL,
	[forma_pago_mx] [char](4) NULL,
	[fecha_vcto_mx] [datetime] NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[liq_settle] [char](1) NULL,
	[tipo_movimiento] [char](1) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Codig__139DBB87]  DEFAULT (0) FOR [codigo_rut]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Monto__1491DFC0]  DEFAULT (0) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Moned__158603F9]  DEFAULT (' ') FOR [moneda]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Forma__167A2832]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Retir__176E4C6B]  DEFAULT (' ') FOR [retiro]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Cerra__186270A4]  DEFAULT (' ') FOR [cerrada]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Situa__195694DD]  DEFAULT (' ') FOR [situacion]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Entid__1A4AB916]  DEFAULT (0) FOR [entidad]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Moned__55016A90]  DEFAULT ('') FOR [moneda_mx]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Monto__55F58EC9]  DEFAULT (0) FOR [monto_mx]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Forma__56E9B302]  DEFAULT ('') FOR [forma_pago_mx]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Fecha__57DDD73B]  DEFAULT ('') FOR [fecha_vcto_mx]
GO
ALTER TABLE [dbo].[GEN_OPERACIONES] ADD  CONSTRAINT [DF__GEN_OPERA__Corre__58D1FB74]  DEFAULT (0) FOR [correlativo]
GO

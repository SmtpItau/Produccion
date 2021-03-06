USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_PAGOS_OPERACION]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_PAGOS_OPERACION](
	[fecha_pago] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](10, 0) NOT NULL,
	[tipo_movimiento] [char](1) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_rut] [numeric](3, 0) NOT NULL,
	[monto_operacion] [float] NOT NULL,
	[moneda] [char](3) NOT NULL,
	[numero_documento] [numeric](10, 0) NOT NULL,
	[forma_pago] [char](4) NOT NULL,
	[nombre_cliente] [char](40) NOT NULL,
	[estado] [char](1) NOT NULL,
	[tipo_canje] [char](1) NOT NULL,
	[codigo_banco] [numeric](3, 0) NOT NULL,
	[fecha_cobro] [datetime] NOT NULL,
	[glosa] [char](40) NOT NULL,
	[tipo_ingreso] [char](1) NOT NULL,
	[correla_pago] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__ID_Si__24FD51B3]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Tipo___25F175EC]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Opera__26E59A25]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Corre__27D9BE5E]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Tipo___28CDE297]  DEFAULT (' ') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Rut_C__29C206D0]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Codig__2AB62B09]  DEFAULT (0) FOR [codigo_rut]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Monto__2BAA4F42]  DEFAULT (0) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Moned__2C9E737B]  DEFAULT (' ') FOR [moneda]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Numer__2D9297B4]  DEFAULT (0) FOR [numero_documento]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Forma__2E86BBED]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Nombr__2F7AE026]  DEFAULT (' ') FOR [nombre_cliente]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Estad__306F045F]  DEFAULT (' ') FOR [estado]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Tipo___31632898]  DEFAULT (' ') FOR [tipo_canje]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Codig__32574CD1]  DEFAULT (0) FOR [codigo_banco]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Glosa__334B710A]  DEFAULT (' ') FOR [glosa]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Tipo___343F9543]  DEFAULT (' ') FOR [tipo_ingreso]
GO
ALTER TABLE [dbo].[GEN_PAGOS_OPERACION] ADD  CONSTRAINT [DF__GEN_PAGOS__Corre__3533B97C]  DEFAULT (0) FOR [correla_pago]
GO

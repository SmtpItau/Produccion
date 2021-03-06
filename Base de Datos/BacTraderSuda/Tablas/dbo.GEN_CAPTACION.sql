USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_CAPTACION]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_CAPTACION](
	[fecha_operacion] [datetime] NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[correla_operacion] [numeric](5, 0) NOT NULL,
	[correla_corte] [numeric](3, 0) NOT NULL,
	[rut_cliente] [numeric](10, 0) NOT NULL,
	[codigo_rut] [numeric](5, 0) NOT NULL,
	[entidad] [numeric](10, 0) NOT NULL,
	[forma_pago] [char](4) NOT NULL,
	[retiro] [char](3) NOT NULL,
	[monto_inicio] [float] NOT NULL,
	[monto_inicio_pesos] [float] NOT NULL,
	[moneda] [numeric](3, 0) NOT NULL,
	[tasa] [numeric](8, 4) NOT NULL,
	[tasa_tran] [numeric](8, 4) NOT NULL,
	[plazo] [numeric](5, 0) NOT NULL,
	[monto_final] [float] NOT NULL,
	[estado] [char](1) NOT NULL,
	[fecha_origen] [datetime] NOT NULL,
	[control_renov] [numeric](5, 0) NOT NULL,
	[custodia] [char](1) NOT NULL,
	[valor_ant_presente] [float] NOT NULL,
	[interes_diario] [float] NOT NULL,
	[reajuste_diario] [float] NOT NULL,
	[interes_acumulado] [float] NOT NULL,
	[reajuste_acumulado] [float] NOT NULL,
	[valor_presente] [float] NOT NULL,
	[interes_extra] [float] NOT NULL,
	[reajuste_extra] [float] NOT NULL,
	[tipo_deposito] [char](1) NOT NULL,
	[numero_original] [numeric](10, 0) NOT NULL,
	[Condicion_Captacion] [char](1) NULL,
	[Tipo_Emision] [int] NULL,
	[estado_mp] [char](1) NOT NULL,
	[mensaje_mp] [char](255) NOT NULL,
	[numero_certificado_dcv] [numeric](10, 0) NOT NULL,
	[fecha_vencimiento_original] [datetime] NOT NULL,
	[monto_inicio_org] [float] NOT NULL,
	[monto_inicio_pesos_org] [float] NOT NULL,
	[monto_final_org] [float] NOT NULL,
	[Id_Compra] [char](1) NOT NULL,
	[capital_recomprado] [float] NULL,
	[resultado_recompra] [float] NULL,
	[Int_dev_recompra] [float] NULL,
	[valor_recompra] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Codig__614745E4]  DEFAULT (0) FOR [codigo_rut]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Forma__623B6A1D]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Retir__632F8E56]  DEFAULT (' ') FOR [retiro]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTAC__Tasa__6423B28F]  DEFAULT (0) FOR [tasa]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Tasa___6517D6C8]  DEFAULT (0) FOR [tasa_tran]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__ESTAD__660BFB01]  DEFAULT ('V') FOR [estado]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Fecha__67001F3A]  DEFAULT ('') FOR [fecha_origen]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Contr__67F44373]  DEFAULT (0) FOR [control_renov]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__CUSTO__68E867AC]  DEFAULT ('P') FOR [custodia]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__valor__69DC8BE5]  DEFAULT (0) FOR [valor_ant_presente]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__inter__6AD0B01E]  DEFAULT (0) FOR [interes_diario]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__reaju__6BC4D457]  DEFAULT (0) FOR [reajuste_diario]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__inter__6CB8F890]  DEFAULT (0) FOR [interes_acumulado]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__reaju__6DAD1CC9]  DEFAULT (0) FOR [reajuste_acumulado]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__valor__6EA14102]  DEFAULT (0) FOR [valor_presente]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__inter__6F95653B]  DEFAULT (0) FOR [interes_extra]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__reaju__70898974]  DEFAULT (0) FOR [reajuste_extra]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__Tipo___717DADAD]  DEFAULT ('R') FOR [tipo_deposito]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  CONSTRAINT [DF__GEN_CAPTA__numer__7271D1E6]  DEFAULT (0) FOR [numero_original]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ('') FOR [Condicion_Captacion]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [Tipo_Emision]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ('') FOR [estado_mp]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ('') FOR [mensaje_mp]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [numero_certificado_dcv]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ('') FOR [fecha_vencimiento_original]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0.0)) FOR [monto_inicio_org]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0.0)) FOR [monto_inicio_pesos_org]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0.0)) FOR [monto_final_org]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ('') FOR [Id_Compra]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [capital_recomprado]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [resultado_recompra]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [Int_dev_recompra]
GO
ALTER TABLE [dbo].[GEN_CAPTACION] ADD  DEFAULT ((0)) FOR [valor_recompra]
GO

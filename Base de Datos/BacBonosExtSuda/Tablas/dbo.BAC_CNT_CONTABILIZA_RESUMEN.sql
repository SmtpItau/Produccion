USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_CONTABILIZA_RESUMEN]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](19, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](10) NOT NULL,
	[moneda_instrumento] [char](6) NOT NULL,
	[valor_compra] [float] NOT NULL,
	[valor_presente] [float] NOT NULL,
	[valor_venta] [float] NOT NULL,
	[utilidad] [float] NOT NULL,
	[perdida] [float] NOT NULL,
	[interes_papel] [float] NOT NULL,
	[reajuste_papel] [float] NOT NULL,
	[interes_pacto] [float] NOT NULL,
	[reajuste_pacto] [float] NOT NULL,
	[valor_cupon] [float] NOT NULL,
	[nominal] [float] NOT NULL,
	[valor_comprahis] [float] NOT NULL,
	[dif_ant_pacto_pos] [float] NOT NULL,
	[dif_ant_pacto_neg] [float] NOT NULL,
	[dif_valor_mercado_pos] [float] NOT NULL,
	[dif_valor_mercado_neg] [float] NOT NULL,
	[condicion_pacto] [char](3) NOT NULL,
	[forma_pago] [char](6) NOT NULL,
	[tipo_instrumento] [char](5) NOT NULL,
	[tipo_cliente] [char](1) NOT NULL,
	[tipo_emisor] [char](6) NOT NULL,
	[forma_pago_entregamos] [char](6) NOT NULL,
	[valor_futuro] [float] NOT NULL,
	[condicion_entrega] [char](1) NOT NULL,
	[tipo_operacion_or] [char](5) NOT NULL,
	[comquien] [char](1) NOT NULL,
	[instser] [char](12) NOT NULL,
	[documento] [numeric](10, 0) NOT NULL,
	[Emisor] [char](10) NOT NULL,
	[tipo_bono] [char](6) NOT NULL,
	[clasificacion_cliente] [char](6) NOT NULL,
	[valor_final] [float] NOT NULL,
	[cartera_origen] [char](2) NOT NULL,
	[interes_positivo] [float] NOT NULL,
	[interes_negativo] [float] NOT NULL,
	[reajuste_positivo] [float] NOT NULL,
	[reajuste_negativo] [float] NOT NULL,
	[plazo] [numeric](9, 0) NOT NULL,
	[cliente] [numeric](18, 0) NOT NULL,
	[codcli] [numeric](18, 0) NOT NULL,
	[fecha_proceso] [datetime] NOT NULL,
	[capitalPeso] [numeric](24, 0) NOT NULL,
	[interesPeso] [numeric](24, 0) NOT NULL,
	[ctacblecorresponsal] [char](15) NOT NULL,
	[valor_cupon_peso] [float] NOT NULL,
	[id_operacion] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[Utilidad_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Perdida_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Pos] [numeric](21, 4) NULL,
	[Diferencia_Precio_Neg] [numeric](21, 4) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__opera__70747ADB]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__corre__71689F14]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__725CC34D]  DEFAULT (0) FOR [valor_compra]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__7350E786]  DEFAULT (0) FOR [valor_presente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__74450BBF]  DEFAULT (0) FOR [valor_venta]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__utili__75392FF8]  DEFAULT (0) FOR [utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__perdi__762D5431]  DEFAULT (0) FOR [perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__7721786A]  DEFAULT (0) FOR [interes_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__78159CA3]  DEFAULT (0) FOR [reajuste_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__7909C0DC]  DEFAULT (0) FOR [interes_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__79FDE515]  DEFAULT (0) FOR [reajuste_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__7AF2094E]  DEFAULT (0) FOR [valor_comprahis]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_a__7BE62D87]  DEFAULT (0) FOR [dif_ant_pacto_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_a__7CDA51C0]  DEFAULT (0) FOR [dif_ant_pacto_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_v__7DCE75F9]  DEFAULT (0) FOR [dif_valor_mercado_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_v__7EC29A32]  DEFAULT (0) FOR [dif_valor_mercado_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__condi__7FB6BE6B]  DEFAULT (' ') FOR [condicion_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__forma__00AAE2A4]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___019F06DD]  DEFAULT (' ') FOR [tipo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___02932B16]  DEFAULT (' ') FOR [tipo_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___03874F4F]  DEFAULT (' ') FOR [tipo_emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__forma__047B7388]  DEFAULT (' ') FOR [forma_pago_entregamos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__056F97C1]  DEFAULT (0) FOR [valor_futuro]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__condi__0663BBFA]  DEFAULT (' ') FOR [condicion_entrega]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___0757E033]  DEFAULT (' ') FOR [tipo_operacion_or]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__comqu__084C046C]  DEFAULT (' ') FOR [comquien]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__insts__094028A5]  DEFAULT (' ') FOR [instser]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__docum__0A344CDE]  DEFAULT (0) FOR [documento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__Emiso__0B287117]  DEFAULT (' ') FOR [Emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___0C1C9550]  DEFAULT (' ') FOR [tipo_bono]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__clasi__0D10B989]  DEFAULT (' ') FOR [clasificacion_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__0E04DDC2]  DEFAULT (0) FOR [valor_final]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__carte__0EF901FB]  DEFAULT (' ') FOR [cartera_origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__0FED2634]  DEFAULT (0) FOR [interes_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__10E14A6D]  DEFAULT (0) FOR [interes_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__11D56EA6]  DEFAULT (0) FOR [reajuste_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__12C992DF]  DEFAULT (0) FOR [reajuste_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__plazo__13BDB718]  DEFAULT (0) FOR [plazo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__clien__14B1DB51]  DEFAULT (0) FOR [cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__codcl__15A5FF8A]  DEFAULT (0) FOR [codcli]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__fecha__169A23C3]  DEFAULT (' ') FOR [fecha_proceso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__capit__178E47FC]  DEFAULT (0) FOR [capitalPeso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__18826C35]  DEFAULT (0) FOR [interesPeso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__ctacb__1976906E]  DEFAULT (' ') FOR [ctacblecorresponsal]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__1A6AB4A7]  DEFAULT (0) FOR [valor_cupon_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Resumen_Utilidad_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Utilidad_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Resumen_Perdida_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Perdida_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Resumen_Diferencia_Precio_Pos]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_RESUMEN] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Resumen_Diferencia_Precio_Neg]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Neg]
GO

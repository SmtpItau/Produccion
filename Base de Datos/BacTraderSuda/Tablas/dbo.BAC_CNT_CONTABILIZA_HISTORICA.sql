USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_CONTABILIZA_HISTORICA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA](
	[FechaContable] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
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
	[interes_pacto] [numeric](21, 4) NOT NULL,
	[reajuste_pacto] [float] NOT NULL,
	[valor_cupon] [float] NOT NULL,
	[nominalpesos] [float] NOT NULL,
	[valor_comprahis] [float] NOT NULL,
	[dif_ant_pacto_pos] [float] NOT NULL,
	[dif_ant_pacto_neg] [float] NOT NULL,
	[dif_valor_mercado_pos] [float] NOT NULL,
	[dif_valor_mercado_neg] [float] NOT NULL,
	[condicion_pacto] [char](3) NOT NULL,
	[forma_pago] [char](6) NOT NULL,
	[tipo_instrumento] [char](1) NOT NULL,
	[tipo_cliente] [char](1) NOT NULL,
	[tipo_emisor] [char](6) NOT NULL,
	[forma_pago_entregamos] [char](6) NOT NULL,
	[valor_futuro] [float] NOT NULL,
	[condicion_entrega] [char](5) NOT NULL,
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
	[Interes_Reajuste] [float] NOT NULL,
	[Nominal] [float] NOT NULL,
	[valor_tasa_emision] [numeric](19, 4) NOT NULL,
	[prima_total] [numeric](19, 4) NOT NULL,
	[descuento_total] [numeric](19, 4) NOT NULL,
	[prima_dia] [numeric](19, 4) NOT NULL,
	[escuento_dia] [numeric](19, 4) NOT NULL,
	[valor_pte_emision] [numeric](19, 4) NOT NULL,
	[dif_par_pos] [numeric](19, 6) NOT NULL,
	[dif_par_neg] [numeric](19, 6) NOT NULL,
	[Tipo_cartera] [char](10) NOT NULL,
	[CondPactoCliente] [char](3) NOT NULL,
	[EstObj] [char](5) NOT NULL,
	[Monto_Pagomañana] [numeric](21, 4) NOT NULL,
	[Utilidad_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Perdida_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Pos] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Neg] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_FechaContable]  DEFAULT ('') FOR [FechaContable]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_id_sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_movimiento]  DEFAULT ('') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_operacion]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_operacion]  DEFAULT ((0)) FOR [operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_correlativo]  DEFAULT ((0)) FOR [correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_codigo_instrumento]  DEFAULT ('') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_moneda_instrumento]  DEFAULT ('') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_compra]  DEFAULT ((0.0)) FOR [valor_compra]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_presente]  DEFAULT ((0.0)) FOR [valor_presente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_venta]  DEFAULT ((0.0)) FOR [valor_venta]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_utilidad]  DEFAULT ((0.0)) FOR [utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_perdida]  DEFAULT ((0.0)) FOR [perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_interes_papel]  DEFAULT ((0.0)) FOR [interes_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_reajuste_papel]  DEFAULT ((0.0)) FOR [reajuste_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_interes_pacto]  DEFAULT ((0.0)) FOR [interes_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_reajuste_pacto]  DEFAULT ((0.0)) FOR [reajuste_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_cupon]  DEFAULT ((0.0)) FOR [valor_cupon]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_nominalpesos]  DEFAULT ((0.0)) FOR [nominalpesos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_comprahis]  DEFAULT ((0.0)) FOR [valor_comprahis]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_ant_pacto_pos]  DEFAULT ((0.0)) FOR [dif_ant_pacto_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_ant_pacto_neg]  DEFAULT ((0.0)) FOR [dif_ant_pacto_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_valor_mercado_pos]  DEFAULT ((0.0)) FOR [dif_valor_mercado_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_valor_mercado_neg]  DEFAULT ((0.0)) FOR [dif_valor_mercado_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_condicion_pacto]  DEFAULT ('') FOR [condicion_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_forma_pago]  DEFAULT ('') FOR [forma_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_instrumento]  DEFAULT ('') FOR [tipo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_cliente]  DEFAULT ('') FOR [tipo_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_emisor]  DEFAULT ('') FOR [tipo_emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_forma_pago_entregamos]  DEFAULT ('') FOR [forma_pago_entregamos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_futuro]  DEFAULT ((0.0)) FOR [valor_futuro]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_condicion_entrega]  DEFAULT ('') FOR [condicion_entrega]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_operacion_or]  DEFAULT ('') FOR [tipo_operacion_or]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_comquien]  DEFAULT ('') FOR [comquien]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_instser]  DEFAULT ('') FOR [instser]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_documento]  DEFAULT ((0)) FOR [documento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Emisor]  DEFAULT ('') FOR [Emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_tipo_bono]  DEFAULT ('') FOR [tipo_bono]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_clasificacion_cliente]  DEFAULT ('') FOR [clasificacion_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_final]  DEFAULT ((0.0)) FOR [valor_final]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_cartera_origen]  DEFAULT ('') FOR [cartera_origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_interes_positivo]  DEFAULT ((0.0)) FOR [interes_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_interes_negativo]  DEFAULT ((0.0)) FOR [interes_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_reajuste_positivo]  DEFAULT ((0.0)) FOR [reajuste_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_reajuste_negativo]  DEFAULT ((0.0)) FOR [reajuste_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_plazo]  DEFAULT ((0)) FOR [plazo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_cliente]  DEFAULT ((0)) FOR [cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_codcli]  DEFAULT ((0)) FOR [codcli]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_fecha_proceso]  DEFAULT ('') FOR [fecha_proceso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Interes_Reajuste]  DEFAULT ((0.0)) FOR [Interes_Reajuste]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Nominal]  DEFAULT ((0.0)) FOR [Nominal]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_tasa_emision]  DEFAULT ((0.0)) FOR [valor_tasa_emision]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_prima_total]  DEFAULT ((0.0)) FOR [prima_total]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_descuento_total]  DEFAULT ((0.0)) FOR [descuento_total]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_prima_dia]  DEFAULT ((0.0)) FOR [prima_dia]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_escuento_dia]  DEFAULT ((0.0)) FOR [escuento_dia]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_valor_pte_emision]  DEFAULT ((0.0)) FOR [valor_pte_emision]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_par_pos]  DEFAULT ((0.0)) FOR [dif_par_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_dif_par_neg]  DEFAULT ((0.0)) FOR [dif_par_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Tipo_cartera]  DEFAULT ('') FOR [Tipo_cartera]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_CondPactoCliente]  DEFAULT ('') FOR [CondPactoCliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_EstObj]  DEFAULT ('') FOR [EstObj]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Monto_Pagomañana]  DEFAULT ((0.0)) FOR [Monto_Pagomañana]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Utilidad_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Utilidad_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Perdida_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Perdida_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Diferencia_Precio_Pos]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA_HISTORICA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_historica_Diferencia_Precio_Neg]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Neg]
GO

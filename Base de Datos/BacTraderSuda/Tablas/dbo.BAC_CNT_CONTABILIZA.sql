USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_CONTABILIZA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_CONTABILIZA](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NULL,
	[tipo_operacion] [char](5) NULL,
	[operacion] [numeric](10, 0) NULL,
	[correlativo] [numeric](5, 0) NULL,
	[codigo_instrumento] [char](10) NULL,
	[moneda_instrumento] [char](6) NULL,
	[valor_compra] [float] NULL,
	[valor_presente] [float] NULL,
	[valor_venta] [float] NULL,
	[utilidad] [float] NULL,
	[perdida] [float] NULL,
	[interes_papel] [float] NULL,
	[reajuste_papel] [float] NULL,
	[interes_pacto] [numeric](21, 4) NULL,
	[reajuste_pacto] [float] NULL,
	[valor_cupon] [float] NULL,
	[nominalpesos] [float] NULL,
	[valor_comprahis] [float] NULL,
	[dif_ant_pacto_pos] [float] NULL,
	[dif_ant_pacto_neg] [float] NULL,
	[dif_valor_mercado_pos] [float] NULL,
	[dif_valor_mercado_neg] [float] NULL,
	[condicion_pacto] [char](3) NULL,
	[forma_pago] [char](6) NULL,
	[tipo_instrumento] [char](1) NULL,
	[tipo_cliente] [char](1) NULL,
	[tipo_emisor] [char](6) NULL,
	[forma_pago_entregamos] [char](6) NULL,
	[valor_futuro] [float] NULL,
	[condicion_entrega] [char](5) NULL,
	[tipo_operacion_or] [char](5) NULL,
	[comquien] [char](1) NULL,
	[instser] [char](12) NULL,
	[documento] [numeric](10, 0) NULL,
	[Emisor] [char](10) NULL,
	[tipo_bono] [char](6) NULL,
	[clasificacion_cliente] [char](6) NULL,
	[valor_final] [float] NULL,
	[cartera_origen] [char](2) NULL,
	[interes_positivo] [float] NULL,
	[interes_negativo] [float] NULL,
	[reajuste_positivo] [float] NULL,
	[reajuste_negativo] [float] NULL,
	[plazo] [numeric](9, 0) NULL,
	[cliente] [numeric](18, 0) NULL,
	[codcli] [numeric](18, 0) NULL,
	[fecha_proceso] [datetime] NULL,
	[Interes_Reajuste] [float] NULL,
	[Nominal] [float] NULL,
	[valor_tasa_emision] [numeric](19, 4) NULL,
	[prima_total] [numeric](19, 4) NULL,
	[descuento_total] [numeric](19, 4) NULL,
	[prima_dia] [numeric](19, 4) NULL,
	[descuento_dia] [numeric](19, 4) NULL,
	[valor_pte_emision] [numeric](19, 4) NULL,
	[dif_par_pos] [numeric](19, 6) NULL,
	[dif_par_neg] [numeric](19, 6) NULL,
	[Tipo_cartera] [char](10) NULL,
	[CondPactoCliente] [char](3) NULL,
	[EstObj] [char](5) NOT NULL,
	[Monto_Pagomañana] [numeric](21, 4) NOT NULL,
	[Utilidad_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Perdida_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Pos] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Neg] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__id_si__505F1309]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___51533742]  DEFAULT (' ') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___52475B7B]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__opera__533B7FB4]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__corre__542FA3ED]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__codig__5523C826]  DEFAULT (' ') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__moned__5617EC5F]  DEFAULT (' ') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__570C1098]  DEFAULT (0) FOR [valor_compra]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__580034D1]  DEFAULT (0) FOR [valor_presente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__58F4590A]  DEFAULT (0) FOR [valor_venta]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__utili__59E87D43]  DEFAULT (0) FOR [utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__perdi__5ADCA17C]  DEFAULT (0) FOR [perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__5BD0C5B5]  DEFAULT (0) FOR [interes_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__5CC4E9EE]  DEFAULT (0) FOR [reajuste_papel]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__5DB90E27]  DEFAULT (0) FOR [interes_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__reaju__5EAD3260]  DEFAULT (0) FOR [reajuste_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__5FA15699]  DEFAULT (0) FOR [valor_cupon]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__nomin__60957AD2]  DEFAULT (0) FOR [nominalpesos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__61899F0B]  DEFAULT (0) FOR [valor_comprahis]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_a__627DC344]  DEFAULT (0) FOR [dif_ant_pacto_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_a__6371E77D]  DEFAULT (0) FOR [dif_ant_pacto_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_v__64660BB6]  DEFAULT (0) FOR [dif_valor_mercado_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_v__655A2FEF]  DEFAULT (0) FOR [dif_valor_mercado_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__condi__664E5428]  DEFAULT (' ') FOR [condicion_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__forma__67427861]  DEFAULT (' ') FOR [forma_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___68369C9A]  DEFAULT (' ') FOR [tipo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___692AC0D3]  DEFAULT (' ') FOR [tipo_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___6A1EE50C]  DEFAULT (' ') FOR [tipo_emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__forma__6B130945]  DEFAULT (' ') FOR [forma_pago_entregamos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__6C072D7E]  DEFAULT (0) FOR [valor_futuro]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__condi__6CFB51B7]  DEFAULT (' ') FOR [condicion_entrega]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___6DEF75F0]  DEFAULT (' ') FOR [tipo_operacion_or]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_comquien]  DEFAULT (' ') FOR [comquien]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_instser]  DEFAULT ('') FOR [instser]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_documento]  DEFAULT (0) FOR [documento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_Emisor]  DEFAULT (' ') FOR [Emisor]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_tipo_bono]  DEFAULT (' ') FOR [tipo_bono]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_clasificacion_cliente]  DEFAULT (' ') FOR [clasificacion_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_valor_final]  DEFAULT (0) FOR [valor_final]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_cartera_origen]  DEFAULT (' ') FOR [cartera_origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_interes_positivo]  DEFAULT (0) FOR [interes_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_interes_negativo]  DEFAULT (0) FOR [interes_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_reajuste_positivo]  DEFAULT (0) FOR [reajuste_positivo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_reajuste_negativo]  DEFAULT (0) FOR [reajuste_negativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_plazo]  DEFAULT (0) FOR [plazo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_cliente]  DEFAULT (0) FOR [cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_codcli]  DEFAULT (0) FOR [codcli]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__fecha__3E6CE205]  DEFAULT ('') FOR [fecha_proceso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_Interes_Reajuste]  DEFAULT (0) FOR [Interes_Reajuste]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF_BAC_CNT_CONTABILIZA_Nominal]  DEFAULT (0) FOR [Nominal]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__5BC4420F]  DEFAULT (0) FOR [valor_tasa_emision]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__prima__5CB86648]  DEFAULT (0) FOR [prima_total]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__descu__5DAC8A81]  DEFAULT (0) FOR [descuento_total]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__prima__5EA0AEBA]  DEFAULT (0) FOR [prima_dia]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__descu__5F94D2F3]  DEFAULT (0) FOR [descuento_dia]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__6088F72C]  DEFAULT (0) FOR [valor_pte_emision]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_p__2F46A153]  DEFAULT (0) FOR [dif_par_pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__dif_p__303AC58C]  DEFAULT (0) FOR [dif_par_neg]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__Tipo___01774BB0]  DEFAULT ('') FOR [Tipo_cartera]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_BacCntContabiliza_CondPactoCliente]  DEFAULT ('') FOR [CondPactoCliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [CT_EstObj]  DEFAULT ('') FOR [EstObj]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__Monto__4247948A]  DEFAULT (0) FOR [Monto_Pagomañana]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_Utilidad_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Utilidad_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_Perdida_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Perdida_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_Diferencia_Precio_Pos]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_bac_cnt_contabiliza_Diferencia_Precio_Neg]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Neg]
GO

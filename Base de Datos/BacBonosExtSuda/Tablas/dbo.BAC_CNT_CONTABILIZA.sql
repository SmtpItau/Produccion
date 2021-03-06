USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_CONTABILIZA]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_CONTABILIZA](
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
	[tipo_instrumento] [char](15) NOT NULL,
	[tipo_cliente] [char](1) NOT NULL,
	[tipo_emisor] [char](6) NOT NULL,
	[forma_pago_entregamos] [char](6) NOT NULL,
	[valor_futuro] [float] NOT NULL,
	[condicion_entrega] [char](1) NOT NULL,
	[tipo_operacion_or] [char](5) NOT NULL,
	[comquien] [char](1) NOT NULL,
	[instser] [char](20) NOT NULL,
	[documento] [numeric](10, 0) NOT NULL,
	[Emisor] [char](10) NOT NULL,
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
	[capitalPeso] [numeric](24, 0) NOT NULL,
	[interesPeso] [numeric](24, 0) NOT NULL,
	[fecha_proceso] [datetime] NULL,
	[ctacblecorresponsal] [char](15) NOT NULL,
	[valor_cupon_peso] [float] NOT NULL,
	[tipo_cartera] [int] NOT NULL,
	[EstObj] [char](5) NOT NULL,
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
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__nomin__60957AD2]  DEFAULT (0) FOR [nominal]
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
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__capit__6ABBA185]  DEFAULT (0) FOR [capitalPeso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__inter__6BAFC5BE]  DEFAULT (0) FOR [interesPeso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__fecha__3E6CE205]  DEFAULT ('') FOR [fecha_proceso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__ctacb__6CA3E9F7]  DEFAULT (' ') FOR [ctacblecorresponsal]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__valor__6D980E30]  DEFAULT (0) FOR [valor_cupon_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [tipo_cartera]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [CT_EstObj]  DEFAULT ('') FOR [EstObj]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Utilidad_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Utilidad_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Perdida_Avr_Patrimonio]  DEFAULT ((0.0)) FOR [Perdida_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Diferencia_Precio_Pos]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Pos]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [df_Bac_Cnt_Contabiliza_Diferencia_Precio_Neg]  DEFAULT ((0.0)) FOR [Diferencia_Precio_Neg]
GO

USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[bac_cnt_contabiliza]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_contabiliza](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NULL,
	[correlativo] [numeric](5, 0) NULL,
	[codigo_instrumento] [char](10) NULL,
	[moneda_instrumento] [char](6) NULL,
	[valor_compra] [numeric](21, 4) NULL,
	[valor_venta] [numeric](21, 4) NULL,
	[valor_presente] [numeric](21, 4) NULL,
	[valor_futuro] [numeric](21, 4) NULL,
	[utilidad] [numeric](21, 0) NULL,
	[perdida] [numeric](21, 0) NULL,
	[Valorizacion] [numeric](21, 0) NULL,
	[Utilidad_Valorizacion] [numeric](21, 0) NULL,
	[Perdida_Valorizacion] [numeric](21, 0) NULL,
	[Reajuste_UF] [numeric](21, 0) NULL,
	[Utilidad_Ayer] [numeric](21, 0) NULL,
	[Perdida_Ayer] [numeric](21, 0) NULL,
	[tipo_cliente] [char](1) NULL,
	[forma_pago] [char](3) NULL,
	[Articulo84] [numeric](21, 0) NULL,
	[Tipo_Opcion] [char](1) NULL,
	[Valor_USD] [numeric](21, 4) NULL,
	[MX_Recompra] [numeric](21, 4) NULL,
	[Valor_Hoy_Recompra] [numeric](21, 4) NULL,
	[Valor_Inicial_MN_Recompra] [numeric](21, 4) NULL,
	[Reajuste_TC_HOY] [numeric](21, 4) NULL,
	[Rever_Mes_Ant] [numeric](21, 4) NULL,
	[Utilidad_Corte] [numeric](21, 4) NULL,
	[Perdida_Corte] [numeric](21, 4) NULL,
	[Neto_Utilidad_corte] [numeric](21, 4) NULL,
	[Neto_Perdida_corte] [numeric](21, 4) NULL,
	[Acumulado_Utili_Corte] [numeric](21, 4) NULL,
	[Acumulado_Perdid_Corte] [numeric](21, 4) NULL,
	[Delta_Utilidad_Corte] [numeric](21, 4) NULL,
	[Delta_Perdida_Corte] [numeric](21, 4) NULL,
	[cantidad_cortes] [numeric](10, 0) NULL,
	[corte_actual] [numeric](10, 0) NULL,
	[moneda_compra] [numeric](3, 0) NULL,
	[moneda_venta] [numeric](3, 0) NULL,
	[codigo_producto] [numeric](2, 0) NULL,
	[reversa] [numeric](1, 0) NULL,
	[reversa_valorizacion] [numeric](21, 4) NULL,
	[Reversa_Valorizacion_Utilidad] [numeric](21, 4) NULL,
	[Reversa_Valorizacion_Perdida] [numeric](21, 4) NULL,
	[reajuste_UF_ayer] [numeric](21, 0) NOT NULL,
	[Int_Diario_Ganado] [numeric](21, 0) NOT NULL,
	[Int_Diario_Pagado] [numeric](21, 0) NOT NULL,
	[Rea_Diario_Ganado] [numeric](21, 0) NOT NULL,
	[Rea_Diario_Pagado] [numeric](21, 0) NOT NULL,
	[Int_Reversa_Ganado] [numeric](21, 0) NOT NULL,
	[Int_Reversa_Pagado] [numeric](21, 0) NOT NULL,
	[Rea_Reversa_Ganado] [numeric](21, 0) NOT NULL,
	[Rea_Reversa_Pagado] [numeric](21, 0) NOT NULL,
	[Interes_Final_Gana] [numeric](21, 0) NOT NULL,
	[Interes_Final_Paga] [numeric](21, 0) NOT NULL,
	[Reajust_Final_Gana] [numeric](21, 0) NOT NULL,
	[Reajust_Final_Paga] [numeric](21, 0) NOT NULL,
	[UtilidadEFisica] [numeric](21, 4) NULL,
	[PerdidaEFisica] [numeric](21, 4) NULL,
	[cntClasificacionCartera] [int] NULL,
	[CarteraNormativa] [char](5) NOT NULL,
	[SubCarteraNormativa] [numeric](9, 0) NOT NULL,
	[Moneda_FPago] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__id_si__7530A505]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__tipo___7624C93E]  DEFAULT ('') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__tipo___7718ED77]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__opera__780D11B0]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__corre__790135E9]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__codig__79F55A22]  DEFAULT ('') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__moned__7AE97E5B]  DEFAULT ('') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__valor__7BDDA294]  DEFAULT (0) FOR [valor_compra]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__valor__7CD1C6CD]  DEFAULT (0) FOR [valor_venta]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__valor__7DC5EB06]  DEFAULT (0) FOR [valor_presente]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__valor__7EBA0F3F]  DEFAULT (0) FOR [valor_futuro]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__utili__7FAE3378]  DEFAULT (0) FOR [utilidad]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__perdi__00A257B1]  DEFAULT (0) FOR [perdida]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Valor__01967BEA]  DEFAULT (0) FOR [Valorizacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Utili__028AA023]  DEFAULT (0) FOR [Utilidad_Valorizacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Perdi__037EC45C]  DEFAULT (0) FOR [Perdida_Valorizacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Reaju__0472E895]  DEFAULT (0) FOR [Reajuste_UF]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Utili__05670CCE]  DEFAULT (0) FOR [Utilidad_Ayer]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Perdi__065B3107]  DEFAULT (0) FOR [Perdida_Ayer]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__tipo___074F5540]  DEFAULT ('') FOR [tipo_cliente]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__forma__08437979]  DEFAULT ('') FOR [forma_pago]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Artic__09379DB2]  DEFAULT (0) FOR [Articulo84]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Tipo___0A2BC1EB]  DEFAULT ('') FOR [Tipo_Opcion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Valor__0B1FE624]  DEFAULT (0) FOR [Valor_USD]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__MX_Re__0C140A5D]  DEFAULT (0) FOR [MX_Recompra]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Valor__0D082E96]  DEFAULT (0) FOR [Valor_Hoy_Recompra]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Valor__0DFC52CF]  DEFAULT (0) FOR [Valor_Inicial_MN_Recompra]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Reaju__0EF07708]  DEFAULT (0) FOR [Reajuste_TC_HOY]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rever__0FE49B41]  DEFAULT (0) FOR [Rever_Mes_Ant]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Utili__10D8BF7A]  DEFAULT (0) FOR [Utilidad_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Perdi__11CCE3B3]  DEFAULT (0) FOR [Perdida_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Neto___12C107EC]  DEFAULT (0) FOR [Neto_Utilidad_corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Neto___13B52C25]  DEFAULT (0) FOR [Neto_Perdida_corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Acumu__14A9505E]  DEFAULT (0) FOR [Acumulado_Utili_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Acumu__159D7497]  DEFAULT (0) FOR [Acumulado_Perdid_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Delta__169198D0]  DEFAULT (0) FOR [Delta_Utilidad_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Delta__1785BD09]  DEFAULT (0) FOR [Delta_Perdida_Corte]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__canti__1879E142]  DEFAULT (0) FOR [cantidad_cortes]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__corte__196E057B]  DEFAULT (0) FOR [corte_actual]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__moned__1A6229B4]  DEFAULT (0) FOR [moneda_compra]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__moned__1B564DED]  DEFAULT (0) FOR [moneda_venta]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__codig__1C4A7226]  DEFAULT (0) FOR [codigo_producto]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__rever__1D3E965F]  DEFAULT (0) FOR [reversa]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__rever__1E32BA98]  DEFAULT (0) FOR [reversa_valorizacion]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rever__1F26DED1]  DEFAULT (0) FOR [Reversa_Valorizacion_Utilidad]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rever__201B030A]  DEFAULT (0) FOR [Reversa_Valorizacion_Perdida]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__reaju__585CFA28]  DEFAULT (0) FOR [reajuste_UF_ayer]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Int_D__1407CFDB]  DEFAULT (0) FOR [Int_Diario_Ganado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Int_D__14FBF414]  DEFAULT (0) FOR [Int_Diario_Pagado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rea_D__15F0184D]  DEFAULT (0) FOR [Rea_Diario_Ganado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rea_D__16E43C86]  DEFAULT (0) FOR [Rea_Diario_Pagado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Int_R__17D860BF]  DEFAULT (0) FOR [Int_Reversa_Ganado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Int_R__18CC84F8]  DEFAULT (0) FOR [Int_Reversa_Pagado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rea_R__19C0A931]  DEFAULT (0) FOR [Rea_Reversa_Ganado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Rea_R__1AB4CD6A]  DEFAULT (0) FOR [Rea_Reversa_Pagado]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Inter__1BA8F1A3]  DEFAULT (0) FOR [Interes_Final_Gana]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Inter__1C9D15DC]  DEFAULT (0) FOR [Interes_Final_Paga]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Reaju__1D913A15]  DEFAULT (0) FOR [Reajust_Final_Gana]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DF__bac_cnt_c__Reaju__1E855E4E]  DEFAULT (0) FOR [Reajust_Final_Paga]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [df_utilefisica]  DEFAULT (0.0) FOR [UtilidadEFisica]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [df_perdefisica]  DEFAULT (0.0) FOR [PerdidaEFisica]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  DEFAULT (0) FOR [cntClasificacionCartera]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DfbacCntContabiliza_CartNormativa]  DEFAULT ('') FOR [CarteraNormativa]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [DfbacCntContabiliza_SubCartNormativa]  DEFAULT (0) FOR [SubCarteraNormativa]
GO
ALTER TABLE [dbo].[bac_cnt_contabiliza] ADD  CONSTRAINT [df_BAC_CNT_CONTABILIZA_Moneda_FPago]  DEFAULT ((0)) FOR [Moneda_FPago]
GO

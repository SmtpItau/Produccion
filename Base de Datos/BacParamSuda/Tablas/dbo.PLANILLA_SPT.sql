USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PLANILLA_SPT]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLANILLA_SPT](
	[fecha] [datetime] NOT NULL,
	[entidad] [numeric](3, 0) NOT NULL,
	[planilla_fecha] [datetime] NULL,
	[planilla_numero] [numeric](10, 0) NOT NULL,
	[interesado_rut] [numeric](9, 0) NULL,
	[interesado_codigo] [numeric](9, 0) NULL,
	[interesado_nombre] [varchar](30) NULL,
	[interesado_direccion] [varchar](30) NULL,
	[interesado_ciudad] [varchar](20) NULL,
	[operacion_numero] [numeric](7, 0) NULL,
	[operacion_fecha] [datetime] NULL,
	[tipo_documento] [numeric](1, 0) NULL,
	[tipo_operacion_cambio] [numeric](3, 0) NULL,
	[codigo_comercio] [varchar](6) NULL,
	[concepto] [varchar](3) NULL,
	[pais_operacion] [numeric](3, 0) NULL,
	[operacion_moneda] [char](3) NULL,
	[monto_origen] [numeric](19, 4) NULL,
	[paridad] [numeric](19, 8) NULL,
	[monto_dolares] [numeric](19, 4) NULL,
	[tipo_cambio] [numeric](19, 4) NULL,
	[monto_pesos] [numeric](19, 4) NULL,
	[afecto_derivados] [numeric](1, 0) NULL,
	[cantidad_acuerdos] [numeric](1, 0) NULL,
	[autbcch_tipo] [varchar](2) NULL,
	[autbcch_numero] [numeric](6, 0) NULL,
	[autbcch_fecha] [datetime] NULL,
	[rel_institucion] [numeric](3, 0) NULL,
	[rel_fecha] [datetime] NULL,
	[rel_numero] [numeric](7, 0) NOT NULL,
	[rel_arbitraje] [char](1) NULL,
	[ofi_numero_inscripcion] [numeric](8, 0) NULL,
	[ofi_fecha_inscripcion] [datetime] NULL,
	[ofi_fecha_vencimiento] [datetime] NULL,
	[ofi_nombre_financista] [varchar](30) NULL,
	[ofi_fecha_desembolso] [datetime] NULL,
	[ofi_moneda_desembolso] [numeric](3, 0) NULL,
	[ofi_monto_desembolso] [numeric](15, 2) NULL,
	[ofi_impuesto_adicional] [numeric](13, 2) NULL,
	[exp_codigo_aduana] [numeric](3, 0) NULL,
	[exp_declaracion_fecha] [datetime] NULL,
	[exp_declaracion_numero] [varchar](7) NULL,
	[exp_informe_fecha] [datetime] NULL,
	[exp_informe_numero] [varchar](7) NULL,
	[exp_fecha_vence_retorno] [datetime] NULL,
	[exp_valor_bruto] [numeric](15, 2) NULL,
	[exp_comisiones] [numeric](13, 2) NULL,
	[exp_otros_gastos] [numeric](13, 2) NULL,
	[exp_valor_total] [numeric](16, 2) NULL,
	[exp_plazo_financia] [numeric](4, 0) NULL,
	[exp_nombre_comprador] [varchar](30) NULL,
	[imp_informe_fecha] [datetime] NULL,
	[imp_informe_numero] [numeric](6, 0) NULL,
	[imp_declaracion_numero] [varchar](18) NULL,
	[imp_forma_pago] [numeric](2, 0) NULL,
	[imp_embarque_numero] [numeric](8, 0) NULL,
	[imp_embarque_fecha] [datetime] NULL,
	[imp_fecha_vence] [datetime] NULL,
	[imp_valor_mercaderia] [numeric](14, 2) NULL,
	[imp_gastos_fob] [numeric](13, 2) NULL,
	[imp_valor_fob] [numeric](14, 2) NULL,
	[imp_flete] [numeric](13, 2) NULL,
	[imp_seguro] [numeric](13, 2) NULL,
	[imp_valor_cif] [numeric](14, 2) NULL,
	[imp_intereses] [numeric](14, 2) NULL,
	[imp_gastos_bancarios] [numeric](13, 2) NULL,
	[der_numero_contrato] [numeric](8, 0) NULL,
	[der_fecha_inicio] [datetime] NULL,
	[der_fecha_vence] [datetime] NULL,
	[der_instrumento] [numeric](2, 0) NULL,
	[der_precio_contrato] [numeric](11, 4) NULL,
	[der_area_Contable] [numeric](2, 0) NULL,
	[acuerdo_codigo_1] [varchar](7) NULL,
	[acuerdo_numero_1] [varchar](17) NULL,
	[acuerdo_codigo_2] [varchar](7) NULL,
	[acuerdo_numero_2] [varchar](17) NULL,
	[acuerdo_codigo_3] [varchar](7) NULL,
	[acuerdo_numero_3] [varchar](17) NULL,
	[acuerdo_codigo_4] [varchar](7) NULL,
	[acuerdo_numero_4] [varchar](17) NULL,
	[acuerdo_codigo_5] [varchar](7) NULL,
	[acuerdo_numero_5] [varchar](17) NULL,
	[obs_1] [varchar](240) NULL,
	[obs_2] [varchar](240) NULL,
	[obs_3] [varchar](240) NULL,
	[NumeroPlanilla_IBS] [numeric](9, 0) NOT NULL,
 CONSTRAINT [PK_PLANILLA_SPT] PRIMARY KEY CLUSTERED 
(
	[fecha] ASC,
	[entidad] ASC,
	[planilla_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Inter__6F41F62E]  DEFAULT ((0)) FOR [interesado_rut]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Inter__70361A67]  DEFAULT ((0)) FOR [interesado_codigo]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Inter__712A3EA0]  DEFAULT ('') FOR [interesado_nombre]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Inter__721E62D9]  DEFAULT ('') FOR [interesado_direccion]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Inter__73128712]  DEFAULT ('') FOR [interesado_ciudad]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Opera__7406AB4B]  DEFAULT ((0)) FOR [operacion_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Tipo___74FACF84]  DEFAULT ((0)) FOR [tipo_documento]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Tipo___75EEF3BD]  DEFAULT ((0)) FOR [tipo_operacion_cambio]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Codig__76E317F6]  DEFAULT ('') FOR [codigo_comercio]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Conce__77D73C2F]  DEFAULT ('') FOR [concepto]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Pais___78CB6068]  DEFAULT ((0)) FOR [pais_operacion]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Opera__79BF84A1]  DEFAULT ((0)) FOR [operacion_moneda]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Monto__7AB3A8DA]  DEFAULT ((0)) FOR [monto_origen]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Parid__7BA7CD13]  DEFAULT ((0)) FOR [paridad]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Monto__7C9BF14C]  DEFAULT ((0)) FOR [monto_dolares]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Tipo___7D901585]  DEFAULT ((0)) FOR [tipo_cambio]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Monto__7E8439BE]  DEFAULT ((0)) FOR [monto_pesos]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Afect__7F785DF7]  DEFAULT ((0)) FOR [afecto_derivados]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Canti__006C8230]  DEFAULT ((0)) FOR [cantidad_acuerdos]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___AutBC__0160A669]  DEFAULT ('') FOR [autbcch_tipo]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___AutBC__0254CAA2]  DEFAULT ((0)) FOR [autbcch_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Rel_i__0348EEDB]  DEFAULT ((0)) FOR [rel_institucion]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Rel_n__043D1314]  DEFAULT ((0)) FOR [rel_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Rel_a__0531374D]  DEFAULT ('') FOR [rel_arbitraje]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Ofi_n__06255B86]  DEFAULT ((0)) FOR [ofi_numero_inscripcion]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Ofi_n__07197FBF]  DEFAULT ('') FOR [ofi_nombre_financista]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Ofi_m__080DA3F8]  DEFAULT ((0)) FOR [ofi_moneda_desembolso]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Ofi_m__0901C831]  DEFAULT ((0)) FOR [ofi_monto_desembolso]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Ofi_i__09F5EC6A]  DEFAULT ((0)) FOR [ofi_impuesto_adicional]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_c__0AEA10A3]  DEFAULT ((0)) FOR [exp_codigo_aduana]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_d__0BDE34DC]  DEFAULT ('') FOR [exp_declaracion_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_i__0CD25915]  DEFAULT ('') FOR [exp_informe_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_v__0DC67D4E]  DEFAULT ((0)) FOR [exp_valor_bruto]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_c__0EBAA187]  DEFAULT ((0)) FOR [exp_comisiones]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_o__0FAEC5C0]  DEFAULT ((0)) FOR [exp_otros_gastos]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_v__10A2E9F9]  DEFAULT ((0)) FOR [exp_valor_total]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_p__11970E32]  DEFAULT ((0)) FOR [exp_plazo_financia]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Exp_n__128B326B]  DEFAULT ('') FOR [exp_nombre_comprador]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_i__137F56A4]  DEFAULT ((0)) FOR [imp_informe_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_d__14737ADD]  DEFAULT ('') FOR [imp_declaracion_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_f__15679F16]  DEFAULT ((0)) FOR [imp_forma_pago]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_e__165BC34F]  DEFAULT ((0)) FOR [imp_embarque_numero]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_v__174FE788]  DEFAULT ((0)) FOR [imp_valor_mercaderia]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_g__18440BC1]  DEFAULT ((0)) FOR [imp_gastos_fob]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_v__19382FFA]  DEFAULT ((0)) FOR [imp_valor_fob]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_f__1A2C5433]  DEFAULT ((0)) FOR [imp_flete]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_s__1B20786C]  DEFAULT ((0)) FOR [imp_seguro]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_v__1C149CA5]  DEFAULT ((0)) FOR [imp_valor_cif]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_i__1D08C0DE]  DEFAULT ((0)) FOR [imp_intereses]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Imp_g__1DFCE517]  DEFAULT ((0)) FOR [imp_gastos_bancarios]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Der_n__1EF10950]  DEFAULT ((0)) FOR [der_numero_contrato]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Der_i__1FE52D89]  DEFAULT ((0)) FOR [der_instrumento]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Der_p__20D951C2]  DEFAULT ((0)) FOR [der_precio_contrato]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Der_a__21CD75FB]  DEFAULT ((0)) FOR [der_area_Contable]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__22C19A34]  DEFAULT ('') FOR [acuerdo_codigo_1]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__23B5BE6D]  DEFAULT ('') FOR [acuerdo_numero_1]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__24A9E2A6]  DEFAULT ('') FOR [acuerdo_codigo_2]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__259E06DF]  DEFAULT ('') FOR [acuerdo_numero_2]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__26922B18]  DEFAULT ('') FOR [acuerdo_codigo_3]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__27864F51]  DEFAULT ('') FOR [acuerdo_numero_3]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__287A738A]  DEFAULT ('') FOR [acuerdo_codigo_4]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__296E97C3]  DEFAULT ('') FOR [acuerdo_numero_4]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__2A62BBFC]  DEFAULT ('') FOR [acuerdo_codigo_5]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Acuer__2B56E035]  DEFAULT ('') FOR [acuerdo_numero_5]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Obs_1__2C4B046E]  DEFAULT ('') FOR [obs_1]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Obs_2__2D3F28A7]  DEFAULT ('') FOR [obs_2]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [DF__PLANILLA___Obs_3__2E334CE0]  DEFAULT ('') FOR [obs_3]
GO
ALTER TABLE [dbo].[PLANILLA_SPT] ADD  CONSTRAINT [df_Planilla_spt_NumeroPlanilla_IBS]  DEFAULT ((0)) FOR [NumeroPlanilla_IBS]
GO

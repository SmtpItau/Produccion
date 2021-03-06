USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RPTPLANILLAS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPTPLANILLAS](
	[entidad_nombre] [char](40) NOT NULL,
	[planilla_fecha] [datetime] NOT NULL,
	[planilla_numero] [numeric](6, 0) NOT NULL,
	[interesado_rut] [numeric](9, 0) NOT NULL,
	[interesado_codigo] [numeric](9, 0) NOT NULL,
	[interesado_nombre] [varchar](30) NOT NULL,
	[interesado_direccion] [varchar](30) NOT NULL,
	[interesado_ciudad] [varchar](20) NOT NULL,
	[operacion_numero] [numeric](7, 0) NOT NULL,
	[operacion_fecha] [datetime] NOT NULL,
	[tipo_documento] [varchar](50) NOT NULL,
	[tipo_operacion_cambio] [varchar](50) NOT NULL,
	[codigo_comercio] [varchar](6) NOT NULL,
	[concepto] [varchar](3) NOT NULL,
	[pais_operacion] [varchar](40) NOT NULL,
	[operacion_moneda] [varchar](40) NOT NULL,
	[monto_origen] [numeric](15, 2) NOT NULL,
	[paridad] [numeric](11, 4) NOT NULL,
	[monto_dolares] [numeric](15, 2) NOT NULL,
	[tipo_cambio] [numeric](9, 2) NOT NULL,
	[monto_pesos] [numeric](17, 2) NOT NULL,
	[afecto_derivados] [numeric](1, 0) NOT NULL,
	[cantidad_acuerdos] [numeric](1, 0) NOT NULL,
	[autbcch_tipo] [varchar](2) NOT NULL,
	[autbcch_numero] [numeric](6, 0) NOT NULL,
	[autbcch_fecha] [datetime] NOT NULL,
	[rel_institucion] [varchar](50) NOT NULL,
	[rel_fecha] [datetime] NOT NULL,
	[rel_numero] [numeric](6, 0) NOT NULL,
	[rel_arbitraje] [char](1) NOT NULL,
	[ofi_numero_inscripcion] [numeric](8, 0) NOT NULL,
	[ofi_fecha_inscripcion] [datetime] NOT NULL,
	[ofi_fecha_vencimiento] [datetime] NOT NULL,
	[ofi_nombre_financista] [varchar](30) NOT NULL,
	[ofi_fecha_desembolso] [datetime] NOT NULL,
	[ofi_moneda_desembolso] [varchar](50) NOT NULL,
	[ofi_monto_desembolso] [numeric](15, 2) NOT NULL,
	[ofi_impuesto_adicional] [numeric](13, 2) NOT NULL,
	[exp_codigo_aduana] [varchar](50) NOT NULL,
	[exp_declaracion_fecha] [datetime] NOT NULL,
	[exp_declaracion_numero] [varchar](7) NOT NULL,
	[exp_informe_fecha] [datetime] NOT NULL,
	[exp_informe_numero] [varchar](7) NOT NULL,
	[exp_fecha_vence_retorno] [datetime] NOT NULL,
	[exp_valor_bruto] [numeric](15, 2) NOT NULL,
	[exp_comisiones] [numeric](13, 2) NOT NULL,
	[exp_otros_gastos] [numeric](13, 2) NOT NULL,
	[exp_valor_total] [numeric](16, 2) NOT NULL,
	[exp_plazo_financia] [numeric](4, 0) NOT NULL,
	[exp_nombre_comprador] [varchar](30) NOT NULL,
	[imp_informe_fecha] [datetime] NOT NULL,
	[imp_informe_numero] [numeric](6, 0) NOT NULL,
	[imp_declaracion_numero] [varchar](18) NOT NULL,
	[imp_forma_pago] [varchar](50) NOT NULL,
	[imp_embarque_numero] [numeric](8, 0) NOT NULL,
	[imp_embarque_fecha] [datetime] NOT NULL,
	[imp_fecha_vence] [datetime] NOT NULL,
	[imp_valor_mercaderia] [numeric](14, 2) NOT NULL,
	[imp_gastos_fob] [numeric](13, 2) NOT NULL,
	[imp_valor_fob] [numeric](14, 2) NOT NULL,
	[imp_flete] [numeric](13, 2) NOT NULL,
	[imp_seguro] [numeric](13, 2) NOT NULL,
	[imp_valor_cif] [numeric](14, 2) NOT NULL,
	[imp_intereses] [numeric](14, 2) NOT NULL,
	[imp_gastos_bancarios] [numeric](13, 2) NOT NULL,
	[der_numero_contrato] [numeric](8, 0) NOT NULL,
	[der_fecha_inicio] [datetime] NOT NULL,
	[der_fecha_vence] [datetime] NOT NULL,
	[der_instrumento] [varchar](50) NOT NULL,
	[der_precio_contrato] [numeric](11, 4) NOT NULL,
	[der_area_contable] [varchar](50) NOT NULL,
	[acuerdo_codigo_1] [varchar](7) NOT NULL,
	[acuerdo_numero_1] [varchar](17) NOT NULL,
	[acuerdo_codigo_2] [varchar](7) NOT NULL,
	[acuerdo_numero_2] [varchar](17) NOT NULL,
	[acuerdo_codigo_3] [varchar](7) NOT NULL,
	[acuerdo_numero_3] [varchar](17) NOT NULL,
	[acuerdo_codigo_4] [varchar](7) NOT NULL,
	[acuerdo_numero_4] [varchar](17) NOT NULL,
	[acuerdo_codigo_5] [varchar](7) NOT NULL,
	[acuerdo_numero_5] [varchar](17) NOT NULL,
	[obs_1] [varchar](240) NOT NULL,
	[obs_2] [varchar](240) NOT NULL,
	[obs_3] [varchar](240) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__entid__2C88998B]  DEFAULT ('') FOR [entidad_nombre]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__plani__2D7CBDC4]  DEFAULT ('') FOR [planilla_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__plani__2E70E1FD]  DEFAULT (0) FOR [planilla_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__inter__2F650636]  DEFAULT (0) FOR [interesado_rut]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__inter__30592A6F]  DEFAULT (0) FOR [interesado_codigo]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__inter__314D4EA8]  DEFAULT ('') FOR [interesado_nombre]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__inter__324172E1]  DEFAULT ('') FOR [interesado_direccion]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__inter__3335971A]  DEFAULT ('') FOR [interesado_ciudad]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__opera__3429BB53]  DEFAULT (0) FOR [operacion_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__opera__351DDF8C]  DEFAULT ('') FOR [operacion_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__tipo___361203C5]  DEFAULT ('') FOR [tipo_documento]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__tipo___370627FE]  DEFAULT ('') FOR [tipo_operacion_cambio]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__codig__37FA4C37]  DEFAULT ('') FOR [codigo_comercio]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__conce__38EE7070]  DEFAULT ('') FOR [concepto]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__pais___39E294A9]  DEFAULT ('') FOR [pais_operacion]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__opera__3AD6B8E2]  DEFAULT ('') FOR [operacion_moneda]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__monto__3BCADD1B]  DEFAULT (0) FOR [monto_origen]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__parid__3CBF0154]  DEFAULT (0) FOR [paridad]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__monto__3DB3258D]  DEFAULT (0) FOR [monto_dolares]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__tipo___3EA749C6]  DEFAULT (0) FOR [tipo_cambio]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__monto__3F9B6DFF]  DEFAULT (0) FOR [monto_pesos]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__afect__408F9238]  DEFAULT (0) FOR [afecto_derivados]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__canti__4183B671]  DEFAULT (0) FOR [cantidad_acuerdos]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__autBC__4277DAAA]  DEFAULT ('') FOR [autbcch_tipo]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__autBC__436BFEE3]  DEFAULT (0) FOR [autbcch_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__autBC__4460231C]  DEFAULT ('') FOR [autbcch_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__rel_i__45544755]  DEFAULT ('') FOR [rel_institucion]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__rel_f__46486B8E]  DEFAULT ('') FOR [rel_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__rel_n__473C8FC7]  DEFAULT (0) FOR [rel_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__rel_a__4830B400]  DEFAULT ('') FOR [rel_arbitraje]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_n__4924D839]  DEFAULT (0) FOR [ofi_numero_inscripcion]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_f__4A18FC72]  DEFAULT ('') FOR [ofi_fecha_inscripcion]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_f__4B0D20AB]  DEFAULT ('') FOR [ofi_fecha_vencimiento]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_n__4C0144E4]  DEFAULT ('') FOR [ofi_nombre_financista]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_f__4CF5691D]  DEFAULT ('') FOR [ofi_fecha_desembolso]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_m__4DE98D56]  DEFAULT ('') FOR [ofi_moneda_desembolso]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_m__4EDDB18F]  DEFAULT (0) FOR [ofi_monto_desembolso]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__ofi_i__4FD1D5C8]  DEFAULT (0) FOR [ofi_impuesto_adicional]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_c__50C5FA01]  DEFAULT ('') FOR [exp_codigo_aduana]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_d__51BA1E3A]  DEFAULT ('') FOR [exp_declaracion_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_d__52AE4273]  DEFAULT ('') FOR [exp_declaracion_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_i__53A266AC]  DEFAULT ('') FOR [exp_informe_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_i__54968AE5]  DEFAULT ('') FOR [exp_informe_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_f__558AAF1E]  DEFAULT ('') FOR [exp_fecha_vence_retorno]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_v__567ED357]  DEFAULT (0) FOR [exp_valor_bruto]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_c__5772F790]  DEFAULT (0) FOR [exp_comisiones]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_o__58671BC9]  DEFAULT (0) FOR [exp_otros_gastos]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_v__595B4002]  DEFAULT (0) FOR [exp_valor_total]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_p__5A4F643B]  DEFAULT (0) FOR [exp_plazo_financia]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__exp_n__5B438874]  DEFAULT ('') FOR [exp_nombre_comprador]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_i__5C37ACAD]  DEFAULT ('') FOR [imp_informe_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_i__5D2BD0E6]  DEFAULT (0) FOR [imp_informe_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_d__5E1FF51F]  DEFAULT ('') FOR [imp_declaracion_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_f__5F141958]  DEFAULT ('') FOR [imp_forma_pago]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_e__60083D91]  DEFAULT (0) FOR [imp_embarque_numero]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_e__60FC61CA]  DEFAULT ('') FOR [imp_embarque_fecha]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_f__61F08603]  DEFAULT ('') FOR [imp_fecha_vence]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_v__62E4AA3C]  DEFAULT (0) FOR [imp_valor_mercaderia]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_g__63D8CE75]  DEFAULT (0) FOR [imp_gastos_fob]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_v__64CCF2AE]  DEFAULT (0) FOR [imp_valor_fob]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_f__65C116E7]  DEFAULT (0) FOR [imp_flete]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_s__66B53B20]  DEFAULT (0) FOR [imp_seguro]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_v__67A95F59]  DEFAULT (0) FOR [imp_valor_cif]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_i__689D8392]  DEFAULT (0) FOR [imp_intereses]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__imp_g__6991A7CB]  DEFAULT (0) FOR [imp_gastos_bancarios]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_n__6A85CC04]  DEFAULT (0) FOR [der_numero_contrato]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_f__6B79F03D]  DEFAULT ('') FOR [der_fecha_inicio]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_f__6C6E1476]  DEFAULT ('') FOR [der_fecha_vence]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_i__6D6238AF]  DEFAULT ('') FOR [der_instrumento]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_p__6E565CE8]  DEFAULT (0) FOR [der_precio_contrato]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__der_a__6F4A8121]  DEFAULT ('') FOR [der_area_contable]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__703EA55A]  DEFAULT ('') FOR [acuerdo_codigo_1]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__7132C993]  DEFAULT ('') FOR [acuerdo_numero_1]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__7226EDCC]  DEFAULT ('') FOR [acuerdo_codigo_2]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__731B1205]  DEFAULT ('') FOR [acuerdo_numero_2]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__740F363E]  DEFAULT ('') FOR [acuerdo_codigo_3]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__75035A77]  DEFAULT ('') FOR [acuerdo_numero_3]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__75F77EB0]  DEFAULT ('') FOR [acuerdo_codigo_4]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__76EBA2E9]  DEFAULT ('') FOR [acuerdo_numero_4]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__77DFC722]  DEFAULT ('') FOR [acuerdo_codigo_5]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__acuer__78D3EB5B]  DEFAULT ('') FOR [acuerdo_numero_5]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__obs_1__79C80F94]  DEFAULT ('') FOR [obs_1]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__obs_2__7ABC33CD]  DEFAULT ('') FOR [obs_2]
GO
ALTER TABLE [dbo].[RPTPLANILLAS] ADD  CONSTRAINT [DF__rptPlanil__obs_3__7BB05806]  DEFAULT ('') FOR [obs_3]
GO

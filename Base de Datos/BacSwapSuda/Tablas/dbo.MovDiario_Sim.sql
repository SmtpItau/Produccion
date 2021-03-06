USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[MovDiario_Sim]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovDiario_Sim](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NULL,
	[tipo_flujo] [numeric](1, 0) NULL,
	[tipo_swap] [numeric](1, 0) NULL,
	[cartera_inversion] [numeric](1, 0) NULL,
	[tipo_operacion] [char](1) NULL,
	[codigo_cliente] [numeric](9, 0) NULL,
	[rut_cliente] [numeric](9, 0) NULL,
	[fecha_cierre] [datetime] NULL,
	[fecha_inicio] [datetime] NULL,
	[fecha_termino] [datetime] NULL,
	[fecha_inicio_flujo] [datetime] NULL,
	[fecha_vence_flujo] [datetime] NULL,
	[fecha_fijacion_tasa] [datetime] NULL,
	[compra_moneda] [numeric](3, 0) NULL,
	[compra_capital] [numeric](19, 4) NULL,
	[compra_amortiza] [numeric](19, 4) NULL,
	[compra_saldo] [numeric](19, 4) NULL,
	[compra_interes] [numeric](19, 4) NULL,
	[compra_spread] [numeric](10, 6) NULL,
	[compra_codigo_tasa] [numeric](3, 0) NULL,
	[compra_valor_tasa] [numeric](10, 6) NULL,
	[compra_valor_tasa_hoy] [numeric](10, 6) NULL,
	[compra_codamo_capital] [numeric](3, 0) NULL,
	[compra_mesamo_capital] [numeric](3, 0) NULL,
	[compra_codamo_interes] [numeric](3, 0) NULL,
	[compra_mesamo_interes] [numeric](3, 0) NULL,
	[compra_base] [numeric](3, 0) NULL,
	[venta_moneda] [numeric](3, 0) NULL,
	[venta_capital] [numeric](19, 4) NULL,
	[venta_amortiza] [numeric](19, 4) NULL,
	[venta_saldo] [numeric](19, 4) NULL,
	[venta_interes] [numeric](19, 4) NULL,
	[venta_spread] [numeric](10, 6) NULL,
	[venta_codigo_tasa] [numeric](3, 0) NULL,
	[venta_valor_tasa] [numeric](10, 6) NULL,
	[venta_valor_tasa_hoy] [numeric](10, 6) NULL,
	[venta_codamo_capital] [numeric](3, 0) NULL,
	[venta_mesamo_capital] [numeric](3, 0) NULL,
	[venta_codamo_interes] [numeric](3, 0) NULL,
	[venta_mesamo_interes] [numeric](3, 0) NULL,
	[venta_base] [numeric](3, 0) NULL,
	[operador] [char](10) NULL,
	[operador_cliente] [numeric](10, 0) NULL,
	[estado_flujo] [numeric](1, 0) NULL,
	[modalidad_pago] [char](1) NULL,
	[pagamos_moneda] [numeric](3, 0) NULL,
	[pagamos_documento] [numeric](3, 0) NULL,
	[pagamos_monto] [numeric](19, 4) NULL,
	[pagamos_monto_USD] [numeric](19, 4) NULL,
	[pagamos_monto_CLP] [numeric](19, 4) NULL,
	[recibimos_moneda] [numeric](3, 0) NULL,
	[recibimos_documento] [numeric](3, 0) NULL,
	[recibimos_monto] [numeric](19, 4) NULL,
	[recibimos_monto_USD] [numeric](19, 4) NULL,
	[recibimos_monto_CLP] [numeric](19, 4) NULL,
	[observaciones] [char](99) NULL,
	[fecha_modifica] [datetime] NULL,
	[Estado_oper_lineas] [char](1) NULL,
	[Observacion_Lineas] [char](255) NULL,
	[Observacion_Limites] [char](255) NULL,
	[Especial] [numeric](1, 0) NULL,
	[SwImpresion] [numeric](1, 0) NULL,
	[Hora] [char](8) NULL,
	[ParidadCompra] [numeric](21, 4) NULL,
	[ParidadVenta] [numeric](21, 4) NULL,
	[Monto_Spread] [float] NULL,
	[mov_area_responsable] [char](6) NULL,
	[mov_cartera_normativa] [char](6) NULL,
	[mov_subcartera_normativa] [char](6) NULL,
	[mov_libro] [char](6) NULL,
	[FeriadoFlujoChile] [int] NULL,
	[FeriadoFlujoEEUU] [int] NULL,
	[FeriadoFlujoEnglan] [int] NULL,
	[FeriadoLiquiChile] [int] NULL,
	[FeriadoLiquiEEUU] [int] NULL,
	[FeriadoLiquiEnglan] [int] NULL,
	[Convencion] [varchar](25) NULL,
	[DiasReset] [int] NULL,
	[FechaEfectiva] [datetime] NULL,
	[PrimerPago] [datetime] NULL,
	[PenultimoPago] [datetime] NULL,
	[Madurez] [datetime] NULL,
	[Note] [varchar](255) NULL,
	[IntercPrinc] [int] NULL,
	[Tikker] [varchar](255) NULL,
	[FechaLiquidacion] [datetime] NULL,
	[FechaReset] [datetime] NULL,
	[CompraTasaProyectada] [float] NULL,
	[VentaTasaProyectada] [float] NULL,
	[Estado] [char](1) NULL,
	[Ref_Tipo_Cambio] [numeric](19, 0) NULL,
	[Ref_Paridad] [numeric](19, 0) NULL,
	[Ref_Fecha_Fijacion_TC] [datetime] NULL,
	[Ref_Fecha_Fijacion_PAR] [datetime] NULL,
	[Tasa_Transfer] [numeric](19, 5) NULL,
	[Spread_Transfer] [numeric](19, 5) NULL,
	[Res_Mesa_Dist_CLP] [numeric](21, 0) NULL,
	[Res_Mesa_Dist_USD] [numeric](21, 4) NULL,
	[moDigitador] [char](15) NULL,
	[Threshold] [char](1) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__numer__41854D1F]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__numer__42797158]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__tipo___436D9591]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__tipo___4461B9CA]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__carte__4555DE03]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__tipo___464A023C]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__codig__473E2675]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__rut_c__48324AAE]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__49266EE7]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4A1A9320]  DEFAULT (0.0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4B0EB759]  DEFAULT (0.0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4C02DB92]  DEFAULT (0.0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4CF6FFCB]  DEFAULT (0.0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4DEB2404]  DEFAULT (0.0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4EDF483D]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__4FD36C76]  DEFAULT (0.0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__50C790AF]  DEFAULT (0.0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__51BBB4E8]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__52AFD921]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__53A3FD5A]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__54982193]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__compr__558C45CC]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__56806A05]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__57748E3E]  DEFAULT (0.0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5868B277]  DEFAULT (0.0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__595CD6B0]  DEFAULT (0.0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5A50FAE9]  DEFAULT (0.0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5B451F22]  DEFAULT (0.0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5C39435B]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5D2D6794]  DEFAULT (0.0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5E218BCD]  DEFAULT (0.0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__5F15B006]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__6009D43F]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__60FDF878]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__61F21CB1]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__venta__62E640EA]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__opera__63DA6523]  DEFAULT ('') FOR [operador]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__opera__64CE895C]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__estad__65C2AD95]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__modal__66B6D1CE]  DEFAULT ('') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__pagam__67AAF607]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__pagam__689F1A40]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__pagam__69933E79]  DEFAULT (0.0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__pagam__6A8762B2]  DEFAULT (0.0) FOR [pagamos_monto_USD]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__pagam__6B7B86EB]  DEFAULT (0.0) FOR [pagamos_monto_CLP]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__recib__6C6FAB24]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__recib__6D63CF5D]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__recib__6E57F396]  DEFAULT (0.0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__recib__6F4C17CF]  DEFAULT (0.0) FOR [recibimos_monto_USD]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__recib__70403C08]  DEFAULT (0.0) FOR [recibimos_monto_CLP]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__obser__71346041]  DEFAULT ('') FOR [observaciones]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Estad__7228847A]  DEFAULT ('') FOR [Estado_oper_lineas]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Obser__731CA8B3]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Obser__7410CCEC]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Espec__7504F125]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__SwImp__75F9155E]  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario___Hora__76ED3997]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Parid__77E15DD0]  DEFAULT (0.0) FOR [ParidadCompra]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Parid__78D58209]  DEFAULT (0.0) FOR [ParidadVenta]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Monto__79C9A642]  DEFAULT (0.0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__mov_a__7ABDCA7B]  DEFAULT ('') FOR [mov_area_responsable]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__mov_c__7BB1EEB4]  DEFAULT ('') FOR [mov_cartera_normativa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__mov_s__7CA612ED]  DEFAULT ('') FOR [mov_subcartera_normativa]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__mov_l__7D9A3726]  DEFAULT ('') FOR [mov_libro]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__7E8E5B5F]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__7F827F98]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__0076A3D1]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__016AC80A]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__025EEC43]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Feria__0353107C]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Conve__044734B5]  DEFAULT ('') FOR [Convencion]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__DiasR__053B58EE]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario___Note__062F7D27]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Inter__0723A160]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Tikke__0817C599]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Compr__090BE9D2]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Venta__0A000E0B]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Estad__0AF43244]  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Ref_T__0BE8567D]  DEFAULT (0) FOR [Ref_Tipo_Cambio]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Ref_P__0CDC7AB6]  DEFAULT (0) FOR [Ref_Paridad]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Tasa___0DD09EEF]  DEFAULT (0.0) FOR [Tasa_Transfer]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Sprea__0EC4C328]  DEFAULT (0.0) FOR [Spread_Transfer]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Res_M__0FB8E761]  DEFAULT (0) FOR [Res_Mesa_Dist_CLP]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Res_M__10AD0B9A]  DEFAULT (0.0) FOR [Res_Mesa_Dist_USD]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__moDig__11A12FD3]  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[MovDiario_Sim] ADD  CONSTRAINT [DF__MovDiario__Thres__1295540C]  DEFAULT ('N') FOR [Threshold]
GO

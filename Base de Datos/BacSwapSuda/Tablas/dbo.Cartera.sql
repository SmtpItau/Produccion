USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[Cartera]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cartera](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NOT NULL,
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[tipo_swap] [numeric](1, 0) NOT NULL,
	[cartera_inversion] [numeric](2, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[fecha_cierre] [datetime] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_termino] [datetime] NOT NULL,
	[fecha_inicio_flujo] [datetime] NOT NULL,
	[fecha_vence_flujo] [datetime] NOT NULL,
	[fecha_fijacion_tasa] [datetime] NOT NULL,
	[compra_moneda] [numeric](3, 0) NOT NULL,
	[compra_capital] [numeric](19, 4) NOT NULL,
	[compra_amortiza] [numeric](19, 4) NOT NULL,
	[compra_saldo] [numeric](19, 4) NOT NULL,
	[compra_interes] [numeric](19, 4) NOT NULL,
	[compra_spread] [numeric](10, 6) NOT NULL,
	[compra_codigo_tasa] [numeric](3, 0) NOT NULL,
	[compra_valor_tasa] [numeric](10, 6) NOT NULL,
	[compra_valor_tasa_hoy] [numeric](10, 6) NOT NULL,
	[compra_codamo_capital] [numeric](3, 0) NOT NULL,
	[compra_mesamo_capital] [numeric](3, 0) NOT NULL,
	[compra_codamo_interes] [numeric](3, 0) NOT NULL,
	[compra_mesamo_interes] [numeric](3, 0) NOT NULL,
	[compra_base] [numeric](3, 0) NOT NULL,
	[venta_moneda] [numeric](3, 0) NOT NULL,
	[venta_capital] [numeric](19, 4) NOT NULL,
	[venta_amortiza] [numeric](19, 4) NOT NULL,
	[venta_saldo] [numeric](19, 4) NOT NULL,
	[venta_interes] [numeric](19, 4) NOT NULL,
	[venta_spread] [numeric](10, 6) NOT NULL,
	[venta_codigo_tasa] [numeric](3, 0) NOT NULL,
	[venta_valor_tasa] [numeric](10, 6) NOT NULL,
	[venta_valor_tasa_hoy] [numeric](10, 6) NOT NULL,
	[venta_codamo_capital] [numeric](3, 0) NOT NULL,
	[venta_mesamo_capital] [numeric](3, 0) NOT NULL,
	[venta_codamo_interes] [numeric](3, 0) NOT NULL,
	[venta_mesamo_interes] [numeric](3, 0) NOT NULL,
	[venta_base] [numeric](3, 0) NOT NULL,
	[operador] [char](10) NOT NULL,
	[operador_cliente] [numeric](10, 0) NOT NULL,
	[estado_flujo] [numeric](1, 0) NOT NULL,
	[modalidad_pago] [char](1) NOT NULL,
	[pagamos_moneda] [numeric](3, 0) NOT NULL,
	[pagamos_documento] [numeric](3, 0) NOT NULL,
	[pagamos_monto] [numeric](19, 4) NOT NULL,
	[pagamos_monto_USD] [numeric](19, 4) NOT NULL,
	[pagamos_monto_CLP] [numeric](19, 4) NOT NULL,
	[recibimos_moneda] [numeric](3, 0) NOT NULL,
	[recibimos_documento] [numeric](3, 0) NOT NULL,
	[recibimos_monto] [numeric](19, 4) NOT NULL,
	[recibimos_monto_USD] [numeric](19, 4) NOT NULL,
	[recibimos_monto_CLP] [numeric](19, 4) NOT NULL,
	[observaciones] [char](99) NOT NULL,
	[fecha_modifica] [datetime] NOT NULL,
	[devengo_dias] [numeric](9, 0) NULL,
	[devengo_monto] [numeric](19, 4) NOT NULL,
	[devengo_monto_peso] [numeric](20, 0) NOT NULL,
	[devengo_monto_acum] [numeric](19, 4) NOT NULL,
	[devengo_monto_ayer] [numeric](19, 4) NOT NULL,
	[devengo_compra] [numeric](19, 4) NOT NULL,
	[devengo_compra_acum] [numeric](19, 4) NOT NULL,
	[devengo_compra_acum_peso] [numeric](19, 0) NOT NULL,
	[devengo_compra_ayer] [numeric](19, 4) NOT NULL,
	[devengo_compra_ayer_peso] [numeric](19, 0) NOT NULL,
	[devengo_venta] [numeric](19, 4) NOT NULL,
	[devengo_venta_acum] [numeric](19, 4) NOT NULL,
	[devengo_venta_acum_peso] [numeric](19, 0) NOT NULL,
	[devengo_venta_ayer] [numeric](19, 4) NOT NULL,
	[devengo_venta_ayer_peso] [numeric](19, 0) NOT NULL,
	[fecha_valoriza] [datetime] NOT NULL,
	[compra_zcr] [float] NOT NULL,
	[compra_mercado_tasa] [float] NOT NULL,
	[compra_mercado] [numeric](19, 4) NOT NULL,
	[compra_mercado_usd] [numeric](19, 4) NOT NULL,
	[compra_mercado_clp] [numeric](19, 4) NOT NULL,
	[compra_duration_tasa] [float] NOT NULL,
	[compra_duration_monto] [numeric](19, 4) NOT NULL,
	[compra_duration_monto_usd] [numeric](19, 4) NOT NULL,
	[compra_duration_monto_clp] [numeric](19, 0) NOT NULL,
	[compra_valor_presente] [numeric](19, 4) NOT NULL,
	[venta_zcr] [float] NOT NULL,
	[venta_mercado_tasa] [float] NOT NULL,
	[venta_mercado] [numeric](19, 4) NOT NULL,
	[venta_mercado_usd] [numeric](19, 4) NOT NULL,
	[venta_mercado_clp] [numeric](19, 4) NOT NULL,
	[venta_duration_tasa] [float] NOT NULL,
	[venta_duration_monto] [numeric](19, 4) NOT NULL,
	[venta_duration_monto_usd] [numeric](19, 4) NOT NULL,
	[venta_duration_monto_clp] [numeric](19, 0) NOT NULL,
	[venta_valor_presente] [numeric](19, 4) NOT NULL,
	[monto_mtm] [numeric](19, 4) NOT NULL,
	[monto_mtm_usd] [numeric](19, 4) NOT NULL,
	[monto_mtm_clp] [numeric](19, 4) NOT NULL,
	[compra_valorizada] [numeric](19, 4) NOT NULL,
	[compra_variacion] [numeric](19, 4) NOT NULL,
	[venta_valorizada] [numeric](19, 4) NOT NULL,
	[venta_variacion] [numeric](19, 4) NOT NULL,
	[valorizacion_dia] [numeric](19, 4) NOT NULL,
	[estado] [char](1) NOT NULL,
	[Estado_oper_lineas] [char](1) NOT NULL,
	[Observacion_Lineas] [char](255) NOT NULL,
	[Observacion_Limites] [char](255) NOT NULL,
	[Especial] [numeric](1, 0) NOT NULL,
	[Capital_Pesos_Actual] [numeric](21, 0) NOT NULL,
	[Capital_Pesos_Ayer] [numeric](21, 0) NOT NULL,
	[Hora] [char](8) NOT NULL,
	[Tasa_Compra_Curva] [numeric](12, 8) NOT NULL,
	[Tasa_Venta_Curva] [numeric](12, 8) NOT NULL,
	[Activo_MO_C08] [numeric](19, 4) NOT NULL,
	[Pasivo_MO_C08] [numeric](19, 4) NOT NULL,
	[Activo_USD_C08] [numeric](19, 4) NOT NULL,
	[Pasivo_USD_C08] [numeric](19, 4) NOT NULL,
	[Activo_CLP_C08] [numeric](19, 0) NOT NULL,
	[Pasivo_CLP_C08] [numeric](19, 0) NOT NULL,
	[Tasa_Compra_CurvaVR] [numeric](12, 8) NOT NULL,
	[Tasa_Venta_CurvaVR] [numeric](12, 8) NOT NULL,
	[Activo_FlujoMO] [numeric](19, 4) NOT NULL,
	[Activo_FlujoUSD] [numeric](19, 4) NOT NULL,
	[Activo_FlujoCLP] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoMO] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoUSD] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoCLP] [numeric](19, 4) NOT NULL,
	[Valor_RazonableMO] [numeric](19, 4) NOT NULL,
	[Valor_RazonableUSD] [numeric](19, 4) NOT NULL,
	[Valor_RazonableCLP] [numeric](19, 4) NOT NULL,
	[Monto_Spread] [float] NOT NULL,
	[Monto_diferido_inicial] [float] NOT NULL,
	[Monto_diferido_diario] [float] NOT NULL,
	[Monto_diferido_acumulado] [float] NOT NULL,
	[TC_MO_Inicial] [float] NOT NULL,
	[Monto_TC_Diario] [float] NOT NULL,
	[Monto_TC_Acumulado] [float] NOT NULL,
	[Monto_Reajuste_Diario] [float] NOT NULL,
	[Monto_Reajuste_Acumulado] [float] NOT NULL,
	[Monto_Valorizacion] [float] NOT NULL,
	[Monto_Capital_TC_ini] [float] NOT NULL,
	[car_area_Responsable] [char](6) NULL,
	[car_Cartera_Normativa] [char](6) NULL,
	[car_SubCartera_Normativa] [char](6) NULL,
	[car_Libro] [char](6) NULL,
	[DevAntPromCam] [float] NULL,
	[vRazAjustado_Mo] [numeric](21, 4) NOT NULL,
	[vRazAjustado_Mn] [numeric](21, 4) NOT NULL,
	[vRazAjustado_Do] [numeric](21, 4) NOT NULL,
	[vRazActivoAjus_Mo] [numeric](21, 4) NOT NULL,
	[vRazPasivoAjus_Mo] [numeric](21, 4) NOT NULL,
	[vRazActivoAjus_Mn] [numeric](21, 0) NOT NULL,
	[vRazPasivoAjus_Mn] [numeric](21, 0) NOT NULL,
	[vRazActivoAjus_Do] [numeric](21, 4) NOT NULL,
	[vRazPasivoAjus_Do] [numeric](21, 4) NOT NULL,
	[vTasaActivaAjusta] [numeric](21, 4) NOT NULL,
	[vTasaPasivaAjusta] [numeric](21, 4) NOT NULL,
	[vDurMacaulActivo] [float] NOT NULL,
	[vDurMacaulPasivo] [float] NOT NULL,
	[vDurModifiActivo] [float] NOT NULL,
	[vDurModifiPasivo] [float] NOT NULL,
	[vDurConvexActivo] [float] NOT NULL,
	[vDurConvexPasivo] [float] NOT NULL,
	[FeriadoFlujoChile] [int] NOT NULL,
	[FeriadoFlujoEEUU] [int] NOT NULL,
	[FeriadoFlujoEnglan] [int] NOT NULL,
	[FeriadoLiquiChile] [int] NOT NULL,
	[FeriadoLiquiEEUU] [int] NOT NULL,
	[FeriadoLiquiEnglan] [int] NOT NULL,
	[Convencion] [varchar](25) NOT NULL,
	[DiasReset] [int] NOT NULL,
	[FechaEfectiva] [datetime] NOT NULL,
	[PrimerPago] [datetime] NOT NULL,
	[PenultimoPago] [datetime] NOT NULL,
	[Madurez] [datetime] NOT NULL,
	[Note] [varchar](255) NOT NULL,
	[IntercPrinc] [int] NOT NULL,
	[Tikker] [varchar](255) NOT NULL,
	[FechaLiquidacion] [datetime] NOT NULL,
	[FechaReset] [datetime] NOT NULL,
	[CompraTasaProyectada] [float] NOT NULL,
	[VentaTasaProyectada] [float] NOT NULL,
	[estado_sinacofi] [char](50) NULL,
	[fecha_sinacofi] [datetime] NULL,
	[Moneda_Valorizacion] [numeric](5, 0) NULL,
	[Valor_Mercado_Activo_Mda_Val] [numeric](18, 6) NULL,
	[Devengo_Recibido_Mda_Val] [numeric](18, 6) NULL,
	[Valor_Mercado_Pasivo_Mda_Val] [numeric](18, 6) NULL,
	[Devengo_Pagar_Mda_Val] [numeric](18, 6) NULL,
	[Principal_Mda_Val] [numeric](18, 6) NULL,
	[Devengo_Neto_Mda_Val] [numeric](18, 6) NULL,
	[Valor_Mercado_Mda_Val] [numeric](18, 6) NULL,
	[Porcentaje_Margen] [numeric](10, 6) NULL,
	[Monto_Margen] [numeric](18, 6) NULL,
	[Monto_Margen_CLP] [numeric](18, 6) NULL,
	[OrigenCurva] [char](2) NOT NULL,
	[ActivoTir] [float] NOT NULL,
	[PasivoTir] [float] NOT NULL,
	[ActivoTirCnv] [float] NOT NULL,
	[PasivoTirCnv] [float] NOT NULL,
	[FxRate] [float] NOT NULL,
	[Compra_amortiza_Prc] [float] NOT NULL,
	[Venta_amortiza_Prc] [float] NOT NULL,
	[Compra_Flujo_Adicional] [float] NOT NULL,
	[Venta_Flujo_Adicional] [float] NOT NULL,
	[FechaValuta] [datetime] NOT NULL,
	[CompraPerResetCod] [numeric](10, 0) NOT NULL,
	[VentaPerResetCod] [numeric](10, 0) NOT NULL,
	[CompraLiqDefault] [char](7) NOT NULL,
	[VentaLiqDefault] [char](7) NOT NULL,
	[CompraResetDefault] [char](7) NOT NULL,
	[VentaResetDefault] [char](7) NOT NULL,
	[Compra_DV01_Forward] [float] NOT NULL,
	[Venta_DV01_Forward] [float] NOT NULL,
	[Compra_DV01_Descuento] [float] NOT NULL,
	[Venta_DV01_Descuento] [float] NOT NULL,
	[Compra_curva_TIR] [varchar](20) NOT NULL,
	[Venta_curva_TIR] [varchar](20) NOT NULL,
	[Compra_Curva_Descont] [varchar](20) NOT NULL,
	[Venta_Curva_Descont] [varchar](20) NOT NULL,
	[Compra_Curva_Forward] [varchar](20) NOT NULL,
	[Venta_Curva_Forward] [varchar](20) NOT NULL,
	[Monto_LCR_Matriz] [numeric](15, 0) NOT NULL,
	[Monto_LCR_Ajuste_AVR] [numeric](15, 0) NOT NULL,
	[Trader_Contraparte] [varchar](60) NOT NULL,
	[Especifica_Negocio] [varchar](60) NOT NULL,
	[Compra_Tasa_Forward_larga] [float] NOT NULL,
	[Compra_Tasa_Forward_corta] [float] NOT NULL,
	[PlazoFlujo] [numeric](10, 0) NOT NULL,
	[PortaFolio] [varchar](80) NOT NULL,
	[Threshold] [char](1) NOT NULL,
	[bEarlyTermination] [bit] NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[Periodicidad] [tinyint] NOT NULL,
	[ReferenciaUSDCLP] [int] NULL,
	[ReferenciaMEXUSD] [int] NULL,
	[FechaUSDCLP] [date] NULL,
	[FechaMEXUSD] [date] NULL,
	[InterNocIni] [bit] NOT NULL,
	[InterNocFin] [bit] NOT NULL,
 CONSTRAINT [PK_Cartera] PRIMARY KEY NONCLUSTERED 
(
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__numero___554B8353]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__numero___563FA78C]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_tipo_flujo]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__tipo_sw__5733CBC5]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__cartera__5827EFFE]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__tipo_op__591C1437]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__codigo___5A103870]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_c__5B045CA9]  DEFAULT ('') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_i__5BF880E2]  DEFAULT ('') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_t__5CECA51B]  DEFAULT ('') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_i__5DE0C954]  DEFAULT ('') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_v__5ED4ED8D]  DEFAULT ('') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_fecha_fijacion_tasa]  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___5FC911C6]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___60BD35FF]  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___61B15A38]  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___62A57E71]  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___6399A2AA]  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___648DC6E3]  DEFAULT (0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___6581EB1C]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___66760F55]  DEFAULT (0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___676A338E]  DEFAULT (0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___685E57C7]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___69527C00]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___6A46A039]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___6B3AC472]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___6C2EE8AB]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__6D230CE4]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_c__6E17311D]  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_a__6F0B5556]  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_s__6FFF798F]  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_i__70F39DC8]  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_s__71E7C201]  DEFAULT (0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_c__72DBE63A]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_v__73D00A73]  DEFAULT (0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_v__74C42EAC]  DEFAULT (0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_c__75B852E5]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__76AC771E]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_c__77A09B57]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__7894BF90]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_b__7988E3C9]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__operado__7A7D0802]  DEFAULT ('') FOR [operador]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__operado__7B712C3B]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__estado___7C655074]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__modalid__7D5974AD]  DEFAULT ('') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__pagamos__7E4D98E6]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__pagamos__7F41BD1F]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__pagamos__0035E158]  DEFAULT (0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__pagamos__012A0591]  DEFAULT (0) FOR [pagamos_monto_USD]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__pagamos__021E29CA]  DEFAULT (0) FOR [pagamos_monto_CLP]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__recibim__03124E03]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__recibim__0406723C]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__recibim__04FA9675]  DEFAULT (0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__recibim__05EEBAAE]  DEFAULT (0) FOR [recibimos_monto_USD]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__recibim__06E2DEE7]  DEFAULT (0) FOR [recibimos_monto_CLP]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__observa__07D70320]  DEFAULT ('') FOR [observaciones]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_m__08CB2759]  DEFAULT ('') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__09BF4B92]  DEFAULT (0) FOR [devengo_dias]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0AB36FCB]  DEFAULT (0) FOR [devengo_monto]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_devengo_monto_peso]  DEFAULT (0) FOR [devengo_monto_peso]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0BA79404]  DEFAULT (0) FOR [devengo_monto_acum]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0C9BB83D]  DEFAULT (0) FOR [devengo_monto_ayer]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0D8FDC76]  DEFAULT (0) FOR [devengo_compra]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0E8400AF]  DEFAULT (0) FOR [devengo_compra_acum]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_devengo_compra_acum_peso]  DEFAULT (0) FOR [devengo_compra_acum_peso]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__0F7824E8]  DEFAULT (0) FOR [devengo_compra_ayer]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_devengo_compra_ayer_peso]  DEFAULT (0) FOR [devengo_compra_ayer_peso]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__106C4921]  DEFAULT (0) FOR [devengo_venta]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__11606D5A]  DEFAULT (0) FOR [devengo_venta_acum]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_devengo_venta_acum_peso]  DEFAULT (0) FOR [devengo_venta_acum_peso]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__devengo__12549193]  DEFAULT (0) FOR [devengo_venta_ayer]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_devengo_venta_ayer_peso]  DEFAULT (0) FOR [devengo_venta_ayer_peso]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__fecha_v__1348B5CC]  DEFAULT ('') FOR [fecha_valoriza]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___143CDA05]  DEFAULT (0) FOR [compra_zcr]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___1530FE3E]  DEFAULT (0) FOR [compra_mercado_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___16252277]  DEFAULT (0) FOR [compra_mercado]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___171946B0]  DEFAULT (0) FOR [compra_mercado_usd]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___180D6AE9]  DEFAULT (0) FOR [compra_mercado_clp]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___19018F22]  DEFAULT (0) FOR [compra_duration_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___19F5B35B]  DEFAULT (0) FOR [compra_duration_monto]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___1AE9D794]  DEFAULT (0) FOR [compra_duration_monto_usd]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___1BDDFBCD]  DEFAULT (0) FOR [compra_duration_monto_clp]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___1CD22006]  DEFAULT (0) FOR [compra_valor_presente]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_z__1DC6443F]  DEFAULT (0) FOR [venta_zcr]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__1EBA6878]  DEFAULT (0) FOR [venta_mercado_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__1FAE8CB1]  DEFAULT (0) FOR [venta_mercado]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__20A2B0EA]  DEFAULT (0) FOR [venta_mercado_usd]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_m__2196D523]  DEFAULT (0) FOR [venta_mercado_clp]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_d__228AF95C]  DEFAULT (0) FOR [venta_duration_tasa]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_d__237F1D95]  DEFAULT (0) FOR [venta_duration_monto]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_d__247341CE]  DEFAULT (0) FOR [venta_duration_monto_usd]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_d__25676607]  DEFAULT (0) FOR [venta_duration_monto_clp]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_v__265B8A40]  DEFAULT (0) FOR [venta_valor_presente]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__monto_m__274FAE79]  DEFAULT (0) FOR [monto_mtm]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__monto_m__2843D2B2]  DEFAULT (0) FOR [monto_mtm_usd]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__monto_m__2937F6EB]  DEFAULT (0) FOR [monto_mtm_clp]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___2A2C1B24]  DEFAULT (0) FOR [compra_valorizada]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__compra___2B203F5D]  DEFAULT (0) FOR [compra_variacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_v__2C146396]  DEFAULT (0) FOR [venta_valorizada]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__venta_v__2D0887CF]  DEFAULT (0) FOR [venta_variacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__valoriz__2DFCAC08]  DEFAULT (0) FOR [valorizacion_dia]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF__Cartera__estado__2EF0D041]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Estado_oper_lineas]  DEFAULT ('') FOR [Estado_oper_lineas]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Observacion_Lineas]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Observacion_Limites]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Especial]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Capital_Pesos_Actual]  DEFAULT (0) FOR [Capital_Pesos_Actual]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_Capital_Pesos_Ayer]  DEFAULT (0) FOR [Capital_Pesos_Ayer]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Tasa_Compra_Curva]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Tasa_Venta_Curva]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_MO_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_MO_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_USD_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_USD_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_CLP_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_CLP_C08]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Tasa_Compra_CurvaVR]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Tasa_Venta_CurvaVR]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_FlujoMO]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_FlujoUSD]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Activo_FlujoCLP]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_FlujoMO]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_FlujoUSD]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Pasivo_FlujoCLP]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Valor_RazonableMO]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Valor_RazonableUSD]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Valor_RazonableCLP]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_diferido_inicial]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_diferido_diario]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_diferido_acumulado]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [TC_MO_Inicial]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_TC_Diario]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_TC_Acumulado]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_Reajuste_Diario]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_Reajuste_Acumulado]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_Valorizacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_Capital_TC_ini]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [car_area_Responsable]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [car_Cartera_Normativa]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [car_SubCartera_Normativa]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [car_Libro]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [DevAntPromCam]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazAjustado_Mo]  DEFAULT (0.0) FOR [vRazAjustado_Mo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazAjustado_Mn]  DEFAULT (0.0) FOR [vRazAjustado_Mn]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazAjustado_Do]  DEFAULT (0.0) FOR [vRazAjustado_Do]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazActivoAjus_Mo]  DEFAULT (0.0) FOR [vRazActivoAjus_Mo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazPasivoAjus_Mo]  DEFAULT (0.0) FOR [vRazPasivoAjus_Mo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazActivoAjus_Mn]  DEFAULT (0.0) FOR [vRazActivoAjus_Mn]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazPasivoAjus_Mn]  DEFAULT (0.0) FOR [vRazPasivoAjus_Mn]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazActivoAjus_Do]  DEFAULT (0.0) FOR [vRazActivoAjus_Do]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vRazPasivoAjus_Do]  DEFAULT (0.0) FOR [vRazPasivoAjus_Do]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vTasaActivaAjusta]  DEFAULT (0.0) FOR [vTasaActivaAjusta]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vTasaPasivaAjusta]  DEFAULT (0.0) FOR [vTasaPasivaAjusta]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurMacaulActivo]  DEFAULT (0.0) FOR [vDurMacaulActivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurMacaulPasivo]  DEFAULT (0.0) FOR [vDurMacaulPasivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurModifiActivo]  DEFAULT (0.0) FOR [vDurModifiActivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurModifiPasivo]  DEFAULT (0.0) FOR [vDurModifiPasivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurConvexActivo]  DEFAULT (0.0) FOR [vDurConvexActivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_cartera_vDurConvexPasivo]  DEFAULT (0.0) FOR [vDurConvexPasivo]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerFluj_Chi]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerFluj_Usa]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerFluj_Eng]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerLiqu_Chi]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerLiqu_Usa]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFerLiqu_Eng]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartConvencion]  DEFAULT ('Siguiente Modificado') FOR [Convencion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartDiasReset]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartFechaEfectiva]  DEFAULT ('19000101') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartPrimerPago]  DEFAULT ('19000101') FOR [PrimerPago]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartPenultimoPago]  DEFAULT ('19000101') FOR [PenultimoPago]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartMadurez]  DEFAULT ('19000101') FOR [Madurez]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartNote]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartIntercPrinc]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartTikker]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartReset]  DEFAULT ('') FOR [FechaReset]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartComTasProy]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCartVenTasProy]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [dfCart_OrigenCurva]  DEFAULT ('') FOR [OrigenCurva]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [ActivoTir]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [PasivoTir]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [ActivoTirCnv]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [PasivoTirCnv]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [FxRate]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_amortiza_Prc]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Venta_amortiza_Prc]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_Flujo_Adicional]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Venta_Flujo_Adicional]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('19000101') FOR [FechaValuta]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [CompraPerResetCod]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [VentaPerResetCod]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [CompraLiqDefault]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [VentaLiqDefault]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [CompraResetDefault]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [VentaResetDefault]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_DV01_Forward]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Venta_DV01_Forward]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_DV01_Descuento]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Venta_DV01_Descuento]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Compra_curva_TIR]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Venta_curva_TIR]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Compra_Curva_Descont]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Venta_Curva_Descont]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Compra_Curva_Forward]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Venta_Curva_Forward]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_LCR_Matriz]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [Monto_LCR_Ajuste_AVR]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Trader_Contraparte]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [Especifica_Negocio]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_Tasa_Forward_larga]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0.0) FOR [Compra_Tasa_Forward_corta]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT (0) FOR [PlazoFlujo]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('') FOR [PortaFolio]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [df_CARTERA_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[Cartera] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_InterNocIni]  DEFAULT ((0)) FOR [InterNocIni]
GO
ALTER TABLE [dbo].[Cartera] ADD  CONSTRAINT [DF_Cartera_InterNocFin]  DEFAULT ((0)) FOR [InterNocFin]
GO

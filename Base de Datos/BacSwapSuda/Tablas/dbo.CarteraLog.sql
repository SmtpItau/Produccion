USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[CarteraLog]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarteraLog](
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
	[devengo_monto_peso] [numeric](20, 0) NOT NULL,
	[devengo_monto] [numeric](19, 4) NOT NULL,
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
	[log_area_responsable] [char](6) NULL,
	[log_Cartera_normativa] [char](6) NULL,
	[log_subcartera_normativa] [char](6) NULL,
	[log_libro] [char](6) NULL,
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
	[InterNocFin] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__numer__0C66AE13]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__numer__0D5AD24C]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_tipo_flujo]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__tipo___0E4EF685]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__carte__0F431ABE]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__tipo___10373EF7]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__codig__112B6330]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__121F8769]  DEFAULT ('') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__1313ABA2]  DEFAULT ('') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__1407CFDB]  DEFAULT ('') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__14FBF414]  DEFAULT ('') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__15F0184D]  DEFAULT ('') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_fecha_fijacion_tasa]  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__16E43C86]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__17D860BF]  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__18CC84F8]  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__19C0A931]  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1AB4CD6A]  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1BA8F1A3]  DEFAULT (0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1C9D15DC]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1D913A15]  DEFAULT (0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1E855E4E]  DEFAULT (0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__1F798287]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__206DA6C0]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__2161CAF9]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__2255EF32]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__234A136B]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__243E37A4]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__25325BDD]  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__26268016]  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__271AA44F]  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__280EC888]  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2902ECC1]  DEFAULT (0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__29F710FA]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2AEB3533]  DEFAULT (0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2BDF596C]  DEFAULT (0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2CD37DA5]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2DC7A1DE]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2EBBC617]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__2FAFEA50]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__30A40E89]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__opera__319832C2]  DEFAULT ('') FOR [operador]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__opera__328C56FB]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__estad__33807B34]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__modal__34749F6D]  DEFAULT ('') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__pagam__3568C3A6]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__pagam__365CE7DF]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__pagam__37510C18]  DEFAULT (0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__pagam__38453051]  DEFAULT (0) FOR [pagamos_monto_USD]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__pagam__3939548A]  DEFAULT (0) FOR [pagamos_monto_CLP]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__recib__3A2D78C3]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__recib__3B219CFC]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__recib__3C15C135]  DEFAULT (0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__recib__3D09E56E]  DEFAULT (0) FOR [recibimos_monto_USD]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__recib__3DFE09A7]  DEFAULT (0) FOR [recibimos_monto_CLP]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__obser__3EF22DE0]  DEFAULT ('') FOR [observaciones]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__3FE65219]  DEFAULT ('') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__40DA7652]  DEFAULT (0) FOR [devengo_dias]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_devengo_monto_peso]  DEFAULT (0) FOR [devengo_monto_peso]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__41CE9A8B]  DEFAULT (0) FOR [devengo_monto]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__42C2BEC4]  DEFAULT (0) FOR [devengo_monto_acum]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__43B6E2FD]  DEFAULT (0) FOR [devengo_monto_ayer]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__44AB0736]  DEFAULT (0) FOR [devengo_compra]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__459F2B6F]  DEFAULT (0) FOR [devengo_compra_acum]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_devengo_compra_acum_peso]  DEFAULT (0) FOR [devengo_compra_acum_peso]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__46934FA8]  DEFAULT (0) FOR [devengo_compra_ayer]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_devengo_compra_ayer_peso]  DEFAULT (0) FOR [devengo_compra_ayer_peso]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__478773E1]  DEFAULT (0) FOR [devengo_venta]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__487B981A]  DEFAULT (0) FOR [devengo_venta_acum]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_devengo_venta_acum_peso]  DEFAULT (0) FOR [devengo_venta_acum_peso]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__deven__496FBC53]  DEFAULT (0) FOR [devengo_venta_ayer]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_devengo_venta_ayer_peso]  DEFAULT (0) FOR [devengo_venta_ayer_peso]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__fecha__4A63E08C]  DEFAULT ('') FOR [fecha_valoriza]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__4B5804C5]  DEFAULT (0) FOR [compra_zcr]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__4C4C28FE]  DEFAULT (0) FOR [compra_mercado_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__4D404D37]  DEFAULT (0) FOR [compra_mercado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__4E347170]  DEFAULT (0) FOR [compra_mercado_usd]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__4F2895A9]  DEFAULT (0) FOR [compra_mercado_clp]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__501CB9E2]  DEFAULT (0) FOR [compra_duration_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__5110DE1B]  DEFAULT (0) FOR [compra_duration_monto]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__52050254]  DEFAULT (0) FOR [compra_duration_monto_usd]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__52F9268D]  DEFAULT (0) FOR [compra_duration_monto_clp]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__53ED4AC6]  DEFAULT (0) FOR [compra_valor_presente]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__54E16EFF]  DEFAULT (0) FOR [venta_zcr]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__55D59338]  DEFAULT (0) FOR [venta_mercado_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__56C9B771]  DEFAULT (0) FOR [venta_mercado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__57BDDBAA]  DEFAULT (0) FOR [venta_mercado_usd]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__58B1FFE3]  DEFAULT (0) FOR [venta_mercado_clp]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__59A6241C]  DEFAULT (0) FOR [venta_duration_tasa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__5A9A4855]  DEFAULT (0) FOR [venta_duration_monto]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__5B8E6C8E]  DEFAULT (0) FOR [venta_duration_monto_usd]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__5C8290C7]  DEFAULT (0) FOR [venta_duration_monto_clp]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__5D76B500]  DEFAULT (0) FOR [venta_valor_presente]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__monto__5E6AD939]  DEFAULT (0) FOR [monto_mtm]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__monto__5F5EFD72]  DEFAULT (0) FOR [monto_mtm_usd]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__monto__605321AB]  DEFAULT (0) FOR [monto_mtm_clp]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__614745E4]  DEFAULT (0) FOR [compra_valorizada]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__compr__623B6A1D]  DEFAULT (0) FOR [compra_variacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__632F8E56]  DEFAULT (0) FOR [venta_valorizada]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__venta__6423B28F]  DEFAULT (0) FOR [venta_variacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__valor__6517D6C8]  DEFAULT (0) FOR [valorizacion_dia]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF__CarteraLo__estad__660BFB01]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Estado_oper_lineas]  DEFAULT ('') FOR [Estado_oper_lineas]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Observacion_Lineas]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Observacion_Limites]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Especial]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Capital_Pesos_Actual]  DEFAULT (0) FOR [Capital_Pesos_Actual]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_Capital_Pesos_Ayer]  DEFAULT (0) FOR [Capital_Pesos_Ayer]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Tasa_Compra_Curva]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Tasa_Venta_Curva]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_MO_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_MO_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_USD_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_USD_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_CLP_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_CLP_C08]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Tasa_Compra_CurvaVR]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Tasa_Venta_CurvaVR]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_FlujoMO]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_FlujoUSD]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Activo_FlujoCLP]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_FlujoMO]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_FlujoUSD]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Pasivo_FlujoCLP]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Valor_RazonableMO]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Valor_RazonableUSD]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Valor_RazonableCLP]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_diferido_inicial]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_diferido_diario]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_diferido_acumulado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [TC_MO_Inicial]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_TC_Diario]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_TC_Acumulado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_Reajuste_Diario]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_Reajuste_Acumulado]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_Valorizacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_Capital_TC_ini]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [log_area_responsable]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [log_Cartera_normativa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [log_subcartera_normativa]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [log_libro]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [DevAntPromCam]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazAjustado_Mo]  DEFAULT (0.0) FOR [vRazAjustado_Mo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazAjustado_Mn]  DEFAULT (0.0) FOR [vRazAjustado_Mn]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazAjustado_Do]  DEFAULT (0.0) FOR [vRazAjustado_Do]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazActivoAjus_Mo]  DEFAULT (0.0) FOR [vRazActivoAjus_Mo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazPasivoAjus_Mo]  DEFAULT (0.0) FOR [vRazPasivoAjus_Mo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazActivoAjus_Mn]  DEFAULT (0.0) FOR [vRazActivoAjus_Mn]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazPasivoAjus_Mn]  DEFAULT (0.0) FOR [vRazPasivoAjus_Mn]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazActivoAjus_Do]  DEFAULT (0.0) FOR [vRazActivoAjus_Do]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vRazPasivoAjus_Do]  DEFAULT (0.0) FOR [vRazPasivoAjus_Do]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vTasaActivaAjusta]  DEFAULT (0.0) FOR [vTasaActivaAjusta]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vTasaPasivaAjusta]  DEFAULT (0.0) FOR [vTasaPasivaAjusta]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurMacaulActivo]  DEFAULT (0.0) FOR [vDurMacaulActivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurMacaulPasivo]  DEFAULT (0.0) FOR [vDurMacaulPasivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurModifiActivo]  DEFAULT (0.0) FOR [vDurModifiActivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurModifiPasivo]  DEFAULT (0.0) FOR [vDurModifiPasivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurConvexActivo]  DEFAULT (0.0) FOR [vDurConvexActivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_carteraLog_vDurConvexPasivo]  DEFAULT (0.0) FOR [vDurConvexPasivo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerFluj_Chi]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerFluj_Usa]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerFluj_Eng]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerLiqu_Chi]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerLiqu_Usa]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFerLiqu_Eng]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogConvencion]  DEFAULT ('Siguiente Modificado') FOR [Convencion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogDiasReset]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogFechaEfectiva]  DEFAULT ('19000101') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogPrimerPago]  DEFAULT ('19000101') FOR [PrimerPago]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogPenultimoPago]  DEFAULT ('19000101') FOR [PenultimoPago]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogMadurez]  DEFAULT ('19000101') FOR [Madurez]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogNote]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogIntercPrinc]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogTikker]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogReset]  DEFAULT ('') FOR [FechaReset]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogComTasProy]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCLogVenTasProy]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [dfCarLog_OrigenCurva]  DEFAULT ('') FOR [OrigenCurva]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [ActivoTir]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [PasivoTir]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [ActivoTirCnv]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [PasivoTirCnv]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [FxRate]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_amortiza_Prc]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Venta_amortiza_Prc]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_Flujo_Adicional]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Venta_Flujo_Adicional]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('19000101') FOR [FechaValuta]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [CompraPerResetCod]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [VentaPerResetCod]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [CompraLiqDefault]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [VentaLiqDefault]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [CompraResetDefault]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [VentaResetDefault]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_DV01_Forward]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Venta_DV01_Forward]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_DV01_Descuento]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Venta_DV01_Descuento]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Compra_curva_TIR]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Venta_curva_TIR]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Compra_Curva_Descont]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Venta_Curva_Descont]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Compra_Curva_Forward]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Venta_Curva_Forward]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_LCR_Matriz]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [Monto_LCR_Ajuste_AVR]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Trader_Contraparte]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [Especifica_Negocio]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_Tasa_Forward_larga]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0.0) FOR [Compra_Tasa_Forward_corta]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT (0) FOR [PlazoFlujo]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('') FOR [PortaFolio]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [df_CARTERALOG_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_Carteralog_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_InterNocIni]  DEFAULT ((0)) FOR [InterNocIni]
GO
ALTER TABLE [dbo].[CarteraLog] ADD  CONSTRAINT [DF_CarteraLog_InterNocFin]  DEFAULT ((0)) FOR [InterNocFin]
GO

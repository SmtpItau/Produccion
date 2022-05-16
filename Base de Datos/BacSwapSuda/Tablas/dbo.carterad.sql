USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[carterad]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carterad](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NOT NULL,
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[tipo_swap] [numeric](1, 0) NOT NULL,
	[cartera_inversion] [numeric](1, 0) NOT NULL,
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
	[devengo_dias] [numeric](3, 0) NOT NULL,
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
	[PortaFolio] [varchar](80) NOT NULL
) ON [PRIMARY]
GO

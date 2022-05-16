USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[CARTERA_UNWIND]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_UNWIND](
	[FechaAnticipo] [datetime] NOT NULL,
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
	[pagamos_monto_usd] [numeric](19, 4) NOT NULL,
	[pagamos_monto_clp] [numeric](19, 4) NOT NULL,
	[recibimos_moneda] [numeric](3, 0) NOT NULL,
	[recibimos_documento] [numeric](3, 0) NOT NULL,
	[recibimos_monto] [numeric](19, 4) NOT NULL,
	[recibimos_monto_usd] [numeric](19, 4) NOT NULL,
	[recibimos_monto_clp] [numeric](19, 4) NOT NULL,
	[observaciones] [char](99) NOT NULL,
	[fecha_modifica] [datetime] NOT NULL,
	[devengo_dias] [numeric](9, 0) NOT NULL,
	[devengo_monto] [numeric](19, 4) NULL,
	[devengo_monto_peso] [numeric](20, 0) NULL,
	[devengo_monto_acum] [numeric](19, 4) NULL,
	[devengo_monto_ayer] [numeric](19, 4) NULL,
	[devengo_compra] [numeric](19, 4) NULL,
	[devengo_compra_acum] [numeric](19, 4) NULL,
	[devengo_compra_acum_peso] [numeric](19, 0) NULL,
	[devengo_compra_ayer] [numeric](19, 4) NULL,
	[devengo_compra_ayer_peso] [numeric](19, 0) NULL,
	[devengo_venta] [numeric](19, 4) NULL,
	[devengo_venta_acum] [numeric](19, 4) NULL,
	[devengo_venta_acum_peso] [numeric](19, 0) NULL,
	[devengo_venta_ayer] [numeric](19, 4) NULL,
	[devengo_venta_ayer_peso] [numeric](19, 0) NULL,
	[fecha_valoriza] [datetime] NOT NULL,
	[compra_zcr] [float] NULL,
	[compra_mercado_tasa] [float] NULL,
	[compra_mercado] [numeric](19, 4) NULL,
	[compra_mercado_usd] [numeric](19, 4) NULL,
	[compra_mercado_clp] [numeric](19, 4) NULL,
	[compra_duration_tasa] [float] NULL,
	[compra_duration_monto] [numeric](19, 4) NULL,
	[compra_duration_monto_usd] [numeric](19, 4) NULL,
	[compra_duration_monto_clp] [numeric](19, 0) NULL,
	[compra_valor_presente] [numeric](19, 4) NULL,
	[venta_zcr] [float] NULL,
	[venta_mercado_tasa] [float] NULL,
	[venta_mercado] [numeric](19, 4) NULL,
	[venta_mercado_usd] [numeric](19, 4) NULL,
	[venta_mercado_clp] [numeric](19, 4) NULL,
	[venta_duration_tasa] [float] NULL,
	[venta_duration_monto] [numeric](19, 4) NULL,
	[venta_duration_monto_usd] [numeric](19, 4) NULL,
	[venta_duration_monto_clp] [numeric](19, 0) NULL,
	[venta_valor_presente] [numeric](19, 4) NULL,
	[monto_mtm] [numeric](19, 4) NULL,
	[monto_mtm_usd] [numeric](19, 4) NULL,
	[monto_mtm_clp] [numeric](19, 4) NULL,
	[compra_valorizada] [numeric](19, 4) NULL,
	[compra_variacion] [numeric](19, 4) NULL,
	[venta_valorizada] [numeric](19, 4) NULL,
	[venta_variacion] [numeric](19, 4) NULL,
	[valorizacion_dia] [numeric](19, 4) NULL,
	[estado] [char](1) NULL,
	[estado_oper_lineas] [char](1) NULL,
	[Observacion_Lineas] [char](255) NULL,
	[Observacion_Limites] [char](255) NULL,
	[Especial] [numeric](1, 0) NULL,
	[Capital_Pesos_Actual] [numeric](21, 0) NULL,
	[Capital_Pesos_Ayer] [numeric](21, 0) NULL,
	[Hora] [char](8) NULL,
	[Tasa_Compra_Curva] [numeric](12, 8) NULL,
	[Tasa_Venta_Curva] [numeric](12, 8) NULL,
	[Activo_MO_C08] [numeric](19, 4) NULL,
	[Pasivo_MO_C08] [numeric](19, 4) NULL,
	[Activo_USD_C08] [numeric](19, 4) NULL,
	[Pasivo_USD_C08] [numeric](19, 4) NULL,
	[Activo_CLP_C08] [numeric](19, 0) NULL,
	[Pasivo_CLP_C08] [numeric](19, 0) NULL,
	[Tasa_Compra_CurvaVR] [numeric](12, 8) NULL,
	[Tasa_Venta_CurvaVR] [numeric](12, 8) NULL,
	[Activo_FlujoMO] [numeric](19, 4) NULL,
	[Activo_FlujoUSD] [numeric](19, 4) NULL,
	[Activo_FlujoCLP] [numeric](19, 4) NULL,
	[Pasivo_FlujoMO] [numeric](19, 4) NULL,
	[Pasivo_FlujoUSD] [numeric](19, 4) NULL,
	[Pasivo_FlujoCLP] [numeric](19, 4) NULL,
	[Valor_RazonableMO] [numeric](19, 4) NULL,
	[Valor_RazonableUSD] [numeric](19, 4) NULL,
	[Valor_RazonableCLP] [numeric](19, 4) NULL,
	[Monto_Spread] [float] NULL,
	[Monto_diferido_inicial] [float] NULL,
	[Monto_diferido_diario] [float] NULL,
	[Monto_diferido_acumulado] [float] NULL,
	[TC_MO_Inicial] [float] NULL,
	[Monto_TC_Diario] [float] NULL,
	[Monto_TC_Acumulado] [float] NULL,
	[Monto_Reajuste_Diario] [float] NULL,
	[Monto_Reajuste_Acumulado] [float] NULL,
	[Monto_Valorizacion] [float] NULL,
	[Monto_Capital_TC_ini] [float] NULL,
	[car_area_Responsable] [char](6) NOT NULL,
	[car_Cartera_Normativa] [char](6) NOT NULL,
	[car_SubCartera_Normativa] [char](6) NOT NULL,
	[car_Libro] [char](6) NOT NULL,
	[DevAntPromCam] [float] NULL,
	[vRazAjustado_Mo] [numeric](21, 4) NULL,
	[vRazAjustado_Mn] [numeric](21, 4) NULL,
	[vRazAjustado_Do] [numeric](21, 4) NULL,
	[vRazActivoAjus_Mo] [numeric](21, 4) NULL,
	[vRazPasivoAjus_Mo] [numeric](21, 4) NULL,
	[vRazActivoAjus_Mn] [numeric](21, 0) NULL,
	[vRazPasivoAjus_Mn] [numeric](21, 0) NULL,
	[vRazActivoAjus_Do] [numeric](21, 4) NULL,
	[vRazPasivoAjus_Do] [numeric](21, 4) NULL,
	[vTasaActivaAjusta] [numeric](21, 4) NULL,
	[vTasaPasivaAjusta] [numeric](21, 4) NULL,
	[vDurMacaulActivo] [float] NULL,
	[vDurMacaulPasivo] [float] NULL,
	[vDurModifiActivo] [float] NULL,
	[vDurModifiPasivo] [float] NULL,
	[vDurConvexActivo] [float] NULL,
	[vDurConvexPasivo] [float] NULL,
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
	[fechareset] [datetime] NULL,
	[CompraTasaProyectada] [float] NULL,
	[VentaTasaProyectada] [float] NULL,
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
	[OrigenCurva] [char](2) NULL,
	[ActivoTir] [float] NULL,
	[PasivoTir] [float] NULL,
	[ActivoTirCnv] [float] NULL,
	[PasivoTirCnv] [float] NULL,
	[FxRate] [float] NULL,
	[Compra_amortiza_Prc] [float] NULL,
	[Venta_amortiza_Prc] [float] NULL,
	[Compra_Flujo_Adicional] [float] NULL,
	[Venta_Flujo_Adicional] [float] NULL,
	[FechaValuta] [datetime] NULL,
	[CompraPerResetCod] [numeric](10, 0) NULL,
	[VentaPerResetCod] [numeric](10, 0) NULL,
	[CompraLiqDefault] [char](7) NULL,
	[VentaLiqDefault] [char](7) NULL,
	[CompraResetDefault] [char](7) NULL,
	[VentaResetDefault] [char](7) NULL,
	[Compra_DV01_Forward] [float] NULL,
	[Venta_DV01_Forward] [float] NULL,
	[Compra_DV01_Descuento] [float] NULL,
	[Venta_DV01_Descuento] [float] NULL,
	[Compra_curva_TIR] [varchar](20) NULL,
	[Venta_curva_TIR] [varchar](20) NULL,
	[Compra_Curva_Descont] [varchar](20) NULL,
	[Venta_Curva_Descont] [varchar](20) NULL,
	[Compra_Curva_Forward] [varchar](20) NULL,
	[Venta_Curva_Forward] [varchar](20) NULL,
	[Monto_LCR_Matriz] [numeric](15, 0) NULL,
	[Monto_LCR_Ajuste_AVR] [numeric](15, 0) NULL,
	[Trader_Contraparte] [varchar](60) NULL,
	[Especifica_Negocio] [varchar](60) NULL,
	[Compra_Tasa_Forward_larga] [float] NULL,
	[Compra_Tasa_Forward_corta] [float] NULL,
	[PlazoFlujo] [numeric](10, 0) NULL,
	[PortaFolio] [varchar](80) NULL,
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
 CONSTRAINT [Pk_dbo.CARTERA_UNWIND] PRIMARY KEY CLUSTERED 
(
	[FechaAnticipo] ASC,
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FechaAnticipo]  DEFAULT ('') FOR [FechaAnticipo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_numero_operacion]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_numero_flujo]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_tipo_flujo]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_tipo_swap]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_cartera_inversion]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_tipo_operacion]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_codigo_cliente]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_cierre]  DEFAULT ('') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_inicio]  DEFAULT ('') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_termino]  DEFAULT ('') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_inicio_flujo]  DEFAULT ('') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_vence_flujo]  DEFAULT ('') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_fijacion_tasa]  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_moneda]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_capital]  DEFAULT (0.0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_amortiza]  DEFAULT (0.0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_saldo]  DEFAULT (0.0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_interes]  DEFAULT (0.0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_spread]  DEFAULT (0.0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_codigo_tasa]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_valor_tasa]  DEFAULT (0.0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_valor_tasa_hoy]  DEFAULT (0.0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_codamo_capital]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mesamo_capital]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_codamo_interes]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mesamo_interes]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_base]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_moneda]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_capital]  DEFAULT (0.0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_amortiza]  DEFAULT (0.0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_saldo]  DEFAULT (0.0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_interes]  DEFAULT (0.0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_spread]  DEFAULT (0.0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_codigo_tasa]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_valor_tasa]  DEFAULT (0.0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_valor_tasa_hoy]  DEFAULT (0.0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_codamo_capital]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mesamo_capital]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_codamo_interes]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mesamo_interes]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_base]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_operador]  DEFAULT ('') FOR [operador]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_operador_cliente]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_estado_flujo]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_modalidad_pago]  DEFAULT ('') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_pagamos_moneda]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_pagamos_documento]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_pagamos_monto]  DEFAULT (0.0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_pagamos_monto_usd]  DEFAULT (0.0) FOR [pagamos_monto_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_pagamos_monto_clp]  DEFAULT (0.0) FOR [pagamos_monto_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_recibimos_moneda]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_recibimos_documento]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_recibimos_monto]  DEFAULT (0.0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_recibimos_monto_usd]  DEFAULT (0.0) FOR [recibimos_monto_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_recibimos_monto_clp]  DEFAULT (0.0) FOR [recibimos_monto_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_observaciones]  DEFAULT ('') FOR [observaciones]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_modifica]  DEFAULT ('') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_dias]  DEFAULT (0) FOR [devengo_dias]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_monto]  DEFAULT (0.0) FOR [devengo_monto]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_monto_peso]  DEFAULT (0) FOR [devengo_monto_peso]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_monto_acum]  DEFAULT (0.0) FOR [devengo_monto_acum]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_monto_ayer]  DEFAULT (0.0) FOR [devengo_monto_ayer]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_compra]  DEFAULT (0.0) FOR [devengo_compra]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_compra_acum]  DEFAULT (0.0) FOR [devengo_compra_acum]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_compra_acum_peso]  DEFAULT (0) FOR [devengo_compra_acum_peso]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_compra_ayer]  DEFAULT (0.0) FOR [devengo_compra_ayer]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_compra_ayer_peso]  DEFAULT (0) FOR [devengo_compra_ayer_peso]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_venta]  DEFAULT (0.0) FOR [devengo_venta]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_venta_acum]  DEFAULT (0.0) FOR [devengo_venta_acum]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_venta_acum_peso]  DEFAULT (0) FOR [devengo_venta_acum_peso]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_venta_ayer]  DEFAULT (0.0) FOR [devengo_venta_ayer]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_devengo_venta_ayer_peso]  DEFAULT (0) FOR [devengo_venta_ayer_peso]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_valoriza]  DEFAULT ('') FOR [fecha_valoriza]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_zcr]  DEFAULT (0.0) FOR [compra_zcr]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mercado_tasa]  DEFAULT (0.0) FOR [compra_mercado_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mercado]  DEFAULT (0.0) FOR [compra_mercado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mercado_usd]  DEFAULT (0.0) FOR [compra_mercado_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_mercado_clp]  DEFAULT (0.0) FOR [compra_mercado_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_duration_tasa]  DEFAULT (0.0) FOR [compra_duration_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_duration_monto]  DEFAULT (0.0) FOR [compra_duration_monto]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_duration_monto_usd]  DEFAULT (0.0) FOR [compra_duration_monto_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_duration_monto_clp]  DEFAULT (0) FOR [compra_duration_monto_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_valor_presente]  DEFAULT (0.0) FOR [compra_valor_presente]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_zcr]  DEFAULT (0.0) FOR [venta_zcr]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mercado_tasa]  DEFAULT (0.0) FOR [venta_mercado_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mercado]  DEFAULT (0.0) FOR [venta_mercado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mercado_usd]  DEFAULT (0.0) FOR [venta_mercado_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_mercado_clp]  DEFAULT (0.0) FOR [venta_mercado_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_duration_tasa]  DEFAULT (0.0) FOR [venta_duration_tasa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_duration_monto]  DEFAULT (0.0) FOR [venta_duration_monto]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_duration_monto_usd]  DEFAULT (0.0) FOR [venta_duration_monto_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_duration_monto_clp]  DEFAULT (0.0) FOR [venta_duration_monto_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_valor_presente]  DEFAULT (0.0) FOR [venta_valor_presente]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_monto_mtm]  DEFAULT (0.0) FOR [monto_mtm]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_monto_mtm_usd]  DEFAULT (0.0) FOR [monto_mtm_usd]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_monto_mtm_clp]  DEFAULT (0.0) FOR [monto_mtm_clp]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_valorizada]  DEFAULT (0.0) FOR [compra_valorizada]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_compra_variacion]  DEFAULT (0.0) FOR [compra_variacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_valorizada]  DEFAULT (0.0) FOR [venta_valorizada]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_venta_variacion]  DEFAULT (0.0) FOR [venta_variacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_valorizacion_dia]  DEFAULT (0.0) FOR [valorizacion_dia]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_estado]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_estado_oper_lineas]  DEFAULT ('') FOR [estado_oper_lineas]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Observacion_Lineas]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Observacion_Limites]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Especial]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Capital_Pesos_Actual]  DEFAULT (0) FOR [Capital_Pesos_Actual]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Capital_Pesos_Ayer]  DEFAULT (0) FOR [Capital_Pesos_Ayer]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Hora]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Tasa_Compra_Curva]  DEFAULT (0.0) FOR [Tasa_Compra_Curva]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Tasa_Venta_Curva]  DEFAULT (0.0) FOR [Tasa_Venta_Curva]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_MO_C08]  DEFAULT (0.0) FOR [Activo_MO_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_MO_C08]  DEFAULT (0.0) FOR [Pasivo_MO_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_USD_C08]  DEFAULT (0.0) FOR [Activo_USD_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_USD_C08]  DEFAULT (0.0) FOR [Pasivo_USD_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_CLP_C08]  DEFAULT (0) FOR [Activo_CLP_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_CLP_C08]  DEFAULT (0) FOR [Pasivo_CLP_C08]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Tasa_Compra_CurvaVR]  DEFAULT (0.0) FOR [Tasa_Compra_CurvaVR]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Tasa_Venta_CurvaVR]  DEFAULT (0.0) FOR [Tasa_Venta_CurvaVR]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_FlujoMO]  DEFAULT (0.0) FOR [Activo_FlujoMO]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_FlujoUSD]  DEFAULT (0.0) FOR [Activo_FlujoUSD]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Activo_FlujoCLP]  DEFAULT (0.0) FOR [Activo_FlujoCLP]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_FlujoMO]  DEFAULT (0.0) FOR [Pasivo_FlujoMO]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_FlujoUSD]  DEFAULT (0.0) FOR [Pasivo_FlujoUSD]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Pasivo_FlujoCLP]  DEFAULT (0.0) FOR [Pasivo_FlujoCLP]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_RazonableMO]  DEFAULT (0.0) FOR [Valor_RazonableMO]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_RazonableUSD]  DEFAULT (0.0) FOR [Valor_RazonableUSD]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_RazonableCLP]  DEFAULT (0.0) FOR [Valor_RazonableCLP]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Spread]  DEFAULT (0.0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_diferido_inicial]  DEFAULT (0.0) FOR [Monto_diferido_inicial]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_diferido_diario]  DEFAULT (0.0) FOR [Monto_diferido_diario]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_diferido_acumulado]  DEFAULT (0.0) FOR [Monto_diferido_acumulado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_TC_MO_Inicial]  DEFAULT (0.0) FOR [TC_MO_Inicial]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_TC_Diario]  DEFAULT (0.0) FOR [Monto_TC_Diario]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_TC_Acumulado]  DEFAULT (0.0) FOR [Monto_TC_Acumulado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Reajuste_Diario]  DEFAULT (0.0) FOR [Monto_Reajuste_Diario]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Reajuste_Acumulado]  DEFAULT (0.0) FOR [Monto_Reajuste_Acumulado]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Valorizacion]  DEFAULT (0.0) FOR [Monto_Valorizacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Capital_TC_ini]  DEFAULT (0.0) FOR [Monto_Capital_TC_ini]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_car_area_Responsable]  DEFAULT ('') FOR [car_area_Responsable]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_car_Cartera_Normativa]  DEFAULT ('') FOR [car_Cartera_Normativa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_car_SubCartera_Normativa]  DEFAULT ('') FOR [car_SubCartera_Normativa]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_car_Libro]  DEFAULT ('') FOR [car_Libro]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_DevAntPromCam]  DEFAULT (0.0) FOR [DevAntPromCam]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazAjustado_Mo]  DEFAULT (0.0) FOR [vRazAjustado_Mo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazAjustado_Mn]  DEFAULT (0.0) FOR [vRazAjustado_Mn]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazAjustado_Do]  DEFAULT (0.0) FOR [vRazAjustado_Do]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazActivoAjus_Mo]  DEFAULT (0.0) FOR [vRazActivoAjus_Mo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazPasivoAjus_Mo]  DEFAULT (0.0) FOR [vRazPasivoAjus_Mo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazActivoAjus_Mn]  DEFAULT (0) FOR [vRazActivoAjus_Mn]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazPasivoAjus_Mn]  DEFAULT (0) FOR [vRazPasivoAjus_Mn]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazActivoAjus_Do]  DEFAULT (0.0) FOR [vRazActivoAjus_Do]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vRazPasivoAjus_Do]  DEFAULT (0.0) FOR [vRazPasivoAjus_Do]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vTasaActivaAjusta]  DEFAULT (0.0) FOR [vTasaActivaAjusta]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vTasaPasivaAjusta]  DEFAULT (0.0) FOR [vTasaPasivaAjusta]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurMacaulActivo]  DEFAULT (0.0) FOR [vDurMacaulActivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurMacaulPasivo]  DEFAULT (0.0) FOR [vDurMacaulPasivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurModifiActivo]  DEFAULT (0.0) FOR [vDurModifiActivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurModifiPasivo]  DEFAULT (0.0) FOR [vDurModifiPasivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurConvexActivo]  DEFAULT (0.0) FOR [vDurConvexActivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_vDurConvexPasivo]  DEFAULT (0.0) FOR [vDurConvexPasivo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoFlujoChile]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoFlujoEEUU]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoFlujoEnglan]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoLiquiChile]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoLiquiEEUU]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FeriadoLiquiEnglan]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Convencion]  DEFAULT ('') FOR [Convencion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_DiasReset]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FechaEfectiva]  DEFAULT ('') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PrimerPago]  DEFAULT ('') FOR [PrimerPago]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PenultimoPago]  DEFAULT ('') FOR [PenultimoPago]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Madurez]  DEFAULT ('') FOR [Madurez]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Note]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_IntercPrinc]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Tikker]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FechaLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fechareset]  DEFAULT ('') FOR [fechareset]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_CompraTasaProyectada]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_VentaTasaProyectada]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_estado_sinacofi]  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_fecha_sinacofi]  DEFAULT ('') FOR [fecha_sinacofi]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Moneda_Valorizacion]  DEFAULT (0) FOR [Moneda_Valorizacion]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_Mercado_Activo_Mda_Val]  DEFAULT (0.0) FOR [Valor_Mercado_Activo_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Devengo_Recibido_Mda_Val]  DEFAULT (0.0) FOR [Devengo_Recibido_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_Mercado_Pasivo_Mda_Val]  DEFAULT (0.0) FOR [Valor_Mercado_Pasivo_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Devengo_Pagar_Mda_Val]  DEFAULT (0.0) FOR [Devengo_Pagar_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Principal_Mda_Val]  DEFAULT (0.0) FOR [Principal_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Devengo_Neto_Mda_Val]  DEFAULT (0.0) FOR [Devengo_Neto_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Valor_Mercado_Mda_Val]  DEFAULT (0.0) FOR [Valor_Mercado_Mda_Val]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Porcentaje_Margen]  DEFAULT (0.0) FOR [Porcentaje_Margen]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Margen]  DEFAULT (0.0) FOR [Monto_Margen]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_Margen_CLP]  DEFAULT (0.0) FOR [Monto_Margen_CLP]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_OrigenCurva]  DEFAULT ('') FOR [OrigenCurva]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_ActivoTir]  DEFAULT (0.0) FOR [ActivoTir]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PasivoTir]  DEFAULT (0.0) FOR [PasivoTir]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_ActivoTirCnv]  DEFAULT (0.0) FOR [ActivoTirCnv]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PasivoTirCnv]  DEFAULT (0.0) FOR [PasivoTirCnv]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FxRate]  DEFAULT (0.0) FOR [FxRate]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_amortiza_Prc]  DEFAULT (0.0) FOR [Compra_amortiza_Prc]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_amortiza_Prc]  DEFAULT (0.0) FOR [Venta_amortiza_Prc]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_Flujo_Adicional]  DEFAULT (0.0) FOR [Compra_Flujo_Adicional]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_Flujo_Adicional]  DEFAULT (0.0) FOR [Venta_Flujo_Adicional]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_FechaValuta]  DEFAULT ('') FOR [FechaValuta]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_CompraPerResetCod]  DEFAULT (0) FOR [CompraPerResetCod]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_VentaPerResetCod]  DEFAULT (0) FOR [VentaPerResetCod]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_CompraLiqDefault]  DEFAULT ('') FOR [CompraLiqDefault]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_VentaLiqDefault]  DEFAULT ('') FOR [VentaLiqDefault]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_CompraResetDefault]  DEFAULT ('') FOR [CompraResetDefault]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_VentaResetDefault]  DEFAULT ('') FOR [VentaResetDefault]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_DV01_Forward]  DEFAULT (0.0) FOR [Compra_DV01_Forward]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_DV01_Forward]  DEFAULT (0.0) FOR [Venta_DV01_Forward]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_DV01_Descuento]  DEFAULT (0.0) FOR [Compra_DV01_Descuento]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_DV01_Descuento]  DEFAULT (0.0) FOR [Venta_DV01_Descuento]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_curva_TIR]  DEFAULT ('') FOR [Compra_curva_TIR]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_curva_TIR]  DEFAULT ('') FOR [Venta_curva_TIR]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_Curva_Descont]  DEFAULT ('') FOR [Compra_Curva_Descont]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_Curva_Descont]  DEFAULT ('') FOR [Venta_Curva_Descont]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_Curva_Forward]  DEFAULT ('') FOR [Compra_Curva_Forward]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Venta_Curva_Forward]  DEFAULT ('') FOR [Venta_Curva_Forward]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_LCR_Matriz]  DEFAULT (0) FOR [Monto_LCR_Matriz]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Monto_LCR_Ajuste_AVR]  DEFAULT (0) FOR [Monto_LCR_Ajuste_AVR]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Trader_Contraparte]  DEFAULT ('') FOR [Trader_Contraparte]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Especifica_Negocio]  DEFAULT ('') FOR [Especifica_Negocio]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_Tasa_Forward_larga]  DEFAULT (0.0) FOR [Compra_Tasa_Forward_larga]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_Compra_Tasa_Forward_corta]  DEFAULT (0.0) FOR [Compra_Tasa_Forward_corta]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PlazoFlujo]  DEFAULT (0) FOR [PlazoFlujo]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_PortaFolio]  DEFAULT ('') FOR [PortaFolio]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [df_CARTERA_UNWIND_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_InterNocIni]  DEFAULT ((0)) FOR [InterNocIni]
GO
ALTER TABLE [dbo].[CARTERA_UNWIND] ADD  CONSTRAINT [DF_CARTERA_UNWIND_InterNocFin]  DEFAULT ((0)) FOR [InterNocFin]
GO

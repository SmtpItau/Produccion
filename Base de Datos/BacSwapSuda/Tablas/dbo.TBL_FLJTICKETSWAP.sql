USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[TBL_FLJTICKETSWAP]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_FLJTICKETSWAP](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NOT NULL,
	[numero_operacion_relacional] [numeric](7, 0) NOT NULL,
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[tipo_swap] [numeric](1, 0) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
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
	[ompra_duration_monto_clp] [numeric](19, 0) NOT NULL,
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
	[compra_valorizada] [numeric](19, 4) NOT NULL,
	[compra_variacion] [numeric](19, 4) NOT NULL,
	[venta_valorizada] [numeric](19, 4) NOT NULL,
	[venta_variacion] [numeric](19, 4) NOT NULL,
	[valorizacion_dia] [numeric](19, 4) NOT NULL,
	[estado] [char](1) NOT NULL,
	[Capital_Pesos_Actual] [numeric](21, 0) NOT NULL,
	[Capital_Pesos_Ayer] [numeric](21, 0) NOT NULL,
	[Hora] [char](8) NOT NULL,
	[Tasa_Compra_Curva] [numeric](12, 8) NOT NULL,
	[Tasa_Venta_Curva] [numeric](12, 8) NOT NULL,
	[Monto_Spread] [float] NOT NULL,
	[Monto_diferido_inicial] [float] NOT NULL,
	[Monto_diferido_diario] [float] NOT NULL,
	[Monto_diferido_acumulado] [float] NOT NULL,
	[TC_MO_Inicial] [float] NOT NULL,
	[Monto_TC_Diario] [float] NOT NULL,
	[FeriadoFlujoChile] [int] NOT NULL,
	[FeriadoFlujoEEUU] [int] NOT NULL,
	[FeriadoFlujoEnglan] [int] NOT NULL,
	[FeriadoLiquiChile] [int] NOT NULL,
	[FeriadoLiquiEEUU] [int] NOT NULL,
	[FeriadoLiquiEnglan] [int] NOT NULL,
	[DiasReset] [int] NOT NULL,
	[FechaEfectiva] [datetime] NOT NULL,
	[FechaPrimerPago] [datetime] NOT NULL,
	[FechaPenultimoPago] [datetime] NOT NULL,
	[FechaMadurez] [datetime] NOT NULL,
	[FechaLiquidacion] [datetime] NOT NULL,
	[FechaReset] [datetime] NOT NULL,
	[CompraTasaProyectada] [float] NOT NULL,
	[VentaTasaProyectada] [float] NOT NULL,
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
	[PlazoFlujo] [numeric](10, 0) NOT NULL,
	[Activo_FlujoMO] [numeric](19, 4) NOT NULL,
	[Activo_FlujoUSD] [numeric](19, 4) NOT NULL,
	[Activo_FlujoCLP] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoMO] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoUSD] [numeric](19, 4) NOT NULL,
	[Pasivo_FlujoCLP] [numeric](19, 4) NOT NULL,
	[Valor_RazonableMO] [numeric](19, 4) NOT NULL,
	[Valor_RazonableUSD] [numeric](19, 4) NOT NULL,
	[Valor_RazonableCLP] [numeric](19, 4) NOT NULL,
	[Activo_MO_C08] [numeric](19, 4) NOT NULL,
	[Pasivo_MO_C08] [numeric](19, 4) NOT NULL,
	[Activo_USD_C08] [numeric](19, 4) NOT NULL,
	[Pasivo_USD_C08] [numeric](19, 4) NOT NULL,
	[Activo_CLP_C08] [numeric](19, 4) NOT NULL,
	[Pasivo_CLP_C08] [numeric](19, 4) NOT NULL,
	[Tasa_Compra_CurvaVR] [numeric](12, 8) NOT NULL,
	[Tasa_Venta_CurvaVR] [numeric](12, 8) NOT NULL,
	[Compra_Curva_Descont] [varchar](20) NOT NULL,
	[Venta_Curva_Descont] [varchar](20) NOT NULL,
	[Compra_Curva_Forward] [varchar](20) NOT NULL,
	[Venta_Curva_Forward] [varchar](20) NOT NULL,
 CONSTRAINT [PK__FLJTICKETSWAP] PRIMARY KEY NONCLUSTERED 
(
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC,
	[tipo_swap] ASC,
	[tipo_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [numero_operacion_relacional]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [operador]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [observaciones]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_dias]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_monto]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_monto_peso]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_monto_acum]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_monto_ayer]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_compra]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_compra_acum]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_compra_acum_peso]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_compra_ayer]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_compra_ayer_peso]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_venta]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_venta_acum]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_venta_acum_peso]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_venta_ayer]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [devengo_venta_ayer_peso]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [fecha_valoriza]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_zcr]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mercado_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mercado]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mercado_usd]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_mercado_clp]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_duration_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_duration_monto]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_duration_monto_usd]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [ompra_duration_monto_clp]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_valor_presente]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_zcr]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mercado_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mercado]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mercado_usd]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_mercado_clp]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_duration_tasa]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_duration_monto]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_duration_monto_usd]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_duration_monto_clp]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_valor_presente]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_valorizada]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [compra_variacion]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_valorizada]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [venta_variacion]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [valorizacion_dia]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Capital_Pesos_Actual]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Capital_Pesos_Ayer]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Compra_Curva]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Venta_Curva]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Monto_diferido_inicial]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Monto_diferido_diario]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Monto_diferido_acumulado]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [TC_MO_Inicial]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Monto_TC_Diario]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaPrimerPago]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaPenultimoPago]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaMadurez]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaReset]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [FxRate]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Compra_amortiza_Prc]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Venta_amortiza_Prc]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Compra_Flujo_Adicional]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Venta_Flujo_Adicional]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [FechaValuta]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [CompraPerResetCod]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [VentaPerResetCod]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [CompraLiqDefault]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [VentaLiqDefault]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [CompraResetDefault]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [VentaResetDefault]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [PlazoFlujo]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_FlujoMO]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_FlujoUSD]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_FlujoCLP]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_FlujoMO]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_FlujoUSD]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_FlujoCLP]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Valor_RazonableMO]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Valor_RazonableUSD]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Valor_RazonableCLP]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_MO_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_MO_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_USD_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_USD_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Activo_CLP_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Pasivo_CLP_C08]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Compra_CurvaVR]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT (0) FOR [Tasa_Venta_CurvaVR]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [Compra_Curva_Descont]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [Venta_Curva_Descont]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [Compra_Curva_Forward]
GO
ALTER TABLE [dbo].[TBL_FLJTICKETSWAP] ADD  DEFAULT ('') FOR [Venta_Curva_Forward]
GO

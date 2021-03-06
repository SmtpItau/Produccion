USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[MovHistorico]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovHistorico](
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
	[Estado_oper_lineas] [char](1) NOT NULL,
	[Observacion_Lineas] [char](255) NOT NULL,
	[Observacion_Limites] [char](255) NOT NULL,
	[Especial] [numeric](1, 0) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[Hora] [char](8) NOT NULL,
	[ParidadCompra] [numeric](21, 4) NULL,
	[ParidadVenta] [numeric](21, 4) NULL,
	[Monto_Spread] [float] NOT NULL,
	[mhi_area_responsable] [char](6) NULL,
	[mhi_cartera_normativa] [char](6) NULL,
	[mhi_subcartera_normativa] [char](6) NULL,
	[mhi_libro] [char](6) NULL,
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
	[Estado] [char](1) NOT NULL,
	[Tasa_Transfer] [numeric](19, 5) NOT NULL,
	[Spread_Transfer] [numeric](19, 5) NOT NULL,
	[Res_Mesa_Dist_CLP] [numeric](21, 0) NOT NULL,
	[Res_Mesa_Dist_USD] [numeric](21, 4) NOT NULL,
	[moDigitador] [char](15) NOT NULL,
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
 CONSTRAINT [PK_MovHistorico] PRIMARY KEY NONCLUSTERED 
(
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__numer__1E505424]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__numer__1F44785D]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_tipo_flujo]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__tipo___20389C96]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__carte__212CC0CF]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__tipo___2220E508]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__codig__23150941]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__24092D7A]  DEFAULT (' ') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__24FD51B3]  DEFAULT (' ') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__25F175EC]  DEFAULT (' ') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__26E59A25]  DEFAULT (' ') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__27D9BE5E]  DEFAULT (' ') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_fecha_fijacion_tasa]  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__28CDE297]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__29C206D0]  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2AB62B09]  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2BAA4F42]  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2C9E737B]  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2D9297B4]  DEFAULT (0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2E86BBED]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__2F7AE026]  DEFAULT (0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__306F045F]  DEFAULT (0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__31632898]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__32574CD1]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__334B710A]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__343F9543]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__compr__3533B97C]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3627DDB5]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__371C01EE]  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__38102627]  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__39044A60]  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__39F86E99]  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3AEC92D2]  DEFAULT (0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3BE0B70B]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3CD4DB44]  DEFAULT (0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3DC8FF7D]  DEFAULT (0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3EBD23B6]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__3FB147EF]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__40A56C28]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__41999061]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__venta__428DB49A]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__opera__4381D8D3]  DEFAULT (' ') FOR [operador]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__opera__4475FD0C]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__estad__456A2145]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__modal__465E457E]  DEFAULT (' ') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__pagam__475269B7]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__pagam__48468DF0]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__pagam__493AB229]  DEFAULT (0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__pagam__4A2ED662]  DEFAULT (0) FOR [pagamos_monto_USD]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__pagam__4B22FA9B]  DEFAULT (0) FOR [pagamos_monto_CLP]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__recib__4C171ED4]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__recib__4D0B430D]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__recib__4DFF6746]  DEFAULT (0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__recib__4EF38B7F]  DEFAULT (0) FOR [recibimos_monto_USD]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__recib__4FE7AFB8]  DEFAULT (0) FOR [recibimos_monto_CLP]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__obser__50DBD3F1]  DEFAULT (' ') FOR [observaciones]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF__MovHistor__fecha__51CFF82A]  DEFAULT (' ') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_Estado_oper_lineas]  DEFAULT ('') FOR [Estado_oper_lineas]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_Observacion_Lineas]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_Observacion_Limites]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_Especial]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [df_movhistorico_ParidadCompra]  DEFAULT (0.0) FOR [ParidadCompra]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [df_movhistorico_ParidadVenta]  DEFAULT (0.0) FOR [ParidadVenta]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [mhi_area_responsable]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [mhi_cartera_normativa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [mhi_subcartera_normativa]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [mhi_libro]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerFluj_Chi]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerFluj_Usa]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerFluj_Eng]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerLiqu_Chi]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerLiqu_Usa]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFerLiqu_Eng]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisConvencion]  DEFAULT ('Siguiente Modificado') FOR [Convencion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisDiasReset]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisFechaEfectiva]  DEFAULT ('19000101') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisPrimerPago]  DEFAULT ('19000101') FOR [PrimerPago]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisPenultimoPago]  DEFAULT ('19000101') FOR [PenultimoPago]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisMadurez]  DEFAULT ('19000101') FOR [Madurez]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisNote]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisIntercPrinc]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisTikker]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisReset]  DEFAULT ('') FOR [FechaReset]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisComTasProy]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [dfMHisVenTasProy]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [Tasa_Transfer]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [Spread_Transfer]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [Res_Mesa_Dist_CLP]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT (0) FOR [Res_Mesa_Dist_USD]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [df_MOVHISTORICO_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_InterNocIni]  DEFAULT ((0)) FOR [InterNocIni]
GO
ALTER TABLE [dbo].[MovHistorico] ADD  CONSTRAINT [DF_MovHistorico_InterNocFin]  DEFAULT ((0)) FOR [InterNocFin]
GO

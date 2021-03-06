USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[MovDiario]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovDiario](
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
	[mov_area_responsable] [char](6) NULL,
	[mov_cartera_normativa] [char](6) NULL,
	[mov_subcartera_normativa] [char](6) NULL,
	[mov_libro] [char](6) NULL,
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
 CONSTRAINT [PK_MovDiario] PRIMARY KEY NONCLUSTERED 
(
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__numer__68E867AC]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__numer__69DC8BE5]  DEFAULT (0) FOR [numero_flujo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_tipo_flujo]  DEFAULT (0) FOR [tipo_flujo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__tipo___6AD0B01E]  DEFAULT (0) FOR [tipo_swap]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__carte__6BC4D457]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__tipo___6CB8F890]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__codig__6DAD1CC9]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__6EA14102]  DEFAULT (' ') FOR [fecha_cierre]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__6F95653B]  DEFAULT (' ') FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__70898974]  DEFAULT (' ') FOR [fecha_termino]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__717DADAD]  DEFAULT (' ') FOR [fecha_inicio_flujo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__7271D1E6]  DEFAULT (' ') FOR [fecha_vence_flujo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_fecha_fijacion_tasa]  DEFAULT ('') FOR [fecha_fijacion_tasa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7365F61F]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__745A1A58]  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__754E3E91]  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__764262CA]  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__77368703]  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__782AAB3C]  DEFAULT (0) FOR [compra_spread]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__791ECF75]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7A12F3AE]  DEFAULT (0) FOR [compra_valor_tasa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7B0717E7]  DEFAULT (0) FOR [compra_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7BFB3C20]  DEFAULT (0) FOR [compra_codamo_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7CEF6059]  DEFAULT (0) FOR [compra_mesamo_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7DE38492]  DEFAULT (0) FOR [compra_codamo_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7ED7A8CB]  DEFAULT (0) FOR [compra_mesamo_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__compr__7FCBCD04]  DEFAULT (0) FOR [compra_base]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__00BFF13D]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__01B41576]  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__02A839AF]  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__039C5DE8]  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__04908221]  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0584A65A]  DEFAULT (0) FOR [venta_spread]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0678CA93]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__076CEECC]  DEFAULT (0) FOR [venta_valor_tasa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__08611305]  DEFAULT (0) FOR [venta_valor_tasa_hoy]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0955373E]  DEFAULT (0) FOR [venta_codamo_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0A495B77]  DEFAULT (0) FOR [venta_mesamo_capital]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0B3D7FB0]  DEFAULT (0) FOR [venta_codamo_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0C31A3E9]  DEFAULT (0) FOR [venta_mesamo_interes]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__venta__0D25C822]  DEFAULT (0) FOR [venta_base]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__opera__0E19EC5B]  DEFAULT (' ') FOR [operador]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__opera__0F0E1094]  DEFAULT (0) FOR [operador_cliente]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__estad__100234CD]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__modal__10F65906]  DEFAULT (' ') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__pagam__11EA7D3F]  DEFAULT (0) FOR [pagamos_moneda]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__pagam__12DEA178]  DEFAULT (0) FOR [pagamos_documento]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__pagam__13D2C5B1]  DEFAULT (0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__pagam__14C6E9EA]  DEFAULT (0) FOR [pagamos_monto_USD]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__pagam__15BB0E23]  DEFAULT (0) FOR [pagamos_monto_CLP]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__recib__16AF325C]  DEFAULT (0) FOR [recibimos_moneda]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__recib__17A35695]  DEFAULT (0) FOR [recibimos_documento]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__recib__18977ACE]  DEFAULT (0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__recib__198B9F07]  DEFAULT (0) FOR [recibimos_monto_USD]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__recib__1A7FC340]  DEFAULT (0) FOR [recibimos_monto_CLP]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__obser__1B73E779]  DEFAULT (' ') FOR [observaciones]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF__MovDiario__fecha__1C680BB2]  DEFAULT (' ') FOR [fecha_modifica]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_Estado_oper_lineas]  DEFAULT ('') FOR [Estado_oper_lineas]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_Observacion_Lineas]  DEFAULT ('') FOR [Observacion_Lineas]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_Observacion_Limites]  DEFAULT ('') FOR [Observacion_Limites]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_Especial]  DEFAULT (0) FOR [Especial]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [df_movdiario_ParidadCompra]  DEFAULT (0.0) FOR [ParidadCompra]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [df_movdiario_ParidadVenta]  DEFAULT (0.0) FOR [ParidadVenta]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [Monto_Spread]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [mov_area_responsable]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [mov_cartera_normativa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [mov_subcartera_normativa]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [mov_libro]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerFluj_Chi]  DEFAULT (0) FOR [FeriadoFlujoChile]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerFluj_Usa]  DEFAULT (0) FOR [FeriadoFlujoEEUU]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerFluj_Eng]  DEFAULT (0) FOR [FeriadoFlujoEnglan]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerLiqu_Chi]  DEFAULT (0) FOR [FeriadoLiquiChile]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerLiqu_Usa]  DEFAULT (0) FOR [FeriadoLiquiEEUU]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFerLiqu_Eng]  DEFAULT (0) FOR [FeriadoLiquiEnglan]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaConvencion]  DEFAULT ('Siguiente Modificado') FOR [Convencion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaDiasReset]  DEFAULT (0) FOR [DiasReset]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaFechaEfectiva]  DEFAULT ('19000101') FOR [FechaEfectiva]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaPrimerPago]  DEFAULT ('19000101') FOR [PrimerPago]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaPenultimoPago]  DEFAULT ('19000101') FOR [PenultimoPago]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaMadurez]  DEFAULT ('19000101') FOR [Madurez]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaNote]  DEFAULT ('') FOR [Note]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaIntercPrinc]  DEFAULT (0) FOR [IntercPrinc]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaTikker]  DEFAULT ('') FOR [Tikker]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaReset]  DEFAULT ('') FOR [FechaReset]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaComTasProy]  DEFAULT (0.0) FOR [CompraTasaProyectada]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [dfMDiaVenTasProy]  DEFAULT (0.0) FOR [VentaTasaProyectada]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [Tasa_Transfer]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [Spread_Transfer]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [Res_Mesa_Dist_CLP]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT (0) FOR [Res_Mesa_Dist_USD]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [df_MOVDIARIO_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[MovDiario] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_InterNocIni]  DEFAULT ((0)) FOR [InterNocIni]
GO
ALTER TABLE [dbo].[MovDiario] ADD  CONSTRAINT [DF_MovDiario_InterNocFin]  DEFAULT ((0)) FOR [InterNocFin]
GO

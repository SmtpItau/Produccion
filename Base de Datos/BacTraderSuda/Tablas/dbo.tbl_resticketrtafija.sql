USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tbl_resticketrtafija]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_resticketrtafija](
	[Fecha_Operacion] [datetime] NOT NULL,
	[Numero_Documento] [numeric](10, 0) NOT NULL,
	[Correlativo] [smallint] NOT NULL,
	[tipo_resultado] [varchar](3) NOT NULL,
	[tipo_operacion] [varchar](3) NOT NULL,
	[CodCartera] [smallint] NOT NULL,
	[CodMesa] [smallint] NOT NULL,
	[moneda] [numeric](3, 0) NOT NULL,
	[Nemotecnico] [varchar](10) NOT NULL,
	[Mascara] [varchar](10) NOT NULL,
	[CodigoInstrumento] [smallint] NOT NULL,
	[Valor_Nominal] [float] NOT NULL,
	[Tir] [numeric](8, 4) NOT NULL,
	[pvp] [numeric](8, 4) NOT NULL,
	[vpar] [numeric](8, 4) NOT NULL,
	[Tir_Estimada] [numeric](8, 4) NOT NULL,
	[Valor_Presente_Hoy] [numeric](19, 4) NOT NULL,
	[Valor_Presente_prox] [numeric](19, 4) NOT NULL,
	[Intereses] [float] NOT NULL,
	[Reajustes] [float] NOT NULL,
	[Interes_mes] [float] NOT NULL,
	[Reajuste_mes] [float] NOT NULL,
	[Interes_Acumulado] [float] NOT NULL,
	[Reajuste_Acumulado] [float] NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL,
	[Amortizacion_Cupon] [float] NOT NULL,
	[Interes_Cupon] [float] NOT NULL,
	[Reajuste_Cupon] [float] NOT NULL,
	[Flujo_Cupon] [float] NOT NULL,
	[valor_compra] [float] NOT NULL,
	[valor_compra_um] [float] NOT NULL,
	[num_ult_cupon] [int] NOT NULL,
	[num_prox_cupon] [int] NOT NULL,
	[fecha_ult_cupon] [datetime] NOT NULL,
	[fecha_prox_cupon] [datetime] NOT NULL,
	[valor_pvcomp] [float] NOT NULL,
	[diferencia_reajuste] [float] NOT NULL,
	[valor_venc] [float] NOT NULL,
	[prima_descuento_total] [float] NOT NULL,
	[prima_descuento_dia] [float] NOT NULL,
	[valor_tasa_emision] [float] NOT NULL,
	[valor_par] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Numero_Documento]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [tipo_resultado]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [CodCartera]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [CodMesa]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [moneda]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [Nemotecnico]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [Mascara]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [CodigoInstrumento]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Valor_Nominal]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Tir]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [pvp]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [vpar]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Tir_Estimada]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Valor_Presente_Hoy]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Valor_Presente_prox]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Intereses]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Reajustes]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Interes_mes]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Reajuste_mes]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Interes_Acumulado]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Reajuste_Acumulado]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Duration]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [DurationMod]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Amortizacion_Cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Interes_Cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Reajuste_Cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [Flujo_Cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_compra]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_compra_um]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [num_ult_cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [num_prox_cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [fecha_ult_cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT ('') FOR [fecha_prox_cupon]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_pvcomp]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [diferencia_reajuste]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_venc]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [prima_descuento_total]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [prima_descuento_dia]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_tasa_emision]
GO
ALTER TABLE [dbo].[tbl_resticketrtafija] ADD  DEFAULT (0) FOR [valor_par]
GO

USE [Reportes]
GO
/****** Object:  Table [dbo].[CNT_AUX_RESUMEN_RF_RENT]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](19, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](10) NOT NULL,
	[moneda_instrumento] [char](6) NOT NULL,
	[valor_compra] [float] NOT NULL,
	[valor_presente] [float] NOT NULL,
	[valor_venta] [float] NOT NULL,
	[utilidad] [float] NOT NULL,
	[perdida] [float] NOT NULL,
	[interes_papel] [float] NOT NULL,
	[reajuste_papel] [float] NOT NULL,
	[interes_pacto] [numeric](21, 4) NOT NULL,
	[reajuste_pacto] [float] NOT NULL,
	[valor_cupon] [float] NOT NULL,
	[nominalpesos] [float] NOT NULL,
	[valor_comprahis] [float] NOT NULL,
	[dif_ant_pacto_pos] [float] NOT NULL,
	[dif_ant_pacto_neg] [float] NOT NULL,
	[dif_valor_mercado_pos] [float] NOT NULL,
	[dif_valor_mercado_neg] [float] NOT NULL,
	[condicion_pacto] [char](3) NOT NULL,
	[forma_pago] [char](6) NOT NULL,
	[tipo_instrumento] [char](1) NOT NULL,
	[tipo_cliente] [char](1) NOT NULL,
	[tipo_emisor] [char](6) NOT NULL,
	[forma_pago_entregamos] [char](6) NOT NULL,
	[valor_futuro] [float] NOT NULL,
	[condicion_entrega] [char](5) NOT NULL,
	[tipo_operacion_or] [char](5) NOT NULL,
	[comquien] [char](1) NOT NULL,
	[instser] [char](12) NOT NULL,
	[documento] [numeric](10, 0) NOT NULL,
	[Emisor] [char](10) NOT NULL,
	[tipo_bono] [char](6) NULL,
	[clasificacion_cliente] [char](6) NULL,
	[valor_final] [float] NULL,
	[cartera_origen] [char](2) NULL,
	[interes_positivo] [float] NULL,
	[interes_negativo] [float] NULL,
	[reajuste_positivo] [float] NULL,
	[reajuste_negativo] [float] NULL,
	[plazo] [numeric](9, 0) NULL,
	[cliente] [numeric](18, 0) NULL,
	[codcli] [numeric](18, 0) NULL,
	[fecha_proceso] [datetime] NULL,
	[interes_reajuste] [float] NOT NULL,
	[Nominal] [float] NOT NULL,
	[valor_tasa_emision] [numeric](19, 4) NOT NULL,
	[prima_total] [numeric](19, 4) NOT NULL,
	[descuento_total] [numeric](19, 4) NOT NULL,
	[prima_dia] [numeric](19, 4) NOT NULL,
	[descuento_dia] [numeric](19, 4) NOT NULL,
	[valor_pte_emision] [numeric](19, 4) NOT NULL,
	[dif_par_pos] [numeric](19, 6) NOT NULL,
	[dif_par_neg] [numeric](19, 6) NOT NULL,
	[Tipo_cartera] [char](10) NULL,
	[CondPactoCliente] [char](3) NULL,
	[Monto_Pagomañana] [numeric](21, 4) NOT NULL,
	[Utilidad_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Perdida_Avr_Patrimonio] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Pos] [numeric](21, 4) NOT NULL,
	[Diferencia_Precio_Neg] [numeric](21, 4) NOT NULL,
	[id_automatico] [numeric](10, 0) IDENTITY(1,1) NOT NULL
) ON [Reportes_Data_01]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [interes_reajuste]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [Nominal]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [valor_tasa_emision]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [prima_total]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [descuento_total]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [prima_dia]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [descuento_dia]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [valor_pte_emision]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [dif_par_pos]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0)) FOR [dif_par_neg]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ('') FOR [Tipo_cartera]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ('') FOR [CondPactoCliente]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0.0)) FOR [Monto_Pagomañana]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0.0)) FOR [Utilidad_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0.0)) FOR [Perdida_Avr_Patrimonio]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0.0)) FOR [Diferencia_Precio_Pos]
GO
ALTER TABLE [dbo].[CNT_AUX_RESUMEN_RF_RENT] ADD  DEFAULT ((0.0)) FOR [Diferencia_Precio_Neg]
GO

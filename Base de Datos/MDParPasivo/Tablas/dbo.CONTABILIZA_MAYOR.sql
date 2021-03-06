USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CONTABILIZA_MAYOR]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTABILIZA_MAYOR](
	[fecha] [datetime] NULL,
	[Tipo_Filtro] [char](1) NULL,
	[id_sistema] [char](3) NULL,
	[cProducto] [varchar](7) NULL,
	[cTipo_Plazo] [varchar](1) NULL,
	[cFinanciamiento] [varchar](3) NULL,
	[cCodigo_Sector] [varchar](1) NULL,
	[cCodigo_Subsector] [varchar](2) NULL,
	[cBanco_Corresponsal] [varchar](5) NULL,
	[cStatus_Cuota] [varchar](1) NULL,
	[cStatus_Colocacion] [varchar](1) NULL,
	[cReajustabilidad] [varchar](1) NULL,
	[cDivisa] [varchar](3) NULL,
	[cTipo_Divisa] [varchar](1) NULL,
	[valor_compra] [float] NULL,
	[valor_presente] [float] NULL,
	[valor_venta] [float] NULL,
	[utilidad] [float] NULL,
	[perdida] [float] NULL,
	[interes_papel] [float] NULL,
	[reajuste_papel] [float] NULL,
	[interes_pacto] [float] NULL,
	[reajuste_pacto] [float] NULL,
	[valor_cupon] [float] NULL,
	[nominalpesos] [float] NULL,
	[nominal] [float] NULL,
	[valor_comprahis] [float] NULL,
	[dif_ant_pacto_pos] [float] NULL,
	[dif_ant_pacto_neg] [float] NULL,
	[dif_valor_mercado_pos] [float] NULL,
	[dif_valor_mercado_neg] [float] NULL,
	[rev_valor_mercado_pos] [float] NULL,
	[rev_valor_mercado_neg] [float] NULL,
	[valor_futuro] [float] NULL,
	[Valor_perdida_usd] [numeric](19, 0) NULL,
	[Valor_utilidad_usd] [numeric](19, 0) NULL,
	[Valor_perdida_clp] [numeric](19, 0) NULL,
	[Valor_utilidad_clp] [numeric](19, 0) NULL,
	[tipo_cuenta] [char](1) NULL,
	[cproductor] [varchar](7) NULL,
	[codigo_evento] [char](3) NULL,
	[codigo_moneda1] [int] NULL,
	[codigo_moneda2] [int] NULL,
	[codigo_instrumento] [int] NULL,
	[numero_operacion] [numeric](10, 0) NULL,
	[numero_documento] [numeric](10, 0) NULL,
	[correlativo] [numeric](3, 0) NULL,
	[forma_pago] [int] NULL,
	[rut] [numeric](9, 0) NULL,
	[Codigo_Operacion] [char](3) NULL,
	[mercado] [numeric](1, 0) NULL,
	[fecha_contable] [datetime] NULL,
	[archivo_proceso] [char](3) NULL,
	[fecha_historica] [datetime] NULL,
	[tipoper] [char](5) NULL,
	[tipopero] [char](5) NULL,
	[cartera] [char](5) NULL,
	[numero_SPOT] [numeric](10, 0) NULL,
	[swp_utilidad_mercado] [float] NULL,
	[swp_perdida_mercado] [float] NULL,
	[swp_capital_moneda1] [float] NULL,
	[swp_capital_moneda2] [float] NULL,
	[swp_diferencia_cambio] [float] NULL,
	[swp_diferencia_recibida] [float] NULL,
	[swp_diferencia_recibida_CP] [float] NULL,
	[swp_diferencia_recibida_SP] [float] NULL,
	[swp_diferencia_recibida_LB] [float] NULL,
	[swp_entrega_principales_m1] [float] NULL,
	[swp_entrega_principales_m2] [float] NULL,
	[swp_interes_cobrado] [float] NULL,
	[swp_interes_cobrado_SP] [float] NULL,
	[swp_interes_cobrado_CP] [float] NULL,
	[swp_interes_cobrado_LB] [float] NULL,
	[swp_interes_pagado] [float] NULL,
	[swp_interes_pagado_SP] [float] NULL,
	[swp_interes_pagado_CP] [float] NULL,
	[swp_interes_pagado_LB] [float] NULL,
	[swp_perd_dif_pre_CP] [float] NULL,
	[swp_perd_dif_pre_SP] [float] NULL,
	[swp_perd_dif_pre_LB] [float] NULL,
	[swp_perd_diferida] [float] NULL,
	[swp_diferencia_contra] [float] NULL,
	[swp_dif_pagada_SP] [float] NULL,
	[swp_dif_pagada_CP] [float] NULL,
	[swp_dif_pagada_LB] [float] NULL,
	[swp_reajuste_dev] [float] NULL,
	[swp_reajuste] [float] NULL,
	[swp_util_dif_pre_CP] [float] NULL,
	[swp_util_dif_pre_SP] [float] NULL,
	[swp_util_dif_pre_LB] [float] NULL,
	[swp_util_diferida] [float] NULL,
	[swp_dif_recibida_SP] [float] NULL,
	[swp_dif_recibida_CP] [float] NULL,
	[swp_dif_recibida_LB] [float] NULL,
	[swp_diferencia_favor] [float] NULL,
	[pago_parcial] [float] NULL,
	[recaudacion_parcial] [float] NULL,
	[diferencia_recibida] [float] NULL,
	[fwd_capital_mx1] [float] NULL,
	[fwd_capital_mx2] [float] NULL,
	[fwd_dif_cambio] [float] NULL,
	[fwd_dif_pago_cp] [float] NULL,
	[fwd_dif_pago_sp] [float] NULL,
	[fwd_dif_pago_lb] [float] NULL,
	[fwd_perdida_cp] [float] NULL,
	[fwd_perdida_sp] [float] NULL,
	[fwd_perdida_lb] [float] NULL,
	[fwd_utilidad_cp] [float] NULL,
	[fwd_utilidad_sp] [float] NULL,
	[fwd_utilidad_lb] [float] NULL,
	[fwd_difpre_util] [float] NULL,
	[fwd_difval_util] [float] NULL,
	[fwd_difpre_Perd] [float] NULL,
	[fwd_difval_Perd] [float] NULL,
	[fwd_difpre_util_rv] [numeric](19, 4) NOT NULL,
	[fwd_difpre_Perd_rv] [numeric](19, 4) NOT NULL,
	[fwd_reajuste] [numeric](19, 4) NOT NULL,
	[sistema_original] [char](3) NOT NULL
) ON [PRIMARY]
GO

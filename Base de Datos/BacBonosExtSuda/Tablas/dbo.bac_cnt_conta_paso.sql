USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[bac_cnt_conta_paso]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_conta_paso](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
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
	[interes_pacto] [float] NOT NULL,
	[reajuste_pacto] [float] NOT NULL,
	[valor_cupon] [float] NOT NULL,
	[nominal] [float] NOT NULL,
	[valor_comprahis] [float] NOT NULL,
	[dif_ant_pacto_pos] [float] NOT NULL,
	[dif_ant_pacto_neg] [float] NOT NULL,
	[dif_valor_mercado_pos] [float] NOT NULL,
	[dif_valor_mercado_neg] [float] NOT NULL,
	[condicion_pacto] [char](3) NOT NULL,
	[forma_pago] [char](6) NOT NULL,
	[tipo_instrumento] [char](5) NOT NULL,
	[tipo_cliente] [char](1) NOT NULL,
	[tipo_emisor] [char](6) NOT NULL,
	[forma_pago_entregamos] [char](6) NOT NULL,
	[valor_futuro] [float] NOT NULL,
	[condicion_entrega] [char](1) NOT NULL,
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
	[capitalPeso] [numeric](24, 0) NOT NULL,
	[interesPeso] [numeric](24, 0) NOT NULL,
	[fecha_proceso] [datetime] NULL,
	[ctacblecorresponsal] [char](15) NOT NULL,
	[valor_cupon_peso] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bac_cnt_conta_paso] ADD  CONSTRAINT [DF__bac_cnt_c__capit__65F6EC68]  DEFAULT (0) FOR [capitalPeso]
GO
ALTER TABLE [dbo].[bac_cnt_conta_paso] ADD  CONSTRAINT [DF__bac_cnt_c__inter__66EB10A1]  DEFAULT (0) FOR [interesPeso]
GO
ALTER TABLE [dbo].[bac_cnt_conta_paso] ADD  CONSTRAINT [DF__bac_cnt_c__ctacb__67DF34DA]  DEFAULT (' ') FOR [ctacblecorresponsal]
GO
ALTER TABLE [dbo].[bac_cnt_conta_paso] ADD  CONSTRAINT [DF__bac_cnt_c__valor__68D35913]  DEFAULT (0) FOR [valor_cupon_peso]
GO

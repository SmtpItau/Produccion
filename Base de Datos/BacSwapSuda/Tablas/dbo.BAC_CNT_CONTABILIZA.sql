USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_CONTABILIZA]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_CONTABILIZA](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[codigo_instrumento] [char](10) NULL,
	[moneda_instrumento] [char](6) NULL,
	[cartera_inversion] [numeric](2, 0) NOT NULL,
	[compra_moneda] [numeric](3, 0) NULL,
	[venta_moneda] [numeric](3, 0) NULL,
	[compra_codigo_tasa] [numeric](3, 0) NULL,
	[venta_codigo_tasa] [numeric](3, 0) NULL,
	[codamo_capital] [numeric](3, 0) NULL,
	[codamo_interes] [numeric](3, 0) NULL,
	[estado_flujo] [numeric](1, 0) NULL,
	[modalidad_pago] [char](1) NULL,
	[moneda_pago] [numeric](3, 0) NULL,
	[moneda_recibo] [numeric](3, 0) NULL,
	[documento_pago] [numeric](3, 0) NULL,
	[documento_recibo] [numeric](3, 0) NULL,
	[compra_capital] [float] NULL,
	[venta_capital] [float] NULL,
	[compra_capital_Ant] [float] NULL,
	[venta_capital_Ant] [float] NULL,
	[compra_capital_Origen] [float] NULL,
	[venta_capital_Origen] [float] NULL,
	[compra_amortiza] [float] NULL,
	[venta_amortiza] [float] NULL,
	[compra_interes] [float] NULL,
	[venta_interes] [float] NULL,
	[compra_saldo] [float] NULL,
	[venta_saldo] [float] NULL,
	[pagamos_monto] [float] NULL,
	[pagamos_monto_usd] [float] NULL,
	[pagamos_monto_clp] [float] NULL,
	[recibimos_monto] [float] NULL,
	[recibimos_monto_usd] [float] NULL,
	[recibimos_monto_clp] [float] NULL,
	[compra_mercado] [float] NULL,
	[venta_mercado] [float] NULL,
	[monto_mtm] [float] NULL,
	[devengo_compra] [float] NULL,
	[devengo_venta] [float] NULL,
	[devengo_compra_Ant_Origen] [float] NULL,
	[devengo_venta_Ant_Origen] [float] NULL,
	[devengo_compra_peso] [float] NULL,
	[devengo_venta_peso] [float] NULL,
	[devengo_compra_Ant_peso] [float] NULL,
	[devengo_venta_Ant_peso] [float] NULL,
	[devengo_monto] [float] NULL,
	[devengo_monto_peso] [float] NULL,
	[devengo_utilidad] [float] NULL,
	[devengo_perdida] [float] NULL,
	[Devengo_Monto_Ant_peso] [float] NULL,
	[Resultado] [char](2) NULL,
	[MontoLinea] [float] NULL,
	[MontoLineaAnt] [float] NULL,
	[resultado_ayer] [char](2) NULL,
	[Tipo_Cliente] [char](1) NOT NULL,
	[EF_Devengo_Compra] [numeric](19, 4) NOT NULL,
	[EF_Devengo_Venta] [numeric](19, 4) NOT NULL,
	[EF_Devengo_Compra_Peso] [numeric](19, 4) NOT NULL,
	[EF_Devengo_Venta_Peso] [numeric](19, 4) NOT NULL,
	[EF_Dev_Neto_Peso_Util] [numeric](19, 0) NOT NULL,
	[EF_Dev_Neto_Peso_Perd] [numeric](19, 0) NOT NULL,
	[Comp_Dev_Neto_Peso_Uti] [numeric](19, 0) NOT NULL,
	[Comp_Dev_Neto_Peso_Per] [numeric](19, 0) NOT NULL,
	[Monto_diferido_utilidad] [float] NOT NULL,
	[Monto_diferido_perdida] [float] NOT NULL,
	[Diferido_Inicio_utilidad] [float] NOT NULL,
	[Diferido_Inicio_perdida] [float] NOT NULL,
	[TipOper] [char](5) NOT NULL,
	[Compra_Amortiza_Peso] [float] NOT NULL,
	[Venta_Amortiza_Peso] [float] NOT NULL,
	[Monto_Reajustabilidad] [float] NOT NULL,
	[Monto_Valorizacion] [float] NOT NULL,
	[Monto_Utilidad_Valoriza] [float] NOT NULL,
	[Monto_Perdida_Valoriza] [float] NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[Dev_Neto_Peso_Uti] [numeric](21, 4) NULL,
	[Dev_Neto_Peso_Per] [numeric](21, 4) NULL,
	[Forma_de_Pago] [int] NULL,
	[SubCartera] [int] NULL,
 CONSTRAINT [PK_BAC_CNT_CONTABILIZA] PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_movimiento] ASC,
	[tipo_operacion] ASC,
	[operacion] ASC,
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__id_si__71E958AF]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___72DD7CE8]  DEFAULT (' ') FOR [tipo_movimiento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__tipo___73D1A121]  DEFAULT (' ') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__opera__74C5C55A]  DEFAULT (0) FOR [operacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__corre__75B9E993]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__codig__76AE0DCC]  DEFAULT (' ') FOR [codigo_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__moned__77A23205]  DEFAULT (' ') FOR [moneda_instrumento]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__carte__7896563E]  DEFAULT (0) FOR [cartera_inversion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__798A7A77]  DEFAULT (0) FOR [compra_moneda]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__7A7E9EB0]  DEFAULT (0) FOR [venta_moneda]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__7B72C2E9]  DEFAULT (0) FOR [compra_codigo_tasa]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__7C66E722]  DEFAULT (0) FOR [venta_codigo_tasa]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__codam__7D5B0B5B]  DEFAULT (0) FOR [codamo_capital]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__codam__7E4F2F94]  DEFAULT (0) FOR [codamo_interes]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__estad__7F4353CD]  DEFAULT (0) FOR [estado_flujo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__modal__00377806]  DEFAULT (' ') FOR [modalidad_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__moned__012B9C3F]  DEFAULT (0) FOR [moneda_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__moned__021FC078]  DEFAULT (0) FOR [moneda_recibo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__docum__0313E4B1]  DEFAULT (0) FOR [documento_pago]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__docum__040808EA]  DEFAULT (0) FOR [documento_recibo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__04FC2D23]  DEFAULT (0) FOR [compra_capital]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__05F0515C]  DEFAULT (0) FOR [venta_capital]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__06E47595]  DEFAULT (0) FOR [compra_capital_Ant]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__07D899CE]  DEFAULT (0) FOR [venta_capital_Ant]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__08CCBE07]  DEFAULT (0) FOR [compra_capital_Origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__09C0E240]  DEFAULT (0) FOR [venta_capital_Origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__0AB50679]  DEFAULT (0) FOR [compra_amortiza]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__0BA92AB2]  DEFAULT (0) FOR [venta_amortiza]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__0C9D4EEB]  DEFAULT (0) FOR [compra_interes]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__0D917324]  DEFAULT (0) FOR [venta_interes]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__0E85975D]  DEFAULT (0) FOR [compra_saldo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__0F79BB96]  DEFAULT (0) FOR [venta_saldo]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__pagam__106DDFCF]  DEFAULT (0) FOR [pagamos_monto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__pagam__11620408]  DEFAULT (0) FOR [pagamos_monto_usd]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__pagam__12562841]  DEFAULT (0) FOR [pagamos_monto_clp]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__recib__134A4C7A]  DEFAULT (0) FOR [recibimos_monto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__recib__143E70B3]  DEFAULT (0) FOR [recibimos_monto_usd]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__recib__153294EC]  DEFAULT (0) FOR [recibimos_monto_clp]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__compr__1626B925]  DEFAULT (0) FOR [compra_mercado]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__venta__171ADD5E]  DEFAULT (0) FOR [venta_mercado]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__monto__180F0197]  DEFAULT (0) FOR [monto_mtm]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__190325D0]  DEFAULT (0) FOR [devengo_compra]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__19F74A09]  DEFAULT (0) FOR [devengo_venta]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1AEB6E42]  DEFAULT (0) FOR [devengo_compra_Ant_Origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1BDF927B]  DEFAULT (0) FOR [devengo_venta_Ant_Origen]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1CD3B6B4]  DEFAULT (0) FOR [devengo_compra_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1DC7DAED]  DEFAULT (0) FOR [devengo_venta_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1EBBFF26]  DEFAULT (0) FOR [devengo_compra_Ant_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__1FB0235F]  DEFAULT (0) FOR [devengo_venta_Ant_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__20A44798]  DEFAULT (0) FOR [devengo_monto]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__21986BD1]  DEFAULT (0) FOR [devengo_monto_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__228C900A]  DEFAULT (0) FOR [devengo_utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__deven__2380B443]  DEFAULT (0) FOR [devengo_perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__Deven__2474D87C]  DEFAULT (0) FOR [Devengo_Monto_Ant_peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__Resul__2568FCB5]  DEFAULT (' ') FOR [Resultado]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__Monto__265D20EE]  DEFAULT (0) FOR [MontoLinea]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__BAC_CNT_C__Monto__27514527]  DEFAULT (0) FOR [MontoLineaAnt]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__resul__328C56FB]  DEFAULT ('') FOR [resultado_ayer]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__Tipo___6EA14102]  DEFAULT ('') FOR [Tipo_Cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__6F95653B]  DEFAULT (0) FOR [EF_Devengo_Compra]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__70898974]  DEFAULT (0) FOR [EF_Devengo_Venta]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__717DADAD]  DEFAULT (0) FOR [EF_Devengo_Compra_Peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__7271D1E6]  DEFAULT (0) FOR [EF_Devengo_Venta_Peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__7365F61F]  DEFAULT (0) FOR [EF_Dev_Neto_Peso_Util]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__EF_De__745A1A58]  DEFAULT (0) FOR [EF_Dev_Neto_Peso_Perd]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__Comp___754E3E91]  DEFAULT (0) FOR [Comp_Dev_Neto_Peso_Uti]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  CONSTRAINT [DF__bac_cnt_c__Comp___764262CA]  DEFAULT (0) FOR [Comp_Dev_Neto_Peso_Per]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_diferido_utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_diferido_perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Diferido_Inicio_utilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Diferido_Inicio_perdida]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (' ') FOR [TipOper]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Compra_Amortiza_Peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Venta_Amortiza_Peso]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_Reajustabilidad]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_Valorizacion]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_Utilidad_Valoriza]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Monto_Perdida_Valoriza]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0.0) FOR [Dev_Neto_Peso_Uti]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0.0) FOR [Dev_Neto_Peso_Per]
GO
ALTER TABLE [dbo].[BAC_CNT_CONTABILIZA] ADD  DEFAULT (0) FOR [Forma_de_Pago]
GO

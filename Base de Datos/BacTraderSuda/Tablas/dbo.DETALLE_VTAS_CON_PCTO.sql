USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[DETALLE_VTAS_CON_PCTO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VTAS_CON_PCTO](
	[Usuario] [varchar](15) NOT NULL,
	[Marca] [char](1) NOT NULL,
	[Documento] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](20) NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[Nominal_Compra] [float] NOT NULL,
	[Tasa_Compra] [float] NOT NULL,
	[Valor_Par] [float] NOT NULL,
	[Valor_Presente] [numeric](19, 4) NOT NULL,
	[Margen] [float] NOT NULL,
	[Valor_Inicial] [numeric](19, 4) NOT NULL,
	[Nominal_Venta] [float] NOT NULL,
	[Tasa_Venta] [float] NOT NULL,
	[vPar_Venta] [float] NOT NULL,
	[vPresente_Venta] [numeric](19, 4) NOT NULL,
	[vInicial_Venta] [numeric](19, 4) NOT NULL,
	[Plazo] [numeric](21, 0) NOT NULL,
	[Ventana] [numeric](9, 0) NOT NULL,
	[Fecha_Emision] [datetime] NOT NULL,
	[Fecha_Vence] [datetime] NOT NULL,
	[Fecha_UltCup] [char](10) NOT NULL,
	[Fecha_SigCup] [datetime] NOT NULL,
	[Numero_Cupon] [numeric](3, 0) NOT NULL,
	[Rut_Emisor] [numeric](9, 0) NOT NULL,
	[Mon_Emisor] [numeric](3, 0) NOT NULL,
	[Convexidad] [float] NOT NULL,
	[DurMod] [float] NOT NULL,
	[DurMac] [float] NOT NULL,
	[TasaEstimada] [float] NOT NULL,
	[CarteraSuper] [char](1) NOT NULL,
	[BloqueoPacto] [numeric](19, 4) NOT NULL,
	[HairCut] [float] NOT NULL,
	[TipOper] [char](3) NOT NULL,
	[FolioBCCH] [numeric](9, 0) NOT NULL,
	[CorrelaBCCH] [numeric](3, 0) NOT NULL,
	[inCodigo] [numeric](3, 0) NOT NULL,
	[MarcaVta] [char](1) NOT NULL,
	[cCustodia] [char](1) NOT NULL,
	[cClave] [char](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Marca]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Documento]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Moneda]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Nominal_Compra]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Tasa_Compra]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Valor_Par]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Valor_Presente]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Margen]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Valor_Inicial]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Nominal_Venta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Tasa_Venta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [vPar_Venta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [vPresente_Venta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [vInicial_Venta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Ventana]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Fecha_Emision]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Fecha_Vence]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('01/01/1900') FOR [Fecha_UltCup]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [Fecha_SigCup]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Numero_Cupon]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Rut_Emisor]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [Mon_Emisor]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [DurMod]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [DurMac]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [TasaEstimada]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [CarteraSuper]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [BloqueoPacto]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0.0) FOR [HairCut]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('VI') FOR [TipOper]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [FolioBCCH]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [CorrelaBCCH]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT (0) FOR [inCodigo]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [MarcaVta]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [cCustodia]
GO
ALTER TABLE [dbo].[DETALLE_VTAS_CON_PCTO] ADD  DEFAULT ('') FOR [cClave]
GO

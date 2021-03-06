USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TABLA_VENTAS]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_VENTAS](
	[TIPO_LISTADO] [char](1) NULL,
	[RUT_CARTERA] [numeric](18, 0) NULL,
	[TIPO_CARTERA] [numeric](18, 0) NULL,
	[CARTERA] [char](3) NULL,
	[NUMDOCU] [numeric](10, 0) NULL,
	[NUMOPER] [numeric](10, 0) NULL,
	[CORRELA] [numeric](3, 0) NULL,
	[INSTSER] [char](10) NULL,
	[FECEMIS] [datetime] NULL,
	[RUTEMIS] [numeric](9, 0) NULL,
	[GENEMIS] [char](5) NULL,
	[MONEMIS] [numeric](3, 0) NULL,
	[TASEMIS] [numeric](8, 4) NULL,
	[BASEEMIS] [numeric](3, 0) NULL,
	[FECVENC] [datetime] NULL,
	[FECPCUP] [datetime] NULL,
	[NOMINAL] [numeric](18, 4) NULL,
	[RUTCLI] [numeric](9, 0) NULL,
	[CODCLI] [numeric](8, 0) NULL,
	[FECCOMP] [datetime] NULL,
	[VALCOMP] [numeric](18, 4) NULL,
	[TIRCOMP] [numeric](8, 4) NULL,
	[BASECOMP] [numeric](3, 0) NULL,
	[VALCOMU] [numeric](18, 4) NULL,
	[TIRVENTA] [numeric](8, 4) NULL,
	[BASETIRVENTA] [numeric](3, 0) NULL,
	[FECINIP] [datetime] NULL,
	[FECVENP] [datetime] NULL,
	[VALINIP] [float] NULL,
	[VALVTOP] [float] NULL,
	[PRCVPAR] [numeric](9, 4) NULL,
	[CODIGO] [numeric](5, 0) NULL,
	[PROG] [char](7) NULL,
	[VPRESEN] [numeric](18, 4) NULL,
	[VALORPARC] [numeric](18, 8) NULL,
	[FORMAPAGOI] [numeric](5, 0) NULL,
	[FORMAPAGOV] [numeric](5, 0) NULL,
	[TIPOPER] [char](3) NULL,
	[INST] [char](6) NULL,
	[NUMCONTRATO] [numeric](8, 0) NULL,
	[TASACONTRATO] [numeric](10, 6) NULL,
	[SUCURSAL] [char](3) NULL,
	[TIPOCLIENTE] [char](2) NULL,
	[EJECUTIVO] [char](3) NULL,
	[MODALIDADINVERSION] [char](1) NULL,
	[FECHAPAGO] [datetime] NULL,
	[VALORCONTABLE] [numeric](18, 4) NULL,
	[INTERESACUM] [numeric](18, 4) NULL,
	[REAJUSTEACUM] [numeric](18, 4) NULL,
	[INDICA] [char](1) NULL,
	[ELIGE] [char](1) NULL,
	[RENTA] [char](1) NULL,
	[SENALA] [numeric](2, 0) NULL,
	[EMISOR] [char](5) NULL,
	[CODDCV] [char](8) NULL,
	[FECUCUP] [datetime] NULL,
	[VENTAVALOR] [numeric](18, 4) NULL,
	[VENTAFORPAGO] [numeric](3, 0) NULL,
	[VENTAFECPAGO] [datetime] NULL,
	[VENTAFECHAREAL] [datetime] NULL,
	[TIRHISTORICA] [numeric](8, 4) NULL,
	[INTERES] [numeric](18, 4) NULL,
	[NDIFERENCIA] [numeric](18, 4) NULL,
	[TIRANTERIOR] [numeric](8, 4) NULL,
	[REAJUSTE] [numeric](18, 4) NULL,
	[VALORPROX] [numeric](18, 4) NULL,
	[MASCARA] [char](12) NULL,
	[RUTCLICOMP] [numeric](9, 0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIPO_LISTADO]  DEFAULT ('') FOR [TIPO_LISTADO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_RUT_CARTERA]  DEFAULT ((0)) FOR [RUT_CARTERA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIPO_CARTERA]  DEFAULT ((0)) FOR [TIPO_CARTERA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_CARTERA]  DEFAULT ('') FOR [CARTERA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_NUMDOCU]  DEFAULT ((0)) FOR [NUMDOCU]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_NUMOPER]  DEFAULT ((0)) FOR [NUMOPER]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_CORRELA]  DEFAULT ((0)) FOR [CORRELA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_INSTSER]  DEFAULT ('') FOR [INSTSER]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECEMIS]  DEFAULT ('') FOR [FECEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_RUTEMIS]  DEFAULT ((0)) FOR [RUTEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_GENEMIS]  DEFAULT ('') FOR [GENEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_MONEMIS]  DEFAULT ((0)) FOR [MONEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TASEMIS]  DEFAULT ((0)) FOR [TASEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_BASEEMIS]  DEFAULT ((0)) FOR [BASEEMIS]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECVENC]  DEFAULT ('') FOR [FECVENC]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECPCUP]  DEFAULT ('') FOR [FECPCUP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_NOMINAL]  DEFAULT ((0)) FOR [NOMINAL]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_RUTCLI]  DEFAULT ((0)) FOR [RUTCLI]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_CODCLI]  DEFAULT ((0)) FOR [CODCLI]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECCOMP]  DEFAULT ('') FOR [FECCOMP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALCOMP]  DEFAULT ((0)) FOR [VALCOMP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIRCOMP]  DEFAULT ((0)) FOR [TIRCOMP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_BASECOMP]  DEFAULT ((0)) FOR [BASECOMP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALCOMU]  DEFAULT ((0)) FOR [VALCOMU]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIRVENTA]  DEFAULT ((0)) FOR [TIRVENTA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_BASETIRVENTA]  DEFAULT ((0)) FOR [BASETIRVENTA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECINIP]  DEFAULT ('') FOR [FECINIP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECVENP]  DEFAULT ('') FOR [FECVENP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALINIP]  DEFAULT ((0)) FOR [VALINIP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALVTOP]  DEFAULT ((0)) FOR [VALVTOP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_PRCVPAR]  DEFAULT ((0)) FOR [PRCVPAR]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_CODIGO]  DEFAULT ((0)) FOR [CODIGO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_PROG]  DEFAULT ('') FOR [PROG]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VPRESEN]  DEFAULT ((0)) FOR [VPRESEN]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALORPARC]  DEFAULT ((0)) FOR [VALORPARC]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FORMAPAGOI]  DEFAULT ((0)) FOR [FORMAPAGOI]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FORMAPAGOV]  DEFAULT ((0)) FOR [FORMAPAGOV]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIPOPER]  DEFAULT ('') FOR [TIPOPER]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_INST]  DEFAULT ('') FOR [INST]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_NUMCONTRATO]  DEFAULT ((0)) FOR [NUMCONTRATO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TASACONTRATO]  DEFAULT ((0)) FOR [TASACONTRATO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_SUCURSAL]  DEFAULT ('') FOR [SUCURSAL]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIPOCLIENTE]  DEFAULT ('') FOR [TIPOCLIENTE]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_EJECUTIVO]  DEFAULT ('') FOR [EJECUTIVO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_MODALIDADINVERSION]  DEFAULT ('') FOR [MODALIDADINVERSION]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECHAPAGO]  DEFAULT ('') FOR [FECHAPAGO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALORCONTABLE]  DEFAULT ((0)) FOR [VALORCONTABLE]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_INTERESACUM]  DEFAULT ((0)) FOR [INTERESACUM]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_REAJUSTEACUM]  DEFAULT ((0)) FOR [REAJUSTEACUM]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_INDICA]  DEFAULT ('') FOR [INDICA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_ELIGE]  DEFAULT ('') FOR [ELIGE]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_RENTA]  DEFAULT ('') FOR [RENTA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_SENALA]  DEFAULT ((0)) FOR [SENALA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_EMISOR]  DEFAULT ('') FOR [EMISOR]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_CODDCV]  DEFAULT ('') FOR [CODDCV]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_FECUCUP]  DEFAULT ('') FOR [FECUCUP]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VENTAVALOR]  DEFAULT ((0)) FOR [VENTAVALOR]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VENTAFORPAGO]  DEFAULT ((0)) FOR [VENTAFORPAGO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VENTAFECPAGO]  DEFAULT ('') FOR [VENTAFECPAGO]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VENTAFECHAREAL]  DEFAULT ('') FOR [VENTAFECHAREAL]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIRHISTORICA]  DEFAULT ((0)) FOR [TIRHISTORICA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_INTERES]  DEFAULT ((0)) FOR [INTERES]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_NDIFERENCIA]  DEFAULT ((0)) FOR [NDIFERENCIA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_TIRANTERIOR]  DEFAULT ((0)) FOR [TIRANTERIOR]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_REAJUSTE]  DEFAULT ((0)) FOR [REAJUSTE]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_VALORPROX]  DEFAULT ((0)) FOR [VALORPROX]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_MASCARA]  DEFAULT (' ') FOR [MASCARA]
GO
ALTER TABLE [dbo].[TABLA_VENTAS] ADD  CONSTRAINT [DF_TABLA_VENTAS_RUTCLICOMP]  DEFAULT ((0)) FOR [RUTCLICOMP]
GO

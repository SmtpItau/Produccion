USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[VALORIZACION_MERCADO]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALORIZACION_MERCADO](
	[fecha_valorizacion] [datetime] NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[rmrutcart] [numeric](9, 0) NOT NULL,
	[rmnumdocu] [numeric](10, 0) NOT NULL,
	[rmnumoper] [numeric](10, 0) NOT NULL,
	[rmcorrela] [numeric](3, 0) NOT NULL,
	[rmcodigo] [numeric](5, 0) NOT NULL,
	[rminstser] [char](10) NOT NULL,
	[rut_emisor] [numeric](9, 0) NOT NULL,
	[moneda_emision] [numeric](3, 0) NOT NULL,
	[valor_nominal] [numeric](19, 4) NOT NULL,
	[tasa_compra] [numeric](8, 4) NOT NULL,
	[tasa_mercado] [numeric](19, 4) NULL,
	[tasa_market] [numeric](8, 4) NOT NULL,
	[tasa_market1] [numeric](8, 4) NOT NULL,
	[tasa_market2] [numeric](8, 4) NOT NULL,
	[valor_presente] [numeric](19, 4) NULL,
	[valor_mercado] [numeric](19, 4) NULL,
	[valor_market] [numeric](19, 4) NULL,
	[valor_market1] [numeric](19, 4) NULL,
	[valor_market2] [numeric](19, 4) NULL,
	[diferencia_mercado] [numeric](19, 4) NULL,
	[diferencia_market] [numeric](19, 4) NULL,
	[diferencia_market1] [numeric](19, 4) NULL,
	[diferencia_market2] [numeric](19, 4) NULL,
	[tmfecemi] [datetime] NULL,
	[tmfecven] [datetime] NULL,
	[tmseriado] [char](1) NULL,
	[tmmascara] [char](12) NULL,
	[PorcjeCob] [numeric](5, 2) NOT NULL,
	[OrigenCurva] [char](2) NOT NULL,
	[ValorMercadoParPrx] [numeric](19, 4) NOT NULL,
	[ValorMercadoCLPParPrx] [numeric](19, 4) NOT NULL,
	[Convexidad] [float] NOT NULL,
	[Duration_Mod] [float] NOT NULL,
	[VpComp] [float] NOT NULL,
	[ID_NIVEL_DE_RIESGO] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__rmcod__2BA35AFD]  DEFAULT (0) FOR [rmcodigo]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__rmins__2C977F36]  DEFAULT ('') FOR [rminstser]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__rut_e__2D8BA36F]  DEFAULT (0) FOR [rut_emisor]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__moned__2E7FC7A8]  DEFAULT (0) FOR [moneda_emision]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__2F73EBE1]  DEFAULT (0) FOR [valor_nominal]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__tasa___3068101A]  DEFAULT (0) FOR [tasa_compra]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__tasa___315C3453]  DEFAULT (0) FOR [tasa_mercado]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__tasa___3250588C]  DEFAULT (0) FOR [tasa_market]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__tasa___33447CC5]  DEFAULT (0) FOR [tasa_market1]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__tasa___3438A0FE]  DEFAULT (0) FOR [tasa_market2]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__352CC537]  DEFAULT (0) FOR [valor_presente]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__3620E970]  DEFAULT (0) FOR [valor_mercado]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__37150DA9]  DEFAULT (0) FOR [valor_market]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__380931E2]  DEFAULT (0) FOR [valor_market1]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__valor__38FD561B]  DEFAULT (0) FOR [valor_market2]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__difer__39F17A54]  DEFAULT (0) FOR [diferencia_mercado]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__difer__3AE59E8D]  DEFAULT (0) FOR [diferencia_market]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__difer__3BD9C2C6]  DEFAULT (0) FOR [diferencia_market1]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__VALORIZAC__difer__3CCDE6FF]  DEFAULT (0) FOR [diferencia_market2]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__valorizac__tmfec__1415EA2F]  DEFAULT ('') FOR [tmfecemi]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__valorizac__tmfec__150A0E68]  DEFAULT ('') FOR [tmfecven]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__valorizac__tmser__15FE32A1]  DEFAULT ('N') FOR [tmseriado]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [DF__valorizac__tmmas__16F256DA]  DEFAULT ('') FOR [tmmascara]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [CT_PorcjeCob]  DEFAULT (0) FOR [PorcjeCob]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  CONSTRAINT [dfValorizacionMercado_OrigenCurva]  DEFAULT ('') FOR [OrigenCurva]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT (0) FOR [ValorMercadoParPrx]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT (0) FOR [ValorMercadoCLPParPrx]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT (0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT (0) FOR [Duration_Mod]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT ((0.0)) FOR [VpComp]
GO
ALTER TABLE [dbo].[VALORIZACION_MERCADO] ADD  DEFAULT ('') FOR [ID_NIVEL_DE_RIESGO]
GO

USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[DETALLE_FLI]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_FLI](
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
	[Fecha_UltCup] [datetime] NOT NULL,
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
 CONSTRAINT [Pk_DETALLE_FLI] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC,
	[Ventana] ASC,
	[Marca] ASC,
	[Documento] ASC,
	[Correlativo] ASC,
	[Serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Marca]  DEFAULT ('') FOR [Marca]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Documento]  DEFAULT (0) FOR [Documento]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Correlativo]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Serie]  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Moneda]  DEFAULT ('') FOR [Moneda]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Nominal_Compra]  DEFAULT (0.0) FOR [Nominal_Compra]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Tasa_Compra]  DEFAULT (0.0) FOR [Tasa_Compra]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Valor_Par]  DEFAULT (0.0) FOR [Valor_Par]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Valor_Presente]  DEFAULT (0.0) FOR [Valor_Presente]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Margen]  DEFAULT (0.0) FOR [Margen]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Valor_Inicial]  DEFAULT (0.0) FOR [Valor_Inicial]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Nominal_Venta]  DEFAULT (0.0) FOR [Nominal_Venta]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Tasa_Venta]  DEFAULT (0.0) FOR [Tasa_Venta]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_vPar_Venta]  DEFAULT (0.0) FOR [vPar_Venta]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_vPresente_Venta]  DEFAULT (0.0) FOR [vPresente_Venta]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_vInicial_Venta]  DEFAULT (0.0) FOR [vInicial_Venta]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Plazo]  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Ventana]  DEFAULT (0) FOR [Ventana]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Fecha_Emision]  DEFAULT ('') FOR [Fecha_Emision]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Fecha_Vence]  DEFAULT ('') FOR [Fecha_Vence]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Fecha_UltCup]  DEFAULT ('') FOR [Fecha_UltCup]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Fecha_SigCup]  DEFAULT ('') FOR [Fecha_SigCup]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Numero_Cupon]  DEFAULT (0) FOR [Numero_Cupon]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Rut_Emisor]  DEFAULT (0) FOR [Rut_Emisor]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Mon_Emisor]  DEFAULT (0) FOR [Mon_Emisor]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_Convexidad]  DEFAULT (0.0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_DurMod]  DEFAULT (0.0) FOR [DurMod]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_DurMac]  DEFAULT (0.0) FOR [DurMac]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_TasaEstimada]  DEFAULT (0.0) FOR [TasaEstimada]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  DEFAULT ('') FOR [CarteraSuper]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_BloqueoPacto]  DEFAULT (0.0) FOR [BloqueoPacto]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_HairCut]  DEFAULT (0.0) FOR [HairCut]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_TipOper]  DEFAULT ('FLI') FOR [TipOper]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_FolioBCCH]  DEFAULT (0) FOR [FolioBCCH]
GO
ALTER TABLE [dbo].[DETALLE_FLI] ADD  CONSTRAINT [df_DETALLE_FLI_CorrelaBCCH]  DEFAULT (0) FOR [CorrelaBCCH]
GO

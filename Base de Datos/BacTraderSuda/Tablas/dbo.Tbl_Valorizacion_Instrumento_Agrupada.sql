USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Tbl_Valorizacion_Instrumento_Agrupada]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada](
	[Garantia_Numero] [numeric](9, 0) NOT NULL,
	[NumeroDocumento] [numeric](9, 0) NOT NULL,
	[CorrelativoDocumento] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](15) NOT NULL,
	[Mascara] [varchar](15) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Seriado] [char](1) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[Tir] [numeric](10, 4) NOT NULL,
	[ValorProceso] [numeric](21, 4) NOT NULL,
	[ValorProxProceso] [numeric](21, 4) NOT NULL,
	[CapitalCompra] [float] NOT NULL,
	[InteresCompra] [float] NOT NULL,
	[ReajusteCompra] [float] NOT NULL,
	[InteresAcumCp] [float] NOT NULL,
	[ReajusteAcumCp] [float] NOT NULL,
	[ValorCompra] [float] NOT NULL,
	[ValorCompraUm] [float] NOT NULL,
	[ValorCompraUm100] [float] NOT NULL,
	[ValorVencimiento] [float] NOT NULL,
	[Capital] [float] NOT NULL,
	[Interes] [float] NOT NULL,
	[Reajuste] [float] NOT NULL,
	[Interes_Mes] [float] NOT NULL,
	[Reajuste_Mes] [float] NOT NULL,
	[Interes_Acum] [float] NOT NULL,
	[Reajuste_Acum] [float] NOT NULL,
	[Amortizacion] [float] NOT NULL,
	[InteresCupon] [float] NOT NULL,
	[ReajusteCupon] [float] NOT NULL,
	[Flujo] [float] NOT NULL,
	[PrimaDescuento] [float] NOT NULL,
	[ValorTasaEmision] [float] NOT NULL,
	[Valorcompraum_original] [float] NOT NULL,
	[Valorcompraoriginal] [float] NOT NULL,
	[TasaMercado] [float] NOT NULL,
	[ValorMercado] [float] NOT NULL,
	[DiferenciaMercado] [float] NOT NULL,
 CONSTRAINT [PK_TBL_VAL_GARANTIA_GRP] PRIMARY KEY CLUSTERED 
(
	[Garantia_Numero] ASC,
	[NumeroDocumento] ASC,
	[CorrelativoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Garantia_Numero]  DEFAULT ((0.0)) FOR [Garantia_Numero]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_NumeroDocumento]  DEFAULT ((0.0)) FOR [NumeroDocumento]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_CorrelativoDocumento]  DEFAULT ((0.0)) FOR [CorrelativoDocumento]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Serie]  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Mascara]  DEFAULT ('') FOR [Mascara]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Codigo]  DEFAULT ((0)) FOR [Codigo]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Seriado]  DEFAULT ('') FOR [Seriado]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Nominal]  DEFAULT ((0.0)) FOR [Nominal]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Tir]  DEFAULT ((0.0)) FOR [Tir]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorProceso]  DEFAULT ((0.0)) FOR [ValorProceso]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorProxProceso]  DEFAULT ((0.0)) FOR [ValorProxProceso]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_CapitalCompra]  DEFAULT ((0.0)) FOR [CapitalCompra]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_InteresCompra]  DEFAULT ((0.0)) FOR [InteresCompra]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ReajusteCompra]  DEFAULT ((0.0)) FOR [ReajusteCompra]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_InteresAcumCp]  DEFAULT ((0.0)) FOR [InteresAcumCp]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ReajusteAcumCp]  DEFAULT ((0.0)) FOR [ReajusteAcumCp]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorCompra]  DEFAULT ((0.0)) FOR [ValorCompra]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorCompraUm]  DEFAULT ((0.0)) FOR [ValorCompraUm]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorCompraUm100]  DEFAULT ((0.0)) FOR [ValorCompraUm100]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorVencimiento]  DEFAULT ((0.0)) FOR [ValorVencimiento]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Capital]  DEFAULT ((0.0)) FOR [Capital]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Interes]  DEFAULT ((0.0)) FOR [Interes]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Reajuste]  DEFAULT ((0.0)) FOR [Reajuste]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Interes_Mes]  DEFAULT ((0.0)) FOR [Interes_Mes]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Reajuste_Mes]  DEFAULT ((0.0)) FOR [Reajuste_Mes]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Interes_Acum]  DEFAULT ((0.0)) FOR [Interes_Acum]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Reajuste_Acum]  DEFAULT ((0.0)) FOR [Reajuste_Acum]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Amortizacion]  DEFAULT ((0.0)) FOR [Amortizacion]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_InteresCupon]  DEFAULT ((0.0)) FOR [InteresCupon]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ReajusteCupon]  DEFAULT ((0.0)) FOR [ReajusteCupon]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Flujo]  DEFAULT ((0.0)) FOR [Flujo]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_PrimaDescuento]  DEFAULT ((0.0)) FOR [PrimaDescuento]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorTasaEmision]  DEFAULT ((0.0)) FOR [ValorTasaEmision]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Valorcompraum_original]  DEFAULT ((0.0)) FOR [Valorcompraum_original]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_Valorcompraoriginal]  DEFAULT ((0.0)) FOR [Valorcompraoriginal]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_TasaMercado]  DEFAULT ((0.0)) FOR [TasaMercado]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_ValorMercado]  DEFAULT ((0.0)) FOR [ValorMercado]
GO
ALTER TABLE [dbo].[Tbl_Valorizacion_Instrumento_Agrupada] ADD  CONSTRAINT [df_TblValInsGrp_DiferenciaMercado]  DEFAULT ((0.0)) FOR [DiferenciaMercado]
GO

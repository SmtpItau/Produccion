USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Liquidaciones_SOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Liquidaciones_SOS](
	[FechaCarga] [datetime] NOT NULL,
	[IdentificacionCliente] [char](2) NOT NULL,
	[IdentificadorClienteNumero] [char](15) NOT NULL,
	[NumTransaccion] [char](1) NOT NULL,
	[OrigenDeLosFondos] [char](1) NOT NULL,
	[TipoOperacion] [char](4) NOT NULL,
	[NumeroDeOperacion] [numeric](15, 0) NOT NULL,
	[OficialCta] [char](20) NOT NULL,
	[NumeroCheque] [char](17) NOT NULL,
	[TipoCta] [char](4) NOT NULL,
	[EspeciaTransadaCantidad] [numeric](17, 0) NOT NULL,
	[EspeciaTransadaTipo] [char](3) NOT NULL,
	[Causal] [char](5) NOT NULL,
	[BeneficiarioOrdenanteDelExte] [char](20) NOT NULL,
	[PaisDelBeneficiarioOrdenante] [char](19) NOT NULL,
	[MedioPago] [char](1) NOT NULL,
	[Sucursal] [char](3) NOT NULL,
	[FechaDeLaOperacion] [datetime] NOT NULL,
	[FechaDeLaLiquidacion] [datetime] NOT NULL,
	[RutCliente] [char](11) NOT NULL,
	[CodigoCliente] [numeric](5, 0) NOT NULL,
	[OrigenDeLosDatos] [char](3) NOT NULL,
	[Operador] [varchar](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_FechaCarga]  DEFAULT ('') FOR [FechaCarga]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_IdentificacionCliente]  DEFAULT ('') FOR [IdentificacionCliente]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_IdentificadorClienteNumero]  DEFAULT ('') FOR [IdentificadorClienteNumero]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_NumTransaccion]  DEFAULT ('') FOR [NumTransaccion]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_OrigenDeLosFondos]  DEFAULT ('') FOR [OrigenDeLosFondos]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_TipoOperacion]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_NumeroDeOperacion]  DEFAULT ((0)) FOR [NumeroDeOperacion]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_OficialCta]  DEFAULT ('') FOR [OficialCta]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_NumeroCheque]  DEFAULT ('') FOR [NumeroCheque]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_TipoCta]  DEFAULT ('') FOR [TipoCta]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_EspeciaTransadaCantidad]  DEFAULT ((0)) FOR [EspeciaTransadaCantidad]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_EspeciaTransadaTipo]  DEFAULT ('') FOR [EspeciaTransadaTipo]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_Causal]  DEFAULT ('') FOR [Causal]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_BeneficiarioOrdenanteDelExte]  DEFAULT ('') FOR [BeneficiarioOrdenanteDelExte]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_PaisDelBeneficiarioOrdenante]  DEFAULT ('') FOR [PaisDelBeneficiarioOrdenante]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_MedioPago]  DEFAULT ('') FOR [MedioPago]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_Sucursal]  DEFAULT ('') FOR [Sucursal]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_FechaDeLaOperacion]  DEFAULT ('') FOR [FechaDeLaOperacion]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_FechaDeLaLiquidacion]  DEFAULT ('') FOR [FechaDeLaLiquidacion]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_RutCliente]  DEFAULT ('') FOR [RutCliente]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_CodigoCliente]  DEFAULT ((0)) FOR [CodigoCliente]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_OrigenDeLosDatos]  DEFAULT ('') FOR [OrigenDeLosDatos]
GO
ALTER TABLE [dbo].[Liquidaciones_SOS] ADD  CONSTRAINT [df_Liquidaciones_SOS_Operador]  DEFAULT ('') FOR [Operador]
GO

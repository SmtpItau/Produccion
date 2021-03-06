USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_TRIBUTARIOS]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TRIBUTARIOS](
	[FechaAnalisis] [datetime] NOT NULL,
	[FechaCierre] [datetime] NOT NULL,
	[FechaSuscripcion] [datetime] NOT NULL,
	[FechaLiquidacion] [datetime] NOT NULL,
	[FolioContrato] [numeric](21, 0) NOT NULL,
	[Correlativo] [numeric](21, 0) NOT NULL,
	[NewRegistro] [int] NOT NULL,
	[Origen] [char](3) NOT NULL,
	[TipoOperacion] [varchar](5) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[RutCliente] [numeric](15, 0) NOT NULL,
	[CodCliente] [numeric](15, 0) NOT NULL,
	[CtaAVR] [varchar](20) NOT NULL,
	[CtaPatrimonio] [varchar](20) NOT NULL,
	[CtaResultado] [varchar](20) NOT NULL,
	[CtaCaja] [varchar](20) NOT NULL,
	[nMontoAVRNeto] [numeric](21, 4) NOT NULL,
	[nMontoAVRProceso] [numeric](21, 4) NOT NULL,
	[nMontoCaja] [numeric](21, 4) NOT NULL,
	[nMontoPatrimonio] [numeric](21, 4) NOT NULL,
	[nMontoResultado] [numeric](21, 4) NOT NULL,
	[nMontoLiquidacion] [numeric](21, 4) NOT NULL,
	[nMontoSaldoAvrTermino] [numeric](21, 4) NOT NULL,
	[nSignoAvr] [char](1) NOT NULL,
	[iSaldo] [int] NOT NULL,
	[nMonedaOperacion] [int] NOT NULL,
	[nMonedaConversion] [int] NOT NULL,
	[FluCajPer] [numeric](15, 0) NULL,
	[FluCajPerAnt] [numeric](15, 0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_FechaAnalisis]  DEFAULT ('') FOR [FechaAnalisis]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_FechaCierre]  DEFAULT ('') FOR [FechaCierre]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_FechaSuscripcion]  DEFAULT ('') FOR [FechaSuscripcion]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_FechaLiquidacion]  DEFAULT ('') FOR [FechaLiquidacion]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_FolioContrato]  DEFAULT ((0)) FOR [FolioContrato]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_Correlativo]  DEFAULT ((0)) FOR [Correlativo]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_NewRegistro]  DEFAULT ((0)) FOR [NewRegistro]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_Origen]  DEFAULT ('') FOR [Origen]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_TipoOperacion]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_RutCliente]  DEFAULT ((0)) FOR [RutCliente]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_CodCliente]  DEFAULT ((0)) FOR [CodCliente]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_CtaAVR]  DEFAULT ('') FOR [CtaAVR]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_CtaPatrimonio]  DEFAULT ('') FOR [CtaPatrimonio]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_CtaResultado]  DEFAULT ('') FOR [CtaResultado]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_CtaCaja]  DEFAULT ('') FOR [CtaCaja]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoAVRNeto]  DEFAULT ((0.0)) FOR [nMontoAVRNeto]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoAVRProceso]  DEFAULT ((0.0)) FOR [nMontoAVRProceso]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoCaja]  DEFAULT ((0.0)) FOR [nMontoCaja]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoPatrimonio]  DEFAULT ((0.0)) FOR [nMontoPatrimonio]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoResultado]  DEFAULT ((0.0)) FOR [nMontoResultado]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoLiquidacion]  DEFAULT ((0.0)) FOR [nMontoLiquidacion]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMontoSaldoAvrTermino]  DEFAULT ((0.0)) FOR [nMontoSaldoAvrTermino]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nSignoAvr]  DEFAULT ('') FOR [nSignoAvr]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_iSaldo]  DEFAULT ((0)) FOR [iSaldo]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMonedaOperacion]  DEFAULT ((0)) FOR [nMonedaOperacion]
GO
ALTER TABLE [dbo].[TBL_TRIBUTARIOS] ADD  CONSTRAINT [df_TBL_TRIBUTARIOS_nMonedaConversion]  DEFAULT ((0)) FOR [nMonedaConversion]
GO

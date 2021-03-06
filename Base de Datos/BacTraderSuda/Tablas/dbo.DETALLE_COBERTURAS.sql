USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[DETALLE_COBERTURAS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_COBERTURAS](
	[nCobertura] [numeric](9, 0) NOT NULL,
	[cSistema] [char](3) NOT NULL,
	[nDocumento] [numeric](9, 0) NOT NULL,
	[nCorrelativo] [numeric](9, 0) NOT NULL,
	[cSerie] [varchar](15) NOT NULL,
	[iMoneda] [int] NOT NULL,
	[nMontoOperacion] [numeric](21, 4) NOT NULL,
	[nValorMercado] [numeric](21, 4) NOT NULL,
	[nMontoCubrir] [numeric](21, 4) NOT NULL,
	[nVRazonableCubrir] [numeric](21, 4) NOT NULL,
	[nMontoDerivado] [numeric](21, 4) NOT NULL,
	[nRazonableDerivado] [numeric](21, 4) NOT NULL,
	[pEfectividad] [numeric](21, 4) NOT NULL,
	[dFechaIngreso] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nCobertura]  DEFAULT (0) FOR [nCobertura]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_cSistema]  DEFAULT ('') FOR [cSistema]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nDocumento]  DEFAULT (0) FOR [nDocumento]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nCorrelativo]  DEFAULT (0) FOR [nCorrelativo]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_cSerie]  DEFAULT ('') FOR [cSerie]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_iMoneda]  DEFAULT (0) FOR [iMoneda]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nMontoOperacion]  DEFAULT (0.0) FOR [nMontoOperacion]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nValorMercado]  DEFAULT (0.0) FOR [nValorMercado]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nMontoCubrir]  DEFAULT (0.0) FOR [nMontoCubrir]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nVRazonableCubrir]  DEFAULT (0.0) FOR [nVRazonableCubrir]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nMontoDerivado]  DEFAULT (0.0) FOR [nMontoDerivado]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_nRazonableDerivado]  DEFAULT (0.0) FOR [nRazonableDerivado]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_pEfectividad]  DEFAULT (0.0) FOR [pEfectividad]
GO
ALTER TABLE [dbo].[DETALLE_COBERTURAS] ADD  CONSTRAINT [dfDetalleCobertura_dFechaIngreso]  DEFAULT ('') FOR [dFechaIngreso]
GO

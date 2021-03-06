USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[COBERTURAS_HISTORICO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COBERTURAS_HISTORICO](
	[dFechaProceso] [datetime] NOT NULL,
	[dFecha] [datetime] NOT NULL,
	[nCobertura] [numeric](9, 0) NOT NULL,
	[cModulo] [char](3) NOT NULL,
	[nDerivado] [numeric](9, 0) NOT NULL,
	[nCorrela] [numeric](9, 0) NOT NULL,
	[nMontoOperacion] [numeric](21, 4) NOT NULL,
	[nMontoOcupado] [numeric](21, 4) NOT NULL,
	[nMontoDisponible] [numeric](21, 4) NOT NULL,
	[nVRazonableOcup] [numeric](21, 4) NOT NULL,
	[nVRazonableDisp] [numeric](21, 4) NOT NULL,
	[nVRazonableMonto] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_dFechaProceso]  DEFAULT ('') FOR [dFechaProceso]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_dFecha]  DEFAULT ('') FOR [dFecha]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nCobertura]  DEFAULT (0.0) FOR [nCobertura]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_cModulo]  DEFAULT ('') FOR [cModulo]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nDerivado]  DEFAULT (0.0) FOR [nDerivado]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nCorrela]  DEFAULT (0.0) FOR [nCorrela]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nMontoOperacion]  DEFAULT (0.0) FOR [nMontoOperacion]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nMontoOcupado]  DEFAULT (0.0) FOR [nMontoOcupado]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nMontoDisponible]  DEFAULT (0.0) FOR [nMontoDisponible]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nVRazonableOcup]  DEFAULT (0.0) FOR [nVRazonableOcup]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nVRazonableDisp]  DEFAULT (0.0) FOR [nVRazonableDisp]
GO
ALTER TABLE [dbo].[COBERTURAS_HISTORICO] ADD  CONSTRAINT [dfCoberturasHist_nVRazonableMonto]  DEFAULT (0.0) FOR [nVRazonableMonto]
GO

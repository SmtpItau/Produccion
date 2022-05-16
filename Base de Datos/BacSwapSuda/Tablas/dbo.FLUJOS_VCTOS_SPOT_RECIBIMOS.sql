USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS](
	[RecFechaProceso] [datetime] NOT NULL,
	[RecNumeroOperacion] [numeric](7, 0) NOT NULL,
	[RecTipoOperacion] [char](1) NOT NULL,
	[RecTipoSwap] [numeric](1, 0) NOT NULL,
	[RecNumeroFlujo] [numeric](3, 0) NOT NULL,
	[RecRutCliente] [numeric](9, 0) NOT NULL,
	[RecCodCliente] [numeric](9, 0) NOT NULL,
	[RecMoneda] [numeric](3, 0) NOT NULL,
	[RecCompraAmortiza] [float] NOT NULL,
	[RecCompraInteres] [float] NOT NULL,
	[RecCompraMoneda] [numeric](3, 0) NOT NULL,
	[RecDocumento] [numeric](3, 0) NOT NULL,
	[RecValorMdaCompra] [float] NOT NULL,
	[RecMontoCompraMda] [float] NOT NULL,
	[RecMontoMda] [float] NOT NULL,
	[RecPrecioCompraMda] [float] NOT NULL,
	[RecPrecioMda] [float] NOT NULL,
	[RecParCompraMda] [float] NOT NULL,
	[RecParMda] [float] NOT NULL,
	[RecMnPrioridad] [int] NOT NULL,
	[RecDiasValor] [numeric](5, 0) NOT NULL,
	[RecCompraCodigoTasa] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecFechaProceso]  DEFAULT ('') FOR [RecFechaProceso]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecNumeroOperacion]  DEFAULT ((0)) FOR [RecNumeroOperacion]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecTipoOperacion]  DEFAULT ('') FOR [RecTipoOperacion]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecTipoSwap]  DEFAULT ((0)) FOR [RecTipoSwap]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecNumeroFlujo]  DEFAULT ((0)) FOR [RecNumeroFlujo]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecRutCliente]  DEFAULT ((0)) FOR [RecRutCliente]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecCodCliente]  DEFAULT ((0)) FOR [RecCodCliente]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecRecibimosMoneda]  DEFAULT ((0)) FOR [RecMoneda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecCompraAmortiza]  DEFAULT ((0.0)) FOR [RecCompraAmortiza]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecCompraInteres]  DEFAULT ((0.0)) FOR [RecCompraInteres]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecCompraMoneda]  DEFAULT ((0)) FOR [RecCompraMoneda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecDocumento]  DEFAULT ((0)) FOR [RecDocumento]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecValorMdaCompra]  DEFAULT ((0.0)) FOR [RecValorMdaCompra]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecMontoCompraMda]  DEFAULT ((0.0)) FOR [RecMontoCompraMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecMontoMda]  DEFAULT ((0.0)) FOR [RecMontoMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecPrecioCompraMda]  DEFAULT ((0.0)) FOR [RecPrecioCompraMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecPrecioMda]  DEFAULT ((0.0)) FOR [RecPrecioMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecParCompraMda]  DEFAULT ((0.0)) FOR [RecParCompraMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecParMda]  DEFAULT ((0.0)) FOR [RecParMda]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecMnPrioridad]  DEFAULT ((0)) FOR [RecMnPrioridad]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecDiasValor]  DEFAULT ((0)) FOR [RecDiasValor]
GO
ALTER TABLE [dbo].[FLUJOS_VCTOS_SPOT_RECIBIMOS] ADD  CONSTRAINT [FLUJOS_VCTOS_SPOT_RECIBIMOS_RecCompraCodigoTasa]  DEFAULT ((0)) FOR [RecCompraCodigoTasa]
GO

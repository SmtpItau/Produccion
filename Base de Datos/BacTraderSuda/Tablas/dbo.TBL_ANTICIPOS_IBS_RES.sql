USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBL_ANTICIPOS_IBS_RES]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ANTICIPOS_IBS_RES](
	[FechaProceso] [datetime] NOT NULL,
	[NumPrestamo] [numeric](12, 0) NOT NULL,
	[CodigoProducto] [varchar](4) NOT NULL,
	[CodigoFamilia] [varchar](4) NOT NULL,
	[NumDerivado] [numeric](12, 0) NOT NULL,
	[TipoDRV] [varchar](1) NOT NULL,
	[TipoAnticipo] [varchar](30) NOT NULL,
	[Monto] [float] NOT NULL,
	[FechaAnticipo] [datetime] NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_FechaProceso]  DEFAULT ('') FOR [FechaProceso]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_NumPrestamo]  DEFAULT ((0)) FOR [NumPrestamo]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_CodigoProducto]  DEFAULT ('') FOR [CodigoProducto]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_CodigoFamilia]  DEFAULT ('') FOR [CodigoFamilia]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_NumDerivado]  DEFAULT ((0)) FOR [NumDerivado]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_TipoDRV]  DEFAULT ('') FOR [TipoDRV]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_TipoAnticipo]  DEFAULT ('') FOR [TipoAnticipo]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_Monto]  DEFAULT ((0.0)) FOR [Monto]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_FechaAnticipo]  DEFAULT ('') FOR [FechaAnticipo]
GO
ALTER TABLE [dbo].[TBL_ANTICIPOS_IBS_RES] ADD  CONSTRAINT [df_TBL_ANTICIPOS_IBS_RES_RutCliente]  DEFAULT ((0)) FOR [RutCliente]
GO

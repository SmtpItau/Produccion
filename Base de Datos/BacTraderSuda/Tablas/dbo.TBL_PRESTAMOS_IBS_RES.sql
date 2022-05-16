USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBL_PRESTAMOS_IBS_RES]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_PRESTAMOS_IBS_RES](
	[FechaProceso] [datetime] NOT NULL,
	[NumPrestamo] [numeric](12, 0) NOT NULL,
	[CodigoProducto] [varchar](4) NOT NULL,
	[CodigoFamilia] [varchar](4) NOT NULL,
	[NumDerivado] [numeric](12, 0) NOT NULL,
	[Tipo] [varchar](1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Monto] [float] NOT NULL,
	[CodigoTasa] [varchar](2) NOT NULL,
	[TipoTasa] [varchar](35) NOT NULL,
	[TasaCliente] [float] NOT NULL,
	[Spread] [float] NOT NULL,
	[MonedaPrestamo] [varchar](3) NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[TipoPlazo] [varchar](1) NOT NULL,
	[Plazo] [numeric](4, 0) NOT NULL,
	[EstadoOperacion] [varchar](7) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_FechaProceso]  DEFAULT ('') FOR [FechaProceso]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_NumPrestamo]  DEFAULT ((0)) FOR [NumPrestamo]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_CodigoProducto]  DEFAULT ('') FOR [CodigoProducto]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_CodigoFamilia]  DEFAULT ('') FOR [CodigoFamilia]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_NumDerivado]  DEFAULT ((0)) FOR [NumDerivado]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_Tipo]  DEFAULT ('') FOR [Tipo]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_FechaInicio]  DEFAULT ('') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_FechaVencimiento]  DEFAULT ('') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_Monto]  DEFAULT ((0.0)) FOR [Monto]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_CodigoTasa]  DEFAULT ('') FOR [CodigoTasa]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_TipoTasa]  DEFAULT ('') FOR [TipoTasa]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_TasaCliente]  DEFAULT ((0.0)) FOR [TasaCliente]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_Spread]  DEFAULT ((0.0)) FOR [Spread]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_MonedaPrestamo]  DEFAULT ('') FOR [MonedaPrestamo]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_RutCliente]  DEFAULT ((0)) FOR [RutCliente]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_TipoPlazo]  DEFAULT ('') FOR [TipoPlazo]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_Plazo]  DEFAULT ((0)) FOR [Plazo]
GO
ALTER TABLE [dbo].[TBL_PRESTAMOS_IBS_RES] ADD  CONSTRAINT [df_TBL_PRESTAMOS_IBS_RES_EstadoOperacion]  DEFAULT ('') FOR [EstadoOperacion]
GO

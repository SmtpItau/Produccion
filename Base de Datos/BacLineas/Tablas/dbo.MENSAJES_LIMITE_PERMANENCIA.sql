USE [BacLineas]
GO
/****** Object:  Table [dbo].[MENSAJES_LIMITE_PERMANENCIA]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA](
	[Fecha] [datetime] NOT NULL,
	[Id_Sistema] [varchar](5) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[NumOperacion] [numeric](9, 0) NOT NULL,
	[NumDocumento] [numeric](9, 0) NOT NULL,
	[NumCorrelativo] [numeric](9, 0) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Familia] [varchar](20) NOT NULL,
	[Instrumento] [varchar](20) NOT NULL,
	[RutEmisor] [numeric](9, 0) NOT NULL,
	[Operador] [varchar](15) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[Tasa] [numeric](21, 4) NOT NULL,
	[Pvp] [numeric](21, 4) NOT NULL,
	[PlazoLimite] [numeric](9, 0) NOT NULL,
	[PlazoActual] [numeric](9, 0) NOT NULL,
	[Firma1] [varchar](15) NOT NULL,
	[Firma2] [varchar](15) NOT NULL,
	[Mensaje] [nvarchar](2500) NOT NULL,
	[FechaSistema] [datetime] NOT NULL,
	[HoraSistema] [datetime] NOT NULL,
	[nIdRelacion] [numeric](21, 0) NOT NULL,
	[nEstado] [int] NOT NULL,
	[Id] [numeric](21, 0) IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Id_Sistema]  DEFAULT ('') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_NumOperacion]  DEFAULT ((0)) FOR [NumOperacion]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_NumDocumento]  DEFAULT ((0)) FOR [NumDocumento]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_NumCorrelativo]  DEFAULT ((0)) FOR [NumCorrelativo]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Codigo]  DEFAULT ((0)) FOR [Codigo]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Familia]  DEFAULT ('') FOR [Familia]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Instrumento]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_RutEmisor]  DEFAULT ((0)) FOR [RutEmisor]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Operador]  DEFAULT ('') FOR [Operador]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Nominal]  DEFAULT ((0.0)) FOR [Nominal]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Tasa]  DEFAULT ((0.0)) FOR [Tasa]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Pvp]  DEFAULT ((0)) FOR [Pvp]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_PlazoLimite]  DEFAULT ((0)) FOR [PlazoLimite]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_PlazoActual]  DEFAULT ((0)) FOR [PlazoActual]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Firma1]  DEFAULT ('') FOR [Firma1]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Firma2]  DEFAULT ('') FOR [Firma2]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_Mensaje]  DEFAULT ('') FOR [Mensaje]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_FechaSistema]  DEFAULT ('') FOR [FechaSistema]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_HoraSistema]  DEFAULT ('') FOR [HoraSistema]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_nIdRelacion]  DEFAULT ((-1)) FOR [nIdRelacion]
GO
ALTER TABLE [dbo].[MENSAJES_LIMITE_PERMANENCIA] ADD  CONSTRAINT [df_msgLimitePermanencia_nEstado]  DEFAULT ((-1)) FOR [nEstado]
GO

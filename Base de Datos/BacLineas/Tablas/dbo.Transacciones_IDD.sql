USE [BacLineas]
GO
/****** Object:  Table [dbo].[Transacciones_IDD]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones_IDD](
	[cModulo] [char](3) NOT NULL,
	[cProducto] [varchar](10) NOT NULL,
	[nOperacion] [numeric](9, 0) NOT NULL,
	[nDocumento] [numeric](9, 0) NOT NULL,
	[iCorrelativo] [int] NOT NULL,
	[nIncodigo] [numeric](5, 0) NOT NULL,
	[nMoneda] [numeric](3, 0) NOT NULL,
	[nMontoOperacion] [float] NOT NULL,
	[nPlazo] [numeric](9, 0) NOT NULL,
	[iRut] [numeric](11, 0) NOT NULL,
	[iCodigo] [int] NOT NULL,
	[nMontoLimite] [float] NOT NULL,
	[sTrader] [varchar](20) NOT NULL,
	[sAprobador] [varchar](20) NOT NULL,
	[iEstadoIdd] [char](1) NOT NULL,
	[sEstadoCF] [numeric](1, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Hora] [datetime] NULL,
	[sMensajeIdd] [varchar](50) NULL,
	[nNumeroIdd] [numeric](9, 0) NOT NULL,
	[sControlLinea] [char](1) NOT NULL,
 CONSTRAINT [Pk_TransaccionesIDD] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[cModulo] ASC,
	[cProducto] ASC,
	[nOperacion] ASC,
	[nDocumento] ASC,
	[iCorrelativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_cModulo]  DEFAULT ('') FOR [cModulo]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_cProducto]  DEFAULT ('') FOR [cProducto]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nOperacion]  DEFAULT ((0)) FOR [nOperacion]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nDocumento]  DEFAULT ((0)) FOR [nDocumento]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_iCorrelativo]  DEFAULT ((0)) FOR [iCorrelativo]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nIncodigo]  DEFAULT ((0)) FOR [nIncodigo]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nMoneda]  DEFAULT ((0)) FOR [nMoneda]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nMontoOperacion]  DEFAULT ((0.0)) FOR [nMontoOperacion]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nPlazo]  DEFAULT ((0)) FOR [nPlazo]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_iRut]  DEFAULT ((0)) FOR [iRut]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_iCodigo]  DEFAULT ((0)) FOR [iCodigo]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nMontoLimite]  DEFAULT ((0.0)) FOR [nMontoLimite]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_sTrader]  DEFAULT ('') FOR [sTrader]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_sAprobador]  DEFAULT ('') FOR [sAprobador]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_iEstadoIdd]  DEFAULT ('P') FOR [iEstadoIdd]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_sEstadoCF]  DEFAULT ((0)) FOR [sEstadoCF]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_nNumeroIdd]  DEFAULT ((0)) FOR [nNumeroIdd]
GO
ALTER TABLE [dbo].[Transacciones_IDD] ADD  CONSTRAINT [df_TransaccionesIDD_sControlLinea]  DEFAULT ('N') FOR [sControlLinea]
GO

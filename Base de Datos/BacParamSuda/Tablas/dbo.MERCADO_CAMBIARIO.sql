USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MERCADO_CAMBIARIO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MERCADO_CAMBIARIO](
	[Fecha] [datetime] NOT NULL,
	[OperacionBac] [numeric](9, 0) NOT NULL,
	[TipoOperacion] [char](1) NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[CodCliente] [int] NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[MontoMx] [numeric](21, 4) NOT NULL,
	[MonedaCnv] [char](3) NOT NULL,
	[MontoMonedaCnv] [numeric](21, 4) NOT NULL,
	[TipoCambio] [numeric](21, 4) NOT NULL,
	[Paridad] [numeric](21, 4) NOT NULL,
	[MercadoCambiario] [int] NOT NULL,
	[FormaPago] [int] NOT NULL,
	[Estado] [char](1) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[FechaConfirmacion] [datetime] NOT NULL,
	[OperacionIBS] [numeric](9, 0) NOT NULL,
	[MontoMxLiquidado] [numeric](21, 4) NOT NULL,
	[MontoLiquidadoEqu] [numeric](21, 4) NOT NULL,
	[MercadoOperacion] [char](4) NOT NULL,
 CONSTRAINT [Pk_Mercado_Cambiario] PRIMARY KEY NONCLUSTERED 
(
	[Fecha] ASC,
	[OperacionBac] ASC,
	[Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_OperacionBac]  DEFAULT (0) FOR [OperacionBac]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_TipoOperacion]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_RutCliente]  DEFAULT (0) FOR [RutCliente]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_CodCliente]  DEFAULT (0) FOR [CodCliente]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Moneda]  DEFAULT ('') FOR [Moneda]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MontoMx]  DEFAULT (0.0) FOR [MontoMx]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MonedaCnv]  DEFAULT ('') FOR [MonedaCnv]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MontoMonedaCnv]  DEFAULT (0.0) FOR [MontoMonedaCnv]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_TipoCambio]  DEFAULT (0.0) FOR [TipoCambio]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Paridad]  DEFAULT (0.0) FOR [Paridad]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MercadoCambiario]  DEFAULT (0) FOR [MercadoCambiario]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_FormaPago]  DEFAULT (0) FOR [FormaPago]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Estado]  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_Confirmacion]  DEFAULT ('') FOR [FechaConfirmacion]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_OperacionIBS]  DEFAULT ('') FOR [OperacionIBS]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MontoMxLiquidado]  DEFAULT (0.0) FOR [MontoMxLiquidado]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MontoLiquidadoEqu]  DEFAULT (0.0) FOR [MontoLiquidadoEqu]
GO
ALTER TABLE [dbo].[MERCADO_CAMBIARIO] ADD  CONSTRAINT [df_MercCamb_MercadoOperacion]  DEFAULT ('') FOR [MercadoOperacion]
GO

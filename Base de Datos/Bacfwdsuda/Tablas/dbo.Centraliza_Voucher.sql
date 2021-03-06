USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[Centraliza_Voucher]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Centraliza_Voucher](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Correlativo] [numeric](5, 0) NULL,
	[Cuenta] [char](20) NULL,
	[Glosa] [char](70) NULL,
	[Moneda_perfil] [numeric](3, 0) NULL,
	[Folio_Perfil] [numeric](5, 0) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [numeric](22, 4) NULL,
	[Moneda] [numeric](3, 0) NULL,
	[Operacion] [numeric](10, 0) NULL,
	[Nombre] [char](60) NULL,
	[Rut] [numeric](9, 0) NULL,
	[Digito] [char](1) NULL,
	[ObsDia] [numeric](12, 4) NULL,
	[UFDia] [numeric](12, 4) NULL,
	[Nombre_Cliente] [char](60) NULL,
	[Direccion_Cliente] [char](60) NULL,
	[Rut_Cliente] [numeric](9, 0) NULL,
	[Digito_Cliente] [char](1) NULL,
	[Fecha_Proceso] [char](10) NULL,
	[Glosa_Cuenta] [char](60) NULL,
	[Codigo_producto] [numeric](2, 0) NULL,
	[Tipo_Mov] [char](5) NULL,
	[Fecha_Inicio] [char](10) NULL,
	[Fecha_Vcto] [char](10) NULL,
	[OP] [char](2) NULL,
	[T] [char](1) NULL,
	[MonSuper] [numeric](3, 0) NULL,
	[fechacontable] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Numer__26BEAA4F]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Corre__27B2CE88]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Cuent__28A6F2C1]  DEFAULT ('') FOR [Cuenta]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Glosa__299B16FA]  DEFAULT ('') FOR [Glosa]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Moned__2A8F3B33]  DEFAULT (0) FOR [Moneda_perfil]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Folio__2B835F6C]  DEFAULT (0) FOR [Folio_Perfil]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Tipo___2C7783A5]  DEFAULT ('') FOR [Tipo_Monto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Monto__2D6BA7DE]  DEFAULT (0) FOR [Monto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Moned__2E5FCC17]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Opera__2F53F050]  DEFAULT (0) FOR [Operacion]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Nombr__30481489]  DEFAULT ('') FOR [Nombre]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza___Rut__313C38C2]  DEFAULT (0) FOR [Rut]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Digit__32305CFB]  DEFAULT ('') FOR [Digito]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__ObsDi__33248134]  DEFAULT (0) FOR [ObsDia]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__UFDia__3418A56D]  DEFAULT (0) FOR [UFDia]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Nombr__350CC9A6]  DEFAULT ('') FOR [Nombre_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Direc__3600EDDF]  DEFAULT ('') FOR [Direccion_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Rut_C__36F51218]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Digit__37E93651]  DEFAULT ('') FOR [Digito_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__38DD5A8A]  DEFAULT ('') FOR [Fecha_Proceso]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Glosa__39D17EC3]  DEFAULT ('') FOR [Glosa_Cuenta]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Codig__3AC5A2FC]  DEFAULT (0) FOR [Codigo_producto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Tipo___3BB9C735]  DEFAULT ('') FOR [Tipo_Mov]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__3CADEB6E]  DEFAULT ('') FOR [Fecha_Inicio]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__3DA20FA7]  DEFAULT ('') FOR [Fecha_Vcto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza_V__OP__3E9633E0]  DEFAULT ('') FOR [OP]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza_Vo__T__3F8A5819]  DEFAULT ('') FOR [T]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__MonSu__407E7C52]  DEFAULT (0) FOR [MonSuper]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF_Centraliza_Voucher_fechacontable]  DEFAULT ('') FOR [fechacontable]
GO

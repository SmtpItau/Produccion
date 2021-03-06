USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[Centraliza_Voucher]    Script Date: 13-05-2022 11:14:36 ******/
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
	[Monto] [numeric](21, 4) NULL,
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
	[FechaContable] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Numer__0B92856B]  DEFAULT (0) FOR [Numero_Voucher]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Corre__0C86A9A4]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Cuent__0D7ACDDD]  DEFAULT ('') FOR [Cuenta]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Glosa__0E6EF216]  DEFAULT ('') FOR [Glosa]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Moned__0F63164F]  DEFAULT (0) FOR [Moneda_perfil]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Folio__10573A88]  DEFAULT (0) FOR [Folio_Perfil]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Tipo___114B5EC1]  DEFAULT ('') FOR [Tipo_Monto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Monto__123F82FA]  DEFAULT (0) FOR [Monto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Moned__1333A733]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Opera__1427CB6C]  DEFAULT (0) FOR [Operacion]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Nombr__151BEFA5]  DEFAULT ('') FOR [Nombre]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza___Rut__161013DE]  DEFAULT (0) FOR [Rut]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Digit__17043817]  DEFAULT ('') FOR [Digito]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__ObsDi__17F85C50]  DEFAULT (0) FOR [ObsDia]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__UFDia__18EC8089]  DEFAULT (0) FOR [UFDia]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Nombr__19E0A4C2]  DEFAULT ('') FOR [Nombre_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Direc__1AD4C8FB]  DEFAULT ('') FOR [Direccion_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Rut_C__1BC8ED34]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Digit__1CBD116D]  DEFAULT ('') FOR [Digito_Cliente]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__1DB135A6]  DEFAULT ('') FOR [Fecha_Proceso]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Glosa__1EA559DF]  DEFAULT ('') FOR [Glosa_Cuenta]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Codig__1F997E18]  DEFAULT (0) FOR [Codigo_producto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Tipo___208DA251]  DEFAULT ('') FOR [Tipo_Mov]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__2181C68A]  DEFAULT ('') FOR [Fecha_Inicio]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__2275EAC3]  DEFAULT ('') FOR [Fecha_Vcto]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza_V__OP__236A0EFC]  DEFAULT ('') FOR [OP]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliza_Vo__T__245E3335]  DEFAULT ('') FOR [T]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__MonSu__2552576E]  DEFAULT (0) FOR [MonSuper]
GO
ALTER TABLE [dbo].[Centraliza_Voucher] ADD  CONSTRAINT [DF__Centraliz__Fecha__26467BA7]  DEFAULT ('') FOR [FechaContable]
GO

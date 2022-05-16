USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDDI]    Script Date: 13-05-2022 12:16:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDDI](
	[dirutcart] [numeric](9, 0) NULL,
	[ditipcart] [numeric](5, 0) NULL,
	[dinumdocu] [numeric](10, 0) NULL,
	[dicorrela] [numeric](3, 0) NULL,
	[dinumdocuo] [numeric](10, 0) NULL,
	[dicorrelao] [numeric](3, 0) NULL,
	[ditipoper] [char](3) NULL,
	[diserie] [char](12) NULL,
	[diinstser] [char](12) NULL,
	[digenemi] [char](10) NULL,
	[dinemmon] [char](5) NULL,
	[dinominal] [numeric](19, 4) NULL,
	[ditircomp] [numeric](19, 4) NULL,
	[dipvpcomp] [numeric](19, 4) NOT NULL,
	[divptirc] [numeric](19, 4) NULL,
	[dipvpmcd] [numeric](19, 2) NULL,
	[ditirmcd] [numeric](19, 4) NULL,
	[divpmcd100] [float] NULL,
	[divpmcd] [numeric](19, 4) NULL,
	[divptirci] [numeric](19, 4) NULL,
	[difecsal] [datetime] NULL,
	[dinumucup] [numeric](3, 0) NULL,
	[dicapitalc] [numeric](19, 4) NULL,
	[diinteresc] [numeric](19, 4) NULL,
	[direajustc] [numeric](19, 4) NULL,
	[dicapitaci] [numeric](19, 4) NULL,
	[diintereci] [numeric](19, 4) NULL,
	[direajusci] [numeric](19, 4) NULL,
	[dicontador] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[dibase] [int] NULL,
	[dimoneda] [numeric](3, 0) NULL,
	[diintermes] [numeric](19, 4) NULL,
	[direajumes] [numeric](19, 4) NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](5) NULL,
	[Mercado] [char](1) NOT NULL,
	[Sucursal] [varchar](5) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Fecha_PagoMañana] [datetime] NOT NULL,
	[Laminas] [char](1) NOT NULL,
	[Tipo_Inversion] [char](1) NOT NULL,
	[Estado_Operacion_Linea] [char](1) NOT NULL,
	[ditcinicio] [numeric](19, 4) NULL,
	[id_libro] [char](6) NULL,
	[Tasa_Contrato] [numeric](8, 6) NOT NULL,
	[Valor_Contable] [numeric](19, 4) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](1) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[disenala] [numeric](18, 0) NOT NULL,
	[dinomigarantia] [numeric](19, 4) NOT NULL,
	[diTasCFdo] [numeric](9, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__codigo_car__21DAC4F8]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Tipo_Carte__2E14E7FD]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Mercado__2F090C36]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Sucursal__2FFD306F]  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Id_Sistema__30F154A8]  DEFAULT (' ') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Fecha_Pago__31E578E1]  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Laminas__32D99D1A]  DEFAULT (' ') FOR [Laminas]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Tipo_Inver__33CDC153]  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[MDDI] ADD  CONSTRAINT [DF__MDDI__Estado_Ope__34C1E58C]  DEFAULT (' ') FOR [Estado_Operacion_Linea]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT (0) FOR [ditcinicio]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ('') FOR [id_libro]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [disenala]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [dinomigarantia]
GO
ALTER TABLE [dbo].[MDDI] ADD  DEFAULT ((0)) FOR [diTasCFdo]
GO

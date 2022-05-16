USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDDI0713]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDDI0713](
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
	[dipvpcomp] [numeric](19, 2) NULL,
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

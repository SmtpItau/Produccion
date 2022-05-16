USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCP1226]    Script Date: 13-05-2022 12:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCP1226](
	[cprutcart] [numeric](9, 0) NOT NULL,
	[cptipcart] [numeric](5, 0) NOT NULL,
	[cpnumdocu] [numeric](10, 0) NOT NULL,
	[cpcorrela] [numeric](3, 0) NOT NULL,
	[cpnumdocuo] [numeric](10, 0) NOT NULL,
	[cpcorrelao] [numeric](3, 0) NOT NULL,
	[cprutcli] [numeric](9, 0) NOT NULL,
	[cpcodcli] [numeric](9, 0) NOT NULL,
	[cpinstser] [char](12) NOT NULL,
	[cpmascara] [char](12) NOT NULL,
	[cpnominal] [numeric](19, 4) NOT NULL,
	[cpfeccomp] [datetime] NOT NULL,
	[cpvalcomp] [numeric](19, 4) NOT NULL,
	[cpvalcomu] [float] NOT NULL,
	[cpvcum100] [float] NOT NULL,
	[cptircomp] [numeric](19, 4) NOT NULL,
	[cptasest] [numeric](9, 4) NOT NULL,
	[cppvpcomp] [numeric](19, 4) NOT NULL,
	[cpvpcomp] [numeric](19, 8) NOT NULL,
	[cpnumucup] [numeric](3, 0) NOT NULL,
	[cpfecemi] [datetime] NOT NULL,
	[cpfecven] [datetime] NOT NULL,
	[cpseriado] [char](1) NOT NULL,
	[cpcodigo] [numeric](5, 0) NOT NULL,
	[cpvptirc] [numeric](19, 4) NOT NULL,
	[cpcapitalc] [numeric](19, 4) NOT NULL,
	[cpinteresc] [numeric](19, 4) NOT NULL,
	[cpreajustc] [numeric](19, 4) NOT NULL,
	[cpcontador] [numeric](19, 0) NOT NULL,
	[cpfecucup] [datetime] NOT NULL,
	[cpfecpcup] [datetime] NOT NULL,
	[cpvcompori] [numeric](19, 4) NOT NULL,
	[cpdcv] [char](1) NOT NULL,
	[cpdurat] [float] NOT NULL,
	[cpdurmod] [float] NOT NULL,
	[cpconvex] [float] NOT NULL,
	[cpintermes] [numeric](19, 4) NOT NULL,
	[cpreajumes] [numeric](19, 4) NOT NULL,
	[fecha_compra_original] [datetime] NOT NULL,
	[valor_compra_original] [numeric](19, 4) NULL,
	[valor_compra_um_original] [float] NOT NULL,
	[tir_compra_original] [numeric](19, 4) NOT NULL,
	[valor_par_compra_original] [numeric](19, 6) NOT NULL,
	[porcentaje_valor_par_compra_original] [numeric](8, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](5) NULL,
	[Mercado] [char](1) NOT NULL,
	[Sucursal] [varchar](5) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Fecha_PagoMañana] [datetime] NOT NULL,
	[Laminas] [char](1) NOT NULL,
	[Tipo_Inversion] [char](1) NOT NULL,
	[Estado_Operacion_Linea] [char](1) NOT NULL,
	[cptipoletra] [char](1) NOT NULL,
	[cpforpagi] [numeric](4, 0) NOT NULL,
	[cpreserva_tecnica] [char](1) NULL,
	[cpvalvenc] [numeric](19, 4) NULL,
	[cpvaltasemi] [numeric](19, 4) NOT NULL,
	[cpprimadesc] [numeric](19, 4) NOT NULL,
	[cpprimdescacum] [numeric](19, 4) NOT NULL,
	[id_libro] [char](6) NULL,
	[Tasa_Contrato] [numeric](8, 6) NOT NULL,
	[Valor_Contable] [numeric](19, 4) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[cpsenala] [numeric](18, 0) NOT NULL,
	[cpvptasemi] [numeric](19, 0) NOT NULL,
	[Valor_a_Diferir] [numeric](19, 0) NOT NULL,
	[Capital_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Intereses_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Reajustes_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[volcker_rule] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO

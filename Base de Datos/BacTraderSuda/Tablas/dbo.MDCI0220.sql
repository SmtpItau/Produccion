USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCI0220]    Script Date: 13-05-2022 12:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCI0220](
	[cirutcart] [numeric](9, 0) NOT NULL,
	[citipcart] [numeric](5, 0) NOT NULL,
	[cinumdocu] [numeric](10, 0) NOT NULL,
	[cicorrela] [numeric](3, 0) NOT NULL,
	[cinumdocuo] [numeric](10, 0) NOT NULL,
	[cicorrelao] [numeric](3, 0) NOT NULL,
	[cirutcli] [numeric](9, 0) NOT NULL,
	[cicodcli] [numeric](9, 0) NOT NULL,
	[ciinstser] [char](12) NOT NULL,
	[cimascara] [char](12) NOT NULL,
	[cinominal] [numeric](19, 4) NOT NULL,
	[cifeccomp] [datetime] NOT NULL,
	[civalcomp] [numeric](19, 4) NOT NULL,
	[civalcomu] [float] NOT NULL,
	[civcum100] [float] NOT NULL,
	[citircomp] [numeric](19, 4) NOT NULL,
	[citasest] [numeric](19, 4) NOT NULL,
	[cipvpcomp] [numeric](19, 4) NOT NULL,
	[civpcomp] [numeric](19, 8) NOT NULL,
	[cifecemi] [datetime] NOT NULL,
	[cifecven] [datetime] NOT NULL,
	[ciseriado] [char](1) NOT NULL,
	[cicodigo] [numeric](5, 0) NOT NULL,
	[cifecinip] [datetime] NOT NULL,
	[cifecvenp] [datetime] NOT NULL,
	[civalinip] [numeric](19, 4) NOT NULL,
	[civalvenp] [numeric](19, 4) NOT NULL,
	[citaspact] [numeric](19, 4) NOT NULL,
	[cibaspact] [numeric](3, 0) NOT NULL,
	[cimonpact] [numeric](3, 0) NOT NULL,
	[civptirc] [numeric](19, 4) NOT NULL,
	[cicapitalc] [numeric](19, 4) NOT NULL,
	[ciinteresc] [numeric](19, 4) NOT NULL,
	[cireajustc] [numeric](19, 4) NOT NULL,
	[ciintermes] [numeric](19, 4) NOT NULL,
	[cireajumes] [numeric](19, 4) NOT NULL,
	[cicapitalci] [numeric](19, 4) NOT NULL,
	[ciinteresci] [numeric](19, 4) NOT NULL,
	[cireajustci] [numeric](19, 4) NOT NULL,
	[civptirci] [numeric](19, 4) NOT NULL,
	[cinumucup] [numeric](3, 0) NOT NULL,
	[cirutemi] [numeric](9, 0) NOT NULL,
	[cimonemi] [numeric](3, 0) NOT NULL,
	[cicontador] [numeric](19, 0) NOT NULL,
	[cifecucup] [datetime] NOT NULL,
	[cinominalp] [numeric](19, 4) NOT NULL,
	[ciforpagi] [numeric](4, 0) NOT NULL,
	[ciforpagv] [numeric](4, 0) NOT NULL,
	[cifecpcup] [datetime] NOT NULL,
	[cidcv] [char](1) NOT NULL,
	[cidurat] [float] NOT NULL,
	[cidurmod] [float] NOT NULL,
	[ciconvex] [float] NOT NULL,
	[fecha_compra_original] [datetime] NOT NULL,
	[valor_compra_original] [numeric](19, 0) NOT NULL,
	[valor_compra_um_original] [float] NOT NULL,
	[tir_compra_original] [numeric](8, 4) NOT NULL,
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
	[Cuenta_Corriente_Inicio] [char](15) NOT NULL,
	[Cuenta_Corriente_Final] [char](15) NOT NULL,
	[Sucursal_Inicio] [varchar](5) NOT NULL,
	[Sucursal_Final] [varchar](5) NOT NULL,
	[Estado_Operacion_Linea] [char](1) NOT NULL,
	[cireserva_tecnica] [char](1) NULL,
	[civalvenc] [numeric](19, 4) NULL,
	[citcinicio] [numeric](19, 4) NULL,
	[id_libro] [char](6) NULL,
	[Tasa_Contrato] [numeric](8, 6) NOT NULL,
	[Valor_Contable] [numeric](19, 2) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[cigarantia] [char](1) NOT NULL,
	[ciind1446] [char](1) NOT NULL,
	[ciTasCFdo] [numeric](9, 4) NOT NULL
) ON [PRIMARY]
GO

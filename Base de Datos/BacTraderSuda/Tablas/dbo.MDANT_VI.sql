USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDANT_VI]    Script Date: 13-05-2022 12:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDANT_VI](
	[virutcart] [numeric](9, 0) NULL,
	[vinumdocu] [numeric](10, 0) NULL,
	[vicorrela] [numeric](3, 0) NULL,
	[vinumoper] [numeric](10, 0) NULL,
	[vitipoper] [char](3) NULL,
	[virutcli] [numeric](9, 0) NULL,
	[vicodcli] [numeric](9, 0) NULL,
	[viinstser] [char](12) NULL,
	[vinominal] [numeric](19, 4) NULL,
	[vifecinip] [datetime] NULL,
	[vifecvenp] [datetime] NULL,
	[vivalinip] [numeric](19, 4) NULL,
	[vivalvenp] [numeric](19, 4) NULL,
	[vitaspact] [numeric](9, 4) NULL,
	[vibaspact] [numeric](3, 0) NULL,
	[vimonpact] [numeric](3, 0) NULL,
	[vivptirc] [numeric](19, 4) NULL,
	[vivptirci] [numeric](19, 4) NULL,
	[vivptirv] [numeric](19, 4) NULL,
	[vivptirvi] [numeric](19, 4) NULL,
	[vivalcomu] [numeric](19, 4) NULL,
	[vivalcomp] [numeric](19, 4) NULL,
	[vicapitalv] [numeric](19, 4) NULL,
	[viinteresv] [numeric](19, 4) NULL,
	[vireajustv] [numeric](19, 4) NULL,
	[viintermesv] [numeric](19, 4) NULL,
	[vireajumesv] [numeric](19, 4) NULL,
	[vicapitalvi] [numeric](19, 4) NULL,
	[viinteresvi] [numeric](19, 4) NULL,
	[vireajustvi] [numeric](19, 4) NULL,
	[viintermesvi] [numeric](19, 4) NULL,
	[vireajumesvi] [numeric](19, 4) NULL,
	[vivalvent] [numeric](19, 4) NULL,
	[vivvum100] [float] NULL,
	[vivalvemu] [float] NULL,
	[vitirvent] [numeric](9, 4) NULL,
	[vitasest] [numeric](9, 4) NULL,
	[vipvpvent] [numeric](19, 4) NULL,
	[vivpvent] [numeric](19, 4) NULL,
	[vinumucupc] [numeric](3, 0) NULL,
	[vinumucupv] [numeric](3, 0) NULL,
	[virutemi] [numeric](9, 0) NULL,
	[vimonemi] [numeric](3, 0) NULL,
	[vifecemi] [datetime] NULL,
	[vifecven] [datetime] NULL,
	[vifecucup] [datetime] NULL,
	[vicodigo] [numeric](3, 0) NULL,
	[vitircomp] [numeric](8, 4) NULL,
	[vifeccomp] [datetime] NULL,
	[viseriado] [char](1) NULL,
	[vimascara] [char](12) NULL,
	[vivalinipci] [numeric](19, 4) NULL,
	[vivalvenpci] [numeric](19, 4) NULL,
	[vifecinipci] [datetime] NULL,
	[vifecvenpci] [datetime] NULL,
	[vitaspactci] [numeric](8, 4) NULL,
	[vibaspactci] [int] NULL,
	[viinteresci] [numeric](19, 4) NULL,
	[vicorvent] [int] NULL,
	[vinominalp] [numeric](19, 0) NULL,
	[viforpagi] [numeric](5, 0) NULL,
	[viforpagv] [numeric](5, 0) NULL,
	[vicorrvent] [numeric](3, 0) NULL,
	[vifecpcup] [datetime] NULL,
	[vivcompori] [numeric](19, 4) NULL,
	[vivpcomp] [numeric](19, 8) NULL,
	[vidurat] [float] NULL,
	[vidurmod] [float] NULL,
	[viconvex] [float] NULL,
	[viintacumcp] [numeric](19, 4) NULL,
	[vireacumcp] [numeric](19, 4) NULL,
	[viintacumvi] [numeric](19, 4) NULL,
	[vireacumvi] [numeric](19, 4) NULL,
	[viintacumci] [numeric](19, 4) NULL,
	[vireacumci] [numeric](19, 4) NULL,
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
	[vivalvenc] [numeric](19, 4) NULL,
	[vitcinicio] [numeric](19, 4) NULL,
	[id_libro] [char](6) NULL,
	[Tasa_Contrato] [numeric](8, 6) NOT NULL,
	[Valor_Contable] [numeric](19, 2) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[vivptasemi] [numeric](19, 0) NOT NULL,
	[vimtoadif] [numeric](19, 0) NOT NULL,
	[Capital_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Intereses_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Reajustes_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[viTasCFdo] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [vivptasemi]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [vimtoadif]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Capital_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Intereses_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [Reajustes_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDANT_VI] ADD  DEFAULT ((0)) FOR [viTasCFdo]
GO

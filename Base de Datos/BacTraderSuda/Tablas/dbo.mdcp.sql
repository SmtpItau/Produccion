USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdcp]    Script Date: 13-05-2022 12:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdcp](
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
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cprutcart__65EBFF70]  DEFAULT (0) FOR [cprutcart]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cptipcart__66E023A9]  DEFAULT (0) FOR [cptipcart]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpnumdocu__67D447E2]  DEFAULT (0) FOR [cpnumdocu]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcorrela__68C86C1B]  DEFAULT (0) FOR [cpcorrela]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpnumdocuo__69BC9054]  DEFAULT (0) FOR [cpnumdocuo]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcorrelao__6AB0B48D]  DEFAULT (0) FOR [cpcorrelao]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cprutcli__6BA4D8C6]  DEFAULT (0) FOR [cprutcli]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcodcli__6C98FCFF]  DEFAULT (0) FOR [cpcodcli]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpinstser__6D8D2138]  DEFAULT (' ') FOR [cpinstser]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpmascara__6E814571]  DEFAULT (' ') FOR [cpmascara]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpnominal__6F7569AA]  DEFAULT (0) FOR [cpnominal]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpfeccomp__70698DE3]  DEFAULT (' ') FOR [cpfeccomp]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvalcomp__715DB21C]  DEFAULT (0) FOR [cpvalcomp]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvalcomu__7251D655]  DEFAULT (0) FOR [cpvalcomu]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvcum100__7345FA8E]  DEFAULT (0) FOR [cpvcum100]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cptircomp__743A1EC7]  DEFAULT (0) FOR [cptircomp]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cptasest__752E4300]  DEFAULT (0) FOR [cptasest]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cppvpcomp__76226739]  DEFAULT (0) FOR [cppvpcomp]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvpcomp__77168B72]  DEFAULT (0) FOR [cpvpcomp]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpnumucup__780AAFAB]  DEFAULT (0) FOR [cpnumucup]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpfecemi__78FED3E4]  DEFAULT (' ') FOR [cpfecemi]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpfecven__79F2F81D]  DEFAULT (' ') FOR [cpfecven]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpseriado__7AE71C56]  DEFAULT (' ') FOR [cpseriado]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcodigo__7BDB408F]  DEFAULT (0) FOR [cpcodigo]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvptirc__7CCF64C8]  DEFAULT (0) FOR [cpvptirc]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcapitalc__7DC38901]  DEFAULT (0) FOR [cpcapitalc]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpinteresc__7EB7AD3A]  DEFAULT (0) FOR [cpinteresc]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpreajustc__7FABD173]  DEFAULT (0) FOR [cpreajustc]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpcontador__009FF5AC]  DEFAULT (0) FOR [cpcontador]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpfecucup__019419E5]  DEFAULT (' ') FOR [cpfecucup]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpfecpcup__02883E1E]  DEFAULT (' ') FOR [cpfecpcup]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpvcompori__037C6257]  DEFAULT (0) FOR [cpvcompori]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpdcv__04708690]  DEFAULT (' ') FOR [cpdcv]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpdurat__0564AAC9]  DEFAULT (0) FOR [cpdurat]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpdurmod__0658CF02]  DEFAULT (0) FOR [cpdurmod]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpconvex__074CF33B]  DEFAULT (0) FOR [cpconvex]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpintermes__61A8CF45]  DEFAULT (0) FOR [cpintermes]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpreajumes__629CF37E]  DEFAULT (0) FOR [cpreajumes]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__fecha_comp__53C72647]  DEFAULT ('') FOR [fecha_compra_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__valor_comp__54BB4A80]  DEFAULT (0) FOR [valor_compra_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__valor_comp__55AF6EB9]  DEFAULT (53) FOR [valor_compra_um_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__tir_compra__56A392F2]  DEFAULT (0) FOR [tir_compra_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__valor_par___5797B72B]  DEFAULT (0) FOR [valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__porcentaje__588BDB64]  DEFAULT (0) FOR [porcentaje_valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__MDCP__codigo_car__597FFF9D]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Tipo_Carte__61948C03]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Mercado__6288B03C]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Sucursal__637CD475]  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Id_Sistema__6470F8AE]  DEFAULT (' ') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Fecha_Pago__65651CE7]  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Laminas__66594120]  DEFAULT (' ') FOR [Laminas]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Tipo_Inver__674D6559]  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__Estado_Ope__68418992]  DEFAULT (' ') FOR [Estado_Operacion_Linea]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF_mdcp_cptipoletra]  DEFAULT ('') FOR [cptipoletra]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF__mdcp__cpforpagi__5FD72C1A]  DEFAULT (0) FOR [cpforpagi]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF_mdcp_cpnominal1]  DEFAULT (' ') FOR [cpreserva_tecnica]
GO
ALTER TABLE [dbo].[mdcp] ADD  CONSTRAINT [DF_mdcp_cpvalvenc]  DEFAULT (0) FOR [cpvalvenc]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT (0) FOR [cpvaltasemi]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT (0) FOR [cpprimadesc]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT (0) FOR [cpprimdescacum]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ('') FOR [id_libro]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [cpsenala]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [cpvptasemi]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Valor_a_Diferir]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Capital_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Intereses_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [Reajustes_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdcp] ADD  DEFAULT ((0)) FOR [volcker_rule]
GO

USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCI]    Script Date: 13-05-2022 12:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCI](
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
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cirutcart__2DA7A64D]  DEFAULT (0) FOR [cirutcart]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__citipcart__2E9BCA86]  DEFAULT (0) FOR [citipcart]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cinumdocu__2F8FEEBF]  DEFAULT (0) FOR [cinumdocu]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicorrela__308412F8]  DEFAULT (0) FOR [cicorrela]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cinumdocuo__31783731]  DEFAULT (0) FOR [cinumdocuo]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicorrelao__326C5B6A]  DEFAULT (0) FOR [cicorrelao]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cirutcli__33607FA3]  DEFAULT (0) FOR [cirutcli]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicodcli__3454A3DC]  DEFAULT (0) FOR [cicodcli]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciinstser__3548C815]  DEFAULT (' ') FOR [ciinstser]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cimascara__363CEC4E]  DEFAULT (' ') FOR [cimascara]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cinominal__37311087]  DEFAULT (0) FOR [cinominal]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifeccomp__382534C0]  DEFAULT (' ') FOR [cifeccomp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civalcomp__391958F9]  DEFAULT (0) FOR [civalcomp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civalcomu__3A0D7D32]  DEFAULT (0) FOR [civalcomu]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civcum100__3B01A16B]  DEFAULT (0) FOR [civcum100]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__citircomp__3BF5C5A4]  DEFAULT (0) FOR [citircomp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__citasest__3CE9E9DD]  DEFAULT (0) FOR [citasest]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cipvpcomp__3DDE0E16]  DEFAULT (0) FOR [cipvpcomp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civpcomp__3ED2324F]  DEFAULT (0) FOR [civpcomp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecemi__3FC65688]  DEFAULT (' ') FOR [cifecemi]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecven__40BA7AC1]  DEFAULT (' ') FOR [cifecven]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciseriado__41AE9EFA]  DEFAULT (' ') FOR [ciseriado]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicodigo__42A2C333]  DEFAULT (0) FOR [cicodigo]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecinip__4396E76C]  DEFAULT (' ') FOR [cifecinip]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecvenp__448B0BA5]  DEFAULT (' ') FOR [cifecvenp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civalinip__457F2FDE]  DEFAULT (0) FOR [civalinip]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civalvenp__46735417]  DEFAULT (0) FOR [civalvenp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__citaspact__47677850]  DEFAULT (0) FOR [citaspact]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cibaspact__485B9C89]  DEFAULT (0) FOR [cibaspact]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cimonpact__494FC0C2]  DEFAULT (0) FOR [cimonpact]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civptirc__4A43E4FB]  DEFAULT (0) FOR [civptirc]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicapitalc__4B380934]  DEFAULT (0) FOR [cicapitalc]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciinteresc__4C2C2D6D]  DEFAULT (0) FOR [ciinteresc]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cireajustc__4D2051A6]  DEFAULT (0) FOR [cireajustc]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciintermes__4C2C2D6D]  DEFAULT (0) FOR [ciintermes]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cireajumes__4D2051A6]  DEFAULT (0) FOR [cireajumes]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicapitalc__4E1475DF]  DEFAULT (0) FOR [cicapitalci]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciinteresc__4F089A18]  DEFAULT (0) FOR [ciinteresci]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cireajustc__4FFCBE51]  DEFAULT (0) FOR [cireajustci]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__civptirci__50F0E28A]  DEFAULT (0) FOR [civptirci]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cinumucup__51E506C3]  DEFAULT (0) FOR [cinumucup]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cirutemi__52D92AFC]  DEFAULT (0) FOR [cirutemi]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cimonemi__53CD4F35]  DEFAULT (0) FOR [cimonemi]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cicontador__54C1736E]  DEFAULT (0) FOR [cicontador]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecucup__55B597A7]  DEFAULT (' ') FOR [cifecucup]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cinominalp__56A9BBE0]  DEFAULT (0) FOR [cinominalp]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciforpagi__579DE019]  DEFAULT (0) FOR [ciforpagi]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciforpagv__58920452]  DEFAULT (0) FOR [ciforpagv]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cifecpcup__5986288B]  DEFAULT (' ') FOR [cifecpcup]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cidcv__38CF4036]  DEFAULT ('P') FOR [cidcv]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cidurat__39C3646F]  DEFAULT (0) FOR [cidurat]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__cidurmod__3AB788A8]  DEFAULT (0) FOR [cidurmod]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__ciconvex__3BABACE1]  DEFAULT (0) FOR [ciconvex]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__fecha_comp__01C2FB21]  DEFAULT ('') FOR [fecha_compra_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__valor_comp__02B71F5A]  DEFAULT (0) FOR [valor_compra_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__valor_comp__03AB4393]  DEFAULT (53) FOR [valor_compra_um_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__tir_compra__049F67CC]  DEFAULT (0) FOR [tir_compra_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__valor_par___05938C05]  DEFAULT (0) FOR [valor_par_compra_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__porcentaje__0687B03E]  DEFAULT (0) FOR [porcentaje_valor_par_compra_original]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__codigo_car__077BD477]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Tipo_Carte__23624F60]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Mercado__24567399]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Sucursal__254A97D2]  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Id_Sistema__263EBC0B]  DEFAULT (' ') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Fecha_Pago__2732E044]  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Laminas__2827047D]  DEFAULT (' ') FOR [Laminas]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Tipo_Inver__291B28B6]  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Cuenta_Cor__2A0F4CEF]  DEFAULT (' ') FOR [Cuenta_Corriente_Inicio]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Cuenta_Cor__2B037128]  DEFAULT (' ') FOR [Cuenta_Corriente_Final]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Sucursal_I__2BF79561]  DEFAULT (' ') FOR [Sucursal_Inicio]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Sucursal_F__2CEBB99A]  DEFAULT (' ') FOR [Sucursal_Final]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF__MDCI__Estado_Ope__2DDFDDD3]  DEFAULT (' ') FOR [Estado_Operacion_Linea]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF_MDCI_cpreserva_tecnica]  DEFAULT (' ') FOR [cireserva_tecnica]
GO
ALTER TABLE [dbo].[MDCI] ADD  CONSTRAINT [DF_MDCI_cinominal1]  DEFAULT (0) FOR [civalvenc]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT (0) FOR [citcinicio]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ('') FOR [id_libro]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT (' ') FOR [cigarantia]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT (' ') FOR [ciind1446]
GO
ALTER TABLE [dbo].[MDCI] ADD  DEFAULT ((0)) FOR [ciTasCFdo]
GO

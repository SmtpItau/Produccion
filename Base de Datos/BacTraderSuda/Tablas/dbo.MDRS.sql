USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDRS]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDRS](
	[rsfecha] [datetime] NOT NULL,
	[rsrutcart] [numeric](9, 0) NOT NULL,
	[rstipcart] [numeric](5, 0) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rscorrela] [numeric](3, 0) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsrutcli] [numeric](9, 0) NOT NULL,
	[rscodcli] [numeric](9, 0) NOT NULL,
	[rsvppresen] [numeric](19, 4) NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rscupamo] [numeric](19, 4) NOT NULL,
	[rscupint] [numeric](19, 4) NOT NULL,
	[rscuprea] [numeric](19, 4) NOT NULL,
	[rsflujo] [numeric](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsfecctb] [datetime] NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](9, 4) NOT NULL,
	[rstasfloat] [numeric](9, 4) NOT NULL,
	[rsmonpact] [numeric](3, 0) NOT NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rstasemi] [numeric](9, 4) NOT NULL,
	[rsbasemi] [numeric](3, 0) NOT NULL,
	[rscodigo] [numeric](3, 0) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsintermes] [numeric](19, 4) NOT NULL,
	[rsreajumes] [numeric](19, 4) NOT NULL,
	[rsreajuste_acum] [numeric](19, 4) NOT NULL,
	[rsinteres_acum] [numeric](19, 4) NOT NULL,
	[rsforpagv] [numeric](4, 0) NOT NULL,
	[rsvalcomp] [numeric](19, 4) NOT NULL,
	[rsvalcomu] [numeric](19, 4) NOT NULL,
	[rsvalvenc] [numeric](19, 4) NOT NULL,
	[rsdurat] [float] NOT NULL,
	[rsdurmod] [float] NOT NULL,
	[rsconvex] [float] NOT NULL,
	[rsnumucup] [int] NOT NULL,
	[rsnumpcup] [int] NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rstipopero] [char](3) NOT NULL,
	[rsfeccomp] [datetime] NOT NULL,
	[rsdifrea] [numeric](19, 4) NOT NULL,
	[rsinstcam] [char](10) NOT NULL,
	[rsfecinip] [datetime] NOT NULL,
	[rsfecvtop] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [numeric](9, 0) NOT NULL,
	[rsvalinip] [numeric](19, 4) NOT NULL,
	[rsvalvtop] [numeric](19, 4) NOT NULL,
	[rstaspact] [numeric](9, 4) NOT NULL,
	[rstipobono] [char](1) NULL,
	[rscondpacto] [char](3) NULL,
	[rsmascara] [char](12) NULL,
	[rsforpagi] [numeric](4, 0) NOT NULL,
	[rstipoletra] [char](1) NULL,
	[rsvalcompcp] [numeric](19, 4) NULL,
	[rsvalcomucp] [numeric](19, 4) NULL,
	[rsinterescp] [numeric](19, 4) NULL,
	[rsreajustecp] [numeric](19, 4) NULL,
	[rsinteres_acumcp] [numeric](19, 4) NULL,
	[rsreajuste_acumcp] [numeric](19, 4) NULL,
	[rsvppresenx_emis] [numeric](19, 4) NULL,
	[rsinteres_emis] [numeric](19, 4) NULL,
	[rsreajuste_emis] [numeric](19, 4) NULL,
	[rsinteres_acum_emis] [numeric](19, 4) NULL,
	[rsreajuste_acum_emis] [numeric](19, 4) NULL,
	[rsvalor_emis] [numeric](19, 4) NULL,
	[rsvpresen_emis] [numeric](19, 4) NULL,
	[rsvalorum_emis] [numeric](19, 4) NULL,
	[rsnominal_resi] [numeric](19, 4) NULL,
	[codigo_carterasuper] [char](1) NULL,
	[prima_descuento_dia] [numeric](19, 4) NOT NULL,
	[prima_descuento_total] [numeric](19, 4) NOT NULL,
	[valor_tasa_emision] [numeric](19, 4) NOT NULL,
	[valor_par] [numeric](19, 8) NOT NULL,
	[rsid_libro] [char](6) NULL,
	[Sucursal] [varchar](5) NOT NULL,
	[Fecha_PagoMañana] [datetime] NOT NULL,
	[Tipo_Inversion] [char](1) NOT NULL,
	[Tasa_Contrato] [numeric](9, 4) NOT NULL,
	[Valor_Contable] [numeric](19, 4) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[rsfechareal] [datetime] NOT NULL,
	[rsgarantia] [char](1) NOT NULL,
	[RsMtogarantia] [numeric](19, 0) NOT NULL,
	[RsVpTasEmiMan] [numeric](19, 0) NOT NULL,
	[RsVpTasEmiHoy] [numeric](19, 0) NOT NULL,
	[RsIntTasEmiDia] [numeric](19, 0) NOT NULL,
	[RsReaTasEmiDia] [numeric](19, 0) NOT NULL,
	[RsIntTasEmiAcu] [numeric](19, 0) NOT NULL,
	[RsReaTasEmiAcu] [numeric](19, 0) NOT NULL,
	[rsestado_mp] [char](1) NOT NULL,
	[rsmensaje_mp] [char](255) NOT NULL,
 CONSTRAINT [PK__MDRS__3D34CDF7] PRIMARY KEY CLUSTERED 
(
	[rsfecha] ASC,
	[rsrutcart] ASC,
	[rstipcart] ASC,
	[rsnumdocu] ASC,
	[rscorrela] ASC,
	[rsnumoper] ASC,
	[rscartera] ASC,
	[rstipoper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsrutcart__3BEBA403]  DEFAULT (0) FOR [rsrutcart]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstipcart__3CDFC83C]  DEFAULT (0) FOR [rstipcart]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsnumdocu__3DD3EC75]  DEFAULT (0) FOR [rsnumdocu]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscorrela__3EC810AE]  DEFAULT (0) FOR [rscorrela]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsnumoper__3FBC34E7]  DEFAULT (0) FOR [rsnumoper]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscartera__40B05920]  DEFAULT ('') FOR [rscartera]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstipoper__41A47D59]  DEFAULT ('') FOR [rstipoper]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsinstser__4298A192]  DEFAULT ('') FOR [rsinstser]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsrutcli__438CC5CB]  DEFAULT (0) FOR [rsrutcli]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscodcli__4480EA04]  DEFAULT (0) FOR [rscodcli]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvppresen__45750E3D]  DEFAULT (0) FOR [rsvppresen]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvppresen__46693276]  DEFAULT (0) FOR [rsvppresenx]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscupamo__475D56AF]  DEFAULT (0) FOR [rscupamo]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscupint__48517AE8]  DEFAULT (0) FOR [rscupint]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscuprea__49459F21]  DEFAULT (0) FOR [rscuprea]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsflujo__4A39C35A]  DEFAULT (0) FOR [rsflujo]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecprox__4B2DE793]  DEFAULT ('') FOR [rsfecprox]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecctb__4C220BCC]  DEFAULT ('') FOR [rsfecctb]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsnominal__4D163005]  DEFAULT (0) FOR [rsnominal]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstir__4E0A543E]  DEFAULT (0) FOR [rstir]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstasfloat__4EFE7877]  DEFAULT (0) FOR [rstasfloat]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsmonpact__4FF29CB0]  DEFAULT (0) FOR [rsmonpact]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsmonemi__50E6C0E9]  DEFAULT (0) FOR [rsmonemi]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstasemi__51DAE522]  DEFAULT (0) FOR [rstasemi]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsbasemi__52CF095B]  DEFAULT (0) FOR [rsbasemi]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscodigo__53C32D94]  DEFAULT (0) FOR [rscodigo]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsinteres__54B751CD]  DEFAULT (0) FOR [rsinteres]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsreajuste__55AB7606]  DEFAULT (0) FOR [rsreajuste]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsintermes__569F9A3F]  DEFAULT (0) FOR [rsintermes]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsreajumes__5793BE78]  DEFAULT (0) FOR [rsreajumes]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsreajuste__5887E2B1]  DEFAULT (0) FOR [rsreajuste_acum]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsinteres___597C06EA]  DEFAULT (0) FOR [rsinteres_acum]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsforpagv__5A702B23]  DEFAULT (0) FOR [rsforpagv]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalcomp__5B644F5C]  DEFAULT (0) FOR [rsvalcomp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalcomu__5C587395]  DEFAULT (0) FOR [rsvalcomu]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalvenc__5D4C97CE]  DEFAULT (0) FOR [rsvalvenc]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsdurat__5E40BC07]  DEFAULT (0) FOR [rsdurat]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsdurmod__5F34E040]  DEFAULT (0) FOR [rsdurmod]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsconvex__60290479]  DEFAULT (0) FOR [rsconvex]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsnumucup__611D28B2]  DEFAULT (0) FOR [rsnumucup]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsnumpcup__62114CEB]  DEFAULT (0) FOR [rsnumpcup]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecucup__63057124]  DEFAULT ('') FOR [rsfecucup]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecpcup__63F9955D]  DEFAULT ('') FOR [rsfecpcup]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvpcomp__64EDB996]  DEFAULT (0) FOR [rsvpcomp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstipopero__65E1DDCF]  DEFAULT ('') FOR [rstipopero]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfeccomp__66D60208]  DEFAULT ('') FOR [rsfeccomp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsdifrea__67CA2641]  DEFAULT (0) FOR [rsdifrea]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsinstcam__68BE4A7A]  DEFAULT ('') FOR [rsinstcam]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecinip__69B26EB3]  DEFAULT ('') FOR [rsfecinip]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecvtop__6AA692EC]  DEFAULT ('') FOR [rsfecvtop]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecemis__6B9AB725]  DEFAULT ('') FOR [rsfecemis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsfecvcto__6C8EDB5E]  DEFAULT ('') FOR [rsfecvcto]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsrutemis__6D82FF97]  DEFAULT (0) FOR [rsrutemis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalinip__6E7723D0]  DEFAULT (0) FOR [rsvalinip]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalvtop__6F6B4809]  DEFAULT (0) FOR [rsvalvtop]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstaspact__705F6C42]  DEFAULT (0) FOR [rstaspact]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rstipobono__46A169FC]  DEFAULT (' ') FOR [rstipobono]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rscondpact__47958E35]  DEFAULT (' ') FOR [rscondpacto]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsmascara__4889B26E]  DEFAULT (' ') FOR [rsmascara]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsforpagi]  DEFAULT (0) FOR [rsforpagi]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rstipoletra]  DEFAULT ('O') FOR [rstipoletra]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsvalcompcp]  DEFAULT (0) FOR [rsvalcompcp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsvalcomucp]  DEFAULT (0) FOR [rsvalcomucp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsinterescp]  DEFAULT (0) FOR [rsinterescp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsreajustecp]  DEFAULT (0) FOR [rsreajustecp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsinteres_acumcp]  DEFAULT (0) FOR [rsinteres_acumcp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsreajuste_acumcp]  DEFAULT (0) FOR [rsreajuste_acumcp]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsvppresenx_emis]  DEFAULT (0) FOR [rsvppresenx_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsinteres_emis]  DEFAULT (0) FOR [rsinteres_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsreajuste_emis]  DEFAULT (0) FOR [rsreajuste_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsinteres_acum_emis]  DEFAULT (0) FOR [rsinteres_acum_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsreajuste_acum_emis]  DEFAULT (0) FOR [rsreajuste_acum_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalor_em__16C904FF]  DEFAULT (0) FOR [rsvalor_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvpresen___17BD2938]  DEFAULT (0) FOR [rsvpresen_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__rsvalorum___1A9995E3]  DEFAULT (0) FOR [rsvalorum_emis]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF_MDRS_rsnominal_resi]  DEFAULT (0) FOR [rsnominal_resi]
GO
ALTER TABLE [dbo].[MDRS] ADD  CONSTRAINT [DF__mdrs__codigo_car__63D370DE]  DEFAULT ('P') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (0) FOR [prima_descuento_dia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (0) FOR [prima_descuento_total]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (0) FOR [valor_tasa_emision]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (0) FOR [valor_par]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ('') FOR [rsid_libro]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [rsfechareal]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [rsgarantia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsMtogarantia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsVpTasEmiMan]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsVpTasEmiHoy]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsIntTasEmiDia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsReaTasEmiDia]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsIntTasEmiAcu]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT ((0)) FOR [RsReaTasEmiAcu]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [rsestado_mp]
GO
ALTER TABLE [dbo].[MDRS] ADD  DEFAULT (' ') FOR [rsmensaje_mp]
GO

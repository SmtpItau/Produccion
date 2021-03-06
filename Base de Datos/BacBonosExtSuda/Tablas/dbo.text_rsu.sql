USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_rsu]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_rsu](
	[rsfecpro] [datetime] NOT NULL,
	[rsrutcart] [numeric](9, 0) NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rscorrelativo] [char](10) NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[cod_familia] [numeric](4, 0) NULL,
	[rstipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[rsrutcli] [numeric](9, 0) NOT NULL,
	[rscodcli] [numeric](9, 0) NOT NULL,
	[rsvppresen] [float] NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rscupamo] [numeric](19, 4) NOT NULL,
	[rscupint] [numeric](19, 4) NOT NULL,
	[rscuprea] [numeric](19, 4) NOT NULL,
	[rsflujo] [numeric](19, 4) NOT NULL,
	[rsfecprox] [datetime] NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](19, 7) NOT NULL,
	[rspvp] [numeric](19, 7) NOT NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rsmonpag] [numeric](3, 0) NOT NULL,
	[rstasemi] [numeric](19, 7) NOT NULL,
	[rsbasemi] [numeric](3, 0) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsreajuste_acum] [numeric](19, 4) NOT NULL,
	[rsinteres_acum] [numeric](19, 4) NOT NULL,
	[rsvalcomu] [float] NOT NULL,
	[rsvalvenc] [numeric](19, 4) NOT NULL,
	[rsnumucup] [numeric](3, 0) NOT NULL,
	[rsnumpcup] [numeric](3, 0) NOT NULL,
	[rsfecucup] [datetime] NOT NULL,
	[rsfecpcup] [datetime] NOT NULL,
	[rsfecpvencap] [datetime] NOT NULL,
	[rsvpcomp] [float] NOT NULL,
	[rsfecpago] [datetime] NOT NULL,
	[rsfeccomp] [datetime] NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[rsrutemis] [numeric](9, 0) NULL,
	[rscodemi] [numeric](1, 0) NULL,
	[rstirmerc] [numeric](19, 7) NOT NULL,
	[rspvpmerc] [numeric](19, 7) NOT NULL,
	[rsvalmerc] [numeric](19, 4) NOT NULL,
	[basilea] [numeric](1, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [numeric](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](2) NOT NULL,
	[sucursal] [smallint] NOT NULL,
	[calce] [char](1) NOT NULL,
	[rsint_compra] [numeric](19, 4) NOT NULL,
	[rsprincipal] [numeric](19, 4) NOT NULL,
	[operador_banco] [char](30) NOT NULL,
	[rsfecneg] [datetime] NOT NULL,
	[rsfecpag] [datetime] NOT NULL,
	[corr_cli_nombre] [char](50) NOT NULL,
	[corr_cli_cta] [char](30) NOT NULL,
	[corr_cli_aba] [char](9) NOT NULL,
	[corr_cli_pais] [char](15) NOT NULL,
	[corr_cli_ciud] [char](15) NOT NULL,
	[corr_cli_swift] [char](30) NOT NULL,
	[corr_cli_ref] [char](30) NOT NULL,
	[rspfectraspaso] [datetime] NOT NULL,
	[rsajuste_traspaso] [numeric](19, 4) NOT NULL,
	[sw_tir] [numeric](1, 0) NOT NULL,
	[sw_pvp] [numeric](1, 0) NOT NULL,
	[CapitalPeso] [numeric](24, 0) NOT NULL,
	[InteresPeso] [numeric](24, 0) NOT NULL,
	[ValorCuponPeso] [numeric](24, 0) NOT NULL,
	[InteresPesoAcum] [numeric](24, 0) NOT NULL,
	[PrincipalDia] [numeric](19, 4) NOT NULL,
	[ValorPresentePeso] [numeric](19, 0) NOT NULL,
	[PrincipalDiaPeso] [numeric](24, 0) NOT NULL,
	[rsDiferenciaMerc] [float] NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[RsId_Libro] [char](10) NULL,
	[PorcjeCob] [numeric](5, 2) NOT NULL,
	[RsTirMercParPrx] [numeric](19, 4) NOT NULL,
	[RsTirMercCLPParPrx] [numeric](19, 4) NOT NULL,
 CONSTRAINT [PK__text_rsu__1229A90A] PRIMARY KEY CLUSTERED 
(
	[rsfecpro] ASC,
	[rsrutcart] ASC,
	[rsnumdocu] ASC,
	[rsnumoper] ASC,
	[rscorrelativo] ASC,
	[rscartera] ASC,
	[rstipoper] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__4DD47EBD]  DEFAULT (' ') FOR [rsfecpro]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsrutc__4EC8A2F6]  DEFAULT ((0)) FOR [rsrutcart]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsnumd__4FBCC72F]  DEFAULT (' ') FOR [rsnumdocu]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF_text_rsu_rscorrelativo]  DEFAULT ((1)) FOR [rscorrelativo]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rscart__50B0EB68]  DEFAULT (' ') FOR [rscartera]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__cod_fa__51A50FA1]  DEFAULT ((0)) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__cod_ne__529933DA]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__id_ins__538D5813]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvppr__54817C4C]  DEFAULT ((0)) FOR [rsvppresen]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvppr__5575A085]  DEFAULT ((0)) FOR [rsvppresenx]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rscupa__5669C4BE]  DEFAULT ((0)) FOR [rscupamo]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rscupi__575DE8F7]  DEFAULT ((0)) FOR [rscupint]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rscupr__58520D30]  DEFAULT ((0)) FOR [rscuprea]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfluj__59463169]  DEFAULT ((0)) FOR [rsflujo]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__5A3A55A2]  DEFAULT (' ') FOR [rsfecprox]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsnomi__5B2E79DB]  DEFAULT ((0)) FOR [rsnominal]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rstir__5C229E14]  DEFAULT ((0)) FOR [rstir]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rspvp__5D16C24D]  DEFAULT ((0)) FOR [rspvp]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rstase__5E0AE686]  DEFAULT ((0)) FOR [rstasemi]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsbase__5EFF0ABF]  DEFAULT ((0)) FOR [rsbasemi]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsinte__5FF32EF8]  DEFAULT ((0)) FOR [rsinteres]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsreaj__60E75331]  DEFAULT ((0)) FOR [rsreajuste]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsreaj__61DB776A]  DEFAULT ((0)) FOR [rsreajuste_acum]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsinte__62CF9BA3]  DEFAULT ((0)) FOR [rsinteres_acum]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvalc__63C3BFDC]  DEFAULT ((0)) FOR [rsvalcomu]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvalv__64B7E415]  DEFAULT ((0)) FOR [rsvalvenc]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsnumu__65AC084E]  DEFAULT ((0)) FOR [rsnumucup]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsnump__66A02C87]  DEFAULT ((0)) FOR [rsnumpcup]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecu__679450C0]  DEFAULT (' ') FOR [rsfecucup]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__688874F9]  DEFAULT (' ') FOR [rsfecpcup]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__697C9932]  DEFAULT (' ') FOR [rsfecpvencap]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvpco__6A70BD6B]  DEFAULT ((0)) FOR [rsvpcomp]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__6B64E1A4]  DEFAULT (' ') FOR [rsfecpago]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecc__6C5905DD]  DEFAULT (' ') FOR [rsfeccomp]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfece__6D4D2A16]  DEFAULT (' ') FOR [rsfecemis]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecv__6E414E4F]  DEFAULT (' ') FOR [rsfecvcto]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rstirm__6F357288]  DEFAULT ((0)) FOR [rstirmerc]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rspvpm__702996C1]  DEFAULT ((0)) FOR [rspvpmerc]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsvalm__711DBAFA]  DEFAULT ((0)) FOR [rsvalmerc]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__encaje__7211DF33]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__monto___7306036C]  DEFAULT ((0)) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__Tipo_C__73FA27A5]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__calce__74EE4BDE]  DEFAULT (' ') FOR [calce]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsint___75E27017]  DEFAULT ((0)) FOR [rsint_compra]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsprin__76D69450]  DEFAULT ((0)) FOR [rsprincipal]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__operad__77CAB889]  DEFAULT (' ') FOR [operador_banco]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecn__78BEDCC2]  DEFAULT (' ') FOR [rsfecneg]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsfecp__79B300FB]  DEFAULT (' ') FOR [rsfecpag]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7AA72534]  DEFAULT (' ') FOR [corr_cli_nombre]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7B9B496D]  DEFAULT (' ') FOR [corr_cli_cta]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7C8F6DA6]  DEFAULT (' ') FOR [corr_cli_aba]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7D8391DF]  DEFAULT (' ') FOR [corr_cli_pais]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7E77B618]  DEFAULT (' ') FOR [corr_cli_ciud]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__7F6BDA51]  DEFAULT (' ') FOR [corr_cli_swift]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__corr_c__005FFE8A]  DEFAULT (' ') FOR [corr_cli_ref]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rspfec__015422C3]  DEFAULT (' ') FOR [rspfectraspaso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsajus__024846FC]  DEFAULT ((0)) FOR [rsajuste_traspaso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__sw_tir__033C6B35]  DEFAULT ((0)) FOR [sw_tir]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__sw_pvp__04308F6E]  DEFAULT ((0)) FOR [sw_pvp]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__Capita__5D01B3B4]  DEFAULT ((0)) FOR [CapitalPeso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__Intere__5DF5D7ED]  DEFAULT ((0)) FOR [InteresPeso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__ValorC__79C8DAEB]  DEFAULT ((0)) FOR [ValorCuponPeso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF_text_rsu_InteresPeso1]  DEFAULT ((0)) FOR [InteresPesoAcum]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF_text_rsu_PrincipalDia]  DEFAULT ((0)) FOR [PrincipalDia]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF_text_rsu_ValorPresentePeso]  DEFAULT ((0)) FOR [ValorPresentePeso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF_text_rsu_PrincipalDiaPeso]  DEFAULT ((0)) FOR [PrincipalDiaPeso]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__text_rsu__rsDife__5EE9FC26]  DEFAULT ((0)) FOR [rsDiferenciaMerc]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [df_textrsu_DurMacaulay]  DEFAULT ((0.0)) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [df_textrsu_DurModificada]  DEFAULT ((0.0)) FOR [DurModificada]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [df_textrsu_Convexidad]  DEFAULT ((0.0)) FOR [Convexidad]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__TEXT_RSU__RsId_L__13E7D44A]  DEFAULT ('') FOR [RsId_Libro]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [CT_PorcjeCob_RSU]  DEFAULT ((0)) FOR [PorcjeCob]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__TEXT_RSU__RsTirM__752E4300]  DEFAULT ((0)) FOR [RsTirMercParPrx]
GO
ALTER TABLE [dbo].[text_rsu] ADD  CONSTRAINT [DF__TEXT_RSU__RsTirM__76226739]  DEFAULT ((0)) FOR [RsTirMercCLPParPrx]
GO
ALTER TABLE [dbo].[text_rsu]  WITH NOCHECK ADD  CONSTRAINT [FK__text_rsu__cod_fa__4AF81212] FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_rsu] CHECK CONSTRAINT [FK__text_rsu__cod_fa__4AF81212]
GO
ALTER TABLE [dbo].[text_rsu]  WITH NOCHECK ADD  CONSTRAINT [FK__text_rsu__rsrutc__4BEC364B] FOREIGN KEY([rsrutcart])
REFERENCES [dbo].[text_arc_ctl_dri] ([acrutprop])
GO
ALTER TABLE [dbo].[text_rsu] CHECK CONSTRAINT [FK__text_rsu__rsrutc__4BEC364B]
GO

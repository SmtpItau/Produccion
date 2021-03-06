USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_mvt_dri]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_mvt_dri](
	[mofecpro] [datetime] NOT NULL,
	[morutcart] [numeric](9, 0) NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[mocorrelativo] [numeric](18, 0) NOT NULL,
	[motipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[cod_familia] [numeric](4, 0) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[mofecemi] [datetime] NOT NULL,
	[mofecven] [datetime] NOT NULL,
	[mofecneg] [datetime] NOT NULL,
	[momonemi] [numeric](3, 0) NOT NULL,
	[momonpag] [numeric](3, 0) NOT NULL,
	[momontoemi] [numeric](19, 4) NOT NULL,
	[motasemi] [numeric](19, 7) NOT NULL,
	[mobasemi] [numeric](3, 0) NOT NULL,
	[morutemi] [numeric](9, 0) NULL,
	[mofecpago] [datetime] NOT NULL,
	[monominal] [numeric](19, 4) NOT NULL,
	[movpresen] [numeric](19, 4) NOT NULL,
	[movalvenc] [numeric](19, 4) NOT NULL,
	[momtps] [numeric](19, 4) NOT NULL,
	[momtum] [numeric](19, 4) NOT NULL,
	[motir] [numeric](19, 7) NOT NULL,
	[mopvp] [numeric](19, 7) NOT NULL,
	[movpar] [numeric](19, 7) NOT NULL,
	[moint_compra] [numeric](19, 4) NOT NULL,
	[moprincipal] [numeric](19, 4) NOT NULL,
	[movalcomp] [float] NOT NULL,
	[movalcomu] [float] NOT NULL,
	[mointeres] [numeric](19, 4) NOT NULL,
	[moreajuste] [numeric](19, 4) NOT NULL,
	[moutilidad] [numeric](19, 4) NOT NULL,
	[moperdida] [numeric](19, 4) NOT NULL,
	[movalven] [numeric](19, 4) NOT NULL,
	[monumucup] [numeric](3, 0) NOT NULL,
	[monumpcup] [numeric](3, 0) NOT NULL,
	[mousuario] [char](12) NULL,
	[mostatreg] [char](1) NOT NULL,
	[moobserv] [char](70) NOT NULL,
	[basilea] [numeric](1, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [numeric](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[tipo_cartera_financiera] [char](2) NOT NULL,
	[sucursal] [smallint] NOT NULL,
	[corr_bco_nombre] [char](50) NOT NULL,
	[corr_bco_cta] [char](30) NOT NULL,
	[corr_bco_aba] [char](9) NOT NULL,
	[corr_bco_pais] [char](15) NOT NULL,
	[corr_bco_ciud] [char](15) NOT NULL,
	[corr_bco_swift] [char](30) NOT NULL,
	[corr_bco_ref] [char](30) NOT NULL,
	[corr_cli_nombre] [char](50) NOT NULL,
	[corr_cli_cta] [char](30) NOT NULL,
	[corr_cli_aba] [char](9) NOT NULL,
	[corr_cli_pais] [char](15) NOT NULL,
	[corr_cli_ciud] [char](15) NOT NULL,
	[corr_cli_swift] [char](30) NOT NULL,
	[corr_cli_ref] [char](30) NOT NULL,
	[operador_contraparte] [char](30) NOT NULL,
	[operador_Banco] [char](30) NOT NULL,
	[calce] [char](1) NOT NULL,
	[tipo_inversion] [char](2) NULL,
	[para_quien] [char](1) NOT NULL,
	[nombre_custodia] [char](30) NOT NULL,
	[confirmacion] [numeric](1, 0) NOT NULL,
	[forma_pago] [numeric](3, 0) NOT NULL,
	[base_tasa] [char](20) NOT NULL,
	[cod_emi] [numeric](1, 0) NULL,
	[mofecucup] [datetime] NOT NULL,
	[mofecpcup] [datetime] NOT NULL,
	[mohoraop] [datetime] NOT NULL,
	[cusip] [char](12) NOT NULL,
	[CapitalPeso] [numeric](24, 0) NOT NULL,
	[InteresPeso] [numeric](24, 0) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[movpressb] [float] NOT NULL,
	[modifsb] [float] NOT NULL,
	[Hora] [char](8) NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[Id_Area_Responsable] [char](10) NULL,
	[Id_Libro] [char](10) NULL,
	[moDigitador] [char](15) NOT NULL,
	[Resultado_Dif_Precio] [numeric](21, 4) NOT NULL,
	[Resultado_Dif_Mercado] [numeric](21, 4) NOT NULL,
	[ValorMercado_prop] [numeric](21, 4) NOT NULL,
 CONSTRAINT [PK__text_mvt_dri__113584D1] PRIMARY KEY CLUSTERED 
(
	[mofecpro] ASC,
	[morutcart] ASC,
	[monumoper] ASC,
	[mocorrelativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__589C25F3]  DEFAULT (' ') FOR [mofecpro]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___morut__59904A2C]  DEFAULT ((0)) FOR [morutcart]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monum__5A846E65]  DEFAULT (' ') FOR [monumoper]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monum__5B78929E]  DEFAULT (' ') FOR [monumdocu]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF_text_mvt_dri_mocorrelativo]  DEFAULT ((1)) FOR [mocorrelativo]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___motip__5C6CB6D7]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___cod_n__5D60DB10]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___cod_f__5E54FF49]  DEFAULT ((0)) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___id_in__5F492382]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__603D47BB]  DEFAULT (' ') FOR [mofecemi]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__61316BF4]  DEFAULT (' ') FOR [mofecven]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__6225902D]  DEFAULT (' ') FOR [mofecneg]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___momon__6319B466]  DEFAULT ((0)) FOR [momontoemi]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___motas__640DD89F]  DEFAULT ((0)) FOR [motasemi]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mobas__6501FCD8]  DEFAULT ((0)) FOR [mobasemi]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__65F62111]  DEFAULT (' ') FOR [mofecpago]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monom__66EA454A]  DEFAULT ((0)) FOR [monominal]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___movpr__67DE6983]  DEFAULT ((0)) FOR [movpresen]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moval__68D28DBC]  DEFAULT ((0)) FOR [movalvenc]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___momtp__69C6B1F5]  DEFAULT ((0)) FOR [momtps]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___momtu__6ABAD62E]  DEFAULT ((0)) FOR [momtum]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___motir__6BAEFA67]  DEFAULT ((0)) FOR [motir]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mopvp__6CA31EA0]  DEFAULT ((0)) FOR [mopvp]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___movpa__6D9742D9]  DEFAULT ((0)) FOR [movpar]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moint__6E8B6712]  DEFAULT ((0)) FOR [moint_compra]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mopri__6F7F8B4B]  DEFAULT ((0)) FOR [moprincipal]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moval__7073AF84]  DEFAULT ((0)) FOR [movalcomp]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moval__7167D3BD]  DEFAULT ((0)) FOR [movalcomu]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moint__725BF7F6]  DEFAULT ((0)) FOR [mointeres]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___morea__73501C2F]  DEFAULT ((0)) FOR [moreajuste]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mouti__74444068]  DEFAULT ((0)) FOR [moutilidad]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moper__753864A1]  DEFAULT ((0)) FOR [moperdida]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moval__762C88DA]  DEFAULT ((0)) FOR [movalven]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monum__7720AD13]  DEFAULT ((0)) FOR [monumucup]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monum__7814D14C]  DEFAULT ((0)) FOR [monumpcup]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mosta__7908F585]  DEFAULT (' ') FOR [mostatreg]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moobs__79FD19BE]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___encaj__7AF13DF7]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___monto__7BE56230]  DEFAULT ((0)) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___tipo___7CD98669]  DEFAULT (' ') FOR [tipo_cartera_financiera]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___7DCDAAA2]  DEFAULT (' ') FOR [corr_bco_nombre]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___7EC1CEDB]  DEFAULT (' ') FOR [corr_bco_cta]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___7FB5F314]  DEFAULT (' ') FOR [corr_bco_aba]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___00AA174D]  DEFAULT (' ') FOR [corr_bco_pais]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___019E3B86]  DEFAULT (' ') FOR [corr_bco_ciud]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___02925FBF]  DEFAULT (' ') FOR [corr_bco_swift]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___038683F8]  DEFAULT (' ') FOR [corr_bco_ref]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___047AA831]  DEFAULT (' ') FOR [corr_cli_nombre]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___056ECC6A]  DEFAULT (' ') FOR [corr_cli_cta]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___0662F0A3]  DEFAULT (' ') FOR [corr_cli_aba]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___075714DC]  DEFAULT (' ') FOR [corr_cli_pais]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___084B3915]  DEFAULT (' ') FOR [corr_cli_ciud]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___093F5D4E]  DEFAULT (' ') FOR [corr_cli_swift]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___corr___0A338187]  DEFAULT (' ') FOR [corr_cli_ref]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___opera__0B27A5C0]  DEFAULT (' ') FOR [operador_contraparte]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___opera__0C1BC9F9]  DEFAULT (' ') FOR [operador_Banco]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___calce__0D0FEE32]  DEFAULT (' ') FOR [calce]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___tipo___0E04126B]  DEFAULT (' ') FOR [tipo_inversion]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___para___0EF836A4]  DEFAULT (' ') FOR [para_quien]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___nombr__0FEC5ADD]  DEFAULT (' ') FOR [nombre_custodia]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___confi__10E07F16]  DEFAULT ((0)) FOR [confirmacion]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___base___11D4A34F]  DEFAULT (' ') FOR [base_tasa]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__12C8C788]  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mofec__13BCEBC1]  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___mohor__14B10FFA]  DEFAULT (' ') FOR [mohoraop]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF_text_mvt_dri_cusip]  DEFAULT (' ') FOR [cusip]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___Capit__5B196B42]  DEFAULT ((0)) FOR [CapitalPeso]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___Inter__5C0D8F7B]  DEFAULT ((0)) FOR [InteresPeso]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__TEXT_MVT___SwImp__1E105D02]  DEFAULT ((0)) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___movpr__5FDE205F]  DEFAULT ((0)) FOR [movpressb]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___modif__60D24498]  DEFAULT ((0)) FOR [modifsb]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt_d__Hora__06C2E356]  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_textmvtdri_DurMacaulay]  DEFAULT ((0.0)) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_textmvtdri_DurModificada]  DEFAULT ((0.0)) FOR [DurModificada]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_textmvtdri_Convexidad]  DEFAULT ((0.0)) FOR [Convexidad]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___Id_Ar__5D8BC399]  DEFAULT ('') FOR [Id_Area_Responsable]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___Id_Li__5E7FE7D2]  DEFAULT ('') FOR [Id_Libro]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [DF__text_mvt___moDig__39A368DE]  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_Text_Mvt_Dri_Resultado_Dif_Precio]  DEFAULT ((0.0)) FOR [Resultado_Dif_Precio]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_Text_Mvt_Dri_Resultado_Dif_Mercado]  DEFAULT ((0.0)) FOR [Resultado_Dif_Mercado]
GO
ALTER TABLE [dbo].[text_mvt_dri] ADD  CONSTRAINT [df_Text_Mvt_Dri_ValorMercado_prop]  DEFAULT ((0.0)) FOR [ValorMercado_prop]
GO
ALTER TABLE [dbo].[text_mvt_dri]  WITH NOCHECK ADD  CONSTRAINT [FK__text_mvt___cod_f__4727812E] FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_mvt_dri] CHECK CONSTRAINT [FK__text_mvt___cod_f__4727812E]
GO
ALTER TABLE [dbo].[text_mvt_dri]  WITH NOCHECK ADD  CONSTRAINT [FK__text_mvt___morut__481BA567] FOREIGN KEY([morutcart])
REFERENCES [dbo].[text_arc_ctl_dri] ([acrutprop])
GO
ALTER TABLE [dbo].[text_mvt_dri] CHECK CONSTRAINT [FK__text_mvt___morut__481BA567]
GO

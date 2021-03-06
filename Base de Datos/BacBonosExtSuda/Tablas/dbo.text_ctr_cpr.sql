USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ctr_cpr]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ctr_cpr](
	[mofecpro] [datetime] NOT NULL,
	[morutcart] [numeric](9, 0) NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[mocorrelativo] [numeric](18, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[motipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[cod_familia] [numeric](4, 0) NULL,
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
	[movalcomp] [numeric](19, 4) NOT NULL,
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
	[Tipo_Cartera_Financiera] [char](2) NOT NULL,
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
	[Hora] [char](8) NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[Id_Area_Responsable] [char](10) NULL,
	[Id_Libro] [char](10) NULL,
	[Resultado_Dif_Precio] [numeric](21, 4) NOT NULL,
	[Resultado_Dif_Mercado] [numeric](21, 4) NOT NULL,
	[ValorMercado_prop] [numeric](21, 4) NOT NULL,
 CONSTRAINT [PK__text_ctr_cpr__0D64F3ED] PRIMARY KEY CLUSTERED 
(
	[mofecpro] ASC,
	[morutcart] ASC,
	[monumoper] ASC,
	[mocorrelativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__4A8310C6]  DEFAULT (' ') FOR [mofecpro]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___morut__4B7734FF]  DEFAULT ((0)) FOR [morutcart]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monum__4C6B5938]  DEFAULT (' ') FOR [monumoper]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF_text_ctr_cpr_mocorrelativo]  DEFAULT ((1)) FOR [mocorrelativo]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monum__4D5F7D71]  DEFAULT (' ') FOR [monumdocu]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___motip__4E53A1AA]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___cod_n__4F47C5E3]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___cod_f__503BEA1C]  DEFAULT ((0)) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___id_in__51300E55]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__5224328E]  DEFAULT (' ') FOR [mofecemi]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__531856C7]  DEFAULT (' ') FOR [mofecven]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__540C7B00]  DEFAULT (' ') FOR [mofecneg]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___momon__55009F39]  DEFAULT ((0)) FOR [momontoemi]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___motas__55F4C372]  DEFAULT ((0)) FOR [motasemi]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mobas__56E8E7AB]  DEFAULT ((0)) FOR [mobasemi]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__57DD0BE4]  DEFAULT (' ') FOR [mofecpago]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monom__58D1301D]  DEFAULT ((0)) FOR [monominal]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___movpr__59C55456]  DEFAULT ((0)) FOR [movpresen]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moval__5AB9788F]  DEFAULT ((0)) FOR [movalvenc]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___momtp__5BAD9CC8]  DEFAULT ((0)) FOR [momtps]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___momtu__5CA1C101]  DEFAULT ((0)) FOR [momtum]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___motir__5D95E53A]  DEFAULT ((0)) FOR [motir]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mopvp__5E8A0973]  DEFAULT ((0)) FOR [mopvp]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___movpa__5F7E2DAC]  DEFAULT ((0)) FOR [movpar]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moint__607251E5]  DEFAULT ((0)) FOR [moint_compra]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mopri__6166761E]  DEFAULT ((0)) FOR [moprincipal]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moval__625A9A57]  DEFAULT ((0)) FOR [movalcomp]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moval__634EBE90]  DEFAULT ((0)) FOR [movalcomu]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moint__6442E2C9]  DEFAULT ((0)) FOR [mointeres]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___morea__65370702]  DEFAULT ((0)) FOR [moreajuste]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mouti__662B2B3B]  DEFAULT ((0)) FOR [moutilidad]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moper__671F4F74]  DEFAULT ((0)) FOR [moperdida]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moval__681373AD]  DEFAULT ((0)) FOR [movalven]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monum__690797E6]  DEFAULT ((0)) FOR [monumucup]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monum__69FBBC1F]  DEFAULT ((0)) FOR [monumpcup]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mosta__6AEFE058]  DEFAULT (' ') FOR [mostatreg]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___moobs__6BE40491]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___encaj__6CD828CA]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___monto__6DCC4D03]  DEFAULT ((0)) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___Tipo___6EC0713C]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___6FB49575]  DEFAULT (' ') FOR [corr_bco_nombre]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___70A8B9AE]  DEFAULT (' ') FOR [corr_bco_cta]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___719CDDE7]  DEFAULT (' ') FOR [corr_bco_aba]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___72910220]  DEFAULT (' ') FOR [corr_bco_pais]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___73852659]  DEFAULT (' ') FOR [corr_bco_ciud]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___74794A92]  DEFAULT (' ') FOR [corr_bco_swift]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___756D6ECB]  DEFAULT (' ') FOR [corr_bco_ref]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___76619304]  DEFAULT (' ') FOR [corr_cli_nombre]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___7755B73D]  DEFAULT (' ') FOR [corr_cli_cta]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___7849DB76]  DEFAULT (' ') FOR [corr_cli_aba]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___793DFFAF]  DEFAULT (' ') FOR [corr_cli_pais]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___7A3223E8]  DEFAULT (' ') FOR [corr_cli_ciud]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___7B264821]  DEFAULT (' ') FOR [corr_cli_swift]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___corr___7C1A6C5A]  DEFAULT (' ') FOR [corr_cli_ref]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___opera__7D0E9093]  DEFAULT (' ') FOR [operador_contraparte]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___opera__7E02B4CC]  DEFAULT (' ') FOR [operador_Banco]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___calce__7EF6D905]  DEFAULT (' ') FOR [calce]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___tipo___7FEAFD3E]  DEFAULT (' ') FOR [tipo_inversion]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___para___00DF2177]  DEFAULT (' ') FOR [para_quien]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___nombr__01D345B0]  DEFAULT (' ') FOR [nombre_custodia]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___confi__02C769E9]  DEFAULT ((0)) FOR [confirmacion]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___base___03BB8E22]  DEFAULT (' ') FOR [base_tasa]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__04AFB25B]  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mofec__05A3D694]  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___mohor__0697FACD]  DEFAULT (' ') FOR [mohoraop]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF_text_ctr_cpr_cusip]  DEFAULT (' ') FOR [cusip]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF_text_ctr_cpr_CapitalPeso]  DEFAULT ((0)) FOR [CapitalPeso]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF_text_ctr_cpr_InteresPeso]  DEFAULT ((0)) FOR [InteresPeso]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr_c__Hora__07B7078F]  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_textctrcpr_DurMacaulay]  DEFAULT ((0.0)) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_textctrcpr_DurModificada]  DEFAULT ((0.0)) FOR [DurModificada]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_textctrcpr_Convexidad]  DEFAULT ((0.0)) FOR [Convexidad]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___Id_Ar__5F740C0B]  DEFAULT ('') FOR [Id_Area_Responsable]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [DF__text_ctr___Id_Li__60683044]  DEFAULT ('') FOR [Id_Libro]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_Text_Ctr_Cpr_Resultado_Dif_Precio]  DEFAULT ((0.0)) FOR [Resultado_Dif_Precio]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_Text_Ctr_Cpr_Resultado_Dif_Mercado]  DEFAULT ((0.0)) FOR [Resultado_Dif_Mercado]
GO
ALTER TABLE [dbo].[text_ctr_cpr] ADD  CONSTRAINT [df_Text_Ctr_Cpr_ValorMercado_prop]  DEFAULT ((0.0)) FOR [ValorMercado_prop]
GO
ALTER TABLE [dbo].[text_ctr_cpr]  WITH CHECK ADD  CONSTRAINT [FK__text_ctr___cod_f__3CA9F2BB] FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_ctr_cpr] CHECK CONSTRAINT [FK__text_ctr___cod_f__3CA9F2BB]
GO
ALTER TABLE [dbo].[text_ctr_cpr]  WITH CHECK ADD  CONSTRAINT [FK__text_ctr___morut__3D9E16F4] FOREIGN KEY([morutcart])
REFERENCES [dbo].[text_arc_ctl_dri] ([acrutprop])
GO
ALTER TABLE [dbo].[text_ctr_cpr] CHECK CONSTRAINT [FK__text_ctr___morut__3D9E16F4]
GO

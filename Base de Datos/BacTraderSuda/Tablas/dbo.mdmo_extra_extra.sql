USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdmo_extra_extra]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdmo_extra_extra](
	[mofecpro] [datetime] NULL,
	[morutcart] [numeric](9, 0) NULL,
	[motipcart] [numeric](5, 0) NULL,
	[monumdocu] [numeric](10, 0) NULL,
	[mocorrela] [numeric](3, 0) NULL,
	[monumdocuo] [numeric](10, 0) NULL,
	[mocorrelao] [numeric](3, 0) NULL,
	[monumoper] [numeric](10, 0) NULL,
	[motipoper] [char](3) NULL,
	[motipopero] [char](3) NULL,
	[moinstser] [char](12) NULL,
	[momascara] [char](12) NULL,
	[mocodigo] [numeric](3, 0) NULL,
	[moseriado] [char](1) NULL,
	[mofecemi] [datetime] NULL,
	[mofecven] [datetime] NULL,
	[momonemi] [numeric](3, 0) NULL,
	[motasemi] [numeric](9, 4) NULL,
	[mobasemi] [numeric](3, 0) NULL,
	[morutemi] [numeric](9, 0) NULL,
	[monominal] [numeric](19, 4) NULL,
	[movpresen] [numeric](19, 4) NULL,
	[momtps] [numeric](19, 4) NULL,
	[momtum] [float] NULL,
	[momtum100] [float] NULL,
	[monumucup] [numeric](3, 0) NULL,
	[motir] [numeric](19, 4) NULL,
	[mopvp] [numeric](7, 2) NULL,
	[movpar] [real] NULL,
	[motasest] [numeric](9, 4) NULL,
	[mofecinip] [datetime] NULL,
	[mofecvenp] [datetime] NULL,
	[movalinip] [numeric](19, 4) NULL,
	[movalvenp] [numeric](19, 4) NULL,
	[motaspact] [numeric](9, 4) NULL,
	[mobaspact] [numeric](3, 0) NULL,
	[momonpact] [numeric](3, 0) NULL,
	[moforpagi] [numeric](5, 0) NULL,
	[moforpagv] [numeric](5, 0) NULL,
	[motipobono] [char](1) NULL,
	[mocondpacto] [char](3) NULL,
	[mopagohoy] [char](1) NULL,
	[morutcli] [numeric](9, 0) NULL,
	[mocodcli] [numeric](9, 0) NULL,
	[motipret] [char](1) NULL,
	[mohora] [char](15) NULL,
	[mousuario] [char](15) NULL,
	[moterminal] [char](15) NULL,
	[mocapitali] [numeric](19, 4) NULL,
	[mointeresi] [numeric](19, 4) NULL,
	[moreajusti] [numeric](19, 4) NULL,
	[movpreseni] [numeric](19, 4) NULL,
	[mocapitalp] [numeric](19, 4) NULL,
	[mointeresp] [numeric](19, 4) NULL,
	[moreajustp] [numeric](19, 4) NULL,
	[movpresenp] [numeric](19, 4) NULL,
	[motasant] [numeric](19, 4) NULL,
	[mobasant] [numeric](19, 4) NULL,
	[movalant] [numeric](19, 4) NULL,
	[mostatreg] [char](1) NULL,
	[movpressb] [numeric](19, 4) NULL,
	[modifsb] [numeric](19, 4) NULL,
	[monominalp] [numeric](19, 4) NULL,
	[movalcomp] [numeric](19, 4) NULL,
	[movalcomu] [numeric](19, 4) NULL,
	[mointeres] [numeric](19, 4) NULL,
	[moreajuste] [numeric](19, 4) NULL,
	[mointpac] [numeric](19, 4) NULL,
	[moreapac] [numeric](19, 4) NULL,
	[moutilidad] [numeric](19, 4) NULL,
	[moperdida] [numeric](19, 4) NULL,
	[movalven] [numeric](19, 4) NULL,
	[mocontador] [numeric](19, 0) NULL,
	[monsollin] [numeric](19, 0) NULL,
	[moobserv] [char](70) NULL,
	[moobserv2] [char](70) NULL,
	[movvista] [numeric](19, 0) NULL,
	[movviscom] [numeric](19, 0) NULL,
	[momtocomi] [numeric](19, 0) NULL,
	[mocorvent] [numeric](5, 0) NULL,
	[modcv] [char](1) NULL,
	[moclave_dcv] [char](10) NULL,
	[mocodexceso] [int] NULL,
	[momtoPFE] [float] NULL,
	[momtoCCE] [float] NULL,
	[mointermesc] [numeric](19, 4) NULL,
	[moreajumesc] [numeric](19, 4) NULL,
	[mointermesvi] [numeric](19, 4) NULL,
	[moreajumesvi] [numeric](19, 4) NULL,
	[fecha_compra_original] [datetime] NULL,
	[valor_compra_original] [numeric](19, 4) NULL,
	[valor_compra_um_original] [float] NULL,
	[tir_compra_original] [numeric](19, 4) NULL,
	[valor_par_compra_original] [numeric](19, 6) NULL,
	[porcentaje_valor_par_compra_original] [numeric](8, 4) NULL,
	[codigo_carterasuper] [char](1) NULL,
	[Tipo_Cartera_Financiera] [char](1) NULL,
	[Mercado] [char](1) NULL,
	[Sucursal] [varchar](5) NULL,
	[Id_Sistema] [char](3) NULL,
	[Fecha_PagoMañana] [datetime] NULL,
	[Laminas] [char](1) NULL,
	[Tipo_Inversion] [char](1) NULL,
	[Cuenta_Corriente_Inicio] [char](15) NULL,
	[Cuenta_Corriente_Final] [char](15) NULL,
	[Sucursal_Inicio] [varchar](5) NULL,
	[Sucursal_Final] [varchar](5) NULL,
	[motipoletra] [char](1) NULL,
	[moreserva_tecnica1] [numeric](19, 4) NULL,
	[movalvenc] [numeric](19, 4) NULL,
	[movaltasemi] [numeric](19, 4) NULL,
	[moprimadesc] [numeric](19, 4) NULL,
	[SwImpresion] [numeric](1, 0) NULL,
	[MtoCompraPM] [numeric](21, 4) NULL,
	[MtoVentaPM] [numeric](21, 4) NULL,
	[PagoMañana] [char](1) NULL,
	[SorteoLchr] [char](1) NULL,
	[Dcrp_Confirmador] [char](1) NULL,
	[Dcrp_Codigo] [numeric](9, 0) NULL,
	[Dcrp_Glosa] [varchar](100) NULL,
	[Dcrp_HoraConfirm] [char](8) NULL,
	[Dcrp_OperConfirm] [char](15) NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NULL,
	[id_libro] [char](6) NULL,
	[moTirTran] [numeric](19, 4) NULL,
	[moPvpTran] [numeric](19, 4) NULL,
	[moVPTran] [numeric](19, 4) NULL,
	[moDifTran_MO] [numeric](19, 4) NULL,
	[moDifTran_CLP] [numeric](19, 0) NULL,
	[moDigitador] [char](15) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mofecpro__5B3966D3]  DEFAULT (' ') FOR [mofecpro]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__morutcart__5C2D8B0C]  DEFAULT (0) FOR [morutcart]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motipcart__5D21AF45]  DEFAULT (0) FOR [motipcart]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monumdocu__5E15D37E]  DEFAULT (0) FOR [monumdocu]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocorrela__5F09F7B7]  DEFAULT (0) FOR [mocorrela]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monumdocuo__5FFE1BF0]  DEFAULT (0) FOR [monumdocuo]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocorrelao__60F24029]  DEFAULT (0) FOR [mocorrelao]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monumoper__61E66462]  DEFAULT (0) FOR [monumoper]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motipoper__62DA889B]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motipopero__63CEACD4]  DEFAULT (' ') FOR [motipopero]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moinstser__64C2D10D]  DEFAULT (' ') FOR [moinstser]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momascara__65B6F546]  DEFAULT (' ') FOR [momascara]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocodigo__66AB197F]  DEFAULT (0) FOR [mocodigo]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moseriado__679F3DB8]  DEFAULT (0) FOR [moseriado]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mofecemi__689361F1]  DEFAULT (' ') FOR [mofecemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mofecven__6987862A]  DEFAULT (' ') FOR [mofecven]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momonemi__6A7BAA63]  DEFAULT (0) FOR [momonemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motasemi__6B6FCE9C]  DEFAULT (0) FOR [motasemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mobasemi__6C63F2D5]  DEFAULT (0) FOR [mobasemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__morutemi__6D58170E]  DEFAULT (0) FOR [morutemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monominal__6E4C3B47]  DEFAULT (0) FOR [monominal]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movpresen__6F405F80]  DEFAULT (0) FOR [movpresen]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtps__703483B9]  DEFAULT (0) FOR [momtps]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtum__7128A7F2]  DEFAULT (0) FOR [momtum]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtum100__721CCC2B]  DEFAULT (0) FOR [momtum100]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monumucup__7310F064]  DEFAULT (0) FOR [monumucup]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motir__7405149D]  DEFAULT (0) FOR [motir]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mopvp__74F938D6]  DEFAULT (0) FOR [mopvp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movpar__75ED5D0F]  DEFAULT (0) FOR [movpar]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motasest__76E18148]  DEFAULT (0) FOR [motasest]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mofecinip__77D5A581]  DEFAULT (' ') FOR [mofecinip]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mofecvenp__78C9C9BA]  DEFAULT (' ') FOR [mofecvenp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalinip__79BDEDF3]  DEFAULT (0) FOR [movalinip]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalvenp__7AB2122C]  DEFAULT (0) FOR [movalvenp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motaspact__7BA63665]  DEFAULT (0) FOR [motaspact]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mobaspact__7C9A5A9E]  DEFAULT (0) FOR [mobaspact]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momonpact__7D8E7ED7]  DEFAULT (0) FOR [momonpact]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moforpagi__7E82A310]  DEFAULT (0) FOR [moforpagi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moforpagv__7F76C749]  DEFAULT (0) FOR [moforpagv]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momercado__006AEB82]  DEFAULT (' ') FOR [motipobono]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motipcust__015F0FBB]  DEFAULT (' ') FOR [mocondpacto]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mopagohoy__025333F4]  DEFAULT (' ') FOR [mopagohoy]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__morutcli__0347582D]  DEFAULT (0) FOR [morutcli]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocodcli__043B7C66]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motipret__052FA09F]  DEFAULT (' ') FOR [motipret]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mohora__0623C4D8]  DEFAULT (' ') FOR [mohora]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mousuario__0717E911]  DEFAULT (' ') FOR [mousuario]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moterminal__080C0D4A]  DEFAULT (' ') FOR [moterminal]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocapitali__09003183]  DEFAULT (0) FOR [mocapitali]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mointeresi__09F455BC]  DEFAULT (0) FOR [mointeresi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moreajusti__0AE879F5]  DEFAULT (0) FOR [moreajusti]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movpreseni__0BDC9E2E]  DEFAULT (0) FOR [movpreseni]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocapitalp__0CD0C267]  DEFAULT (0) FOR [mocapitalp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mointeresp__0DC4E6A0]  DEFAULT (0) FOR [mointeresp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moreajustp__0EB90AD9]  DEFAULT (0) FOR [moreajustp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movpresenp__0FAD2F12]  DEFAULT (0) FOR [movpresenp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__motasant__10A1534B]  DEFAULT (0) FOR [motasant]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mobasant__11957784]  DEFAULT (0) FOR [mobasant]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalant__12899BBD]  DEFAULT (0) FOR [movalant]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mostatreg__137DBFF6]  DEFAULT (' ') FOR [mostatreg]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movpressb__1471E42F]  DEFAULT (0) FOR [movpressb]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__modifsb__15660868]  DEFAULT (0) FOR [modifsb]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monominalp__165A2CA1]  DEFAULT (0) FOR [monominalp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalcomp__174E50DA]  DEFAULT (0) FOR [movalcomp]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalcomu__18427513]  DEFAULT (0) FOR [movalcomu]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mointeres__1936994C]  DEFAULT (0) FOR [mointeres]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moreajuste__1A2ABD85]  DEFAULT (0) FOR [moreajuste]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mointpac__1B1EE1BE]  DEFAULT (0) FOR [mointpac]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moreapac__1C1305F7]  DEFAULT (0) FOR [moreapac]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moutilidad__1D072A30]  DEFAULT (0) FOR [moutilidad]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moperdida__1DFB4E69]  DEFAULT (0) FOR [moperdida]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movalven__1EEF72A2]  DEFAULT (0) FOR [movalven]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocontador__1FE396DB]  DEFAULT (0) FOR [mocontador]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__monsollin__20D7BB14]  DEFAULT (0) FOR [monsollin]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moobserv__21CBDF4D]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moobserv2__22C00386]  DEFAULT (' ') FOR [moobserv2]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movvista__23B427BF]  DEFAULT (0) FOR [movvista]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movviscom__24A84BF8]  DEFAULT (0) FOR [movviscom]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtocomi__259C7031]  DEFAULT (0) FOR [momtocomi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocorvent__2690946A]  DEFAULT (0) FOR [mocorvent]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__modcv__4CF63474]  DEFAULT (' ') FOR [modcv]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moclave_dc__4DEA58AD]  DEFAULT ('') FOR [moclave_dcv]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__mocodexces__4EDE7CE6]  DEFAULT (0) FOR [mocodexceso]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtoPFE__4FD2A11F]  DEFAULT (0) FOR [momtoPFE]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__momtoCCE__50C6C558]  DEFAULT (0) FOR [momtoCCE]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__fecha_comp__14B5D404]  DEFAULT ('') FOR [fecha_compra_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__valor_comp__15A9F83D]  DEFAULT (0) FOR [valor_compra_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__valor_comp__169E1C76]  DEFAULT (53) FOR [valor_compra_um_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__tir_compra__179240AF]  DEFAULT (0) FOR [tir_compra_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__valor_par___188664E8]  DEFAULT (0) FOR [valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__porcentaje__197A8921]  DEFAULT (0) FOR [porcentaje_valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__codigo_car__1A6EAD5A]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Tipo_Carte__07852AC1]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Mercado__08794EFA]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Sucursal__096D7333]  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Id_Sistema__0A61976C]  DEFAULT (' ') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Fecha_Pago__0B55BBA5]  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Laminas__0C49DFDE]  DEFAULT (' ') FOR [Laminas]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Tipo_Inver__0D3E0417]  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Cuenta_Cor__0E322850]  DEFAULT (' ') FOR [Cuenta_Corriente_Inicio]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Cuenta_Cor__0F264C89]  DEFAULT (' ') FOR [Cuenta_Corriente_Final]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Sucursal_I__101A70C2]  DEFAULT (' ') FOR [Sucursal_Inicio]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__Sucursal_F__110E94FB]  DEFAULT (' ') FOR [Sucursal_Final]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF_mdmo_extra_motipoletra]  DEFAULT ('') FOR [motipoletra]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF_mdmo_extra_monominal1]  DEFAULT (0) FOR [moreserva_tecnica1]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF_mdmo_extra_monominal1_1]  DEFAULT (0) FOR [movalvenc]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__movaltasem__57F3B12B]  DEFAULT (0) FOR [movaltasemi]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moprimades__58E7D564]  DEFAULT (0) FOR [moprimadesc]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__SwImpresio__43B94502]  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [Df_mdmo_extra_MtoCompraPM]  DEFAULT (0.0) FOR [MtoCompraPM]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [Df_mdmo_extra_MtoVentaPM]  DEFAULT (0.0) FOR [MtoVentaPM]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [Df_mdmo_extra_PagoMañana]  DEFAULT ('N') FOR [PagoMañana]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [Df_mdmo_extra_SorteoLchr]  DEFAULT ('N') FOR [SorteoLchr]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_dcrpconfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_dcrpcodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_dcrpglosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_dcrphora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_operhora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [df_mdmo_extra_opecnvhora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__id_libro__3C58E5B3]  DEFAULT ('') FOR [id_libro]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moTirTran__12AFF206]  DEFAULT (0.0) FOR [moTirTran]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moPvpTran__13A4163F]  DEFAULT (0.0) FOR [moPvpTran]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moVPTran__14983A78]  DEFAULT (0.0) FOR [moVPTran]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moDifTran___158C5EB1]  DEFAULT (0.0) FOR [moDifTran_MO]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moDifTran___168082EA]  DEFAULT (0.0) FOR [moDifTran_CLP]
GO
ALTER TABLE [dbo].[mdmo_extra_extra] ADD  CONSTRAINT [DF__mdmo_extra__moDigitado__7BA26F7C]  DEFAULT ('') FOR [moDigitador]
GO

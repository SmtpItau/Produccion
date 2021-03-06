USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdmo]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdmo](
	[mofecpro] [datetime] NOT NULL,
	[morutcart] [numeric](9, 0) NOT NULL,
	[motipcart] [numeric](5, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[mocorrela] [numeric](3, 0) NOT NULL,
	[monumdocuo] [numeric](10, 0) NOT NULL,
	[mocorrelao] [numeric](3, 0) NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[motipoper] [char](3) NOT NULL,
	[motipopero] [char](3) NOT NULL,
	[moinstser] [char](12) NOT NULL,
	[momascara] [char](12) NOT NULL,
	[mocodigo] [numeric](3, 0) NOT NULL,
	[moseriado] [char](1) NOT NULL,
	[mofecemi] [datetime] NOT NULL,
	[mofecven] [datetime] NOT NULL,
	[momonemi] [numeric](3, 0) NOT NULL,
	[motasemi] [numeric](9, 4) NOT NULL,
	[mobasemi] [numeric](3, 0) NOT NULL,
	[morutemi] [numeric](9, 0) NOT NULL,
	[monominal] [numeric](19, 4) NOT NULL,
	[movpresen] [numeric](19, 4) NOT NULL,
	[momtps] [numeric](19, 4) NOT NULL,
	[momtum] [float] NOT NULL,
	[momtum100] [float] NOT NULL,
	[monumucup] [numeric](3, 0) NOT NULL,
	[motir] [numeric](19, 4) NOT NULL,
	[mopvp] [numeric](19, 4) NOT NULL,
	[movpar] [real] NOT NULL,
	[motasest] [numeric](9, 4) NOT NULL,
	[mofecinip] [datetime] NOT NULL,
	[mofecvenp] [datetime] NOT NULL,
	[movalinip] [numeric](19, 4) NOT NULL,
	[movalvenp] [numeric](19, 4) NOT NULL,
	[motaspact] [numeric](9, 4) NOT NULL,
	[mobaspact] [numeric](3, 0) NOT NULL,
	[momonpact] [numeric](3, 0) NOT NULL,
	[moforpagi] [numeric](5, 0) NOT NULL,
	[moforpagv] [numeric](5, 0) NOT NULL,
	[motipobono] [char](1) NOT NULL,
	[mocondpacto] [char](3) NOT NULL,
	[mopagohoy] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[motipret] [char](1) NOT NULL,
	[mohora] [char](15) NOT NULL,
	[mousuario] [char](15) NOT NULL,
	[moterminal] [char](15) NOT NULL,
	[mocapitali] [numeric](19, 4) NOT NULL,
	[mointeresi] [numeric](19, 4) NOT NULL,
	[moreajusti] [numeric](19, 4) NOT NULL,
	[movpreseni] [numeric](19, 4) NOT NULL,
	[mocapitalp] [numeric](19, 4) NOT NULL,
	[mointeresp] [numeric](19, 4) NOT NULL,
	[moreajustp] [numeric](19, 4) NOT NULL,
	[movpresenp] [numeric](19, 4) NOT NULL,
	[motasant] [numeric](19, 4) NOT NULL,
	[mobasant] [numeric](19, 4) NOT NULL,
	[movalant] [numeric](19, 4) NOT NULL,
	[mostatreg] [char](1) NOT NULL,
	[movpressb] [numeric](19, 4) NOT NULL,
	[modifsb] [numeric](19, 4) NOT NULL,
	[monominalp] [numeric](19, 4) NULL,
	[movalcomp] [numeric](19, 4) NULL,
	[movalcomu] [numeric](19, 4) NOT NULL,
	[mointeres] [numeric](19, 4) NULL,
	[moreajuste] [numeric](19, 4) NULL,
	[mointpac] [numeric](19, 4) NULL,
	[moreapac] [numeric](19, 4) NULL,
	[moutilidad] [numeric](19, 4) NULL,
	[moperdida] [numeric](19, 4) NULL,
	[movalven] [numeric](19, 4) NULL,
	[mocontador] [numeric](19, 0) NOT NULL,
	[monsollin] [numeric](19, 0) NOT NULL,
	[moobserv] [char](70) NOT NULL,
	[moobserv2] [char](70) NOT NULL,
	[movvista] [numeric](19, 0) NOT NULL,
	[movviscom] [numeric](19, 0) NOT NULL,
	[momtocomi] [numeric](19, 0) NOT NULL,
	[mocorvent] [numeric](5, 0) NOT NULL,
	[modcv] [char](1) NOT NULL,
	[moclave_dcv] [char](10) NOT NULL,
	[mocodexceso] [int] NOT NULL,
	[momtoPFE] [float] NOT NULL,
	[momtoCCE] [float] NOT NULL,
	[mointermesc] [numeric](19, 4) NULL,
	[moreajumesc] [numeric](19, 4) NULL,
	[mointermesvi] [numeric](19, 4) NULL,
	[moreajumesvi] [numeric](19, 4) NULL,
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
	[Cuenta_Corriente_Inicio] [char](15) NOT NULL,
	[Cuenta_Corriente_Final] [char](15) NOT NULL,
	[Sucursal_Inicio] [varchar](5) NOT NULL,
	[Sucursal_Final] [varchar](5) NOT NULL,
	[motipoletra] [char](1) NOT NULL,
	[moreserva_tecnica1] [numeric](19, 4) NULL,
	[movalvenc] [numeric](19, 4) NULL,
	[movaltasemi] [numeric](19, 4) NOT NULL,
	[moprimadesc] [numeric](19, 4) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[MtoCompraPM] [numeric](21, 4) NULL,
	[MtoVentaPM] [numeric](21, 4) NULL,
	[PagoMañana] [char](1) NULL,
	[SorteoLchr] [char](1) NULL,
	[Dcrp_Confirmador] [char](1) NOT NULL,
	[Dcrp_Codigo] [numeric](9, 0) NOT NULL,
	[Dcrp_Glosa] [varchar](100) NOT NULL,
	[Dcrp_HoraConfirm] [char](8) NOT NULL,
	[Dcrp_OperConfirm] [char](15) NOT NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NOT NULL,
	[id_libro] [char](6) NULL,
	[moTirTran] [numeric](19, 4) NOT NULL,
	[moPvpTran] [numeric](19, 4) NOT NULL,
	[moVPTran] [numeric](19, 4) NOT NULL,
	[moDifTran_MO] [numeric](19, 4) NOT NULL,
	[moDifTran_CLP] [numeric](19, 0) NOT NULL,
	[moDigitador] [char](15) NOT NULL,
	[Resultado_Dif_Precio] [numeric](21, 4) NOT NULL,
	[Resultado_Dif_Mercado] [numeric](21, 4) NOT NULL,
	[ValorMercado_prop] [numeric](21, 4) NOT NULL,
	[Tasa_Contrato] [numeric](8, 6) NOT NULL,
	[Valor_Contable] [numeric](19, 4) NOT NULL,
	[Fecha_Contrato] [datetime] NOT NULL,
	[Numero_Contrato] [numeric](10, 0) NOT NULL,
	[Tipo_Rentabilidad] [char](10) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Tipo_Custodia] [int] NOT NULL,
	[tipo_deposito] [char](1) NOT NULL,
	[Condicion_Captacion] [char](1) NOT NULL,
	[mofecpcup] [datetime] NOT NULL,
	[mofecucup] [datetime] NOT NULL,
	[mofechareal] [datetime] NOT NULL,
	[Codigo_Interfaz] [numeric](3, 0) NOT NULL,
	[mogarantia] [char](1) NOT NULL,
	[sub_forma_venc] [numeric](5, 0) NOT NULL,
	[sub_forma_ini] [numeric](5, 0) NOT NULL,
	[movptirc] [numeric](18, 4) NOT NULL,
	[moFecCust] [datetime] NOT NULL,
	[moind1446] [char](1) NOT NULL,
	[Estado_DCV] [char](1) NOT NULL,
	[Codigo_madurez] [char](1) NOT NULL,
	[MoIndVtaParcial] [char](1) NOT NULL,
	[Movptasemi] [numeric](19, 0) NOT NULL,
	[MoMtoDif] [numeric](19, 0) NOT NULL,
	[Capital_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Intereses_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Reajustes_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Tipo_Emision] [int] NOT NULL,
	[moestado_mp] [char](1) NOT NULL,
	[momensaje_mp] [char](255) NOT NULL,
	[moTasCFdo] [numeric](9, 4) NOT NULL,
	[numero_certificado_dcv] [numeric](10, 0) NOT NULL,
	[moexcepcion] [char](1) NOT NULL,
	[movisador1] [char](15) NOT NULL,
	[movisador2] [char](15) NOT NULL,
	[MOESTADO_CONTRATO] [char](30) NOT NULL,
	[morutContraparte] [numeric](9, 0) NOT NULL,
	[mocodContraparte] [numeric](9, 0) NOT NULL,
	[volcker_rule] [numeric](1, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mofecpro__5B3966D3]  DEFAULT (' ') FOR [mofecpro]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__morutcart__5C2D8B0C]  DEFAULT (0) FOR [morutcart]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motipcart__5D21AF45]  DEFAULT (0) FOR [motipcart]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monumdocu__5E15D37E]  DEFAULT (0) FOR [monumdocu]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocorrela__5F09F7B7]  DEFAULT (0) FOR [mocorrela]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monumdocuo__5FFE1BF0]  DEFAULT (0) FOR [monumdocuo]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocorrelao__60F24029]  DEFAULT (0) FOR [mocorrelao]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monumoper__61E66462]  DEFAULT (0) FOR [monumoper]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motipoper__62DA889B]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motipopero__63CEACD4]  DEFAULT (' ') FOR [motipopero]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moinstser__64C2D10D]  DEFAULT (' ') FOR [moinstser]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momascara__65B6F546]  DEFAULT (' ') FOR [momascara]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocodigo__66AB197F]  DEFAULT (0) FOR [mocodigo]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moseriado__679F3DB8]  DEFAULT (0) FOR [moseriado]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mofecemi__689361F1]  DEFAULT (' ') FOR [mofecemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mofecven__6987862A]  DEFAULT (' ') FOR [mofecven]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momonemi__6A7BAA63]  DEFAULT (0) FOR [momonemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motasemi__6B6FCE9C]  DEFAULT (0) FOR [motasemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mobasemi__6C63F2D5]  DEFAULT (0) FOR [mobasemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__morutemi__6D58170E]  DEFAULT (0) FOR [morutemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monominal__6E4C3B47]  DEFAULT (0) FOR [monominal]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movpresen__6F405F80]  DEFAULT (0) FOR [movpresen]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtps__703483B9]  DEFAULT (0) FOR [momtps]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtum__7128A7F2]  DEFAULT (0) FOR [momtum]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtum100__721CCC2B]  DEFAULT (0) FOR [momtum100]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monumucup__7310F064]  DEFAULT (0) FOR [monumucup]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motir__7405149D]  DEFAULT (0) FOR [motir]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mopvp__74F938D6]  DEFAULT (0) FOR [mopvp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movpar__75ED5D0F]  DEFAULT (0) FOR [movpar]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motasest__76E18148]  DEFAULT (0) FOR [motasest]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mofecinip__77D5A581]  DEFAULT (' ') FOR [mofecinip]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mofecvenp__78C9C9BA]  DEFAULT (' ') FOR [mofecvenp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalinip__79BDEDF3]  DEFAULT (0) FOR [movalinip]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalvenp__7AB2122C]  DEFAULT (0) FOR [movalvenp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motaspact__7BA63665]  DEFAULT (0) FOR [motaspact]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mobaspact__7C9A5A9E]  DEFAULT (0) FOR [mobaspact]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momonpact__7D8E7ED7]  DEFAULT (0) FOR [momonpact]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moforpagi__7E82A310]  DEFAULT (0) FOR [moforpagi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moforpagv__7F76C749]  DEFAULT (0) FOR [moforpagv]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momercado__006AEB82]  DEFAULT (' ') FOR [motipobono]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motipcust__015F0FBB]  DEFAULT (' ') FOR [mocondpacto]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mopagohoy__025333F4]  DEFAULT (' ') FOR [mopagohoy]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__morutcli__0347582D]  DEFAULT (0) FOR [morutcli]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocodcli__043B7C66]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motipret__052FA09F]  DEFAULT (' ') FOR [motipret]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mohora__0623C4D8]  DEFAULT (' ') FOR [mohora]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mousuario__0717E911]  DEFAULT (' ') FOR [mousuario]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moterminal__080C0D4A]  DEFAULT (' ') FOR [moterminal]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocapitali__09003183]  DEFAULT (0) FOR [mocapitali]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mointeresi__09F455BC]  DEFAULT (0) FOR [mointeresi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moreajusti__0AE879F5]  DEFAULT (0) FOR [moreajusti]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movpreseni__0BDC9E2E]  DEFAULT (0) FOR [movpreseni]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocapitalp__0CD0C267]  DEFAULT (0) FOR [mocapitalp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mointeresp__0DC4E6A0]  DEFAULT (0) FOR [mointeresp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moreajustp__0EB90AD9]  DEFAULT (0) FOR [moreajustp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movpresenp__0FAD2F12]  DEFAULT (0) FOR [movpresenp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__motasant__10A1534B]  DEFAULT (0) FOR [motasant]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mobasant__11957784]  DEFAULT (0) FOR [mobasant]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalant__12899BBD]  DEFAULT (0) FOR [movalant]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mostatreg__137DBFF6]  DEFAULT (' ') FOR [mostatreg]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movpressb__1471E42F]  DEFAULT (0) FOR [movpressb]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__modifsb__15660868]  DEFAULT (0) FOR [modifsb]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monominalp__165A2CA1]  DEFAULT (0) FOR [monominalp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalcomp__174E50DA]  DEFAULT (0) FOR [movalcomp]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalcomu__18427513]  DEFAULT (0) FOR [movalcomu]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mointeres__1936994C]  DEFAULT (0) FOR [mointeres]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moreajuste__1A2ABD85]  DEFAULT (0) FOR [moreajuste]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mointpac__1B1EE1BE]  DEFAULT (0) FOR [mointpac]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moreapac__1C1305F7]  DEFAULT (0) FOR [moreapac]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moutilidad__1D072A30]  DEFAULT (0) FOR [moutilidad]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moperdida__1DFB4E69]  DEFAULT (0) FOR [moperdida]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movalven__1EEF72A2]  DEFAULT (0) FOR [movalven]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocontador__1FE396DB]  DEFAULT (0) FOR [mocontador]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__monsollin__20D7BB14]  DEFAULT (0) FOR [monsollin]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moobserv__21CBDF4D]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moobserv2__22C00386]  DEFAULT (' ') FOR [moobserv2]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movvista__23B427BF]  DEFAULT (0) FOR [movvista]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__movviscom__24A84BF8]  DEFAULT (0) FOR [movviscom]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtocomi__259C7031]  DEFAULT (0) FOR [momtocomi]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocorvent__2690946A]  DEFAULT (0) FOR [mocorvent]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__modcv__4CF63474]  DEFAULT (' ') FOR [modcv]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__moclave_dc__4DEA58AD]  DEFAULT ('') FOR [moclave_dcv]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__mocodexces__4EDE7CE6]  DEFAULT (0) FOR [mocodexceso]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtoPFE__4FD2A11F]  DEFAULT (0) FOR [momtoPFE]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__momtoCCE__50C6C558]  DEFAULT (0) FOR [momtoCCE]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__fecha_comp__14B5D404]  DEFAULT ('') FOR [fecha_compra_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__valor_comp__15A9F83D]  DEFAULT (0) FOR [valor_compra_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__valor_comp__169E1C76]  DEFAULT (53) FOR [valor_compra_um_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__tir_compra__179240AF]  DEFAULT (0) FOR [tir_compra_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__valor_par___188664E8]  DEFAULT (0) FOR [valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__porcentaje__197A8921]  DEFAULT (0) FOR [porcentaje_valor_par_compra_original]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__MDMO__codigo_car__1A6EAD5A]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Tipo_Carte__07852AC1]  DEFAULT (' ') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Mercado__08794EFA]  DEFAULT (' ') FOR [Mercado]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Sucursal__096D7333]  DEFAULT (' ') FOR [Sucursal]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Id_Sistema__0A61976C]  DEFAULT (' ') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Fecha_Pago__0B55BBA5]  DEFAULT (' ') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Laminas__0C49DFDE]  DEFAULT (' ') FOR [Laminas]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Tipo_Inver__0D3E0417]  DEFAULT (' ') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Cuenta_Cor__0E322850]  DEFAULT (' ') FOR [Cuenta_Corriente_Inicio]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Cuenta_Cor__0F264C89]  DEFAULT (' ') FOR [Cuenta_Corriente_Final]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Sucursal_I__101A70C2]  DEFAULT (' ') FOR [Sucursal_Inicio]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF__mdmo__Sucursal_F__110E94FB]  DEFAULT (' ') FOR [Sucursal_Final]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF_mdmo_motipoletra]  DEFAULT ('') FOR [motipoletra]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF_mdmo_monominal1]  DEFAULT (0) FOR [moreserva_tecnica1]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [DF_mdmo_monominal1_1]  DEFAULT (0) FOR [movalvenc]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0) FOR [movaltasemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0) FOR [moprimadesc]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [Df_Mdmo_MtoCompraPM]  DEFAULT (0.0) FOR [MtoCompraPM]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [Df_Mdmo_MtoVentaPM]  DEFAULT (0.0) FOR [MtoVentaPM]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [Df_Mdmo_PagoMañana]  DEFAULT ('N') FOR [PagoMañana]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [Df_Mdmo_SorteoLchr]  DEFAULT ('N') FOR [SorteoLchr]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_dcrpconfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_dcrpcodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_dcrpglosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_dcrphora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_operhora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_opecnvhora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ('') FOR [id_libro]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0.0) FOR [moTirTran]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0.0) FOR [moPvpTran]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0.0) FOR [moVPTran]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0.0) FOR [moDifTran_MO]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (0.0) FOR [moDifTran_CLP]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_Resultado_Dif_Precio]  DEFAULT ((0.0)) FOR [Resultado_Dif_Precio]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_Resultado_Dif_Mercado]  DEFAULT ((0.0)) FOR [Resultado_Dif_Mercado]
GO
ALTER TABLE [dbo].[mdmo] ADD  CONSTRAINT [df_mdmo_ValorMercado_prop]  DEFAULT ((0.0)) FOR [ValorMercado_prop]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [tipo_deposito]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [Condicion_Captacion]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [mofechareal]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Codigo_Interfaz]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [mogarantia]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [sub_forma_venc]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [sub_forma_ini]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [movptirc]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [moFecCust]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [moind1446]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [Estado_DCV]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [Codigo_madurez]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [MoIndVtaParcial]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Movptasemi]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [MoMtoDif]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Capital_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Intereses_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Reajustes_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [Tipo_Emision]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [moestado_mp]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [momensaje_mp]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [moTasCFdo]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [numero_certificado_dcv]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [moexcepcion]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [movisador1]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [movisador2]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT (' ') FOR [MOESTADO_CONTRATO]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [morutContraparte]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [mocodContraparte]
GO
ALTER TABLE [dbo].[mdmo] ADD  DEFAULT ((0)) FOR [volcker_rule]
GO

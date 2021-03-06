USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDMOPM]    Script Date: 13-05-2022 12:16:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDMOPM](
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
	[mopvp] [numeric](7, 2) NOT NULL,
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
	[moINTeresi] [numeric](19, 4) NOT NULL,
	[moreajusti] [numeric](19, 4) NOT NULL,
	[movpreseni] [numeric](19, 4) NOT NULL,
	[mocapitalp] [numeric](19, 4) NOT NULL,
	[moINTeresp] [numeric](19, 4) NOT NULL,
	[moreajustp] [numeric](19, 4) NOT NULL,
	[movpresenp] [numeric](19, 4) NOT NULL,
	[motasant] [numeric](19, 4) NOT NULL,
	[mobasant] [numeric](19, 4) NOT NULL,
	[movalant] [numeric](19, 4) NOT NULL,
	[mostatreg] [char](1) NOT NULL,
	[movpressb] [numeric](19, 4) NOT NULL,
	[modifsb] [numeric](19, 4) NOT NULL,
	[monominalp] [numeric](19, 4) NOT NULL,
	[movalcomp] [numeric](19, 4) NOT NULL,
	[movalcomu] [numeric](19, 4) NOT NULL,
	[moINTeres] [numeric](19, 4) NOT NULL,
	[moreajuste] [numeric](19, 4) NOT NULL,
	[moINTpac] [numeric](19, 4) NOT NULL,
	[moreapac] [numeric](19, 4) NOT NULL,
	[moutilidad] [numeric](19, 4) NOT NULL,
	[moperdida] [numeric](19, 4) NOT NULL,
	[movalven] [numeric](19, 4) NOT NULL,
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
	[moINTermesc] [numeric](19, 4) NOT NULL,
	[moreajumesc] [numeric](19, 4) NOT NULL,
	[moINTermesvi] [numeric](19, 4) NOT NULL,
	[moreajumesvi] [numeric](19, 4) NOT NULL,
	[fecha_compra_original] [datetime] NOT NULL,
	[valor_compra_original] [numeric](19, 4) NOT NULL,
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
	[moreserva_tecnica1] [numeric](19, 4) NOT NULL,
	[movalvenc] [numeric](19, 4) NOT NULL,
	[movaltasemi] [numeric](19, 4) NOT NULL,
	[moprimadesc] [numeric](19, 4) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[MtoCompraPM] [numeric](21, 4) NOT NULL,
	[MtoVentaPM] [numeric](21, 4) NOT NULL,
	[PagoMañana] [char](1) NOT NULL,
	[SorteoLCHR] [char](1) NOT NULL,
	[Dcrp_Confirmador] [char](1) NOT NULL,
	[Dcrp_Codigo] [numeric](9, 0) NOT NULL,
	[Dcrp_Glosa] [varchar](100) NOT NULL,
	[Dcrp_HoraConfirm] [char](8) NOT NULL,
	[Dcrp_OperConfirm] [char](15) NOT NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NOT NULL,
	[moid_libro] [char](6) NULL,
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
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mofecpro]  DEFAULT ('') FOR [mofecpro]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_morutcart]  DEFAULT (0) FOR [morutcart]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipcart]  DEFAULT (0) FOR [motipcart]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monumdocu]  DEFAULT (0) FOR [monumdocu]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocorrela]  DEFAULT (0) FOR [mocorrela]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monumdocuo]  DEFAULT (0) FOR [monumdocuo]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocorrelao]  DEFAULT (0) FOR [mocorrelao]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monumoper]  DEFAULT (0) FOR [monumoper]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipoper]  DEFAULT ('') FOR [motipoper]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipopero]  DEFAULT ('') FOR [motipopero]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moinstser]  DEFAULT ('') FOR [moinstser]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momascara]  DEFAULT ('') FOR [momascara]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocodigo]  DEFAULT (0) FOR [mocodigo]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moseriado]  DEFAULT ('') FOR [moseriado]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mofecemi]  DEFAULT ('') FOR [mofecemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mofecven]  DEFAULT ('') FOR [mofecven]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momonemi]  DEFAULT (0) FOR [momonemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motasemi]  DEFAULT (0.0) FOR [motasemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mobasemi]  DEFAULT (0) FOR [mobasemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_morutemi]  DEFAULT (0) FOR [morutemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monominal]  DEFAULT (0.0) FOR [monominal]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movpresen]  DEFAULT (0.0) FOR [movpresen]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtps]  DEFAULT (0.0) FOR [momtps]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtum]  DEFAULT (0.0) FOR [momtum]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtum100]  DEFAULT (0.0) FOR [momtum100]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monumucup]  DEFAULT (0) FOR [monumucup]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motir]  DEFAULT (0.0) FOR [motir]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mopvp]  DEFAULT (0.0) FOR [mopvp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movpar]  DEFAULT (0) FOR [movpar]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motasest]  DEFAULT (0.0) FOR [motasest]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mofecinip]  DEFAULT ('') FOR [mofecinip]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mofecvenp]  DEFAULT ('') FOR [mofecvenp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalinip]  DEFAULT (0.0) FOR [movalinip]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalvenp]  DEFAULT (0.0) FOR [movalvenp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motaspact]  DEFAULT (0.0) FOR [motaspact]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mobaspact]  DEFAULT (0) FOR [mobaspact]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momonpact]  DEFAULT (0) FOR [momonpact]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moforpagi]  DEFAULT (0) FOR [moforpagi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moforpagv]  DEFAULT (0) FOR [moforpagv]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipobono]  DEFAULT ('') FOR [motipobono]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocondpacto]  DEFAULT ('') FOR [mocondpacto]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mopagohoy]  DEFAULT ('') FOR [mopagohoy]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_morutcli]  DEFAULT (0) FOR [morutcli]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocodcli]  DEFAULT (0) FOR [mocodcli]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipret]  DEFAULT ('') FOR [motipret]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mohora]  DEFAULT ('') FOR [mohora]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mousuario]  DEFAULT ('') FOR [mousuario]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moterminal]  DEFAULT ('') FOR [moterminal]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocapitali]  DEFAULT (0.0) FOR [mocapitali]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTeresi]  DEFAULT (0.0) FOR [moINTeresi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreajusti]  DEFAULT (0.0) FOR [moreajusti]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movpreseni]  DEFAULT (0.0) FOR [movpreseni]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocapitalp]  DEFAULT (0.0) FOR [mocapitalp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTeresp]  DEFAULT (0.0) FOR [moINTeresp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreajustp]  DEFAULT (0.0) FOR [moreajustp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movpresenp]  DEFAULT (0.0) FOR [movpresenp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motasant]  DEFAULT (0.0) FOR [motasant]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mobasant]  DEFAULT (0.0) FOR [mobasant]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalant]  DEFAULT (0.0) FOR [movalant]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mostatreg]  DEFAULT ('') FOR [mostatreg]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movpressb]  DEFAULT (0.0) FOR [movpressb]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_modifsb]  DEFAULT (0.0) FOR [modifsb]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monominalp]  DEFAULT (0.0) FOR [monominalp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalcomp]  DEFAULT (0.0) FOR [movalcomp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalcomu]  DEFAULT (0.0) FOR [movalcomu]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTeres]  DEFAULT (0.0) FOR [moINTeres]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreajuste]  DEFAULT (0.0) FOR [moreajuste]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTpac]  DEFAULT (0.0) FOR [moINTpac]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreapac]  DEFAULT (0.0) FOR [moreapac]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moutilidad]  DEFAULT (0.0) FOR [moutilidad]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moperdida]  DEFAULT (0.0) FOR [moperdida]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalven]  DEFAULT (0.0) FOR [movalven]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocontador]  DEFAULT (0) FOR [mocontador]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_monsollin]  DEFAULT (0) FOR [monsollin]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moobserv]  DEFAULT ('') FOR [moobserv]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moobserv2]  DEFAULT ('') FOR [moobserv2]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movvista]  DEFAULT (0) FOR [movvista]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movviscom]  DEFAULT (0) FOR [movviscom]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtocomi]  DEFAULT (0) FOR [momtocomi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocorvent]  DEFAULT (0) FOR [mocorvent]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_modcv]  DEFAULT ('') FOR [modcv]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moclave_dcv]  DEFAULT ('') FOR [moclave_dcv]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_mocodexceso]  DEFAULT (0) FOR [mocodexceso]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtoPFE]  DEFAULT (0.0) FOR [momtoPFE]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_momtoCCE]  DEFAULT (0.0) FOR [momtoCCE]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTermesc]  DEFAULT (0.0) FOR [moINTermesc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreajumesc]  DEFAULT (0.0) FOR [moreajumesc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moINTermesvi]  DEFAULT (0.0) FOR [moINTermesvi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreajumesvi]  DEFAULT (0.0) FOR [moreajumesvi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_fecha_compra_original]  DEFAULT ('') FOR [fecha_compra_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_valor_compra_original]  DEFAULT (0.0) FOR [valor_compra_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_valor_compra_um_original]  DEFAULT (0.0) FOR [valor_compra_um_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_tir_compra_original]  DEFAULT (0.0) FOR [tir_compra_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_valor_par_compra_original]  DEFAULT (0.0) FOR [valor_par_compra_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_porcentaje_valor_par_compra_original]  DEFAULT (0.0) FOR [porcentaje_valor_par_compra_original]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_codigo_carterasuper]  DEFAULT ('') FOR [codigo_carterasuper]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Tipo_Cartera_Financiera]  DEFAULT ('') FOR [Tipo_Cartera_Financiera]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Mercado]  DEFAULT ('') FOR [Mercado]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Sucursal]  DEFAULT ('') FOR [Sucursal]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Id_Sistema]  DEFAULT ('') FOR [Id_Sistema]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Fecha_PagoMañana]  DEFAULT ('') FOR [Fecha_PagoMañana]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Laminas]  DEFAULT ('') FOR [Laminas]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Tipo_Inversion]  DEFAULT ('') FOR [Tipo_Inversion]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Cuenta_Corriente_Inicio]  DEFAULT ('') FOR [Cuenta_Corriente_Inicio]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Cuenta_Corriente_Final]  DEFAULT ('') FOR [Cuenta_Corriente_Final]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Sucursal_Inicio]  DEFAULT ('') FOR [Sucursal_Inicio]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Sucursal_Final]  DEFAULT ('') FOR [Sucursal_Final]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_motipoletra]  DEFAULT ('') FOR [motipoletra]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moreserva_tecnica1]  DEFAULT (0.0) FOR [moreserva_tecnica1]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movalvenc]  DEFAULT (0.0) FOR [movalvenc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_movaltasemi]  DEFAULT (0.0) FOR [movaltasemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_moprimadesc]  DEFAULT (0.0) FOR [moprimadesc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_SwImpresion]  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_MtoCompraPM]  DEFAULT (0.0) FOR [MtoCompraPM]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_MtoVentaPM]  DEFAULT (0.0) FOR [MtoVentaPM]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_PagoMañana]  DEFAULT ('N') FOR [PagoMañana]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_SorteoLCHR]  DEFAULT ('N') FOR [SorteoLCHR]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_DcrpConfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_DcrpCodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_DcrpGlosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_DcrpHora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_OperHora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_OpeCnvHora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ('') FOR [moid_libro]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Resultado_Dif_Precio]  DEFAULT ((0.0)) FOR [Resultado_Dif_Precio]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_Resultado_Dif_Mercado]  DEFAULT ((0.0)) FOR [Resultado_Dif_Mercado]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  CONSTRAINT [df_mdmopm_ValorMercado_prop]  DEFAULT ((0.0)) FOR [ValorMercado_prop]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [tipo_deposito]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [Condicion_Captacion]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [mofechareal]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Codigo_Interfaz]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [mogarantia]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [sub_forma_venc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [sub_forma_ini]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [movptirc]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [moFecCust]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [moind1446]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [Estado_DCV]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [Codigo_madurez]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [MoIndVtaParcial]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Movptasemi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [MoMtoDif]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Capital_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Intereses_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Reajustes_Tasa_Emi]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [Tipo_Emision]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [moestado_mp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [momensaje_mp]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [moTasCFdo]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [numero_certificado_dcv]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [moexcepcion]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [movisador1]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [movisador2]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT (' ') FOR [MOESTADO_CONTRATO]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [morutContraparte]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [mocodContraparte]
GO
ALTER TABLE [dbo].[MDMOPM] ADD  DEFAULT ((0)) FOR [volcker_rule]
GO

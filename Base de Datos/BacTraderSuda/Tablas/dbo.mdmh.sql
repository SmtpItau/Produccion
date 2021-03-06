USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdmh]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdmh](
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
	[MtoCompraPM] [numeric](21, 4) NULL,
	[MtoVentaPM] [numeric](21, 4) NULL,
	[SorteoLchr] [char](1) NULL,
	[PagoMañana] [char](1) NULL,
	[Dcrp_Confirmador] [char](1) NOT NULL,
	[Dcrp_Codigo] [numeric](9, 0) NOT NULL,
	[Dcrp_Glosa] [varchar](100) NOT NULL,
	[Dcrp_HoraConfirm] [char](8) NOT NULL,
	[Dcrp_OperConfirm] [char](15) NOT NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NOT NULL,
	[moid_libro] [char](6) NULL,
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
	[tipo_deposito] [char](10) NOT NULL,
	[Condicion_Captacion] [char](10) NOT NULL,
	[mofecpcup] [datetime] NOT NULL,
	[mofecucup] [datetime] NOT NULL,
	[mofechareal] [datetime] NOT NULL,
	[Codigo_Interfaz] [numeric](3, 0) NOT NULL,
	[sub_forma_venc] [numeric](5, 0) NOT NULL,
	[sub_forma_ini] [numeric](5, 0) NOT NULL,
	[movptirc] [numeric](19, 0) NOT NULL,
	[moFecCust] [datetime] NOT NULL,
	[moind1446] [char](1) NOT NULL,
	[Movptasemi] [numeric](19, 0) NOT NULL,
	[MoMtoDif] [numeric](19, 0) NOT NULL,
	[Capital_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Intereses_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Reajustes_Tasa_Emi] [numeric](19, 0) NOT NULL,
	[Tipo_Emision] [int] NOT NULL,
	[moestado_mp] [char](1) NOT NULL,
	[momensaje_mp] [char](255) NOT NULL,
	[numero_certificado_dcv] [numeric](10, 0) NOT NULL,
	[morutContraparte] [numeric](9, 0) NOT NULL,
	[mocodContraparte] [numeric](9, 0) NOT NULL,
	[volcker_rule] [numeric](1, 0) NOT NULL,
	[numdocu_itau] [numeric](10, 0) NOT NULL,
	[numoper_itau] [numeric](10, 0) NOT NULL,
	[correla_itau] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0) FOR [movaltasemi]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0) FOR [moprimadesc]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [Df_Mdmoh_MtoCompraPM]  DEFAULT (0.0) FOR [MtoCompraPM]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [Df_Mdmoh_MtoVentaPM]  DEFAULT (0.0) FOR [MtoVentaPM]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [Df_Mdmoh_SorteoLchr]  DEFAULT ('N') FOR [SorteoLchr]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [Df_Mdmoh_PagoMañana]  DEFAULT ('N') FOR [PagoMañana]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_dcrpconfirma]  DEFAULT ('N') FOR [Dcrp_Confirmador]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_dcrpcodigo]  DEFAULT (0) FOR [Dcrp_Codigo]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_dcrpglosa]  DEFAULT ('-') FOR [Dcrp_Glosa]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_dcrphora]  DEFAULT ('00:00:00') FOR [Dcrp_HoraConfirm]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mmdmh_operhora]  DEFAULT ('-') FOR [Dcrp_OperConfirm]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_opecnvhora]  DEFAULT ('-') FOR [Dcrp_OpeCnvConfirm]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ('') FOR [moid_libro]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0.0) FOR [moTirTran]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0.0) FOR [moPvpTran]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0.0) FOR [moVPTran]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0.0) FOR [moDifTran_MO]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (0.0) FOR [moDifTran_CLP]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ('') FOR [moDigitador]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_Resultado_Dif_Precio]  DEFAULT ((0.0)) FOR [Resultado_Dif_Precio]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_Resultado_Dif_Mercado]  DEFAULT ((0.0)) FOR [Resultado_Dif_Mercado]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [df_mdmh_ValorMercado_prop]  DEFAULT ((0.0)) FOR [ValorMercado_prop]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Tasa_Contrato]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Valor_Contable]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [Fecha_Contrato]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Numero_Contrato]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [Tipo_Rentabilidad]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Ejecutivo]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Tipo_Custodia]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [tipo_deposito]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [Condicion_Captacion]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [mofechareal]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Codigo_Interfaz]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [sub_forma_venc]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [sub_forma_ini]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [movptirc]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [moFecCust]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [moind1446]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Movptasemi]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [MoMtoDif]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Capital_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Intereses_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Reajustes_Tasa_Emi]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [Tipo_Emision]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [moestado_mp]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT (' ') FOR [momensaje_mp]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [numero_certificado_dcv]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [morutContraparte]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [mocodContraparte]
GO
ALTER TABLE [dbo].[mdmh] ADD  DEFAULT ((0)) FOR [volcker_rule]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [DF__MDMH__Numdocu]  DEFAULT ((0)) FOR [numdocu_itau]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [DF__MDMH__numoper]  DEFAULT ((0)) FOR [numoper_itau]
GO
ALTER TABLE [dbo].[mdmh] ADD  CONSTRAINT [DF__MDMH__correla]  DEFAULT ((0)) FOR [correla_itau]
GO

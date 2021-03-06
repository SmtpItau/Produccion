USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MFCA_EVAL]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MFCA_EVAL](
	[canumoper] [numeric](10, 0) NOT NULL,
	[cacodpos1] [numeric](2, 0) NOT NULL,
	[cacodmon1] [numeric](3, 0) NOT NULL,
	[cacodsuc1] [numeric](3, 0) NOT NULL,
	[cacodpos2] [numeric](2, 0) NOT NULL,
	[cacodmon2] [numeric](3, 0) NOT NULL,
	[cacodcart] [numeric](9, 0) NOT NULL,
	[cacodigo] [numeric](9, 0) NOT NULL,
	[cacodcli] [numeric](9, 0) NOT NULL,
	[catipoper] [char](1) NOT NULL,
	[catipmoda] [char](1) NOT NULL,
	[cafecha] [datetime] NOT NULL,
	[catipcam] [float] NOT NULL,
	[camdausd] [numeric](3, 0) NOT NULL,
	[camtomon1] [numeric](21, 4) NOT NULL,
	[caequusd1] [numeric](21, 4) NOT NULL,
	[caequmon1] [numeric](21, 4) NOT NULL,
	[camtomon2] [numeric](21, 4) NOT NULL,
	[caequusd2] [numeric](21, 4) NOT NULL,
	[caequmon2] [numeric](21, 4) NOT NULL,
	[caparmon1] [float] NOT NULL,
	[capremon1] [float] NOT NULL,
	[caparmon2] [float] NOT NULL,
	[capremon2] [float] NOT NULL,
	[caestado] [char](1) NOT NULL,
	[caretiro] [char](1) NOT NULL,
	[cacontraparte] [numeric](9, 0) NOT NULL,
	[caobserv] [varchar](255) NOT NULL,
	[captacom] [float] NOT NULL,
	[captavta] [float] NOT NULL,
	[caspread] [float] NOT NULL,
	[cacolmon1] [float] NOT NULL,
	[cacapmon1] [float] NOT NULL,
	[catasadolar] [float] NOT NULL,
	[catasaufclp] [float] NOT NULL,
	[caprecal] [float] NOT NULL,
	[caplazo] [numeric](6, 0) NOT NULL,
	[cafecvcto] [datetime] NOT NULL,
	[capreant] [float] NOT NULL,
	[cavalpre] [float] NOT NULL,
	[caoperador] [char](15) NOT NULL,
	[catasfwdcmp] [float] NOT NULL,
	[catasfwdvta] [float] NOT NULL,
	[cacalcmpdol] [float] NOT NULL,
	[cacalcmpspr] [float] NOT NULL,
	[cacalvtadol] [float] NOT NULL,
	[cacalvtaspr] [float] NOT NULL,
	[catasausd] [float] NOT NULL,
	[catasacon] [float] NOT NULL,
	[cadiferen] [float] NOT NULL,
	[cafpagomn] [numeric](3, 0) NOT NULL,
	[cafpagomx] [numeric](3, 0) NOT NULL,
	[cadiftipcam] [numeric](21, 4) NOT NULL,
	[cadifuf] [numeric](21, 4) NOT NULL,
	[caclpinicial] [numeric](21, 4) NOT NULL,
	[caclpfinal] [numeric](21, 4) NOT NULL,
	[camtodiferir] [numeric](21, 4) NOT NULL,
	[camtodevengar] [numeric](21, 4) NOT NULL,
	[cadevacum] [numeric](21, 4) NOT NULL,
	[catipcamval] [numeric](21, 6) NOT NULL,
	[camtoliq] [numeric](21, 4) NOT NULL,
	[camtocalzado] [numeric](19, 4) NOT NULL,
	[calock] [char](15) NOT NULL,
	[camarktomarket] [numeric](21, 4) NOT NULL,
	[capreciomtm] [numeric](21, 10) NOT NULL,
	[capreciofwd] [numeric](21, 10) NOT NULL,
	[camtomon1ini] [numeric](21, 4) NOT NULL,
	[camtomon1fin] [numeric](21, 4) NOT NULL,
	[camtomon2ini] [numeric](21, 4) NOT NULL,
	[camtomon2fin] [numeric](21, 4) NOT NULL,
	[caplazoope] [numeric](6, 0) NOT NULL,
	[caplazovto] [numeric](6, 0) NOT NULL,
	[caplazocal] [numeric](6, 0) NOT NULL,
	[cadiasdev] [numeric](6, 0) NOT NULL,
	[cadelusd] [numeric](12, 4) NOT NULL,
	[cadeluf] [numeric](12, 4) NOT NULL,
	[carevusd] [numeric](21, 0) NOT NULL,
	[carevuf] [numeric](21, 0) NOT NULL,
	[carevtot] [numeric](21, 0) NOT NULL,
	[cavalordia] [numeric](21, 0) NOT NULL,
	[cactacambio_a] [numeric](21, 0) NOT NULL,
	[cactacambio_c] [numeric](21, 0) NOT NULL,
	[cautildiferir] [numeric](21, 0) NOT NULL,
	[caperddiferir] [numeric](21, 0) NOT NULL,
	[cautildevenga] [numeric](21, 0) NOT NULL,
	[caperddevenga] [numeric](21, 0) NOT NULL,
	[cautilacum] [numeric](21, 0) NOT NULL,
	[caperdacum] [numeric](21, 0) NOT NULL,
	[cautilsaldo] [numeric](21, 0) NOT NULL,
	[caperdsaldo] [numeric](21, 0) NOT NULL,
	[caclpmoneda1] [numeric](21, 0) NOT NULL,
	[caclpmoneda2] [numeric](21, 0) NOT NULL,
	[camtocomp] [numeric](21, 10) NOT NULL,
	[caantici] [char](1) NOT NULL,
	[cafecvenor] [datetime] NOT NULL,
	[cabroker] [numeric](9, 0) NOT NULL,
	[cafecmod] [datetime] NOT NULL,
	[cavalorayer] [numeric](21, 0) NOT NULL,
	[camontopfe] [numeric](24, 4) NOT NULL,
	[camontocce] [numeric](24, 4) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[precio_transferencia] [numeric](21, 11) NOT NULL,
	[tipo_sintetico] [char](3) NOT NULL,
	[precio_spot] [numeric](10, 4) NOT NULL,
	[pais_origen] [numeric](5, 0) NOT NULL,
	[moneda_compensacion] [numeric](5, 0) NOT NULL,
	[riesgo_sintetico] [char](3) NOT NULL,
	[precio_reversa_sintetico] [numeric](10, 4) NOT NULL,
	[calzada] [char](1) NOT NULL,
	[marca] [varchar](30) NOT NULL,
	[numerointerfaz] [varchar](16) NOT NULL,
	[contrato_entrega_via] [char](1) NOT NULL,
	[contrato_emitido_por] [char](1) NOT NULL,
	[contrato_ubicado_en] [char](1) NOT NULL,
	[fechaemision] [datetime] NOT NULL,
	[fecharecepcion] [datetime] NOT NULL,
	[fechaingresocustodia] [datetime] NOT NULL,
	[fechafirmacontrato] [datetime] NOT NULL,
	[fecharetirocustodia] [datetime] NOT NULL,
	[numerocontratocliente] [numeric](10, 0) NOT NULL,
	[capremio] [numeric](24, 4) NOT NULL,
	[catipopc] [char](1) NOT NULL,
	[diferido_usd] [numeric](21, 4) NOT NULL,
	[diferido_cnv] [numeric](21, 4) NOT NULL,
	[devengo_acum_usd_hoy] [numeric](21, 4) NOT NULL,
	[devengo_acum_cnv_hoy] [numeric](21, 4) NOT NULL,
	[devengo_acum_usd_ayer] [numeric](21, 4) NOT NULL,
	[devengo_acum_cnv_ayer] [numeric](21, 4) NOT NULL,
	[pesos_diferido_usd] [numeric](21, 0) NOT NULL,
	[pesos_diferido_cnv] [numeric](21, 0) NOT NULL,
	[pesos_devengo_usd] [numeric](21, 0) NOT NULL,
	[pesos_devengo_cnv] [numeric](21, 0) NOT NULL,
	[pesos_devengo_acum_usd] [numeric](21, 0) NOT NULL,
	[pesos_devengo_acum_cnv] [numeric](21, 0) NOT NULL,
	[pesos_devengo_saldo_usd] [numeric](21, 0) NOT NULL,
	[pesos_devengo_saldo_cnv] [numeric](21, 0) NOT NULL,
	[valor_actual_cnv] [numeric](21, 4) NOT NULL,
	[tc_calculo_mes_actual] [float] NOT NULL,
	[tc_calculo_mes_anterior] [float] NOT NULL,
	[mtm_hoy_moneda1] [numeric](21, 0) NOT NULL,
	[mtm_hoy_moneda2] [numeric](21, 0) NOT NULL,
	[var_moneda1] [numeric](21, 0) NOT NULL,
	[var_moneda2] [numeric](21, 0) NOT NULL,
	[tasa_mtm_moneda1] [float] NOT NULL,
	[tasa_mtm_moneda2] [float] NOT NULL,
	[tasa_var_moneda1] [float] NOT NULL,
	[tasa_var_moneda2] [float] NOT NULL,
	[efecto_cambio_moneda1] [numeric](21, 0) NOT NULL,
	[efecto_cambio_moneda2] [numeric](21, 0) NOT NULL,
	[devengo_tasa_moneda1] [numeric](21, 0) NOT NULL,
	[devengo_tasa_moneda2] [numeric](21, 0) NOT NULL,
	[cambio_tasa_moneda1] [numeric](21, 0) NOT NULL,
	[cambio_tasa_moneda2] [numeric](21, 0) NOT NULL,
	[residuo] [numeric](21, 0) NOT NULL,
	[mtm_ayer_moneda1] [numeric](21, 0) NOT NULL,
	[mtm_ayer_moneda2] [numeric](21, 0) NOT NULL,
	[cahora] [char](8) NOT NULL,
	[capreciopunta] [float] NOT NULL,
	[caremunera_linea] [numeric](10, 4) NOT NULL,
	[caplazo_uso_moneda1] [numeric](5, 0) NOT NULL,
	[caplazo_uso_moneda2] [numeric](5, 0) NOT NULL,
	[caobservlin] [char](255) NOT NULL,
	[caobservlim] [char](255) NOT NULL,
	[caautoriza] [char](15) NOT NULL,
	[catasa_efectiva_moneda1] [float] NOT NULL,
	[catasa_efectiva_moneda2] [float] NOT NULL,
	[cautilacum_ayer] [numeric](21, 0) NOT NULL,
	[caperdacum_ayer] [numeric](21, 0) NOT NULL,
	[carevusd_ayer] [numeric](21, 0) NOT NULL,
	[carevuf_ayer] [numeric](21, 0) NOT NULL,
	[carevtot_ayer] [numeric](21, 0) NOT NULL,
	[caoperrelaspot] [char](2) NULL,
	[catasaEfectMon1] [float] NOT NULL,
	[catasaEfectMon2] [float] NOT NULL,
	[catipcamSpot] [float] NOT NULL,
	[catipcamFwd] [float] NOT NULL,
	[cafecEfectiva] [datetime] NOT NULL,
	[fVal_Obtenido] [float] NULL,
	[fRes_Obtenido] [float] NULL,
	[CaTasaSinteticaM1] [float] NULL,
	[CaTasaSinteticaM2] [float] NULL,
	[CaPrecioSpotVentaM1] [float] NULL,
	[CaPrecioSpotVentaM2] [float] NULL,
	[CaPrecioSpotCompraM1] [float] NULL,
	[CaPrecioSpotCompraM2] [float] NULL,
	[caserie] [varchar](12) NULL,
	[caseriado] [char](1) NULL,
	[ValorRazonableActivo] [float] NULL,
	[ValorRazonablePasivo] [float] NULL,
	[catipcamPtosFwd] [float] NOT NULL,
	[cacartera_normativa] [char](6) NULL,
	[casubcartera_normativa] [char](6) NULL,
	[calibro] [char](6) NULL,
	[caArea_Responsable] [char](6) NULL,
	[estado_sinacofi] [char](25) NOT NULL,
	[fecha_estado_sina] [datetime] NOT NULL,
	[caAntPtosFwd] [float] NOT NULL,
	[caAntPtosCos] [float] NOT NULL,
	[caAntTasaPlazoRem] [float] NOT NULL,
	[caAntBase] [float] NOT NULL,
	[caAntForPagMdaComp] [numeric](3, 0) NOT NULL,
	[caAntParContraMda] [float] NOT NULL,
	[caAntParMdaComp] [float] NOT NULL,
	[caAntFactorContMda] [float] NOT NULL,
	[caAntMtoMdaComp] [float] NOT NULL,
	[caAntDifCostUnitMerc] [float] NOT NULL,
	[caAntMTMCost] [float] NOT NULL,
	[caAntMargenContMda] [float] NOT NULL,
	[caAntValCLPContMda] [float] NOT NULL,
	[caAntCorrela] [numeric](3, 0) NOT NULL,
	[caAntPreOpEF] [float] NOT NULL,
	[caOrgCurvaMon] [char](2) NOT NULL,
	[caOrgCurvaCnv] [char](2) NOT NULL,
	[VrCambio] [float] NOT NULL,
	[VrDevengo] [float] NOT NULL,
	[VrTasa] [float] NOT NULL,
	[cacosto_usdclp] [float] NOT NULL,
	[cacosto_mxusd] [float] NOT NULL,
	[cacosto_mxclp] [float] NOT NULL,
	[cafijaTCRef] [datetime] NOT NULL,
	[cafijaPRRef] [datetime] NOT NULL,
	[caMtoOriginal] [numeric](21, 4) NOT NULL,
	[caSpotTipCam] [float] NOT NULL,
	[caSpotParidad] [float] NOT NULL,
	[numerospot] [numeric](9, 0) NOT NULL,
	[Resultado_Mesa] [float] NOT NULL,
	[Threshold] [char](1) NOT NULL,
	[CaFechaStarting] [datetime] NOT NULL,
	[CaFechaFijacionStarting] [datetime] NOT NULL,
	[CaPuntosFwdCierre] [float] NOT NULL,
	[CaPuntosTransfObs] [float] NOT NULL,
	[CaPuntosTransfFwd] [float] NOT NULL,
	[CaTasaPriPzoFijObs] [float] NOT NULL,
	[CaTasaSecPzoFijObs] [float] NOT NULL,
	[CaDelta] [float] NOT NULL,
	[bEarlyTermination] [bit] NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[Periodicidad] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__canumoper__543A90E5]  DEFAULT ((0)) FOR [canumoper]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodpos1__552EB51E]  DEFAULT ((0)) FOR [cacodpos1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodmon1__5622D957]  DEFAULT ((0)) FOR [cacodmon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodsuc1__5716FD90]  DEFAULT ((0)) FOR [cacodsuc1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodpos2__580B21C9]  DEFAULT ((0)) FOR [cacodpos2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodmon2__58FF4602]  DEFAULT ((0)) FOR [cacodmon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodcart__59F36A3B]  DEFAULT ((0)) FOR [cacodcart]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodigo__5AE78E74]  DEFAULT ((0)) FOR [cacodigo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacodcli__5BDBB2AD]  DEFAULT ((0)) FOR [cacodcli]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catipoper__5CCFD6E6]  DEFAULT (' ') FOR [catipoper]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catipmoda__5DC3FB1F]  DEFAULT (' ') FOR [catipmoda]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafecha__5EB81F58]  DEFAULT (' ') FOR [cafecha]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catipcam__5FAC4391]  DEFAULT ((0)) FOR [catipcam]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camdausd__60A067CA]  DEFAULT ((0)) FOR [camdausd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon1__61948C03]  DEFAULT ((0)) FOR [camtomon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caequusd1__6288B03C]  DEFAULT ((0)) FOR [caequusd1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caequmon1__637CD475]  DEFAULT ((0)) FOR [caequmon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon2__6470F8AE]  DEFAULT ((0)) FOR [camtomon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caequusd2__65651CE7]  DEFAULT ((0)) FOR [caequusd2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caequmon2__66594120]  DEFAULT ((0)) FOR [caequmon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caparmon1__674D6559]  DEFAULT ((0)) FOR [caparmon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capremon1__68418992]  DEFAULT ((0)) FOR [capremon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caparmon2__6935ADCB]  DEFAULT ((0)) FOR [caparmon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capremon2__6A29D204]  DEFAULT ((0)) FOR [capremon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caestado__6B1DF63D]  DEFAULT (' ') FOR [caestado]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caretiro__6C121A76]  DEFAULT (' ') FOR [caretiro]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacontrapa__6D063EAF]  DEFAULT ((0)) FOR [cacontraparte]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caobserv__6DFA62E8]  DEFAULT (' ') FOR [caobserv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__captacom__6EEE8721]  DEFAULT ((0)) FOR [captacom]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__captavta__6FE2AB5A]  DEFAULT ((0)) FOR [captavta]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caspread__70D6CF93]  DEFAULT ((0)) FOR [caspread]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacolmon1__71CAF3CC]  DEFAULT ((0)) FOR [cacolmon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacapmon1__72BF1805]  DEFAULT ((0)) FOR [cacapmon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasadola__73B33C3E]  DEFAULT ((0)) FOR [catasadolar]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasaufcl__74A76077]  DEFAULT ((0)) FOR [catasaufclp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caprecal__759B84B0]  DEFAULT ((0)) FOR [caprecal]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caplazo__768FA8E9]  DEFAULT ((0)) FOR [caplazo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafecvcto__7783CD22]  DEFAULT (' ') FOR [cafecvcto]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capreant__7877F15B]  DEFAULT ((0)) FOR [capreant]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cavalpre__796C1594]  DEFAULT ((0)) FOR [cavalpre]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caoperador__7A6039CD]  DEFAULT (' ') FOR [caoperador]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasfwdcm__7B545E06]  DEFAULT ((0)) FOR [catasfwdcmp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasfwdvt__7C48823F]  DEFAULT ((0)) FOR [catasfwdvta]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacalcmpdo__7D3CA678]  DEFAULT ((0)) FOR [cacalcmpdol]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacalcmpsp__7E30CAB1]  DEFAULT ((0)) FOR [cacalcmpspr]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacalvtado__7F24EEEA]  DEFAULT ((0)) FOR [cacalvtadol]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cacalvtasp__00191323]  DEFAULT ((0)) FOR [cacalvtaspr]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasausd__010D375C]  DEFAULT ((0)) FOR [catasausd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catasacon__02015B95]  DEFAULT ((0)) FOR [catasacon]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadiferen__02F57FCE]  DEFAULT ((0)) FOR [cadiferen]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafpagomn__03E9A407]  DEFAULT ((0)) FOR [cafpagomn]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafpagomx__04DDC840]  DEFAULT ((0)) FOR [cafpagomx]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadiftipca__05D1EC79]  DEFAULT ((0)) FOR [cadiftipcam]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadifuf__06C610B2]  DEFAULT ((0)) FOR [cadifuf]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caclpinici__07BA34EB]  DEFAULT ((0)) FOR [caclpinicial]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caclpfinal__08AE5924]  DEFAULT ((0)) FOR [caclpfinal]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtodifer__09A27D5D]  DEFAULT ((0)) FOR [camtodiferir]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtodeven__0A96A196]  DEFAULT ((0)) FOR [camtodevengar]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadevacum__0B8AC5CF]  DEFAULT ((0)) FOR [cadevacum]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catipcamva__0C7EEA08]  DEFAULT ((0)) FOR [catipcamval]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtoliq__0D730E41]  DEFAULT ((0)) FOR [camtoliq]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtocalza__0E67327A]  DEFAULT ((0)) FOR [camtocalzado]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__calock__0F5B56B3]  DEFAULT (' ') FOR [calock]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camarktoma__104F7AEC]  DEFAULT ((0)) FOR [camarktomarket]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capreciomt__11439F25]  DEFAULT ((0)) FOR [capreciomtm]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capreciofw__1237C35E]  DEFAULT ((0)) FOR [capreciofwd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon1i__132BE797]  DEFAULT ((0)) FOR [camtomon1ini]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon1f__14200BD0]  DEFAULT ((0)) FOR [camtomon1fin]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon2i__15143009]  DEFAULT ((0)) FOR [camtomon2ini]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtomon2f__16085442]  DEFAULT ((0)) FOR [camtomon2fin]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caplazoope__16FC787B]  DEFAULT ((0)) FOR [caplazoope]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caplazovto__17F09CB4]  DEFAULT ((0)) FOR [caplazovto]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caplazocal__18E4C0ED]  DEFAULT ((0)) FOR [caplazocal]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadiasdev__19D8E526]  DEFAULT ((0)) FOR [cadiasdev]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadelusd__1ACD095F]  DEFAULT ((0)) FOR [cadelusd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cadeluf__1BC12D98]  DEFAULT ((0)) FOR [cadeluf]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__carevusd__1CB551D1]  DEFAULT ((0)) FOR [carevusd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__carevuf__1DA9760A]  DEFAULT ((0)) FOR [carevuf]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__carevtot__1E9D9A43]  DEFAULT ((0)) FOR [carevtot]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cavalordia__1F91BE7C]  DEFAULT ((0)) FOR [cavalordia]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cactacambi__2085E2B5]  DEFAULT ((0)) FOR [cactacambio_a]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cactacambi__217A06EE]  DEFAULT ((0)) FOR [cactacambio_c]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cautildife__226E2B27]  DEFAULT ((0)) FOR [cautildiferir]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caperddife__23624F60]  DEFAULT ((0)) FOR [caperddiferir]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cautildeve__24567399]  DEFAULT ((0)) FOR [cautildevenga]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caperddeve__254A97D2]  DEFAULT ((0)) FOR [caperddevenga]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cautilacum__263EBC0B]  DEFAULT ((0)) FOR [cautilacum]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caperdacum__2732E044]  DEFAULT ((0)) FOR [caperdacum]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cautilsald__2827047D]  DEFAULT ((0)) FOR [cautilsaldo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caperdsald__291B28B6]  DEFAULT ((0)) FOR [caperdsaldo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caclpmoned__2A0F4CEF]  DEFAULT ((0)) FOR [caclpmoneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caclpmoned__2B037128]  DEFAULT ((0)) FOR [caclpmoneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camtocomp__2BF79561]  DEFAULT ((0)) FOR [camtocomp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__caantici__2CEBB99A]  DEFAULT (' ') FOR [caantici]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafecvenor__2DDFDDD3]  DEFAULT (' ') FOR [cafecvenor]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cabroker__2ED4020C]  DEFAULT ((0)) FOR [cabroker]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cafecmod__2FC82645]  DEFAULT (' ') FOR [cafecmod]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cavaloraye__30BC4A7E]  DEFAULT ((0)) FOR [cavalorayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camontopfe__31B06EB7]  DEFAULT ((0)) FOR [camontopfe]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__camontocce__32A492F0]  DEFAULT ((0)) FOR [camontocce]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__id_sistema__3398B729]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__precio_tra__348CDB62]  DEFAULT ((0)) FOR [precio_transferencia]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tipo_sinte__3580FF9B]  DEFAULT (' ') FOR [tipo_sintetico]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__precio_spo__367523D4]  DEFAULT ((0)) FOR [precio_spot]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pais_orige__3769480D]  DEFAULT ((0)) FOR [pais_origen]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__moneda_com__385D6C46]  DEFAULT ((0)) FOR [moneda_compensacion]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__riesgo_sin__3951907F]  DEFAULT (' ') FOR [riesgo_sintetico]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__precio_rev__3A45B4B8]  DEFAULT ((0)) FOR [precio_reversa_sintetico]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__calzada__3B39D8F1]  DEFAULT (' ') FOR [calzada]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__marca__3C2DFD2A]  DEFAULT (' ') FOR [marca]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__numerointe__3D222163]  DEFAULT (' ') FOR [numerointerfaz]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__contrato_e__3E16459C]  DEFAULT (' ') FOR [contrato_entrega_via]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__contrato_e__3F0A69D5]  DEFAULT (' ') FOR [contrato_emitido_por]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__contrato_u__3FFE8E0E]  DEFAULT (' ') FOR [contrato_ubicado_en]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__fechaemisi__40F2B247]  DEFAULT (' ') FOR [fechaemision]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__fecharecep__41E6D680]  DEFAULT (' ') FOR [fecharecepcion]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__fechaingre__42DAFAB9]  DEFAULT (' ') FOR [fechaingresocustodia]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__fechafirma__43CF1EF2]  DEFAULT (' ') FOR [fechafirmacontrato]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__fecharetir__44C3432B]  DEFAULT (' ') FOR [fecharetirocustodia]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__numerocont__45B76764]  DEFAULT ((0)) FOR [numerocontratocliente]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__capremio__46AB8B9D]  DEFAULT ((0)) FOR [capremio]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__catipopc__479FAFD6]  DEFAULT (' ') FOR [catipopc]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__diferido_u__4893D40F]  DEFAULT ((0)) FOR [diferido_usd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__diferido_c__4987F848]  DEFAULT ((0)) FOR [diferido_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ac__4A7C1C81]  DEFAULT ((0)) FOR [devengo_acum_usd_hoy]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ac__4B7040BA]  DEFAULT ((0)) FOR [devengo_acum_cnv_hoy]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ac__4C6464F3]  DEFAULT ((0)) FOR [devengo_acum_usd_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ac__4D58892C]  DEFAULT ((0)) FOR [devengo_acum_cnv_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_dife__4E4CAD65]  DEFAULT ((0)) FOR [pesos_diferido_usd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_dife__4F40D19E]  DEFAULT ((0)) FOR [pesos_diferido_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__5034F5D7]  DEFAULT ((0)) FOR [pesos_devengo_usd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__51291A10]  DEFAULT ((0)) FOR [pesos_devengo_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__521D3E49]  DEFAULT ((0)) FOR [pesos_devengo_acum_usd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__53116282]  DEFAULT ((0)) FOR [pesos_devengo_acum_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__540586BB]  DEFAULT ((0)) FOR [pesos_devengo_saldo_usd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__pesos_deve__54F9AAF4]  DEFAULT ((0)) FOR [pesos_devengo_saldo_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__valor_actu__55EDCF2D]  DEFAULT ((0)) FOR [valor_actual_cnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tc_calculo__56E1F366]  DEFAULT ((0)) FOR [tc_calculo_mes_actual]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tc_calculo__57D6179F]  DEFAULT ((0)) FOR [tc_calculo_mes_anterior]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__mtm_hoy_mo__58CA3BD8]  DEFAULT ((0)) FOR [mtm_hoy_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__mtm_hoy_mo__59BE6011]  DEFAULT ((0)) FOR [mtm_hoy_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__var_moneda__5AB2844A]  DEFAULT ((0)) FOR [var_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__var_moneda__5BA6A883]  DEFAULT ((0)) FOR [var_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tasa_mtm_m__5C9ACCBC]  DEFAULT ((0)) FOR [tasa_mtm_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tasa_mtm_m__5D8EF0F5]  DEFAULT ((0)) FOR [tasa_mtm_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tasa_var_m__5E83152E]  DEFAULT ((0)) FOR [tasa_var_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__tasa_var_m__5F773967]  DEFAULT ((0)) FOR [tasa_var_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__efecto_cam__606B5DA0]  DEFAULT ((0)) FOR [efecto_cambio_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__efecto_cam__615F81D9]  DEFAULT ((0)) FOR [efecto_cambio_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ta__6253A612]  DEFAULT ((0)) FOR [devengo_tasa_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__devengo_ta__6347CA4B]  DEFAULT ((0)) FOR [devengo_tasa_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cambio_tas__643BEE84]  DEFAULT ((0)) FOR [cambio_tasa_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cambio_tas__653012BD]  DEFAULT ((0)) FOR [cambio_tasa_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__residuo__662436F6]  DEFAULT ((0)) FOR [residuo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__mtm_ayer_m__67185B2F]  DEFAULT ((0)) FOR [mtm_ayer_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__mtm_ayer_m__680C7F68]  DEFAULT ((0)) FOR [mtm_ayer_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF__mfca_eval__cahora__6900A3A1]  DEFAULT ('') FOR [cahora]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_capreciopunta]  DEFAULT ((0)) FOR [capreciopunta]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caremunera_linea]  DEFAULT ((0)) FOR [caremunera_linea]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caplazo_uso_moneda1]  DEFAULT ((0)) FOR [caplazo_uso_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caplazo_uso_moneda2]  DEFAULT ((0)) FOR [caplazo_uso_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caobservlin]  DEFAULT (' ') FOR [caobservlin]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caobservlim]  DEFAULT (' ') FOR [caobservlim]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_caautoriza]  DEFAULT (' ') FOR [caautoriza]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_catasa_efectiva_moneda1]  DEFAULT ((0)) FOR [catasa_efectiva_moneda1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_catasa_efectiva_moneda2]  DEFAULT ((0)) FOR [catasa_efectiva_moneda2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [cautilacum_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caperdacum_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [carevusd_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [carevuf_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [carevtot_ayer]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [catasaEfectMon1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [catasaEfectMon2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [catipcamSpot]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [catipcamFwd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [cafecEfectiva]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [fVal_Obtenido]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [fRes_Obtenido]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaTasaSinteticaM1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaTasaSinteticaM2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaPrecioSpotVentaM1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaPrecioSpotVentaM2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaPrecioSpotCompraM1]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((1)) FOR [CaPrecioSpotCompraM2]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_caserie]  DEFAULT ('') FOR [caserie]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_caseriado]  DEFAULT ('N') FOR [caseriado]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_ValorRazonableActivo]  DEFAULT ((0.0)) FOR [ValorRazonableActivo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_ValorRazonablePasivo]  DEFAULT ((0.0)) FOR [ValorRazonablePasivo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0.0)) FOR [catipcamPtosFwd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [cacartera_normativa]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [casubcartera_normativa]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [calibro]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [caArea_Responsable]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntPtosFwd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntPtosCos]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntTasaPlazoRem]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntBase]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntForPagMdaComp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntParContraMda]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntParMdaComp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntFactorContMda]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntMtoMdaComp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntDifCostUnitMerc]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntMTMCost]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntMargenContMda]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntValCLPContMda]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntCorrela]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caAntPreOpEF]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_caOrgCurvaMon]  DEFAULT ('') FOR [caOrgCurvaMon]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_caOrgCurvaCnv]  DEFAULT ('') FOR [caOrgCurvaCnv]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_VrCambio]  DEFAULT ((0)) FOR [VrCambio]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_VrDevengo]  DEFAULT ((0)) FOR [VrDevengo]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_VrTasa]  DEFAULT ((0)) FOR [VrTasa]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_cacosto_usdclp]  DEFAULT ((0.0)) FOR [cacosto_usdclp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_cacosto_mxusd]  DEFAULT ((0.0)) FOR [cacosto_mxusd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_cacosto_mxclp]  DEFAULT ((0.0)) FOR [cacosto_mxclp]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_cafijaTCRef]  DEFAULT ('') FOR [cafijaTCRef]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_cafijaPRRef]  DEFAULT ('') FOR [cafijaPRRef]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [caMtoOriginal]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_caSpotTipCam]  DEFAULT ((0.0)) FOR [caSpotTipCam]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [dfmfca_eval_caSpotParidad]  DEFAULT ((0.0)) FOR [caSpotParidad]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [numerospot]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_Resultado_Mesa]  DEFAULT ((0.0)) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [df_mfca_eval_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaFechaStarting]  DEFAULT ('19000101') FOR [CaFechaStarting]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaFechaFijacionStarting]  DEFAULT ('19000101') FOR [CaFechaFijacionStarting]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaPuntosFwdCierre]  DEFAULT ((0.0)) FOR [CaPuntosFwdCierre]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaPuntosTransfObs]  DEFAULT ((0.0)) FOR [CaPuntosTransfObs]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaPuntosTransfFwd]  DEFAULT ((0.0)) FOR [CaPuntosTransfFwd]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaTasaPriPzoFijObs]  DEFAULT ((0.0)) FOR [CaTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaTasaSecPzoFijObs]  DEFAULT ((0.0)) FOR [CaTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_mfca_eval_CaDelta]  DEFAULT ((0.0)) FOR [CaDelta]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  CONSTRAINT [DF_MFCA_EVAL_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [FechaInicio]
GO
ALTER TABLE [dbo].[MFCA_EVAL] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO

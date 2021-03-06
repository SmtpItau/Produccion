USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfca_log]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfca_log](
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
	[caclpfinal] [numeric](21, 9) NOT NULL,
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
	[capremio] [numeric](21, 4) NOT NULL,
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
	[caprimero] [char](1) NOT NULL,
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
	[cacosto_usdclp] [float] NOT NULL,
	[cacosto_mxusd] [float] NOT NULL,
	[cacosto_mxclp] [float] NOT NULL,
	[cafijaTCRef] [datetime] NOT NULL,
	[cafijaPRRef] [datetime] NOT NULL,
	[caSpotTipCam] [float] NOT NULL,
	[caSpotParidad] [float] NOT NULL,
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
	[Periodicidad] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__canumo__043EA9C2]  DEFAULT (0) FOR [canumoper]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodp__0532CDFB]  DEFAULT (0) FOR [cacodpos1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodm__0626F234]  DEFAULT (0) FOR [cacodmon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacods__071B166D]  DEFAULT (0) FOR [cacodsuc1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodp__080F3AA6]  DEFAULT (0) FOR [cacodpos2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodm__09035EDF]  DEFAULT (0) FOR [cacodmon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodc__09F78318]  DEFAULT (0) FOR [cacodcart]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodi__0AEBA751]  DEFAULT (0) FOR [cacodigo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacodc__0BDFCB8A]  DEFAULT (0) FOR [cacodcli]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catipo__0CD3EFC3]  DEFAULT (' ') FOR [catipoper]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catipm__0DC813FC]  DEFAULT (' ') FOR [catipmoda]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafech__0EBC3835]  DEFAULT (' ') FOR [cafecha]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catipc__0FB05C6E]  DEFAULT (0) FOR [catipcam]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camdau__10A480A7]  DEFAULT (0) FOR [camdausd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__1198A4E0]  DEFAULT (0) FOR [camtomon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caequu__128CC919]  DEFAULT (0) FOR [caequusd1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caequm__1380ED52]  DEFAULT (0) FOR [caequmon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__1475118B]  DEFAULT (0) FOR [camtomon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caequu__156935C4]  DEFAULT (0) FOR [caequusd2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caequm__165D59FD]  DEFAULT (0) FOR [caequmon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caparm__17517E36]  DEFAULT (0) FOR [caparmon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprem__1845A26F]  DEFAULT (0) FOR [capremon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caparm__1939C6A8]  DEFAULT (0) FOR [caparmon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprem__1A2DEAE1]  DEFAULT (0) FOR [capremon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caesta__1B220F1A]  DEFAULT (' ') FOR [caestado]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__careti__1C163353]  DEFAULT (' ') FOR [caretiro]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacont__1D0A578C]  DEFAULT (0) FOR [cacontraparte]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caobse__1DFE7BC5]  DEFAULT (' ') FOR [caobserv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__captac__1EF29FFE]  DEFAULT (0) FOR [captacom]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__captav__1FE6C437]  DEFAULT (0) FOR [captavta]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caspre__20DAE870]  DEFAULT (0) FOR [caspread]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacolm__21CF0CA9]  DEFAULT (0) FOR [cacolmon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacapm__22C330E2]  DEFAULT (0) FOR [cacapmon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasa__23B7551B]  DEFAULT (0) FOR [catasadolar]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasa__24AB7954]  DEFAULT (0) FOR [catasaufclp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprec__259F9D8D]  DEFAULT (0) FOR [caprecal]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caplaz__2693C1C6]  DEFAULT (0) FOR [caplazo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafecv__2787E5FF]  DEFAULT (' ') FOR [cafecvcto]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprea__287C0A38]  DEFAULT (0) FOR [capreant]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cavalp__29702E71]  DEFAULT (0) FOR [cavalpre]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caoper__2A6452AA]  DEFAULT (' ') FOR [caoperador]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasf__2B5876E3]  DEFAULT (0) FOR [catasfwdcmp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasf__2C4C9B1C]  DEFAULT (0) FOR [catasfwdvta]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacalc__2D40BF55]  DEFAULT (0) FOR [cacalcmpdol]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacalc__2E34E38E]  DEFAULT (0) FOR [cacalcmpspr]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacalv__2F2907C7]  DEFAULT (0) FOR [cacalvtadol]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cacalv__301D2C00]  DEFAULT (0) FOR [cacalvtaspr]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasa__31115039]  DEFAULT (0) FOR [catasausd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catasa__32057472]  DEFAULT (0) FOR [catasacon]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadife__32F998AB]  DEFAULT (0) FOR [cadiferen]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafpag__33EDBCE4]  DEFAULT (0) FOR [cafpagomn]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafpag__34E1E11D]  DEFAULT (0) FOR [cafpagomx]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadift__35D60556]  DEFAULT (0) FOR [cadiftipcam]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadifu__36CA298F]  DEFAULT (0) FOR [cadifuf]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caclpi__37BE4DC8]  DEFAULT (0) FOR [caclpinicial]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caclpf__38B27201]  DEFAULT (0) FOR [caclpfinal]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtod__39A6963A]  DEFAULT (0) FOR [camtodiferir]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtod__3A9ABA73]  DEFAULT (0) FOR [camtodevengar]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadeva__3B8EDEAC]  DEFAULT (0) FOR [cadevacum]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catipc__3C8302E5]  DEFAULT (0) FOR [catipcamval]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtol__3D77271E]  DEFAULT (0) FOR [camtoliq]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtoc__3E6B4B57]  DEFAULT (0) FOR [camtocalzado]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__calock__3F5F6F90]  DEFAULT (' ') FOR [calock]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camark__405393C9]  DEFAULT (0) FOR [camarktomarket]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprec__4147B802]  DEFAULT (0) FOR [capreciomtm]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprec__423BDC3B]  DEFAULT (0) FOR [capreciofwd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__43300074]  DEFAULT (0) FOR [camtomon1ini]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__442424AD]  DEFAULT (0) FOR [camtomon1fin]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__451848E6]  DEFAULT (0) FOR [camtomon2ini]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtom__460C6D1F]  DEFAULT (0) FOR [camtomon2fin]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caplaz__47009158]  DEFAULT (0) FOR [caplazoope]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caplaz__47F4B591]  DEFAULT (0) FOR [caplazovto]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caplaz__48E8D9CA]  DEFAULT (0) FOR [caplazocal]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadias__49DCFE03]  DEFAULT (0) FOR [cadiasdev]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadelu__4AD1223C]  DEFAULT (0) FOR [cadelusd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cadelu__4BC54675]  DEFAULT (0) FOR [cadeluf]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__carevu__4CB96AAE]  DEFAULT (0) FOR [carevusd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__carevu__4DAD8EE7]  DEFAULT (0) FOR [carevuf]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__carevt__4EA1B320]  DEFAULT (0) FOR [carevtot]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cavalo__4F95D759]  DEFAULT (0) FOR [cavalordia]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cactac__5089FB92]  DEFAULT (0) FOR [cactacambio_a]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cactac__517E1FCB]  DEFAULT (0) FOR [cactacambio_c]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cautil__52724404]  DEFAULT (0) FOR [cautildiferir]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caperd__5366683D]  DEFAULT (0) FOR [caperddiferir]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cautil__545A8C76]  DEFAULT (0) FOR [cautildevenga]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caperd__554EB0AF]  DEFAULT (0) FOR [caperddevenga]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cautil__5642D4E8]  DEFAULT (0) FOR [cautilacum]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caperd__5736F921]  DEFAULT (0) FOR [caperdacum]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cautil__582B1D5A]  DEFAULT (0) FOR [cautilsaldo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caperd__591F4193]  DEFAULT (0) FOR [caperdsaldo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caclpm__5A1365CC]  DEFAULT (0) FOR [caclpmoneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caclpm__5B078A05]  DEFAULT (0) FOR [caclpmoneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camtoc__5BFBAE3E]  DEFAULT (0) FOR [camtocomp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caanti__5CEFD277]  DEFAULT (' ') FOR [caantici]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafecv__5DE3F6B0]  DEFAULT (' ') FOR [cafecvenor]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cabrok__5ED81AE9]  DEFAULT (0) FOR [cabroker]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cafecm__5FCC3F22]  DEFAULT (' ') FOR [cafecmod]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cavalo__60C0635B]  DEFAULT (0) FOR [cavalorayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camont__61B48794]  DEFAULT (0) FOR [camontopfe]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__camont__62A8ABCD]  DEFAULT (0) FOR [camontocce]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__id_sis__639CD006]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__precio__6490F43F]  DEFAULT (0) FOR [precio_transferencia]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tipo_s__65851878]  DEFAULT (' ') FOR [tipo_sintetico]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__precio__66793CB1]  DEFAULT (0) FOR [precio_spot]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pais_o__676D60EA]  DEFAULT (0) FOR [pais_origen]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__moneda__68618523]  DEFAULT (0) FOR [moneda_compensacion]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__riesgo__6955A95C]  DEFAULT (' ') FOR [riesgo_sintetico]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__precio__6A49CD95]  DEFAULT (0) FOR [precio_reversa_sintetico]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__calzad__6B3DF1CE]  DEFAULT (' ') FOR [calzada]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__marca__6C321607]  DEFAULT (' ') FOR [marca]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__numero__6D263A40]  DEFAULT (' ') FOR [numerointerfaz]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__contra__6E1A5E79]  DEFAULT (' ') FOR [contrato_entrega_via]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__contra__6F0E82B2]  DEFAULT (' ') FOR [contrato_emitido_por]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__contra__7002A6EB]  DEFAULT (' ') FOR [contrato_ubicado_en]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__fechae__70F6CB24]  DEFAULT (' ') FOR [fechaemision]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__fechar__71EAEF5D]  DEFAULT (' ') FOR [fecharecepcion]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__fechai__72DF1396]  DEFAULT (' ') FOR [fechaingresocustodia]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__fechaf__73D337CF]  DEFAULT (' ') FOR [fechafirmacontrato]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__fechar__74C75C08]  DEFAULT (' ') FOR [fecharetirocustodia]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__numero__75BB8041]  DEFAULT (0) FOR [numerocontratocliente]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprem__76AFA47A]  DEFAULT (0) FOR [capremio]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__catipo__77A3C8B3]  DEFAULT (' ') FOR [catipopc]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__diferi__7897ECEC]  DEFAULT (0) FOR [diferido_usd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__diferi__798C1125]  DEFAULT (0) FOR [diferido_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__7A80355E]  DEFAULT (0) FOR [devengo_acum_usd_hoy]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__7B745997]  DEFAULT (0) FOR [devengo_acum_cnv_hoy]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__7C687DD0]  DEFAULT (0) FOR [devengo_acum_usd_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__7D5CA209]  DEFAULT (0) FOR [devengo_acum_cnv_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___7E50C642]  DEFAULT (0) FOR [pesos_diferido_usd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___7F44EA7B]  DEFAULT (0) FOR [pesos_diferido_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___00390EB4]  DEFAULT (0) FOR [pesos_devengo_usd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___012D32ED]  DEFAULT (0) FOR [pesos_devengo_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___02215726]  DEFAULT (0) FOR [pesos_devengo_acum_usd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___03157B5F]  DEFAULT (0) FOR [pesos_devengo_acum_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___04099F98]  DEFAULT (0) FOR [pesos_devengo_saldo_usd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__pesos___04FDC3D1]  DEFAULT (0) FOR [pesos_devengo_saldo_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__valor___05F1E80A]  DEFAULT (0) FOR [valor_actual_cnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tc_cal__06E60C43]  DEFAULT (0) FOR [tc_calculo_mes_actual]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tc_cal__07DA307C]  DEFAULT (0) FOR [tc_calculo_mes_anterior]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__mtm_ho__08CE54B5]  DEFAULT (0) FOR [mtm_hoy_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__mtm_ho__09C278EE]  DEFAULT (0) FOR [mtm_hoy_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__var_mo__0AB69D27]  DEFAULT (0) FOR [var_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__var_mo__0BAAC160]  DEFAULT (0) FOR [var_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tasa_m__0C9EE599]  DEFAULT (0) FOR [tasa_mtm_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tasa_m__0D9309D2]  DEFAULT (0) FOR [tasa_mtm_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tasa_v__0E872E0B]  DEFAULT (0) FOR [tasa_var_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__tasa_v__0F7B5244]  DEFAULT (0) FOR [tasa_var_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__efecto__106F767D]  DEFAULT (0) FOR [efecto_cambio_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__efecto__11639AB6]  DEFAULT (0) FOR [efecto_cambio_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__1257BEEF]  DEFAULT (0) FOR [devengo_tasa_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__deveng__134BE328]  DEFAULT (0) FOR [devengo_tasa_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cambio__14400761]  DEFAULT (0) FOR [cambio_tasa_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cambio__15342B9A]  DEFAULT (0) FOR [cambio_tasa_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__residu__16284FD3]  DEFAULT (0) FOR [residuo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__mtm_ay__171C740C]  DEFAULT (0) FOR [mtm_ayer_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__mtm_ay__18109845]  DEFAULT (0) FOR [mtm_ayer_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__cahora__1904BC7E]  DEFAULT (0) FOR [cahora]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF__mfca_log__caprim__19F8E0B7]  DEFAULT ('N') FOR [caprimero]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_capreciopunta]  DEFAULT (0) FOR [capreciopunta]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caremunera_linea]  DEFAULT (0) FOR [caremunera_linea]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caplazo_uso_moneda1]  DEFAULT (0) FOR [caplazo_uso_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caplazo_uso_moneda2]  DEFAULT (0) FOR [caplazo_uso_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caobservlin]  DEFAULT (' ') FOR [caobservlin]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caobservlim]  DEFAULT (' ') FOR [caobservlim]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_caautoriza]  DEFAULT (' ') FOR [caautoriza]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_catasa_efectiva_moneda1]  DEFAULT (0) FOR [catasa_efectiva_moneda1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_mfca_log_catasa_efectiva_moneda2]  DEFAULT (0) FOR [catasa_efectiva_moneda2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [cautilacum_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caperdacum_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [carevusd_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [carevuf_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [carevtot_ayer]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [catasaEfectMon1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [catasaEfectMon2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [catipcamSpot]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [catipcamFwd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [cafecEfectiva]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [fVal_Obtenido]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [fRes_Obtenido]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaTasaSinteticaM1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaTasaSinteticaM2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaPrecioSpotVentaM1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaPrecioSpotVentaM2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaPrecioSpotCompraM1]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (1) FOR [CaPrecioSpotCompraM2]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_mfcalog_caserie]  DEFAULT ('') FOR [caserie]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_mfcalog_caseriado]  DEFAULT ('N') FOR [caseriado]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_mfca_log_ValorRazonableActivo]  DEFAULT (0.0) FOR [ValorRazonableActivo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_mfca_log_ValorRazonablePasivo]  DEFAULT (0.0) FOR [ValorRazonablePasivo]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0.0) FOR [catipcamPtosFwd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [cacartera_normativa]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [casubcartera_normativa]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [calibro]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [caArea_Responsable]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntPtosFwd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntPtosCos]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntTasaPlazoRem]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntBase]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntForPagMdaComp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntParContraMda]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntParMdaComp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntFactorContMda]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntMtoMdaComp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntDifCostUnitMerc]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntMTMCost]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntMargenContMda]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntValCLPContMda]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntCorrela]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT (0) FOR [caAntPreOpEF]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfMfcaLog_caOrgCurvaMon]  DEFAULT ('') FOR [caOrgCurvaMon]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfMfcaLog_caOrgCurvaCnv]  DEFAULT ('') FOR [caOrgCurvaCnv]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_cacosto_usdclp]  DEFAULT (0.0) FOR [cacosto_usdclp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_cacosto_mxusd]  DEFAULT (0.0) FOR [cacosto_mxusd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_cacosto_mxclp]  DEFAULT (0.0) FOR [cacosto_mxclp]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_cafijaTCRef]  DEFAULT ('') FOR [cafijaTCRef]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_cafijaPRRef]  DEFAULT ('') FOR [cafijaPRRef]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_caSpotTipCam]  DEFAULT (0.0) FOR [caSpotTipCam]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [dfmfcalog_caSpotParidad]  DEFAULT (0.0) FOR [caSpotParidad]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_MFCA_LOG_Resultado_Mesa]  DEFAULT (0.0) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [df_MFCA_LOG_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaFechaStarting]  DEFAULT ('19000101') FOR [CaFechaStarting]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaFechaFijacionStarting]  DEFAULT ('19000101') FOR [CaFechaFijacionStarting]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaPuntosFwdCierre]  DEFAULT (0.0) FOR [CaPuntosFwdCierre]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaPuntosTransfObs]  DEFAULT (0.0) FOR [CaPuntosTransfObs]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaPuntosTransfFwd]  DEFAULT (0.0) FOR [CaPuntosTransfFwd]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaTasaPriPzoFijObs]  DEFAULT (0.0) FOR [CaTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaTasaSecPzoFijObs]  DEFAULT (0.0) FOR [CaTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_LOG_CaDelta]  DEFAULT (0.0) FOR [CaDelta]
GO
ALTER TABLE [dbo].[mfca_log] ADD  CONSTRAINT [DF_MFCA_log_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[mfca_log] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO

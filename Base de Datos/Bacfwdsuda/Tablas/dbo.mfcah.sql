USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfcah]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfcah](
	[cafecproc] [datetime] NOT NULL,
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
	[capreciofwd] [numeric](21, 4) NOT NULL,
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
	[camtocomp] [numeric](21, 0) NOT NULL,
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
	[caobervlim] [char](255) NOT NULL,
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
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafecproc__6AE8EC13]  DEFAULT (0) FOR [cafecproc]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__canumoper__6BDD104C]  DEFAULT (0) FOR [canumoper]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodpos1__6CD13485]  DEFAULT (0) FOR [cacodpos1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodmon1__6DC558BE]  DEFAULT (0) FOR [cacodmon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodsuc1__6EB97CF7]  DEFAULT (0) FOR [cacodsuc1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodpos2__6FADA130]  DEFAULT (0) FOR [cacodpos2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodmon2__70A1C569]  DEFAULT (0) FOR [cacodmon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodcart__7195E9A2]  DEFAULT (0) FOR [cacodcart]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodigo__728A0DDB]  DEFAULT (0) FOR [cacodigo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacodcli__737E3214]  DEFAULT (0) FOR [cacodcli]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catipoper__7472564D]  DEFAULT (' ') FOR [catipoper]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catipmoda__75667A86]  DEFAULT (' ') FOR [catipmoda]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafecha__765A9EBF]  DEFAULT (' ') FOR [cafecha]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catipcam__774EC2F8]  DEFAULT (0) FOR [catipcam]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camdausd__7842E731]  DEFAULT (0) FOR [camdausd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon1__79370B6A]  DEFAULT (0) FOR [camtomon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caequusd1__7A2B2FA3]  DEFAULT (0) FOR [caequusd1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caequmon1__7B1F53DC]  DEFAULT (0) FOR [caequmon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon2__7C137815]  DEFAULT (0) FOR [camtomon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caequusd2__7D079C4E]  DEFAULT (0) FOR [caequusd2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caequmon2__7DFBC087]  DEFAULT (0) FOR [caequmon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caparmon1__7EEFE4C0]  DEFAULT (0) FOR [caparmon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capremon1__7FE408F9]  DEFAULT (0) FOR [capremon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caparmon2__00D82D32]  DEFAULT (0) FOR [caparmon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capremon2__01CC516B]  DEFAULT (0) FOR [capremon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caestado__02C075A4]  DEFAULT (' ') FOR [caestado]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caretiro__03B499DD]  DEFAULT (' ') FOR [caretiro]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacontrap__04A8BE16]  DEFAULT (0) FOR [cacontraparte]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caobserv__059CE24F]  DEFAULT (' ') FOR [caobserv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__captacom__06910688]  DEFAULT (0) FOR [captacom]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__captavta__07852AC1]  DEFAULT (0) FOR [captavta]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caspread__08794EFA]  DEFAULT (0) FOR [caspread]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacolmon1__096D7333]  DEFAULT (0) FOR [cacolmon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacapmon1__0A61976C]  DEFAULT (0) FOR [cacapmon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasadol__0B55BBA5]  DEFAULT (0) FOR [catasadolar]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasaufc__0C49DFDE]  DEFAULT (0) FOR [catasaufclp]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caprecal__0D3E0417]  DEFAULT (0) FOR [caprecal]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caplazo__0E322850]  DEFAULT (0) FOR [caplazo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafecvcto__0F264C89]  DEFAULT (' ') FOR [cafecvcto]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capreant__101A70C2]  DEFAULT (0) FOR [capreant]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cavalpre__110E94FB]  DEFAULT (0) FOR [cavalpre]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caoperado__1202B934]  DEFAULT (' ') FOR [caoperador]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasfwdc__12F6DD6D]  DEFAULT (0) FOR [catasfwdcmp]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasfwdv__13EB01A6]  DEFAULT (0) FOR [catasfwdvta]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacalcmpd__14DF25DF]  DEFAULT (0) FOR [cacalcmpdol]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacalcmps__15D34A18]  DEFAULT (0) FOR [cacalcmpspr]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacalvtad__16C76E51]  DEFAULT (0) FOR [cacalvtadol]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cacalvtas__17BB928A]  DEFAULT (0) FOR [cacalvtaspr]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasausd__18AFB6C3]  DEFAULT (0) FOR [catasausd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catasacon__19A3DAFC]  DEFAULT (0) FOR [catasacon]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadiferen__1A97FF35]  DEFAULT (0) FOR [cadiferen]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafpagomn__1B8C236E]  DEFAULT (0) FOR [cafpagomn]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafpagomx__1C8047A7]  DEFAULT (0) FOR [cafpagomx]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadiftipc__1D746BE0]  DEFAULT (0) FOR [cadiftipcam]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadifuf__1E689019]  DEFAULT (0) FOR [cadifuf]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caclpinic__1F5CB452]  DEFAULT (0) FOR [caclpinicial]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caclpfina__2050D88B]  DEFAULT (0) FOR [caclpfinal]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtodife__2144FCC4]  DEFAULT (0) FOR [camtodiferir]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtodeve__223920FD]  DEFAULT (0) FOR [camtodevengar]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadevacum__232D4536]  DEFAULT (0) FOR [cadevacum]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catipcamv__2421696F]  DEFAULT (0) FOR [catipcamval]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtoliq__25158DA8]  DEFAULT (0) FOR [camtoliq]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtocalz__2609B1E1]  DEFAULT (0) FOR [camtocalzado]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__calock__26FDD61A]  DEFAULT (' ') FOR [calock]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camarktom__27F1FA53]  DEFAULT (0) FOR [camarktomarket]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capreciom__28E61E8C]  DEFAULT (0) FOR [capreciomtm]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capreciof__29DA42C5]  DEFAULT (0) FOR [capreciofwd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon1__2ACE66FE]  DEFAULT (0) FOR [camtomon1ini]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon1__2BC28B37]  DEFAULT (0) FOR [camtomon1fin]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon2__2CB6AF70]  DEFAULT (0) FOR [camtomon2ini]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtomon2__2DAAD3A9]  DEFAULT (0) FOR [camtomon2fin]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caplazoop__2E9EF7E2]  DEFAULT (0) FOR [caplazoope]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caplazovt__2F931C1B]  DEFAULT (0) FOR [caplazovto]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caplazoca__30874054]  DEFAULT (0) FOR [caplazocal]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadiasdev__317B648D]  DEFAULT (0) FOR [cadiasdev]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadelusd__326F88C6]  DEFAULT (0) FOR [cadelusd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cadeluf__3363ACFF]  DEFAULT (0) FOR [cadeluf]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__carevusd__3457D138]  DEFAULT (0) FOR [carevusd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__carevuf__354BF571]  DEFAULT (0) FOR [carevuf]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__carevtot__364019AA]  DEFAULT (0) FOR [carevtot]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cavalordi__37343DE3]  DEFAULT (0) FOR [cavalordia]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cactacamb__3828621C]  DEFAULT (0) FOR [cactacambio_a]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cactacamb__391C8655]  DEFAULT (0) FOR [cactacambio_c]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cautildif__3A10AA8E]  DEFAULT (0) FOR [cautildiferir]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caperddif__3B04CEC7]  DEFAULT (0) FOR [caperddiferir]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cautildev__3BF8F300]  DEFAULT (0) FOR [cautildevenga]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caperddev__3CED1739]  DEFAULT (0) FOR [caperddevenga]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cautilacu__3DE13B72]  DEFAULT (0) FOR [cautilacum]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caperdacu__3ED55FAB]  DEFAULT (0) FOR [caperdacum]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cautilsal__3FC983E4]  DEFAULT (0) FOR [cautilsaldo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caperdsal__40BDA81D]  DEFAULT (0) FOR [caperdsaldo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caclpmone__41B1CC56]  DEFAULT (0) FOR [caclpmoneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caclpmone__42A5F08F]  DEFAULT (0) FOR [caclpmoneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camtocomp__439A14C8]  DEFAULT (0) FOR [camtocomp]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__caantici__448E3901]  DEFAULT (' ') FOR [caantici]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafecveno__45825D3A]  DEFAULT (' ') FOR [cafecvenor]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cabroker__46768173]  DEFAULT (0) FOR [cabroker]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cafecmod__476AA5AC]  DEFAULT (' ') FOR [cafecmod]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cavaloray__485EC9E5]  DEFAULT (0) FOR [cavalorayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camontopf__4952EE1E]  DEFAULT (0) FOR [camontopfe]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__camontocc__4A471257]  DEFAULT (0) FOR [camontocce]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__id_sistem__4B3B3690]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__precio_tr__4C2F5AC9]  DEFAULT (0) FOR [precio_transferencia]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tipo_sint__4D237F02]  DEFAULT (' ') FOR [tipo_sintetico]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__precio_sp__4E17A33B]  DEFAULT (0) FOR [precio_spot]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pais_orig__4F0BC774]  DEFAULT (0) FOR [pais_origen]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__moneda_co__4FFFEBAD]  DEFAULT (0) FOR [moneda_compensacion]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__riesgo_si__50F40FE6]  DEFAULT (' ') FOR [riesgo_sintetico]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__precio_re__51E8341F]  DEFAULT (0) FOR [precio_reversa_sintetico]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__calzada__52DC5858]  DEFAULT (' ') FOR [calzada]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__marca__53D07C91]  DEFAULT (' ') FOR [marca]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__numeroint__54C4A0CA]  DEFAULT (' ') FOR [numerointerfaz]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__contrato___55B8C503]  DEFAULT (' ') FOR [contrato_entrega_via]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__contrato___56ACE93C]  DEFAULT (' ') FOR [contrato_emitido_por]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__contrato___57A10D75]  DEFAULT (' ') FOR [contrato_ubicado_en]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__fechaemis__589531AE]  DEFAULT (' ') FOR [fechaemision]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__fecharece__598955E7]  DEFAULT (' ') FOR [fecharecepcion]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__fechaingr__5A7D7A20]  DEFAULT (' ') FOR [fechaingresocustodia]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__fechafirm__5B719E59]  DEFAULT (' ') FOR [fechafirmacontrato]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__fechareti__5C65C292]  DEFAULT (' ') FOR [fecharetirocustodia]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__numerocon__5D59E6CB]  DEFAULT (0) FOR [numerocontratocliente]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__capremio__5E4E0B04]  DEFAULT (0) FOR [capremio]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__catipopc__5F422F3D]  DEFAULT (' ') FOR [catipopc]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__diferido___60365376]  DEFAULT (0) FOR [diferido_usd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__diferido___612A77AF]  DEFAULT (0) FOR [diferido_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_a__621E9BE8]  DEFAULT (0) FOR [devengo_acum_usd_hoy]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_a__6312C021]  DEFAULT (0) FOR [devengo_acum_cnv_hoy]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_a__6406E45A]  DEFAULT (0) FOR [devengo_acum_usd_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_a__64FB0893]  DEFAULT (0) FOR [devengo_acum_cnv_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dif__65EF2CCC]  DEFAULT (0) FOR [pesos_diferido_usd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dif__66E35105]  DEFAULT (0) FOR [pesos_diferido_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__67D7753E]  DEFAULT (0) FOR [pesos_devengo_usd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__68CB9977]  DEFAULT (0) FOR [pesos_devengo_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__69BFBDB0]  DEFAULT (0) FOR [pesos_devengo_acum_usd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__6AB3E1E9]  DEFAULT (0) FOR [pesos_devengo_acum_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__6BA80622]  DEFAULT (0) FOR [pesos_devengo_saldo_usd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__pesos_dev__6C9C2A5B]  DEFAULT (0) FOR [pesos_devengo_saldo_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__valor_act__6D904E94]  DEFAULT (0) FOR [valor_actual_cnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tc_calcul__6E8472CD]  DEFAULT (0) FOR [tc_calculo_mes_actual]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tc_calcul__6F789706]  DEFAULT (0) FOR [tc_calculo_mes_anterior]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__mtm_hoy_m__706CBB3F]  DEFAULT (0) FOR [mtm_hoy_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__mtm_hoy_m__7160DF78]  DEFAULT (0) FOR [mtm_hoy_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__var_moned__725503B1]  DEFAULT (0) FOR [var_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__var_moned__734927EA]  DEFAULT (0) FOR [var_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tasa_mtm___743D4C23]  DEFAULT (0) FOR [tasa_mtm_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tasa_mtm___7531705C]  DEFAULT (0) FOR [tasa_mtm_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tasa_var___76259495]  DEFAULT (0) FOR [tasa_var_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__tasa_var___7719B8CE]  DEFAULT (0) FOR [tasa_var_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__efecto_ca__780DDD07]  DEFAULT (0) FOR [efecto_cambio_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__efecto_ca__79020140]  DEFAULT (0) FOR [efecto_cambio_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_t__79F62579]  DEFAULT (0) FOR [devengo_tasa_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__devengo_t__7AEA49B2]  DEFAULT (0) FOR [devengo_tasa_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cambio_ta__7BDE6DEB]  DEFAULT (0) FOR [cambio_tasa_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cambio_ta__7CD29224]  DEFAULT (0) FOR [cambio_tasa_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__residuo__7DC6B65D]  DEFAULT (0) FOR [residuo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__mtm_ayer___7EBADA96]  DEFAULT (0) FOR [mtm_ayer_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__mtm_ayer___7FAEFECF]  DEFAULT (0) FOR [mtm_ayer_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF__mfcah__cahora__00A32308]  DEFAULT ('') FOR [cahora]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_capreciopunta]  DEFAULT (0) FOR [capreciopunta]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caremunera_linea]  DEFAULT (0) FOR [caremunera_linea]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caplazo_uso_moneda1]  DEFAULT (0) FOR [caplazo_uso_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caplazo_uso_moneda2]  DEFAULT (0) FOR [caplazo_uso_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caobservlin]  DEFAULT (' ') FOR [caobservlin]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caobervlim]  DEFAULT (' ') FOR [caobervlim]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_caautoriza]  DEFAULT (' ') FOR [caautoriza]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_catasa_efectiva_moneda1]  DEFAULT (0) FOR [catasa_efectiva_moneda1]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_mfcah_catasa_efectiva_moneda2]  DEFAULT (0) FOR [catasa_efectiva_moneda2]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [cautilacum_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [caperdacum_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [carevusd_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [carevuf_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [carevtot_ayer]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [catasaEfectMon1]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [catasaEfectMon2]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [catipcamSpot]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [catipcamFwd]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [cafecEfectiva]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [fVal_Obtenido]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0) FOR [fRes_Obtenido]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaTasaSinteticaM1]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaTasaSinteticaM2]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaPrecioSpotVentaM1]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaPrecioSpotVentaM2]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaPrecioSpotCompraM1]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (1) FOR [CaPrecioSpotCompraM2]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_mfcah_caserie]  DEFAULT ('') FOR [caserie]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_mfcah_caseriado]  DEFAULT ('N') FOR [caseriado]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_mfcah_ValorRazonableActivo]  DEFAULT (0.0) FOR [ValorRazonableActivo]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_mfcah_ValorRazonablePasivo]  DEFAULT (0.0) FOR [ValorRazonablePasivo]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT (0.0) FOR [catipcamPtosFwd]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [cacartera_normativa]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [casubcartera_normativa]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [calibro]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [caArea_Responsable]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfMfcaH_caOrgCurvaMon]  DEFAULT ('') FOR [caOrgCurvaMon]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfMfcaH_caOrgCurvaCnv]  DEFAULT ('') FOR [caOrgCurvaCnv]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_cacosto_usdclp]  DEFAULT (0.0) FOR [cacosto_usdclp]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_cacosto_mxusd]  DEFAULT (0.0) FOR [cacosto_mxusd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_cacosto_mxclp]  DEFAULT (0.0) FOR [cacosto_mxclp]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_cafijaTCRef]  DEFAULT ('') FOR [cafijaTCRef]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_cafijaPRRef]  DEFAULT ('') FOR [cafijaPRRef]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_caSpotTipCam]  DEFAULT (0.0) FOR [caSpotTipCam]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [dfmfcah_caSpotParidad]  DEFAULT (0.0) FOR [caSpotParidad]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_MFCAH_Resultado_Mesa]  DEFAULT (0.0) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [df_MFCAH_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaFechaStarting]  DEFAULT ('19000101') FOR [CaFechaStarting]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaFechaFijacionStarting]  DEFAULT ('19000101') FOR [CaFechaFijacionStarting]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaPuntosFwdCierre]  DEFAULT (0.0) FOR [CaPuntosFwdCierre]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaPuntosTransfObs]  DEFAULT (0.0) FOR [CaPuntosTransfObs]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaPuntosTransfFwd]  DEFAULT (0.0) FOR [CaPuntosTransfFwd]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaTasaPriPzoFijObs]  DEFAULT (0.0) FOR [CaTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaTasaSecPzoFijObs]  DEFAULT (0.0) FOR [CaTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_CaDelta]  DEFAULT (0.0) FOR [CaDelta]
GO
ALTER TABLE [dbo].[mfcah] ADD  CONSTRAINT [DF_MFCAH_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[mfcah] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO

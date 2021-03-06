USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MFCARES]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MFCARES](
	[CaFechaProceso] [datetime] NULL,
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
	[VrCambioParPrx] [float] NOT NULL,
	[VrDevengoParPrx] [float] NOT NULL,
	[VrTasaParPrx] [float] NOT NULL,
	[fRes_ObtenidoParPrx] [float] NOT NULL,
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
	[Periodicidad] [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT ('') FOR [estado_sinacofi]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT ('') FOR [fecha_estado_sina]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntPtosFwd]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntPtosCos]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntTasaPlazoRem]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntBase]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntForPagMdaComp]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntParContraMda]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntParMdaComp]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntFactorContMda]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntMtoMdaComp]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntDifCostUnitMerc]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntMTMCost]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntMargenContMda]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntValCLPContMda]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntCorrela]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [caAntPreOpEF]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfMfcaRes_caOrgCurvaMon]  DEFAULT ('') FOR [caOrgCurvaMon]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfMfcaRes_caOrgCurvaCnv]  DEFAULT ('') FOR [caOrgCurvaCnv]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrCambio]  DEFAULT (0) FOR [VrCambio]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrDevengo]  DEFAULT (0) FOR [VrDevengo]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrTasa]  DEFAULT (0) FOR [VrTasa]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrCambioParPrx]  DEFAULT (0) FOR [VrCambioParPrx]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrDevengoParPrx]  DEFAULT (0) FOR [VrDevengoParPrx]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_VrTasaParPrx]  DEFAULT (0) FOR [VrTasaParPrx]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_fRes_ObtenidoParPrx]  DEFAULT (0) FOR [fRes_ObtenidoParPrx]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_cacosto_usdclp]  DEFAULT (0.0) FOR [cacosto_usdclp]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_cacosto_mxusd]  DEFAULT (0.0) FOR [cacosto_mxusd]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_cacosto_mxclp]  DEFAULT (0.0) FOR [cacosto_mxclp]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_cafijaTCRef]  DEFAULT ('') FOR [cafijaTCRef]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_cafijaPRRef]  DEFAULT ('') FOR [cafijaPRRef]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [CT_camtooriginal_res]  DEFAULT (0) FOR [caMtoOriginal]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_caSpotTipCam]  DEFAULT (0.0) FOR [caSpotTipCam]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [dfmfcares_caSpotParidad]  DEFAULT (0.0) FOR [caSpotParidad]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT (0) FOR [numerospot]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_Resultado_Mesa]  DEFAULT (0.0) FOR [Resultado_Mesa]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [df_MFCARES_Threshold]  DEFAULT ('') FOR [Threshold]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaFechaStarting]  DEFAULT ('19000101') FOR [CaFechaStarting]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaFechaFijacionStarting]  DEFAULT ('19000101') FOR [CaFechaFijacionStarting]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaPuntosFwdCierre]  DEFAULT (0.0) FOR [CaPuntosFwdCierre]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaPuntosTransfObs]  DEFAULT (0.0) FOR [CaPuntosTransfObs]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaPuntosTransfFwd]  DEFAULT (0.0) FOR [CaPuntosTransfFwd]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaTasaPriPzoFijObs]  DEFAULT (0.0) FOR [CaTasaPriPzoFijObs]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaTasaSecPzoFijObs]  DEFAULT (0.0) FOR [CaTasaSecPzoFijObs]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_CaDelta]  DEFAULT (0.0) FOR [CaDelta]
GO
ALTER TABLE [dbo].[MFCARES] ADD  CONSTRAINT [DF_MFCARES_bEarlyTermination]  DEFAULT ((0)) FOR [bEarlyTermination]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT ('1900-01-01') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[MFCARES] ADD  DEFAULT ((0)) FOR [Periodicidad]
GO

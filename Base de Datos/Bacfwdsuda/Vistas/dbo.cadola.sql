USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[cadola]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create view [dbo].[cadola]
as 

select '20100602' as CaFechaProceso,canumoper,cacodpos1,cacodmon1,cacodsuc1,cacodpos2,cacodmon2,cacodcart,cacodigo,cacodcli,catipoper,catipmoda,cafecha,catipcam,camdausd,camtomon1,caequusd1,caequmon1,camtomon2,caequusd2,caequmon2,caparmon1,capremon1,caparmon2,capremon2,caestado,caretiro,cacontraparte,caobserv,captacom,captavta,caspread,cacolmon1,cacapmon1,catasadolar,catasaufclp,caprecal,caplazo,'20100703'  as cafecvcto,capreant,cavalpre,caoperador,catasfwdcmp,catasfwdvta,cacalcmpdol,cacalcmpspr,cacalvtadol,cacalvtaspr,catasausd,catasacon,cadiferen,cafpagomn,cafpagomx,cadiftipcam,cadifuf,caclpinicial,caclpfinal,camtodiferir,camtodevengar,cadevacum,catipcamval,camtoliq,camtocalzado,calock,camarktomarket,capreciomtm,capreciofwd,camtomon1ini,camtomon1fin,camtomon2ini,camtomon2fin,caplazoope,caplazovto,caplazocal,cadiasdev,cadelusd,cadeluf,carevusd,carevuf,carevtot,cavalordia,cactacambio_a,cactacambio_c,cautildiferir,caperddiferir,cautildevenga,caperddevenga,cautilacum,caperdacum,cautilsaldo,caperdsaldo,caclpmoneda1,caclpmoneda2,camtocomp,caantici,cafecvenor,cabroker,cafecmod,cavalorayer,camontopfe,camontocce,id_sistema,precio_transferencia,tipo_sintetico,precio_spot,pais_origen,moneda_compensacion,riesgo_sintetico,precio_reversa_sintetico,calzada,marca,numerointerfaz,contrato_entrega_via,contrato_emitido_por,contrato_ubicado_en,fechaemision,fecharecepcion,fechaingresocustodia,fechafirmacontrato,fecharetirocustodia,numerocontratocliente,capremio,catipopc,diferido_usd,diferido_cnv,devengo_acum_usd_hoy,devengo_acum_cnv_hoy,devengo_acum_usd_ayer,devengo_acum_cnv_ayer,pesos_diferido_usd,pesos_diferido_cnv,pesos_devengo_usd,pesos_devengo_cnv,pesos_devengo_acum_usd,pesos_devengo_acum_cnv,pesos_devengo_saldo_usd,pesos_devengo_saldo_cnv,valor_actual_cnv,tc_calculo_mes_actual,tc_calculo_mes_anterior,mtm_hoy_moneda1,mtm_hoy_moneda2,var_moneda1,var_moneda2,tasa_mtm_moneda1,tasa_mtm_moneda2,tasa_var_moneda1,tasa_var_moneda2,efecto_cambio_moneda1,efecto_cambio_moneda2,devengo_tasa_moneda1,devengo_tasa_moneda2,cambio_tasa_moneda1,cambio_tasa_moneda2,residuo,mtm_ayer_moneda1,mtm_ayer_moneda2,cahora,capreciopunta,caremunera_linea,caplazo_uso_moneda1,caplazo_uso_moneda2,caobservlin,caobservlim,caautoriza,catasa_efectiva_moneda1,catasa_efectiva_moneda2,cautilacum_ayer,caperdacum_ayer,carevusd_ayer,carevuf_ayer,carevtot_ayer,caoperrelaspot,catasaEfectMon1,catasaEfectMon2,catipcamSpot,catipcamFwd,cafecEfectiva,fVal_Obtenido,fRes_Obtenido,CaTasaSinteticaM1,CaTasaSinteticaM2,CaPrecioSpotVentaM1,CaPrecioSpotVentaM2,CaPrecioSpotCompraM1,CaPrecioSpotCompraM2,caserie,caseriado,ValorRazonableActivo,ValorRazonablePasivo,catipcamPtosFwd,cacartera_normativa,casubcartera_normativa,calibro,caArea_Responsable,estado_sinacofi,fecha_estado_sina,caAntPtosFwd,caAntPtosCos,caAntTasaPlazoRem,caAntBase,caAntForPagMdaComp,caAntParContraMda,caAntParMdaComp,caAntFactorContMda,caAntMtoMdaComp,caAntDifCostUnitMerc,caAntMTMCost,caAntMargenContMda,caAntValCLPContMda,caAntCorrela,caAntPreOpEF,caOrgCurvaMon,caOrgCurvaCnv,VrCambio,VrDevengo,VrTasa,VrCambioParPrx,VrDevengoParPrx,VrTasaParPrx,fRes_ObtenidoParPrx,cacosto_usdclp,cacosto_mxusd,cacosto_mxclp,cafijaTCRef,cafijaPRRef,caMtoOriginal,caSpotTipCam,caSpotParidad
,numerospot
,Resultado_Mesa
,'S' as Threshold
,getdate() as CaFechaStarting
,getdate() as CaFechaFijacionStarting
,0.00 as CaPuntosFwdCierre
,0.00 as CaPuntosTransfObs
,0.00 as CaPuntosTransfFwd
,0.00 as CaTasaPriPzoFijObs
,0.00 as CaTasaSecPzoFijObs
,0.00 as CaDelta
from mfcaRES
WHERE CAFECHAPROCESO='20100602' AND CANUMOPER 
IN (30586,
30587,
30578,
30580,
30588,
30589,
30573,
30574,
30584,
30585,
30590,
24336,
30599,
30600,
30601,
30602,
30603,
16664,
24251,
16751,
24615,
18272,
18659,
19910,
20019,
21107,
24507,
26110,
30604,
24560,
24337,
24341,
24342,
27702,
29871,  
30026,
31712,
31924,
31925)


GO

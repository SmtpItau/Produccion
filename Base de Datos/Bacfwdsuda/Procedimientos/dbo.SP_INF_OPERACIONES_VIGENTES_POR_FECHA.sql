USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_OPERACIONES_VIGENTES_POR_FECHA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



-- sp_inf_operaciones_vigentes_por_Fecha '20100208' , '1111', '1554', '1552'
-- sp_inf_operaciones_vigentes_por_Fecha '20050330' , '1111', '1554', '1552'
CREATE PROCEDURE [dbo].[SP_INF_OPERACIONES_VIGENTES_POR_FECHA]	(	@dfechasta	CHAR(08)
								,	@Cat_CartNorm		CHAR(06) = ''
								,	@Cat_SubCartNorm	CHAR(06) = ''
								,	@Cat_Libro		CHAR(06) = ''
								)
AS BEGIN
SET NOCOUNT ON

DECLARE @FECHA DATETIME

--select @FECHA = cast(substring(@dfechasta,5,2)+'/'+substring(@dfechasta,7,2)+'/'+substring(@dfechasta,1,4) as datetime)
select @FECHA = CONVERT(CHAR(10),@dFechasta,103)

SELECT * INTO #PASO FROM MFCA WHERE CAFECHA <= @dfechasta --AND CACODPOS1 = 2

INSERT #PASO(	canumoper,	cacodpos1,	cacodmon1,	cacodsuc1,	cacodpos2,	cacodmon2,	cacodcart,
		cacodigo,	cacodcli,	catipoper,	catipmoda,	cafecha,	catipcam,	camdausd,
		camtomon1,	caequusd1,	caequmon1,	camtomon2,	caequusd2,	caequmon2,	caparmon1,
		capremon1,	caparmon2,	capremon2,	caestado,	caretiro,	cacontraparte,	caobserv,
		captacom,	captavta,	caspread,	cacolmon1,	cacapmon1,	catasadolar,	catasaufclp,
		caprecal,	caplazo,	cafecvcto,	capreant,	cavalpre,	caoperador,	catasfwdcmp,
		catasfwdvta,	cacalcmpdol,	cacalcmpspr,	cacalvtadol,	cacalvtaspr,	catasausd,	catasacon,
		cadiferen,	cafpagomn,	cafpagomx,	cadiftipcam,	cadifuf,	caclpinicial,	caclpfinal,
		camtodiferir,	camtodevengar,	cadevacum,	catipcamval,	camtoliq,	camtocalzado,	calock,
		camarktomarket,	capreciomtm,	capreciofwd,	camtomon1ini,	camtomon1fin,	camtomon2ini,	camtomon2fin,
		caplazoope,	caplazovto,	caplazocal,	cadiasdev,	cadelusd,	cadeluf,	carevusd,
		carevuf,	carevtot,	cavalordia,	cactacambio_a,	cactacambio_c,	cautildiferir,	caperddiferir,
		cautildevenga,	caperddevenga,	cautilacum,	caperdacum,	cautilsaldo,	caperdsaldo,	caclpmoneda1,
		caclpmoneda2,	camtocomp,	caantici,	cafecvenor,	cabroker,	cafecmod,	cavalorayer,
		camontopfe,	camontocce,	id_sistema,	precio_transferencia,		tipo_sintetico,	precio_spot,
		pais_origen,	moneda_compensacion,		riesgo_sintetico,		precio_reversa_sintetico,
		calzada,marca,	numerointerfaz,	contrato_entrega_via,		contrato_emitido_por,		contrato_ubicado_en,
		fechaemision,	fecharecepcion,	fechaingresocustodia,		fechafirmacontrato,		fecharetirocustodia,
		numerocontratocliente,		capremio,catipopc,		diferido_usd,diferido_cnv,	devengo_acum_usd_hoy,
		devengo_acum_cnv_hoy,		devengo_acum_usd_ayer,		devengo_acum_cnv_ayer,		pesos_diferido_usd,
		pesos_diferido_cnv,		pesos_devengo_usd,		pesos_devengo_cnv,		pesos_devengo_acum_usd,
		pesos_devengo_acum_cnv,		pesos_devengo_saldo_usd,	pesos_devengo_saldo_cnv,	valor_actual_cnv,
		tc_calculo_mes_actual,		tc_calculo_mes_anterior,	mtm_hoy_moneda1,		mtm_hoy_moneda2,
		var_moneda1,			var_moneda2,			tasa_mtm_moneda1,		tasa_mtm_moneda2,
		tasa_var_moneda1,		tasa_var_moneda2,		efecto_cambio_moneda1,		efecto_cambio_moneda2,
		devengo_tasa_moneda1,		devengo_tasa_moneda2,		cambio_tasa_moneda1,		cambio_tasa_moneda2,
		residuo,			mtm_ayer_moneda1,		mtm_ayer_moneda2,		cahora,
		capreciopunta,			caremunera_linea,		caplazo_uso_moneda1,		caplazo_uso_moneda2,
		caobservlin,			caobservlim,			caautoriza,			catasa_efectiva_moneda1,
		catasa_efectiva_moneda2,	cautilacum_ayer,		caperdacum_ayer,		carevusd_ayer,
		carevuf_ayer,			carevtot_ayer,			caoperrelaspot,			cacartera_normativa, 
		casubcartera_normativa,		calibro,			cafecEfectiva,			catipcamFwd,
		catipcamSpot,			catasaEfectMon2,		catasaEfectMon1
	)
SELECT	canumoper,cacodpos1,cacodmon1,cacodsuc1,cacodpos2,cacodmon2,cacodcart,cacodigo,cacodcli,catipoper,catipmoda,
	cafecha,catipcam,camdausd,camtomon1,caequusd1,caequmon1,camtomon2,caequusd2,caequmon2,caparmon1,capremon1,
	caparmon2,capremon2,caestado,caretiro,cacontraparte,caobserv,captacom,captavta,caspread,cacolmon1,cacapmon1,
	catasadolar,catasaufclp,caprecal,caplazo,cafecvcto,capreant,cavalpre,caoperador,catasfwdcmp,catasfwdvta,
	cacalcmpdol,cacalcmpspr,cacalvtadol,cacalvtaspr,catasausd,catasacon,cadiferen,cafpagomn,cafpagomx,cadiftipcam,
	cadifuf,caclpinicial,caclpfinal,camtodiferir,camtodevengar,cadevacum,catipcamval,camtoliq,camtocalzado,calock,
	camarktomarket,capreciomtm,capreciofwd,camtomon1ini,camtomon1fin,camtomon2ini,camtomon2fin,caplazoope,caplazovto,
	caplazocal,cadiasdev,cadelusd,cadeluf,carevusd,carevuf,carevtot,cavalordia,cactacambio_a,cactacambio_c,
	cautildiferir,caperddiferir,cautildevenga,caperddevenga,cautilacum,caperdacum,cautilsaldo,caperdsaldo,
	caclpmoneda1,caclpmoneda2,camtocomp,caantici,cafecvenor,cabroker,cafecmod,cavalorayer,camontopfe,camontocce,
	id_sistema,precio_transferencia,tipo_sintetico,precio_spot,pais_origen,moneda_compensacion,riesgo_sintetico,
	precio_reversa_sintetico,calzada,marca,numerointerfaz,contrato_entrega_via,contrato_emitido_por,
	contrato_ubicado_en,fechaemision,fecharecepcion,fechaingresocustodia,fechafirmacontrato,fecharetirocustodia,
	numerocontratocliente,capremio,catipopc,diferido_usd,diferido_cnv,devengo_acum_usd_hoy,devengo_acum_cnv_hoy,
	devengo_acum_usd_ayer,devengo_acum_cnv_ayer,pesos_diferido_usd,pesos_diferido_cnv,pesos_devengo_usd,
	pesos_devengo_cnv,pesos_devengo_acum_usd,pesos_devengo_acum_cnv,pesos_devengo_saldo_usd,pesos_devengo_saldo_cnv,
	valor_actual_cnv,tc_calculo_mes_actual,tc_calculo_mes_anterior,mtm_hoy_moneda1,mtm_hoy_moneda2,var_moneda1,
	var_moneda2,tasa_mtm_moneda1,tasa_mtm_moneda2,tasa_var_moneda1,tasa_var_moneda2,efecto_cambio_moneda1,
	efecto_cambio_moneda2,devengo_tasa_moneda1,devengo_tasa_moneda2,cambio_tasa_moneda1,cambio_tasa_moneda2,
	residuo,mtm_ayer_moneda1,mtm_ayer_moneda2,cahora,capreciopunta,caremunera_linea,caplazo_uso_moneda1,
	caplazo_uso_moneda2,caobservlin,'',caautoriza,catasa_efectiva_moneda1,catasa_efectiva_moneda2,cautilacum_ayer,
	caperdacum_ayer,carevusd_ayer,carevuf_ayer,carevtot_ayer,0,cacartera_normativa, casubcartera_normativa, calibro,
	cafecEfectiva,	catipcamFwd,	catipcamSpot,	catasaEfectMon2,	catasaEfectMon1
FROM MFCAH A 
WHERE CAFECVCTO > @dfechasta 
AND CAFECHA < @dfechasta AND NOT EXISTS(SELECT 1 FROM #PASO B WHERE B.canumoper = A.canumoper)--AND CACODPOS1 = 2

    SELECT 'Tipo Operacion'         = a.catipoper                         ,
           'Numero Operacion'       = a.canumoper                         ,
           'Nombre Cliente'         = b.clnombre                          ,
           'Fecha Inicio'           = CONVERT(CHAR(10), a.cafecha, 103)   ,
           'Fecha Termino'          = CONVERT(CHAR(10), a.cafecvcto, 103) ,
           'Dias Cnt'               = a.caplazo                           ,
           'PRM'                    = ISNULL(c.mnnemo,'')                 ,
           'TipoCambioInicio'       = a.capremon2                         ,
           'ParidadFutura'          = a.catipcam                          ,
           'TipoCambioValorizacion' = ( SELECT vmvalor
                                        FROM   VIEW_VALOR_MONEDA
                                        WHERE  vmcodigo = 994 AND
                                               vmfecha  = @dfechasta )    , 
           'ParidadValorizacion'    = a.catipcamval                       ,
           'M/X ope'                = ISNULL(e.mnnemo,'')                 ,
           'Monto Operacion'        = a.camtomon1                         ,
           'M/X CNV'                = ISNULL(d.mnnemo,'')                 ,
           'MontoConversion'        = a.camtomon2                         ,
           'Art84'     = CASE a.catipoper WHEN 'C' THEN ROUND(a.caequmon1 - a.caequmon2,0) ELSE ROUND(a.caequmon2 - a.caequmon1,0) END,
           'Valorizacion'           = a.cavalordia                        ,
           'M'                      = a.catipmoda                         ,
           'Fecha Proceso'          = CONVERT(CHAR(10), @FECHA, 103)      ,
           'Observado'              = ( SELECT vmvalor
                                        FROM   VIEW_VALOR_MONEDA WHERE  vmcodigo = 994 AND vmfecha  = @dfechasta )   , 
           'Entidad'                = ( SELECT rcnombre
                                        from   VIEW_ENTIDAD
                                        where  rccodcar = a.cacodsuc1 )   ,
           'Hora'                   = CONVERT(CHAR(5), getdate(),108)     ,
	   'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
	   'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
	   'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') 

   /* FROM   #PASO         a,
           VIEW_CLIENTE  b,
           VIEW_MONEDA   c,
           VIEW_MONEDA   d,
           VIEW_MONEDA   e 
    WHERE (b.clrut      = a.cacodigo   AND
           a.cacodcli   = b.clcodigo ) AND
           a.camdausd   *= c.mncodmon   AND
           a.cacodmon2  *= d.mncodmon   AND
           a.cacodmon1  *= e.mncodmon
    ORDER  BY b.clnombre,a.cacodmon1, a.catipoper,a.canumoper */

--RQ 7619
    FROM   #PASO         a LEFT OUTER JOIN  VIEW_MONEDA   c ON a.camdausd   = c.mncodmon 
			       LEFT OUTER JOIN  VIEW_MONEDA   d ON a.cacodmon2  = d.mncodmon
			       LEFT OUTER JOIN  VIEW_MONEDA   e ON a.cacodmon1  = e.mncodmon,
           VIEW_CLIENTE  b
    WHERE (b.clrut      = a.cacodigo   AND
           a.cacodcli   = b.clcodigo ) 
    ORDER  BY b.clnombre,a.cacodmon1, a.catipoper,a.canumoper 


SET NOCOUNT OFF 
END


GO

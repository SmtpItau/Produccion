USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULARANTICIPO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ANULARANTICIPO]  
   (   @nnumoper      NUMERIC(10) )
AS
BEGIN

	-- @nnumoper corresponde a número Anexo.
   SET NOCOUNT ON

   BEGIN TRANSACTION


   DECLARE @acfecante     DATETIME
   DECLARE @acfecproc     DATETIME
   DECLARE @nnumoperel   NUMERIC(10)

 
   SELECT  @acfecante = acfecante       ,
           @acfecproc = acfecproc     
   FROM MFAC 

   INSERT INTO MFCA_LOG ( canumoper     ,
                          cacodpos1     ,
                          cacodmon1     ,
                          cacodsuc1     ,
                          cacodpos2     ,
                          cacodmon2     ,
                          cacodcart     ,
                          cacodigo      ,
                          cacodcli      ,
                          catipoper     ,
                          catipmoda     ,
                          cafecha       ,
                          catipcam      ,
                          camdausd      ,
                          camtomon1     ,
                          caequusd1     ,
                          caequmon1     ,
                          camtomon2     ,
                          caequusd2     ,
                          caequmon2     ,
                          caparmon1     ,
                          capremon1     ,
                          caparmon2     ,
                          capremon2     ,
                          caestado      ,
                          caretiro      ,
                          cacontraparte ,
                          caobserv      ,
                          captacom      ,
                          captavta      ,
                          caspread      ,
                          cacolmon1     ,
                          cacapmon1     ,
                          catasadolar   ,
                          catasaufclp   ,
                          caprecal      ,
                          caplazo       ,
                          cafecvcto     ,
                          capreant      ,
                          cavalpre      ,
                          caoperador    ,
                          catasfwdcmp   ,
                          catasfwdvta   ,
                          cacalcmpdol   ,
                          cacalcmpspr   ,
                          cacalvtadol   ,
                          cacalvtaspr   ,
                          catasausd     ,
                          catasacon     ,
                          cadiferen     ,
                          cafpagomn     ,
                          cafpagomx     ,
                          cadiftipcam   ,
                          cadifuf       ,
                          caclpinicial  ,
             		  caclpfinal    ,
                          camtodiferir  ,
                          camtodevengar ,
                          cadevacum     ,
                          catipcamval   ,
                          camtoliq      ,
                          camtocalzado  ,
                          calock        ,
                          camarktomarket,
                          capreciomtm   ,
                          capreciofwd   ,
                          camtomon1ini  ,
                          camtomon1fin  ,
                          camtomon2ini  ,
                          camtomon2fin  ,
                          caplazoope    ,
                          caplazovto    ,
                          caplazocal    ,
                          cadiasdev     ,
                          cadelusd      ,
                          cadeluf       ,
                          carevusd      ,
                          carevuf       ,
                          carevtot      ,
                          cavalordia    ,
                          cactacambio_a ,
                          cactacambio_c ,
                          cautildiferir ,
                          caperddiferir ,
                          cautildevenga ,
                          caperddevenga ,
                          cautilacum    ,
                          caperdacum    ,
                          cautilsaldo   ,
                          caperdsaldo   ,
                          caclpmoneda1  ,
                          caclpmoneda2  ,
                          camtocomp     ,
                          caantici      ,
                          cafecvenor    ,
                          cabroker      ,
                          cafecmod      ,
                          cavalorayer ,
                          cahora      ,
                          catasaEfectMon1 ,
                          catasaEfectMon2 ,        
                          catipcamSpot    ,        
                          catipcamFwd     ,        
                          cafecEfectiva   ,
		          fVal_Obtenido,	
		          fRes_Obtenido,
		          CaTasaSinteticaM1,
		          CaTasaSinteticaM2,
		          CaPrecioSpotVentaM1,
		          CaPrecioSpotVentaM2,
		          CaPrecioSpotCompraM1,
		          CaPrecioSpotCompraM2,
			  caArea_Responsable	,
                          cacartera_normativa    ,
                          casubcartera_normativa ,
                          calibro ,
                          estado_sinacofi ,
                          fecha_estado_sina ,
                          caAntPtosFwd ,
                          caAntPtosCos ,
                          caAntTasaPlazoRem ,
                          caAntBase ,
                          caAntForPagMdaComp ,
                          caAntParContraMda ,
                          caAntParMdaComp ,  
                          caAntFactorContMda ,
                          caAntMtoMdaComp ,
                          caAntDifCostUnitMerc ,
                          caAntMTMCost ,
                          caAntMargenContMda ,
                          caAntValCLPContMda ,
                          caAntCorrela ,
                          caAntPreOpEF ,
                          caOrgCurvaMon ,
                          caOrgCurvaCnv ,
                          cacosto_usdclp ,
                          cacosto_mxusd ,
                          cacosto_mxclp ,
                          cafijaTCRef ,
                          cafijaPRRef ,
                          caSpotTipCam ,
                          caSpotParidad ,
                          Resultado_Mesa ,
                          Threshold ,
                          CaFechaStarting ,
                          CaFechaFijacionStarting ,
                          CaPuntosFwdCierre ,
                          CaPuntosTransfObs ,
                          CaPuntosTransfFwd ,
                          CaTasaPriPzoFijObs ,
                          CaTasaSecPzoFijObs ,
                          CaDelta,
						  numerocontratocliente
						  --PRD 12712
						,bEarlyTermination
						,FechaInicio
						,Periodicidad
          
                        )
   SELECT                 canumoper     ,
                          cacodpos1     ,
                          cacodmon1     ,
                          cacodsuc1     ,
                          cacodpos2     ,
                          cacodmon2     ,
                          cacodcart     ,
                          cacodigo      ,
                          cacodcli      ,
                          catipoper     ,
                          catipmoda     ,
                          cafecha       ,
                          catipcam      ,
                          camdausd      ,
                          camtomon1     ,
                          caequusd1     ,
                          caequmon1     ,
                          camtomon2     ,
                          caequusd2     ,
                          caequmon2     ,
                          caparmon1     ,
                          capremon1     ,
                          caparmon2     ,
        capremon2     ,
                       'A'           ,
                          caretiro      ,
                          cacontraparte ,
                          'Anula Anticipo' ,  
                          captacom      ,
                          captavta      ,
                          caspread      ,
                          cacolmon1     ,
                          cacapmon1     ,
                          catasadolar   ,
                          catasaufclp   ,
                          caprecal      ,
                          caplazo       ,
                          cafecvcto     ,
                          capreant      ,
                          cavalpre      ,
                          caoperador    ,
                          catasfwdcmp   ,
                          catasfwdvta   ,
                          cacalcmpdol   ,
                          cacalcmpspr   ,
                          cacalvtadol   ,
                          cacalvtaspr   ,
                          catasausd     ,
                          catasacon     ,
       		          cadiferen     ,
           		  cafpagomn     ,
                          cafpagomx     ,
                          cadiftipcam   ,
                          cadifuf       ,
                          caclpinicial  ,
                          caclpfinal    ,
                          camtodiferir  ,
                          camtodevengar ,
                          cadevacum     ,
                          catipcamval   ,
                          camtoliq      ,
                          camtocalzado  ,
                          calock        ,
                          camarktomarket,
                          capreciomtm   ,
                          capreciofwd  ,
                          camtomon1ini  ,
                          camtomon1fin  ,
                          camtomon2ini  ,
                          camtomon2fin  ,
                          caplazoope    ,
                          caplazovto    ,
                          caplazocal    ,
                          cadiasdev     ,
                          cadelusd      ,
                          cadeluf       ,
                          carevusd      ,
                          carevuf       ,
                          carevtot      ,
                          cavalordia    ,
                          cactacambio_a ,
                          cactacambio_c ,
                          cautildiferir ,
                          caperddiferir ,
                          cautildevenga ,
                          caperddevenga ,
                          cautilacum    ,
                          caperdacum    ,
                          cautilsaldo   ,
                          caperdsaldo   ,
                          caclpmoneda1  ,
                          caclpmoneda2  ,
                          camtocomp     ,
                          caantici      ,
                          cafecvenor    ,
                          cabroker      ,
                          cafecha       ,
                          cavalorayer ,
                          CONVERT( CHAR(08), GETDATE() , 108 ),
                          catasaEfectMon1 ,
                          catasaEfectMon2 ,        
                          catipcamSpot    ,        
                          catipcamFwd     ,        
                          cafecEfectiva   ,
		          fVal_Obtenido,	
		          fRes_Obtenido,
		          CaTasaSinteticaM1,
		          CaTasaSinteticaM2,
		          CaPrecioSpotVentaM1,
		          CaPrecioSpotVentaM2,
		          CaPrecioSpotCompraM1,
		          CaPrecioSpotCompraM2,
			  caArea_Responsable	 ,
                          cacartera_normativa    ,
                          casubcartera_normativa ,
                          calibro ,
                          estado_sinacofi ,
 fecha_estado_sina ,
                       caAntPtosFwd ,
                          caAntPtosCos ,
                          caAntTasaPlazoRem ,
                          caAntBase ,
                          caAntForPagMdaComp ,
                          caAntParContraMda ,
                          caAntParMdaComp ,  
                          caAntFactorContMda ,
                          caAntMtoMdaComp ,
                          caAntDifCostUnitMerc ,
                          caAntMTMCost ,
                          caAntMargenContMda ,
                          caAntValCLPContMda ,
                          caAntCorrela ,
                          caAntPreOpEF ,
                          caOrgCurvaMon ,
                          caOrgCurvaCnv ,
                          cacosto_usdclp ,
                          cacosto_mxusd ,
                          cacosto_mxclp ,
                          cafijaTCRef ,
                          cafijaPRRef ,
                          caSpotTipCam ,
                          caSpotParidad ,
                          Resultado_Mesa ,
                          Threshold ,
                          CaFechaStarting ,
                          CaFechaFijacionStarting ,
                          CaPuntosFwdCierre ,
                          CaPuntosTransfObs ,
                          CaPuntosTransfFwd ,
                          CaTasaPriPzoFijObs ,
                          CaTasaSecPzoFijObs ,
                          CaDelta ,
						  numerocontratocliente
						  --PRD 12712
						 ,bEarlyTermination
						 ,FechaInicio
						 ,Periodicidad
   FROM                   MFCA
   WHERE                  canumoper = @nnumoper  -- select * from MFCA_LOG 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al grabar Anulación Anticipo en tabla de Log.'      
      SET NOCOUNT OFF
      RETURN
   END

   SELECT  @nnumoperel = numerocontratocliente
   FROM  MFCA
   WHERE canumoper = @nnumoper
   AND   caantici  = 'A' 
   AND   cafecvcto  = @acfecproc 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al seleccionar obtener numero de operación relacionada con Anticipo.'      
      SET NOCOUNT OFF
      RETURN
   END

   DELETE FROM MFCA 
   WHERE canumoper = @nnumoper
   AND   caantici  = 'A' 
   AND   cafecvcto   = @acfecproc 

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Operación Anticipo de Cartera.'
      SET NOCOUNT OFF
      RETURN
   END

   DELETE FROM MFCA 
   WHERE canumoper = @nnumoperel

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Eliminar Operación realcionada con operación Anticipo. '
      SET NOCOUNT OFF
      RETURN
   END

   -- MAP 20080823 Decomenté esto
   DELETE bacparamsuda..MDLBTR
   WHERE  sistema          = 'BFW'
   AND    numero_operacion = @nnumoperel  -- El pago siempre queda con la operacion Original.
   AND    estado_envio <>  'E'            -- Si no esta enviada la borra

  SELECT 	canumoper
,	cacodpos1
,	cacodmon1
,	cacodsuc1
,	cacodpos2
,	cacodmon2
,	cacodcart
,	cacodigo
,	cacodcli
,	catipoper
,	catipmoda
,	cafecha
,	catipcam
,	camdausd
,	camtomon1
,	caequusd1
,	caequmon1
,	camtomon2
,	caequusd2
,	caequmon2
,	caparmon1
,	capremon1
,	caparmon2
,	capremon2
,	caestado
,	caretiro
,	cacontraparte
,	caobserv
,	captacom
,	captavta
,	caspread
,	cacolmon1
,	cacapmon1
,	catasadolar
,	catasaufclp
,	caprecal
,	caplazo
,	cafecvcto
,	capreant
,	cavalpre
,	caoperador
,	catasfwdcmp
,	catasfwdvta
,	cacalcmpdol
,	cacalcmpspr
,	cacalvtadol
,	cacalvtaspr
,	catasausd
,	catasacon
,	cadiferen
,	cafpagomn
,	cafpagomx
,	cadiftipcam
,	cadifuf
,	caclpinicial
,	caclpfinal
,	camtodiferir
,	camtodevengar
,	cadevacum
,	catipcamval
,	camtoliq
,	camtocalzado
,	calock
,	camarktomarket
,	capreciomtm
,	capreciofwd
,	camtomon1ini
,	camtomon1fin
,	camtomon2ini
,	camtomon2fin
,	caplazoope
,	caplazovto
,	caplazocal
,	cadiasdev
,	cadelusd
,	cadeluf
,	carevusd
,	carevuf
,	carevtot
,	cavalordia
,	cactacambio_a
,	cactacambio_c
,	cautildiferir
,	caperddiferir
,	cautildevenga
,	caperddevenga
,	cautilacum
,	caperdacum
,	cautilsaldo
,	caperdsaldo
,	caclpmoneda1
,	caclpmoneda2
,	camtocomp
,	caantici
,	cafecvenor
,	cabroker
,	cafecmod
,	cavalorayer
,	camontopfe
,	camontocce
,	id_sistema
,	precio_transferencia
,	tipo_sintetico
,	precio_spot
,	pais_origen
,	moneda_compensacion
,	riesgo_sintetico
,	precio_reversa_sintetico
,	calzada
,	marca
,	numerointerfaz
,	contrato_entrega_via
,	contrato_emitido_por
,	contrato_ubicado_en
,	fechaemision
,	fecharecepcion
,	fechaingresocustodia
,	fechafirmacontrato
,	fecharetirocustodia
,	numerocontratocliente
,	capremio
,	catipopc
,	diferido_usd
,	diferido_cnv
,	devengo_acum_usd_hoy
,	devengo_acum_cnv_hoy
,	devengo_acum_usd_ayer
,	devengo_acum_cnv_ayer
,	pesos_diferido_usd
,	pesos_diferido_cnv
,	pesos_devengo_usd
,	pesos_devengo_cnv
,	pesos_devengo_acum_usd
,	pesos_devengo_acum_cnv
,	pesos_devengo_saldo_usd
,	pesos_devengo_saldo_cnv
,	valor_actual_cnv
,	tc_calculo_mes_actual
,	tc_calculo_mes_anterior
,	mtm_hoy_moneda1
,	mtm_hoy_moneda2
,	var_moneda1
,	var_moneda2
,	tasa_mtm_moneda1
,	tasa_mtm_moneda2
,	tasa_var_moneda1
,	tasa_var_moneda2
,	efecto_cambio_moneda1
,	efecto_cambio_moneda2
,	devengo_tasa_moneda1
,	devengo_tasa_moneda2
,	cambio_tasa_moneda1
,	cambio_tasa_moneda2
,	residuo
,	mtm_ayer_moneda1
,	mtm_ayer_moneda2
,	cahora
,	capreciopunta
,	caremunera_linea
,	caplazo_uso_moneda1
,	caplazo_uso_moneda2
,	caobservlin
,	caobservlim
,	caautoriza
,	catasa_efectiva_moneda1
,	catasa_efectiva_moneda2
,	cautilacum_ayer
,	caperdacum_ayer
,	carevusd_ayer
,	carevuf_ayer
,	carevtot_ayer
,	caoperrelaspot
,	catasaEfectMon1
,	catasaEfectMon2
,	catipcamSpot
,	catipcamFwd
,	cafecEfectiva
,	fVal_Obtenido
,	fRes_Obtenido
,	CaTasaSinteticaM1
,	CaTasaSinteticaM2
,	CaPrecioSpotVentaM1
,	CaPrecioSpotVentaM2
,	CaPrecioSpotCompraM1
,	CaPrecioSpotCompraM2
,	caserie
,	caseriado
,	ValorRazonableActivo
,	ValorRazonablePasivo
,	catipcamPtosFwd
,	cacartera_normativa
,	casubcartera_normativa
,	calibro
,	caArea_Responsable
,	estado_sinacofi
,	fecha_estado_sina
,	caAntPtosFwd
,	caAntPtosCos
,	caAntTasaPlazoRem
,	caAntBase
,	caAntForPagMdaComp
,	caAntParContraMda
,	caAntParMdaComp
,	caAntFactorContMda
,	caAntMtoMdaComp
,	caAntDifCostUnitMerc
,	caAntMTMCost
,	caAntMargenContMda
,	caAntValCLPContMda
,	caAntCorrela
,	caAntPreOpEF
,	caOrgCurvaMon
,	caOrgCurvaCnv
,	VrCambio
,	VrDevengo
,	VrTasa
,	cacosto_usdclp
,	cacosto_mxusd
,	cacosto_mxclp
,	cafijaTCRef
,	cafijaPRRef
,	caMtoOriginal
,	caSpotTipCam
,	caSpotParidad
,       numerospot
,       Resultado_Mesa
,       Threshold
,       CaFechaStarting
,       CaFechaFijacionStarting
,       CaPuntosFwdCierre
,       CaPuntosTransfObs
,       CaPuntosTransfFwd
,       CaTasaPriPzoFijObs
,       CaTasaSecPzoFijObs
,       CaDelta
  --PRD 12712
,bEarlyTermination
,FechaInicio
,Periodicidad

   INTO #TEMP
   FROM MFCARES
   WHERE CaFechaProceso    = @acfecante
   AND   canumoper         = @nnumoperel

   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Insertar Operación original en temporal.'
      SET NOCOUNT OFF
      RETURN
   END

   INSERT INTO MFCA (
	canumoper
,	cacodpos1
,	cacodmon1
,	cacodsuc1
,	cacodpos2
,	cacodmon2
,	cacodcart
,	cacodigo
,	cacodcli
,	catipoper
,	catipmoda
,	cafecha
,	catipcam
,	camdausd
,	camtomon1
,	caequusd1
,	caequmon1
,	camtomon2
,	caequusd2
,	caequmon2
,	caparmon1
,	capremon1
,	caparmon2
,	capremon2
,	caestado
,	caretiro
,	cacontraparte
,	caobserv
,	captacom
,	captavta
,	caspread
,	cacolmon1
,	cacapmon1
,	catasadolar
,	catasaufclp
,	caprecal
,	caplazo
,	cafecvcto
,	capreant
,	cavalpre
,	caoperador
,	catasfwdcmp
,	catasfwdvta
,	cacalcmpdol
,	cacalcmpspr
,	cacalvtadol
,	cacalvtaspr
,	catasausd
,	catasacon
,	cadiferen
,	cafpagomn
,	cafpagomx
,	cadiftipcam
,	cadifuf
,	caclpinicial
,	caclpfinal
,	camtodiferir
,	camtodevengar
,	cadevacum
,	catipcamval
,	camtoliq
,	camtocalzado
,	calock
,	camarktomarket
,	capreciomtm
,	capreciofwd
,	camtomon1ini
,	camtomon1fin
,	camtomon2ini
,	camtomon2fin
,	caplazoope
,	caplazovto
,	caplazocal
,	cadiasdev
,	cadelusd
,	cadeluf
,	carevusd
,	carevuf
,	carevtot
,	cavalordia
,	cactacambio_a
,	cactacambio_c
,	cautildiferir
,	caperddiferir
,	cautildevenga
,	caperddevenga
,	cautilacum
,	caperdacum
,	cautilsaldo
,	caperdsaldo
,	caclpmoneda1
,	caclpmoneda2
,	camtocomp
,	caantici
,	cafecvenor
,	cabroker
,	cafecmod
,	cavalorayer
,	camontopfe
,	camontocce
,	id_sistema
,	precio_transferencia
,	tipo_sintetico
,	precio_spot
,	pais_origen
,	moneda_compensacion
,	riesgo_sintetico
,	precio_reversa_sintetico
,	calzada
,	marca
,	numerointerfaz
,	contrato_entrega_via
,	contrato_emitido_por
,	contrato_ubicado_en
,	fechaemision
,	fecharecepcion
,	fechaingresocustodia
,	fechafirmacontrato
,	fecharetirocustodia
,	numerocontratocliente
,	capremio
,	catipopc
,	diferido_usd
,	diferido_cnv
,	devengo_acum_usd_hoy
,	devengo_acum_cnv_hoy
,	devengo_acum_usd_ayer
,	devengo_acum_cnv_ayer
,	pesos_diferido_usd
,	pesos_diferido_cnv
,	pesos_devengo_usd
,	pesos_devengo_cnv
,	pesos_devengo_acum_usd
,	pesos_devengo_acum_cnv
,	pesos_devengo_saldo_usd
,	pesos_devengo_saldo_cnv
,	valor_actual_cnv
,	tc_calculo_mes_actual
,	tc_calculo_mes_anterior
,	mtm_hoy_moneda1
,	mtm_hoy_moneda2
,	var_moneda1
,	var_moneda2
,	tasa_mtm_moneda1
,	tasa_mtm_moneda2
,	tasa_var_moneda1
,	tasa_var_moneda2
,	efecto_cambio_moneda1
,	efecto_cambio_moneda2
,	devengo_tasa_moneda1
,	devengo_tasa_moneda2
,	cambio_tasa_moneda1
,	cambio_tasa_moneda2
,	residuo
,	mtm_ayer_moneda1
,	mtm_ayer_moneda2
,	cahora
,	capreciopunta
,	caremunera_linea
,	caplazo_uso_moneda1
,	caplazo_uso_moneda2
,	caobservlin
,	caobservlim
,	caautoriza
,	catasa_efectiva_moneda1
,	catasa_efectiva_moneda2
,	cautilacum_ayer
,	caperdacum_ayer
,	carevusd_ayer
,	carevuf_ayer
,	carevtot_ayer
,	caoperrelaspot
,	catasaEfectMon1
,	catasaEfectMon2
,	catipcamSpot
,	catipcamFwd
,	cafecEfectiva
,	fVal_Obtenido
,	fRes_Obtenido
,	CaTasaSinteticaM1
,	CaTasaSinteticaM2
,	CaPrecioSpotVentaM1
,	CaPrecioSpotVentaM2
,	CaPrecioSpotCompraM1
,	CaPrecioSpotCompraM2
,	caserie
,	caseriado
,	ValorRazonableActivo
,	ValorRazonablePasivo
,	catipcamPtosFwd
,	cacartera_normativa
,	casubcartera_normativa
,	calibro
,	caArea_Responsable
,	estado_sinacofi
,	fecha_estado_sina
,	caAntPtosFwd
,	caAntPtosCos
,	caAntTasaPlazoRem
,	caAntBase
,	caAntForPagMdaComp
,	caAntParContraMda
,	caAntParMdaComp
,	caAntFactorContMda
,	caAntMtoMdaComp
,	caAntDifCostUnitMerc
,	caAntMTMCost
,	caAntMargenContMda
,	caAntValCLPContMda
,	caAntCorrela
,	caAntPreOpEF
,	caOrgCurvaMon
,	caOrgCurvaCnv
,	VrCambio
,	VrDevengo
,	VrTasa
,	cacosto_usdclp
,	cacosto_mxusd
,	cacosto_mxclp
,	cafijaTCRef
,	cafijaPRRef
,	caMtoOriginal
,	caSpotTipCam
,	caSpotParidad
,       numerospot
,       Resultado_Mesa
,       Threshold
,       CaFechaStarting
,       CaFechaFijacionStarting
,       CaPuntosFwdCierre
,       CaPuntosTransfObs
,       CaPuntosTransfFwd
,       CaTasaPriPzoFijObs
,       CaTasaSecPzoFijObs
,       CaDelta
  --PRD 12712
,bEarlyTermination
,FechaInicio
,Periodicidad
)
   SELECT 	canumoper
,	cacodpos1
,	cacodmon1
,	cacodsuc1
,	cacodpos2
,	cacodmon2
,	cacodcart
,	cacodigo
,	cacodcli
,	catipoper
,	catipmoda
,	cafecha
,	catipcam
,	camdausd
,	camtomon1
,	caequusd1
,	caequmon1
,	camtomon2
,	caequusd2
,	caequmon2
,	caparmon1
,	capremon1
,	caparmon2
,	capremon2
,	caestado
,	caretiro
,	cacontraparte
,	caobserv
,	captacom
,	captavta
,	caspread
,	cacolmon1
,	cacapmon1
,	catasadolar
,	catasaufclp
,	caprecal
,	caplazo
,	cafecvcto
,	capreant
,	cavalpre
,	caoperador
,	catasfwdcmp
,	catasfwdvta
,	cacalcmpdol
,	cacalcmpspr
,	cacalvtadol
,	cacalvtaspr
,	catasausd
,	catasacon
,	cadiferen
,	cafpagomn
,	cafpagomx
,	cadiftipcam
,	cadifuf
,	caclpinicial
,	caclpfinal
,	camtodiferir
,	camtodevengar
,	cadevacum
,	catipcamval
,	camtoliq
,	camtocalzado
,	calock
,	camarktomarket
,	capreciomtm
,	capreciofwd
,	camtomon1ini
,	camtomon1fin
,	camtomon2ini
,	camtomon2fin
,	caplazoope
,	caplazovto
,	caplazocal
,	cadiasdev
,	cadelusd
,	cadeluf
,	carevusd
,	carevuf
,	carevtot
,	cavalordia
,	cactacambio_a
,	cactacambio_c
,	cautildiferir
,	caperddiferir
,	cautildevenga
,	caperddevenga
,	cautilacum
,	caperdacum
,	cautilsaldo
,	caperdsaldo
,	caclpmoneda1
,	caclpmoneda2
,	camtocomp
,	caantici
,	cafecvenor
,	cabroker
,	cafecmod
,	cavalorayer
,	camontopfe
,	camontocce
,	id_sistema
,	precio_transferencia
,	tipo_sintetico
,	precio_spot
,	pais_origen
,	moneda_compensacion
,	riesgo_sintetico
,	precio_reversa_sintetico
,	calzada
,	marca
,	numerointerfaz
,	contrato_entrega_via
,	contrato_emitido_por
,	contrato_ubicado_en
,	fechaemision
,	fecharecepcion
,	fechaingresocustodia
,	fechafirmacontrato
,	fecharetirocustodia
,	numerocontratocliente
,	capremio
,	catipopc
,	diferido_usd
,	diferido_cnv
,	devengo_acum_usd_hoy
,	devengo_acum_cnv_hoy
,	devengo_acum_usd_ayer
,	devengo_acum_cnv_ayer
,	pesos_diferido_usd
,	pesos_diferido_cnv
,	pesos_devengo_usd
,	pesos_devengo_cnv
,	pesos_devengo_acum_usd
,	pesos_devengo_acum_cnv
,	pesos_devengo_saldo_usd
,	pesos_devengo_saldo_cnv
,	valor_actual_cnv
,	tc_calculo_mes_actual
,	tc_calculo_mes_anterior
,	mtm_hoy_moneda1
,	mtm_hoy_moneda2
,	var_moneda1
,	var_moneda2
,	tasa_mtm_moneda1
,	tasa_mtm_moneda2
,	tasa_var_moneda1
,	tasa_var_moneda2
,	efecto_cambio_moneda1
,	efecto_cambio_moneda2
,	devengo_tasa_moneda1
,	devengo_tasa_moneda2
,	cambio_tasa_moneda1
,	cambio_tasa_moneda2
,	residuo
,	mtm_ayer_moneda1
,	mtm_ayer_moneda2
,	cahora
,	capreciopunta
,	caremunera_linea
,	caplazo_uso_moneda1
,	caplazo_uso_moneda2
,	caobservlin
,	caobservlim
,	caautoriza
,	catasa_efectiva_moneda1
,	catasa_efectiva_moneda2
,	cautilacum_ayer
,	caperdacum_ayer
,	carevusd_ayer
,	carevuf_ayer
,	carevtot_ayer
,	caoperrelaspot
,	catasaEfectMon1
,	catasaEfectMon2
,	catipcamSpot
,	catipcamFwd
,	cafecEfectiva
,	fVal_Obtenido
,	fRes_Obtenido
,	CaTasaSinteticaM1
,	CaTasaSinteticaM2
,	CaPrecioSpotVentaM1
,	CaPrecioSpotVentaM2
,	CaPrecioSpotCompraM1
,	CaPrecioSpotCompraM2
,	caserie
,	caseriado
,	ValorRazonableActivo
,	ValorRazonablePasivo
,	catipcamPtosFwd
,	cacartera_normativa
,	casubcartera_normativa
,	calibro
,	caArea_Responsable
,	estado_sinacofi
,	fecha_estado_sina
,	caAntPtosFwd
,	caAntPtosCos
,	caAntTasaPlazoRem
,	caAntBase
,	caAntForPagMdaComp
,	caAntParContraMda
,	caAntParMdaComp
,	caAntFactorContMda
,	caAntMtoMdaComp
,	caAntDifCostUnitMerc
,	caAntMTMCost
,	caAntMargenContMda
,	caAntValCLPContMda
,	caAntCorrela
,	caAntPreOpEF
,	caOrgCurvaMon
,	caOrgCurvaCnv
,	VrCambio
,	VrDevengo
,	VrTasa
,	cacosto_usdclp
,	cacosto_mxusd
,	cacosto_mxclp
,	cafijaTCRef
,	cafijaPRRef
,	caMtoOriginal
,	caSpotTipCam
,	caSpotParidad
,       numerospot
,       Resultado_Mesa
,       Threshold
,       CaFechaStarting
,       CaFechaFijacionStarting
,       CaPuntosFwdCierre
,       CaPuntosTransfObs
,       CaPuntosTransfFwd
,       CaTasaPriPzoFijObs
,       CaTasaSecPzoFijObs
,       CaDelta
  --PRD 12712
,bEarlyTermination
,FechaInicio
,Periodicidad
  FROM #TEMP
             
   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al Insertar Operación original en Cartera.'
      SET NOCOUNT OFF
      RETURN
   END

   EXEC SP_PRO_RECALCULA_MTOS_CARTERA @nnumoper


   COMMIT TRANSACTION

   SET NOCOUNT OFF
   RETURN 0
END

GO

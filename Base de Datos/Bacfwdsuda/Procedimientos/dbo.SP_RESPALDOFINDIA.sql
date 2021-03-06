USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDOFINDIA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RESPALDOFINDIA]  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dfecproc  DATETIME  
   DECLARE @dfecprox  DATETIME  
  
   SELECT @dfecproc   = acfecproc  
   ,   @dfecprox   = acfecprox  
   FROM   MFAC        with (nolock)  
  
   DELETE FROM MFMOH  
         WHERE mofecha = @dfecproc  
   
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el borrado de movimientos historicos MFMOH.'  
      SET NOCOUNT OFF  
      RETURN  
   END  
  
   /*=======================================================================*/  
   /* RESPALDO DE MOVIMIENTOS DEL DIA                                       */  
   /*=======================================================================*/  
  
   INSERT INTO MFMOH   
               ( monumoper,  
                 mocodpos1,  
                 mocodmon1,  
                 mocodsuc1,  
                 mocodpos2,  
                 mocodmon2,  
                 mocodcart,  
                 mocodigo,  
                 mocodcli,  
                 motipoper,  
                 motipmoda,  
                 mofecha,  
                 motipcam,  
                 momdausd,  
                 momtomon1,  
                 moequusd1,  
                 moequmon1,  
                 momtomon2,  
                 moequusd2,  
                 moequmon2,  
                 moparmon1,  
                 mopremon1,  
                 moparmon2,  
                 mopremon2,  
                 moestado,  
                 moretiro,  
                 mocontraparte,  
                 moobserv,  
                 mospread,  
                 motasadolar,  
                 motasaufclp,  
                 moprecal,  
                 moplazo,  
                 mofecvcto,  
                 molock,  
                 mooperador,  
                 motasfwdcmp,  
                 motasfwdvta,  
                 mocalcmpdol,  
                 mocalcmpspr,  
                 mocalvtadol,  
                 mocalvtaspr,  
                 motasausd,  
                 motasacon,  
                 momtomon1ini,  
                 momtomon1fin,  
                 momtomon2ini,  
                 momtomon2fin,  
                 modiferen,  
                 mofpagomn,  
                 mofpagomx,  
                 mohora,  
                 motasaEfectMon1,        
                 motasaEfectMon2,        
                 motipcamSpot,       
                 motipcamFwd,       
                 mofecEfectiva,  
                 motipcamPtosFwd,  
                 moArea_Responsable ,  
                 mocartera_normativa,  
                 mosubcartera_normativa,  
                 molibro,  
                 estado_sinacofi,  
                 fecha_estado_sina,  
                 moserie,  
                 ------------->  
                 mocosto_usdclp,  
                 mocosto_mxusd,  
                 mocosto_mxclp,  
                 mofijaTCRef,  
                 mofijaPRRef,  
       --> Otros  
                 motasa_efectiva_moneda1,  
                 motasa_efectiva_moneda2,  
                 moremunera_linea,  
                 mopreciopunta   ,  
                 motipopc        ,  
                 mopremio        ,  
                 mobroker        ,  
                 moSpotTipCam    ,  
                 moSpotParidad   ,  
                 numerospot      ,  
                 Resultado_Mesa,  
    Threshold --- PRD-4858  
                 -- 5522 Bloque Forward a Observado   
                 , MoFechaStarting,              
                 MoFechaFijacionStarting,       
                 MoPuntosFwdCierre,                                       
                 MoPuntosTransfObs,                                       
                 MoPuntosTransfFwd,                                       
                 MoTasaPriPzoFijObs,  
                 MoTasaSecPzoFijObs,  
                 MoDelta,              
                 -- 5522 Bloque Forward a Observado                                     
                 --5541  
                 monroopemxclp  
                 -- PRD 12712 - 21707  
                 , bEarlyTermination  
                 , FechaInicio         
     , Periodicidad )  
          SELECT monumoper,  
                 mocodpos1,  
                 mocodmon1,  
                 mocodsuc1,  
                 mocodpos2,  
                 mocodmon2,  
                 mocodcart,  
                 mocodigo,  
                 mocodcli,  
                 motipoper,  
     motipmoda,  
                 mofecha,  
  motipcam,  
                 momdausd,  
                 momtomon1,  
                 moequusd1,  
                 moequmon1,  
                 momtomon2,  
                 moequusd2,  
                 moequmon2,  
                 moparmon1,  
                 mopremon1,  
                 moparmon2,  
                 mopremon2,  
                 moestado,  
                 moretiro,  
                 mocontraparte,  
                 moobserv,  
                 mospread,  
                 motasadolar,  
                 motasaufclp,  
                 moprecal,  
                 moplazo,  
                 mofecvcto,  
                 molock,  
                 mooperador,  
                 motasfwdcmp,  
                 motasfwdvta,  
                 mocalcmpdol,  
                 mocalcmpspr,  
                 mocalvtadol,  
                 mocalvtaspr,  
                 motasausd,  
                 motasacon,  
                 momtomon1ini,  
                 momtomon1fin,  
                 momtomon2ini,  
                 momtomon2fin,  
                 modiferen,  
                 mofpagomn,  
                 mofpagomx,  
                 mohora,  
                 motasaEfectMon1,        
                 motasaEfectMon2,        
                 motipcamSpot,        
                 motipcamFwd,       
                 mofecEfectiva,  
                 motipcamPtosFwd,  
             moArea_Responsable,  
                 mocartera_normativa,  
                 mosubcartera_normativa,  
                 molibro,  
                 estado_sinacofi,  
                 fecha_estado_sina,  
                 moserie,  
                 ------------->  
                 mocosto_usdclp,  
                 mocosto_mxusd,  
                 mocosto_mxclp,  
                 mofijaTCRef,  
                 mofijaPRRef,  
                 --> Otros  
                 ISNULL( motasa_efectiva_moneda1, 0.0),  
                 ISNULL( motasa_efectiva_moneda2, 0.0),  
                 ISNULL( moremunera_linea, 0.0),  
                 ISNULL( mopreciopunta, 0.0),  
                 ISNULL( motipopc, 0.0),  
                 ISNULL( mopremio, 0.0),   
                 ISNULL( mobroker, 0.0),  
                 moSpotTipCam,  
                 moSpotParidad ,  
          numerospot,  
                 Resultado_Mesa,  
    Threshold --- PRD-4858  
                 -- 5522 Bloque Forward a Observado   
                 , MoFechaStarting,              
                 MoFechaFijacionStarting,       
                 MoPuntosFwdCierre,                                       
                 MoPuntosTransfObs,                                       
                 MoPuntosTransfFwd,                                       
                 MoTasaPriPzoFijObs,  
                 MoTasaSecPzoFijObs,  
                 MoDelta,  
                 -- 5522 Bloque Forward a Observado                                    
                 --PRD5541  
                 monroopemxclp  
                 -- PRD 12712 - 21707  
                 , bEarlyTermination  
                 , FechaInicio         
     , Periodicidad  
            FROM MFMO  
           WHERE mofecha = @dfecproc  
  
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el Traspaso de movimientos MFMO.'  
      SET NOCOUNT OFF  
      RETURN  
   END  
   
   DELETE FROM MFACH  
         WHERE acfecproc = @dfecproc  
  
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el borrado de parametros historicos MFACH.'  
      SET NOCOUNT OFF  
      RETURN  
   END  
  
   /*=======================================================================*/  
   /* Respaldo de la tabla de parametros.                                   */  
   /*=======================================================================*/  
   INSERT INTO MFACH   
               ( acrutprop     ,  
                 acdigprop,  
                 acnomprop,  
                 acdirprop,  
                 acfecante,  
                 acfecproc,  
                 acfecprox,  
                 acsucmesa,  
                 acofimesa,  
                 accodmonloc,  
                 accodmondol,  
                 accodmonuf,  
                 accodmondolobs,  
                 acnumoper,  
                 accorrel,  
                 acnumdecimales,  
                 acpais,  
                 acplaza,  
                 accodempresa,  
                 accodclie,  
                 actipocalculo,  
                 actipparfwd,  
                 actcaparfwd,  
                 acsw_pd,  
                 acsw_fd,  
                 acsw_ciemefwd,  
                 acsw_devenfwd,  
                 acsw_contafwd,  
                 acdesviacionestandar,  
                 accodbcch,  
                 acfax,  
                 actelefono  
               )  
          SELECT acrutprop,  
                 acdigprop,  
                 acnomprop,  
                 acdirprop,  
acfecante,  
                 acfecproc,  
                 acfecprox,  
                 acsucmesa,  
                 acofimesa,  
                 accodmonloc,  
                 accodmondol,  
                 accodmonuf,  
                 accodmondolobs,  
                 acnumoper,  
                 accorrel,  
                 acnumdecimales,  
                 acpais,  
                 acplaza,  
                 accodempresa,  
                 accodclie,  
                 actipocalculo,  
                 actipparfwd,  
                 actcaparfwd,  
                 acsw_pd,  
                 acsw_fd,  
                 acsw_ciemefwd,  
                 acsw_devenfwd,  
                 acsw_contafwd,  
                 acdesviacionestandar,  
                 accodbcch,  
                 acfax,  
                 actelefono  
            FROM MFAC  
  
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el borrado de parámetros MFAC.'  
      SET NOCOUNT OFF  
      RETURN  
   END  
  
   /*=======================================================================*/  
   /* ACTUALIZACION DE TABLA PARIDADES MFBIDASK               */  
   /*=======================================================================*/   
   DELETE FROM MFBIDASK  
         WHERE fecha = @dfecprox  
  
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el borrado de Bid-Ask'  
      SET NOCOUNT OFF  
      RETURN  
   END  
  
   SELECT   moneda,  
           'fecha' = @dfecprox,  
            periodo,  
            bid,  
            ask,  
            factor  
   INTO     #Paso  
   FROM     MFBIDASK  
   WHERE    fecha = @dfecproc  
   ORDER BY moneda,periodo  
  
   INSERT INTO MFBIDASK   
   (      moneda,  
          fecha,  
          periodo,  
          bid,  
          ask,  
          factor  
   )  
   SELECT moneda,  
          fecha,  
          periodo,  
          bid,  
          ask,  
          factor  
   FROM   #Paso  
  
   IF @@ERROR <> 0   
   BEGIN  
      SELECT -1, 'Error: En el respaldo de Paridades BID/ASK.'  
      SET NOCOUNT OFF  
      RETURN  
   END  
  
   DELETE FROM MFCCH  
         WHERE ccfecven = @dfecproc  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al borrar los calces históricos'  
      RETURN  
   END  
  
   INSERT INTO MFCCH  
   SELECT ccposcmp,  
          ccopecmp,  
          ccposvta,  
          ccopevta,  
          ccmonto,  
          ccfecven,  
          ccfecuact,  
          ccusuario  
   FROM   MFCC  
   WHERE  ccfecven <= @dfecproc  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al grabar los calces históricos'  
      RETURN  
   END  
  
   --> TAG MPNG20060317   
   DELETE FROM MFCARES  
         WHERE CaFechaProceso = @dfecproc    
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al borrar Foto MFCARES de hoy'  
      RETURN  
   END  
  
   INSERT INTO MFCARES  
               ( CaFechaProceso   
               , canumoper   
               , cacodpos1   
               , cacodmon1   
               , cacodsuc1   
               , cacodpos2   
               , cacodmon2   
               , cacodcart   
               , cacodigo   
               , cacodcli   
               , catipoper   
               , catipmoda   
               , cafecha   
               , catipcam   
               , camdausd   
               , camtomon1   
               , caequusd1   
               , caequmon1   
               , camtomon2   
               , caequusd2   
               , caequmon2   
               , caparmon1   
               , capremon1   
               , caparmon2   
               , capremon2   
               , caestado   
               , caretiro   
               , cacontraparte   
               , caobserv   
               , captacom   
               , captavta   
               , caspread   
               , cacolmon1   
               , cacapmon1   
             , catasadolar   
               , catasaufclp   
               , caprecal   
           , caplazo   
               , cafecvcto   
               , capreant   
               , cavalpre   
               , caoperador   
               , catasfwdcmp   
               , catasfwdvta   
               , cacalcmpdol   
               , cacalcmpspr   
               , cacalvtadol   
               , cacalvtaspr   
               , catasausd   
               , catasacon   
               , cadiferen   
               , cafpagomn   
               , cafpagomx   
               , cadiftipcam   
               , cadifuf   
               , caclpinicial   
               , caclpfinal   
               , camtodiferir   
               , camtodevengar   
               , cadevacum   
               , catipcamval   
               , camtoliq   
               , camtocalzado   
               , calock   
               , camarktomarket   
               , capreciomtm   
               , capreciofwd   
               , camtomon1ini   
               , camtomon1fin   
               , camtomon2ini   
               , camtomon2fin   
               , caplazoope   
               , caplazovto   
               , caplazocal   
               , cadiasdev   
               , cadelusd   
               , cadeluf   
               , carevusd   
               , carevuf   
               , carevtot   
               , cavalordia   
               , cactacambio_a   
               , cactacambio_c   
               , cautildiferir   
               , caperddiferir   
               , cautildevenga   
               , caperddevenga   
               , cautilacum   
               , caperdacum   
               , cautilsaldo   
               , caperdsaldo   
               , caclpmoneda1   
               , caclpmoneda2   
               , camtocomp   
               , caantici   
               , cafecvenor   
               , cabroker   
               , cafecmod   
               , cavalorayer   
               , camontopfe   
               , camontocce   
               , id_sistema   
               , precio_transferencia   
               , tipo_sintetico   
               , precio_spot   
               , pais_origen   
               , moneda_compensacion   
               , riesgo_sintetico   
               , precio_reversa_sintetico   
               , calzada   
               , marca   
               , numerointerfaz   
               , contrato_entrega_via   
               , contrato_emitido_por   
               , contrato_ubicado_en   
               , fechaemision   
               , fecharecepcion   
               , fechaingresocustodia   
               , fechafirmacontrato   
               , fecharetirocustodia   
               , numerocontratocliente   
 , capremio   
               , catipopc   
               , diferido_usd   
               , diferido_cnv   
               , devengo_acum_usd_hoy   
               , devengo_acum_cnv_hoy   
               , devengo_acum_usd_ayer   
               , devengo_acum_cnv_ayer   
               , pesos_diferido_usd   
               , pesos_diferido_cnv   
               , pesos_devengo_usd   
               , pesos_devengo_cnv   
               , pesos_devengo_acum_usd   
               , pesos_devengo_acum_cnv   
               , pesos_devengo_saldo_usd   
               , pesos_devengo_saldo_cnv   
               , valor_actual_cnv   
               , tc_calculo_mes_actual   
               , tc_calculo_mes_anterior   
               , mtm_hoy_moneda1   
               , mtm_hoy_moneda2   
               , var_moneda1   
               , var_moneda2   
               , tasa_mtm_moneda1   
               , tasa_mtm_moneda2   
               , tasa_var_moneda1   
               , tasa_var_moneda2   
               , efecto_cambio_moneda1   
               , efecto_cambio_moneda2   
               , devengo_tasa_moneda1   
               , devengo_tasa_moneda2   
               , cambio_tasa_moneda1   
               , cambio_tasa_moneda2   
               , residuo   
           , mtm_ayer_moneda1   
               , mtm_ayer_moneda2   
               , cahora   
               , capreciopunta   
               , caremunera_linea   
               , caplazo_uso_moneda1   
               , caplazo_uso_moneda2   
               , caobservlin   
               , caobservlim   
               , caautoriza   
               , catasa_efectiva_moneda1   
               , catasa_efectiva_moneda2   
               , cautilacum_ayer   
               , caperdacum_ayer   
               , carevusd_ayer   
               , carevuf_ayer   
               , carevtot_ayer   
               , caoperrelaspot   
               , catasaEfectMon1   
               , catasaEfectMon2   
               , catipcamSpot   
               , catipcamFwd   
               , cafecEfectiva   
               , fVal_Obtenido   
               , fRes_Obtenido   
               , CaTasaSinteticaM1   
               , CaTasaSinteticaM2   
               , CaPrecioSpotVentaM1   
               , CaPrecioSpotVentaM2   
               , CaPrecioSpotCompraM1   
               , CaPrecioSpotCompraM2   
               , caserie   
               , caseriado   
               , ValorRazonableActivo   
               , ValorRazonablePasivo   
               , catipcamPtosFwd   
               , cacartera_normativa   
               , casubcartera_normativa   
               , calibro   
               , caArea_Responsable   
               , estado_sinacofi   
               , fecha_estado_sina   
               , caAntPtosFwd   
               , caAntPtosCos   
               , caAntTasaPlazoRem   
               , caAntBase   
               , caAntForPagMdaComp   
               , caAntParContraMda   
               , caAntParMdaComp   
               , caAntFactorContMda   
               , caAntMtoMdaComp   
               , caAntDifCostUnitMerc   
               , caAntMTMCost   
               , caAntMargenContMda   
               , caAntValCLPContMda   
               , caAntCorrela   
               , caAntPreOpEF  
               , caOrgCurvaMon  
               , caOrgCurvaCnv  
                 --> Separacion Valor Razonable  
               , VrCambio  
               , VrTasa  
               , VrDevengo  
               , caMtoOriginal  
       --> Campos Arbitraje Moneda Mx-$  
               , cacosto_usdclp  
               , cacosto_mxusd  
               , cacosto_mxclp  
               , cafijaTCRef  
               , cafijaPRRef  
               , caSpotTipCam  
               , caSpotParidad  
        , numerospot  
               , Resultado_Mesa  
   , Threshold --- PRD-4858  -- select * from mfca  
               -- 5522 Bloque Forward a Observado  
               , CaFechaStarting               
               , CaFechaFijacionStarting       
  , CaPuntosFwdCierre                                  
               , CaPuntosTransfObs                                       
               , CaPuntosTransfFwd                                       
               , CaTasaPriPzoFijObs                                      
               , CaTasaSecPzoFijObs                                      
               , CaDelta                       
               -- 5522 Bloque Forward a Observado                            
               --> PRD 12712 Early Termination  
               ,   bEarlyTermination        
            ,   FechaInicio              
            ,   Periodicidad              
                                    
               )  
          SELECT @dfecproc  
               , canumoper  
               , cacodpos1  
               , cacodmon1  
               , cacodsuc1  
               , cacodpos2  
               , cacodmon2  
               , cacodcart  
               , cacodigo  
               , cacodcli  
               , catipoper  
               , catipmoda  
               , cafecha  
               , catipcam  
               , camdausd  
               , camtomon1  
               , caequusd1  
               , caequmon1  
               , camtomon2  
               , caequusd2  
               , caequmon2  
               , caparmon1  
               , capremon1  
               , caparmon2  
               , capremon2  
               , caestado  
               , caretiro  
               , cacontraparte  
               , caobserv  
               , captacom  
               , captavta  
               , caspread  
               , cacolmon1  
               , cacapmon1  
               , catasadolar  
               , catasaufclp  
               , caprecal  
               , caplazo  
               , cafecvcto  
               , capreant  
               , cavalpre  
               , caoperador  
               , catasfwdcmp  
               , catasfwdvta  
               , cacalcmpdol  
               , cacalcmpspr  
               , cacalvtadol  
               , cacalvtaspr  
               , catasausd  
               , catasacon  
               , cadiferen  
               , cafpagomn  
               , cafpagomx  
               , cadiftipcam  
               , cadifuf  
               , caclpinicial  
               , caclpfinal  
               , camtodiferir  
           , camtodevengar  
               , cadevacum  
               , catipcamval  
               , camtoliq  
               , camtocalzado  
               , calock  
               , camarktomarket  
               , capreciomtm  
               , capreciofwd  
               , camtomon1ini  
               , camtomon1fin  
               , camtomon2ini  
               , camtomon2fin  
               , caplazoope  
               , caplazovto  
               , caplazocal  
               , cadiasdev  
               , cadelusd  
               , cadeluf  
               , carevusd  
               , carevuf  
               , carevtot  
               , cavalordia  
               , cactacambio_a  
               , cactacambio_c  
               , cautildiferir  
               , caperddiferir  
               , cautildevenga  
               , caperddevenga  
               , cautilacum  
               , caperdacum  
               , cautilsaldo  
               , caperdsaldo  
               , caclpmoneda1  
               , caclpmoneda2  
               , camtocomp  
               , caantici  
               , cafecvenor  
               , cabroker  
               , cafecmod  
               , cavalorayer  
               , camontopfe  
               , camontocce  
               , id_sistema  
               , precio_transferencia  
               , tipo_sintetico  
               , precio_spot  
               , pais_origen  
               , moneda_compensacion  
               , riesgo_sintetico  
               , precio_reversa_sintetico  
               , calzada  
               , marca  
               , numerointerfaz  
               , contrato_entrega_via  
               , contrato_emitido_por  
               , contrato_ubicado_en  
               , fechaemision  
               , fecharecepcion  
               , fechaingresocustodia  
               , fechafirmacontrato  
               , fecharetirocustodia  
               , numerocontratocliente  
               , capremio  
               , catipopc  
               , diferido_usd  
               , diferido_cnv  
               , devengo_acum_usd_hoy  
               , devengo_acum_cnv_hoy  
               , devengo_acum_usd_ayer  
               , devengo_acum_cnv_ayer  
               , pesos_diferido_usd  
               , pesos_diferido_cnv  
               , pesos_devengo_usd  
               , pesos_devengo_cnv  
               , pesos_devengo_acum_usd  
               , pesos_devengo_acum_cnv  
               , pesos_devengo_saldo_usd  
               , pesos_devengo_saldo_cnv  
               , valor_actual_cnv  
               , tc_calculo_mes_actual  
               , tc_calculo_mes_anterior  
               , mtm_hoy_moneda1  
               , mtm_hoy_moneda2  
               , var_moneda1  
               , var_moneda2  
               , tasa_mtm_moneda1  
               , tasa_mtm_moneda2  
               , tasa_var_moneda1  
               , tasa_var_moneda2  
               , efecto_cambio_moneda1  
               , efecto_cambio_moneda2  
               , devengo_tasa_moneda1  
               , devengo_tasa_moneda2  
               , cambio_tasa_moneda1  
               , cambio_tasa_moneda2  
               , residuo  
               , mtm_ayer_moneda1  
               , mtm_ayer_moneda2  
               , cahora  
               , capreciopunta  
               , caremunera_linea  
               , caplazo_uso_moneda1  
               , caplazo_uso_moneda2  
               , caobservlin  
               , caobservlim  
               , caautoriza  
               , catasa_efectiva_moneda1  
               , catasa_efectiva_moneda2  
               , cautilacum_ayer  
               , caperdacum_ayer  
               , carevusd_ayer  
               , carevuf_ayer  
               , carevtot_ayer  
               , caoperrelaspot  
               , catasaEfectMon1  
               , catasaEfectMon2  
               , catipcamSpot  
               , catipcamFwd  
               , cafecEfectiva  
               , fVal_Obtenido  
               , fRes_Obtenido  
               , CaTasaSinteticaM1  
  
               , CaTasaSinteticaM2  
               , CaPrecioSpotVentaM1  
               , CaPrecioSpotVentaM2  
               , CaPrecioSpotCompraM1  
               , CaPrecioSpotCompraM2  
               , caserie  
               , caseriado  
               , ValorRazonableActivo  
               , ValorRazonablePasivo  
               , catipcamPtosFwd  
               , cacartera_normativa  
               , casubcartera_normativa  
               , calibro  
               , caArea_Responsable  
               , estado_sinacofi  
               , fecha_estado_sina  
               , caAntPtosFwd  
               , caAntPtosCos  
               , caAntTasaPlazoRem  
               , caAntBase  
               , caAntForPagMdaComp  
               , caAntParContraMda  
               , caAntParMdaComp  
               , caAntFactorContMda  
               , caAntMtoMdaComp  
               , caAntDifCostUnitMerc  
               , caAntMTMCost  
               , caAntMargenContMda  
               , caAntValCLPContMda  
               , caAntCorrela  
               , caAntPreOpEF  
               , caOrgCurvaMon  
               , caOrgCurvaCnv  
                 --> Separacion Valor Razonable  
               , VrCambio  
               , VrTasa  
               , VrDevengo  
               , caMtoOriginal  
        --> Campos Arbitraje Moneda Mx-$  
               , cacosto_usdclp  
               , cacosto_mxusd  
               , cacosto_mxclp  
               , cafijaTCRef  
               , cafijaPRRef  
               , caSpotTipCam  
               , caSpotParidad  
               , numerospot  
     , Resultado_Mesa  
   , Threshold --- PRD-4858  
               -- 5522 Bloque Forward a Observado  
               , CaFechaStarting               
               , CaFechaFijacionStarting       
               , CaPuntosFwdCierre                                       
               , CaPuntosTransfObs                                       
               , CaPuntosTransfFwd                                       
               , CaTasaPriPzoFijObs                                      
               , CaTasaSecPzoFijObs                                      
               , CaDelta                       
               -- 5522 Bloque Forward a Observado                            
               --> PRD 12712 Early Termination  
               ,   bEarlyTermination        
            ,   FechaInicio              
            ,   Periodicidad  
            --> PRD 12712                      
            FROM MFCA  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al grabar Foto MFCA en MFCARES'  
      RETURN  
   END  
  
   /*  PRD-4858, respaldar Threshold a histórico, jbh, 25-02-2010  */  
  EXEC sp_RespaldaHistoricoThresholdBfw @dfecproc  
  
  IF @@ERROR <> 0  
  BEGIN  
 SET NOCOUNT OFF  
 SELECT -1, 'Error: Problemas al traspasar valores de Threshold al historico'  
 RETURN  
  END  
  /* fin PRD-4858     */  
  
 INSERT TBL_CARTERA_FLUJOS_RES  
 ( Cfr_Numero_OPeracion   
 , Cfr_Correlativo   
 , Cfr_Numero_Credito   
 , Cfr_Numero_Dividendo   
 , Cfr_Plazo     
 , Cfr_Fecha_Vencimiento         
 , Cfr_Fecha_Fijacion            
 , Cfr_Monto_Principal       
 , Cfr_Precio_Contrato       
 , Cfr_Precio_Costo          
 , Cfr_Monto_Secundario      
 , Cfr_Spread                
 , Cfr_Tasa_Moneda_Principal                               
 , Cfr_Tasa_Moneda_Secundaria                              
 , Cfr_Precio_Proyectado                                   
 , Cfr_Fecha_Evento              
 , Cfr_Fecha_Proceso  
 , Cfr_Estado   
 )  
 SELECT Ctf_Numero_OPeracion  
 , Ctf_Correlativo  
 , Ctf_Numero_Credito  
 , Ctf_Numero_Dividendo  
 , Ctf_Plazo  
 , Ctf_Fecha_Vencimiento  
 , Ctf_Fecha_Fijacion  
 , Ctf_Monto_Principal  
 , Ctf_Precio_Contrato  
 , Ctf_Precio_Costo  
 , Ctf_Monto_Secundario  
 , Ctf_Spread                
 , Ctf_Tasa_Moneda_Principal                               
 , Ctf_Tasa_Moneda_Secundaria                              
 , Ctf_Precio_Proyectado                                   
 , GETDATE()  
 , @dfecproc  
 , 'AV'  
 FROM TBL_CARTERA_FLUJOS  
 , MFCA  
 WHERE Ctf_Numero_OPeracion = canumoper  
 AND cafecvcto  = @dfecproc  
 AND caantici  = 'A'  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al respaldar flujos de anticipos'  
      RETURN  
   END  
  
 DELETE TBL_CARTERA_FLUJOS  
 WHERE Ctf_Fecha_Vencimiento <= @dfecproc  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al eliminar flujos vencidos'  
      RETURN  
   END  
  
   --> FIN TAG MPNG20060317  --> Modificado por Adrián  
  
   DELETE VIEW_LIMITE_TRANSACCION_ERROR WHERE Id_Sistema = 'BFW'  
   DELETE VIEW_LIMITE_TRANSACCION       WHERE Id_Sistema = 'BFW'  
   DELETE VIEW_APROBACION_OPERACIONES   WHERE Id_Sistema = 'BFW'  
  
 -- Fusion dejar de borrar está estructura  
 --  DELETE FROM BacLineas..LINEA_TRANSACCION_DETALLE WHERE Id_Sistema = 'BFW'  
 --  DELETE FROM BacLineas..LINEA_TRANSACCION         WHERE Id_Sistema = 'BFW'  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: Problemas al Eliminar Mensajes de Líneas'  
      RETURN  
   END  
  
   UPDATE MFAC SET acsw_fd = '1'  
    , acsw_pd = '0'  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET NOCOUNT OFF  
      SELECT -1, 'Error: En Tabla de Parametros '  
      RETURN  
   END  
   
   
	-->>BAJA SPOT CIERRE DIA AUTOMATICO
	--1100110000
	UPDATE BACCAMSUDA..MEAC
	SET	 ACLOGDIG	= '0111111111' -->para inicio de dia
			 --ACLOGDIG	= '1111111101'	-->>para fin de dia
			,ACPCIERRE	= 'N'
	--<<BAJA SPOT CIERRE DIA AUTOMATICO
	/*
	SET aclogdig = CASE @POS
	WHEN 1 THEN                          @VALP + SUBSTRING(aclogdig,2,8)    -- Inicio de Dia
	WHEN 2 THEN SUBSTRING(aclogdig,1,1)+ @VALP + SUBSTRING(aclogdig,3,7)    -- Parametros Financieros
	WHEN 3 THEN SUBSTRING(aclogdig,1,2)+ @VALP + SUBSTRING(aclogdig,4,6)    -- Paridades Diarias
	WHEN 4 THEN SUBSTRING(aclogdig,1,3)+ @VALP + SUBSTRING(aclogdig,5,5)    -- Posiciones Iniciales
	WHEN 5 THEN SUBSTRING(aclogdig,1,4)+ @VALP + SUBSTRING(aclogdig,6,4)    -- Paridades Mensuales del BCCH
	WHEN 6 THEN SUBSTRING(aclogdig,1,5)+ @VALP + SUBSTRING(aclogdig,7,3)    -- Control Oper ???
	WHEN 7 THEN SUBSTRING(aclogdig,1,6)+ @VALP + SUBSTRING(aclogdig,8,2)    -- Control Oper ???
	WHEN 8 THEN SUBSTRING(aclogdig,1,7)+ @VALP + SUBSTRING(aclogdig,9,1)    -- Pre-Cierre Mesa 
	WHEN 9 THEN SUBSTRING(aclogdig,1,8)+ @VALP                             -- Cierre Mesa - Fin de Dia
	END
	WHERE acentida = @ENTIDAD
	*/
  
   SET NOCOUNT OFF  
   SELECT 0  
  
END  
GO

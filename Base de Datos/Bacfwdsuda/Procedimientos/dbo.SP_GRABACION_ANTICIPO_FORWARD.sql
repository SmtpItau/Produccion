USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACION_ANTICIPO_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABACION_ANTICIPO_FORWARD]    
    ( @canumoper              NUMERIC(9)    
 , @catipmoda              CHAR(1)    
 , @camtomon1              NUMERIC(21,4)   -->   Monto Anticipo    
 , @catipcam               FLOAT           -->   Paridad / Tc Cierre    
 , @capremon1              FLOAT           -->   Paridad / Tc Cierre    
 , @caAntPtosFwd           FLOAT           -->   Ptos Fwd    
 , @precio_spot            NUMERIC(10,4)    -->   Paridad / Tc Cierre    
 , @caprecal               FLOAT           -->   Paridad + Ptos Fwd --> Precio Forward cierre    
 , @camtomon2              NUMERIC(21,4)   -->   Monto Moneda 2               ----> SE OMITE EL VALOR QUE ENTRA POR ACA    
 , @capremon2              FLOAT           -->   Paridad / Tc Costo    
 , @caAntPtosCos           FLOAT           -->   Ptos Fwd    
 , @precio_transferencia   NUMERIC(21,11)  -->   Paridad + Ptos Fwd --> Precio Forward costo    
 , @moneda_compensacion    NUMERIC(5)      -->   Moneda de compensacion    
 , @caAntForPagMdaComp     NUMERIC(3)      -->   Forma pago compensacion    
 , @cafpagomn              NUMERIC(3)      -->   forma de pago entrega fisica (Spot)    
 , @cafpagomx              NUMERIC(3)      -->   forma de pago entrega fisica (Spot)    
 , @caAntMtoMdaComp        FLOAT           -->   Valor Compensacion    
 , @cavalpre               FLOAT           -->   valor entrega fisica --> CACOLMON1    
 , @caAntValCLPContMda     FLOAT           -->   Resultado Trading     
 , @caAntMargenContMda     FLOAT           -->   Resultado Venta    
 , @Resultado_Mesa         FLOAT           -->   resultado Mesa    
 , @caspread               FLOAT           -->   resultado Mesa    
 , @fres_obtenido          FLOAT               
 , @caantmtmcost           FLOAT           -->    MTM deL COSTO  (recibe paga costo)    
 , @camarktomarket         NUMERIC(21,4)   -->    MTM del CIERRE (recibe paga cierr)    
 , @camtocalzado           NUMERIC(19,4)       
 , @nPorcentajeNominal     FLOAT    
 , @nfactor                FLOAT     
 , @caoperador    VARCHAR(15) --> Operador que realiza el anticipo    
   )    
AS    
BEGIN    
    
 SET NOCOUNT ON ;    
    
 DECLARE @dFecEfectivaRegla    DATETIME    
 , @dFecvctoOrig  DATETIME    
 , @cFecanterior  DATETIME    
 , @cfecproc          DATETIME ;     
    
    
 DECLARE @iRefMercado    INT      
 ,  @ncodpos1  INT  ;    
    
 DECLARE @nnumop            NUMERIC(10)    
 , @ncorrela          NUMERIC(03)    
 , @nnumopOrig        NUMERIC(10) ;    
    
 DECLARE @nfact             FLOAT    
 , @nfactNuev         FLOAT    
 , @dDolarContable  FLOAT    
 , @nnocionalOrig     FLOAT   ;    
    
 DECLARE @primero           CHAR(1)  ;    
    
    
 IF @ncodpos1 = 1 or @ncodpos1 = 2 BEGIN    
     SET @iRefMercado = 0    
  SELECT @iRefMercado =     
   CASE  WHEN cacodpos1 = 1 THEN CONVERT(NUMERIC(5), cacodpos2)    
    WHEN cacodpos1 = 2 THEN CONVERT(NUMERIC(5), cacolmon1)    
   END    
     FROM MFCA    
   WHERE canumoper    = @canumoper           
    
  EXECUTE BacFwdSuda..SP_GENERA_FECHA_EFECTIVA @ncodpos1, @caTipModa, @iRefMercado, @cfecproc, @dFecEfectivaRegla OUTPUT    
    
        END    
     
       
    
 SELECT  @cfecproc = acfecproc  , @cFecanterior  = acfecante  FROM MFAC   ;    
      
     SELECT @nnumopOrig    = canumoper    
 ,      @nnocionalOrig = camtomon1    
 ,      @dFecvctoOrig  = cafecvcto      
 ,      @ncodpos1      = cacodpos1    
   FROM MFCA    
  WHERE canumoper = @canumoper     ;    
    
 SELECT @dDolarContable = ISNULL(tipo_cambio,0.0) FROM bacparamsuda.dbo.valor_moneda_contable WHERE fecha = @cFecanterior AND codigo_moneda =994    
    
 SELECT  @caAntMtoMdaComp =  CASE  WHEN @catipmoda = 'C' AND @ncodpos1 = 2 THEN @camtocalzado --> ROUND(@camarktomarket * @dDolarContable,0)    
                                                WHEN @catipmoda = 'E' AND @ncodpos1 = 2 THEN @camtocalzado -->   
      WHEN @catipmoda = 'C' AND @ncodpos1 = 1 THEN @camarktomarket       
      ELSE @caAntMtoMdaComp END ;    
     
 SELECT @primero = 'S'       
  
 SELECT @nfact    = 1.0 - (@camtomon1/@nnocionalOrig )      
 SELECT @nfactNuev = (@camtomon1/@nnocionalOrig)      
    
    
 SELECT @ncorrela   = ISNULL(MAX(caAntCorrela),0)      
   FROM mfca    
  WHERE numerocontratocliente = @canumoper    
    
 SELECT @ncorrela = @ncorrela + 1    
    
 --> Hago temporal con registro Orignial para anticipos Parciales    
    
 SELECT *      
   INTO #TEMP      
   FROM MFCA    
  WHERE canumoper  = @canumoper    
    AND camtomon1 <> @camtomon1      
    
    
 IF @ncodpos1 in (  1 , 2 ,  3 ,13, 14)  BEGIN    
  IF   @nnocionalOrig <> @camtomon1  BEGIN    
   UPDATE MFAC     
      SET acnumoper = acnumoper + 1  ;    
    
   SELECT @nnumop = acnumoper FROM MFAC ;    
  END    
 END    
    
    
 IF @@ERROR <> 0 BEGIN    
    
  SELECT -1, 'Error: en la actualización del N° de Operación en tabla de Control MFAC.'    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 --> Actualizo tabla de Unwind siempre y caundo sea parcial    
    
 UPDATE  #TEMP     
    SET  canumoper          = @nnumop    
 , caAntCorrela        = @ncorrela    
 , numerocontratocliente  = @canumoper    
 , catipmoda               = @catipmoda    
 , camtomon1               = @camtomon1    
 , catipcam                = @catipcam    
 , capremon1               = @capremon1    
 , caAntPtosFwd            = @caAntPtosFwd    
 , precio_spot             = @precio_spot    
 , caprecal                = @caprecal    
 , capremon2               = @capremon2    
 , caAntPtosCos            = @caAntPtosCos    
 , precio_transferencia    = @precio_transferencia    
 , moneda_compensacion     = @moneda_compensacion    
 , caAntForPagMdaComp      = @caAntForPagMdaComp    
 , cafpagomn               = @cafpagomn    
 , cafpagomx               = @cafpagomx    
 , caAntMtoMdaComp         = @caAntMtoMdaComp    
 , cavalpre                = @cavalpre    
 , caAntValCLPContMda      = @caAntValCLPContMda    
 , caAntMargenContMda      = @caAntMargenContMda    
 , Resultado_Mesa          = @Resultado_Mesa    
 , caspread                = @caspread    
 , caAntMTMCost            = @caantmtmcost    
 , camarktomarket          = @camarktomarket    
 , camtocalzado            = @camtocalzado    
 , caantici           = 'A'    
 , cafecvcto          = @cfecproc    --> Fecha proceso    
 , capreant           = @catipcam  --> Precio Spot     
 , caAntBase          = 360     --> Fijo    
 , cafecha            = @cfecproc    
 , capreciomtm        = @catipcam  --> Precio Spot     
 , CaPrecioFwd        = 0    
 , caAntPreOpEF       = CASE WHEN catipmoda ='E' THEN @catipcam  ELSE 0 END     
 , captacom           = 0    
 , captavta           = 0    
 , camtocomp          = @camarktomarket    
        , caAntParMdaComp    = CASE WHEN @moneda_compensacion = 999 then @precio_spot else 1 end     
 , caestado            = ''     
 , caequusd1          = caequusd1 * @nfactNuev    
 , caequmon1          = caequmon1 * @nfactNuev    
 , camtomon2          = camtomon2 * @nfactNuev    
 , caequusd2          = caequusd2 * @nfactNuev    
 , caequmon2          = caequmon2 * @nfactNuev    
 , cadiferen          = cadiferen * @nfactNuev    
 , cadiftipcam        = cadiftipcam * @nfactNuev    
 , camtodiferir       = camtodiferir * @nfactNuev    
 , camtomon1ini       = camtomon1ini * @nfactNuev    
 , camtomon1fin       = camtomon1fin * @nfactNuev    
 , camtomon2ini       = camtomon2ini * @nfactNuev    
 , camtomon2fin       = camtomon2fin * @nfactNuev    
 , carevusd           = carevusd * @nfactNuev    
 , carevtot          = carevtot * @nfactNuev    
 , cavalordia         = cavalordia * @nfactNuev    
 , cactacambio_a      = cactacambio_a * @nfactNuev    
 , cactacambio_c      = cactacambio_c * @nfactNuev    
 , caperddiferir      = caperddiferir * @nfactNuev    
 , caperddevenga      = caperddevenga * @nfactNuev    
 , caperdacum         = caperdacum * @nfactNuev    
 , caperdsaldo        = caperdsaldo * @nfactNuev    
 , caclpmoneda1       = caclpmoneda1 * @nfactNuev    
 , caclpmoneda2       = caclpmoneda2 * @nfactNuev    
 , cavalorayer        = cavalorayer * @nfactNuev    
 , mtm_hoy_moneda1    = mtm_hoy_moneda1 * @nfactNuev    
 , mtm_hoy_moneda2    = mtm_hoy_moneda2 * @nfactNuev    
 , carevtot_ayer      = carevtot_ayer * @nfactNuev    
 , fRes_Obtenido      = fRes_Obtenido * @nfactNuev    
 , ValorRazonableActivo  = ValorRazonableActivo * @nfactNuev    
 , ValorRazonablePasivo  = ValorRazonablePasivo * @nfactNuev    
 , caoperador       = @caoperador     
 , caplazovto         = 0 -->DATEDIFF(dd,@cfecproc,@cfecant)    
 , caplazocal         = 0 -->DATEDIFF(dd,@cfecproc,@cfecant)    
 , caplazo            = 0 -->DATEDIFF(dd,@cfecproc,@cfecant)                    
 , caautoriza         = ''    
 , cafecvenor         = @dFecvctoOrig      
 , caobserv           = ''      
 , caobservlin        = ''     
   WHERE   canumoper   = @canumoper     
    
 IF @@ERROR <> 0 BEGIN    
  SELECT -1, 'Error: en la actualización de Temporal'    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 IF EXISTS( SELECT 1 FROM MFCA_LOG WHERE caestado = 'M' AND CONVERT(CHAR(8),cafecmod,112) = CONVERT(CHAR(8),@cfecproc,112) AND canumoper = @canumoper)    
 BEGIN    
  SELECT @primero = 'N'    
 END    
    
SELECT @primero     
SELECT * FROM #TEMP    
    
       
 INSERT INTO MFCA_LOG    
 (    canumoper    
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
  , cahora    
  , caprimero    
  , capreciopunta    
  , caremunera_linea    
  , catasa_efectiva_moneda1    
  , catasa_efectiva_moneda2    
  , catasaEfectMon1             
  , catasaEfectMon2             
  , catipcamSpot                
  , catipcamFwd                 
  , cafecEfectiva    
  , caArea_Responsable    
  , cacartera_normativa    
  , casubcartera_normativa    
  , calibro    
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
  , mtm_hoy_moneda1    
  , mtm_hoy_moneda2    
  , catipcamPtosFwd    
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
  , cacosto_usdclp    
  , cacosto_mxusd    
  , cacosto_mxclp    
  , cafijaTCRef    
  , cafijaPRRef    
  , caSpotTipCam    
  , caSpotParidad    
  , Resultado_Mesa    
  , Threshold    
  , CaFechaStarting    
  , CaFechaFijacionStarting    
  , CaPuntosFwdCierre    
  , CaPuntosTransfObs    
  , CaPuntosTransfFwd    
  , CaTasaPriPzoFijObs    
  , CaTasaSecPzoFijObs    
  , CaDelta
 --PRD 12712
	,bEarlyTermination
	,FechaInicio
	,Periodicidad)    
  SELECT canumoper    
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
  , 'M'    
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
  , @cfecproc --cafecha  
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
  , cahora    
  , @primero    
  , capreciopunta    
  , caremunera_linea    
  , catasa_efectiva_moneda1    
  , catasa_efectiva_moneda2    
  , catasaEfectMon1             
  , catasaEfectMon2             
  , catipcamSpot                
  , catipcamFwd                 
  , cafecEfectiva               
  , caArea_Responsable    
  , cacartera_normativa    
  , casubcartera_normativa    
  , calibro    
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
  , mtm_hoy_moneda1    
  , mtm_hoy_moneda2    
  , catipcamPtosFwd    
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
  , cacosto_usdclp    
  , cacosto_mxusd    
  , cacosto_mxclp    
  , cafijaTCRef    
  , cafijaPRRef    
  , caSpotTipCam    
  , caSpotParidad    
  , Resultado_Mesa    
  , Threshold    
  , CaFechaStarting    
  , CaFechaFijacionStarting    
  , CaPuntosFwdCierre    
  , CaPuntosTransfObs    
  , CaPuntosTransfFwd    
  , CaTasaPriPzoFijObs    
  , CaTasaSecPzoFijObs    
  , CaDelta    
  --PRD 12712
	,bEarlyTermination
	,FechaInicio
	,Periodicidad
    FROM MFCA    
   WHERE canumoper = @canumoper    
    
 IF @@ERROR <> 0 BEGIN    
  SELECT -1, 'Error: en la actualización de Tabla Log'    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 --> inserta solo cuando es anticipo Parcial    
 INSERT INTO  MFCA    
 SELECT * FROM #TEMP     
       
 IF @@error <> 0 BEGIN    
    
  SELECT -1, 'Error: en Insert de Temporal a  Cartera'    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 IF @nnocionalOrig <> @camtomon1     
 BEGIN    
  --> actualizo por anticipo Parcial    
  UPDATE  MFCA     
     SET  camtomon1 = camtomon1 * @nfact    
   , caequusd1 = caequusd1 * @nfact     
   , caequmon1 = caequmon1 * @nfact     
   , camtomon2 = camtomon2 * @nfact     
   , caequusd2 = caequusd2 * @nfact     
   , caequmon2 = caequmon2 * @nfact     
   , caspread  = caspread * @nfact     
   , cadiferen = cadiferen * @nfact     
   , cadiftipcam  = cadiftipcam * @nfact     
   , camtodiferir = camtodiferir * @nfact     
   , camarktomarket = camarktomarket * @nfact     
   , camtomon1ini = camtomon1ini * @nfact     
   , camtomon1fin = camtomon1fin * @nfact     
   , camtomon2ini = camtomon2ini * @nfact     
   , camtomon2fin = camtomon2fin * @nfact     
   , carevusd = carevusd * @nfact     
   , carevtot = carevtot * @nfact     
   , cavalordia = cavalordia * @nfact     
   , cactacambio_a = cactacambio_a * @nfact     
   , cactacambio_c = cactacambio_c * @nfact     
   , caperddiferir = caperddiferir * @nfact     
   , caperddevenga = caperddevenga * @nfact     
   , caperdacum = caperdacum * @nfact     
   , caperdsaldo = caperdsaldo * @nfact     
   , caclpmoneda1 = caclpmoneda1 * @nfact     
   , caclpmoneda2 = caclpmoneda2 * @nfact     
   , cavalorayer = cavalorayer * @nfact     
   , mtm_hoy_moneda1 = mtm_hoy_moneda1 * @nfact     
   , mtm_hoy_moneda2 = mtm_hoy_moneda2 * @nfact     
   , carevtot_ayer = carevtot_ayer * @nfact     
   , fRes_Obtenido = fRes_Obtenido * @nfact     
   , ValorRazonableActivo = ValorRazonableActivo * @nfact     
   , ValorRazonablePasivo = ValorRazonablePasivo * @nfact    
    WHERE canumoper  = @canumoper     
    
   SELECT @nnumopOrig = @nnumop    
 END ELSE    
 BEGIN    
  --> actualizo por anticipo total    
  UPDATE MFCA SET  cafecvcto         = @cfecproc    
  , caantici          = 'A'    
  , caAntCorrela        = @ncorrela    
  , numerocontratocliente  = @canumoper    
  , catipmoda              = @catipmoda                  
  , camtomon1              = @camtomon1                  
  , catipcam               = @catipcam                   
  , capremon1              = @capremon1                  
  , caAntPtosFwd           = @caAntPtosFwd               
  , precio_spot            = @precio_spot                
  , caprecal               = @caprecal                   
  , capremon2              = @capremon2                  
  , caAntPtosCos           = @caAntPtosCos               
  , precio_transferencia   = @precio_transferencia       
  , moneda_compensacion    = @moneda_compensacion        
  , caAntForPagMdaComp     = @caAntForPagMdaComp         
  , cafpagomn              = @cafpagomn                  
  , cafpagomx    = @cafpagomx                  
  , caAntMtoMdaComp        = @caAntMtoMdaComp            
  , cavalpre               = @cavalpre                   
  , caAntValCLPContMda     = @caAntValCLPContMda         
  , caAntMargenContMda     = @caAntMargenContMda         
  , Resultado_Mesa         = @Resultado_Mesa             
  , caspread               = @caspread                   
  , fres_obtenido          = @fres_obtenido              
  , caantmtmcost           = @caantmtmcost               
  , camarktomarket         = @camarktomarket             
  , camtocalzado           = @camtocalzado               
  , capreant           = @catipcam  --> Precio Spot     
  , caAntBase          = 360     -->Fijo    
  , cafecha            = @cfecproc    
  , capreciomtm        = @catipcam  --> Precio Spot     
  , CaPrecioFwd        = 0    
  , caAntPreOpEF       = CASE WHEN catipmoda ='E' THEN @catipcam  ELSE 0 END     
  , captacom           = 0    
  , captavta           = 0    
                , caAntParMdaComp    = CASE WHEN @moneda_compensacion = 999 then @precio_spot else 1 end     
  , camtocomp          = @camarktomarket    
  , caestado                = ''    
  , caoperador              = @caoperador      
  , caplazovto              = 0    
  , caplazocal              = 0    
  , caplazo                 = 0    
  , cafecvenor              = @dFecvctoOrig      
  , caautoriza              = ''    
  , caobserv                = ''     
  , caobservlin  = ''      
  WHERE   canumoper               = @canumoper     
    
-- , caAntFactorContMda  = @nfactor      
-- , caAntDifCostUnitMerc  = @nDifCostUnitImplMerc    
    
/*  , camtomon1         = @nnocional             
  , precio_spot       = @nPrecioSpot    
  , capreant          = @nPrecioSpotCos    
  , caAntPtosFwd      = @nptosfwd    
  , caAntPtosCos      = @nptoscos    
  , caAntTasaPlazoRem = @ntasaplazorem    
  , caAntBase         = @nbase       
  , catipmoda         = @cTipModa    
  , cafecha           = @cfecIniOrig    
  , capreciomtm       = @nprecspotptosdesc    
  , precio_transferencia = @nprecspotcosdesc     
  , CaPrecioFwd       = @nprecpactdesc     
  , caAntPreOpEF      = @nprecal        
  , cafpagomn         = @nfpagoMN    
  , cafpagomx         = @nfpagoMX    
  , captacom          = @ndifunitimpspot        
  , cacolmon1         = @ncompimpspot    
  , cacapmon1         = @nAntMtoMonCompAntes    
  , captavta          = @ndifunitimpmerc    
  , camarktomarket    = @nmtm     
  , camtocomp         = @nmtocompliq      
  , moneda_compensacion = @nmdacomp     
  , caAntForPagMdaComp = @nforpagMdaComp    
  , caAntParContraMda = @nparcontmda    
  , caAntParMdaComp   = @nparmdacomp    
  , caAntFactorContMda = @nfactor      
  , caAntMtoMdaComp   = @nmtomoncomp    
  , caAntDifCostUnitMerc = @nDifCostUnitImplMerc    
  , caAntMTMCost      =  @nMTMCosto    
  , caAntMargenContMda = @nmargenhoycontmda    
  , caAntValCLPContMda = @nvalorCLPcontmda    
  , caspread           = @nanticipoCLP     
   */    
    
  SELECT  @nnumopOrig = @canumoper    
 END     
    
 IF @@error <> 0 BEGIN    
    
  SELECT -1, 'Error: en la actualización de Cartera'    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 IF ( @caTipModa = 'E' ) BEGIN    
  EXECUTE Sp_EnviarSpotAnticipo @nnumopOrig    
 END     
    
    
 IF @@ERROR <> 0 BEGIN    
    
  SELECT -1, 'Error: al ejecutar procedimiento Sp_EnviarSpotAnticipo '    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 IF ( @caTipModa = 'E' )     
 BEGIN    
  EXECUTE BacCamSuda..Sp_Capturaforward    
 END     
    
 IF @@ERROR <> 0 BEGIN    
    
  SELECT -1, 'Error: al ejecutar procedimiento Sp_EnviarSpotAnticipo '    
  SET NOCOUNT OFF    
  RETURN    
 END    
    
 SELECT @nnumopOrig, 'OK'    
    
 SET NOCOUNT OFF    
    
    
END    

GO

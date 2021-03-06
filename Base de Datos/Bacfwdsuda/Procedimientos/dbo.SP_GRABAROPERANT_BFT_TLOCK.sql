USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAROPERANT_BFT_TLOCK]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAROPERANT_BFT_TLOCK]
       (
        @nnumoper                NUMERIC (10)     ,
        @ctipoper                CHAR ( 01 )      ,
        @ncodpos1                NUMERIC(02)      ,   
        @cfecant                 DATETIME         ,
        @nnocional               FLOAT            ,
        @nTasaAnti               FLOAT            ,
        @nTasaCostAnti           FLOAT            ,
        @cTipModa                CHAR ( 01 )      ,
        @nValPteTasaPact         FLOAT            ,
        @nValPteTasaAnt          FLOAT            , 
        @nValPteTasaCosto        FLOAT            , 
        @nmtm                    FLOAT            ,
        @nMTMCosto               FLOAT            ,
        @nmtocompliq             FLOAT            , 
        @nmdacomp                NUMERIC(03)      ,    
        @nforpagMdaComp          NUMERIC(03)      ,    
        @nparcontmda             FLOAT            ,
        @nparmdacomp             FLOAT            ,  
        @nfactor                 FLOAT            ,
        @nmtomoncomp             FLOAT            ,
        @nmargenhoycontmda       FLOAT            ,
        @nvalorCLPcontmda        FLOAT            ,
        @nanticipoCLP            FLOAT            ,
        @coperador               CHAR(15)         ,
        @cfecvctoOrig            DATETIME         ,
        @cfecIniOrig             DATETIME         ,       
        @nResultadoMesa          FLOAT    = 0.0
       )
AS
BEGIN
SET NOCOUNT ON

    DECLARE    @nnumop           NUMERIC(10)
    DECLARE    @cfecproc         DATETIME 
    DECLARE    @ncorrela         NUMERIC(03)
    DECLARE    @nfact            FLOAT
    DECLARE    @nfactNuev        FLOAT
    DECLARE    @nnumopOrig       NUMERIC(10)
    DECLARE    @nnocionalOrig    NUMERIC(10)
    DECLARE    @primero          CHAR(1)
   
    BEGIN TRANSACTION

    SELECT  @cfecproc = acfecproc 
    FROM mfac

    SELECT @nnumopOrig    = canumoper
          ,@nnocionalOrig = camtomon1
    FROM MFCA
    WHERE canumoper = @nnumoper

    SELECT @primero = 'S'   

    SELECT @nfact = 1.0 - (@nnocional/@nnocionalOrig )  
    SELECT @nfactNuev = (@nnocional/@nnocionalOrig)  


    SELECT @ncorrela   = ISNULL(MAX(caAntCorrela),0)  
    FROM MFCA
    WHERE numerocontratocliente = @nnumoper

    SELECT @ncorrela = @ncorrela + 1


    SELECT *  INTO #TEMP  
    FROM MFCA
    WHERE canumoper = @nnumoper
    AND   camtomon1 <> @nnocional   




   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1,
             'Error: al crear el nuevo registro en tabla Temporal.'
      SET NOCOUNT OFF
      RETURN
   END

      IF @ncodpos1 = 10  OR @ncodpos1 = 11
      BEGIN

       IF   @nnocionalOrig <> @nnocional 
       BEGIN
         UPDATE MFAC 
         SET    acnumoper = acnumoper + 1

         SELECT @nnumop = acnumoper FROM MFAC
       END
      END

   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización del N° de Operación en tabla de Control MFAC.'
      SET NOCOUNT OFF
      RETURN
   END



   UPDATE #TEMP SET  canumoper         = @nnumop
                    ,caantici          = 'A' 
                    ,cafecvcto         = @cfecant
                    ,camtomon1         = @nnocional         
                    ,catipcamspot      = @nTasaAnti
                    ,precio_spot       = @nTasaAnti
                    ,capreant          = @nTasaCostAnti
                    ,catipmoda         = @cTipModa   
                    ,cafecha           = @cfecproc
                    ,caequmon1         = @nValPteTasaPact 
                    ,camtomon1fin      = @nValPteTasaPact 
                    ,caequusd2         = @nValPteTasaAnt
                    ,camtomon2ini      = @nValPteTasaAnt
                    ,precio_transferencia = @nValPteTasaCosto
                    ,caequmon2         = @nmtm
                    ,cadiferen         = @nmtm
                    ,camtomon2fin      = @nmtm 
                  ,cavalordia        = @nmtm   
                    ,caAntMTMCost      = @nMTMCosto
                    ,camtocomp         = @nmtocompliq  
                    ,moneda_compensacion = @nmdacomp 
                    ,caAntForPagMdaComp = @nforpagMdaComp
                    ,caAntParContraMda = @nparcontmda
                    ,caAntParMdaComp   = @nparmdacomp
                    ,caAntFactorContMda = @nfactor  
                    ,caAntMtoMdaComp   = @nmtomoncomp
                    ,caAntMargenContMda = @nmargenhoycontmda
                    ,caAntValCLPContMda = @nvalorCLPcontmda
                    ,caspread           = @nanticipoCLP 
                    ,numerocontratocliente = @nnumoper
                    ,caAntCorrela       = @ncorrela
                    ,caestado           = '' 
                    , caequusd1         = caequusd1 * @nfactNuev
--                    , caequmon1         = caequmon1 * @nfactNuev
                    , camtomon2         = camtomon2 * @nfactNuev
--                    , caequusd2         = caequusd2 * @nfactNuev
--                    , caequmon2         = caequmon2 * @nfactNuev
--                    , cadiferen         = cadiferen * @nfactNuev
                    , cadiftipcam       = cadiftipcam * @nfactNuev
                    , camtodiferir      = camtodiferir * @nfactNuev
                    , camtomon1ini      = camtomon1ini * @nfactNuev
--                    , camtomon1fin      = camtomon1fin * @nfactNuev
--                    , camtomon2ini      = camtomon2ini * @nfactNuev
--                    , camtomon2fin      = camtomon2fin * @nfactNuev
                    , carevusd          = carevusd * @nfactNuev
                    , carevtot          = carevtot * @nfactNuev
--                    , cavalordia        = cavalordia * @nfactNuev
                    , cactacambio_a     = cactacambio_a * @nfactNuev
                    , cactacambio_c     = cactacambio_c * @nfactNuev
                    , caperddiferir     = caperddiferir * @nfactNuev
                    , caperddevenga     = caperddevenga * @nfactNuev
                    , caperdacum        = caperdacum * @nfactNuev
                    , caperdsaldo       = caperdsaldo * @nfactNuev
                    , caclpmoneda1      = caclpmoneda1 * @nfactNuev
                    , caclpmoneda2      = caclpmoneda2 * @nfactNuev
                    , cavalorayer       = cavalorayer * @nfactNuev
                    , mtm_hoy_moneda1   = mtm_hoy_moneda1 * @nfactNuev
                    , mtm_hoy_moneda2   = mtm_hoy_moneda2 * @nfactNuev
                    , carevtot_ayer     = carevtot_ayer * @nfactNuev
                    , fRes_Obtenido     = fRes_Obtenido * @nfactNuev
                    , ValorRazonableActivo = ValorRazonableActivo * @nfactNuev
                    , ValorRazonablePasivo = ValorRazonablePasivo * @nfactNuev
                    , caoperador        = @coperador 
                    , caplazovto        = DATEDIFF(dd,@cfecproc,@cfecant)
                    , caplazocal        = DATEDIFF(dd,@cfecproc,@cfecant)
                    , caplazo           = DATEDIFF(dd,@cfecproc,@cfecant)                
                    , caautoriza        = ''
                    , cafecvenor        = @cfecvctoOrig
                    , caobserv          = ''  
                    , caobservlin       = '' 
                    , Resultado_Mesa    = @nResultadoMesa
   WHERE canumoper   = @nnumoper 



   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización de Temporal'
      SET NOCOUNT OFF
      RETURN
   END


   IF EXISTS( SELECT 1 FROM MFCA_LOG WHERE caestado = 'M' AND CONVERT(CHAR(8),cafecmod,112) = CONVERT(CHAR(8),@cfecproc,112) AND canumoper = @nnumoper)
   BEGIN
         SELECT @primero = 'N'
   END
     
    
         INSERT INTO MFCA_LOG
      (   canumoper
      ,   cacodpos1
      ,   cacodmon1
      ,   cacodsuc1
      ,   cacodpos2
      ,   cacodmon2
      ,   cacodcart
      ,   cacodigo
      ,   cacodcli
      ,   catipoper
      ,   catipmoda
      ,   cafecha
      ,   catipcam
      ,   camdausd
      ,   camtomon1
      ,   caequusd1
      ,   caequmon1
      ,   camtomon2
      ,   caequusd2
      ,   caequmon2
      ,   caparmon1
      ,   capremon1
      ,   caparmon2
      ,   capremon2
      ,   caestado
      ,   caretiro
      ,   cacontraparte
      ,   caobserv
      ,   captacom
      ,   captavta
      ,   caspread
      ,   cacolmon1
      ,   cacapmon1
      ,   catasadolar
      ,   catasaufclp
      ,   caprecal
      ,   caplazo
      ,   cafecvcto
      ,   capreant
      ,   cavalpre
      ,   caoperador
      ,   catasfwdcmp
      ,   catasfwdvta
      ,   cacalcmpdol
      ,   cacalcmpspr
      ,   cacalvtadol
      ,   cacalvtaspr
      ,   catasausd
      ,   catasacon
      ,   cadiferen
      ,   cafpagomn
      ,   cafpagomx
      ,   cadiftipcam
      ,   cadifuf
      ,   caclpinicial
      ,   caclpfinal
      ,   camtodiferir
      ,   camtodevengar
      ,   cadevacum
      ,   catipcamval
      ,   camtoliq
      ,   camtocalzado
      ,   calock
      ,   camarktomarket
      ,   capreciomtm
      ,   capreciofwd
      ,   camtomon1ini
      ,   camtomon1fin
      ,   camtomon2ini
      ,   camtomon2fin
      ,   caplazoope
      ,   caplazovto
      ,   caplazocal
      ,   cadiasdev
      ,   cadelusd
      ,   cadeluf
      ,   carevusd
      ,   carevuf
      ,   carevtot
      ,   cavalordia
      ,   cactacambio_a
      ,   cactacambio_c
      ,   cautildiferir
      ,   caperddiferir
      ,   cautildevenga
      ,   caperddevenga
      ,   cautilacum
      ,   caperdacum
      ,   cautilsaldo
      ,   caperdsaldo
      ,   caclpmoneda1
      ,   caclpmoneda2
      ,   camtocomp
      ,   caantici
      ,   cafecvenor
      ,   cabroker
      ,   cafecmod
      ,   cavalorayer
      ,   camontopfe
      ,   camontocce
      ,   id_sistema
      ,   precio_transferencia
      ,   tipo_sintetico
      ,   precio_spot
      ,   pais_origen
      ,   moneda_compensacion
      ,   riesgo_sintetico
      ,   precio_reversa_sintetico
      ,   calzada
      ,   marca
      ,   numerointerfaz
      ,   contrato_entrega_via
      ,   contrato_emitido_por
      ,   contrato_ubicado_en
      ,   fechaemision
      ,   fecharecepcion
      ,   fechaingresocustodia
      ,   fechafirmacontrato
      ,   fecharetirocustodia
      ,   numerocontratocliente
      ,   capremio
      ,   catipopc
      ,   cahora
      ,   caprimero
      ,   capreciopunta
      ,   caremunera_linea
      ,   catasa_efectiva_moneda1
      ,   catasa_efectiva_moneda2
      ,   catasaEfectMon1         
      ,   catasaEfectMon2         
      ,   catipcamSpot            
      ,   catipcamFwd             
      ,   cafecEfectiva
      ,   caArea_Responsable
      ,   cacartera_normativa
      ,   casubcartera_normativa
      ,   calibro
      ,   fVal_Obtenido
      ,   fRes_Obtenido	
   ,   CaTasaSinteticaM1
      ,   CaTasaSinteticaM2
      ,   CaPrecioSpotVentaM1
      ,   CaPrecioSpotVentaM2
      ,   CaPrecioSpotCompraM1
      ,   CaPrecioSpotCompraM2     
      ,   caserie
      ,   caseriado
      ,   ValorRazonableActivo
      ,   ValorRazonablePasivo
      ,   mtm_hoy_moneda1
      ,   mtm_hoy_moneda2
      ,   catipcamPtosFwd
      ,   estado_sinacofi
      ,   fecha_estado_sina
      ,	  caAntPtosFwd
      ,   caAntPtosCos
      ,	  caAntTasaPlazoRem
      ,	  caAntBase
      ,   caAntForPagMdaComp
      ,	  caAntParContraMda
      ,	  caAntParMdaComp
      ,	  caAntFactorContMda
      ,	  caAntMtoMdaComp
      ,	  caAntDifCostUnitMerc
      ,	  caAntMTMCost
      ,   caAntMargenContMda
      ,   caAntValCLPContMda
      ,	  caAntCorrela
      ,   caAntPreOpEF  
      --> Resultado Mesa de Distribucion
      ,   Resultado_Mesa
      --PRD 12712
	  , bEarlyTermination
	  , FechaInicio
	  , Periodicidad
      )
      SELECT canumoper
 ,      cacodpos1
      ,      cacodmon1
      ,      cacodsuc1
      ,      cacodpos2
      ,      cacodmon2
      ,      cacodcart
      ,      cacodigo
      ,      cacodcli
      ,      catipoper
      ,      catipmoda
      ,      cafecha
      ,      catipcam
      ,      camdausd
      ,      camtomon1
      ,      caequusd1
      ,      caequmon1
      ,      camtomon2
      ,      caequusd2
      ,      caequmon2
      ,      caparmon1
      ,      capremon1
      ,      caparmon2
      ,      capremon2
      ,      'M'
      ,      caretiro
      ,      cacontraparte
      ,      caobserv
      ,      captacom
      ,      captavta
      ,      caspread
      ,      cacolmon1
      ,      cacapmon1
      ,      catasadolar
      ,      catasaufclp
      ,      caprecal
      ,      caplazo
      ,      cafecvcto
      ,      capreant
      ,      cavalpre
      ,      caoperador
      ,      catasfwdcmp
      ,      catasfwdvta
      ,      cacalcmpdol
      ,      cacalcmpspr
      ,      cacalvtadol
      ,      cacalvtaspr
      ,      catasausd
      ,      catasacon
      ,      cadiferen
      ,      cafpagomn
      ,      cafpagomx
      ,      cadiftipcam
      ,      cadifuf
      ,      caclpinicial
      ,      caclpfinal
      ,      camtodiferir
      ,      camtodevengar
      ,      cadevacum
      ,      catipcamval
      ,      camtoliq
      ,      camtocalzado
      ,      calock
      ,      camarktomarket
      ,      capreciomtm
      ,      capreciofwd
      ,      camtomon1ini
      ,      camtomon1fin
      ,      camtomon2ini
      ,      camtomon2fin
      ,      caplazoope
      ,      caplazovto
      ,      caplazocal
      ,      cadiasdev
      ,      cadelusd
      ,      cadeluf
      ,      carevusd
      ,      carevuf
      ,      carevtot
      ,      cavalordia
      ,      cactacambio_a
      ,      cactacambio_c
      ,      cautildiferir
      ,      caperddiferir
      ,      cautildevenga
      ,      caperddevenga
      ,      cautilacum
      ,      caperdacum
      ,      cautilsaldo
      ,      caperdsaldo
      ,      caclpmoneda1
      ,      caclpmoneda2
      ,      camtocomp
      ,      caantici
      ,      cafecvenor
      ,      cabroker
      ,      cafecha
      ,      cavalorayer
      ,      camontopfe
      ,      camontocce
      ,      id_sistema
      ,      precio_transferencia
      ,      tipo_sintetico
      ,      precio_spot
      ,      pais_origen
      ,      moneda_compensacion
      ,      riesgo_sintetico
      ,      precio_reversa_sintetico
      ,      calzada
      ,      marca
      ,      numerointerfaz
      ,      contrato_entrega_via
      ,      contrato_emitido_por
      ,      contrato_ubicado_en
      ,      fechaemision
      ,      fecharecepcion
      ,      fechaingresocustodia
      ,      fechafirmacontrato
      ,      fecharetirocustodia
      ,      numerocontratocliente
      ,    capremio
      ,      catipopc
      ,      cahora
      ,      @primero
      ,      capreciopunta
      ,      caremunera_linea
      ,      catasa_efectiva_moneda1
      ,      catasa_efectiva_moneda2
      ,      catasaEfectMon1         
      ,      catasaEfectMon2         
      ,      catipcamSpot            
      ,      catipcamFwd             
      ,      cafecEfectiva           
      ,      caArea_Responsable
      ,      cacartera_normativa
      ,      casubcartera_normativa
      ,      calibro
      ,      fVal_Obtenido
      ,      fRes_Obtenido	
      ,      CaTasaSinteticaM1
      ,      CaTasaSinteticaM2
      ,      CaPrecioSpotVentaM1
      ,      CaPrecioSpotVentaM2
      ,      CaPrecioSpotCompraM1
      ,      CaPrecioSpotCompraM2     
      ,      caserie
      ,      caseriado
      ,      ValorRazonableActivo
 ,     ValorRazonablePasivo
      ,      mtm_hoy_moneda1
      ,   mtm_hoy_moneda2
      ,      catipcamPtosFwd
      ,      estado_sinacofi
      ,      fecha_estado_sina
      ,	     caAntPtosFwd
      ,	     caAntPtosCos
      ,	     caAntTasaPlazoRem
      ,	     caAntBase
      ,	     caAntForPagMdaComp
      ,	     caAntParContraMda
      ,	     caAntParMdaComp
      ,	     caAntFactorContMda
      ,	     caAntMtoMdaComp
      ,	     caAntDifCostUnitMerc
      ,	     caAntMTMCost
      ,	     caAntMargenContMda
      ,	     caAntValCLPContMda
      ,	     caAntCorrela
      ,      caAntPreOpEF  
      ,      Resultado_Mesa
      --PRD 12712
	  , bEarlyTermination
	  , FechaInicio
	  , Periodicidad
      FROM   MFCA
      WHERE  canumoper = @nnumoper

     IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización de Tabla Log'
      SET NOCOUNT OFF
      RETURN
     END

   INSERT INTO  MFCA
   SELECT * FROM #TEMP 
   
   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en Insert de Temporal a  Cartera'
      SET NOCOUNT OFF
      RETURN
   END


   IF   @nnocionalOrig <> @nnocional 
   BEGIN
   
     UPDATE MFCA SET  camtomon1 = camtomon1 * @nfact
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
                    , Resultado_Mesa       = @nResultadoMesa
   WHERE   canumoper   =  @nnumoper 
   SELECT  @nnumopOrig = @nnumop
    
   END
   ELSE
   BEGIN
   	UPDATE MFCA SET  cafecvcto         = @cfecant
                    ,caantici          = 'A'
                    ,camtomon1         = @nnocional         
                    ,precio_spot       = @nTasaAnti
                    ,capreant          = @nTasaCostAnti
                    ,catipmoda         = @cTipModa
                    ,cafecha           = @cfecIniOrig
                    ,caequmon1         = @nValPteTasaPact 
                    ,camtomon1fin      = @nValPteTasaPact 
                    ,caequusd2         = @nValPteTasaAnt
                    ,camtomon2ini      = @nValPteTasaAnt
                    ,precio_transferencia = @nValPteTasaCosto
                    ,caequmon2         = @nmtm
                    ,cadiferen         = @nmtm
                    ,camtomon2fin      = @nmtm 
                    ,cavalordia        = @nmtm   
                    ,caAntMTMCost      =  @nMTMCosto
                    ,camtocomp         = @nmtocompliq  
                    ,moneda_compensacion = @nmdacomp 
                    ,caAntForPagMdaComp = @nforpagMdaComp
                    ,caAntParContraMda = @nparcontmda
                    ,caAntParMdaComp   = @nparmdacomp
                    ,caAntFactorContMda = @nfactor  
                    ,caAntMtoMdaComp   = @nmtomoncomp
                    ,caAntMargenContMda = @nmargenhoycontmda
                    ,caAntValCLPContMda = @nvalorCLPcontmda
                    ,caspread           = @nanticipoCLP 
                    ,numerocontratocliente = @nnumoper
                    ,caAntCorrela       = @ncorrela
                    ,caestado           = ''
                    ,caoperador         = @coperador  
                    ,caplazovto        = DATEDIFF(dd,@cfecproc,@cfecant)
                    ,caplazocal        = DATEDIFF(dd,@cfecproc,@cfecant)
                    ,caplazo           = DATEDIFF(dd,@cfecproc,@cfecant)                
                    ,cafecvenor        = @cfecvctoOrig
                    ,caautoriza        = ''
                    ,caobserv          = '' 
                    ,caobservlin       = ''  
                    , Resultado_Mesa    = @nResultadoMesa
   WHERE canumoper   = @nnumoper 
   
   SELECT  @nnumopOrig = @nnumoper

   END 
   


   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización de Cartera'
      SET NOCOUNT OFF
      RETURN
   END


    IF ( @cTipModa = 'E' ) 
    BEGIN

      EXECUTE Sp_EnviarSpotAnticipo @nnumopOrig

    END 


    IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al ejecutar procedimiento Sp_EnviarSpotAnticipo '
      SET NOCOUNT OFF
      RETURN
    END

   COMMIT TRANSACTION

   SELECT @nnumopOrig, 'OK'

   SET NOCOUNT OFF
END

GO

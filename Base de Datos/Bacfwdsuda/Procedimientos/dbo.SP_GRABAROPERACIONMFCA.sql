USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAROPERACIONMFCA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_GRABAROPERACIONMFCA]     
                                        ( @nnumoper       NUMERIC (     10 ),    
                                          @ncodcart       NUMERIC ( 09, 00 ),    
                                          @ncodigo        NUMERIC ( 09, 00 ),    
                                          @ncodpos1       NUMERIC ( 02, 00 ),    
                                          @ncodmon1       NUMERIC ( 03, 00 ),    
                                          @ncodmon2       NUMERIC ( 03, 00 ),    
                                          @ctipoper       CHAR ( 1 )        ,    
                                          @ctipmoda       CHAR ( 1 )        ,    
                                          @dfecha         DATETIME          ,    
                                          @ntipcam        FLOAT             ,    
                                          @nmdausd        NUMERIC ( 03, 00 ),    
                                          @nmtomon1       NUMERIC ( 21, 04 ),    
                                          @nequusd1       NUMERIC ( 21, 04 ),    
                                          @nequmol1       NUMERIC ( 21, 04 ),    
                                          @nmtomon2       NUMERIC ( 21, 04 ),    
                                          @nequusd2       NUMERIC ( 21, 04 ),    
                                          @nequmol2       NUMERIC ( 21, 04 ),    
                                          @nparmon1       FLOAT             ,    
                                          @npremon1       FLOAT             ,    
                                          @nparmon2       FLOAT             ,    
                                          @npremon2       FLOAT             ,    
                                          @cestado        CHAR ( 1 )        ,    
                                          @cretiro        CHAR ( 1 )        ,    
                                          @ccontraparte   NUMERIC (  09 )   ,    
                                          @cobserv        VARCHAR ( 255 )   ,    
                                          @nspread        FLOAT             ,    
                                          @nprecal        FLOAT             ,    
                                          @nplazo         NUMERIC(06)       ,    
                                          @cfecvcto       DATETIME          ,    
                                          @clock          CHAR(15)          ,   --> CHAR(10)    
                                          @coperador      CHAR(15)          ,   --> CHAR(10)    
                                          @ntasausd       FLOAT             ,    
                                          @ntasacon       FLOAT             ,    
                                          @nfpagomn       NUMERIC ( 03, 00 ),    
                                          @nfpagomx       NUMERIC ( 03, 00 ),     
                                          @nMtoMon1ini    NUMERIC ( 21, 04 ),    
                                          @nMtoMon1fin    NUMERIC ( 21, 04 ),    
                                          @nMtoMon2ini    NUMERIC ( 21, 04 ),    
                                          @nMtoMon2fin    NUMERIC ( 21, 04 ),    
                                          @nentidad       NUMERIC ( 05, 00 ),    
                                          @ncodcli        NUMERIC ( 09, 00 ),    
                                          @nmtodif        NUMERIC ( 19,  0 ),    
                                          @nbroker        NUMERIC ( 09, 00 ),    
                                          @npremio        NUMERIC ( 21, 04 ),    
                                          @ctipopc        CHAR    (     01 ),    
                                          @precio_punta   FLOAT    ,    
                                          @remunera_linea   NUMERIC(10,04)  ,    
                                          @tasa_efectiva_moneda1 FLOAT ,    
                                          @tasa_efectiva_moneda2 FLOAT ,    
    
                                          @tasaefectmon1 FLOAT  = 0.0 ,    
                                          @tasaefectmon2            FLOAT    = 0.0 ,    
                                          @ntipcamSpot              FLOAT    = 0.0 ,    
                                          @ntipcamFwd               FLOAT    = 0.0 ,    
                                          @dfechaefect              DATETIME = @cfecvcto,    
    
                                          @cSerie                   VARCHAR(12) = '' ,    
                                          @cSeriado                 CHAR(1)     = '' ,        
       @CodAreaResponsable  CHAR(06)='' ,    
                                          @CodCartNorm   CHAR(06)='' ,    
                                          @CodSubCartNorm  CHAR(06)='' ,    
                                          @CodLibro   CHAR(06)=''     
                                          --> MX-$    
                                      ,   @nCostoUSDCLP             FLOAT          = 0.0    
                                      ,   @nCostoMxUSD              FLOAT          = 0.0    
                                      ,   @nCostoMxCLP              FLOAT          = 0.0    
                                      ,   @iRefTc                   INT        = 0.0    
                                      ,   @iRefParidad              INT        = 0.0    
                                      ,   @dRefTc                   DATETIME       = ''    
                                      ,   @dRefParidad              DATETIME       = ''    
                                      ,   @nTipCamUSDCLP            FLOAT          = 0.0    
                                      ,   @nSpotTc                  FLOAT          = 0.0    
                                      ,   @nSpotParidad             FLOAT          = 0.0    
                                      ,   @nResultadoMesa           FLOAT          = 0.0    
                                      ,   @cFecStarting              DATETIME       = ''     
                                      ,   @cFecFijacionStarting     DATETIME       = ''     
                                      ,   @nPtosTransfObs           FLOAT          = 0.0     
                                      ,   @nPtosTransfFwd           FLOAT          = 0.0     
                                      ,   @nPtosFwdCierre           FLOAT          = 0.0     
          ,   @nResultadoComex     FLOAT          = 0.0    
           ,   @Calvtadol                FLOAT          = 1   --> Marca para los Fw Asiaticos (1 seg Cambio; 14, fw Obsr; 15 fw Asiatico)             
                                        )    
AS    
BEGIN    
   SET NOCOUNT ON    
   DECLARE @dfecproc    DATETIME    
   DECLARE @hora    CHAR(8)    
   DECLARE @primero CHAR(1)    
   SELECT @primero = 'S'    
   SELECT @hora = CONVERT( CHAR(08), GETDATE() , 108 )    
   SELECT @dfecproc = acfecproc FROM MFAC    
    
    
   UPDATE mfmoh SET mocodpos1     = @ncodpos1    ,    
                    mocodmon1     = @ncodmon1    ,    
                    mocodmon2     = @ncodmon2    ,    
                    mocodcart     = @ncodcart    ,    
                    mocodigo      = @ncodigo     ,    
                    motipoper     = @ctipoper    ,    
                    motipmoda     = @ctipmoda    ,    
                    mofecha       = @dfecha      ,    
                    motipcam      = @ntipcam     ,    
                    momdausd      = @nmdausd     ,    
                    momtomon1     = @nmtomon1    ,    
                    moequusd1     = @nequusd1    ,    
                    moequmon1     = @nequmol1    ,    
                    momtomon2     = @nmtomon2    ,    
                    moequusd2     = @nequusd2    ,    
                    moequmon2     = @nequmol2    ,    
                    moparmon1     = @nparmon1    ,    
                    mopremon1     = @npremon1    ,    
                    moparmon2     = @nparmon2    ,    
                   mopremon2     = @npremon2    ,    
                    moestado      = @cestado     ,    
                    moretiro      = @cretiro     ,    
                    mocontraparte = @ccontraparte,    
                    moobserv      = @cobserv     ,    
                    mospread      = @nspread     ,    
                    moprecal      = @nprecal     ,    
         moplazo       = @nplazo      ,    
                    mofecvcto     = @cfecvcto    ,    
                    molock        = @clock       ,    
                    mooperador    = @coperador   ,    
                    motasausd     = @ntasausd    ,    
                    motasacon     = @ntasacon    ,    
                    mofpagomn     = @nfpagomn    ,    
                    mofpagomx     = @nfpagomx    ,    
                    momtomon1ini  = @nMtoMon1ini ,    
                    momtomon1fin  = @nMtoMon1fin ,    
                    momtomon2ini  = @nMtoMon2ini ,    
                    momtomon2fin  = @nMtoMon2fin ,    
                    mocodsuc1     = @nentidad    ,    
                    mocodcli      = @ncodcli     ,    
                    modiferen     = @nmtodif     ,    
                    mobroker      = @nbroker     ,    
                    mopremio      = @npremio     ,    
                    motipopc      = @ctipopc  ,    
                    mohora   = @hora  ,    
                    mopreciopunta = @precio_punta,    
                    moremunera_linea = @remunera_linea ,    
                    motasa_efectiva_moneda1 = @tasa_efectiva_moneda1 ,    
                    motasa_efectiva_moneda2 = @tasa_efectiva_moneda2,    
    
                    motasaEfectMon1         = @tasaefectmon1  ,    
                    motasaEfectMon2         = @tasaefectmon2  ,    
                    motipcamSpot            = @ntipcamSpot  ,    
                    motipcamFwd             = @ntipcamFwd  ,    
                    mofecEfectiva           = @dfechaefect  ,    
                    moserie                 = @cSerie   ,    
                    moseriado               = @cSeriado   ,    
      moArea_Responsable  = @CodAreaResponsable ,    
                    mocartera_normativa  = @CodCartNorm  ,    
                    mosubcartera_normativa = @CodSubCartNorm ,    
                    molibro   = @CodLibro      
                   -->    MX-$    
             ,      mocosto_usdclp          = @nCostoUSDCLP    
             ,      mocosto_mxusd           = @nCostoMxUSD    
             ,      mocosto_mxclp           = @nCostoMxCLP    
             ,      mocodpos2               = @iRefTc    
             ,      mofijaTCRef             = @dRefTc    
             ,      mofijaPRRef             = @dRefParidad    
             ,      moSpotTipCam            = @nSpotTc    
             ,      moSpotParidad           = @nSpotParidad    
             -->    Resultado Mesa de Distribucion    
             ,      Resultado_Mesa          = @nResultadoMesa    
             -->    PRD-5522    
             ,      MoFechaStarting         = @cFecStarting    
             ,      MoFechaFijacionStarting = @cFecFijacionStarting    
             ,      MoPuntosTransfObs       = @nPtosTransfObs    
             ,      MoPuntosTransfFwd       = @nPtosTransfFwd    
             ,      MoPuntosFwdCierre       = @nPtosFwdCierre     
             --> Marca Fw Asiatico   
    ,     MoCalvtadol    = @Calvtadol  
    WHERE           monumoper     = @nnumoper    
    
 
 IF EXISTS( SELECT 1 FROM MFCA_LOG WHERE caestado = 'M' AND CONVERT(CHAR(8),cafecmod,112) = CONVERT(CHAR(8),@dfecproc,112) AND canumoper = @nnumoper)    
  BEGIN    
   SELECT @primero = 'N'    
  END    
   INSERT INTO mfca_log( canumoper               ,    
                         cacodpos1               ,    
                         cacodmon1               ,    
                         cacodsuc1               ,    
--                         cacodpos2               ,    
                         cacodmon2               ,    
   cacodcart               ,    
                         cacodigo                ,    
                         cacodcli                ,    
                         catipoper               ,    
                         catipmoda               ,    
                         cafecha                 ,    
                         catipcam                ,    
                         camdausd                ,    
                         camtomon1               ,    
                         caequusd1               ,    
                         caequmon1               ,    
camtomon2               ,    
                         caequusd2               ,    
                         caequmon2               ,    
                         caparmon1               ,    
                         capremon1               ,    
                         caparmon2               ,    
                         capremon2               ,    
                         caestado                ,    
                         caretiro                ,    
                         cacontraparte           ,    
                         caobserv                ,    
                         captacom                ,    
                         captavta                ,    
                         caspread                ,    
                         -->cacolmon1               ,    
                         cacapmon1               ,    
                         catasadolar             ,    
                         catasaufclp             ,    
                         caprecal                ,    
                         caplazo                 ,    
       cafecvcto               ,    
                         capreant                ,    
                         cavalpre                ,    
                         caoperador              ,    
                         catasfwdcmp             ,    
                         catasfwdvta             ,    
                         cacalcmpdol             ,    
                         cacalcmpspr             ,    
                         cacalvtadol             ,    
                         cacalvtaspr             ,    
                         catasausd               ,    
                         catasacon               ,    
                         cadiferen               ,    
                         cafpagomn               ,    
                         cafpagomx               ,    
                         cadiftipcam             ,    
                         cadifuf                 ,    
                         caclpinicial            ,    
                         caclpfinal              ,    
                         camtodiferir            ,    
                         camtodevengar           ,    
                         cadevacum               ,    
                         catipcamval             ,    
                         camtoliq                ,    
                         camtocalzado            ,    
                         calock                  ,    
                         camarktomarket          ,    
                         capreciomtm             ,    
             capreciofwd             ,    
       camtomon1ini            ,    
                         camtomon1fin            ,    
                         camtomon2ini            ,    
                         camtomon2fin            ,    
                         caplazoope              ,    
                         caplazovto              ,    
                         caplazocal              ,    
                         cadiasdev               ,    
                         cadelusd                ,    
                         cadeluf                 ,    
                         carevusd                ,    
                         carevuf                 ,    
                         carevtot                ,    
                         cavalordia              ,    
                         cactacambio_a           ,    
                         cactacambio_c        ,    
                         cautildiferir           ,    
                         caperddiferir           ,    
                         cautildevenga           ,    
                         caperddevenga           ,    
                         cautilacum              ,    
                         caperdacum              ,    
                         cautilsaldo             ,    
                         caperdsaldo             ,    
                         caclpmoneda1            ,    
                         caclpmoneda2            ,    
                         camtocomp               ,    
                         caantici                ,    
                         cafecvenor              ,    
           cabroker                ,    
                         cafecmod                ,    
                         cavalorayer             ,    
                         camontopfe              ,    
                         camontocce              ,    
                         id_sistema              ,    
                         precio_transferencia    ,    
                         tipo_sintetico          ,    
                         precio_spot             ,    
                         pais_origen             ,    
                         moneda_compensacion     ,    
                         riesgo_sintetico        ,    
                         precio_reversa_sintetico,    
                         calzada                 ,    
                         marca                   ,    
                         numerointerfaz          ,    
                         contrato_entrega_via    ,    
                         contrato_emitido_por    ,    
                         contrato_ubicado_en     ,    
                         fechaemision      ,    
                         fecharecepcion          ,    
                         fechaingresocustodia    ,    
                         fechafirmacontrato      ,    
                         fecharetirocustodia     ,    
                         numerocontratocliente   ,    
                         capremio                ,    
                         catipopc   ,    
           cahora    ,    
           caprimero   ,    
           capreciopunta   ,    
           caremunera_linea  ,    
           catasa_efectiva_moneda1 ,    
           catasa_efectiva_moneda2 ,    
           catasaEfectMon1 ,    
           catasaEfectMon2 ,    
           catipcamSpot  ,    
           catipcamFwd  ,    
           cafecEfectiva  ,    
    caArea_Responsable ,    
                         cacartera_normativa  ,     
                         casubcartera_normativa  ,    
                         calibro       
   ,fVal_Obtenido    
   ,fRes_Obtenido    
   ,CaTasaSinteticaM1    
   ,CaTasaSinteticaM2    
   ,CaPrecioSpotVentaM1    
   ,CaPrecioSpotVentaM2    
   ,CaPrecioSpotCompraM1    
   ,CaPrecioSpotCompraM2    
                        ,caserie    
                        ,caseriado    
                        , ValorRazonableActivo      
                        , ValorRazonablePasivo    
                        , mtm_hoy_moneda1    
                        , mtm_hoy_moneda2    
    
                        --> MX-$    
                        ,   cacosto_usdclp    
                        ,   cacosto_mxusd    
                        ,   cacosto_mxclp    
                        ,   cacodpos2    
                        ,   cacolmon1    
                        ,   cafijaTCRef    
                        ,   cafijaPRRef    
                        ,   caSpotTipCam    
                        ,   caSpotParidad    
                        --> Resultado Mesa de Distribucion    
                        ,   Resultado_Mesa    
                        --> PRD-5522    
                        ,   CaFechaStarting             
                        ,   CaFechaFijacionStarting     
                        ,   CaPuntosTransfObs           
                        ,   CaPuntosTransfFwd           
                        ,   CaPuntosFwdCierre           
						--PRD 12712
						,bEarlyTermination
						,FechaInicio
						,Periodicidad
                      )    
   SELECT                canumoper               ,    
                         cacodpos1               ,    
                         cacodmon1               ,    
                         cacodsuc1               ,    
--                         cacodpos2               ,    
                         cacodmon2               ,    
                         cacodcart               ,    
                         cacodigo                ,    
                         cacodcli                ,    
                         catipoper               ,    
                         catipmoda               ,    
                         cafecha                 ,    
                         catipcam                ,    
                         camdausd                ,    
                         camtomon1               ,    
                         caequusd1               ,    
                  caequmon1               ,    
                         camtomon2               ,    
                         caequusd2               ,    
                         caequmon2               ,    
                         caparmon1               ,    
                         capremon1               ,    
                         caparmon2               ,    
                         capremon2               ,    
                         'M'                     ,    
                         caretiro                ,    
                         cacontraparte           ,    
                         caobserv                ,    
                         captacom                ,    
                         captavta                ,    
                         caspread                ,    
--                         cacolmon1               ,    
                         cacapmon1               ,    
                         catasadolar             ,    
                         catasaufclp             ,    
                         caprecal                ,    
                         caplazo                 ,    
                         cafecvcto               ,    
                         capreant                ,    
                         cavalpre                ,    
                         caoperador              ,    
                         catasfwdcmp             ,    
                         catasfwdvta             ,    
                         cacalcmpdol     ,    
                         cacalcmpspr             ,    
                         cacalvtadol             ,    
                         cacalvtaspr             ,    
                         catasausd               ,    
                         catasacon               ,    
                         cadiferen               ,    
                         cafpagomn               ,    
                         cafpagomx               ,    
                         cadiftipcam             ,    
                         cadifuf                 ,    
                         caclpinicial            ,    
                         caclpfinal              ,    
                         camtodiferir            ,    
                         camtodevengar           ,    
                         cadevacum               ,    
                         catipcamval             ,    
                         camtoliq                ,    
                         camtocalzado            ,    
                         calock                  ,    
                         camarktomarket          ,    
                         capreciomtm             ,    
                         capreciofwd             ,    
                         camtomon1ini            ,    
                         camtomon1fin            ,    
                         camtomon2ini            ,    
                         camtomon2fin            ,    
                         caplazoope              ,    
                         caplazovto              ,    
                         caplazocal              ,    
                         cadiasdev        ,    
                         cadelusd                ,    
                         cadeluf                 ,    
                         carevusd                ,    
                         carevuf                 ,    
                         carevtot                ,    
                  cavalordia   ,    
                         cactacambio_a           ,    
                         cactacambio_c           ,    
                         cautildiferir           ,    
                         caperddiferir           ,    
                         cautildevenga           ,    
                         caperddevenga           ,    
                         cautilacum              ,    
                         caperdacum              ,    
                         cautilsaldo             ,    
                         caperdsaldo             ,    
                         caclpmoneda1            ,    
                         caclpmoneda2            ,    
                         camtocomp               ,    
                         caantici                ,    
                         cafecvenor              ,    
                         cabroker                ,    
                         @dfecproc               ,    
                         cavalorayer             ,    
                         camontopfe              ,    
                         camontocce              ,    
                         id_sistema              ,    
                         precio_transferencia    ,    
                         tipo_sintetico          ,    
                         precio_spot             ,    
                         pais_origen             ,    
                         moneda_compensacion     ,    
                         riesgo_sintetico        ,    
                         precio_reversa_sintetico,    
                         calzada                 ,    
                         marca                   ,    
                         numerointerfaz          ,    
                         contrato_entrega_via    ,    
                         contrato_emitido_por    ,    
                         contrato_ubicado_en     ,    
                         fechaemision            ,    
                         fecharecepcion          ,    
                         fechaingresocustodia    ,    
                         fechafirmacontrato      ,    
                         fecharetirocustodia     ,    
                         numerocontratocliente   ,    
                         capremio                ,    
                   catipopc   ,    
    cahora    ,    
    @primero   ,    
    capreciopunta   ,    
    caremunera_linea  ,    
    catasa_efectiva_moneda1 ,    
                         catasa_efectiva_moneda2,    
                         catasaEfectMon1 ,    
                         catasaEfectMon2 ,    
                         catipcamSpot  ,    
                         catipcamFwd  ,    
                         cafecEfectiva  ,    
    caArea_Responsable ,    
                         cacartera_normativa  ,    
                         casubcartera_normativa  ,    
                         calibro      
   ,fVal_Obtenido    
   ,fRes_Obtenido    
   ,CaTasaSinteticaM1    
   ,CaTasaSinteticaM2    
   ,CaPrecioSpotVentaM1    
   ,CaPrecioSpotVentaM2    
   ,CaPrecioSpotCompraM1    
   ,CaPrecioSpotCompraM2    
                        ,caserie    
                        ,caseriado    
                        , ValorRazonableActivo      
                        , ValorRazonablePasivo    
                        , mtm_hoy_moneda1    
                        , mtm_hoy_moneda2    
                        --> MX-$    
                        ,   cacosto_usdclp    
                        ,   cacosto_mxusd    
                        ,   cacosto_mxclp    
                        ,   cacodpos2    
                        ,   cacolmon1    
                        ,   cafijaTCRef    
                        ,   cafijaPRRef    
                        ,   caSpotTipCam    
               ,   caSpotParidad    
                        --> Resultado Mesa de Distribucion    
                        ,   Resultado_Mesa    
                        --> PRD-5522    
                        ,      CaFechaStarting             
                        ,      CaFechaFijacionStarting     
                        ,      CaPuntosTransfObs           
                        ,      CaPuntosTransfFwd           
                        ,      CaPuntosFwdCierre   
                        --PRD 12712
						, bEarlyTermination
						, FechaInicio
						, Periodicidad        
    
   FROM                  mfca    
   WHERE                 canumoper = @nnumoper    
    
    
   UPDATE mfca SET cacodpos1     = @ncodpos1    ,    
                   cacodmon1     = @ncodmon1    ,    
                   cacodmon2     = @ncodmon2    ,    
                   cacodcart     = @ncodcart    ,    
                   cacodigo      = @ncodigo     ,    
                   catipoper     = @ctipoper    ,    
                   catipmoda     = @ctipmoda    ,    
                   cafecha       = @dfecha      ,    
                   catipcam      = @ntipcam     ,    
                   camdausd      = @nmdausd     ,    
                   camtomon1     = @nmtomon1    ,    
                   caequusd1     = @nequusd1    ,    
                   caequmon1     = @nequmol1    ,    
                   camtomon2     = @nmtomon2    ,    
                   caequusd2     = @nequusd2  ,    
                   caequmon2     = @nequmol2    ,    
                   caparmon1     = @nparmon1    ,    
                   capremon1     = @npremon1    ,    
                   caparmon2     = @nparmon2    ,    
                   capremon2     = @npremon2    ,    
                   caestado      = @cestado     ,    
                   caretiro      = @cretiro     ,    
                   cacontraparte = @ccontraparte,    
                   caobserv      = @cobserv     ,    
                   caspread      = @nspread     ,    
                   caprecal      = @nprecal     ,    
                   caplazo       = @nplazo      ,    
                   cafecvcto     = @cfecvcto    ,    
                   caoperador    = @coperador   ,    
                   catasausd     = @nTasaUsd    ,    
                   catasacon     = @nTasaCon    ,    
                   cafpagomn     = @nfpagomn    ,    
                   cafpagomx     = @nfpagomx    ,    
                   camtomon1ini  = @nMtoMon1ini ,    
                   camtomon1fin  = @nMtoMon1fin ,    
                   camtomon2ini  = @nMtoMon2ini ,    
                   camtomon2fin  = @nMtoMon2fin ,    
                   cacodsuc1     = @nentidad    ,    
                   cacodcli      = @ncodcli     ,    
                   cadiferen     = @nMtoDif     ,    
                   cabroker      = @nbroker     ,    
                   capremio      = @npremio     ,    
                   catipopc      = @ctipopc ,    
                   cahora  = @hora ,    
                   capreciopunta = @precio_punta,    
                   caremunera_linea = @remunera_linea    ,    
                   catasa_efectiva_moneda1 = @tasa_efectiva_moneda1 ,    
                   catasa_efectiva_moneda2 = @tasa_efectiva_moneda2 ,    
    catasaEfectMon1         = @tasaefectmon1  ,    
                   catasaEfectMon2         = @tasaefectmon2  ,    
                   catipcamSpot            = @ntipcamSpot  ,    
                   catipcamFwd             = @ntipcamFwd  ,    
                   cafecEfectiva           = @dfechaefect  ,    
                   caserie                 = @cSerie   ,    
                   caseriado               = @cSeriado   ,    
     caArea_Responsable  = @CodAreaResponsable ,    
                   cacartera_normativa  = @CodCartNorm  ,    
                   casubcartera_normativa = @CodSubCartNorm ,    
                   calibro   = @CodLibro    
                  -->    MX-$    
            ,      cacosto_usdclp           = @nCostoUSDCLP    
            ,      cacosto_mxusd            = @nCostoMxUSD    
            ,      cacosto_mxclp   = @nCostoMxCLP    
            ,      cacodpos2                = @iRefTc    
            ,      cacolmon1                = @iRefParidad    
            ,      cafijaTCRef              = @dRefTc    
            ,      cafijaPRRef              = @dRefParidad    
            ,      cavalpre                 = @nTipCamUSDCLP    
            ,      caSpotTipCam             = @nSpotTc    
            ,      caSpotParidad            = @nSpotParidad    
            -->    Resultado de mesa de Distribucion    
            ,      Resultado_Mesa           = @nResultadoMesa    
            -->    PRD-5522    
            ,      CaFechaStarting         = @cFecStarting    
            ,      CaFechaFijacionStarting = @cFecFijacionStarting    
            ,      CaPuntosTransfObs       = @nPtosTransfObs    
            ,      CaPuntosTransfFwd       = @nPtosTransfFwd    
            ,      CaPuntosFwdCierre       = @nPtosFwdCierre     
     ,      cadevacum      = @nResultadoComex    
   -->    Marca Fw Asiatico   
   ,    caCalvtadol    = @Calvtadol  
   WHERE           canumoper                = @nnumoper    
    
   IF @ctipoper = 'C' OR @ctipoper = 'O'    
   BEGIN    
      IF EXISTS ( SELECT ccmonto    
                  FROM   MFCC    
                  WHERE  ccopecmp = @nnumoper    
                )    
      BEGIN    
         UPDATE MFCA    
         SET    camtocalzado = 0    
         WHERE  canumoper = @nnumoper    
         UPDATE mfca    
         SET    camtocalzado = camtocalzado - ccmonto     
         FROM   mfca,    
                mfcc    
         WHERE  canumoper = ccopevta  AND    
                ccopecmp  = @nnumoper    
         DELETE MFCC    
         WHERE  ccopecmp = @nnumoper    
      END    
   END    
   ELSE IF @ctipoper = 'V' OR @ctipoper = 'A'    
   BEGIN    
      IF EXISTS ( SELECT ccmonto    
                  FROM   MFCC    
                  WHERE  ccopevta = @nnumoper    
                )    
      BEGIN    
         UPDATE MFCA    
         SET    camtocalzado = 0    
         WHERE  canumoper = @nnumoper    
         UPDATE mfca    
         SET    camtocalzado = camtocalzado - ccmonto     
         FROM   mfca,    
                mfcc    
         WHERE  canumoper = ccopecmp  AND    
                ccopevta  = @nnumoper    
         DELETE MFCC    
         WHERE  ccopevta = @nnumoper    
      END    
   END    

	-->		cambia el estado del impresion del Faz de confirmación
	UPDATE	dbo.Tbl_Impresion_Fax
	SET		Modifica		= 1
	,		FechaModifica	= GETDATE()
	WHERE	Modulo			= 'BFW'
	AND		Folio			= @nnumoper
	-->		cambia el estado del impresion del Faz de confirmación

   SELECT @nnumoper, 'OK'    
   SET NOCOUNT OFF    
END  

GO

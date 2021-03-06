USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAROPERACION]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABAROPERACION]
   (   @nnumoper                 NUMERIC(10)  
   ,   @ncodcart                 NUMERIC(09)  
   ,   @ncodigo                  NUMERIC(09)  
   ,   @ncodpos1                 NUMERIC(02)  
   ,   @ncodmon1				 NUMERIC(03)  
   ,   @ncodmon2                 NUMERIC(03)  
   ,   @ctipoper                 CHAR(1)  
   ,   @ctipmoda                 CHAR(1)  
   ,   @dfecha                   DATETIME  
   ,   @ntipcam                  FLOAT  
   ,   @nmdausd                  NUMERIC(03,0)  
   ,   @nmtomon1				 NUMERIC(21,4) --> 12  
   ,   @nequusd1                 NUMERIC(21,4) --> 13            
   ,   @nequmol1                 NUMERIC(21,4) --> 14  
   ,   @nmtomon2				 NUMERIC(21,4) --> 15  
   ,   @nequusd2                 NUMERIC(21,4) --> 16  
   ,   @nequmol2                 NUMERIC(21,4) --> 17  
   ,   @nparmon1				 FLOAT         --> 18  
   ,   @npremon1                 FLOAT         --> 19  
   ,   @nparmon2                 FLOAT         --> 20  
   ,   @npremon2                 FLOAT         --> 21  
   ,   @cestado                  CHAR(1)  
   ,   @cretiro                  CHAR(1)  
   ,   @ccontraparte             NUMERIC(09)  
   ,   @cobserv                  VARCHAR(255)  
   ,   @nspread                  FLOAT  
   ,   @nprecal                  FLOAT         --> 27  
   ,   @nplazo                   NUMERIC(06)   --> 28  
   ,   @cfecvcto                 DATETIME      --> 29  
   ,   @clock                    CHAR(15)      --> 30  
   ,   @coperador                CHAR(15)  
   ,   @ntasausd                 FLOAT  
   ,   @ntasacon                 FLOAT  
   ,   @nfpagomn                 NUMERIC(03)  
   ,   @nfpagomx                 NUMERIC(03)  
   ,   @nMtoMon1ini              NUMERIC(21,4) --> 36  
   ,   @nMtoMon1fin              NUMERIC(21,4) --> 37  
   ,   @nMtoMon2ini              NUMERIC(21,4) --> 38  
   ,   @nMtoMon2fin              NUMERIC(21,4) --> 39  
   ,   @nentidad                 NUMERIC(05,0) --> 40  
   ,   @ncodcli                  NUMERIC(09)  
   ,   @nMtoDif                  NUMERIC(19,0)  
   ,   @nBroker                  NUMERIC(09,0)  
   ,   @nMontoPFE                NUMERIC(24,1)  = 0  
   ,   @nMontoCCE                NUMERIC(24,1)  = 0  
       --------------------------  
   ,   @id_sistema               CHAR(03)       = ''  
   ,   @Precio_Transferencia     NUMERIC(21,11) = 00  
   ,   @Tipo_Sintetico           CHAR(03)       = ''  
   ,   @Precio_Spot              NUMERIC(10,4)  = 00  
   ,   @Pais_Origen              NUMERIC(05,00) = 00 --> 50  
   ,   @Moneda_Compensacion      NUMERIC(05,00) = 00  
   ,   @Riesgo_Sintetico         CHAR(03)       = ''  
   ,   @Precio_Reversa_Sintetico NUMERIC(10,04) = 00  
   ,   @npremio                  NUMERIC(21,4)  
   ,   @ctipopc                  CHAR(01)  
   ,   @precio_punta             FLOAT  
   ,   @remunera_linea           NUMERIC(10,04)  
   ,   @tasa_efectiva_moneda1    FLOAT  
   ,   @tasa_efectiva_moneda2    FLOAT  
   ,   @relacionada_spot         CHAR(2)			--> 60
   ,   @tasaefectmon1            FLOAT          = 0.0  
   ,   @tasaefectmon2            FLOAT          = 0.0  
   ,   @ntipcamSpot              FLOAT          = 0.0  
   ,   @ntipcamFwd               FLOAT          = 0.0  
   ,   @dfechaefect              DATETIME       = @cfecvcto  
   ,   @Serie                    VARCHAR(12)    = ''  
   ,   @Seriado                  CHAR(1)        = ''
   ,   @ntipcamPtosFwd           FLOAT          = 0.0  
   ,   @CodAreaResponsable		 CHAR(06)       = ''  
   ,   @CodCartNorm				 CHAR(06)       = '' --> 70
   ,   @CodSubCartNorm			 CHAR(06)       = '' 
   ,   @CodLibro                 CHAR(06)       = ''  
   ,   @estadoSina				 CHAR(25)       = ''  
   ,   @fechaSina                DATETIME       = ''  
  
   --> MX-$  
   ,   @nCostoUSDCLP             FLOAT          = 0.0  
   ,   @nCostoMxUSD    FLOAT       = 0.0  
 ,  @nCostoMxCLP              FLOAT          = 0.0  
   ,   @iRefTc                   INT        = 0.0  
   ,   @iRefParidad				 INT  = 0.0  
   ,   @dRefTc                   DATETIME       = ''  --> 80
   ,   @dRefParidad              DATETIME       = ''  
   ,   @nTipCamUSDCLP            FLOAT          = 0.0  
   ,   @nSpotTc                  FLOAT          = 0.0  
   ,   @nSpotParidad             FLOAT          = 0.0
   --> Resultado de la Mesa de Distribucion  
   ,   @nResultadoMesa           FLOAT          = 0.0  
  
   ,   @cFecStarting             DATETIME       = ''   
   ,   @cFecFijacionStarting     DATETIME       = ''   
   ,   @nPtosTransfObs           FLOAT          = 0.0   
   ,   @nPtosTransfFwd           FLOAT          = 0.0   
   ,   @nPtosFwdCierre           FLOAT          = 0.0   -->90
  
   ,   @nResultadoComex          FLOAT          = 0.0 --> 91
   ,   @NroOpeRelMxClp			 INT = 0			  --> 92
   ,   @Calvtadol                FLOAT          = 1	  --> 93		--> Marca para los Fw Asiaticos (1 seg Cambio; 14, fw Obsr; 15 fw Asiatico)
   ,   @Novacion				 INT			= 0   --> 94		--Prd_19146 Comder
  
   ,   @BrokerComDer		     INT            = 0   --> 95        --PRD 19111 ComboBox Broker   
                    		                        -- 
   ,   @bEarlyTermination        BIT            = 0	  --> 96				-- PRD 12712
   ,   @FechaInicio              DATETIME		= ''  --> 97 --'19000101'   -- PRD 12712
   ,   @Periodicidad             TINYINT        = 0	  --> 98				-- PRD 12712
      
  
  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @Estado        NUMERIC(1)  
   DECLARE @xtipoper      CHAR(3)  
   DECLARE @xmoneda       CHAR(3)  
   DECLARE @xvamos        CHAR(1)      
   DECLARE @xFormaPago    CHAR(4)  
   DECLARE @xMonto        NUMERIC(21,4)  
   DECLARE @nError        INT  
   DECLARE @hora          CHAR(8)  
   DECLARE @primero       CHAR(1)  
   DECLARE @oldMonto      NUMERIC(21,04)  
   DECLARE @oldTC         NUMERIC(14,04)  
   DECLARE @TipMer        CHAR(04)  
   DECLARE @oldTipMer     CHAR(04)  
   DECLARE @oldTipOper    CHAR(01)  
   DECLARE @oldCartera    NUMERIC(09)  
   DECLARE @TipOper_spot  CHAR(01)  
   DECLARE @afecta_hedge  INT  
   DECLARE @cfecprox      DATETIME            
   DECLARE @vcto          NUMERIC(01)  
   DECLARE @nmtomon1Vcto  NUMERIC (21,04)   
   DECLARE @mocodcli  numeric(9,0)  
   DECLARE @monomcli  char(35)   
   DECLARE @monumope  numeric(7,0)      
   DECLARE @numoperaux  numeric(9)  
   DECLARE @cFechaProc    DATETIME  
   DECLARE @ActivaComder VARCHAR(1) --Prd_19146 Comder
   DECLARE @nnumopeRelSpot  NUMERIC(10)  --PRD_21645
   DECLARE @nnumopeRelSpotMod  NUMERIC(10)  --PRD_21645
   
   
   SET @nnumopeRelSpot = @nnumoper --PRD_21645
      
   SELECT	@cfecprox		= acfecprox   
   ,		@cFechaProc		= acfecproc  
   ,		@ActivaComder	= acswActivaComder --Prd_19146 Comder
   FROM		MFAC with (nolock)  


  DECLARE @cliente INT 
  SET @cliente = @ncodigo
  
   SET @vcto         = CASE WHEN @cfecvcto = @cfecprox THEN 1 ELSE 0 END  
   SET @nmtomon1Vcto = CASE WHEN @cfecvcto = @cfecprox THEN @nmtomon1 * -1 ELSE @nmtomon1 END  
   SET @primero      = 'S'  
   SET @hora         = CONVERT(CHAR(08),GETDATE(),108)  
   SET @relacionada_spot  = CASE WHEN @ncodpos1 = 14 THEN '09' ELSE  @relacionada_spot END  
  
   IF @nnumoper <> 0  
   BEGIN  
      IF @ncodpos1 in ( 1, 4, 5, 6, 7, 12 )  
      BEGIN  
  
         SELECT  @oldMonto      = momtomon1 * (-1)  
         ,       @oldTC         = motipcamPtosFwd --motipcam    
         ,       @oldTipOper    = motipoper  
         ,       @oldCartera    = mocodcart  
         ,       @afecta_hedge = rcnumcorr  
         FROM    MFMO           with (nolock)  
                 INNER JOIN BacParamSuda..TIPO_CARTERA with (nolock) ON rcsistema = 'BFW' AND rcrut = mocodcart AND rccodpro = mocodpos1  
         WHERE   monumoper      = @nnumoper   
  
         SET @oldTipMer = 'FUTU'  
      END  
  
      IF @ncodpos1 = 5  
      BEGIN  
         SET @oldTipMer  = '1446'  
         SET @oldTipOper = CASE WHEN @oldTipOper = 'O' THEN 'C' ELSE 'V' END  
      END  
  
      UPDATE MFMO  with (rowlock)  
      SET    mocodpos1               = @ncodpos1  
      ,      mocodmon1               = @ncodmon1  
      ,      mocodmon2               = @ncodmon2  
      ,      mocodcart               = @ncodcart  
      ,      mocodigo                = @ncodigo  
      ,      motipoper               = @ctipoper  
      ,      motipmoda               = @ctipmoda  
      ,      mofecha			     = @dfecha  
      ,      motipcam                = @ntipcam  
      ,      momdausd                = @nmdausd  
      ,      momtomon1               = @nmtomon1  
      ,      moequusd1               = @nequusd1  
      ,      moequmon1               = @nequmol1  
      ,      momtomon2               = @nmtomon2  
      ,      moequusd2               = @nequusd2  
      ,      moequmon2               = @nequmol2  
      ,      moparmon1               = @nparmon1  
      ,      mopremon1               = @npremon1  
      ,      moparmon2               = @nparmon2  
      ,      mopremon2               = @npremon2  
	  ,      moestado                = @cestado  
      ,      moretiro                = @cretiro  
      ,      mocontraparte           = @ccontraparte  
      ,      moobserv                = @cobserv  
      ,      mospread                = @nspread  
      ,      moprecal                = @nprecal  
      ,      moplazo                 = @nplazo  
      ,      mofecvcto               = @cfecvcto  
      ,      molock                  = @clock  
      ,      mooperador              = @coperador  
      ,      motasausd               = @ntasausd  
      ,      motasacon               = @ntasacon  
      ,      mofpagomn               = @nfpagomn  
      ,      mofpagomx               = @nfpagomx  
      ,      momtomon1ini            = @nMtoMon1ini  
      ,      momtomon1fin            = @nMtoMon1fin  
      ,      momtomon2ini            = @nMtoMon2ini  
      ,      momtomon2fin            = @nMtoMon2fin  
      ,      mocodsuc1               = @nentidad  
      ,      mocodcli                = @ncodcli  
      ,      modiferen               = @nmtodif  
      ,      mobroker                = @nbroker  
      ,      mopremio                = @npremio  
      ,      motipopc                = @ctipopc  
      ,      mohora                  = @hora  
      ,      mopreciopunta           = @precio_punta  
      ,      moremunera_linea        = @remunera_linea  
      ,      motasa_efectiva_moneda1 = @tasa_efectiva_moneda1  
      ,      motasa_efectiva_moneda2 = @tasa_efectiva_moneda2  
      ,      motasaEfectMon1         = @tasaefectmon1  
      ,      motasaEfectMon2         = @tasaefectmon2  
      ,      motipcamSpot            = @ntipcamSpot  
      ,      motipcamFwd             = @ntipcamFwd  
      ,      mofecEfectiva           = @dfechaefect  
      ,      moserie                 = @Serie  
      ,      moseriado               = @Seriado  
      ,      motipcamPtosFwd         = @ntipcamPtosFwd  
      ,      moArea_Responsable      = @CodAreaResponsable  
      ,      mocartera_normativa     = @CodCartNorm  
      ,      mosubcartera_normativa  = @CodSubCartNorm  
      ,      molibro                 = @CodLibro  
      ,      estado_sinacofi         = @estadoSina  
      ,      fecha_estado_sina       = @fechaSina  
      -->    MX-$  
      ,      mocosto_usdclp          = @nCostoUSDCLP  
      ,      mocosto_mxusd           = @nCostoMxUSD  
      ,      mocosto_mxclp           = @nCostoMxCLP  
      ,      mocodpos2               = @iRefTc  
      ,      mofijaTCRef             = @dRefTc  
      ,      mofijaPRRef             = @dRefParidad  
      ,      moSpotTipCam            = @nSpotTc  
      ,      moSpotParidad           = @nSpotParidad  
      ,      Resultado_Mesa          = @nResultadoMesa  
      -->    PRD-5522  
      ,      MoFechaStarting         = @cFecStarting  
      ,      MoFechaFijacionStarting = @cFecFijacionStarting  
      ,      MoPuntosTransfObs       = @nPtosTransfObs  
      ,      MoPuntosTransfFwd       = @nPtosTransfFwd  
      ,      MoPuntosFwdCierre       = @nPtosFwdCierre   
      -->	 Marca para los Fw Asiaticos (1 seg Cambio; 14, fw Obsr; 15 fw Asiatico)
	  ,		 mocalvtadol			 = @Calvtadol
	  --->  PRD 19111 Actualiza Broker Comder
	  ,		MOCALVTASPR			 = @BrokerComDer
	    -- --> PRD 12712
	  ,      bEarlyTermination        = @bEarlyTermination        
	  ,      FechaInicio              = @FechaInicio              
	  ,      Periodicidad             = @Periodicidad             
	  -- <-- Fin PRD 12712
      WHERE  monumoper               = @nnumoper  
  
      IF EXISTS(SELECT 1 FROM MFCA_LOG with (nolock) WHERE caestado = 'M' AND CONVERT(CHAR(8),cafecmod,112) = CONVERT(CHAR(8),@dfecha,112) AND canumoper = @nnumoper)  
      BEGIN  
         SET  @primero = 'N'  
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
	  --> PRD 19111 Guarda Broker ComDer  (cacalvtaspr)
      ,   cacalvtaspr  
      ,   catasausd  
      ,   catasacon  
      ,   cadiferen  
      ,   cafpagomn  
      ,   cafpagomx  
      ,   cadiftipcam  
      ,   cadifuf  
      ,   caclpinicial  
	  --> PRD 19111 Guarda USD/UF ComDer (caclpfinal)
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
      ,  ValorRazonableActivo  
      ,   ValorRazonablePasivo  
      ,   mtm_hoy_moneda1  
      ,   mtm_hoy_moneda2  
      ,   catipcamPtosFwd  
      ,   estado_sinacofi  
      ,   fecha_estado_sina  
      ------->  
      ,   cacosto_usdclp  
      ,   cacosto_mxusd  
      ,   cacosto_mxclp  
      ,   cafijaTCRef  
      ,   cafijaPRRef  
      ,   caSpotTipCam  
      ,   caSpotParidad  
      --> Resultado de Mesa de Distribucion  
      ,   Resultado_Mesa  
      --> PRD-5522  
      ,   CaFechaStarting           
      ,   CaFechaFijacionStarting   
      ,   CaPuntosTransfObs         
      ,   CaPuntosTransfFwd         
      ,   CaPuntosFwdCierre         
      ,   var_moneda2
      --> PRD 12712
      ,   bEarlyTermination      
	  ,   FechaInicio            
	  ,   Periodicidad           
	  --> PRD 12712
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
	    --> PRD 19111 Guarda Broker ComDer
      ,      @BrokerComDer  
      ,      catasausd  
      ,      catasacon  
      ,      cadiferen  
      ,      cafpagomn  
      ,      cafpagomx  
      ,      cadiftipcam  
      ,      cadifuf  
      ,      caclpinicial  
	  --> PRD 19111 Guarda USD/UF ComDer
      ,    CASE WHEN camtomon2 <= 0 THEN 0.0 ELSE (camtomon1 /camtomon2) END  --caclpfinal  
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
      , caplazovto  
      ,      caplazocal  
      ,      cadiasdev  
      ,      cadelusd  
      ,		 cadeluf  
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
      ,      @cFechaProc  
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
	  ,   numerocontratocliente  
      ,      capremio  
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
      ,      ValorRazonablePasivo  
      ,      mtm_hoy_moneda1  
      ,      mtm_hoy_moneda2  
      ,      catipcamPtosFwd  
      ,      estado_sinacofi  
      ,      fecha_estado_sina  
      ------->  
      ,      cacosto_usdclp  
      ,      cacosto_mxusd  
      ,      cacosto_mxclp  
      ,      cafijaTCRef  
      ,      cafijaPRRef  
      ,      caSpotTipCam  
      ,      caSpotParidad  
      -->    Resultado de Mesa de Distribucion  
      ,      Resultado_Mesa  
      --> PRD-5522  
      ,      CaFechaStarting           
      ,      CaFechaFijacionStarting   
      ,      CaPuntosTransfObs         
      ,      CaPuntosTransfFwd   
      ,      CaPuntosFwdCierre         
      ,      var_moneda2  
      --> PRD 12712
      ,      bEarlyTermination
	  ,      FechaInicio
	  ,      Periodicidad
	  --> PRD 12712
      FROM   MFCA      with (nolock)  
      WHERE  canumoper = @nnumoper  
  
      UPDATE MFCA                     with (rowlock)  
      SET    cacodpos1                = @ncodpos1  
      ,      cacodmon1                = @ncodmon1  
      ,      cacodmon2                = @ncodmon2  
      ,      cacodcart                = @ncodcart  
      ,      cacodigo                 = @ncodigo  
      ,      catipoper                = @ctipoper  
      ,      catipmoda                = @ctipmoda  
      ,      cafecha                  = @dfecha  
      ,      catipcam                 = @ntipcam  
      ,      camdausd                 = @nmdausd  
      ,      camtomon1                = @nmtomon1  
      ,      caequusd1                = @nequusd1  
      ,      caequmon1                = @nequmol1  
      ,      camtomon2                = @nmtomon2  
      ,      caequusd2                = @nequusd2  
      ,      caequmon2                = @nequmol2  
      ,      caparmon1                = @nparmon1  
      ,      capremon1                = @npremon1  
      ,      caparmon2                = @nparmon2  
      ,      capremon2                = @npremon2  
      ,      caestado                 = @cestado  
      ,      caretiro                 = @cretiro  
      ,      cacontraparte            = @ccontraparte  
      ,      caobserv                 = @cobserv  
      ,      caspread                 = @nspread  
      ,      caprecal                 = @nprecal  
      ,      caplazo				  = @nplazo  
	  ,      cafecvcto                = @cfecvcto  
      ,      caoperador               = @coperador  
      ,      catasausd                = @ntasausd  
      ,      catasacon                = @ntasacon  
      ,      cafpagomn                = @nfpagomn  
      ,      cafpagomx                = @nfpagomx  
      ,      camtomon1ini             = @nMtoMon1ini  
      ,      camtomon1fin             = @nMtoMon1fin  
      ,      camtomon2ini             = @nMtoMon2ini  
      ,      camtomon2fin             = @nMtoMon2fin  
      ,      cacodsuc1                = @nentidad  
      ,      cacodcli                 = @ncodcli  
      ,      cadiferen                = @nmtodif  
      ,      cabroker				  = @nBroker  
      ,      camontopfe               = @nMontoPFE  
      ,      camontocce               = @nMontoCCE  
      ,      id_sistema               = @id_sistema  
      ,      Precio_Transferencia     = @Precio_Transferencia  
      ,      Tipo_Sintetico           = @Tipo_Sintetico  
      ,      Precio_Spot              = @Precio_Spot  
      ,      Pais_Origen              = @Pais_Origen  
      ,      Moneda_Compensacion      = @Moneda_Compensacion  
      ,      Riesgo_Sintetico         = @Riesgo_Sintetico  
      ,      Precio_Reversa_Sintetico = @precio_reversa_sintetico  
      ,      capremio                 = @npremio  
      ,      catipopc                 = @ctipopc  
      ,      cahora                   = @hora  
      ,      capreciopunta            = @precio_punta  
      ,      caremunera_linea         = @remunera_linea  
      ,      catasa_efectiva_moneda1  = @tasa_efectiva_moneda1  
      ,      catasa_efectiva_moneda2  = @tasa_efectiva_moneda2  
      ,      catasaEfectMon1          = @tasaefectmon1  
      ,      catasaEfectMon2          = @tasaefectmon2  
      ,      catipcamSpot             = @ntipcamSpot  
      ,      catipcamFwd              = @ntipcamFwd  
      ,      cafecEfectiva            = @dfechaefect  
      ,      caserie                  = @Serie  
      ,      caseriado                = @Seriado  
      ,      catipcamPtosFwd          = @ntipcamPtosFwd    
      ,      caArea_Responsable       = @CodAreaResponsable  
      ,      cacartera_normativa      = @CodCartNorm  
      ,      casubcartera_normativa   = @CodSubCartNorm  
      ,      calibro                  = @CodLibro  
      ,      estado_sinacofi          = @estadoSina  
      ,      fecha_estado_sina        = @fechaSina  
      -->    MX-$  
      ,      cacosto_usdclp           = @nCostoUSDCLP  
      ,      cacosto_mxusd            = @nCostoMxUSD  
      ,      cacosto_mxclp            = @nCostoMxCLP  
      ,      cacodpos2                = @iRefTc  
      ,      cacolmon1                = @iRefParidad  
      ,      cafijaTCRef              = @dRefTc  
      ,      cafijaPRRef              = @dRefParidad  
      ,      cavalpre                 = @nTipCamUSDCLP  
      ,      caSpotTipCam             = @nSpotTc  
      ,      caSpotParidad            = @nSpotParidad  
      -->    Resultado de Mesa de Distribucion  
      ,      Resultado_Mesa           = @nResultadoMesa  
      -->    PRD-5522  
      ,      CaFechaStarting          = @cFecStarting  
      ,      CaFechaFijacionStarting  = @cFecFijacionStarting  
      ,      CaPuntosTransfObs        = @nPtosTransfObs  
      ,      CaPuntosTransfFwd        = @nPtosTransfFwd  
      ,      CaPuntosFwdCierre        = @nPtosFwdCierre   
     -->REQ.5539  
      ,      Cadevacum				  = @nResultadoComex    
	  -->	 Marca para fw Asiatico
	  ,		 cacalvtadol			  = @Calvtadol	
	  --> PRD 19111 - Guarda Broker(cacalvtaspr) y USD/ UF ComDer (caclpfinal)
	  ,      cacalvtaspr              = @BrokerComDer
	  ,		 caclpfinal				  = CASE WHEN @nmtomon2 <= 0 THEN 0.0 ELSE (@nmtomon1 /@nmtomon2) END   
	  -- Fin  PRD 19111
	  -- --> PRD 12712
	  ,      bEarlyTermination        = @bEarlyTermination        
	  ,      FechaInicio              = @FechaInicio              
	  ,      Periodicidad             = @Periodicidad             
	  -- <-- Fin PRD 12712
      WHERE  canumoper                = @nnumoper  
  
      ---------------------------------------------------------------------------------------------------------------------  
      -- Esto Para Rebajar la Posicion de SPOT, Se Agregó la Cartera debido a que se Solicitó que Sólo Trading Afecte HEDGE  
      ---------------------------------------------------------------------------------------------------------------------  
      SELECT @afecta_hedge = ISNULL((SELECT rcnumcorr FROM BacParamSuda..TIPO_CARTERA with (nolock)  
                                                     WHERE rcsistema = 'BFW' AND @ncodcart = rcrut AND @ncodpos1 = rccodpro),0)  
  
      IF (@ncodpos1 IN ( 1, 4, 5, 6, 7, 12))  
      BEGIN  
         EXECUTE SP_GMOVTO @oldTipMer   
                         , @oldTipOper   
                         , @oldTC  
                         , @oldMonto  
          , @vcto  
      END  
   END ELSE    
   BEGIN  
  
      IF @ncodpos1 = 4 OR @ncodpos1 = 5 OR @ncodpos1 = 6  
      BEGIN  
 UPDATE MFAC   
         SET    accorrel = accorrel + 1  
  
         SELECT @nnumoper = accorrel FROM MFAC  
      END ELSE  
      BEGIN  
 UPDATE MFAC   
         SET    acnumoper = acnumoper + 1  
  
         SELECT @nnumoper = acnumoper FROM MFAC  
      END  
  
      INSERT INTO MFMO  
      (   monumoper  
      ,   mocodpos1  
      ,   mocodmon1  
      ,   mocodmon2  
      ,   mocodcart  
      ,   mocodigo  
      ,   motipoper  
      ,   motipmoda  
      ,   mofecha  
      ,   motipcam  
      ,   momdausd  
      ,   momtomon1  
      ,   moequusd1  
      ,   moequmon1  
      ,   momtomon2  
      ,   moequusd2  
      ,   moequmon2  
      ,   moparmon1  
      ,   mopremon1  
      ,   moparmon2  
      ,   mopremon2  
      ,   moestado  
      ,   moretiro  
      ,   mocontraparte  
      ,   moobserv  
      ,   mospread  
      ,   moprecal  
      ,   moplazo  
      ,   mofecvcto  
      ,   molock  
      ,   mooperador  
      ,   motasausd  
      ,   motasacon  
      ,   mofpagomn  
      ,   mofpagomx  
      ,   momtomon1ini  
      ,   momtomon1fin  
      ,   momtomon2ini  
      ,   momtomon2fin  
      ,   mocodsuc1  
      ,   mocodcli  
      ,   modiferen  
      ,   mopremio  
      ,   motipopc  
      ,   mohora  
      ,   mopreciopunta  
      ,   moremunera_linea  
      ,   motasa_efectiva_moneda1  
      ,   motasa_efectiva_moneda2  
      ,   moOperRelaspot  
      ,   motasaEfectMon1           
      ,   motasaEfectMon2           
      ,   motipcamSpot              
      ,   motipcamFwd              
      ,   mofecEfectiva           
      ,   moserie  
      ,   moseriado  
      ,   motipcamPtosFwd   
      ,   moArea_Responsable  
      ,   mocartera_normativa  
      ,   mosubcartera_normativa  
      ,   molibro  
      ,   estado_sinacofi  
      ,   fecha_estado_sina  
      -->    MX-$  
      ,   mocosto_usdclp  
      ,   mocosto_mxusd  
   ,   mocosto_mxclp  
      ,   mocodpos2  
      ,   mofijaTCRef  
      ,   mofijaPRRef  
      ,   moSpotTipCam  
      ,   moSpotParidad  
      --> Resultado Mesa de Distribucion  
      ,   Resultado_Mesa  
      --> PRD-5522  
      ,   MoFechaStarting  
      ,   MoFechaFijacionStarting  
	  ,   MoPuntosTransfObs  
      ,   MoPuntosTransfFwd  
      ,   MoPuntosFwdCierre  
     --> Campo moNroOpeMxClp utilizado para almacenar número de operación relacionada var_moneda2  
      ,	  moNroOpeMxClp
	  --> Marca para fw Asiatico
	  ,	  mocalvtadol	
	  --> PRD 19111 Guarda Broker ComDer
	  ,   MOCALVTASPR
	  -- --> PRD 12712
	  ,      bEarlyTermination        
	  ,      FechaInicio                    
	  ,      Periodicidad                  
	  -- <-- Fin PRD 12712
	  )
      VALUES  
      (   @nnumoper  
      ,   @ncodpos1  
      ,   @ncodmon1  
      ,   @ncodmon2  
      ,   @ncodcart  
      ,   @ncodigo  
      ,   @ctipoper  
      ,   @ctipmoda  
      ,   @dfecha  
      ,   @ntipcam  
      ,   @nmdausd  
      ,   @nmtomon1  
      ,   @nequusd1  
      ,   @nequmol1  
      ,   @nmtomon2  
      ,   @nequusd2  
      ,   @nequmol2  
      ,   @nparmon1  
      ,   @npremon1  
      ,   @nparmon2  
      ,   @npremon2  
      ,   @cestado  
      ,   @cretiro  
      ,   @ccontraparte  
      ,   @cobserv  
      ,   @nspread  
      ,   @nprecal  
      ,   @nplazo  
      ,   @cfecvcto  
      ,   @clocK  
      ,   @coperador  
      ,   @ntasausd  
      ,   @ntasacon  
      ,   @nfpagomn  
      ,   @nfpagomx  
      ,   @nMtoMon1ini  
      ,   @nMtoMon1fin  
      ,   @nMtoMon2ini  
      ,   @nMtoMon2fin  
      ,   @nentidad  
      ,   @ncodcli  
      ,   @nmtodif  
      ,   @npremio  
      ,   @ctipopc  
    ,   @hora  
      ,   @precio_punta  
      ,   @remunera_linea  
      ,   @tasa_efectiva_moneda1  
      ,   @tasa_efectiva_moneda2  
      ,   @relacionada_spot  
      ,   @tasaefectmon1  
      ,   @tasaefectmon2  
      ,   @ntipcamSpot  
      ,   @ntipcamFwd  
      ,   @dfechaefect     
      ,   @Serie  
      ,   @Seriado  
      ,   @ntipcamPtosFwd  
      ,   @CodAreaResponsable  
      ,   @CodCartNorm  
      ,   @CodSubCartNorm  
      ,   @CodLibro     
      ,   @estadoSina  
      ,   @fechaSina  
      -->    MX-$  
      ,   @nCostoUSDCLP  
      ,   @nCostoMxUSD  
      ,   @nCostoMxCLP  
      ,   @iRefTc  
      ,   @dRefTc  
      ,   @dRefParidad  
      ,   @nSpotTc  
      ,   @nSpotParidad  
      --> Resultado Mesa de Distribucion  
      ,   @nResultadoMesa  
      --> PRD-5522   
      ,   @cFecStarting  
      ,   @cFecFijacionStarting  
      ,   @nPtosTransfObs  
      ,   @nPtosTransfFwd  
      ,   @nPtosFwdCierre   
      --> Numero de operación relacionada MxClp almacenado en var_moneda2  
      ,   @NroOpeRelMxClp
	  --> Marca para fw Asiatico
	  ,	  @Calvtadol	
	  --> PRD 19111 Guarda Broker ComDer
	  ,   @BrokerComDer
	    -- --> PRD 12712
	  ,  @bEarlyTermination        
	  ,  @FechaInicio              
	  ,  @Periodicidad             
	  -- <-- Fin PRD 12712
	  )
  
      INSERT INTO MFCA  
      (   canumoper  
      ,   cacodpos1  
      ,   cacodmon1  
      ,   cacodmon2  
      ,   cacodcart  
      ,   cacodigo  
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
      ,   caspread  
      ,   caprecal  
      ,   caplazo  
      ,   cafecvcto  
      ,   caoperador  
      ,   catasausd  
      ,   catasacon  
      ,   cafpagomn  
      ,   cafpagomx  
      ,   camtomon1ini  
      ,   camtomon1fin  
      ,   camtomon2ini  
      ,   camtomon2fin  
      ,   cacodsuc1  
      ,   cacodcli  
      ,   cadiferen  
      ,   cabroker  
      ,   camontopfe  
      ,   camontocce  
      ,   Calzada  
      ,   id_sistema  
      ,   Precio_Transferencia  
      ,   Tipo_Sintetico  
      ,   Precio_Spot  
      ,   Pais_Origen  
      ,   Moneda_Compensacion  
      ,   Riesgo_Sintetico  
      ,   Precio_Reversa_Sintetico  
      ,   capremio  
      ,   catipopc  
      ,   cahora  
      ,   capreciopunta  
      ,   caremunera_linea  
      ,   catasa_efectiva_moneda1  
      ,   catasa_efectiva_moneda2  
      ,   caOperRelaSpot  
      ,   catasaEfectMon1           
      ,   catasaEfectMon2           
      ,   catipcamSpot              
      ,   catipcamFwd   
      ,   cafecEfectiva            
      ,   caserie  
      ,   caseriado  
      ,   cavalordia  
      ,   catipcamPtosFwd              
      ,   caArea_Responsable  
      ,   cacartera_normativa  
      ,   casubcartera_normativa  
      ,   calibro  
      ,   estado_sinacofi  
      ,   fecha_estado_sina  
      ,   fecharecepcion  
      ,   caMtoOriginal  
  
      --> MX-$  
      ,   cacosto_usdclp  
      ,   cacosto_mxusd  
      ,   cacosto_mxclp  
      ,   cacodpos2  
      ,   cacolmon1  
      ,   cafijaTCRef  
      ,   cafijaPRRef  
      ,   cavalpre  
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
      --> PRD-5522  
      ,   Cadevacum  
      --> Campo var_moneda2 reutilizado para almacenar número de operación relacionada  
      ,   var_moneda2
	  --> Marca para fw Asiatico
	  ,	  cacalvtadol	
	  --> PRD 19111 Guarda Broker ComDer
	  ,   CACALVTASPR
	  --> PRD 1911 Guarda cálculo USD/UF 
	  ,   caclpfinal
	  --> PRD 12712
	  ,   bEarlyTermination
	  ,   FechaInicio
	  ,   Periodicidad
	  --> PRD 12712
      )
      VALUES  
      (   @nnumoper  
      ,   @ncodpos1  
      ,   @ncodmon1  
      ,   @ncodmon2  
      ,   @ncodcart  
      ,   @ncodigo  
      ,   @ctipoper  
      ,   @ctipmoda  
      ,   @dfecha  
      ,   @ntipcam  
      ,   @nmdausd  
      ,   @nmtomon1  
      ,   @nequusd1  
      ,   @nequmol1  
      ,   @nmtomon2  
      ,   @nequusd2 
      ,   @nequmol2  
      ,   @nparmon1  
      ,   @npremon1  
      ,   @nparmon2  
      ,   @npremon2  
      ,   @cestado  
      ,   @cretiro  
      ,   @ccontraparte  
      ,   @cobserv  
      ,   @nspread  
      ,   @nprecal  
      ,   @nplazo  
      ,   @cfecvcto  
      ,   @coperador  
      ,   @ntasausd  
      ,   @ntasacon  
      ,   @nfpagomn  
      ,   @nfpagomx  
      ,   @nMtoMon1ini  
      ,   @nMtoMon1fin  
      ,   @nMtoMon2ini  
      ,   @nMtoMon2fin  
      ,   @nentidad  
      ,   @ncodcli  
      ,   @nmtodif  
      ,   @nBroker  
      ,   @nMontoPFE  
      ,   @nMontoCCE  
      ,   'N'  
      ,   @id_sistema  
      ,   @Precio_Transferencia  
      ,   @Tipo_Sintetico  
      ,   @Precio_Spot  
      ,   @Pais_Origen  
      ,   @Moneda_Compensacion  
      ,   @Riesgo_Sintetico  
      ,   @Precio_Reversa_Sintetico  
      ,   @npremio  
      ,   @ctipopc  
      ,   @hora  
      ,   @precio_punta  
      ,   @remunera_linea  
      ,   @tasa_efectiva_moneda1  
      ,   @tasa_efectiva_moneda2  
      ,   @relacionada_spot  
      ,   @tasaefectmon1  
      ,   @tasaefectmon2  
	  ,   @ntipcamSpot  
      ,   @ntipcamFwd  
      ,   @dfechaefect     
      ,   @Serie  
      ,   @Seriado  
      ,   @nMtoDif  
      ,   @ntipcamPtosFwd  
      ,   @CodAreaResponsable  
      ,   @CodCartNorm  
      ,   @CodSubCartNorm  
      ,   @CodLibro  
      ,   @estadoSina  
      ,   @fechaSina  
      ,   CASE WHEN @ncodpos1 = 13 THEN @cFechaProc ELSE '19000101' END  
      ,   CASE WHEN @ncodpos1 = 13 THEN @nmtomon1 ELSE 0 END  
      --> MX-$  
      ,   @nCostoUSDCLP  
      ,   @nCostoMxUSD  
      ,   @nCostoMxCLP  
      ,   @iRefTc  
      ,   @iRefParidad  
      ,   @dRefTc  
	  ,   @dRefParidad  
      ,   @nTipCamUSDCLP  
      ,   @nSpotTc  
      ,   @nSpotParidad  
      --> Resultado de Mesa de Distribucion  
      ,   @nResultadoMesa  
      --> PRD-5522   
      ,   @cFecStarting  
      ,   @cFecFijacionStarting  
   ,   @nPtosTransfObs  
      ,   @nPtosTransfFwd  
      ,   @nPtosFwdCierre   
      --> PRD-5539  
      ,   @nResultadoComex  
      ,   @NroOpeRelMxClp
	  --> Marca para fw Asiatico
	  ,	  @Calvtadol	
	   --> PRD 19111 Guarda Broker ComDer
	  ,   @BrokerComDer
	   --> PRD 19111 Guarda cálculo USD/UF  ComDer en campo caclpfinal
	  ,  CASE WHEN @nmtomon2 <= 0 THEN 0.0 ELSE (@nmtomon1/@nmtomon2) END
       --> PRD 12712
	  ,   @bEarlyTermination
	  ,   @FechaInicio
	  ,   @Periodicidad
	  --> PRD 12712
      )

	  

        IF @ActivaComder = 'S' --Prd_19146 Comder and PRD-19111
        BEGIN
        	IF @Novacion = 1 
			BEGIN
				INSERT INTO BDBOMESA.dbo.COMDER_RelacionMarcaComder
				(	cReSistema
				,	nReNumOper                               
				,	iReNovacion  
				,	nReRutCliente
				,   nReCodCliente
				,   vReEstado
				,	vReMotivRechazo
				,	dReFecha
				)
				VALUES
				(	'BFW'
				,	@nnumoper
				,	@Novacion
				,	@ncodigo
				,	@ncodcli
				,	'V'
				,   ''
				,	@dfecha			
				)   
			END          	
        END            		
   END  


  
   ---------------------------------------------------------------------------------------------------------------------  
   -- Esto Para Afectar la Posicion de SPOT, Se Agregó la Cartera debido a que se Solicitó que Sólo Trading Afecte HEDGE  
   ---------------------------------------------------------------------------------------------------------------------  
   IF (@ncodpos1 in (1, 4, 5, 6, 7, 12))  
   BEGIN  
      SET @TipMer       = 'FUTU'  
      SET @TipOper_spot = @ctipoper  
  
      IF @ncodpos1 = 5   
 BEGIN  
         SET @TipMer       = '1446'  
         SET @TipOper_spot = CASE @ctipoper WHEN 'O' THEN 'C' ELSE 'V' END  
      END  
  
      EXECUTE SP_GMOVTO @TipMer  
                      , @TipOper_spot  
                      , @ntipcamPtosFwd  
                      , @nmtomon1  
                      , 0  
   END  
  
   IF @ctipoper = 'C' OR @ctipoper = 'O'  
   BEGIN  
      IF EXISTS( SELECT ccmonto FROM MFCC with (nolock) WHERE ccopecmp = @nnumoper )  
      BEGIN  
         UPDATE MFCA with (rowlock)  
         SET camtocalzado = 0  
         WHERE  canumoper = @nnumoper  
  
         UPDATE MFCA with (rowlock)  
         SET    camtocalzado = camtocalzado - ccmonto   
         FROM   MFCA  
         ,      MFCC  
         WHERE  canumoper = ccopevta    
         AND    ccopecmp  = @nnumoper  
  
         DELETE MFCC  
         WHERE  ccopecmp = @nnumoper  
  
      END  
   END ELSE   
   BEGIN  
      IF @ctipoper IN ( 'V', 'A' )  
      BEGIN  
         IF EXISTS(SELECT 1 FROM MFCC with (nolock) WHERE ccopevta = @nnumoper)  
         BEGIN  
            UPDATE MFCA with (rowlock)  
               SET camtocalzado = 0  
             WHERE canumoper    = @nnumoper  
  
            UPDATE MFCA with (rowlock)  
               SET camtocalzado = camtocalzado - ccmonto   
              FROM MFCA   
                 , MFCC   
             WHERE canumoper    = ccopecmp    
               AND ccopevta     = @nnumoper  
  
            DELETE MFCC  
             WHERE ccopevta = @nnumoper  
   END  
      END  
   END  
 
   /* JTP solo para dejar pasar el SP */  
   EXECUTE mdgestion..SP_GENERA_FLUJO_CONTRATO_FWD @nnumoper  
                                                 , @dfecha  
                                                 , @cfecvcto  
                                                 , @ncodigo  
                                                 , @ncodcli  
                                                 , @nmtomon1  
                                                 , '19000101'  
                                                 , '00:00:01'  
                                                 , '19000101'  
                                                 , '00:00:01'  
  , 0  
                                                 , 0  
                                                 , 'SQL'  
                                                 , @nError OUTPUT  
  
 If @nError <> 0  
 Begin  
    Select 0,'NO'  
    Return -1  
 End   
  
   --> Ingreso de Operacion automatica SPOT  
   DECLARE @nPlaza                 INT   
   DECLARE @tipo                 CHAR(4)  
   DECLARE @compra_forma_pagomn    NUMERIC(3)  
   DECLARE @compra_forma_pagomx    NUMERIC(3)  
   DECLARE @venta_forma_pagomn    NUMERIC(3)  
   DECLARE @venta_forma_pagomx    NUMERIC(3)  
   DECLARE @fp1      NUMERIC(3)  
   DECLARE @fp2      NUMERIC(3)  
   DECLARE @fecval1     DATETIME  
   DECLARE @fecval2     DATETIME  
   DECLARE @contabiliza     CHAR(1)  
   DECLARE @fecha                DATETIME  
   DECLARE @observa     VARCHAR(250)  
   DECLARE @nTipCliente            INT  
   DECLARE @cProductoSpot          VARCHAR(5)
   DECLARE @iProductoSpot		   SMALLINT  
  
   DECLARE @CorresponsalCNT        CHAR(10)  
   DECLARE @nDiasFec1              INT  
   DECLARE @nDiasFec2              INT  
  
  
   IF @relacionada_spot = '06' AND @ncodpos1 <> 3  
   BEGIN  
   --=====PRD21645==========================================================================================	
   	IF @nnumopeRelSpot <> 0 
   		BEGIN
   			 SELECT  @nnumopeRelSpotMod = numerospot FROM mfca  WHERE canumoper = @nnumopeRelSpot 
   		END
   		ELSE
   			BEGIN
   				set @nnumopeRelSpotMod = 0
   			END
  --=====PRD21645==========================================================================================	  	
                                                                           --> se agrego 02-02-2010  
      IF EXISTS(SELECT 1 FROM BacParamSuda..CLIENTE WHERE clrut = @ncodigo AND clcodigo = @ncodcli)  
      BEGIN  
         SELECT @nnumoper, 'OK'  
  
         SELECT @mocodcli    = clcodigo  
         ,      @monomcli    = clnombre   
         ,      @nTipCliente = cltipcli  
         FROM   BacParamSuda..CLIENTE   
         WHERE  clrut        = @ncodigo  
AND  clcodigo     = @ncodcli --> se agrego 02-02-2010  
         --AND  cltipemp     = 1  
  
         SET    @monumope    = (SELECT MAX(monumope) FROM BacCamSuda..MEMO )  
         SET    @monumope    = @monumope + 1  
   SET    @tipo        = CASE WHEN @ctipoper = 'C' THEN 'V' ELSE 'C' END  
  
         IF @nTipCliente = 1 or @nTipCliente = 2 or @nTipCliente = 3  
            SET @cProductoSpot = 'PTAS'  
         ELSE  
            SET @cProductoSpot = 'EMPR'  

		SET @iProductoSpot = CASE	WHEN @cProductoSpot = 'PTAS' THEN 4
									WHEN @cProductoSpot = 'EMPR' THEN 5
									ELSE 0
								END
		

		IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
						WHERE  idPlataforma         = @iProductoSpot
						AND    idProducto           = @iProductoSpot
						AND    idCliente			 = @Cliente
						AND    idOperacion=1)
		BEGIN
		  
			 SELECT @compra_forma_pagomn = Default_iFormaPagoMN,  
 					@compra_forma_pagomx = Default_iFormaPagoMX, 
					@contabiliza  = 'S',  
					@CorresponsalCNT        = Default_iCodCorresponsal
			 FROM   BacParamSuda..CargaOperaciones_DefectoValores  
			 WHERE  idPlataforma         = @iProductoSpot --> @cProductoSpot  
			 AND    idProducto           = @iProductoSpot --> @cProductoSpot
			 AND    idCliente			 = 0
			 AND    idOperacion=1
         
			 SELECT @venta_forma_pagomn = Default_iFormaPagoMN,  
 					@venta_forma_pagomx = Default_iFormaPagoMX, 
					@CorresponsalCNT        = Default_iCodCorresponsal
			 FROM   BacParamSuda..CargaOperaciones_DefectoValores  
			 WHERE  idPlataforma         = @iProductoSpot --> @cProductoSpot  
			 AND    idProducto           = @iProductoSpot --> @cProductoSpot
			 AND    idCliente			 = 0
			 AND    idOperacion=2
		END
		
		ELSE
		BEGIN
			 SELECT @compra_forma_pagomn = Default_iFormaPagoMN,  
 					@compra_forma_pagomx = Default_iFormaPagoMX, 
					@contabiliza  = 'S',  
					@CorresponsalCNT        = Default_iCodCorresponsal
			 FROM   BacParamSuda..CargaOperaciones_DefectoValores  
			 WHERE  idPlataforma         = @iProductoSpot --> @cProductoSpot  
			 AND    idProducto           = @iProductoSpot --> @cProductoSpot
			 AND    idCliente			 = @Cliente
			 AND    idOperacion=1
         
			 SELECT @venta_forma_pagomn = Default_iFormaPagoMN,  
 					@venta_forma_pagomx = Default_iFormaPagoMX, 
					@CorresponsalCNT        = Default_iCodCorresponsal
			 FROM   BacParamSuda..CargaOperaciones_DefectoValores  
			 WHERE  idPlataforma         = @iProductoSpot --> @cProductoSpot  
			 AND    idProducto           = @iProductoSpot --> @cProductoSpot
			 AND    idCliente			 = @Cliente
			 AND    idOperacion=2    
		END		    
  
         SET @fp1       = CASE WHEN @tipo = 'C' THEN @compra_forma_pagomn ELSE @venta_forma_pagomx END --> Entregamos  
      SET @fp2       = CASE WHEN @tipo = 'C' THEN @compra_forma_pagomx ELSE @venta_forma_pagomn END --> Recibimos  
  
         SET @nDiasFec1 = ISNULL((SELECT ISNULL(diasvalor, 0) FROM BacParamSuda..FORMA_DE_PAGO with(nolock) WHERE codigo = @fp1), 0) --> Entregamos  
         SET @nDiasFec2 = ISNULL((SELECT ISNULL(diasvalor, 0) FROM BacParamSuda..FORMA_DE_PAGO with(nolock) WHERE codigo = @fp2), 0) --> Recibimos  
  
         SET @fecval1   = @dfecha --> DATEADD(DAY, @nDiasFec1, @dfecha)  
         SET @fecval2   = @dfecha --> DATEADD(DAY, @nDiasFec2, @dfecha)  
  
         IF @tipo = 'C'  
            SET @nPlaza = 6  
         ELSE    
            SET @nPlaza = 225  
  
         EXECUTE BacCamSuda..SP_BUSCA_FECHA_HABIL @fecval1, @nDiasFec1, @nPlaza, @fecval1 OUTPUT  
  
         IF @tipo = 'C'  
            SET @nPlaza = 225  
         ELSE    
            SET @nPlaza = 6  
  
         EXECUTE BacCamSuda..SP_BUSCA_FECHA_HABIL @fecval2, @nDiasFec2, @nPlaza, @fecval2 OUTPUT  
  
         /* --> Esto deriva en Error en los Dias de Valuta. <--  
         IF @tipo = 'V'  
         BEGIN  
            SET @fp1 =  @compra_forma_pagomx  
            SET @fp2 =  @compra_forma_pagomn  
            SET @fecval1 = dateadd(day, 1, @dfecha)  
  
            EXECUTE BacTraderSuda..SP_VALUTA_HABIL @fecval1, 1, @fecval1 OUT  
            EXECUTE BacTraderSuda..SP_VALUTA_HABIL @fecval1, 1, @fecval2 OUT  
         END ELSE  
         BEGIN  
            SET @fp1 =  @venta_forma_pagomn  
            SET @fp2 =  @venta_forma_pagomx  
            SET @fecval2 = dateadd(day, 1, @dfecha)  
  
            EXECUTE bactradersuda..sp_valuta_habil @fecval2,1,@fecval1 out  
            EXECUTE bactradersuda..sp_valuta_habil @fecval2,1,@fecval2 out  
         END  
         */  
         SET @observa = 'Operacion Derivado: ' + CONVERT(VARCHAR(10),@nnumoper)   
  
         CREATE TABLE #temp_spot  
         (   numero   INT  
         ,   estado   VARCHAR(80)  
         )  
  
         SET @nmtomon2 = (@nmtomon1 * @ntipcamSpot)  
         SET @ntipcam  =  @ntipcamSpot  
  
         INSERT INTO #temp_spot  
         EXECUTE BacCamSuda..SP_GMOVTO @nnumopeRelSpotMod --0                   --> 01 monumope  PRD_21645
                                    , @cProductoSpot       --> 02 motipmer ( 'PTAS' )  
                                    , @tipo                --> 03 motipope  
                                    , @ncodigo            --> 04 morutcli  
                                    , @mocodcli            --> 05 mocodcli  
                                    , @monomcli            --> 06 monomcli  
                                    , 'USD'                --> 07 mocodmon  
                    , 'CLP'                --> 08 mocodcnv  
                                    , @nmtomon1            --> 09 monommo  
                                    , @ntipcam             --> 10 moticam  
                                    , @ntipcam             --> 11 motctra  
                                    , 1                    --> 12 moparida  
									, 1                    --> 13 moussme  
                                    , @nmtomon1            --> 14  
                                    , @nmtomon1    --> 15  
                                    , @nmtomon2            --> 16 momonpe  
                                    , @fp1                 --> 17 --> Entregamos  
                                    , @fp2     --> 18 --> Recibimos  
                                    , @coperador    --> 19  
                                    , 'SWAP SPOT'    --> 20  
                                    , @dfecha     --> 21  
                                    , 0                    --> 22  
                                    , ''     --> 23  
                                    , 0      --> 24  
                                    , @fecval1     --> 25  
									, @fecval2     --> 26  
                                    , 0      --> 27  
                                    , ''     --> 28  
                                    , 1      --> 29  
                                    , @ntipcam             --> 30 moprecio  
                                    , @ntipcam            --> 31 mopretra  
                                    , 0            --> 32  
                                    , 'BCC'        --> 33  
                                    , @contabiliza         --> 34  
                                    , @observa             --> 35  
                                    , ''                   --> 36  
                                    , ''                   --> 37  
                                    , ''                   --> 38  
                                    , 0                    --> 39  
                                    , 0                    --> 40  
                                    , 0                    --> 41  
                                    , 0                    --> 42  
                                    , 0                    --> 43  
                                    , @dfecha              --> 44  
                                    , @dfecha              --> 45  
                                    , 'PTAS'               --> 46  
                                    , ''                   --> 47  
                                    , ''                   --> 48  
                                    , 0                    --> 49  
                                    , 0                    --> 50  
                                    , 0                    --> 51  
                                    , 0                    --> 52  
                                    , 0                    --> 53  
                                    , 0                    --> 54  
                                    , 0         --> 55  
                                    , 0                    --> 56  
                                    , @dfecha              --> 57  
                                    , 0                    --> 58  
                                    , 0                    --> 59  
                                    , 'S'                  --> 60  
                                    , @nnumoper            --> 61  
                                    -->   No estaba Contemplado. <--  
									, ''                   --> @der_inicio    DATETIME      = '''',  -- 62   
									, ''                   --> @der_vcto    DATETIME      = '''',  -- 63  
									, 0                    --> @der_precio    NUMERIC (19,4)=0,  -- 64       
									, 0                    --> @der_instr          NUMERIC (02)  =0,  -- 65  
									, 0                    --> @netting            NUMERIC (10)  =0,  -- 66  
									, 0                    --> @numero_tbtx    NUMERIC (10)  =0,  -- 67  
									, 'N'                  --> @controla_tran    CHAR    (01)=''S'',  -- 68  
									, @CorresponsalCNT     --> @CorresponsalCNT    CHAR  (10)=''0'',  -- 69 Corresponsal Contable del Cliente Banco CorpBanca  
									, 0                    --> @p_IndOriManual     NUMERIC      (2,0)=0          -- 70  
                                    -->   No estaba Contemplado. <--  
  
         DROP TABLE #temp_spot  
  
         IF @@ERROR = 0   
         BEGIN  
            SELECT @numoperaux = monumope FROM BacCamSuda..MEMO WHERE monumfut = @nnumoper  
  
            IF @numoperaux > 0  
            BEGIN  
               UPDATE MFMO SET numerospot = @numoperaux WHERE monumoper = @nnumoper  
               UPDATE MFCA SET numerospot = @numoperaux WHERE canumoper = @nnumoper  
            END  
         END  
      END ELSE   
      BEGIN  
         SELECT @nnumoper, 'OK'  
      END  
   END ELSE    
   BEGIN  
      SELECT @nnumoper, 'OK'  
   END  
  
   SET NOCOUNT OFF  
END  
 
 
 
 


GO

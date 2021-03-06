USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_ANTICIPO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_ANTICIPO]
       (
        @nnumoper                NUMERIC (10)     ,--1--ope
        @cfecant                 DATETIME         ,--2--fecha pantalla
        @nnocional               FLOAT            ,--3--monto anticipar , pantalla
        @nPrecioSpot             FLOAT            ,--4--precio spot pantalla
        @nptosfwd                FLOAT            ,--5--pantalla
        @ntasaplazorem        	 FLOAT            ,--6--tasa utilizada en la diferencia d fecha del anticipo y venciminto
        @nfpagoMN                NUMERIC(03)      ,--7--formas de pago, consultar si corresponde a mda1 o contramoneda o compensacion.-  
        @nfpagoMX                NUMERIC(03)      ,--8--idem  
        @nmtm                    FLOAT            ,--9--pantalla, txtmtm.text, comparar este valor con el que se calcula en la nueva pantalla
        @nmdacomp                NUMERIC(03)      ,--10--moneda del monto a liquidar,
	@nforpagMdaComp          NUMERIC(03)      ,--11--forma de pago del monto a liquidar
        @nparcontmda             FLOAT            ,--12--paridad contra moneda
        @nparmdacomp             FLOAT            ,--13--paridad moneda compensacion  
        @coperador               CHAR(15)         ,	--15--usuario sistema
        @cfecvctoOrig            DATETIME         ,	--16--
        @cfecIniOrig             DATETIME         ,	--17--
        @caAntMargenContMda      FLOAT            ,--18--Resultado Mesa Venta
	@caAntValCLPContMda	 FLOAT            ,--19--Resultado Mesa Trading
	@nValorAnticipo		 FLOAT		  ,	--20--
	@cModalidad 		 CHAR(1)          ,	--21--
	@fParidadAnt		 FLOAT            = 0,  --22--Paridad Pantalla
	@nprecpactdesc		 FLOAT		  = 0,  --23--Precio Descuento
	@nmtomoncomp		 FLOAT		  = 0,  --24--Monto a Pagar
        @nPrecioSpotPtos         FLOAT            = 0,	--25--Spot + Puntos
	@nAntMtoMonCompAntes	 FLOAT		  = 0,  --26--Monto a Pagar * Factor 
	@caAntFactorContMda 	 FLOAT		  = 0   --27--Factor
       )
AS
BEGIN
SET NOCOUNT ON

   --> Se agrega para Recalcular la Fecha Efectiva .-> 25-02-2009 => En base a nueva Regla .- TAG->FECHAEFECTIVA
    DECLARE    @dFecEfectivaRegla   	DATETIME
    DECLARE    @iRefMercado         	INTEGER

    DECLARE    @nnumop           	NUMERIC(10)
    DECLARE    @cfecproc         	DATETIME 
    DECLARE    @ncorrela         	NUMERIC(03)
    DECLARE    @nfact            	FLOAT
    DECLARE    @nfactNuev        	FLOAT
    DECLARE    @nnumopOrig       	NUMERIC(10)
    DECLARE    @nnocionalOrig    	Float 
    DECLARE    @primero          	CHAR(1)
    DECLARE    @nbase            	INTEGER          
    DECLARE    @ncodpos1         	NUMERIC(02)      
    DECLARE    @nFecVenc         	DATETIME 
    DECLARE    @cTipModa	 	CHAR(1)

   BEGIN TRANSACTION

    SELECT  @cfecproc = acfecproc FROM mfac


    SELECT @nnumopOrig    = canumoper
          ,@nnocionalOrig = camtomon1
	  ,@nbase 	  = caAntBase
          ,@ncodpos1      = cacodpos1
	  ,@cTipModa 	  = catipmoda
    FROM MFCA
    WHERE canumoper = @nnumoper

      IF @ncodpos1 = 1 or @ncodpos1 = 2
      BEGIN
           SELECT @iRefMercado = CASE WHEN cacodpos1 = 1 THEN CONVERT(NUMERIC(5), cacodpos2)
                                      WHEN cacodpos1 = 2 THEN CONVERT(NUMERIC(5), cacolmon1)
                                      ELSE                    CONVERT(NUMERIC(5), 0)
                                 END
           FROM   MFCA
           WHERE  canumoper    = @nnumoper

           EXECUTE BacFwdSuda..SP_GENERA_FECHA_EFECTIVA @ncodpos1, @cTipModa, @iRefMercado, @cfecant, @dFecEfectivaRegla OUTPUT
      END

    SELECT @primero = 'S'   

    SELECT @nfact = 1.0 - (@nnocional/@nnocionalOrig )  
    SELECT @nfactNuev = (@nnocional/@nnocionalOrig)  

    SELECT @ncorrela   = ISNULL(MAX(caAntCorrela),0)  
    FROM MFCA
    WHERE numerocontratocliente = @nnumoper


    SELECT @ncorrela = @ncorrela + 1

    SELECT * INTO #TEMP  
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

   IF @ncodpos1 in (  1 , 2 ,  3 , 13)
      BEGIN

   	IF @nnocionalOrig <> @nnocional  
      	 BEGIN
       	  UPDATE MFAC  
       	   SET acnumoper = acnumoper + 1
       		  SELECT @nnumop = acnumoper FROM MFAC
       	END

      END

   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización del N° de Operación en tabla de Control MFAC.'
      SET NOCOUNT OFF
      RETURN
   END

   UPDATE #TEMP SET  canumoper         		= @nnumop
		    ,caparmon2			= CASE WHEN @ncodpos1 = 2 THEN @fParidadAnt ELSE caparmon2 END
		    ,caparmon1			= CASE WHEN @ncodpos1 = 2 THEN 1 ELSE caparmon1 END
                    ,caantici          		= 'A' 
		    ,cafecvcto         		= @cfecant
		    ,camtomon1			= @nnocional
		    ,precio_spot       		= @nPrecioSpot
                    ,caAntPtosFwd      		= @nptosfwd
                    ,caAntTasaPlazoRem 		= @ntasaplazorem
                    ,caAntBase         		= @nbase   
                    ,catipmoda         		= @cModalidad   
 		    ,cafecha           		= @cfecproc
		    ,capreciomtm       		= @nPrecioSpotPtos -->revisar
                    ,cafpagomn         		= @nfpagoMN
                    ,cafpagomx         		= @nfpagoMX
		    ,cacolmon1         		= 0 
		    ,CaPrecioFwd       		= @nprecpactdesc  
		    ,CaAntPreOpEF		= @fParidadAnt
		    ,cacapmon1         		= @nAntMtoMonCompAntes
                    ,camarktomarket    		= @nmtm 
                    ,caAntForPagMdaComp  	= @nforpagMdaComp
                    ,caAntParContraMda 	 	= @nparcontmda
                    ,caAntParMdaComp   	 	= @nparmdacomp
                    ,caAntFactorContMda  	= @caAntFactorContMda  
		    ,caAntMtoMdaComp   		= @nmtomoncomp
                    ,numerocontratocliente 	= @nnumoper
                    ,caAntCorrela       	= @ncorrela
		    ,caMtoComp			= @nValorAnticipo
                    ,moneda_compensacion 	= @nmdacomp 
                    ,caestado           	= '' 
		    , caAntMargenContMda  	= @caAntMargenContMda --se agregan estos campos M.Venta
		    , caAntValCLPContMda  	= @caAntValCLPContMda --Vta. Trading
                    , caequusd1         	= caequusd1 	* @nfactNuev
                    , caequmon1         	= caequmon1 	* @nfactNuev
                    , camtomon2         	= camtomon2 	* @nfactNuev
                    , caequusd2         	= caequusd2 	* @nfactNuev
                    , caequmon2         	= caequmon2 	* @nfactNuev
                    , cadiferen         	= cadiferen 	* @nfactNuev
                    , cadiftipcam       	= cadiftipcam 	* @nfactNuev
                    , camtodiferir      	= camtodiferir 	* @nfactNuev
                    , camtomon1ini      	= camtomon1ini 	* @nfactNuev
                    , camtomon1fin      	= camtomon1fin 	* @nfactNuev
                    , camtomon2ini      	= camtomon2ini 	* @nfactNuev
                    , camtomon2fin      	= camtomon2fin 	* @nfactNuev
                    , carevusd          	= carevusd 	* @nfactNuev
                    , carevtot          	= carevtot 	* @nfactNuev
                    , cavalordia        	= cavalordia 	* @nfactNuev
                    , cactacambio_a     	= cactacambio_a * @nfactNuev
                    , cactacambio_c     	= cactacambio_c * @nfactNuev
                    , caperddiferir     	= caperddiferir * @nfactNuev
                    , caperddevenga     	= caperddevenga * @nfactNuev
                    , caperdacum        	= caperdacum 	* @nfactNuev
                    , caperdsaldo       	= caperdsaldo 	* @nfactNuev
                    , caclpmoneda1      	= caclpmoneda1 	* @nfactNuev
                    , caclpmoneda2      	= caclpmoneda2 	* @nfactNuev
                    , cavalorayer       	= cavalorayer 	* @nfactNuev
                    , mtm_hoy_moneda1   	= mtm_hoy_moneda1 * @nfactNuev
                    , mtm_hoy_moneda2   	= mtm_hoy_moneda2 * @nfactNuev
                    , carevtot_ayer     	= carevtot_ayer * @nfactNuev
                    , fRes_Obtenido     	= fRes_Obtenido * @nfactNuev
                    , ValorRazonableActivo 	= ValorRazonableActivo * @nfactNuev
                    , ValorRazonablePasivo 	= ValorRazonablePasivo * @nfactNuev
                    , caoperador     		= @coperador 
                    , caplazovto        	= DATEDIFF(dd,@cfecproc,@cfecant)
                    , caplazocal        	= DATEDIFF(dd,@cfecproc,@cfecant)
                    , caplazo           	= DATEDIFF(dd,@cfecproc,@cfecant)                
                    , caautoriza        	= ''
         	    , cafecvenor        	= @cfecvctoOrig
                    , caobserv          	= ''  
                    , caobservlin       	= '' 
		   
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
      --PRD 12712
	,bEarlyTermination
	,FechaInicio
	,Periodicidad
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
      --PRD 12712
	,bEarlyTermination
	,FechaInicio
	,Periodicidad
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
     UPDATE MFCA SET  camtomon1 	= camtomon1 	* @nfact
                    , caequusd1 	= caequusd1 	* @nfact 
                    , caequmon1 	= caequmon1 	* @nfact 
                    , camtomon2 	= camtomon2 	* @nfact 
                    , caequusd2 	= caequusd2 	* @nfact 
                    , caequmon2 	= caequmon2 	* @nfact 
                    , caspread  	= caspread 	* @nfact 
                    , cadiferen 	= cadiferen 	* @nfact 
                    , cadiftipcam  	= cadiftipcam 	* @nfact 
                    , camtodiferir 	= camtodiferir 	* @nfact 
                    , camarktomarket = camarktomarket 	* @nfact 
                    , camtomon1ini = camtomon1ini 	* @nfact 
                    , camtomon1fin = camtomon1fin 	* @nfact 
                    , camtomon2ini = camtomon2ini 	* @nfact 
                    , camtomon2fin = camtomon2fin 	* @nfact 
                    , carevusd = carevusd 		* @nfact 
                    , carevtot = carevtot 		* @nfact 
                    , cavalordia = cavalordia 		* @nfact 
                    , cactacambio_a = cactacambio_a 	* @nfact 
                    , cactacambio_c = cactacambio_c 	* @nfact 
                    , caperddiferir = caperddiferir 	* @nfact 
                    , caperddevenga = caperddevenga 	* @nfact 
                    , caperdacum = caperdacum 		* @nfact 
                    , caperdsaldo = caperdsaldo 	* @nfact 
                    , caclpmoneda1 = caclpmoneda1 	* @nfact 
		    , caclpmoneda2 = caclpmoneda2 	* @nfact 
                    , cavalorayer = cavalorayer 	* @nfact 
                    , mtm_hoy_moneda1 = mtm_hoy_moneda1 * @nfact 
                    , mtm_hoy_moneda2 = mtm_hoy_moneda2 * @nfact 
                    , carevtot_ayer = carevtot_ayer 	* @nfact 
                    , fRes_Obtenido = fRes_Obtenido 	* @nfact 
                    , ValorRazonableActivo = ValorRazonableActivo * @nfact 
                    , ValorRazonablePasivo = ValorRazonablePasivo * @nfact
  		WHERE canumoper   =  @nnumoper 

   		SELECT  @nnumopOrig = @nnumop
    
   END
   
ELSE
   BEGIN
	    UPDATE MFCA SET  cafecvcto         	= @cfecant
                    ,caantici  			= 'A'
		    ,caparmon2			= CASE WHEN @ncodpos1 = 2 THEN @fParidadAnt ELSE caparmon2 END 
		    ,caparmon1			= CASE WHEN @ncodpos1 = 2 THEN 1 ELSE caparmon1 END
		    ,camtomon1         		= @nnocional   
                    ,precio_spot       		= @nPrecioSpot
                    ,caAntPtosFwd      		= @nptosfwd
                    ,caAntTasaPlazoRem 		= @ntasaplazorem
                    ,caAntBase         		= @nbase   
                    ,catipmoda         		= @cTipModa
                    ,cafecha           		= @cfecIniOrig
		    ,capreciomtm       		= @nPrecioSpotPtos -->revisar
		    ,CaPrecioFwd       		= @nprecpactdesc  
		    ,CaAntPreOpEF		= @fParidadAnt
                    ,cafpagomn         		= @nfpagoMN
                    ,cafpagomx         		= @nfpagoMX
		    ,cacolmon1         		= 0
                    ,cacapmon1         		= @nAntMtoMonCompAntes
                    ,camarktomarket    		= @nmtm 
		    ,caMtoComp			= @nValorAnticipo
                    ,moneda_compensacion 	= @nmdacomp 
                    ,caAntForPagMdaComp 	= @nforpagMdaComp
                    ,caAntParContraMda 		= @nparcontmda
             	    ,caAntParMdaComp   		= @nparmdacomp
                    ,caAntFactorContMda  	= @caAntFactorContMda  
		    ,caAntMtoMdaComp   		= @nmtomoncomp
                    ,numerocontratocliente 	= @nnumoper
                    ,caAntCorrela       	= @ncorrela
                    ,caestado           	= ''
                    ,caoperador         	= @coperador  
                    ,caplazovto        		= DATEDIFF(dd,@cfecproc,@cfecant)
                    ,caplazocal        		= DATEDIFF(dd,@cfecproc,@cfecant)
                    ,caplazo           		= DATEDIFF(dd,@cfecproc,@cfecant)                
                    ,cafecvenor        		= @cfecvctoOrig
                    ,caautoriza        		= ''
                    ,caobserv          		= '' 
                    ,caobservlin       		= ''  
		    
   	WHERE canumoper   = @nnumoper 

   	SELECT  @nnumopOrig = @nnumoper

   END 

   IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la actualización de Cartera'
      SET NOCOUNT OFF
      RETURN
   END

    IF ( @cTipModa = 'E' or @cModalidad = 'E') 
    BEGIN
      EXECUTE Sp_EnviarSpotAnticipo @nnumopOrig
    END 

    IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al ejecutar procedimiento Sp_EnviarSpotAnticipo '
      SET NOCOUNT OFF
      RETURN
    END

   IF ( @cTipModa = 'E' or @cModalidad = 'E') 
    BEGIN
      EXECUTE BacCamSuda..Sp_Capturaforward
    END 

    IF @@error <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: al ejecutar procedimiento Sp_Capturaforward '
      SET NOCOUNT OFF
      RETURN
    END


   COMMIT TRANSACTION

   SELECT @nnumopOrig, 'OK'

   SET NOCOUNT OFF
END

GO

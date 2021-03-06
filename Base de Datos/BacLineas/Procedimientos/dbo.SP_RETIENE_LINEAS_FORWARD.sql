USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETIENE_LINEAS_FORWARD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETIENE_LINEAS_FORWARD]
AS 
BEGIN

   SET NOCOUNT ON
   DECLARE @ncont  	   INTEGER
   ,       @Posicion1  	   CHAR(03)
   ,       @Numoper 	   NUMERIC(10)
   ,       @rut      	   NUMERIC(9)
   ,       @CodCli     	   NUMERIC(09)
   ,       @rut1      	   NUMERIC(9)
   ,       @CodCli1        NUMERIC(09)
   ,       @MtoMda1    	   NUMERIC(21,04)
   ,       @fecvcto    	   CHAR(08)
   ,       @fechini    	   CHAR(08)
   ,       @MercadoLc  	   CHAR(01)
   ,       @moneda  	   NUMERIC(05)
   ,       @nregs  	   INTEGER
   ,       @producto 	   CHAR(05)
   ,       @fecpro	   DATETIME
   ,       @nContraMoneda  NUMERIC(03)
   ,       @nMonedaOpera   NUMERIC(03)
   ,       @nPerdidaDev	   NUMERIC(21,04)
   ,       @nTipoOperacion NUMERIC(05)
   ,       @nPlazoResidual NUMERIC(05)
   ,       @nTipoCam	   FLOAT
   ,       @nDolarHoy	   FLOAT
   ,       @Moneda_Sis	   NUMERIC(10)
   ,       @PERDIDALIM	   FLOAT
   ,       @Monto_Ori	   FLOAT
   ,       @Monto_USD	   FLOAT
   ,       @Clase_Op 	   CHAR(1)
   ,       @iDiasValor     INTEGER
		
   SELECT 	
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
,	'BFW' AS id_sistema
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
,       fp.diasvalor
   INTO   #tmp_car 
   FROM   bacfwdsuda.dbo.MFAC MFAC
   ,      bacparamsuda.dbo.CLIENTE	
   ,      bacfwdsuda.dbo.MFCA     INNER JOIN bacparamsuda.dbo.PRODUCTO P       ON P.id_sistema = 'BFW' AND Codigo_producto = cacodpos1
                               left  join bacparamsuda.dbo.FORMA_DE_PAGO fp ON cafpagomn    = fp.codigo
   WHERE  cafecvcto    = acfecproc 
   AND    cacodpos1    IN(1,2,3,7,10)
   AND    cacodigo     = clrut 
   AND    cacodcli     = clcodigo
   and    catipmoda    = 'C'
   ORDER BY canumoper

   INSERT INTO #tmp_car 
   SELECT 	
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
,	'BFW' AS id_sistema
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
,	'' AS caobservlim
,	caautoriza
,	catasa_efectiva_moneda1
,	catasa_efectiva_moneda2
,	cautilacum_ayer
,	caperdacum_ayer
,	carevusd_ayer
,	carevuf_ayer
,	carevtot_ayer
,	0 AS caoperrelaspot
,	catasaEfectMon1
,	catasaEfectMon2
,	catipcamSpot
,	catipcamFwd
,	cafecEfectiva
,       fp.diasvalor
 FROM   bacfwdsuda.dbo.MFAC
 ,      bacfwdsuda.dbo.MFCAH    INNER JOIN bacparamsuda.dbo.PRODUCTO P       ON P.id_sistema = 'BFW' AND Codigo_producto = cacodpos1
                             LEFT  JOIN bacparamsuda.dbo.FORMA_DE_PAGO fp ON cafpagomn    = fp.codigo
                             LEFT  JOIN bacparamsuda.dbo.CLIENTE          ON cacodigo     = clrut AND cacodcli = clcodigo
   WHERE  canumoper   in(SELECT numero_operacion FROM baclineas.dbo.LINEAS_RETENIDAS , bacfwdsuda.dbo.MFAC WHERE id_sistema = 'BFW' AND fecha_pago >= acfecproc and estado_liberacion = 'N') 
   ORDER BY canumoper

   SELECT  @fechini = CONVERT(CHAR(8), acfecproc ,112)    
   FROM    bacfwdsuda.dbo.MFAC

   SELECT  @fecpro = acfecproc 
   FROM    bacfwdsuda.dbo.MFAC

   SELECT @nDolarHoy = vmvalor
   FROM   bacparamsuda.dbo.valor_moneda 	
   WHERE  vmcodigo   = 994 
   AND    vmfecha    = @fecpro

   CREATE TABLE #Tmp_Moneda
   (   Codigo	NUMERIC(10)
   ,   TCambio	FLOAT
   ,   Tipo	CHAR(01)
   )

   INSERT #TMP_MONEDA
   SELECT mncodmon,1.0, mnrrda
   FROM   bacparamsuda.dbo.MONEDA

   UPDATE #TMP_MONEDA
   SET    TCambio  = CASE WHEN vmvalor = 0.0 THEN 1.0 ELSE vmvalor END
   FROM   bacparamsuda.dbo.VALOR_MONEDA
   WHERE  vmcodigo = Codigo
   AND    vmfecha  = @fecpro

   UPDATE #TMP_MONEDA
   SET    TCambio = @nDolarHoy
   WHERE  Codigo  = 13

   /*
   SELECT 'Numero   '= canumoper        
   ,      'fecha    '= min(corfecvcto)  
   ,      'fechaven '= cafecvcto
   into    #cortes
   FROM    bacfwdsuda.dbo.mfca 	
   ,	   bacfwdsuda.dbo.cortes
   WHERE   canumoper  = cornumoper
   AND	   corfecvcto = @fecpro
   GROUP BY canumoper, cafecvcto

   update #tmp_car
   set    cafecvcto = CASE WHEN fechaven >= fecha THEN fechaven ELSE fecha END
   from   #cortes
   where  canumoper = Numero
   */

   update #tmp_car
   set    cafecvcto = @fecpro

   /*
   UPDATE  baclineas.dbo.LINEA_SISTEMA 
   SET	   TotalOcupado    = 0
   ,	   TotalExceso 	   = 0
   ,	   TotalDisponible = TotalAsignado
   WHERE   id_sistema      = 'BFW'

   UPDATE  baclineas.dbo.LINEA_PRODUCTO_POR_PLAZO
   SET	   TotalOcupado    = 0
   ,	   TotalExceso 	   = 0
   ,	   TotalDisponible = TotalAsignado
   WHERE   id_sistema      = 'BFW'
   */

   SELECT @nregs = COUNT(1)
   FROM   #tmp_car

   SELECT @ncont = 1

   WHILE @ncont <= @nregs
   BEGIN  
      SET ROWCOUNT @ncont

      SELECT @Posicion1     = CONVERT(CHAR(3),cacodpos1)     
      ,      @Numoper       = canumoper        
      ,      @rut           = cacodigo       
      ,      @CodCli        = cacodcli       
      ,      @rut1          = cacodigo       
      ,      @CodCli1       = cacodcli       
      ,      @MtoMda1       = CASE WHEN cacodpos1 = 2  THEN  camtomon2 
                                   WHEN cacodpos1 = 3  THEN  caequusd1 
                                   WHEN cacodpos1 = 10 THEN  caequusd2
                                   ELSE camtomon1 
                              END       
      ,      @fecvcto       = CONVERT(CHAR(8),cafecvcto,112)    
      ,      @MercadoLc     = CASE clpais WHEN 6 THEN 'S' ELSE 'N' END   
      ,      @Moneda        = cacodmon1 
      ,      @producto      = CONVERT(CHAR(5),cacodpos1)	
      ,      @nMonedaOpera  = ISNULL(CASE WHEN cacodpos1 = 2 THEN cacodmon2 
                                          ELSE cacodmon1 
                                     END,0)
      ,      @nContraMoneda = ISNULL(CASE WHEN Contra_Moneda = 'S' THEN ISNULL(CASE WHEN cacodpos1 = 2 THEN cacodmon1 ELSE cacodmon2 END,0)
				          ELSE                          0 
				     END,0)
      ,      @nPerdidaDev   = CASE WHEN cacodpos1 In(1,7) then carevtot
				   WHEN cacodpos1 In(2)   then cavalordia
				   When cacodpos1 In(3)   then cautilacum
			      end
      ,      @nTipoOperacion = cacodpos1			
      ,      @nPlazoResidual = caplazovto			
      ,      @Monto_Ori	     = camtomon1			
      ,      @Clase_Op	     = catipoper
      ,      @iDiasValor     = cafpagomn
      FROM   bacparamsuda.dbo.cliente	
      ,      #tmp_car 	     INNER JOIN bacparamsuda.dbo.producto P ON P.id_sistema = 'BFW' AND Codigo_producto = cacodpos1
      WHERE  cacodigo        = clrut 
      AND    cacodcli        = clcodigo
      ORDER BY canumoper

      SELECT @nPerdidaDev    = CASE WHEN @nPerdidaDev < 0 THEN 0 ELSE @nPerdidaDev END

      /******* Actualiza el Monto Origen a Dolar con la Paridad del día *******/

      SELECT @Monto_USD = @MtoMda1

      IF @Posicion1 in(2,3)
      BEGIN
         SELECT @Monto_USD = CASE WHEN @Posicion1 In(2) THEN (@Monto_Ori * Tcambio) / @nDolarHoy
	  	                  WHEN @Posicion1 In(3) THEN (@Monto_Ori * Tcambio) / @nDolarHoy
   	        	     END
         FROM   #Tmp_Moneda  
         WHERE  Codigo      = @Moneda
      END

      SELECT @MtoMda1 = @Monto_USD
      /******************************* FIN ***********************************/

      IF EXISTS(SELECT 1 FROM baclineas.dbo.CLIENTE_RELACIONADO WHERE clrut_hijo = @rut1 AND clcodigo_hijo = @CodCli1)
      BEGIN
         SELECT	@rut1           = clrut_padre		
         ,      @CodCli1        = clcodigo_padre
         FROM	baclineas.dbo.CLIENTE_RELACIONADO 
         WHERE 	clrut_hijo 	= @rut1	
         AND    clcodigo_hijo 	= @CodCli1
      END	

      SET ROWCOUNT 0

      SELECT @ncont = @ncont + 1

      IF EXISTS( SELECT 1 FROM baclineas.dbo.linea_sistema WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'BFW')
      BEGIN

         IF NOT EXISTS(SELECT 1 FROM baclineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BFW' AND numero_operacion = @Numoper AND estado_liberacion = 'S')
         BEGIN

            IF NOT EXISTS(SELECT 1 FROM baclineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BFW' AND numero_operacion = @Numoper)
            begin
            INSERT INTO baclineas.dbo.LINEAS_RETENIDAS 
            SELECT @fechini
            ,      'BFW'
            ,      @Posicion1
            ,      @Clase_Op
            ,      @Numoper
            ,      0
            ,      0
            ,      @rut
            ,      @CodCli
            ,      @MtoMda1
            ,      @Monto_Ori
            ,      @Monto_Ori
            ,      0.0
            ,      0.0
            ,      @iDiasValor
            ,      @fechini
            ,      'N'
            end

         EXECUTE baclineas.dbo.SP_LINEAS_CHEQUEARGRABAR  	
                 @fechini 
         ,       'BFW'  
         ,       @Posicion1 
         ,       @Numoper  
         ,       @Numoper  
         ,       0  
         ,       @rut   
         ,       @CodCli  
         ,       @MtoMda1  
         ,       0  
         ,       @fecvcto  
         ,       ''  
         ,       0  
         ,       0  
         ,       @fechini 
         ,       0  
         ,       'N'  
         ,       @moneda  
         ,       'C'  
         ,       0  
         ,       'N'  
         ,       0  
         ,       @fechini 
         ,       0	
         ,       0	
         ,       0	
         ,       0	
         ,       ''

         --  Esto para crear linea por plazo si no existe                        
         EXECUTE baclineas.dbo.SP_LINEAS_CHEQUEAR 
                 'BFW'
         ,       @producto
         ,       @Numoper
         ,       ''
         ,       'N'
         ,       'S'

         EXECUTE baclineas.dbo.SP_LINEAS_GRBOPERACION
                'BFW'  	
         ,      @Posicion1 	
         ,      @Numoper 	
         ,      @Numoper 	
         ,      ' '  		
         ,      'N'  		
         ,      @MercadoLc	
         ,      @nContraMoneda	
         ,      @nMonedaOpera

	SELECT @Moneda_Sis      = CONVERT(NUMERIC(10),Moneda) --Rescata Moneda Sistema
	FROM   baclineas.dbo.LINEA_SISTEMA
	WHERE  rut_cliente 	= @rut
        AND    codigo_cliente	= @Codcli
        AND    id_sistema	= 'BFW'

        SELECT @PERDIDALIM      = @nPerdidaDev / TCambio 
	FROM   #Tmp_Moneda
	WHERE  Codigo           = @Moneda_Sis

         IF @nPerdidaDev > 0 
         BEGIN
            /***************** Inicio linea_sistema **************************/
            UPDATE baclineas.dbo.LINEA_SISTEMA
            SET    TotalOcupado    = round(isnull(TotalOcupado,0),4) 	-- + ROUND(isnull(@PERDIDALIM,0),4) - Se comenta por solicitud de usuario de Control Financiero					
            ,      TotalDisponible = round(isnull(TotalAsignado,0),4) 	- round(isnull(TotalOcupado,0),4)  -- + ROUND(isnull(@PERDIDALIM,0),4) - Se comenta por solicitud de usuario de Control Financiero
            WHERE  Id_Sistema      = 'BFW' 	
            AND    Rut_Cliente     = @rut1  	
            AND    Codigo_Cliente  = @CodCli1       

            UPDATE  baclineas.dbo.LINEA_SISTEMA
            SET     TotalExceso     = CASE WHEN round(isnull(TotalDisponible,0),4) < 0       THEN round(isnull(TotalAsignado,0),4) - round(isnull(TotalOcupado,0),4)
			  		   Else                                                   1
			  	      END
            ,       TotalDisponible = round(CASE WHEN round(isnull(TotalDisponible,0),4) < 0 THEN 0
			  	                 ELSE                                             round(ISNULL(TotalDisponible,0),4)
			  	            END,4)
            WHERE   Id_Sistema      = 'BFW'  
            AND     Rut_Cliente     = @rut1  
            And     Codigo_Cliente  = @CodCli1

            /***************** Fin linea_sistema **************************/
            /***************** Inicio LINEA_GENERAL **************************/
            --Select /*convert(numeric(10),Moneda),*/* from baclineas.dbo.LINEA_GENERAL where rut_cliente =97919000

              UPDATE baclineas.dbo.LINEA_GENERAL
              SET    TotalOcupado    = round(isnull(TotalOcupado,0),4) 	+ ROUND(isnull(@PERDIDALIM,0),4)					
              ,      TotalDisponible = round(isnull(TotalAsignado,0),4) 	- round(isnull(TotalOcupado,0),4) + ROUND(isnull(@PERDIDALIM,0),4)	
              WHERE  Rut_Cliente     = @rut1  	
              And    Codigo_Cliente  = @CodCli1      
	
              UPDATE baclineas.dbo.LINEA_GENERAL
              SET    TotalExceso     = CASE WHEN round(isnull(TotalDisponible,0),4) < 0       THEN round(isnull(TotalAsignado,0),4) - round(isnull(TotalOcupado,0),4)
			  		    ELSE                                                   1
			  	       END
              ,      TotalDisponible = round(CASE WHEN round(isnull(TotalDisponible,0),4) < 0 THEN 0
			  	                  ELSE       round(ISNULL(TotalDisponible,0),4)
			  	             END,4)
              WHERE Rut_Cliente      = @rut1    
              AND   Codigo_Cliente   = @CodCli1 

              /***************** Fin LINEA_GENERAL **************************/
              /***************** Inicio LINEA_PRODUCTO_POR_PLAZO **************************/

              UPDATE baclineas.dbo.LINEA_PRODUCTO_POR_PLAZO
              SET    TotalOcupado    = round(isnull(TotalOcupado,0),4) 	+ ROUND(isnull(@PERDIDALIM,0),4)					
              ,      TotalDisponible = round(isnull(TotalAsignado,0),4) - round(isnull(TotalOcupado,0),4) + ROUND(isnull(@PERDIDALIM,0),4)	
              WHERE  rut_cliente     = @rut1 		  
              AND    codigo_cliente  = @Codcli1	  
              AND    id_sistema	     = 'BFW'   	  
              AND    codigo_producto = @Posicion1	  
              AND    plazodesde     <= @nPlazoResidual 
              AND    plazohasta      > @nPlazoResidual 
	
              UPDATE baclineas.dbo.LINEA_PRODUCTO_POR_PLAZO
              SET    TotalExceso     = CASE WHEN round(isnull(TotalDisponible,0),4) < 0 THEN round(isnull(TotalAsignado,0),4) - round(isnull(TotalOcupado,0),4)
			  		    ELSE                                             1
			  	       END
              ,      TotalDisponible = round(CASE WHEN round(isnull(TotalDisponible,0),4) < 0 THEN 0
			  	                  ELSE                                             round(ISNULL(TotalDisponible,0),4)
			  	             END,4)
              WHERE  rut_cliente     = @rut1 	  
              AND    codigo_cliente  = @Codcli1	  
              AND    id_sistema	     = 'BFW'   	  
              AND    codigo_producto = @Posicion1	  
              AND    plazodesde     <= @nPlazoResidual 
              AND    plazohasta      > @nPlazoResidual 

	 END

      /***************** Fin LINEA_PRODUCTO_POR_PLAZO **************************/

         EXECUTE bacfwdsuda.dbo.SP_GRABA_REGISTRO_UTILIDAD_BANCO  	@Numoper	,
							@nTipoOperacion	,
							@rut  	,
				    		@CodCli  	,
							@nMonedaOpera	,
							@PERDIDALIM	,
							@nContraMoneda  ,
							@nPlazoResidual	,
							@Monto_Ori	,
							@MtoMda1	,
							@Clase_Op
      END
     END

  END


   EXECUTE baclineas.dbo.SP_RECALCULA_GENERAL

   UPDATE  baclineas.dbo.matriz_atribucion_instrumento 
   SET	   Acumulado_Diario = 0
   WHERE   Id_Sistema       = 'BFW'

END
GO

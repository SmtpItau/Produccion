USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRASPASOOPERACIONES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRASPASOOPERACIONES]   
AS    
BEGIN    
    
   --> Control de Modificación: Fecha: 06 Febrero 2008. Usuario : AGonzalF    
   --> Item N° 11 - Distincion entre curvas TM y MC - Mejoras Riesgo Financiero -    
   --> Se Modifica el proceso de de carga de tabla MFCAH => Se agrega Campo ( caOrgCurvaMon, caOrgCurvaCnv )    
    
   SET NOCOUNT ON    
    
   /*=======================================================================*/    
   /* Proceso de traspaso  de cartera de vencimientos                       */    
   /*=======================================================================*/    
    
   DECLARE @dfecproc     DATETIME    
   DECLARE @dfecante     DATETIME    
   DECLARE @dfecproxpro  DATETIME    
   DECLARE @numoper      NUMERIC(7)    
   DECLARE @Estado       NUMERIC(3)    
   DECLARE @MsgErr       VARCHAR(100)    
   DECLARE @Modalidad    CHAR(1)    
   DECLARE @Mtocomp      FLOAT    
   DECLARE @MtoTesore    FLOAT    
   DECLARE @MdaTesore    CHAR(3)    
   DECLARE @cPaisCliente CHAR(50)    
   DECLARE @nrutcli      NUMERIC(9)    
   DECLARE @ncodcli      NUMERIC(9)    
   DECLARE @ncodpos1     NUMERIC(2)    
   DECLARE @ctipope      CHAR(4)    
   DECLARE @ncodsuc1     NUMERIC(3)    
   DECLARE @cfpago       CHAR(4)    
   DECLARE @nregs        INT    
   DECLARE @ncont        INT    
   DECLARE @nvalor       FLOAT    
   DECLARE @fecvcto      DATETIME    
   DECLARE @cartera      NUMERIC(9)    
   DECLARE @afecta_hedge INT    
   DECLARE @TipMer       CHAR(04)    
   DECLARE @TipOper_spot CHAR(01)    
   DECLARE @ntipcam      FLOAT    
   DECLARE @nmtomon1     NUMERIC(21,4)    
   DECLARE @fecEfectiva  DATETIME    
    
   SELECT  @dfecante     = acfecante    
   ,       @dfecproc     = acfecproc     
   ,       @dfecproxpro  = acfecprox    
   FROM    MFAC          with (nolock)    
    
   /*=======================================================================*/    
   /* Proceso de traspaso  de cartera a base historica                      */    
   /*=======================================================================*/    
    
   INSERT INTO CORTESH    
   SELECT cornumoper    
   ,      corcorrela    
   ,      corfecvcto    
   ,      cormonto    
   ,      cormontocomp    
   ,      cormontodia    
   ,      corprecio    
   ,      corpreciodia    
   ,      correscnv    
   ,      corsaldo    
   ,      corsaldoAcu    
   ,      corsalAcum    
   ,      correajac    
   ,      corresclp    
   ,      corultimo    
   ,      cortastab    
   ,      corestado    
   ,      corbase    
   ,      cointeresac    
   ,      correajayer    
   ,      corinteresayer    
   FROM   CORTES    with (nolock)    
   ,      MFCA      with (nolock)    
   WHERE  cafecvcto <= @dfecante    
   AND    cacodpos1  = 7    
   AND    canumoper  = cornumoper    
    
   INSERT INTO MFCAH    
   (   cafecproc    
   ,   canumoper    
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
   ,   cavalorayer    
   ,   camontopfe    
   ,   camontocce    
   ,   catasaEfectMon1    
   ,   catasaEfectMon2    
   ,   catipcamSpot    
   ,   catipcamFwd    
   ,   cafecEfectiva    
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
   ,   capreciopunta    
   ,   estado_sinacofi    
   ,   fecha_estado_sina    
   ,   numerocontratocliente    
   ,   caOrgCurvaMon    
   ,   caOrgCurvaCnv    
   ----------------------    
   ,   cacosto_usdclp    
   ,   cacosto_mxusd    
   ,   cacosto_mxclp    
   ,   cafijaTCRef    
   ,   cafijaPRRef    
   ,   caSpotTipCam    
   ,   caSpotParidad    
   ---------------------    
   ,   Resultado_Mesa    
   ---------------------    
   ,   Threshold    
   ,   CaFechaStarting    
   ,   CaFechaFijacionStarting    
   ,   CaPuntosFwdCierre    
   ,   CaPuntosTransfObs    
   ,   CaPuntosTransfFwd    
   ,   CaTasaPriPzoFijObs    
   ,   CaTasaSecPzoFijObs    
   ,   CaDelta    
   --> PRD 12712 Early Termination
   ,   bEarlyTermination      
   ,   FechaInicio            
   ,   Periodicidad
   --> PRD 12712      
   )    
   SELECT    
       @dfecante    
   ,   canumoper    
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
   ,  caperdsaldo    
   ,   caclpmoneda1    
   ,   caclpmoneda2    
   ,   camtocomp    
   ,   caantici    
   ,   cafecvenor    
   ,   cavalorayer    
   ,   camontopfe    
   ,   camontocce    
   ,   catasaEfectMon1    
   ,   catasaEfectMon2    
   ,   catipcamSpot    
   ,   catipcamFwd    
   ,   cafecEfectiva    
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
   ,   capreciopunta    
   ,   estado_sinacofi    
   ,   fecha_estado_sina    
   ,   numerocontratocliente    
   ,   caOrgCurvaMon    
   ,   caOrgCurvaCnv    
   ----------------------    
   ,   cacosto_usdclp    
   ,   cacosto_mxusd    
   ,   cacosto_mxclp    
   ,   cafijaTCRef    
   ,   cafijaPRRef    
   ,   caSpotTipCam    
   ,   caSpotParidad    
   ----------------------    
   ,   Resultado_Mesa    
   ----------------------    
   ,   Threshold    
   ,   CaFechaStarting    
   ,   CaFechaFijacionStarting    
   ,   CaPuntosFwdCierre    
   ,   CaPuntosTransfObs    
   ,   CaPuntosTransfFwd    
   ,   CaTasaPriPzoFijObs    
   ,   CaTasaSecPzoFijObs    
   ,   CaDelta    
   --> PRD 12712 Early Termination
   ,   bEarlyTermination      
   ,   FechaInicio            
   ,   Periodicidad
   --> PRD 12712     
    
   FROM  MFCA      with (nolock)    
   WHERE cafecvcto <= @dfecante    
    
   /*=======================================================================*/    
   /* Proceso de borrado de vctos. de cartera                               */    
   /*=======================================================================*/    
   DELETE FROM MFCA    
         WHERE cafecvcto <= @dfecante    
    
    
 /**************************************************************************************************/    
 /******************** TRASPASA FLUJOS VENCIDOS A TABLA TBL_CARTERA_FLUJOS_RES *********************/    
 /**************************************************************************************************/    
     
 --1° PARAMETRO (NUMERO_OPERACION) - TODAS LAS OPERACIONES (0)    
 --2° PARAMETRO (CORRELATIVO)  - TODOS LOS CORRELATIVOS (0)    
 --3° PARAMETRO (TIPO ELIMINACION) - POR VENCIMIENTO (V)    
 EXEC SP_DEL_SEGURO_INFLACION_MV 0,0,'V'     
    
   /*=======================================================================*/    
   /* Traspasa Valorizacion de Cartera para la reversa                      */    
   /*=======================================================================*/    
    
-- GLCF    
   UPDATE MFCA    
   SET    cavalorayer = CASE WHEN cacodpos1 IN (2,10) THEN cavalordia     
    WHEN cacodpos1 IN(1,7,3,13) THEN carevTot    
                                ELSE                                 0    
   END    
/* GLCF    
   UPDATE MFCA    
   SET    cavalorayer = cavalordia    
   WHERE  cacodpos1 IN (2,10)    
    
   UPDATE MFCA    
   SET    cavalorayer = carevTot    
   WHERE  cacodpos1 IN(1,7,3,13)    
*/    
    
  
   -->     Se carga el Observado en el Precio Spot, para los Forward Observados.  
   DECLARE @DolarObs       FLOAT  
       SET @DolarObs       = 0.0  
       SET @DolarObs       = isnull(( SELECT isnull(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA   
                                       WHERE vmfecha = @dfecproc AND vmcodigo = 994 ), 0.0)  
  
   UPDATE  BacFwdSuda.dbo.MFCA   
      SET  catipcamSpot    = @DolarObs  
    WHERE  cacodpos1       = 14  
      and  cafechastarting = @dfecproc  
   -->     Se carga el Observado en el Precio Spot, para los Forward Observados.  
  
   UPDATE CORTES    
   SET    correajayer    = correajac    
   ,      corinteresayer = cointeresac            
    
   -->   AQUI COMIENZAN LOS CAMBIOS    
   DECLARE @correla    NUMERIC(10)    
   DECLARE @numero     NUMERIC(10)    
   DECLARE @dfecha     DATETIME    
   DECLARE @cont       INT    
   DECLARE @reg        INT    
  
           SET @reg  = 0    
       SET @cont = 0    
    
   SELECT *     
        , Id_Temp1   = Identity(INT)    
     INTO #TMP1     
     FROM CORTES     with (nolock)    
    WHERE corestado <> 1    
    
   SELECT @reg  = MAX(Id_Temp1)    
   ,      @cont = MIN(Id_Temp1)    
   FROM   #TMP1    
     
   WHILE @reg >= @cont    
   BEGIN    
    
      SET    @correla = 0    
    
      SELECT @numero  = cornumoper    
      FROM   #TMP1    
      WHERE  Id_Temp1 = @cont    
    
      SET @cont = @cont + 1    
    
      SELECT @correla = corcorrela + 1    
      ,      @numero  = cornumoper    
      FROM   CORTES     with (nolock)    
      WHERE  corfecvcto < @dfecante    
      AND    cornumoper = @numero    
       
      SELECT @dfecha    = corfecvcto    
      FROM   CORTES     with (nolock)    
      WHERE  corcorrela = @correla    
      AND    cornumoper = @numero    
    
      IF @dfecha <= @dfecante    
      BEGIN    
         UPDATE CORTES    
         SET    corestado  = 1    
         WHERE  corcorrela < @correla    
         AND    cornumoper = @numero   --> corfecvcto <= @dfecante    
      END    
   END    
   --> AQUI TERMINAN LOS CAMBIOS    
    
   /*=======================================================================*/    
   /* Proceso que mueve a Spot                                              */    
   /*=======================================================================*/    
   UPDATE BacCamSuda..MEAC with (rowlock)    
      SET achedgevctofuturo = 0    
    
      SET @nvalor  = 1.0    
    
   SELECT @nvalor  = ISNULL(vmvalor, 1.0)    
     FROM VIEW_VALOR_MONEDA with (nolock)    
    WHERE vmfecha  = @dfecproc     
      AND vmcodigo = 994    
    
      SET @ntipcam =  @nvalor    
    
   SELECT *    
        , Identity(int) as Id    
     INTO #VctoFwd    
     FROM MFCA      with (nolock)    
    WHERE cafecvcto <= @dfecproxpro     
    
      SET @nregs = (SELECT MAX(Id) FROM #VctoFwd)    
      SET @ncont = (SELECT MIN(Id) FROM #VctoFwd)    
    
   WHILE @nregs >= @ncont    
   BEGIN    
    
      SELECT @NumOper     = canumoper       
      ,      @Modalidad   = catipmoda       
      ,      @Mtocomp     = camtocomp       
      ,      @nrutcli     = cacodigo        
      ,      @ncodcli     = cacodcli        
      ,      @ctipope     = catipoper       
      ,      @ncodpos1    = cacodpos1       
      ,      @ncodsuc1    = cacodsuc1       
      ,      @fecvcto     = cafecvcto       
      ,      @cfpago      = CONVERT(CHAR(4),cafpagomn)     
      ,      @cartera     = cacodcart       
      ,      @nmtomon1    = camtomon1     
      ,      @fecEfectiva = cafecEfectiva    
      FROM   #VctoFwd    
      WHERE  Id           = @ncont    
    
      SET @ncont = @ncont + 1    
    
      IF (@Modalidad = 'E' AND @ncodpos1 IN(1, 2, 12, 14 )) AND @fecvcto <= @dfecproc -- Forward a Observado    
      BEGIN    
        EXECUTE @Estado = Sp_EnviarSpot @NumOper    
    
         IF @Estado < 0    
         BEGIN    
            SET @MsgErr = CASE WHEN @Estado = -1 THEN 'No Existe en Cartera la Operacion '     + CONVERT(VARCHAR(10),@NumOper)    
                               WHEN @Estado = -2 THEN 'Fechas SPOT no coincide con solicitada por FORWARD (' + CONVERT(VARCHAR(10),@NumOper)+ ')'    
                               ELSE                   'No se puede enviar a Spot Op. Forward ' + CONVERT(VARCHAR(10),@NumOper)    
                          END    
            SELECT @Estado, 'Error: En el traspaso de vencimientos Entrega Fisica a Spot. debido a ' + @MsgErr    
            RETURN    
         END    
      END    
    
      IF @ncodpos1 IN(1, 4, 5, 6, 7, 12,14)  
      BEGIN    
         SELECT @afecta_hedge = rcnumcorr    
           FROM VIEW_TIPO_CARTERA with (nolock)    
          WHERE rcsistema       = 'BFW'    
            AND rcrut           = @cartera    
            AND rccodpro        = @ncodpos1    
    
         IF @Modalidad = 'E' AND @fecvcto <= @dfecproc AND @cartera = 1  AND @afecta_hedge = 1    
         BEGIN    
            SET @TipMer       = 'FUTU'    
  SET @TipOper_spot = @ctipope    
    
            IF @ncodpos1 = 5     
            BEGIN    
               SET @TipMer       = '1446'    
               SET @TipOper_spot = CASE @ctipope WHEN 'O' THEN 'C' ELSE 'V' END    
            END    
    
            SET @nmtomon1 = @nmtomon1 * -1    
            EXECUTE SP_GMOVTO @TipMer, @TipOper_spot, @ntipcam, @nmtomon1, 1      
         END ELSE    
         BEGIN    
            IF @Modalidad = 'C' AND @fecvcto = @dfecproc    
            BEGIN    
               SET @TipMer       = 'FUTU'    
               SET @TipOper_spot = @ctipope    
    
               IF @ncodpos1 = 5     
               BEGIN    
                  SET @TipMer = '1446'    
                  SET @TipOper_spot = CASE @ctipope WHEN 'O' THEN 'C' ELSE 'V' END    
               END    
               SET @nmtomon1 = @nmtomon1 -- * -1 --> (CASE WHEN @TipOper_spot = 'C' THEN -1 ELSE 1 END)    
    
               EXECUTE Sp_Gmovto @TipMer, @TipOper_spot, @ntipcam, @nmtomon1, 1      
            END    
         END    
      END    
   END        
    
    
   /*=======================================================================*/    
   /* Proceso de borrado de movimientos                                     */    
   /*=======================================================================*/    
   DELETE FROM MFMO    
     
   /*=======================================================================*/    
   /* Proceso de borrado de calces                                          */    
   /*=======================================================================*/    
   DELETE FROM MFCC    
         WHERE ccfecven <= @dfecante    
    
   /*=======================================================================*/    
   /* Actualiza Datos de Informe de Resultados                            */    
  /*=======================================================================*/    
   SELECT *    
     INTO #temp_res    
     FROM RESULTADO    
    WHERE fecha = @dfecante    
    
   UPDATE #temp_res     
      SET fecha = @dfecproc    
    
   DELETE FROM RESULTADO    
    WHERE fecha = @dfecproc    
    
   INSERT INTO RESULTADO (fecha, tipo)    
                   SELECT fecha, tipo FROM #temp_res    
    
   /*=======================================================================*/    
   /* Actualiza Datos de Resultados de Calces                        */    
   /*=======================================================================*/    
   SELECT *     
     INTO #temp_res1    
     FROM RESULTADO_CALCE    
    WHERE fecha = @dfecante    
    
   UPDATE #temp_res1 SET fecha = @dfecproc    
    
   DELETE FROM RESULTADO_CALCE    
          WHERE fecha = @dfecproc    
    
   INSERT INTO RESULTADO_CALCE (fecha, tipo )    
                         SELECT fecha, tipo FROM #temp_res1    
    
   /*=======================================================================*/    
   /* Actualiza Datos Tasas MTM                                             */    
   /*=======================================================================*/    
   SELECT *    
     INTO #TEMP_RES2    
     FROM VIEW_TASA_FWD with (nolock)    
    WHERE fecha = @dfecante    
    
   UPDATE #TEMP_RES2     
      SET fecha = @dfecproc    
    
   DELETE FROM VIEW_TASA_FWD     
         WHERE fecha = @dfecproc    
    
   INSERT INTO VIEW_TASA_FWD    
          SELECT * FROM #TEMP_RES2    
     
   /*=======================================================================*/    
   /* Actualiza Datos Moneda Extranjera                                     */    
   /*=======================================================================*/    
   SELECT vmcodigo    
   ,      vmvalor    
   ,      vmptacmp    
   ,      vmptavta    
   ,      vmfecha    
   ,      vmtipo    
   ,      vmparidad    
   ,      vmparmer    
   ,      vmposini    
   ,      vmprecoi    
   ,      vmparini    
   ,      vmprecoc    
   ,      vmparidc    
   ,      vmposic    
   ,      vmpreco    
   ,      vmpreve    
   ,      vmpmeco    
   ,      vmpmeve    
   ,      vmtotco    
   ,      vmtotve    
   ,      vmutili    
   ,      vmparco    
   ,      vmparve    
   ,      vmorden    
   ,      vmctacmb    
   ,      vmcmbini    
   ,      vmreval    
   ,      vmarbit    
   ,      vmparmer1    
   ,      vmnumstgo    
   INTO   #TEMP_RES3    
   FROM   VIEW_VALOR_MONEDA      with (nolock)    
          INNER JOIN VIEW_MONEDA with (nolock) ON mncodmon = vmcodigo      
   WHERE  mnmx     = 'C'      
   AND    vmfecha  = @dfecante    
    
   UPDATE #TEMP_RES3     
      SET vmfecha  = @dfecproc    
    
   DELETE VIEW_VALOR_MONEDA     
     FROM VIEW_MONEDA with (nolock)    
    WHERE vmfecha  = @dfecproc    
      AND mncodmon = vmcodigo    
      AND mnmx     = 'C'    
    
   INSERT INTO view_valor_moneda    
   SELECT *  FROM #TEMP_RES3    
    
   SELECT 0    
   SET NOCOUNT OFF    
    
END    

GO

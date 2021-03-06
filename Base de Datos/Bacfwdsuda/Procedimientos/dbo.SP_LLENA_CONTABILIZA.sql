USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA]
   (   @Fecha_Hoy   DATETIME   )  
AS  
BEGIN  
   /* MAP Nov 2007    : NO convertia por la moneda compensacion cuando esta es 13. */  
  
   SET NOCOUNT ON  
  
   DECLARE @dAcfecproc   DATETIME  
       SET @dAcfecproc   = (SELECT acfecproc FROM MFAC with (nolock) )  
  
   DECLARE @dAcfecante   DATETIME  
       SET @dAcfecante   = (SELECT acfecante FROM MFAC with (nolock) )  
  
   DECLARE @FechaAnt     CHAR(8)  
       SET @FechaAnt     = CONVERT(CHAR(8), @dAcfecante ,112)  
  
   DECLARE @Fecha_Ayer   DATETIME  
       SET @Fecha_Ayer   = @dAcfecante  
  
   DECLARE @iFound       INTEGER  
      SET  @iFound       = -1  
  
   SELECT  @iFound       = 0  
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)  
   WHERE   Fecha         = @dAcfecproc  
   AND     Tipo_Cambio  <> 0  
  
   IF @iFound = -1  
   BEGIN  
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')  
      RETURN  
   END  
  
   DECLARE @Control_Error  INTEGER  
   DECLARE @diasdevengar   INTEGER  
   DECLARE @correla        NUMERIC(3)  
  
   DECLARE @FechaActual    CHAR(08)  
       SET @FechaActual    = CONVERT(CHAR(8),@Fecha_Hoy,112)  
  
   DECLARE @PrimerDiaMes   CHAR(08)  
       SET @PrimerDiaMes   = SUBSTRING(@FechaActual,1,6) + '01'  
  
   DECLARE @FechaValorMoneda DATETIME  
   DECLARE @FechaValorMonAye DATETIME  
  
   EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @Fecha_Hoy, @FechaValorMoneda OUTPUT  
   EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @FechaAnt,  @FechaValorMonAye OUTPUT  
  
   ----<< Chequea si es el Primer dia del Mes  
   IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(@FechaAnt,5,2)  
   BEGIN  
      SET @FechaAnt     = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)  
      SET @diasdevengar = DATEDIFF(DAY, @FechaAnt, @PrimerDiaMes)  
   END  
  
   --|========================================================================================|  
   --| LLENADO DE ARCHIVO DE CONTABILIZACION         |  
   --|========================================================================================|  
   TRUNCATE TABLE BAC_CNT_CONTABILIZA  
  
   IF @@ERROR <> 0  
   BEGIN  
      PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (FORWARD).'  
      RETURN 1  
   END  
  
   IF @Control_Error <> 0  
      RETURN 1  
  
   SELECT vmfecha  
        , vmcodigo  
        , vmvalor  
   INTO   #VALOR_MONEDA  
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)  
   WHERE (vmfecha   = @dAcfecproc OR vmfecha = @dAcfecante)  
   and    vmcodigo  NOT IN(999,998)  
     
   INSERT INTO #VALOR_MONEDA  
   SELECT @dAcfecproc  
   ,      vmcodigo  
   ,      vmvalor  
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)  
   WHERE  vmfecha   = @FechaValorMoneda  
   AND    vmcodigo  = 998  
  
   INSERT INTO #VALOR_MONEDA  
   SELECT @dAcfecante  
   ,      vmcodigo  
   ,      vmvalor  
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)  
   WHERE  vmfecha   = @FechaValorMonAye  
   AND    vmcodigo  = 998  
  
   INSERT INTO #VALOR_MONEDA   
   SELECT @dAcfecproc  
   ,      999  
   ,      1.0  
     
   INSERT INTO #VALOR_MONEDA  
   SELECT @dAcfecante  
   ,      999  
   ,      1.0  
  
   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --  
   SELECT vmfecha       = Fecha  
   ,      vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END  
   ,      vmvalor       = Tipo_Cambio  
   INTO   #VALOR_TC_CONTABLE  
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK)  
   WHERE (Fecha         = @dAcfecproc OR Fecha = @dAcfecante)  
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)  
  
   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --  
   INSERT INTO #VALOR_TC_CONTABLE  
   SELECT vmfecha  
   ,      vmcodigo  
   ,      vmvalor  
   FROM   #VALOR_MONEDA   
   WHERE  vmcodigo  IN(994,995,997,998,999)  
  
   DECLARE @fValorDo_Hoy   FLOAT  
       SET @fValorDo_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 994)  
  
   DECLARE @fValorIvp_Hoy  FLOAT  
       SET @fValorIvp_Hoy  = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 997)  
  
   DECLARE @fValorUf_Hoy   FLOAT  
       SET @fValorUf_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 998)  
  
   --> ***************************************  
   --> Contabilidad Normativa. 20 Junio 2006.-  
   --> ***************************************  
   --> ( 0 ) Movimiento Inicio --  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      Valor_Compra  
   ,      Valor_Venta  
   ,      Valor_Hoy_Recompra  
   ,      Utilidad_Valorizacion  
   ,      Perdida_Valorizacion  
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida  
   ,      Utilidad  
   ,      Perdida  
   ,      UtilidadEFisica  
   ,      PerdidaEFisica  
   ,      Valor_Presente  
   ,      Valor_Usd  
   ,      Mx_Recompra  
   ,      cantidad_cortes  
   )  
   SELECT 'Id_Sistema'                        = 'BFW'  
   ,      'Tipo_Movimiento'                   = 'MOV'  
   ,      'Tipo_Operacion'                    = LTRIM(RTRIM(cacodpos1)) + LTRIM(RTRIM(catipoper))  
   ,      'Operacion'                         = canumoper  
   ,      'Correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN cacodpos1 = 10 THEN cacodmon1  
                                                     ELSE                     cacodmon2  
                                                END  
   ,      'Moneda_Instrumento'                = CASE WHEN cacodpos1 = 2  THEN LTRIM(RTRIM(cacodmon1))  
                                                     WHEN cacodpos1 = 12 THEN LTRIM(RTRIM(cacodmon1))  
                                                     ELSE ''   
                                                END  
   ,      'forma_pago'                        = cafpagomn  
   ,      'Moneda_Compra (O)'                 = cacodmon1  
   ,      'Moneda_Venta  (C)'                 = cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = cacartera_normativa  
   ,      'SubCarteraNormativa'               = casubcartera_normativa  
   ,      'Valor_Compra_300'                  = CASE WHEN cacodmon1 = 998 THEN ISNULL(camtomon1 * @fValorUf_Hoy  ,0.0)  
                                                     WHEN cacodmon1 = 997 THEN ISNULL(camtomon1 * @fValorIvp_Hoy ,0.0)  
                                                     WHEN cacodmon1 = 994 THEN ISNULL(camtomon1 * @fValorDo_Hoy  ,0.0)  
                                                     ELSE                      camtomon1  
                                                END  
   ,      'Valor_Venta_301'                   = ISNULL(camtomon1 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE   
                                                                     WHERE vmfecha  = @dAcfecproc AND vmcodigo = cacodmon1), 0.0 )  
                                                --> CASE WHEN cacodmon1 = 13 THEN 13 ELSE cacodmon1 END),0.0)  
   ,      'Valor_Hoy_Recompra_303'            = CASE WHEN cafecha = @Fecha_Hoy THEN 0.0  
                                                     ELSE ISNULL(camtomon1 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE   
                                                                               WHERE vmfecha  = @dAcfecante AND vmcodigo = cacodmon1) ,0.0)  
                                                                               --> CASE WHEN cacodmon1 = 13 THEN 13 ELSE cacodmon1 END),0.0)   
            END  
   ,      'Utilidad_Valorizacion_304'         = ISNULL(CASE WHEN fres_obtenido >= 0 THEN ABS(ROUND(fres_obtenido,0)) ELSE 0.0 END,0.0)  
   ,      'Perdida_Valorizacion_305'          = ISNULL(CASE WHEN fres_obtenido <  0 THEN ABS(ROUND(fres_obtenido,0)) ELSE 0.0 END,0.0)  
   ,      'Reversa_Valorizacion_Utilidad_306' = CASE WHEN cafecha = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL((SELECT CASE WHEN r.fres_obtenido >= 0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END   
                                                                    FROM MFCARES r WITH (NOLOCK)  
                                                                   WHERE canumoper = r.canumoper AND cafechaproceso = @dAcfecante),0.0)   
                                                END  
   ,      'Reversa_Valorizacion_Perdida_307'  = CASE WHEN cafecha = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL((SELECT CASE WHEN r.fres_obtenido <  0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END   
                                                                    FROM MFCARES r WITH (NOLOCK)  
                                                                   WHERE canumoper = r.canumoper AND cafechaproceso = @dAcfecante),0.0)   
                                                END  
   ,      'Utilidad_309'                      = CASE WHEN catipmoda = 'C' AND camtocomp >= 0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'Perdida_308'                       = CASE WHEN catipmoda = 'C' AND camtocomp  < 0 THEN ABS(camtocomp) ELSE 0.0 END  
  
   ,      'UtilidadEFisica_905'               = CASE WHEN catipmoda = 'E' AND camtocomp >= 0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'PerdidaEFisica_906'                = CASE WHEN catipmoda = 'E' AND camtocomp <  0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'Valor_Presente_310'                = camtomon2  
   ,      'Valor_Usd_311'                     = camtomon2           * (SELECT ISNULL(vmvalor,0.0)  
                                                                         FROM #VALOR_TC_CONTABLE   
                                                                        WHERE vmfecha = @dAcfecproc and vmcodigo = cacodmon2)  
                                                                        --> CASE WHEN cacodmon2 = 13 THEN 13 ELSE cacodmon2 END)  
   ,      'Mx_Recompra_312'                   = CASE WHEN cafecha   = @Fecha_Hoy THEN 0.0   
                                                     ELSE camtomon2 * (SELECT ISNULL(vmvalor,0.0)  
                                                                         FROM #VALOR_TC_CONTABLE  
                                                                        WHERE vmfecha = @dAcfecante and vmcodigo = cacodmon2)  
                                                                        --> CASE WHEN cacodmon2 = 13 THEN 13 ELSE cacodmon2 END)  
                                                END  
   ,      'cantidad_cortes'                   = 1  
   FROM   MFCA                            with (nolock)  
          LEFT JOIN BacParamSuda..CLIENTE with (nolock) ON cacodigo = clrut AND cacodcli = clcodigo  
   WHERE  cafecha               = @Fecha_Hoy  
   AND    caestado              = ''  
   AND    caantici             <> 'A'          -- MAP01 20070813 Descartará las 'Operaciones Anticipo' del día  
  
   -->    Crea la Contabilidad de la Modificacion  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      valor_usd  
   ,      Valor_Inicial_MN_Recompra  
   ,   cantidad_cortes  
   )  
   SELECT 'Id_Sistema'                        = 'BFW'  
   ,      'Tipo_Movimiento'                   = 'MOD'  
   ,   'Tipo_Operacion'               = 'M' + LTRIM(RTRIM(car.cacodpos1)) + LTRIM(RTRIM(car.catipoper))  
   ,      'Operacion'                         = car.canumoper  
   ,      'Correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN car.cacodpos1 = 10 THEN car.cacodmon1  ELSE car.cacodmon2 END  
   ,      'Moneda_Instrumento'                = CASE WHEN car.cacodpos1 = 2  THEN LTRIM(RTRIM(car.cacodmon1))           
                                                     ELSE ''   
                                                END  
   ,      'forma_pago'                        = car.cafpagomn  
   ,      'Moneda_Compra (O)'                 = car.cacodmon1  
   ,      'Moneda_Venta  (C)'                 = car.cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = car.cacartera_normativa  
   ,      'SubCarteraNormativa'               = car.casubcartera_normativa  
   ,      'Valor_Usd_311'                     = car.camtomon2 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = CASE WHEN car.cacodmon2 = 13 THEN 13 ELSE car.cacodmon2 END)  
   ,      'Valor_Inicial_MN_Recompra_923'     = res.camtomon2 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecante and vmcodigo = CASE WHEN res.cacodmon2 = 13 THEN 13 ELSE res.cacodmon2 END)  
   ,      'cantidad_cortes'                   = 1  
   FROM   MFCA                             car with (nolock)   
          INNER JOIN MFCARES               res with (nolock) ON res.cafechaproceso = @dAcfecante AND res.canumoper = car.canumoper  
          INNER JOIN BacParamSuda..CLIENTE cli with (nolock) ON cli.clrut = car.cacodigo AND cli.clcodigo = car.cacodcli  
   WHERE  car.cacodpos1                       = 13  
     AND  car.cafecha                         > @Fecha_Hoy  
     AND  car.cafecmod                        = @Fecha_Hoy  
   -->    Crea la Contabilidad de la Modificacion  
  
--   --> ( 4 ) Reversa Lbtr  
--   INSERT INTO BAC_CNT_CONTABILIZA  
--   (      id_sistema  
--   ,      tipo_movimiento  
--   ,      tipo_operacion  
--   ,      operacion  
--   ,      correlativo  
--   ,      codigo_instrumento  
--   ,      moneda_instrumento  
--   ,      valor_futuro  
--   ,      valor_compra  
--   ,      forma_pago  
--   ,      cantidad_cortes  
--   )  
--   SELECT 'id_sistema'          = 'BFW'  
--   ,      'tipo_movimiento'     = 'REV'  
--   ,      'tipo_operacion'      = 'RLB'  
--   ,      'operacion'           = numero_operacion  
--   ,      'correlativo'         = 1  
--   ,      'codigo_instrumento'  = ''  
--   ,      'moneda_instrumento'  = ''  
--   ,      'valor_futuro'        = CASE WHEN Tipo_Movimiento = 'C' THEN monto_operacion ELSE 0 END  
--   ,      'valor_compra'        = CASE WHEN Tipo_Movimiento = 'A' THEN monto_operacion ELSE 0 END  
--   ,      'forma_pago'          = forma_pago  
--   ,      'cantidad_cortes'     = 1  
--   FROM   BacParamSuda..MDLBTR                  with (nolock)  
--          LEFT JOIN BacParamSuda..FORMA_DE_PAGO with (nolock) ON Codigo = forma_pago  
--   WHERE  Sistema  = 'BFW'  
--   AND    fecha_vencimiento = @Fecha_Hoy  
--   AND   fecha_vencimiento    <> fecha  
--   AND    Estado_envio         <> 'A'  
--   AND    diasvalor             > 0  
--   AND    forma_pago           <> 5  
  
/************************************************************  
 * Code para SADP  
  ************************************************************/  
-- Operaciones caen por SADP  
SELECT 'id_sistema' = 'BFW',  
       'tipo_movimiento' = 'REV',  
       'tipo_operacion' = 'RLB',  
       'operacion' = sdo.iOPE_Operacion,  
       'correlativo' = 1,  
       'codigo_instrumento' = '',  
       'moneda_instrumento' = '',  
       'valor_futuro' = CASE   
                             WHEN sto.sTOPER_AccionSADP = 'P' THEN sdo.fDETOPE_MontoPago  
                             ELSE 0  
                        END,  
       'valor_compra' = CASE   
                    WHEN sto.sTOPER_AccionSADP = 'C' THEN sdo.fDETOPE_MontoPago  
                             ELSE 0  
                        END,  
       'forma_pago' = CASE   
                           WHEN so.iOPE_Moneda = 999 THEN m.cafpagomn  
                           ELSE m.cafpagomx  
                      END,  
       'cantidad_cortes' = 1  
INTO #TMP_1  
FROM   db_SADP_Filiales.dbo.SADP_DetOperaciones sdo  
       INNER JOIN db_SADP_Filiales.dbo.SADP_Operaciones so  
            ON  so.dOPE_Fecha = sdo.dOPE_Fecha  
            AND so.idEntidad = sdo.idEntidad  
            AND so.idModulo = sdo.idModulo  
            AND so.idTipoOperacion = sdo.idTipoOperacion  
            AND so.iOPE_Operacion = sdo.iOPE_Operacion  
       INNER JOIN Bacfwdsuda.dbo.mfcah m  
            ON  m.canumoper = sdo.iOPE_Operacion  
       INNER JOIN db_SADP_Filiales.dbo.SADP_TipoOperaciones sto  
            ON  sto.idEntidad = so.idEntidad  
            AND sto.idModulo = so.idModulo  
            AND sto.idTipoOperacion = so.idTipoOperacion  
WHERE  sdo.idEntidad = 1  
       AND sdo.idModulo = 2  
       AND sdo.dDETOPE_FechaLiquidacion = @Fecha_Hoy  
       AND sdo.dDETOPE_FechaLiquidacion <> sdo.dOPE_Fecha  
    AND (CASE   
                           WHEN so.iOPE_Moneda = 999 THEN m.cafpagomn  
                           ELSE m.cafpagomx  
                      END)<>5  
  AND sdo.idFormaPago <>5        
  AND sdo.idEstado =4                         
  
   IF @@ERROR <> 0   
   BEGIN  
      PRINT 'Error Proceso de Actualización Reversa Lbtr.'  
      RETURN 1  
   END  
     
-- Operaciones caen por SADP VB6  
INSERT INTO #TMP_1  
 SELECT 'id_sistema'          = 'BFW'  
   ,      'tipo_movimiento'     = 'REV'  
   ,      'tipo_operacion'      = 'RLB'  
   ,      'operacion'           = numero_operacion  
   ,      'correlativo'         = 1  
   ,      'codigo_instrumento'  = ''  
   ,      'moneda_instrumento'  = ''  
   ,      'valor_futuro'        = CASE WHEN Tipo_Movimiento = 'C' THEN monto_operacion ELSE 0 END  
   ,      'valor_compra'        = CASE WHEN Tipo_Movimiento = 'A' THEN monto_operacion ELSE 0 END  
   ,      'forma_pago'          = forma_pago  
   ,      'cantidad_cortes'     = 1  
   FROM   BacParamSuda..MDLBTR                  with (nolock)  
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO with (nolock) ON Codigo = forma_pago  
   WHERE  Sistema  = 'BFW'  
   AND    fecha_vencimiento = @Fecha_Hoy  
   AND   fecha_vencimiento    <> fecha  
   AND    Estado_envio         <> 'A'  
   AND    diasvalor             > 0  
   AND    forma_pago           <> 5  
 AND   numero_operacion NOT IN (SELECT operacion FROM #TMP_1) -- Omitir Oper. SADP  
  
   IF @@ERROR <> 0   
   BEGIN  
      PRINT 'Error Proceso de Actualización Reversa Lbtr.'  
      RETURN 1  
   END  
  
INSERT INTO BAC_CNT_CONTABILIZA  
  (  
    id_sistema,  
    tipo_movimiento,  
    tipo_operacion,  
    operacion,  
    correlativo,  
    codigo_instrumento,  
    moneda_instrumento,  
    valor_futuro,  
    valor_compra,  
    forma_pago,  
    cantidad_cortes  
  )  
SELECT * FROM #TMP_1  
  
   IF @@ERROR <> 0   
   BEGIN  
      PRINT 'Error Proceso de Actualización Reversa Lbtr.'  
      RETURN 1  
   END  
  
/************************************************************  
 * FIN Code para SADP  
************************************************************/  
  
  
   SET @Correla = 0  
  
   UPDATE BAC_CNT_CONTABILIZA  
   SET    Correlativo    = @Correla  
   ,      @Correla       = @Correla + 1  
   WHERE  Tipo_Operacion = 'RLB'  
   --> ( 4 ) Reversa Lbtr  
  
   --> ( 5 ) Devengamiento y Valorización  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      Valor_Compra  
   ,      Valor_Venta  
   ,      Valor_Hoy_Recompra  
   ,      Utilidad_Valorizacion  
   ,      Perdida_Valorizacion  
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida  
   ,      Utilidad  
   ,      Perdida  
   ,      UtilidadEFisica  
   ,      PerdidaEFisica  
   ,      Valor_Presente  
   ,      Valor_Usd  
   ,      Mx_Recompra  
   ,      cantidad_cortes  
   )  
   SELECT 'id_sistema'                        = 'BFW'  
   ,      'tipo_movimiento'                   = 'DEV'  
   ,      'tipo_operacion'                    = CASE WHEN c.cacodpos1 = 10 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                     WHEN c.cacodpos1 = 11 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                     ELSE                 'D' + LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                END  
   ,      'operacion'                         = c.canumoper  
   ,      'correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN c.cacodpos1 = 10 THEN c.cacodmon1  
                                                     ELSE                       c.cacodmon2   
                                                END  
   ,      'Moneda_Instrumento'                = CASE WHEN c.cacodpos1 = 2  THEN LTRIM(RTRIM(c.cacodmon1))   
                                                     WHEN c.cacodpos1 = 12 THEN LTRIM(RTRIM(c.cacodmon1))  
                                                     ELSE ''  
       END  
   ,      'forma_pago'                        = c.cafpagomn  
   ,      'Moneda_Compra (O)'                 = c.cacodmon1  
   ,      'Moneda_Venta  (C)'                 = c.cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = c.cacartera_normativa  
   ,      'SubCarteraNormativa'               = c.casubcartera_normativa  
   ,      'Valor_Compra_300'                  = CASE WHEN c.cacodmon1 = 998 THEN ISNULL(c.camtomon1 * @fValorUf_Hoy,  0.0)  
                                                     WHEN c.cacodmon1 = 997 THEN ISNULL(c.camtomon1 * @fValorIvp_Hoy, 0.0)  
                                                     WHEN c.cacodmon1 = 994 THEN ISNULL(c.camtomon1 * @fValorDo_Hoy,  0.0)  
                                                     ELSE c.camtomon1  
                                                END  
   ,      'Valor_Venta_301'                   = CASE WHEN c.cafecha   = @Fecha_Hoy AND (c.cacodmon1 = 998 or c.cacodmon2 = 998) THEN 0.0  
                                                     WHEN c.cafecvcto = @Fecha_Hoy                                              THEN 0.0  
                                                     ELSE ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0)   
                                                                                  FROM #VALOR_TC_CONTABLE  
                                                                                 WHERE vmfecha = @dAcfecproc and vmcodigo = c.cacodmon1), 0.0)  
                                                END  
   ,      'Valor_Hoy_Recompra_303'            = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL((c.camtomon1 + ISNULL(Ctf_Monto_Principal,0.0))* (SELECT ISNULL(vmvalor,0.0)   
                                                                                FROM #VALOR_TC_CONTABLE  
                                                                                WHERE vmfecha = @dAcfecante   
                 and vmcodigo = c.cacodmon1), 0.0)  
                                         END  
   ,      'Utilidad_Valorizacion_304'         = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
              ELSE ISNULL(CASE WHEN c.fres_obtenido >= 0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Perdida_Valorizacion_305'        = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN c.fres_obtenido <  0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Reversa_Valorizacion_Utilidad_306' = CASE WHEN c.cafecha = @Fecha_Hoy and c.caAntici <> 'a' THEN 0.0  
                                                     ELSE ISNULL(CASE WHEN r.fres_obtenido >= 0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Reversa_Valorizacion_Perdida_307'  = CASE WHEN c.cafecha = @Fecha_Hoy and c.caAntici <> 'a' THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN r.fres_obtenido <  0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Utilidad_309'                      = CASE WHEN c.catipmoda = 'C' AND c.camtocomp   >= 0 THEN ABS(c.camtocomp) ELSE 0.0 END  
   ,      'Perdida_308'                       = CASE WHEN c.catipmoda = 'C' AND c.camtocomp   <  0 THEN ABS(c.camtocomp) ELSE 0.0 END  
   ,      'UtilidadEFisica_905'               = CASE WHEN c.catipmoda = 'E' AND c.camtocomp   >= 0 THEN ABS(c.camtocomp) ELSE 0.0 END  
   ,      'PerdidaEFisica_906'                = CASE WHEN c.catipmoda = 'E' AND c.camtocomp   <  0 THEN ABS(c.camtocomp) ELSE 0.0 END  
   ,      'Valor_Presente_310'                = c.camtomon2  
   ,      'Valor_Usd_311'                     = CASE WHEN c.cafecha = @Fecha_Hoy AND (c.cacodmon1 = 998 or c.cacodmon2 = 998 ) -- 5522 Forward a Observado  
                                                         THEN 0.0  
                                                     WHEN c.cafecha = @Fecha_hoy and c.CaCodpos1 = 14  
                                                         THEN 0.0  
                                                     WHEN c.CaFechaStarting < @Fecha_hoy and c.CaCodPos1 = 14   
                                                         THEN 0.0  
                                                     ELSE c.camtomon2 * (SELECT ISNULL(vmvalor,0.0)  
                                                                           FROM #VALOR_TC_CONTABLE  
                                                                          WHERE vmfecha = @dAcfecproc and vmcodigo = c.cacodmon2)  
                                                END  
   ,      'Mx_Recompra_312'                   = CASE WHEN c.cafecha   = @Fecha_Hoy                                             -- 5522 Forward a Observado  
                                                          THEN 0.0   
                                                     WHEN c.CaFechaStarting < @Fecha_Hoy and c.CaCodPos1 = 14  
                                                          THEN 0.0  
                                                     ELSE   
                                                          Case when c.CaCodpos1 = 14 then r.CaMtoMon2 else  c.camtomon2 end                        -- 5522 Forward a Observado  
                                                                     * (SELECT ISNULL(vmvalor,0.0)  
                                                                           FROM #VALOR_TC_CONTABLE  
                                                                          WHERE vmfecha = @dAcfecante and vmcodigo = c.cacodmon2)  
                                                END  
   ,      'cantidad_cortes'                   = 1  
   FROM   MFCA                              c  with (nolock)  
          LEFT JOIN BacParamSuda..CLIENTE      with (nolock) ON clrut            = c.cacodigo  AND clcodigo    = c.cacodcli  
          LEFT JOIN BacFwdSuda..MFCARES     R  with (nolock) ON r.cafechaproceso = @dAcfecante AND c.canumoper = r.canumoper  
    LEFT JOIN BacFwdSuda..TBL_CARTERA_FLUJOS F with (nolock) ON f.Ctf_Numero_OPeracion = c.canumoper and f.Ctf_Fecha_Vencimiento = @Fecha_Hoy  
   WHERE  c.caestado                        = ''  
      AND NOT (c.caantici                   = 'A'   
      AND c.canumoper                      <> c.numerocontratocliente)  
   -- MAP02 20070813 Se descartan de este evento las 'Operaciones Anticipo'  
   -- Los anticipos totales deben reversar su VR como siempre  

   IF @@ERROR <> 0  
   BEGIN  
      PRINT 'Error Proceso de Actualización Registro de Devengamiento para Seguros de Cambio.'  
      RETURN 1  
   END  
   --> ( 5 ) Devengamiento y Valorización  
  
   --> ( 9 ) Vencimiento  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      Valor_Compra  
   ,      Valor_Venta  
   ,      Valor_Hoy_Recompra  
   ,      Utilidad_Valorizacion  
   ,      Perdida_Valorizacion  
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida  
   ,      Utilidad  
   ,      Perdida  
   ,      UtilidadEFisica  
   ,      PerdidaEFisica  
   ,      Valor_Presente  
   ,      Valor_Usd  
   ,      Mx_Recompra  
   ,      Acumulado_Utili_Corte  
   ,      Tipo_Opcion  
   ,      cantidad_cortes  
   ,   Moneda_FPago  
   )  
   SELECT 'id_sistema'                        = 'BFW'  
   ,      'tipo_movimiento'                   = CASE WHEN c.cacodpos1 = 10							THEN 'VCT'  
													 WHEN c.cacodpos1 = 11							THEN 'VCT'  
                                                     WHEN c.cacodpos1 = 2 AND c.catipmoda = 'C'		THEN 'VCT'  
                                                     WHEN c.cacodpos1 = 2 AND c.catipmoda = 'E'		THEN 'MOV'  
													 WHEN c.cacodpos1 = 1 AND c.var_moneda2 <> 0	THEN 'VCT'							--- PRD 18033
                                                     ELSE												 'MOV'  
                                                END  
   ,      'tipo_operacion'                    = CASE WHEN c.cacodpos1 = 10 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                     WHEN c.cacodpos1 = 11 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
													 WHEN c.cacodpos1 = 1 AND c.var_moneda2 <> 0  THEN 'V'+'2'+LTRIM(RTRIM(c.catipoper))---PRD 18033
                                                     ELSE                 'V' + LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                END  
   ,      'operacion'                         = c.canumoper  
   ,      'correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN c.cacodpos1 = 10 THEN c.cacodmon1  
													 WHEN c.cacodpos1 = 1 AND c.var_moneda2 <> 0  THEN c.cacodmon1						---PRD 18033
                                                     ELSE                       c.cacodmon2  
                                                END  
   ,      'Moneda_Instrumento'                = CASE WHEN c.cacodpos1 = 2  THEN LTRIM(RTRIM(c.cacodmon1))   
                                                     WHEN c.cacodpos1 = 12 THEN LTRIM(RTRIM(c.cacodmon1))  
													 WHEN c.cacodpos1 = 1 AND c.var_moneda2 <> 0  THEN LTRIM(RTRIM(c.cacodmon2))		---PRD 18033
                                                     ELSE ''
                                                END  
   ,      'forma_pago'                        = c.cafpagomn  
   ,      'Moneda_Compra (O)'                 = c.cacodmon1  
   ,      'Moneda_Venta  (C)'                 = c.cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = c.cacartera_normativa  
   ,      'SubCarteraNormativa'               = c.casubcartera_normativa  
   ,      'Valor_Compra_300'                  = CASE WHEN c.cacodmon1 = 998  THEN ISNULL(c.camtomon1 * @fValorUf_Hoy,  0.0)  
													 WHEN c.cacodmon1 = 997  THEN ISNULL(c.camtomon1 * @fValorIvp_Hoy, 0.0)  
                                                     WHEN c.cacodmon1 = 994  THEN ISNULL(c.camtomon1 * @fValorDo_Hoy,  0.0)  
                                                     ELSE c.camtomon1  
												END  
   ,      'Valor_Venta_301'                   = CASE WHEN c.cacodpos1 = 1 THEN ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_MONEDA  WHERE vmfecha  = c.cafecha   
												AND vmcodigo = CASE WHEN c.cacodmon1 = 13 THEN 994 ELSE c.cacodmon1 END), 0.0)  
                                                     ELSE                      ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha  = @dAcfecproc AND vmcodigo = c.cacodmon1), 0.0 )  
                                                END  
   ,      'Valor_Hoy_Recompra_303'            = CASE WHEN c.cafecha   = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0)  
                                                                                  FROM #VALOR_TC_CONTABLE  
                                                                                 WHERE vmfecha = @dAcfecante AND vmcodigo = c.cacodmon1), 0.0 )  
                                                END  
   ,      'Utilidad_Valorizacion_304'         = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN c.fres_obtenido >= 0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Perdida_Valorizacion_305'          = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN c.fres_obtenido <  0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Reversa_Valorizacion_Utilidad_306' = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0  
                                                     ELSE ISNULL(CASE WHEN r.fres_obtenido >= 0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Reversa_Valorizacion_Perdida_307'  = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN r.fres_obtenido <  0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Utilidad_309'                      = CASE WHEN clpais  = 6 and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp)  
                                                     WHEN clpais <> 6 and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy  
                                                     ELSE 0.0  
            END  
            /*  
            CASE WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 0   and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp)   
              WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 999 and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp)   
              WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 13  and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp) --> / isnull(@fValorDo_Hoy, 1.0)   
              WHEN clpais   = 6        and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp)   
              WHEN clpais  <> 6        and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy   
                                                     ELSE 0.0  
            END  
            */   
            /*  
            CASE WHEN clpais  = 6 and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp)  
                                                     WHEN clpais <> 6 and c.catipmoda = 'C' AND c.camtocomp >= 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy  
                                                     ELSE 0.0  
            END  
            */  
              
   ,      'Perdida_308'                       = CASE WHEN clpais =  6 and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp)     
                                         WHEN clpais <> 6 and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy  
              ELSE 0.0   
            END  
            /*  
            CASE WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 0   and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp)  
              WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 999 and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp)  
              WHEN c.cacodpos1 = 1 AND c.cacalcmpdol = 13  and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp) --> / isnull(@fValorDo_Hoy, 1.0)  
              WHEN clpais   = 6        and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp)  
              WHEN clpais  <> 6        and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy  
                                                     ELSE 0.0  
            END  
            */  
               /*  
            CASE WHEN clpais =  6 and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp)     
                                                     WHEN clpais <> 6 and c.catipmoda = 'C' AND c.camtocomp  < 0 THEN ABS(c.camtocomp) * @fValorDo_Hoy  
                                                     ELSE 0.0   
            END  
            */  
   ,      'UtilidadEFisica_905'               = 0.0  
   ,      'PerdidaEFisica_906'                = 0.0  
   ,      'Valor_Presente_310'                = c.camtomon2  
   ,      'Valor_Usd_311'                     = c.camtomon2 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = c.cacodmon2)  
   ,      'Mx_Recompra_312'                   = CASE WHEN c.cafecha   = @Fecha_Hoy THEN 0.0   
                                                     ELSE c.camtomon2 * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecante and vmcodigo = c.cacodmon2)  
                                                END  
   ,      'Acumulado_Utili_Corte'             = CASE WHEN c.cacodpos1 = 2 AND c.catipmoda = 'E' AND mnrrda = 'M' and c.catipoper = 'C' THEN ROUND( (((uno.vmvalor / dos.vmvalor) -      c.catipcam)  * c.camtomon1) * dos.vmvalor,0)  
                                                     WHEN c.cacodpos1 = 2 AND c.catipmoda = 'E' AND mnrrda = 'D' and c.catipoper = 'C' THEN ROUND( (((uno.vmvalor / dos.vmvalor) - (1.0/c.catipcam)) * c.camtomon1) * dos.vmvalor,0)  
                                                     WHEN c.cacodpos1 = 2 AND c.catipmoda = 'E' AND mnrrda = 'M' and c.catipoper = 'V' THEN ROUND(((((uno.vmvalor / dos.vmvalor) -      c.catipcam)  * c.camtomon1) * dos.vmvalor) * -1 ,0)  
                                                     WHEN c.cacodpos1 = 2 AND c.catipmoda = 'E' AND mnrrda = 'D' and c.catipoper = 'V' THEN ROUND(((((uno.vmvalor / dos.vmvalor) - (1.0/c.catipcam)) * c.camtomon1) * dos.vmvalor) * -1 ,0)  
                                                     WHEN                     c.catipmoda = 'E'                                        THEN c.camtocomp  
                                                     ELSE                                                                                   0.0  
                                                END  
   ,      'Tipo_Opcion'                       = '*'  
   ,      'cantidad_cortes'                   = 1  
   ,   'Moneda_FPago'       = CONVERT(NUMERIC(3), ISNULL( mfp.tbcodigo1,0) )  
   FROM   MFCA              c with (nolock)  
          LEFT JOIN BacParamSuda..CLIENTE      with (nolock) ON c.cacodigo   = clrut   AND c.cacodcli = clcodigo  
          LEFT JOIN BacParamSuda..MONEDA      with (nolock) ON c.cacodmon1  = mncodmon  
          LEFT JOIN #VALOR_TC_CONTABLE      uno with (nolock) ON uno.vmfecha  = @fecha_hoy AND uno.vmcodigo = c.cacodmon1  
          LEFT JOIN #VALOR_TC_CONTABLE      dos with (nolock) ON dos.vmfecha  = @fecha_hoy AND dos.vmcodigo = 994  
          LEFT JOIN BacFwdSuda..MFCARES      R   with (nolock) ON r.cafechaproceso = @dAcfecante AND c.canumoper  = r.canumoper  
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  mfp with (nolock) ON mfp.tbcateg  = 9008   
                    and mfp.tbtasa   = case when c.cacalcmpdol <> 0        then c.cacalcmpdol  
                             when c.cacalcmpdol  = 0 AND c.cacodpos1 = 1 then 999  
                             when c.cacalcmpdol  = 0 AND c.cacodpos1 = 2 then 13  
                             else c.cacodmon2  
                              end  
                    and mfp.tbvalor  = c.cafpagomn  
   WHERE  c.cafecvcto                      <= @fecha_hoy  
   AND    c.caestado                          = ''  
   AND    c.caantici            <> 'A'         -- MAP03 20070813 Descartará las 'Operaciones Anticipo' y los 'Anticipos Totales'  
 
   -->    Genera Vcto de Flujo Seguro Inflacion Hipotecario  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      valor_usd  
   ,      Valor_Inicial_MN_Recompra  
   ,      Utilidad  
   ,      Perdida  
   ,      cantidad_cortes  
   )  
   SELECT 'id_sistema'                        = 'BFW'  
   ,      'tipo_movimiento'                   = 'CAP'  
   ,      'tipo_operacion'                    = 'C' + LTRIM(RTRIM(car.cacodpos1)) + LTRIM(RTRIM(car.catipoper))  
   ,      'operacion'                     = car.canumoper  
   , 'correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = car.cacodmon2   
   ,      'Moneda_Instrumento'                = ''  
   ,      'forma_pago'                        = car.cafpagomn  
   ,      'Moneda_Compra (O)'                 = car.cacodmon1  
   ,      'Moneda_Venta  (C)'                 = car.cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = car.cacartera_normativa  
   ,      'SubCarteraNormativa'               = car.casubcartera_normativa  
  
   ,      'Valor_Usd_311'                     = Ctf_Monto_Principal  *  (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = CASE WHEN car.cacodmon1 = 13 THEN 13 ELSE car.cacodmon1 END)  
   ,      'Valor_Inicial_MN_Recompra_923'     = Ctf_Monto_Principal  *  (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecante and vmcodigo = CASE WHEN res.cacodmon1 = 13 THEN 13 ELSE res.cacodmon1 END)  
  
   ,      'Utilidad_309'                      = CASE WHEN car.catipoper = 'C'  
        THEN CASE WHEN (ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0) - Ctf_Monto_Secundario) > 0   
          THEN ABS((ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0)- Ctf_Monto_Secundario))  
          ELSE 0.0 END  
       WHEN car.catipoper = 'V'  
        THEN CASE WHEN (Ctf_Monto_Secundario - ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0) ) > 0   
          THEN ABS(( Ctf_Monto_Secundario - ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0)))  
          ELSE 0.0 END  
      END  
/*      CASE WHEN cli.clpais  = 6 and car.catipmoda = 'C' AND car.camtocomp >= 0 THEN ABS(car.camtocomp)  
                                                     WHEN cli.clpais <> 6 and car.catipmoda = 'C' AND car.camtocomp >= 0 THEN ABS(car.camtocomp) * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = 994)  
                                                     ELSE 0.0  
                                                END  
*/  
   ,      'Perdida_308'     = CASE WHEN car.catipoper = 'C'  
        THEN CASE WHEN (ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0) - Ctf_Monto_Secundario) < 0   
          THEN ABS((ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0)- Ctf_Monto_Secundario))  
          ELSE 0.0 END  
       WHEN car.catipoper = 'V'  
        THEN CASE WHEN (Ctf_Monto_Secundario - ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0) ) < 0   
          THEN ABS(( Ctf_Monto_Secundario - ROUND(Ctf_Monto_Principal * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = car.cacodmon1 ),0)))  
          ELSE 0.0 END  
      END  
/*      CASE WHEN cli.clpais =  6 and car.catipmoda = 'C' AND car.camtocomp  < 0 THEN ABS(car.camtocomp)     
                                                     WHEN cli.clpais <> 6 and car.catipmoda = 'C' AND car.camtocomp  < 0 THEN ABS(car.camtocomp) * (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc and vmcodigo = 994)  
                                                     ELSE 0.0   
                                                END  
*/  
   ,      'cantidad_cortes'                   = 1  
   FROM   BacFwdSuda..MFCA                 car WITH (NOLOCK)  
    INNER JOIN BacFwdSuda..MFCARES   res WITH (NOLOCK) ON res.cafechaproceso = @dAcfecante AND res.canumoper = car.canumoper  
          INNER JOIN BacParamSuda..CLIENTE cli WITH (NOLOCK) ON cli.clrut = car.cacodigo AND cli.clcodigo = car.cacodcli   
   INNER JOIN BACFWDSUDA..TBL_CARTERA_FLUJOS ON Ctf_Numero_OPeracion = car.canumoper AND  Ctf_Fecha_Vencimiento = @Fecha_Hoy  
   WHERE  car.cacodpos1                       = 13  
  
  
--     AND  flu.ctf_fecha_vencimiento           = @fecha_hoy  
   -->    Genera Vcto de Flujo Seguro Inflacion Hipotecario  
  
   UPDATE BAC_CNT_CONTABILIZA  
   SET    UtilidadEFisica  = CASE WHEN Acumulado_Utili_Corte >= 0.0 THEN ABS(Acumulado_Utili_Corte) ELSE 0.0 END  
   ,      PerdidaEFisica   = CASE WHEN Acumulado_Utili_Corte  < 0.0 THEN ABS(Acumulado_Utili_Corte) ELSE 0.0 END  
   WHERE  Tipo_Opcion      = '*'  
  
   IF @@ERROR <> 0  
   BEGIN  
      PRINT 'Error Proceso de Actualización Registro de Vencimiento para Seguros de Inflación.'  
      RETURN 1  
   END  
   --> ( 10 ) Vencimiento  
  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema                   , tipo_movimiento , tipo_operacion , operacion          , correlativo           , codigo_instrumento  
   ,      moneda_instrumento           , forma_pago      , Moneda_Compra  , Moneda_Venta       , tipo_cliente          , CarteraNormativa       
   ,      SubCarteraNormativa          , Valor_Compra    , Valor_Venta    , Valor_Hoy_Recompra , Utilidad_Valorizacion , Perdida_Valorizacion   
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida , Utilidad        , Perdida        , UtilidadEFisica    , PerdidaEFisica        , Valor_Presente   
   ,      Valor_Usd                    , Mx_Recompra     , cantidad_cortes  
   )  
   SELECT 'Id_Sistema'                        = 'BFW'  
   ,      'Tipo_Movimiento'                   = 'MOV'  
   ,      'Tipo_Operacion'                    = LTRIM(RTRIM(cacodpos1)) + LTRIM(RTRIM(catipoper))  
   ,      'Operacion'                         = canumoper  
   ,      'Correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN cacodpos1 = 10 THEN cacodmon1  
                                                     ELSE                     cacodmon2  
                                                END  
   ,      'Moneda_Instrumento'                = CASE WHEN cacodpos1 = 2  THEN LTRIM(RTRIM(cacodmon1))  
                                                     WHEN cacodpos1 = 12 THEN LTRIM(RTRIM(cacodmon1))  
                                                     ELSE ''  
                                                END  
   ,      'forma_pago'                        = cafpagomn  
   ,      'Moneda_Compra (O)'                 = cacodmon1  
   ,      'Moneda_Venta  (C)'                 = cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = cacartera_normativa  
   ,      'SubCarteraNormativa'               = casubcartera_normativa  
,      'Valor_Compra_300'      = CASE WHEN cacodmon1 = 998  THEN ISNULL(camtomon1 * @fValorUf_Hoy,  0.0)  
                                                     WHEN cacodmon1 = 997  THEN ISNULL(camtomon1 * @fValorIvp_Hoy, 0.0)  
              WHEN cacodmon1 = 994  THEN ISNULL(camtomon1 * @fValorDo_Hoy,  0.0)  
                                                     ELSE camtomon1  
                                                END  
   ,      'Valor_Venta_301'                   = ISNULL(camtomon1 * (SELECT ISNULL(vmvalor,0.0)  
                                                                      FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK)  
                                                                     WHERE vmfecha = cafecha   
                                                                       AND vmcodigo = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END), 0.0 )  
   ,      'Valor_Hoy_Recompra_303'            = 0  
   ,      'Utilidad_Valorizacion_304'         = ISNULL(CASE WHEN fres_obtenido >= 0 THEN ABS(ROUND(fres_obtenido,0)) ELSE 0.0 END,0.0)  
   ,      'Perdida_Valorizacion_305'          = ISNULL(CASE WHEN fres_obtenido <  0 THEN ABS(ROUND(fres_obtenido,0)) ELSE 0.0 END,0.0)  
   ,      'Reversa_Valorizacion_Utilidad_306' = 0  
   ,      'Reversa_Valorizacion_Perdida_307'  = 0  
   ,      'Utilidad_309'                      = CASE WHEN catipmoda = 'C' AND camtocomp >= 0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'Perdida_308'                       = CASE WHEN catipmoda = 'C' AND camtocomp  < 0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'UtilidadEFisica_905'               = CASE WHEN catipmoda = 'E' AND camtocomp >= 0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'PerdidaEFisica_906'                = CASE WHEN catipmoda = 'E' AND camtocomp <  0 THEN ABS(camtocomp) ELSE 0.0 END  
   ,      'Valor_Presente_310'                = camtomon2  
   ,      'Valor_Usd_311'                     = CASE WHEN cacodmon2 = 999 THEN camtomon2  
                                                     ELSE camtomon2 * (SELECT ISNULL(vmvalor,0.0)  
                                                                         FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK)  
                                                                        WHERE vmfecha = cafecha  
                                                                          AND vmcodigo = CASE WHEN cacodmon2 = 13 THEN 994 ELSE cacodmon2 END)  
                                                END  
   ,      'Mx_Recompra_312'                   = 0.0  
   ,      'cantidad_cortes'                   = 2  
   FROM   MFCA        with (nolock)   
          LEFT JOIN BacParamSuda..CLIENTE   with (nolock) ON cacodigo = clrut   AND cacodcli = clcodigo  
   WHERE  cafecha               < @Fecha_Hoy  
   AND    cafecvcto             > @Fecha_Hoy  
   AND    caestado              = ''  
   --> ( XxxxxX ) -- Para Interfaz Balance Operacion --  
  
   --- MAP04 Se agrega evento para contabilizar Capital y VR de Op. Original   
   --> ( 20 ) Contabilizacion Capitales y VR   
 INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      Valor_Compra  
   ,      Valor_Venta  
   ,      Valor_Hoy_Recompra  
   ,      Utilidad_Valorizacion  
   ,   Perdida_Valorizacion  
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida  
   ,      Utilidad  
   ,      Perdida  
   ,      UtilidadEFisica  
   ,      PerdidaEFisica  
   ,      Valor_Presente  
   ,      Valor_Usd  
   ,      Mx_Recompra  
   ,      cantidad_cortes  
   )  
   SELECT 'id_sistema'                        = 'BFW'  
   ,      'tipo_movimiento'                   = 'ANT'  
   ,      'tipo_operacion'                    = CASE WHEN c.cacodpos1 = 10 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                     WHEN c.cacodpos1 = 11 THEN LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
                                                     ELSE                       LTRIM(RTRIM(c.cacodpos1)) + LTRIM(RTRIM(c.catipoper))  
            END  
   ,      'operacion'                         = c.numerocontratocliente  
   ,      'correlativo'                       = 1  
   ,      'Codigo_Instrumento'                = CASE WHEN c.cacodpos1 = 10 THEN c.cacodmon1  
                                                     ELSE                       c.cacodmon2  
                                                END  
   ,      'Moneda_Instrumento'                = CASE WHEN c.cacodpos1 = 2  THEN LTRIM(RTRIM(c.cacodmon1))   
                                                     WHEN c.cacodpos1 = 12 THEN LTRIM(RTRIM(c.cacodmon1))  
                       ELSE ''  
                                                END  
   ,      'forma_pago'                        = c.cafpagomn  
   ,      'Moneda_Compra (O)'                 = c.cacodmon1  
   ,      'Moneda_Venta  (C)'                 = c.cacodmon2  
   ,      'tipo_cliente'                      = CASE WHEN clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'                  = c.cacartera_normativa  
   ,      'SubCarteraNormativa'               = c.casubcartera_normativa  
   ,      'Valor_Compra_300'                  = CASE WHEN c.cacodmon1 = 998 THEN ISNULL(c.camtomon1 * @fValorUf_Hoy,  0.0)  
                                                     WHEN c.cacodmon1 = 997 THEN ISNULL(c.camtomon1 * @fValorIvp_Hoy, 0.0)  
                                                     WHEN c.cacodmon1 = 994 THEN ISNULL(c.camtomon1 * @fValorDo_Hoy,  0.0)  
                                                     ELSE c.camtomon1  
                                                END  
   ,      'Valor_Venta_301'                   = CASE WHEN c.cafecha   = @Fecha_Hoy AND (c.cacodmon1 = 998 or c.cacodmon2 = 998) THEN 0.0  
                                                     WHEN c.cafecvcto = @Fecha_Hoy                                              THEN 0.0  
                                                     ELSE ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0)  
                                                                                  FROM #VALOR_TC_CONTABLE  
                                                                                  WHERE vmfecha = @dAcfecproc  
                                                                                    AND vmcodigo = c.cacodmon1), 0.0)  
                                                END  
   ,      'Valor_Hoy_Recompra_303'            = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0   
              ELSE ISNULL(c.camtomon1 * (SELECT ISNULL(vmvalor,0.0)  
                                                                                  FROM #VALOR_TC_CONTABLE  
                                                                                 WHERE vmfecha = @dAcfecante  
                                                                                   AND vmcodigo = c.cacodmon1), 0.0)  
                                                END  
   ,      'Utilidad_Valorizacion_304'         = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN c.fres_obtenido >= 0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Perdida_Valorizacion_305'          = CASE WHEN c.cafecvcto = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN c.fres_obtenido <  0 THEN ABS(ROUND(c.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                               END  
   ,      'Reversa_Valorizacion_Utilidad_306' = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0   
                        ELSE ISNULL(CASE WHEN r.fres_obtenido >= 0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Reversa_Valorizacion_Perdida_307'  = CASE WHEN c.cafecha = @Fecha_Hoy THEN 0.0   
                                                     ELSE ISNULL(CASE WHEN r.fres_obtenido <  0 THEN ABS(ROUND(r.fres_obtenido,0)) ELSE 0.0 END,0.0)  
                                                END  
   ,      'Utilidad_309'                      = ROUND(CASE WHEN c.caantmtomdacomp >= 0 THEN ABS(c.caantmtomdacomp) ELSE 0.0 END    
                                              * ISNULL( (SELECT vmvalor  
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK)   
                                                          WHERE vmcodigo = CASE WHEN c.moneda_compensacion = 13 THEN 994 ELSE c.moneda_compensacion END  
                                                            AND vmfecha  = @Fecha_Hoy) , 1.0), 0)   
  
   ,      'Perdida_308'                       = ROUND( CASE WHEN c.caantmtomdacomp  < 0 THEN ABS(c.caantmtomdacomp) ELSE 0.0 END   
                                              * ISNULL( (SELECT vmvalor  
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK)   
                                                          WHERE vmcodigo = CASE WHEN c.moneda_compensacion = 13 THEN 994 ELSE c.moneda_compensacion END  
                                                            AND vmfecha  = @Fecha_Hoy) , 1.0), 0)  
   ,      'UtilidadEFisica_905'               = CASE WHEN c.catipmoda = 'E' AND c.cavaLPRE   >= 0 THEN ABS(c.cavaLPRE) ELSE 0.0 END  
   ,      'PerdidaEFisica_906'                = CASE WHEN c.catipmoda = 'E' AND c.cavaLPRE<  0 THEN ABS(c.cavaLPRE) ELSE 0.0 END  
   ,      'Valor_Presente_310'                = c.camtomon2  
   ,      'Valor_Usd_311'                     = CASE WHEN c.cafecha = @Fecha_Hoy AND (c.cacodmon1 = 998 or c.cacodmon2 = 998) THEN 0.0  
                                                     ELSE c.camtomon2 * (SELECT ISNULL(vmvalor,0.0)  
                                                                           FROM #VALOR_TC_CONTABLE  
                                                                          WHERE vmfecha = @dAcfecproc  
                   AND vmcodigo = c.cacodmon2)  
                                                END  
   ,      'Mx_Recompra_312'                   = CASE WHEN c.cafecha   = @Fecha_Hoy THEN 0.0   
												ELSE c.camtomon2 * (	SELECT ISNULL(vmvalor,0.0)  
																		FROM #VALOR_TC_CONTABLE  
																		WHERE vmfecha = @dAcfecante  
																		AND vmcodigo = c.cacodmon2)  
												END  
   ,      'cantidad_cortes'                   = 1  
   FROM   MFCA   c with (nolock)  
          LEFT JOIN BacParamSuda..CLIENTE     with (nolock) ON clrut            = c.cacodigo  AND clcodigo    = c.cacodcli  
          LEFT JOIN BacFwdSuda..MFCARES     r with (nolock) ON r.cafechaproceso = @dAcfecante AND r.canumoper = c.canumoper  
   WHERE  c.caestado                          = ''  
   AND    c.caantici       = 'A'   
  
       
   IF @@ERROR <> 0  
   BEGIN  
      PRINT 'Error Proceso de Actualización Registro de Movimiento Anticipo.'  
      RETURN 1  
  END  
   --> ( 5 ) Devengamiento y Valorización  
   --> MAP04 Fin  
  
    -- MAP05  
   --> (14) Liquidación Anticipo.  
   -->      Se elimina Tipo_Movmiento LIA, la compensacion estará siempre en CLP , concepto s308 y 309 siempre en CLP.  
  
   UPDATE BAC_CNT_CONTABILIZA  
   SET    UtilidadEFisica  = CASE WHEN Acumulado_Utili_Corte >= 0.0 THEN ABS(Acumulado_Utili_Corte) ELSE 0.0 END  
   ,      PerdidaEFisica   = CASE WHEN Acumulado_Utili_Corte  < 0.0 THEN ABS(Acumulado_Utili_Corte) ELSE 0.0 END  
   WHERE  Tipo_Opcion      = '*'  
  
   IF @@ERROR <> 0  
   BEGIN  
      PRINT 'Error Proceso de Actualización Liquidacion de Anticipos.'  
      RETURN 1  
   END  
   --> ( 15 ) Liquidacion Anticipo  
   -- MAP05  
  
   --> ( *** ) Proceso de Actualización del Codigo de Cartera Para Derivados Forward  
   CREATE TABLE #Llena_Codigo_Paso  
   (   MiSistema       CHAR(3)    NOT NULL DEFAULT('')  
   ,   MiContraparte   INTEGER    NOT NULL DEFAULT(0)  
   ,   MiCartera       CHAR(5)    NOT NULL DEFAULT('')  
   ,   MiSubCartera    NUMERIC(9) NOT NULL DEFAULT(0)  
   ,   MiCodCartera    NUMERIC(9) NOT NULL DEFAULT(0)  
       CONSTRAINT [Primary_llenacodigopaso] PRIMARY KEY NONCLUSTERED  
       (   [MiSistema], [MiContraparte], [MiCartera], [MiSubCartera], [MiCodCartera]   )  
   )  
  
   INSERT INTO #Llena_Codigo_Paso  
   SELECT id_sistema            as MiSistema  
   ,      tipo_cliente          as MiContraparte  
   ,      CarteraNormativa      as MiCartera  
 ,      SubCarteraNormativa   as MiSubCartera  
   ,      0                     as MiCodCartera  
   FROM   BacFwdSuda..BAC_CNT_CONTABILIZA with (nolock)  
   GROUP BY id_sistema   
   ,        tipo_cliente   
   ,        CarteraNormativa   
   ,        SubCarteraNormativa  
  
   UPDATE #Llena_Codigo_Paso  
   SET    MiCodCartera        = CodigoCartera   
   FROM   BacParamSuda..TBL_CLASIFICACION_CARTERA_INSTRUMENTO  
   WHERE  id_Sistema          = MiSistema  
   AND    Contraparte         = MiContraparte  
   AND    CarteraNormativa    = MiCartera  
   AND    SubcarteraNormativa = MiSubCartera  
  
   UPDATE BacFwdSuda..BAC_CNT_CONTABILIZA  
   SET    cntClasificacionCartera = MiCodCartera  
   FROM   #Llena_Codigo_Paso  
   WHERE  id_sistema              = MiSistema  
   AND    tipo_cliente            = MiContraparte  
   AND    CarteraNormativa        = MiCartera  
   AND    SubCarteraNormativa     = MiSubCartera  
  
  
   DROP TABLE #Llena_Codigo_Paso  
   --> ( *** ) Proceso de Actualización del Codigo de Cartera Para Derivados Forward  
  
   RETURN 0  
  
END

GO

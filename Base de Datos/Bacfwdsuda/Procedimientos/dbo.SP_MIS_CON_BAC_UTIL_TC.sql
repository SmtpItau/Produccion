USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MIS_CON_BAC_UTIL_TC]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MIS_CON_BAC_UTIL_TC]
AS          
BEGIN          

/*	-->			Adrian

                SET NOCOUNT ON          
          
                DECLARE          @Fecha_Proceso         CHAR(10)          
                               , @PrimerDiaMes          CHAR(10)          
                               , @UltimoDiaMes          CHAR(10)          
                               , @Dias                 CHAR(10)          
                               , @dFechaGenera          DATETIME          
          
                /*SET @dFechaGenera     = (          SELECT  convert(char(08),acfecproc,112)        
                                                   FROM BacfwdSuda.dbo.MFAC with(nolock) )*/        
        
    /* SET @dFechaGenera = (SELECT Fecha = CASE WHEN acsw_pd = 1 THEN convert(char(08),acfecproc,112)        
             ELSE convert(char(08),acfecprox,112) END        
                                                   FROM BacfwdSuda.dbo.MFAC with(nolock) )    */      
          
                SET @dFechaGenera = GETDATE()      
      
                SET @Fecha_Proceso     = CONVERT(CHAR(8),DATEADD(month,-1,@dFechaGenera),112)--CONVERT(CHAR(8),DATEADD(month,-1,'20100615'),112)           
                SET @PrimerDiaMes      = ''          
                SET @UltimoDiaMes      = ''          
                SET @PrimerDiaMes      =  SUBSTRING(@Fecha_Proceso,1,6) + '01'          
                SET @UltimoDiaMes      = CONVERT(CHAR(10),DATEADD(day,-1,DATEADD(month,1,@PrimerDiaMes)),112)          
          
          
                IF exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[MIS_CON_BAC_UTIL_TC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)          
                BEGIN          
                               drop table [dbo].[MIS_CON_BAC_UTIL_TC]          
                END          
          
                CREATE TABLE [dbo].[MIS_CON_BAC_UTIL_TC] (          
                               MES_CONTABLE                                     NUMERIC(6,0) ,          
                               SOURCE_ID                                        CHAR(14),          
                               OPERACION                                       CHAR(20),          
                               PRODUCT_ID                                     CHAR(16),          
                               ISO_COUNTRY                                  CHAR(3),          
                               EMPRESA_ID                                     CHAR(3),          
                               BRANCH_CD                                      CHAR(3),          
                               CLIENTE_ID                                       CHAR(12),          
                               FULL_NAME                                      CHAR(80),          
                               FAMILIA                                          CHAR(4),          
                               PRODUCT_TYPE_CD                                CHAR(4),          
                               FECHA_CONTABLE                                  CHAR(8),          
                               FECHA_INTERFAZ                                   CHAR(8),          
                               FECHA_APERTURA_OPERAC                      CHAR(8),          
                               FECHA_INICIO                                  CHAR(8),          
                               FECHA_VCMTO                                      CHAR(8),          
                               FECHA_RENOVACION                    CHAR(8),          
                               FECHA_PROX_CAMBIO_TASA                    CHAR(8),          
                               ISO_CURRENCY_CD                                  CHAR(3),          
                               TIPO_MONEDA                                      CHAR(1),          
                               TIPO_OPERACION                                   CHAR(1),          
                               PERIODICIDAD_DE_FLUJOS                 CHAR(5),          
                               IND_TASA_TRANSFERENCIA        CHAR(2),     
                               NRO_CUOTAS_FLUJO_SWAP                     CHAR(5),          
                           TASA_INTERES                                  NUMERIC(18,8),          
                               TASA_TIPO_PARIDAD               NUMERIC(18,5),          
                               CAP_MONE_ORIGEN                                  NUMERIC(18,2),          
                               CAP_MONE_LOCAL                                   NUMERIC(18,2),          
                               MONTO_UTIL_ORIGEN                                NUMERIC(18,5),          
                               MONTO_UTIL_LOCAL                NUMERIC(18,5))          
          
                /***************************************************FORWARD*************************************************/          
                /***********************************************************************************************************/          
                --TABLA MFMOH          
               
                              INSERT INTO MIS_CON_BAC_UTIL_TC          
                               SELECT  CONVERT(CHAR(6),mvto.mofecha,112)                                                              ,-- MES_CONTABLE          
                                               'MI59'                                                                                          ,-- SOURCE_ID Preguntar que se debe ingresar.... de donde saco esta info.          
                                               LTRIM(RTRIM(mvto.monumoper))                                                                    ,-- N° de Op.          
                                               'MD10'                                                                                          ,-- PRODUCT_ID  Preguntar que se debe ingresar.... de donde saco esta info.          
                                               'CL'                                                                                            ,-- ISO_COUNTRY          
                                               '001'                                                                                           ,-- EMPRESA_ID          
                                               '001'                                                                                           , -- BRANCH_CD          
                                               LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))                            , -- + SPACE(12 - LEN(LTRIM(RTRIM(clie.Clrut + clie.Cldv)))) ,                      
                                               LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))                      , -- FULL_NAME          
                                               'MDIR'                                                                                           , -- FAMILIA  Preguntar que se debe ingresar.... de donde saco esta info.          
                                               'FWD'                                                                                           , -- PRODUCT_TYPE_CD          
                                               CONVERT(CHAR(8), mvto.mofecha, 112)                                                             , -- FECHA_CONTABLE           
                                               CONVERT(CHAR(8), mvto.mofecha, 112)                                                             , -- FECHA_INTERFAZ          
                                               CONVERT(CHAR(8), mvto.mofecha, 112)                                                             , -- FECHA_APERTURA_OPERAC          
CONVERT(CHAR(8), mvto.mofecha, 112)                                                             , -- FECHA_INICIO          
          CONVERT(CHAR(8), mvto.mofecvcto, 112)                                                           , -- FECHA_VCMTO          
                              SPACE(0)                                                                                        , -- FECHA_RENOVACION       Preguntar que se debe ingresar.... de donde saco esta info.          
                                               CONVERT(CHAR(8),mvto.moFecEfectiva,112)                                                         , -- FECHA_PROX_CAMBIO_TASA           
                                               LTRIM(RTRIM(mon1.mnnemo))                                                                       , -- ISO_CURRENCY_CD          
                                               CASE     WHEN mon1.mnnemo = 'CLP' THEN           
               '1'          
                         WHEN mon1.mnnemo = 'UF' THEN          
        '2'          
         ELSE          
           '3'          
            END                                                                                             , -- TIPO_MONEDA 1: MN, 2, MREAJ, 3: MX           
                                               mvto.motipoper                                                                                  , -- TIPO_OPERACION          
                                               '0'                                                                                             , -- PERIODICIDAD_DE_FLUJOS           
                                               SPACE(0)                                                                                        , -- IND_TASA_TRANSFERENCIA          
                                               '0'                                                                                             , -- NRO_CUOTAS_FLUJO_SWAP          
                                               0.0                                                                                             , -- TASA_INTERES          
                                                CASE     WHEN mvto.mocodpos1 = 2  THEN          
                                                            --ISNULL(mvto.mopremon1, 0.0)                                           -- TASA_TIPO_PARIDAD          
                                                              ISNULL(mvto.moparmon1, 0.0)          
                                                              WHEN mvto.mocodpos1 = 14 THEN          
                                                                                    ISNULL(mvto.mopremon1, 0.0)          
                                                              ELSE          
                                                                                    ISNULL(mvto.motipcam, 0.0)--1,3,13,10,11                                            
                                                END                                                                                            ,                                                                        
                                               mvto.momtomon1                                                                                  , -- CAP_MONE_ORIGEN          
                                               --mvto.moequmon1                                                                                  , -- CAP_MONE_LOCAL          
                                               --mvto.momtomon2,          
      mvto.moequmon1,    
      /*CASE WHEN mvto.mocodpos1 = 2 THEN          
                                                                              --RTRIM(ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0))         -- MONTO_UTIL_ORIGEN          
                                                    ROUND(mvto.moequmon1 / mvto.mopremon2 / mvto.moparmon1, 0)          
      ELSE        
                                                                              --mvto.Resultado_Mesa -- MONTO_UTIL_ORIGEN          
                                                    mvto.momtomon1          
                    
      END                                  ,*/          
                                               CASE WHEN mon1.mnnemo = 'CLP' THEN          
         isnull(mvto.Resultado_Mesa,0)          
       WHEN mon1.mnnemo = 'UF' THEN          
        isNull(mvto.Resultado_Mesa /mvto.motipcam,0)          
       WHEN mon1.mnnemo = 'USD' THEN          
         CASE WHEN mvto.mocodpos1 = 14 THEN          
                                                                           isNull(mvto.Resultado_Mesa / mvto.mopremon1,0)          
                                       ELSE           
                                                                          isNull(mvto.Resultado_Mesa / mvto.motipcam,0)          
                                                                 END          
                 
       ELSE          
         isNull((mvto.Resultado_Mesa / vvm.vmvalor) * mvto.moparmon1, 0)          
         --mvto.Resultado_Mesa          
       END  ,          
    CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)       
                                     ELSE                         mvto.Resultado_Mesa      
                                END     -- MONTO_UTIL_LOCAL       
    FROM   BacFwdSuda.dbo.MFMOH           mvto          
    INNER JOIN BacFwdSuda.dbo.MFACH     ctro ON ctro.acfecproc  = mvto.mofecha          
                                              INNER JOIN BacParamSuda.dbo.CLIENTE  clie ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli          
                                              INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1          
                                              LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = mvto.mocodmon1          
                                              LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 ON mon2.mncodmon   = mvto.mocodmon2          
                                              LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont ON vcont.fecha         = ctro.acfecante  AND vcont.codigo_moneda = 994          
      LEFT JOIN BacParamSuda.dbo.valor_moneda vvm ON vvm.vmfecha = mvto.mofecha AND vvm.vmcodigo = 998          
                WHERE mvto.moestado              <> 'A'    AND          
                                             mvto.mofecha              >= @PrimerDiaMes AND          
       mvto.mofecha              <= @UltimoDiaMes          
      --CONVERT(CHAR(8),mvto.mofecha,112)              > @PrimerDiaMes AND          
                                               --CONVERT(CHAR(8),mvto.mofecha,112)              < @UltimoDiaMes          
                               ORDER BY mvto.monumoper          
          
        
      
   /*****************************************ANTICIPOS FORWARD *********************************************************************/      
   /*****************************************************************************************************************/      
      
SELECT canumoper, cacodpos1,  catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
      ,   camtomon1, catipcam, caparmon1, caequmon1, caequusd1, caequmon2, capremon1, capremon2, capreant, caspread,   camtomon2        
      ,   cafecha,   cafecvcto, cafecEfectiva, caestado,  caantici,  caoperador        
      ,   precio_spot, caantptosfwd, caantptoscos        
     INTO #TMP_CARTERA_ANTICIPO_FORWARD        
     FROM BacFwdsuda.dbo.MFCA   unw with(nolock)        
 WHERE unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes      
      and unw.caestado  <> 'A'        
 and unw.caantici   = 'A'        
      
  
   INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD    
   SELECT    unw.canumoper, unw.cacodpos1, unw.catipoper, unw.catipmoda, unw.cacodigo,  unw.cacodcli, unw.cacodmon1, unw.cacodmon2    
      ,   unw.camtomon1, unw.catipcam, unw.caparmon1, unw.caequmon1, unw.caequusd1, unw.caequmon2, unw.capremon1, unw.capremon2  
      ,   unw.capreant, unw.caspread,  unw.camtomon2    
      ,   unw.cafecha,   unw.cafecvcto, unw.cafecEfectiva, unw.caestado,  unw.caantici,  unw.caoperador    
      ,   res.precio_spot, caantptosfwd = res.caantptosfwd, caantptoscos=res.caantptoscos  
     FROM BacFwdsuda.dbo.MFCAh  unw with(nolock)    
          inner join BacFwdsuda.dbo.MFCARES res ON res.CaFechaProceso = unw.cafecvcto and res.canumoper = unw.canumoper  
    WHERE unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes    
 and unw.caestado  <> 'A'  
 and unw.caantici   = 'A'    
 and unw.canumoper  NOT IN(SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)    
  
      
/*        
  
   INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD        
   SELECT canumoper, cacodpos1, catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
      ,   camtomon1, catipcam, caparmon1, caequmon1, caequusd1, caequmon2, capremon1, capremon2, capreant, caspread,  camtomon2        
      ,   cafecha,   cafecvcto, cafecEfectiva, caestado,  caantici,  caoperador        
      ,   precio_spot, caantptosfwd = 0.0 , caantptoscos = 0.0       
     FROM BacFwdsuda.dbo.MFCAH  unw with(nolock)        
    WHERE unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes        
      and unw.caestado  <> 'A'        
      and unw.caantici   = 'A'        
      and unw.canumoper  NOT IN(SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)        
  
  
  
   UPDATE MIS_CON_BAC_UTIL_TC        
      SET CAP_MONE_ORIGEN                             = CAP_MONE_ORIGEN - cant.camtomon1        
      ,   CAP_MONE_LOCAL                        = CAP_MONE_LOCAL - cant.caequmon1        
      --,   MontoDolares                      = MontoDolares - CASE WHEN cant.cacodpos1 = 2 and cant.camtomon1 <> 13 THEN cant.camtomon2 ELSE cant.caequusd1 END        
     FROM #TMP_CARTERA_ANTICIPO_FORWARD     cant        
    WHERE MIS_CON_BAC_UTIL_TC.PRODUCT_TYPE_CD           = 'FWD'        
      AND MIS_CON_BAC_UTIL_TC.OPERACION = cant.canumoper        
*/    
      
    
   UPDATE #TMP_CARTERA_ANTICIPO_FORWARD      
      SET caspread  = caspread + MIS_CON_BAC_UTIL_TC.MONTO_UTIL_LOCAL,    
  precio_spot = catipcam -- #TMP1.TASA_TIPO_PARIDAD    
     FROM MIS_CON_BAC_UTIL_TC           
    WHERE MIS_CON_BAC_UTIL_TC.PRODUCT_TYPE_CD = 'FWD'      
      AND MIS_CON_BAC_UTIL_TC.OPERACION = canumoper      
    
 DELETE FROM MIS_CON_BAC_UTIL_TC    
 WHERE OPERACION IN (SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)    
 AND PRODUCT_TYPE_CD = 'FWD'    
      
      
INSERT INTO MIS_CON_BAC_UTIL_TC        
SELECT  CONVERT(CHAR(6),unw.cafecvcto,112)                                                              ,-- MES_CONTABLE      
                                               'MI59'                                                                                          ,-- SOURCE_ID Preguntar que se debe ingresar.... de donde saco esta info.      
                                               LTRIM(RTRIM(unw.canumoper))                                                                    ,-- N° de Op.      
                                               'MD10'                                                                                          ,-- PRODUCT_ID  Preguntar que se debe ingresar.... de donde saco esta info.      
                                               'CL'                                                                                            ,-- ISO_COUNTRY      
                                               '001'                        ,-- EMPRESA_ID      
                                               '001'                                                                                           , -- BRANCH_CD      
                                               LTRIM(RTRIM(CONVERT(CHAR(10), cli.clrut)))+ LTRIM(RTRIM(cli.cldv))                            , -- + SPACE(12 - LEN(LTRIM(RTRIM(clie.Clrut + clie.Cldv)))) ,                  
                                               LTRIM(RTRIM(cli.clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(cli.clnombre))))                      , -- FULL_NAME      
                                               'MDIR'                                                                                           , -- FAMILIA  Preguntar que se debe ingresar.... de donde saco esta info.      
                                               'FWD'                                                                                           , -- PRODUCT_TYPE_CD      
                                               CONVERT(CHAR(8), unw.cafecha, 112)                                                             , -- FECHA_CONTABLE       
                                               CONVERT(CHAR(8), unw.cafecha, 112)                      , -- FECHA_INTERFAZ      
                                               CONVERT(CHAR(8), unw.cafecha, 112)                                                             , -- FECHA_APERTURA_OPERAC      
                                               CONVERT(CHAR(8), unw.cafecha, 112)                                                             , -- FECHA_INICIO      
                                               CONVERT(CHAR(8), unw.cafecvcto, 112)                                                           , -- FECHA_VCMTO      
                                               SPACE(0)                                                                                        , -- FECHA_RENOVACION       Preguntar que se debe ingresar.... de donde saco esta info.      
                 CONVERT(CHAR(8),unw.cafecEfectiva,112)                                                         , -- FECHA_PROX_CAMBIO_TASA       
                                               LTRIM(RTRIM(mn1.mnnemo))                                                                       , -- ISO_CURRENCY_CD      
                                               CASE     WHEN mn1.mnnemo = 'CLP' THEN       
                   '1'      
                            WHEN mn1.mnnemo = 'UF' THEN      
             '2'      
             ELSE      
                '3'      
                 END                , -- TIPO_MONEDA 1: MN, 2, MREAJ, 3: MX       
                                               unw.catipoper                                                                                  , -- TIPO_OPERACION      
                                               '0'                                                                                             , -- PERIODICIDAD_DE_FLUJOS       
                                               SPACE(0)                                                                                        , -- IND_TASA_TRANSFERENCIA      
                                               '0'                                                                                             , -- NRO_CUOTAS_FLUJO_SWAP      
                                               0.0                                                                                             , -- TASA_INTERES      
                                                CASE     WHEN unw.cacodpos1 = 2  or unw.cacodpos1 = 13 THEN      
                                                            ISNULL(unw.capremon1, 0.0)                                           -- TASA_TIPO_PARIDAD      
                                                              --ISNULL(unw.caparmon1, 0.0)      
 WHEN unw.cacodpos1 = 14 THEN      
                     unw.precio_spot  + unw.caantptosfwd      
                                                                                    --ISNULL(unw.capremon1, 0.0)      
                                                              ELSE      
                                                                                    --ISNULL(unw.catipcam, 0.0)--1,3,13,10,11                                        
                   unw.precio_spot  + unw.caantptosfwd      
                                                END                                                                                            ,                                                                    
                                               unw.camtomon1                                                                                  , -- CAP_MONE_ORIGEN      
      unw.caequmon1, -- unw.caequmon2    
                        CASE WHEN mn1.mnnemo = 'CLP' THEN      
         isnull(unw.caspread,0)      
       WHEN mn1.mnnemo = 'UF' THEN      
        isNull(unw.caspread /unw.catipcam,0)      
       WHEN mn1.mnnemo = 'USD' THEN      
         CASE WHEN unw.cacodpos1 = 14 THEN      
                                                                           isNull(unw.caspread / unw.capremon1,0)      
                                                                 ELSE       
                                                                          isNull(unw.caspread / unw.catipcam,0)      
                                                                 END      
             
       ELSE      
         isNull((unw.caspread / vvm.vmvalor) * unw.caparmon1, 0)      
       END  ,      
          
      
    unw.caspread         -- MONTO_UTIL_LOCAL      
   FROM   #TMP_CARTERA_ANTICIPO_FORWARD unw        
          LEFT JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) ON pro.id_sistema = 'FWD' AND pro.codigo_producto = unw.cacodpos1        
          LEFT JOIN BacParamSuda.dbo.CLIENTE  cli with(nolock) ON cli.clrut      = unw.cacodigo and cli.clcodigo = unw.cacodcli        
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) ON mn1.mncodmon   = unw.cacodmon1        
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn2 with(nolock) ON mn2.mncodmon   = unw.cacodmon2        
    LEFT JOIN BacParamSuda.dbo.valor_moneda vvm ON vvm.vmfecha = unw.cafecha AND vvm.vmcodigo = 998      
      
 drop table #TMP_CARTERA_ANTICIPO_FORWARD      
      
      
      
      
   /****************************************************SWAP**********************************************************/          
   /*****************************************************************************************************************/          
          
          
    INSERT INTO MIS_CON_BAC_UTIL_TC          
    SELECT CONVERT(CHAR(6),mvto.fecha_cierre,112)     , -- MES_CONTABLE         
    'MI59'          , -- SOURCE_ID Preguntar que se debe ingresar.... de donde saco esta info.          
    LTRIM(RTRIM(mvto.numero_operacion))      , -- N° de Op.          
    'MD11'          , -- PRODUCT_ID  Preguntar que se debe ingresar.... de donde saco esta info.          
    'CL'          , -- ISO_COUNTRY          
    '001'          , -- EMPRESA_ID          
    '001'          , -- BRANCH_CD          
    LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))  ,  -- CLIENTE_ID          
    LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre)))) ,  -- FULL_NAME          
    'MDIR'          , -- FAMILIA          
    'PCS'          , -- PRODUCT_TYPE_CD          
    CONVERT(CHAR(8), mvto.fecha_cierre, 112)      , -- FECHA_CONTABLE           
    CONVERT(CHAR(8), mvto.fecha_cierre, 112)      , -- FECHA_INTERFAZ          
    CONVERT(CHAR(8), mvto.fecha_cierre, 112)     ,  -- FECHA_APERTURA_OPERAC          
    CONVERT(CHAR(8), mvto.fecha_inicio, 112)     ,  -- FECHA_INICIO          
    CONVERT(CHAR(8), mvto.fecha_termino, 112)     , -- FECHA_VCMTO          
    CONVERT(CHAR(8), mvto.fecha_vence_flujo, 112)     , -- FECHA_RENOVACION          
    CONVERT(CHAR(8), mvto.fecha_fijacion_tasa, 112)     , -- FECHA_PROX_CAMBIO_TASA Preguntar que se debe ingresar.... de donde saco esta info.          
    LTRIM(RTRIM(mon1.mnnemo))       , -- ISO_CURRENCY_CD          
    CASE WHEN mon1.mnnemo = 'CLP' THEN          
         '1'          
     WHEN mon1.mnnemo = 'UF' THEN          
         '2'          
     ELSE   
         '3'          
     END          , -- TIPO_MONEDA 1: MN, 2, MREAJ, 3: MX ?????          
     'C'          , -- TIPO_OPERACION          
     LTRIM(RTRIM(mvto.compra_codamo_interes ))    , -- PERIODICIDAD_DE_FLUJOS ????          
     LTRIM(RTRIM(mvto.compra_codigo_tasa))     , -- IND_TASA_TRANSFERENCIA          
     LTRIM(RTRIM((SELECT MAX(MVTO.numero_flujo)          
      FROM BacSwapSuda.dbo.MOVHISTORICO MVTO          
      WHERE MVTO.NUMERO_OPERACION = vent.NUMERO_OPERACION)))  ,  -- NRO_CUOTAS_FLUJO_SWAP          
     isNull(MVTO.compra_valor_tasa,0)      , --compra_valor_tasa--Tasa_Transfer--compra_valor_tasa_hoy-- cual de estos campo es la tasa de interes          
     isNUll(mvto.compra_valor_tasa,0)      , -- TASA_TIPO_PARIDAD          
     isNull(mvto.compra_capital,0)       , -- CAP_MONE_ORIGEN          
               
    --CAP_MONE_LOCAL = capital * valor_UF          
     --vent.venta_capital       , -- CAP_MONE_LOCAL          
     CASE WHEN mon1.mnnemo = 'CLP' THEN          
          isNull(mvto.compra_capital,0)        
      WHEN mon1.mnnemo = 'UF' THEN          
       --select vmvalor from view_valor_moneda where vmfecha = mvto.fecha_inicio and vmcodigo = 998          
       isnull(mvto.compra_capital * vvm.vmvalor,0)          
       --vent.venta_capital          
      WHEN mon1.mnnemo = 'COP' THEN            
       isnull(mvto.compra_capital * vmon.Tipo_Cambio,0)               
                 
     ELSE          
         --mvto.compra_capital * vmc.Tipo_Cambio -- del dia (527.60)          
         isnull(vmc.Tipo_Cambio * mvto.compra_capital,0)          
                   
     END  ,          
          
     -- MONTO_UTIL_ORIGEN          
     --mvto.Res_Mesa_Dist_CLP       , -- MONTO_UTIL_ORIGEN          
     CASE WHEN mon1.mnnemo = 'CLP' THEN          
         isnull(mvto.Res_Mesa_Dist_CLP,0)          
      WHEN mon1.mnnemo = 'UF' THEN          
       --select vmvalor from view_valor_moneda where vmfecha = mvto.fecha_inicio and vmcodigo = 998          
       isNull(mvto.Res_Mesa_Dist_CLP / vvm.vmvalor,0)          
 --vent.venta_capital          
      WHEN mon1.mnnemo = 'COP' THEN            
       isnull(mvto.Res_Mesa_Dist_CLP / vmon.Tipo_Cambio,0)  
                 
                 
     ELSE          
         --mvto.compra_capital * vmc.Tipo_Cambio -- del dia (527.60)          
         isNull(mvto.Res_Mesa_Dist_USD,0)          
                   
     END  ,          
               
          
          
     mvto.Res_Mesa_Dist_CLP        -- MONTO_UTIL_LOCAL          
     FROM  BacSwapSuda.dbo.MOVHISTORICO              mvto          
               
     INNER JOIN BacSwapSuda.dbo.MOVHISTORICO    vent ON vent.numero_operacion = mvto.numero_operacion           
          AND vent.numero_flujo     = mvto.numero_flujo          
          AND vent.tipo_flujo       = 2          
               
            INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente           
                      
     LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda          
            LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda          
               
     
     LEFT JOIN BacParamSuda.dbo.Valor_moneda_contable vmc ON vmc.Fecha = mvto.fecha_inicio AND vmc.Codigo_Moneda = 994          
     --LEFT JOIN BacFwdSuda..view_valor_moneda vvm ON vvm.vmfecha = mvto.fecha_inicio AND vvm.vmcodigo = 998          
     LEFT JOIN BacParamSuda.dbo.valor_moneda vvm ON vvm.vmfecha = mvto.fecha_inicio AND vvm.vmcodigo = 998          
     LEFT JOIN BacParamSuda.dbo.Valor_moneda_contable vmon ON vmon.Fecha = mvto.fecha_inicio AND vmon.Codigo_Moneda = 129 -- COP  
                    
     WHERE   mvto.fecha_cierre       >= @PrimerDiaMes AND          
      mvto.fecha_cierre <= @UltimoDiaMes AND          
             
     mvto.estado           <> 'C'   AND          
     mvto.tipo_flujo       = 1   AND          
     mvto.numero_flujo =(SELECT MIN( ctlf.numero_flujo )           
                       FROM BacSwapSuda.dbo.MOVHISTORICO ctlf           
                                       WHERE ctlf.fecha_cierre >= @PrimerDiaMes AND           
         ctlf.fecha_cierre <= @UltimoDiaMes AND          
         ctlf.numero_operacion  = mvto.numero_operacion AND            
                                           ctlf.tipo_flujo        = 1)          
     ORDER BY mvto.numero_operacion          
          
          
  /**************************************************  SWAP  **********************************************************/    
 /************************************************  ANTICIPOS  *******************************************************/    
    
 SELECT CONVERT(CHAR(6),his.fecha_termino,112)      as MES_CONTABLE,    
 'MI59'          as SOURCE_ID ,    
 LTRIM(RTRIM(his.numero_operacion))      as numero_operacion,    
 'MD11'          as PRODUCT_ID  ,    
 'CL'          as ISO_COUNTRY,    
 '001'          as EMPRESA_ID,    
 '001'          as BRANCH_CD,    
 LTRIM(RTRIM(CONVERT(CHAR(10),clie.clrut)))+ LTRIM(RTRIM(clie.cldv))  as CLIENTE_ID,    
 LTRIM(RTRIM(clie.clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.clnombre)))) as FULL_NAME,    
 'MDIR'          as FAMILIA,    
 'PCS'          as PRODUCT_TYPE_CD,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_CONTABLE ,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_INTERFAZ,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_APERTURA_OPERAC,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_INICIO,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_VCMTO,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_RENOVACION,    
 CONVERT(CHAR(8), his.fecha_termino, 112) as FECHA_PROX_CAMBIO_TASA ,    
 LTRIM(RTRIM(mon1.mnnemo))     as ISO_CURRENCY_CD,    
 CASE WHEN mon1.mnnemo = 'CLP' THEN    
   '1'    
 WHEN mon1.mnnemo = 'UF' THEN    
   '2'    
 ELSE    
   '3'    
 END          as TIPO_MONEDA,    
 'C'          as TIPO_OPERACION,    
 LTRIM(RTRIM(his.compra_codamo_interes ))    as PERIODICIDAD_DE_FLUJOS ,    
 LTRIM(RTRIM(his.compra_codigo_tasa))     as IND_TASA_TRANSFERENCIA,    
 LTRIM(RTRIM((SELECT MAX(MVTO.numero_flujo)    
   FROM BacSwapSuda.dbo.CARTERAHIS MVTO    
   WHERE MVTO.NUMERO_OPERACION = his.NUMERO_OPERACION))) as NRO_CUOTAS_FLUJO_SWAP,    
 isNull(his.compra_valor_tasa,0)      as compra_valor_tasa,    
 isNUll(his.compra_valor_tasa,0)      as TASA_TIPO_PARIDAD,    
 isNull(his.compra_capital,0)        as CAP_MONE_ORIGEN,    
 CASE WHEN mon1.mnnemo = 'CLP' THEN    
   isNull(his.compra_capital,0)    
  WHEN mon1.mnnemo = 'UF' THEN    
   isnull(his.compra_capital * vvm.vmvalor,0)    
  WHEN mon1.mnnemo = 'COP' THEN            
   isnull(his.compra_capital * vmon.Tipo_Cambio,0)        
  ELSE    
   isnull(vmc.Tipo_Cambio * his.compra_capital,0)    
  END             as CAP_MONE_LOCAL,    
 CASE WHEN mon1.mnnemo = 'CLP' THEN    
   isnull(unw.ResMesa,0)    
  WHEN mon1.mnnemo = 'UF' THEN    
   isNull(unw.ResMesa / vvm.vmvalor,0)    
  WHEN mon1.mnnemo = 'COP' THEN            
   isnull(unw.ResMesa / vmon.Tipo_Cambio,0)  
  ELSE    
   isNull(unw.ResMesa / vmc.Tipo_Cambio,0)  
   END             as MONTO_ORIGEN,    
 unw.ResMesa           as ResMesa    
 INTO #TMP_CARTERA_ANTICIPO_SWAP    
 FROM   BacSwapsuda.dbo.CARTERAHIS            his      
 INNER JOIN BacSwapsuda.dbo.CARTERAHIS vta ON vta.numero_operacion = his.numero_operacion       
                          AND vta.numero_flujo     = his.numero_flujo      
                          AND vta.tipo_flujo       = 2      
 INNER JOIN ( SELECT numero_operacion as NumCon, MIN(numero_flujo) -1 as FluCon, tipo_flujo as TipCon, MIN( Devengo_Recibido_Mda_Val /*Principal_Mda_Val*/ ) as ResMesa      
        FROM BacswapSuda.dbo.CARTERA_UNWIND      
        WHERE FechaAnticipo BETWEEN @PrimerDiaMes AND @UltimoDiaMes      
        AND tipo_flujo = 1 GROUP BY numero_operacion, tipo_flujo ) unw ON unw.NumCon  = his.numero_operacion      
                         AND unw.FluCon  = his.numero_flujo      
                                                     AND unw.TipCon  = his.tipo_flujo      
 INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = his.rut_cliente AND clie.clcodigo = his.codigo_cliente      
 LEFT  JOIN BacParamSuda.dbo.MONEDA  mon1 ON mon1.mncodmon = his.compra_moneda      
 LEFT  JOIN BacParamSuda.dbo.MONEDA  mon2 ON mon2.mncodmon = vta.venta_moneda      
  LEFT JOIN BacParamSuda.dbo.Valor_moneda_contable vmc ON vmc.Fecha = his.fecha_inicio AND vmc.Codigo_Moneda = 994    
 LEFT JOIN BacParamSuda.dbo.valor_moneda vvm ON vvm.vmfecha = his.fecha_inicio AND vvm.vmcodigo = 998    
 LEFT JOIN BacParamSuda.dbo.Valor_moneda_contable vmon ON vmon.Fecha = his.fecha_inicio AND vmon.Codigo_Moneda = 129 -- COP  
 WHERE his.estado      <> 'C'      
 AND  his.tipo_flujo   = 1      
    
    
    
 UPDATE #TMP_CARTERA_ANTICIPO_SWAP      
 SET ResMesa  = ResMesa + MIS_CON_BAC_UTIL_TC.MONTO_UTIL_LOCAL,    
  MONTO_ORIGEN = MONTO_ORIGEN + MIS_CON_BAC_UTIL_TC.MONTO_UTIL_ORIGEN    
 FROM MIS_CON_BAC_UTIL_TC    
 WHERE MIS_CON_BAC_UTIL_TC.PRODUCT_TYPE_CD           = 'PCS'      
 AND MIS_CON_BAC_UTIL_TC.OPERACION = numero_operacion      
    
 DELETE FROM MIS_CON_BAC_UTIL_TC    
 WHERE OPERACION IN (SELECT numero_operacion FROM #TMP_CARTERA_ANTICIPO_SWAP)    
 AND PRODUCT_TYPE_CD = 'PCS'    
    
 INSERT INTO MIS_CON_BAC_UTIL_TC    
 SELECT * FROM #TMP_CARTERA_ANTICIPO_SWAP    
    
 drop table #TMP_CARTERA_ANTICIPO_SWAP    
    
        
          
      
   /***************************************SPOT/CAMBIOS***************************************/          
   /******************************************************************************************/          
   /* TABLA MEMO*/          
          
     INSERT INTO MIS_CON_BAC_UTIL_TC          
     SELECT CONVERT(CHAR(6),mvto.mofech,112)     , -- MES_CONTABLE          
     'MI59'          , -- SOURCE_ID Preguntar que se debe ingresar.... de donde saco esta info.          
     LTRIM(RTRIM(mvto.monumope))       , -- N° de Op.          
     'MD14'          , -- PRODUCT_ID  Preguntar que se debe ingresar.... de donde saco esta info.          
     'CL'          , -- ISO_COUNTRY          
     '001'          , -- EMPRESA_ID          
     '001'          , -- BRANCH_CD          
     LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie. Cldv))   , -- CLIENTE_ID          
     LTRIM(RTRIM(clie.Clnombre)) + SPACE(80 - LEN(LTRIM(RTRIM(clie.Clnombre)))) ,  -- FULL_NAME          
 'MDIR'          ,  -- FAMILIA          
     'BCC'          , -- PRODUCT_TYPE_CD          
     CONVERT(CHAR(8), mvto.mofech, 112)       , -- FECHA_CONTABLE           
     CONVERT(CHAR(8), mvto.mofech, 112)         , -- FECHA_INTERFAZ          
     CONVERT(CHAR(8), mvto.mofech, 112)      , -- FECHA_APERTURA_OPERAC          
     CONVERT(CHAR(8), mvto.mofech, 112)      , -- FECHA_INICIO          
     CONVERT(CHAR(8), mvto.mofech, 112)      , -- FECHA_VCMTO          
     SPACE(0)         , -- FECHA_RENOVACION          
     SPACE(0)         , -- FECHA_PROX_CAMBIO_TASA          
     mvto.mocodmon         , -- ISO_CURRENCY_CD          
     CASE WHEN mvto.mocodmon = 'CLP' THEN           
        '1'          
     WHEN mvto.mocodmon = 'UF' THEN          
        '2'          
     ELSE          
        '3'          
     END          , -- TIPO_MONEDA 1: MN, 2, MREAJ, 3: MX           
     mvto.motipope         , -- TIPO_OPERACION          
     '0'          , -- PERIODICIDAD_DE_FLUJOS          
     SPACE(0)         , -- IND_TASA_TRANSFERENCIA          
     '0'          , -- NRO_CUOTAS_FLUJO_SWAP          
     0.0          , -- TASA_INTERES??          
     CASE WHEN mvto.MOTIPMER = 'ARBI'            
       or mvto.MOTIPMER = 'EMPR'           
       and mvto.MOCODCNV <> 'CLP' then  --OR mvto.mocodmon = 'EUR' THEN          
        ISNULL(mvto.MOPARME, 0.0)                                   -- TASA_TIPO_PARIDAD          
                
      ELSE          
       ISNULL(mvto.moticam,0.0)      
     END               ,      
  mvto.momonmo         , -- CAP_MONE_ORIGEN          
     mvto.momonpe         , -- CAP_MONE_LOCAL          
               
     --mvto.moDifTran_Clp        , -- MONTO_UTIL_ORIGEN          
      CASE WHEN mvto.mocodmon = 'CLP' THEN          
         isnull(CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END,0)          
       WHEN mvto.mocodmon = 'UF' THEN          
          
        isNull(CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)          
       WHEN mvto.mocodmon = 'USD' THEN          
        isNull(CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)          
                 
       ELSE          
          
         --isNull((mvto.Resultado_Mesa / vvm.vmvalor) * mvto.moparmon1, 0)          
         isNull((CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam) *mvto.MOPARME, 0)          
         --mvto.moDifTran_Clp          
       END  ,          
          
          
     --mvto.moDifTran_Clp         -- MONTO_UTIL_LOCAL          
     CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END      
     FROM BacCamSuda.dbo.MEMOH mvto          
            INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli AND          
         clie.clcodigo = mvto.mocodcli          
     WHERE mvto.moestatus <> 'A'  AND          
      mvto.moterm  <> 'FORWARD' AND          
      mvto.moterm <> 'SWAP' AND          
      mvto.moterm <> 'OPCIONES' AND          
      mvto.MOTIPMER <> 'CCBB'   AND        
      --mvto.MOTERM <> 'DATATEC' AND          
      --mvto.MOTERM <> 'CORREDORA' AND          
      mvto.mofech >= @PrimerDiaMes AND          
      mvto.mofech <= @UltimoDiaMes AND          
      -- mvto.MOOPER <> 'CAVENDANO' AND      
   mvto.monumope NOT IN (SELECT  MONUMOPE FROM BacCamSuda..MEMOH WHERE MOOPER = 'CAVENDANO' AND moDifTran_Clp = 0 )  AND    
      mvto.monumope NOT IN (SELECT  MONUMOPE FROM BacCamSuda..MEMOH WHERE MORUTCLI in ('96665450') AND moDifTran_Clp = 0 )          
     ORDER BY mvto.monumope          
          
          
          
   /***************************************OPCIONES***************************************/          
   /**************************************************************************************/          
          
     SELECT * into #AnuladasyAnticipadas from  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato          
     where  moTipoTransaccion = 'ANULA' or moTipoTransaccion = 'ANTICIPA'          
     AND MoFechaContrato >= @PrimerDiaMes           
     AND MoFechaContrato <= @UltimoDiaMes      
      
     SELECT CONVERT(CHAR(6),mvto.MoFechaContrato,112) as MES_CONTABLE     , --   
     'MI59'          as SOURCE_ID ,   
     LTRIM(RTRIM(mvto.MoNumContrato)) as NroOpe ,  
     'MD15'          as PRODUCT_ID  ,  
     'CL'          as ISO_COUNTRY  ,  
     '001'          as EMPRESA_ID  ,  
     '001'          as BRANCH_CD  ,  
     LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv)) as CLIENTE_ID  ,  
     LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre)))) as FULL_NAME ,  
     'MDIR'   as FAMILIA ,   
     'OPC'   as PRODUCT_TYPE_CD  ,  
     CONVERT(CHAR(8),mvto.MoFechaContrato,112) as FECHA_CONTABLE   ,  
     CONVERT(CHAR(8),mvto.MoFechaContrato,112) as FECHA_INTERFAZ  ,  
     CONVERT(CHAR(8),mvto.MoFechaContrato,112) as FECHA_APERTURA_OPERAC  ,  
     CONVERT(CHAR(8),mvto.MoFechaContrato,112) as FECHA_INICIO  ,   
     CONVERT(CHAR(8),mvto.MoFechaContrato,112) as FECHA_VCMTO ,   
     SPACE(0)         as FECHA_RENOVACION ,  
     SPACE(0)         as FECHA_PROX_CAMBIO_TASA ,   
     LTRIM(RTRIM(mon1.mnnemo)) as ISO_CURRENCY_CD ,  
     CASE WHEN mon1.mnnemo = 'CLP' THEN     
     '1'    
     WHEN mon1.mnnemo = 'UF' THEN    
        '2'    
     ELSE    
        '3'    
     END            as TIPO_MONEDA ,  
     CASE WHEN ctro.MoVinculacion ='Individual' THEN      -- TIPO_OPERACION -- preguntar MNG    
      ctro.MoCVOpc     
     ELSE    
      ''    
     END      as TIPO_OPERACION ,  
     '00000'       as PERIODICIDAD ,  
     SPACE(0)      as IND_TASA_TRANSFERENCIA ,  
     '0'         as NRO_CUOTAS_FLUJO_SWAP ,  
     0.0          as TASA_INTERES,  
     ctro.MoStrike          as TASA_TIPO_PARIDAD  ,  
     ctro.MoMontoMon1       as CAP_MONE_ORIGEN  ,  
     ctro.MoMontoMon2       as CAP_MONE_LOCAL  ,  
     mvto.MoResultadoVentasML / ctro.MoStrike  as MONTO_UTIL_ORIGEN  ,  
     ISNULL(mvto.MoResultadoVentasML,0)  as MONTO_UTIL_LOCAL  ,  
 ctro.MoFechaInicioOpc as FechaInicioOpc,  
 ctro.MoNumFolio as NumFolio  
   INTO #TMP2  
     FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato mvto    
            INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.MoRutCliente and clie.clcodigo = mvto.MoCodigo    
            INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato       ctro ON mvto.MoNumFolio  = ctro.MoNumFolio and ctro.MoNumEstructura=1    
     LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = ctro.MoCodMon1    
     WHERE mvto.MoFechaContrato >= @PrimerDiaMes     
     AND mvto.MoFechaContrato <= @UltimoDiaMes    
     AND  mvto.MoNumContrato not in ( select MoNumcontrato from #AnuladasyAnticipadas )     
  AND  mvto.MoEstado   <> 'C' -->  Para sacar las cotizaciones  
 order by mvto.MoNumContrato  
  
 select max(NumFolio)as NumFolio, NroOpe   
 into #MAX  
 from #TMP2   
 group by NroOpe  
 order by NroOpe  
  
 INSERT INTO MIS_CON_BAC_UTIL_TC  
 select MES_CONTABLE, SOURCE_ID, a.NroOpe ,PRODUCT_ID, ISO_COUNTRY, EMPRESA_ID, BRANCH_CD , CLIENTE_ID,  
 FULL_NAME, FAMILIA, PRODUCT_TYPE_CD, FECHA_CONTABLE, FECHA_INTERFAZ, FECHA_APERTURA_OPERAC, FECHA_INICIO,  
 FECHA_VCMTO, FECHA_RENOVACION, FECHA_PROX_CAMBIO_TASA, ISO_CURRENCY_CD, TIPO_MONEDA, TIPO_OPERACION,  
 PERIODICIDAD, IND_TASA_TRANSFERENCIA, NRO_CUOTAS_FLUJO_SWAP, TASA_INTERES,TASA_TIPO_PARIDAD,  
    CAP_MONE_ORIGEN, CAP_MONE_LOCAL, MONTO_UTIL_ORIGEN, MONTO_UTIL_LOCAL  
 FROM #TMP2 a, #MAX b where a.NroOpe = b.NroOpe  
 AND a.NumFolio = b.NumFolio  
  
 DROP TABLE #TMP2  
 DROP TABLE #MAX  
    DROP TABLE #AnuladasyAnticipadas    
  
*/	-->			Adrian


 /************************************************************************************************************************/          
 /*INTERFAZ BAC */    

SET NOCOUNT ON

	TRUNCATE TABLE dbo.MIS_CON_BAC_UTIL_TC
	
	EXECUTE dbo.SP_LOAD_DATA_MIS 1 --> Proceso Diario

  
CREATE TABLE #SALIDA (    
RESUMEN CHAR(1000) )  
  
INSERT #SALIDA        
 SELECT  'MES_CONTABLE'      + ';' +          
  'SOURCE_ID'      + ';' +          
  'OPERACION'     + ';' +          
  'PRODUCT_ID'     + ';' +          
'ISO_COUNTRY'     + ';' +          
  'EMPRESA_ID'     + ';' +          
  'BRANCH_CD'     + ';' +           
  'CLIENTE_ID'     + ';' +          
  'FULL_NAME'     + ';' +          
  'FAMILIA'     + ';' +          
  'PRODUCT_TYPE_CD'    + ';' +          
  'FECHA_CONTABLE'    + ';' +          
  'FECHA_INTERFAZ'    + ';' +          
  'FECHA_APERTURA_OPERAC'    + ';' +       
  'FECHA_INICIO'     + ';' +          
  'FECHA_VCMTO'     + ';' +          
  'FECHA_RENOVACION'    + ';' +          
  'FECHA_PROX_CAMBIO_TASA'   + ';' +          
  'ISO_CURRENCY_CD'    + ';' +          
  'TIPO_MONEDA'     + ';' +          
  'TIPO_OPERACION'    + ';' +          
  'PERIODICIDAD_DE_FLUJOS'   + ';' +          
  'IND_TASA_TRANSFERENCIA'   + ';' +          
  'NRO_CUOTAS_FLUJO_SWAP'    + ';' +          
  'TASA_INTERES'     + ';' +          
  'TASA_TIPO_PARIDAD'    + ';' +          
  'CAP_MONE_ORIGEN'    + ';' +          
  'CAP_MONE_LOCAL'    + ';' +          
  'MONTO_UTIL_ORIGEN'    + ';' +          
  'MONTO_UTIL_LOCAL'    -- AS RESUMEN           
  
-- UNION          
          
INSERT #SALIDA          
 SELECT  LTRIM(RTRIM(MES_CONTABLE))    + ';' +          
  LTRIM(RTRIM(SOURCE_ID))     + ';' +          
  LTRIM(RTRIM(OPERACION))     + ';' +          
  LTRIM(RTRIM(PRODUCT_ID))    + ';' +          
  LTRIM(RTRIM(ISO_COUNTRY))    + ';' +          
  LTRIM(RTRIM(EMPRESA_ID))    + ';' +          
  LTRIM(RTRIM(BRANCH_CD))     + ';' +          
  LTRIM(RTRIM(CLIENTE_ID))    + ';' +          
  LTRIM(RTRIM(FULL_NAME))     + ';' +          
  LTRIM(RTRIM(FAMILIA))     + ';' +          
  LTRIM(RTRIM(PRODUCT_TYPE_CD))    + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(8),FECHA_CONTABLE,112))) + ';' +          
  LTRIM(RTRIM(FECHA_INTERFAZ))    + ';' +          
  LTRIM(RTRIM(FECHA_APERTURA_OPERAC))   + ';' +          
  LTRIM(RTRIM(FECHA_INICIO))    + ';' +          
  LTRIM(RTRIM(FECHA_VCMTO))    + ';' +          
  LTRIM(RTRIM(FECHA_RENOVACION))    + ';' +          
  LTRIM(RTRIM(FECHA_PROX_CAMBIO_TASA))   + ';' +          
  LTRIM(RTRIM(ISO_CURRENCY_CD))    + ';' +          
  LTRIM(RTRIM(TIPO_MONEDA))    + ';' +          
  LTRIM(RTRIM(TIPO_OPERACION))    + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),PERIODICIDAD_DE_FLUJOS)))   + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),IND_TASA_TRANSFERENCIA))) + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),NRO_CUOTAS_FLUJO_SWAP)))   + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),TASA_INTERES)))  + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),TASA_TIPO_PARIDAD))) + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_ORIGEN)))  + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_LOCAL)))  + ';' +          
  LTRIM(RTRIM(MONTO_UTIL_ORIGEN))    + ';' +          
  LTRIM(RTRIM(CONVERT(CHAR(18),MONTO_UTIL_LOCAL)))          
 FROM  MIS_CON_BAC_UTIL_TC          
 --ORDER BY PRODUCT_TYPE_CD,OPERACION          
 --ORDER BY RESUMEN DESC          
  
select ltrim(rtrim(RESUMEN)) as RESUMEN FROM  #SALIDA ORDER BY RESUMEN DESC    
  
END
GO

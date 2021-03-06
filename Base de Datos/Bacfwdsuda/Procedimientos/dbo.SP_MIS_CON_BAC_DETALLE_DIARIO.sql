USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MIS_CON_BAC_DETALLE_DIARIO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MIS_CON_BAC_DETALLE_DIARIO]
AS
BEGIN

/*


                SET NOCOUNT ON        
        
                DECLARE          @Fecha_Proceso         CHAR(10)        
                               , @PrimerDiaMes          CHAR(10)        
                               , @UltimoDiaMes          CHAR(10)        
                               , @Dias                 CHAR(10)        
        
                SET @Fecha_Proceso     = CONVERT(CHAR(8),GETDATE() ,112)
                SET @PrimerDiaMes      = ''        
                SET @UltimoDiaMes      = ''        
                SET @PrimerDiaMes      =  SUBSTRING(@Fecha_Proceso,1,6) + '01'        
                SET @UltimoDiaMes      = CONVERT(CHAR(10),@Fecha_Proceso,112)        
        
				--SET @PrimerDiaMes      = '20120801'
				--SET @UltimoDiaMes      = '20120831'

				--SELECT @PrimerDiaMes      
				--SELECT @UltimoDiaMes    
        
--				IF EXISTS(SELECT 1 FROM tempdb..SYSOBJECTS WHERE TYPE = 'U' AND NAME like '%MIS_CON_BAC_UTIL_TC_DIARIA%') BEGIN
--					DROP TABLE DBO.MIS_CON_BAC_UTIL_TC_DIARIA
--				END

				IF exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[MIS_CON_BAC_UTIL_TC_DIARIA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)        
                BEGIN        
                               drop table [dbo].[MIS_CON_BAC_UTIL_TC_DIARIA]        
                END  
      
        
                CREATE TABLE [DBO].[MIS_CON_BAC_UTIL_TC_DIARIA] (        
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
                               MONTO_UTIL_LOCAL            NUMERIC(18,5) ,
							   OPERADOR							CHAR(15) )
        
                /***************************************************FORWARD*************************************************/        
                /***********************************************************************************************************/        
                --TABLA MFMOH        
             
                              INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA        
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
                 CONVERT(CHAR(8),mvto.moFecEfectiva,112)                                            , -- FECHA_PROX_CAMBIO_TASA         
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
                                END,     -- MONTO_UTIL_LOCAL    
	mvto.mooperador    -- OPERADOR 
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



   UPDATE MIS_CON_BAC_UTIL_TC_DIARIA      
      SET CAP_MONE_ORIGEN                             = CAP_MONE_ORIGEN - cant.camtomon1      
      ,   CAP_MONE_LOCAL                        = CAP_MONE_LOCAL - cant.caequmon1      
      --,   MontoDolares                      = MontoDolares - CASE WHEN cant.cacodpos1 = 2 and cant.camtomon1 <> 13 THEN cant.camtomon2 ELSE cant.caequusd1 END      
     FROM #TMP_CARTERA_ANTICIPO_FORWARD     cant      
    WHERE MIS_CON_BAC_UTIL_TC_DIARIA.PRODUCT_TYPE_CD           = 'FWD'      
      AND MIS_CON_BAC_UTIL_TC_DIARIA.OPERACION = cant.canumoper      
*/  
    
  
   UPDATE #TMP_CARTERA_ANTICIPO_FORWARD    
      SET caspread  = caspread + MIS_CON_BAC_UTIL_TC_DIARIA.MONTO_UTIL_LOCAL,  
  precio_spot = catipcam -- #TMP1.TASA_TIPO_PARIDAD  
     FROM MIS_CON_BAC_UTIL_TC_DIARIA         
    WHERE MIS_CON_BAC_UTIL_TC_DIARIA.PRODUCT_TYPE_CD = 'FWD'    
      AND MIS_CON_BAC_UTIL_TC_DIARIA.OPERACION = canumoper    
  
 DELETE FROM MIS_CON_BAC_UTIL_TC_DIARIA  
 WHERE OPERACION IN (SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)  
 AND PRODUCT_TYPE_CD = 'FWD'  
    
    
INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA      
SELECT  CONVERT(CHAR(6),unw.cafecvcto,112)                                                              ,-- MES_CONTABLE    
                                               'MI59'                                                                                          ,-- SOURCE_ID Preguntar que se debe ingresar.... de donde saco esta info.    
                                               LTRIM(RTRIM(unw.canumoper))                                                                    ,-- N° de Op.    
                                               'MD10'                                                                                          ,-- PRODUCT_ID  Preguntar que se debe ingresar.... de donde saco esta info.    
                                               'CL'                                                                                            ,-- ISO_COUNTRY    
                                               '001'                                                                                           ,-- EMPRESA_ID    
                                               '001'                                                                                           , -- BRANCH_CD    
                                               LTRIM(RTRIM(CONVERT(CHAR(10), cli.clrut)))+ LTRIM(RTRIM(cli.cldv))                            , -- + SPACE(12 - LEN(LTRIM(RTRIM(clie.Clrut + clie.Cldv)))) ,                
                                               LTRIM(RTRIM(cli.clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(cli.clnombre))))                      , -- FULL_NAME    
                                               'MDIR'                            , -- FAMILIA  Preguntar que se debe ingresar.... de donde saco esta info.    
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
                                 unw.camtomon1                                                           , -- CAP_MONE_ORIGEN    
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
        
    
    unw.caspread  ,       -- MONTO_UTIL_LOCAL    
	unw.caoperador
   FROM   #TMP_CARTERA_ANTICIPO_FORWARD unw      
          LEFT JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) ON pro.id_sistema = 'FWD' AND pro.codigo_producto = unw.cacodpos1      
          LEFT JOIN BacParamSuda.dbo.CLIENTE  cli with(nolock) ON cli.clrut      = unw.cacodigo and cli.clcodigo = unw.cacodcli      
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) ON mn1.mncodmon   = unw.cacodmon1      
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn2 with(nolock) ON mn2.mncodmon   = unw.cacodmon2      
    LEFT JOIN BacParamSuda.dbo.valor_moneda vvm ON vvm.vmfecha = unw.cafecha AND vvm.vmcodigo = 998    
    
 drop table #TMP_CARTERA_ANTICIPO_FORWARD    
    
    
    
    
   /****************************************************SWAP**********************************************************/        
   /*****************************************************************************************************************/        
        
        
    INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA        
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.fecha_cierre,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.numero_operacion))
	,		PRODUCT_ID                  = 'MD11'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'PCS'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.fecha_inicio, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.fecha_termino, 112) 
	,		FECHA_RENOVACION            = CONVERT(CHAR(8), mvto.fecha_vence_flujo, 112)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8), mvto.fecha_fijacion_tasa, 112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = 'C' 
	,		PERIODICIDAD_DE_FLUJOS      = LTRIM(RTRIM(mvto.compra_codamo_interes ))
	,		IND_TASA_TRANSFERENCIA      = LTRIM(RTRIM(mvto.compra_codigo_tasa))
	,		NRO_CUOTAS_FLUJO_SWAP       = LTRIM(RTRIM(( SELECT	MAX(MVTO.numero_flujo) 
														FROM	BacSwapSuda.dbo.MOVHISTORICO MVTO 
														WHERE	MVTO.NUMERO_OPERACION = vent.NUMERO_OPERACION )))

	,		TASA_INTERES                = isNull(MVTO.compra_valor_tasa,0)
	,		TASA_TIPO_PARIDAD           = isNUll(mvto.compra_valor_tasa,0)
	,		CAP_MONE_ORIGEN             = isNull(mvto.compra_capital,0) 
	,		CAP_MONE_LOCAL              = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isNull(mvto.compra_capital,0)
												WHEN mon1.mnnemo = 'UF'		THEN isnull(mvto.compra_capital * vvm.vmvalor,0)        
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.compra_capital * vmon.Tipo_Cambio,0)             
												ELSE							 isnull(vmc.Tipo_Cambio * mvto.compra_capital,0)
											END

	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isnull(mvto.Res_Mesa_Dist_CLP,0)
												WHEN mon1.mnnemo = 'UF'		THEN isNull(mvto.Res_Mesa_Dist_CLP / vvm.vmvalor,0)
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.Res_Mesa_Dist_CLP / vmon.Tipo_Cambio,0)
											    ELSE							 isNull(mvto.Res_Mesa_Dist_USD,0)
											END
	,		MONTO_UTIL_LOCAL			= mvto.Res_Mesa_Dist_CLP
	,		OPERADOR					= mvto.operador

	FROM	(	SELECT	numero_operacion, tipo_flujo, numero_flujo, estado
					,	rut_cliente, codigo_cliente, operador
					,	fecha_cierre, fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo, fecha_fijacion_tasa
					,	compra_moneda, compra_capital, compra_codamo_interes, compra_codigo_tasa, compra_valor_tasa
					,	Res_Mesa_Dist_CLP, Res_Mesa_Dist_USD
				FROM	BacSwapSuda.dbo.MOVHISTORICO	with(nolock)
				WHERE ( fecha_cierre	>= @PrimerDiaMes AND fecha_cierre <= @UltimoDiaMes )
				AND     estado			<> 'C'
				AND		tipo_flujo		= 1
			)	mvto
			INNER JOIN ( SELECT  numero_operacion, tipo_flujo, numero_flujo, estado
							,	 rut_cliente, codigo_cliente, operador
							,	 fecha_cierre, fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo, fecha_fijacion_tasa
							,	 venta_moneda, venta_capital, venta_codamo_interes, venta_codigo_tasa, venta_valor_tasa
							,	 Res_Mesa_Dist_CLP, Res_Mesa_Dist_USD
						 FROM	 BacSwapSuda.dbo.MOVHISTORICO	with(nolock)
						 WHERE ( fecha_cierre	>= @PrimerDiaMes AND fecha_cierre <= @UltimoDiaMes )
						 AND     estado			<> 'C'
						 AND	 tipo_flujo		= 2
						)		 vent			ON	vent.numero_operacion	= mvto.numero_operacion
												AND vent.numero_flujo		= mvto.numero_flujo
												AND	vent.tipo_flujo			= 2
			INNER JOIN ( SELECT clrut, clcodigo, cldv, clnombre
						 FROM	BacParamSuda.dbo.CLIENTE					with(nolock)
						)		clie			ON	clie.clrut				= mvto.rut_cliente
												AND clie.clcodigo			= mvto.codigo_cliente
			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA						with(nolock)
						)		mon1			ON	mon1.mncodmon			= mvto.compra_moneda

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA						with(nolock)
						)		mon2			ON	mon2.mncodmon			= vent.venta_moneda
	
			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 994
						)		vmc				ON	vmc.Fecha				= mvto.fecha_inicio
--												AND vmc.Codigo_Moneda		= 994

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.valor_moneda				with(nolock)
						 WHERE	vmcodigo		= 998
						)		vvm				ON	vvm.vmfecha				= mvto.fecha_inicio
--												AND vvm.vmcodigo			= 998

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 129
						)		vmon			ON	vmon.Fecha				= mvto.fecha_inicio
--												AND vmon.Codigo_Moneda		= 129

	WHERE	mvto.tipo_flujo			= 1   
	AND		mvto.numero_flujo		=(	SELECT	MIN( ctlf.numero_flujo ) 
										FROM	BacSwapSuda.dbo.MOVHISTORICO ctlf         
										WHERE	ctlf.fecha_cierre		>= @PrimerDiaMes 
										AND     ctlf.fecha_cierre		<= @UltimoDiaMes 
										AND		ctlf.numero_operacion	 = mvto.numero_operacion 
										AND		ctlf.tipo_flujo			 = 1)

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
 unw.ResMesa           as ResMesa  ,
 his.operador  as Operador
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
 SET ResMesa  = ResMesa + MIS_CON_BAC_UTIL_TC_DIARIA.MONTO_UTIL_LOCAL,  
  MONTO_ORIGEN = MONTO_ORIGEN + MIS_CON_BAC_UTIL_TC_DIARIA.MONTO_UTIL_ORIGEN  
 FROM MIS_CON_BAC_UTIL_TC_DIARIA  
 WHERE MIS_CON_BAC_UTIL_TC_DIARIA.PRODUCT_TYPE_CD           = 'PCS'    
 AND MIS_CON_BAC_UTIL_TC_DIARIA.OPERACION = numero_operacion    
  
 DELETE FROM MIS_CON_BAC_UTIL_TC_DIARIA  
 WHERE OPERACION IN (SELECT numero_operacion FROM #TMP_CARTERA_ANTICIPO_SWAP)  
 AND PRODUCT_TYPE_CD = 'PCS'  
  
 INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA  
 SELECT * FROM #TMP_CARTERA_ANTICIPO_SWAP  
  
 drop table #TMP_CARTERA_ANTICIPO_SWAP  
  
      
        
    
   /***************************************SPOT/CAMBIOS***************************************/        
   /******************************************************************************************/        
   /* TABLA MEMO*/        
        
     INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA        
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
     CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END ,
	 mvto.mooper as OPERADOR   
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
	ctro.MoNumFolio as NumFolio,
	mooperador as Operador
   INTO #TMP3
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
	from #TMP3 
	group by NroOpe
	order by NroOpe

	INSERT INTO MIS_CON_BAC_UTIL_TC_DIARIA
	select MES_CONTABLE, SOURCE_ID, a.NroOpe ,PRODUCT_ID, ISO_COUNTRY, EMPRESA_ID, BRANCH_CD , CLIENTE_ID,
	FULL_NAME, FAMILIA, PRODUCT_TYPE_CD, FECHA_CONTABLE, FECHA_INTERFAZ, FECHA_APERTURA_OPERAC, FECHA_INICIO,
	FECHA_VCMTO, FECHA_RENOVACION, FECHA_PROX_CAMBIO_TASA, ISO_CURRENCY_CD, TIPO_MONEDA, TIPO_OPERACION,
	PERIODICIDAD, IND_TASA_TRANSFERENCIA, NRO_CUOTAS_FLUJO_SWAP, TASA_INTERES,TASA_TIPO_PARIDAD,
    CAP_MONE_ORIGEN, CAP_MONE_LOCAL, MONTO_UTIL_ORIGEN, MONTO_UTIL_LOCAL, OPERADOR
	FROM #TMP3 a, #MAX b where a.NroOpe = b.NroOpe
	AND a.NumFolio = b.NumFolio

	DROP TABLE #TMP3
	DROP TABLE #MAX
    DROP TABLE #AnuladasyAnticipadas  

        
 /************************************************************************************************************************/        
 /*INTERFAZ BAC */  

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
  'MONTO_UTIL_LOCAL'   + ';' + 
  'OPERADOR'    -- AS RESUMEN         

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
  LTRIM(RTRIM(CONVERT(CHAR(18),MONTO_UTIL_LOCAL))) + ';' + 
  LTRIM(RTRIM(OPERADOR))
 FROM  MIS_CON_BAC_UTIL_TC_DIARIA        
 --ORDER BY PRODUCT_TYPE_CD,OPERACION        
 --ORDER BY RESUMEN DESC        

select ltrim(rtrim(RESUMEN)) as RESUMEN FROM  #SALIDA ORDER BY RESUMEN DESC  

drop table #SALIDA
*/

-->	Adrian --> 

	SET NOCOUNT ON

/*
	DECLARE	@PrimerDiaMes		DATETIME
		SET @PrimerDiaMes		= CONVERT(DATETIME, SUBSTRING( CONVERT(CHAR(10), GETDATE(), 112), 1, 6) + '01')

	DECLARE	@UltimoDiaMes		DATETIME
		SET @UltimoDiaMes		= CONVERT(DATETIME, CONVERT(CHAR(10), GETDATE(), 112))

	TRUNCATE TABLE dbo.MIS_CON_BAC_UTIL_TC_DIARIA	--> dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	TRUNCATE TABLE dbo.MIS_CON_BAC_DET

	/***************************************************FORWARD*************************************************/
    /***********************************************************************************************************/

    INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA		--> MIS_CON_BAC_UTIL_TC_DIARIA        
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.mofecha,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.monumoper))
	,		PRODUCT_ID                  = 'MD10'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = clie.ID		--> LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))  
	,		FULL_NAME                   = clie.FNAME	--> LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'FWD'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.mofecha,	112) 
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.mofecvcto,	112)
	,		FECHA_RENOVACION            = SPACE(0) 
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8),mvto.moFecEfectiva,112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 =  CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'        
												WHEN mon1.mnnemo = 'UF'		THEN '2'        
												ELSE							 '3'        
											END
	,		TIPO_OPERACION              = mvto.motipoper 
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN mvto.mocodpos1 = 2  THEN	ISNULL(mvto.moparmon1, 0.0)
												WHEN mvto.mocodpos1 = 14 THEN	ISNULL(mvto.mopremon1, 0.0)
												ELSE							ISNULL(mvto.motipcam,  0.0)
											END
	,		CAP_MONE_ORIGEN             = mvto.momtomon1 
	,		CAP_MONE_LOCAL              = mvto.moequmon1

	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP' THEN	isnull(mvto.Resultado_Mesa,0)        
												WHEN mon1.mnnemo = 'UF'  THEN   isNull(mvto.Resultado_Mesa /mvto.motipcam,0)        
												WHEN mon1.mnnemo = 'USD' THEN   CASE	WHEN mvto.mocodpos1 = 14 THEN	isNull(mvto.Resultado_Mesa / mvto.mopremon1,0)        
																						ELSE							isNull(mvto.Resultado_Mesa / mvto.motipcam,0)        
																					END        
												ELSE							isNull((mvto.Resultado_Mesa / vvm.vmvalor) * mvto.moparmon1, 0)        
											END

	,		MONTO_UTIL_LOCAL			= CASE	WHEN mvto.mocodpos1 = 2	 THEN	ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)     
												ELSE							mvto.Resultado_Mesa    
											END
	,		OPERADOR					= mvto.mooperador
	FROM	BacFwdSuda.dbo.MFMOH		mvto with(nolock)
			INNER JOIN ( SELECT acfecante, acfecproc, acfecprox
						 FROM	BacFwdSuda.dbo.MFACH
						)		ctro						ON ctro.acfecproc	= mvto.mofecha

			INNER JOIN ( SELECT id_sistema, Codigo = codigo_producto, descripcion
						 FROM	BacParamSuda.dbo.PRODUCTO
						 WHERE	id_sistema	= 'BFW'
						)		prod						ON	prod.id_sistema	= 'BFW'
															AND prod.Codigo		= mvto.mocodpos1

			INNER JOIN ( SELECT clrut, clcodigo, cldv, clnombre
							,	ID	  = LTRIM(RTRIM(CONVERT(CHAR(10), Clrut)))+ LTRIM(RTRIM(Cldv))
							,	FNAME = LTRIM(RTRIM(Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(Clnombre))))
						 FROM	BacParamSuda.dbo.CLIENTE						with(nolock)
						)		clie						ON	clie.clrut      = mvto.mocodigo 
															AND clie.clcodigo	= mvto.mocodcli        
			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA							with(nolock)
						)		mon1						ON	mon1.mncodmon	= mvto.mocodmon1

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA							with(nolock)
						)		mon2						ON	mon2.mncodmon	= mvto.mocodmon2

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE			with(nolock)
						)		vcont						ON	vcont.fecha		= mvto.mofecha --> ctro.acfecante  
															AND vcont.codigo_moneda = 994

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.VALOR_MONEDA					with(nolock)
						)		vvm							ON	vvm.vmfecha		= mvto.mofecha 
															AND vvm.vmcodigo	= 998
	WHERE	mvto.moestado              <> 'A'    
	AND		mvto.mofecha              >= @PrimerDiaMes 
	AND		mvto.mofecha              <= @UltimoDiaMes        
	ORDER BY mvto.monumoper

	/*****************************************ANTICIPOS FORWARD ******************************************************/
	/*****************************************************************************************************************/
    
	SELECT	canumoper, cacodpos1,  catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2      
    ,		camtomon1, catipcam, caparmon1, caequmon1, caequusd1, caequmon2, capremon1, capremon2, capreant, caspread,   camtomon2      
	,		cafecha,   cafecvcto, cafecEfectiva, caestado,  caantici,  caoperador      
	,		precio_spot, caantptosfwd, caantptoscos      
	INTO	#TMP_CARTERA_ANTICIPO_FORWARD
	FROM	BacFwdsuda.dbo.MFCA   unw with(nolock)
	WHERE	unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes
    and		unw.caestado  <> 'A'
    and		unw.caantici   = 'A'

	INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD  
	SELECT  unw.canumoper, unw.cacodpos1, unw.catipoper, unw.catipmoda, unw.cacodigo,  unw.cacodcli, unw.cacodmon1, unw.cacodmon2  
	,		unw.camtomon1, unw.catipcam, unw.caparmon1, unw.caequmon1, unw.caequusd1, unw.caequmon2, unw.capremon1, unw.capremon2
	,		unw.capreant, unw.caspread,  unw.camtomon2  
	,		unw.cafecha,   unw.cafecvcto, unw.cafecEfectiva, unw.caestado,  unw.caantici,  unw.caoperador  
	,		res.precio_spot, caantptosfwd = res.caantptosfwd, caantptoscos=res.caantptoscos
	FROM	BacFwdsuda.dbo.MFCAh  unw with(nolock)  
			inner join BacFwdsuda.dbo.MFCARES res ON res.CaFechaProceso = unw.cafecvcto and res.canumoper = unw.canumoper
	WHERE	unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes  
	and		unw.caestado  <> 'A'
	and		unw.caantici  = 'A'  
	and		unw.canumoper  NOT IN(SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD) 

	UPDATE	#TMP_CARTERA_ANTICIPO_FORWARD
    SET		caspread			= caspread + mis.MONTO_UTIL_LOCAL
	,		precio_spot			= catipcam
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA	mis		--> MIS_CON_BAC_UTIL_TC_DIARIA         
    WHERE	mis.PRODUCT_TYPE_CD	= 'FWD'
    AND		mis.OPERACION		= canumoper

	DELETE
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA			--> MIS_CON_BAC_UTIL_TC_DIARIA
	WHERE	OPERACION			IN (SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)
	AND		PRODUCT_TYPE_CD		= 'FWD'

	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA		--> MIS_CON_BAC_UTIL_TC_DIARIA        
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),unw.cafecvcto,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(unw.canumoper))
	,		PRODUCT_ID                  = 'MD10'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), cli.clrut)))+ LTRIM(RTRIM(cli.cldv)) 
	,		FULL_NAME                   = LTRIM(RTRIM(cli.clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(cli.clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'FWD' 
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), unw.cafecvcto, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8),unw.cafecEfectiva,112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mn1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mn1.mnnemo = 'CLP' THEN '1'    
												WHEN mn1.mnnemo = 'UF'	THEN '2'    
												ELSE						 '3'
											END
	,		TIPO_OPERACION              = unw.catipoper
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0' 
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN unw.cacodpos1 = 2  or unw.cacodpos1 = 13	THEN	ISNULL(unw.capremon1, 0.0)                                           -- TASA_TIPO_PARIDAD    
												WHEN unw.cacodpos1 = 14							THEN	unw.precio_spot  + unw.caantptosfwd    
												ELSE													unw.precio_spot  + unw.caantptosfwd    
											END
	,		CAP_MONE_ORIGEN             = unw.camtomon1
	,		CAP_MONE_LOCAL              = unw.caequmon1
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mn1.mnnemo = 'CLP' THEN isnull(unw.caspread,0)
												WHEN mn1.mnnemo = 'UF'	THEN isNull(unw.caspread /unw.catipcam,0)
												WHEN mn1.mnnemo = 'USD' THEN CASE	WHEN unw.cacodpos1 = 14 THEN isNull(unw.caspread / unw.capremon1,0)
																					ELSE						 isNull(unw.caspread / unw.catipcam, 0)
																				END
												ELSE						 isNull((unw.caspread / vvm.vmvalor) * unw.caparmon1, 0)
											END
	,		MONTO_UTIL_LOCAL			= unw.caspread
	,		OPERADOR					= unw.caoperador
	FROM	#TMP_CARTERA_ANTICIPO_FORWARD unw

			INNER JOIN ( SELECT Id_Sistema, codigo = codigo_producto, descripcion
						 FROM	BacParamSuda.dbo.PRODUCTO		with(nolock)
						 WHERE	id_sistema	= 'BFW'
						)		pro			ON	pro.codigo			= unw.cacodpos1
			LEFT  JOIN ( SELECT clrut, clcodigo, cldv, clnombre
						 FROM	BacParamSuda.dbo.CLIENTE		with(nolock)
						)		cli			ON	cli.clrut		= unw.cacodigo
										and cli.clcodigo		= unw.cacodcli
			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA			with(nolock)
						)		mn1			ON	mn1.mncodmon	= unw.cacodmon1

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA			with(nolock)
						)		mn2			ON	mn2.mncodmon	= unw.cacodmon2

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						)		vvm			ON	vvm.vmfecha		= unw.cafecha 
											AND	vvm.vmcodigo	= 998

	DROP TABLE #TMP_CARTERA_ANTICIPO_FORWARD

   /****************************************************SWAP**********************************************************/        
   /*****************************************************************************************************************/        

	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA			-->		MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.fecha_cierre,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.numero_operacion))
	,		PRODUCT_ID                  = 'MD11'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'PCS'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.fecha_inicio, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.fecha_termino, 112) 
	,		FECHA_RENOVACION            = CONVERT(CHAR(8), mvto.fecha_vence_flujo, 112)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8), mvto.fecha_fijacion_tasa, 112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = 'C' 
	,		PERIODICIDAD_DE_FLUJOS      = LTRIM(RTRIM(mvto.compra_codamo_interes ))
	,		IND_TASA_TRANSFERENCIA      = LTRIM(RTRIM(mvto.compra_codigo_tasa))
	,		NRO_CUOTAS_FLUJO_SWAP       = LTRIM(RTRIM(( SELECT	MAX(mvto.numero_flujo) 
														FROM	BacSwapSuda.dbo.MOVHISTORICO MVTO 
														WHERE	mvto.numero_operacion = vent.NUMERO_OPERACION )))

	,		TASA_INTERES                = isNull(MVTO.compra_valor_tasa,0)
	,		TASA_TIPO_PARIDAD           = isNUll(mvto.compra_valor_tasa,0)
	,		CAP_MONE_ORIGEN             = isNull(mvto.compra_capital,0) 
	,		CAP_MONE_LOCAL              = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isNull(mvto.compra_capital,0)
												WHEN mon1.mnnemo = 'UF'		THEN isnull(mvto.compra_capital * vvm.vmvalor,0)        
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.compra_capital * vmon.Tipo_Cambio,0)             
												ELSE							 isnull(vmc.Tipo_Cambio * mvto.compra_capital,0)
											END

	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isnull(mvto.Res_Mesa_Dist_CLP,0)
												WHEN mon1.mnnemo = 'UF'		THEN isNull(mvto.Res_Mesa_Dist_CLP / vvm.vmvalor,0)
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.Res_Mesa_Dist_CLP / vmon.Tipo_Cambio,0)
											    ELSE							 isNull(mvto.Res_Mesa_Dist_USD,0)
											END
	,		MONTO_UTIL_LOCAL			= mvto.Res_Mesa_Dist_CLP
	,		OPERADOR					= mvto.operador

	FROM	(	SELECT	numero_operacion, tipo_flujo, numero_flujo, estado
					,	rut_cliente, codigo_cliente, operador
					,	fecha_cierre, fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo, fecha_fijacion_tasa
					,	compra_moneda, compra_capital, compra_codamo_interes, compra_codigo_tasa, compra_valor_tasa
					,	Res_Mesa_Dist_CLP, Res_Mesa_Dist_USD
				FROM	BacSwapSuda.dbo.MOVHISTORICO	with(nolock)
				WHERE ( fecha_cierre	>= @PrimerDiaMes AND fecha_cierre <= @UltimoDiaMes )
				AND     estado			<> 'C'
				AND		tipo_flujo		= 1
			)	mvto

			INNER JOIN ( SELECT  numero_operacion, tipo_flujo, numero_flujo, estado
							,	 rut_cliente, codigo_cliente, operador
							,	 fecha_cierre, fecha_inicio, fecha_termino, fecha_inicio_flujo, fecha_vence_flujo, fecha_fijacion_tasa
							,	 venta_moneda, venta_capital, venta_codamo_interes, venta_codigo_tasa, venta_valor_tasa
							,	 Res_Mesa_Dist_CLP, Res_Mesa_Dist_USD
						 FROM	 BacSwapSuda.dbo.MOVHISTORICO	with(nolock)
						 WHERE ( fecha_cierre	>= @PrimerDiaMes AND fecha_cierre <= @UltimoDiaMes )
						 AND     estado			<> 'C'
						 AND	 tipo_flujo		= 2
						)		 vent			ON	vent.numero_operacion	= mvto.numero_operacion
												AND vent.numero_flujo		= mvto.numero_flujo
												AND	vent.tipo_flujo			= 2

			INNER JOIN ( SELECT clrut, clcodigo, cldv, clnombre
						 FROM	BacParamSuda.dbo.CLIENTE					with(nolock)
						)		clie			ON	clie.clrut				= mvto.rut_cliente
												AND clie.clcodigo			= mvto.codigo_cliente

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA						with(nolock)
						)		mon1			ON	mon1.mncodmon			= mvto.compra_moneda

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA						with(nolock)
						)		mon2			ON	mon2.mncodmon			= vent.venta_moneda
	
			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 994
						)		vmc				ON	vmc.Fecha				= mvto.fecha_inicio
--												AND vmc.Codigo_Moneda		= 994

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.valor_moneda				with(nolock)
						 WHERE	vmcodigo		= 998
						)		vvm				ON	vvm.vmfecha				= mvto.fecha_inicio
--												AND vvm.vmcodigo			= 998

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 129
						)		vmon			ON	vmon.Fecha				= mvto.fecha_inicio
--												AND vmon.Codigo_Moneda		= 129

	WHERE	mvto.tipo_flujo			= 1   
	AND		mvto.numero_flujo		=(	SELECT	MIN( ctlf.numero_flujo ) 
										FROM	BacSwapSuda.dbo.MOVHISTORICO ctlf         
										WHERE	ctlf.fecha_cierre		>= @PrimerDiaMes 
										AND     ctlf.fecha_cierre		<= @UltimoDiaMes 
										AND		ctlf.numero_operacion	 = mvto.numero_operacion 
										AND		ctlf.tipo_flujo			 = 1)

	ORDER BY mvto.numero_operacion
        
        
	/**************************************************  SWAP  **********************************************************/  
	/************************************************  ANTICIPOS  *******************************************************/  

	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),his.fecha_termino,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(his.numero_operacion))
	,		PRODUCT_ID                  = 'MD11'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Rut)))+ LTRIM(RTRIM(clie.Dv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Nombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Nombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'PCS'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_RENOVACION            = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8), his.fecha_termino, 112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3'
											END
	,		TIPO_OPERACION              = 'C'
	,		PERIODICIDAD_DE_FLUJOS      = LTRIM(RTRIM(his.compra_codamo_interes ))
	,		IND_TASA_TRANSFERENCIA      = LTRIM(RTRIM(his.compra_codigo_tasa))
	,		NRO_CUOTAS_FLUJO_SWAP       = LTRIM(RTRIM((	SELECT	MAX(mvth.numero_flujo)
														FROM	BacSwapSuda.dbo.CARTERAHIS mvth
														WHERE	mvth.NUMERO_OPERACION = his.NUMERO_OPERACION)))
	,		TASA_INTERES                = isNull(his.compra_valor_tasa,0)
	,		TASA_TIPO_PARIDAD           = isNUll(his.compra_valor_tasa,0)
	,		CAP_MONE_ORIGEN             = isNull(his.compra_capital,0)
	,		CAP_MONE_LOCAL              = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isNull(his.compra_capital,0)
												WHEN mon1.mnnemo = 'UF'		THEN isnull(his.compra_capital	* vvm.vmvalor,0)
												WHEN mon1.mnnemo = 'COP'	THEN isnull(his.compra_capital	* vmon.Tipo_Cambio,0)
												ELSE							 isnull(vmc.Tipo_Cambio		* his.compra_capital,0)
											END
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isnull(Anticipo.Monto,0)					--> unw.ResMesa
												WHEN mon1.mnnemo = 'UF'		THEN isNull(Anticipo.Monto / vvm.vmvalor,0)		--> unw.ResMesa
												WHEN mon1.mnnemo = 'COP'	THEN isnull(Anticipo.Monto / vmon.Tipo_Cambio,0)--> unw.ResMesa
												ELSE							 isNull(Anticipo.Monto / vmc.Tipo_Cambio,0)	--> unw.ResMesa
											END
	,		MONTO_UTIL_LOCAL			= Anticipo.Monto			--> unw.ResMesa
	,		OPERADOR					= Anticipo.operador			-->	his.operador
	INTO	#TMP_CARTERA_ANTICIPO_SWAP
	from	BacSwapSuda.dbo.CarteraHis His	with(nolock)
			inner join (	select	numero_operacion, numero_flujo, tipo_flujo, venta_capital, venta_valor_tasa, venta_moneda
							from	BacSwapSuda.dbo.CarteraHis	with(nolock)
						)	Venta	On	Venta.numero_operacion = His.numero_operacion
									and	Venta.numero_flujo     = His.numero_flujo
									and	Venta.tipo_flujo       = 2

			inner join (	select		Contrato		= Numero_Operacion
							,			Flujo			= Min( Numero_Flujo ) - 1
							,			Tipo			= Tipo_Flujo
							,			Monto			= Min( Devengo_Recibido_Mda_Val )
							,			operador		= Min( operador )
							,			FechaAnticipo	= FechaAnticipo
							from		BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
							where		FechaAnticipo	BETWEEN @PrimerDiaMes AND @UltimoDiaMes
							and			Tipo_Flujo		= 1
							group by	Numero_Operacion, Tipo_Flujo, FechaAnticipo
						)	Anticipo	On	Anticipo.Contrato	= His.Numero_Operacion
										and	Anticipo.Flujo		= His.Numero_Flujo
										and	Anticipo.Tipo		= His.Tipo_Flujo

			inner join	(	select Producto		=	Case	when codigo_producto = 'ST' then 1
															when codigo_producto = 'SM' then 2
															when codigo_producto = 'FR' then 3
															when codigo_producto = 'SP' then 4
													end
							,		Glosa		=	Descripcion
							from	BacParamSuda.dbo.Producto	with(nolock)
							where	Id_Sistema	= 'PCS'
						)	Prod	On Prod.Producto = His.tipo_swap

			inner join  (	select	Rut			= clrut
								,	Codigo		= clcodigo
								,	Dv			= cldv
								,	Nombre		= clnombre
							from	BacParamSuda.dbo.Cliente	with(nolock)
						)	Clie	On 	Clie.Rut = His.Rut_Cliente and Clie.codigo = His.Codigo_Cliente

			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = his.compra_moneda
			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = Venta.venta_moneda

			LEFT JOIN ( SELECT	fecha, codigo_moneda, tipo_cambio
						FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
						)		vmc						ON	vmc.Fecha			= his.fecha_inicio 
														AND vmc.Codigo_Moneda	= 994

			LEFT JOIN (	SELECT	vmfecha, vmcodigo, vmvalor
						FROM	BacParamSuda.dbo.VALOR_MONEDA 
						)		vvm						ON	vvm.vmfecha			= his.fecha_inicio 
														AND vvm.vmcodigo		= 998

			LEFT JOIN (	SELECT	fecha, codigo_moneda, tipo_cambio
						FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE 
						)		vmon					ON	vmon.Fecha			= his.fecha_inicio 
														AND vmon.Codigo_Moneda	= 129 -- COP
	where	His.Tipo_Flujo			= 1
	and		His.Estado				<> ''

	UPDATE	#TMP_CARTERA_ANTICIPO_SWAP
	SET		MONTO_UTIL_LOCAL	= #TMP_CARTERA_ANTICIPO_SWAP.MONTO_UTIL_LOCAL	+ mis.MONTO_UTIL_LOCAL
	,		MONTO_UTIL_ORIGEN	= #TMP_CARTERA_ANTICIPO_SWAP.MONTO_UTIL_ORIGEN	+ mis.MONTO_UTIL_ORIGEN
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA	mis			-->	dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	WHERE	mis.PRODUCT_TYPE_CD	= 'PCS'
	AND		mis.OPERACION		= #TMP_CARTERA_ANTICIPO_SWAP.OPERACION

	DELETE	
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA				--> dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	WHERE	OPERACION		IN (SELECT OPERACION FROM #TMP_CARTERA_ANTICIPO_SWAP)  
	AND		PRODUCT_TYPE_CD = 'PCS'  

	INSERT INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA			-->	dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT * FROM #TMP_CARTERA_ANTICIPO_SWAP

	DROP TABLE #TMP_CARTERA_ANTICIPO_SWAP
    
   /***************************************SPOT/CAMBIOS***************************************/        
   /******************************************************************************************/        

    INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.mofech,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.monumope))
	,		PRODUCT_ID                  = 'MD14'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie. Cldv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Clnombre)) + SPACE(80 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'BCC'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM( mvto.mocodmon ))
	,		TIPO_MONEDA                 = CASE	WHEN mvto.mocodmon = 'CLP'	THEN '1'
												WHEN mvto.mocodmon = 'UF'	THEN '2'
												ELSE							 '3'
											END
	,		TIPO_OPERACION              = mvto.motipope
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN mvto.motipmer IN('ARBI', 'EMPR') and mvto.mocodcnv <> 'CLP' THEN  ISNULL(mvto.moparme, 0.0) 
												ELSE ISNULL(mvto.moticam,0.0)
											END
	,		CAP_MONE_ORIGEN             = mvto.momonmo
	,		CAP_MONE_LOCAL              = mvto.momonpe
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mvto.mocodmon = 'CLP'	THEN	isnull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END,0)
												WHEN mvto.mocodmon = 'UF'	THEN	isNull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)
												WHEN mvto.mocodmon = 'USD'	THEN	isNull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)
												ELSE								isNull((CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam) * mvto.moparme, 0)
										   END
	,		MONTO_UTIL_LOCAL			= CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END
	,		OPERADOR					= mvto.mooper
	FROM	(	select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
				,		cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
				,		morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memoh	with(nolock)
				where	mofech		BETWEEN @PrimerDiaMes and @UltimoDiaMes
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
			)	mvto			

				INNER JOIN ( SELECT clrut, cldv, clcodigo, clnombre
							 FROM	BacParamSuda.dbo.CLIENTE		with(nolock)
							)		clie				ON clie.clrut = mvto.morutcli AND clie.clcodigo = mvto.mocodcli

	WHERE	mvto.monumope	NOT IN (SELECT monumope FROM BacCamSuda.dbo.MEMOH WHERE mooper		= 'CAVENDANO' AND moDifTran_Clp = 0 )  
	AND		mvto.monumope	NOT IN (SELECT monumope FROM BacCamSuda.dbo.MEMOH WHERE morutcli	= '96665450'  AND moDifTran_Clp = 0 )        
	ORDER BY mvto.monumope        


	-- ************************************************************************** --
	-- *********************   O P C I O N E S    ******************************* --
	-- ************************************************************************** --

    INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	MES_CONTABLE			=	CONVERT(CHAR(6),Retorno.MoFechaContrato,112)
	,		SOURCE_ID				=	'MI59'
	,		OPERACION				=	LTRIM(RTRIM(Retorno.MoNumContrato))
	,		PRODUCT_ID				=	'MD15'
	,		ISO_COUNTRY				=	'CL'
	,		EMPRESA_ID				=	'001'
	,		BRANCH_CD				=	'001'
	,		CLIENTE_ID				=	Retorno.Rut
	,		FULL_NAME				=	Retorno.Nombre
	,		FAMILIA					=	'MDIR'
	,		PRODUCT_TYPE_CD			=	'OPC'
	,		FECHA_CONTABLE			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_INTERFAZ			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_APERTURA_OPERAC	=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_INICIO			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_VCMTO				=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_RENOVACION		=	SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA	=	SPACE(0)
	,		ISO_CURRENCY_CD			=	Retorno.MonTransada
	,		TIPO_MONEDA				=	CASE	WHEN Retorno.MonTransada	= 'CLP'			THEN '1'
												WHEN Retorno.MonTransada	= 'UF'			THEN '2'
												ELSE											 '3'
											END
	,		TIPO_OPERACION			=	CASE	WHEN Retorno.MoVinculacion	= 'Individual'	THEN Retorno.MoCvOpc
												ELSE											 ''
											END
	,		PERIODICIDAD_DE_FLUJOS	=	'00000'
	,		IND_TASA_TRANSFERENCIA	=	SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP	=	'0'
	,		TASA_INTERES			=	0.0
	,		TASA_TIPO_PARIDAD		=	Retorno.Strike
	,		CAP_MONE_ORIGEN			=	Retorno.MoMontoMon1
	,		CAP_MONE_LOCAL			=	Retorno.MoMontoMon2
	,		MONTO_UTIL_ORIGEN		=	Retorno.ResultadoMo
	,		MONTO_UTIL_LOCAL		=	Retorno.ResultadoMl
	,		OPERADOR				=	Retorno.mooperador
	FROM	(	select	MoNumContrato		= mov.monumcontrato
				,		mooperador			= mov.mooperador
				,		MoResultadoVentasML	= mov.moresultadoventasml
				,		MoFechaContrato		= mov.mofechacontrato
				,		MoRutCliente		= mov.morutcliente
				,		MoCodigo			= mov.mocodigo
				,		MoCallPut			= Detalle.mocallput
				,		MoStrike			= Detalle.mostrike
				,		MoVinculacion		= Detalle.movinculacion
				,		MoCVOpc				= Detalle.mocvopc
				,		MoMontoMon1			= Detalle.momontomon1
				,		MoMontoMon2			= Detalle.momontomon2
				,		MonTransada			= mon1.mnnemo
				,		MonConversion		= mon2.mnnemo
				,		MoRelacionaPAE		= mov.morelacionapae
				,		mocodestructura		= mov.mocodestructura
				,		MoFechaInicioOpc	= Detalle.mofechainicioopc
				,		MoNumFolio			= mov.monumfolio
				,		ResultadoMl			= grupo.ResultadoMl
				,		ResultadoMo			= grupo.ResultadoDo
				,		Strike				= grupo.Strike
				,		Rut					= convert(char(10), clie.cRut	 )
				,		Nombre				= convert(char(60), clie.cNombre )
				from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	mov	with(nolock)
						inner join (	select	 monumcontrato		= movimiento.monumcontrato
										,		 monumfolio			= max( movimiento.monumfolio )
										,		 ResultadoMl		= sum( movimiento.moresultadoventasml )
										,		 ResultadoDo		= sum( movimiento.moresultadoventasml / DetInt.mostrike )
										,		 Strike				= avg( DetInt.mostrike )
										from	 LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	movimiento	with(nolock)

												 inner join (	select	monumfolio, mostrike
																from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato
																where	monumestructura	= 1
															)	DetInt	On DetInt.monumfolio = movimiento.monumfolio

										where	(mofechacontrato	between @PrimerDiaMes and @UltimoDiaMes)
										and	not	(movimiento.moestado			= 'C')
										and	not	(movimiento.motipotransaccion	in('anula', 'ejerce'))
										and		(movimiento.monumcontrato		not in (	select	monumcontrato 
																							from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato
																							where	mofechacontrato		between @PrimerDiaMes and @UltimoDiaMes
																							and		moTipoTransaccion	IN( 'anula', 'ejerce' )
																						)	)
										group by movimiento.monumcontrato
									)	grupo	On	grupo.monumcontrato		=	mov.monumcontrato
												and grupo.monumfolio		=	mov.monumfolio

						 inner join (	select	monumfolio			= monumfolio
										,		mostrike			= mostrike
										,		mocallput			= mocallput
										,		movinculacion		= movinculacion
										,		mocvopc				= mocvopc
										,		momontomon1			= momontomon1
										,		momontomon2			= momontomon2
										,		mocodmon1			= mocodmon1
										,		mocodmon2			= mocodmon2
										,		mofechainicioopc	= mofechainicioopc
										from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato
										where	monumestructura	= 1
									)	Detalle	On Detalle.monumfolio = mov.monumfolio

						left  join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)			mon1			On	mon1.mncodmon	= Detalle.mocodmon1
						left  join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)			mon2			On	mon2.mncodmon	= Detalle.mocodmon2

						left  join (	select	clrut		= clrut
											,	clcodigo	= clcodigo
											,	cRut		= ltrim(rtrim( convert(char(10), clrut) )) + ltrim(rtrim( cldv ))
											,	cNombre		= ltrim(rtrim( clnombre )) + space( 60 - len( ltrim(rtrim( clnombre )) ) )
										from	BacParamSuda.dbo.cliente with(nolock)
									)			clie			On	clie.clrut		= mov.MoRutCliente
																and clie.clcodigo	= mov.MoCodigo
				where	grupo.ResultadoMl <> 0
			)	Retorno
	order by Retorno.monumcontrato

	/**************************************************************************************/
	/****************************** S P O T     W E B *************************************/
	/**************************************************************************************/

	-->		SPOT WEB	<--
	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	MES_CONTABLE                = convert( char(6), opx.Fecha, 112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = ltrim(rtrim( opx.FolioContrato ))
	,		PRODUCT_ID                  = 'MD14'	--> Mantiene el Codigo de Producto de los Spot.
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = cli.clienteid
	,		FULL_NAME                   = cli.fullname
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'SPW'		--> 'BCC'	
	,		FECHA_CONTABLE              = convert( char(8), opx.Fecha, 112)
	,		FECHA_INTERFAZ              = convert( char(8), opx.Fecha, 112)
	,		FECHA_APERTURA_OPERAC       = convert( char(8), opx.Fecha, 112)
	,		FECHA_INICIO                = convert( char(8), opx.Fecha, 112)
	,		FECHA_VCMTO                 = convert( char(8), opx.Fecha, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = opx.TipoTransaccion
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = opx.TipoCambio
	,		CAP_MONE_ORIGEN             = opx.MtoDolares
	,		CAP_MONE_LOCAL              = opx.MtoPesos
	,		MONTO_UTIL_ORIGEN           = (ROUND(opx.SpreadComercial * opx.MtoDolares, 0) / opx.TipoCambio)
	,		MONTO_UTIL_LOCAL			=  ROUND(opx.SpreadComercial * opx.MtoDolares, 0)
	,		OPERADOR					= 'E-Bank'
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
			inner join 	(	select	clrut		= clie.clrut
								,	clienteid	= LTRIM(RTRIM(CONVERT(CHAR(10), clie.clrut )))+ LTRIM(RTRIM( clie.cldv ))  
								,	fullname    = LTRIM(RTRIM( clie.clnombre )) + SPACE(60 - LEN(LTRIM(RTRIM( clie.clnombre ))))
							from	BacParamSuda.dbo.CLIENTE	clie	with(nolock)
									inner join (	select	clrut, cldv = MIN( cldv )
													from	BacParamSuda.dbo.Cliente	with(nolock)
													group by clrut 
												)	grpcli		On grpcli.clrut = clie.clrut and grpcli.cldv = clie.cldv
						)	cli		On	cli.clrut		=	opx.RutCliente

			left join	(	select	mncodmon, mnnemo	
							from	BacParamSuda.dbo.MONEDA	with(nolock)
						)	mon1	On	mon1.mncodmon	=	13
	WHERE  opx.Fecha	BETWEEN @PrimerDiaMes AND @UltimoDiaMes

	/**************************************************************************************/
	/******************** R E N T A   F I J A   N A C I O N A L ***************************/
	/**************************************************************************************/

	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	MES_CONTABLE                = convert(char(6), Movto.mofecpro, 112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = ltrim(rtrim( Movto.monumoper ))	-->	Deberia ser compuesto (Operacion + Correla + Documento)
	,		PRODUCT_ID                  = 'MD16'							--> Se debe definir el Codigo del Producto
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = Clie.clienteid
	,		FULL_NAME                   = Clie.fullname
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'BTR'								--> Indicador de Renta Fija
	,		FECHA_CONTABLE              = convert(char(8), Movto.mofecpro, 112)
	,		FECHA_INTERFAZ              = convert(char(8), Movto.mofecpro, 112)
	,		FECHA_APERTURA_OPERAC       = convert(char(8), Movto.mofecpro, 112)
	,		FECHA_INICIO                = isnull(CASE	WHEN Movto.motipoper IN('CP',' VP') THEN convert(char(8), Movto.mofecpro,	112)
														WHEN Movto.motipoper IN('CI', 'VI') THEN convert(char(8), Movto.mofecinip,	112)
													END, convert(char(8), Movto.mofecpro,	112))
	,		FECHA_VCMTO                 = case	when Movto.motipoper = 'CP' then SPACE(0)
												else							 convert(char(8), FechaVcto, 112)
											end
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = substring(Mone.mnnemo, 1,3)
	,		TIPO_MONEDA                 = Mone.tipmon
	,		TIPO_OPERACION              = substring(Movto.motipoper, 1, 1)
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = 0
	,		TASA_INTERES                = 0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN Movto.motipoper IN('CP', 'VP') THEN	Movto.motir
												WHEN Movto.motipoper IN('CI', 'VI') THEN	Movto.motaspact
											END
	,		CAP_MONE_ORIGEN             = CASE	WHEN Movto.motipoper IN('VI', 'VP')	THEN	Movto.movalven 
												ELSE										Movto.movpresen 
											END
	,		CAP_MONE_LOCAL              = CASE	WHEN Movto.motipoper IN('VI', 'VP')	THEN	Movto.movalven 
												ELSE										Movto.movpresen 
											END
	,		MONTO_UTIL_ORIGEN           = case	when Movto.moDifTran_CLP = 0 then 0 
												else isnull(Movto.moDifTran_CLP / vmvalor,0.0)
											end
	,		MONTO_UTIL_LOCAL			= Movto.moDifTran_CLP
	,		OPERADOR					= ltrim(rtrim( Movto.mousuario ))

	FROM	(	select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motir	 * movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact * movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	moDifTran_CLP	= MAX( moDifTran_CLP )
					,	Moneda			= momonpact
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecvenp )
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CI', 'VI')
				and		mostatreg  <> 'A'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonpact
					,	mofecinip

				union all

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen	 )
					,	motir			= SUM( motir	* movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact* movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran* movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven		 )
					,	moDifTran_CLP	= SUM( moDifTran_CLP )
					,	Moneda			= momonemi
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecven  )
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CP', 'VP', 'IB' )
				and		mostatreg  <> 'A'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonemi
					,	mofecinip
			)	Movto
			inner join  (	select	clrut
							,		clcodigo
							,		cldv
							,		clienteid	= LTRIM(RTRIM(CONVERT(CHAR(10), clrut )))+ LTRIM(RTRIM( cldv ))
							,		fullname    = LTRIM(RTRIM( clnombre )) + SPACE(60 - LEN(LTRIM(RTRIM( clnombre ))))
							from	BacParamSuda.dbo.CLIENTE with(nolock)
						)	Clie	On		Clie.clrut		= Movto.morutcli 
									and		Clie.clcodigo	= Movto.mocodcli        

			inner join	(	select	mncodmon
							,		mnnemo	= ltrim(rtrim( mnnemo ))
							,		tipmon	= CASE	WHEN mnnemo = 'CLP'	THEN '1'
													WHEN mnnemo = 'UF'	THEN '2'
													ELSE					 '3' END
							from	BacParamSuda.dbo.MONEDA	with(nolock)
						)	Mone	On	Mone.mncodmon = Movto.Moneda 

			inner join	(	select	vmfecha,	vmcodigo,	vmvalor
							from	BacParamSuda.dbo.Valor_Moneda
							union	
							select	vmfecha,	999,		1.0
							from	BacParamSuda.dbo.Valor_Moneda
							where	vmcodigo	= 994
							union
							select	vmfecha,	13,			vmvalor
							from	BacParamSuda.dbo.Valor_Moneda
							where	vmcodigo	= 994
						)	nvalmon	On	nvalmon.vmfecha	 =	CASE	WHEN Movto.motipoper IN('CP', 'VP')	THEN Movto.mofecpro
																	WHEN Movto.motipoper IN('CI', 'VI')	THEN Movto.mofecinip
																END	
									and	nvalmon.vmcodigo =	Mone.mncodmon
	        
	/************************************************************************************************************************/        
	/*INTERFAZ BAC */


	--		  *****************
	--		  INICIO      NUEVO
	--		  *****************

	-->		 inserto a tabkla temporal fisica
	INSERT	INTO dbo.MIS_CON_BAC_DET
			SELECT * FROM dbo.MIS_CON_BAC_UTIL_TC_DIARIA

	-->		 Limpio la tabla final
	TRUNCATE TABLE dbo.MIS_CON_BAC_UTIL_TC_DIARIA

	-->		 Inserto los productos que no son MD16 y MD15
	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	mis.*
	FROM	dbo.MIS_CON_BAC_DET mis
			inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
							from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
							where	tbcateg					= 9000
						)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = mis.OPERADOR
	WHERE	LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD16'
	and		LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD15'

	-->		 Inserto los productos MD16
	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	mis.*
	FROM	dbo.MIS_CON_BAC_DET mis
			inner join (	select	DISTINCT OPERADOR_MDISTRIBUCION	= tbglosa 
							from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
							where	tbcateg					= 9000
						)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = mis.OPERADOR
	WHERE	LTRIM(RTRIM( mis.PRODUCT_ID	))  =	'MD16'	--> Fltro de Usuarios, aplica para todo a excepción de Renta Fija

	-->		 Inserto los productos MD15
	INSERT	INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	SELECT	mis.*
	FROM	dbo.MIS_CON_BAC_DET mis
	WHERE	mis.PRODUCT_ID		=	'MD15'	--> Fltro de Usuarios, No aplica para Opciones (Se informan Todas las Operaciones)

	--		  *****************
	--		  TERMINO	  NUEVO
	--		  *****************

*/


	TRUNCATE TABLE dbo.MIS_CON_BAC_UTIL_TC_DIARIA

	EXECUTE dbo.SP_LOAD_DATA_MIS 0 --> Proceso Diario

	CREATE TABLE #SALIDA 
		(	RESUMEN		CHAR(1000)	)

	--		  *****************
	--		  SE INICIA EL AJUSTA DE SALIDA
	--		  *****************

	INSERT	INTO #SALIDA
	SELECT  'MES_CONTABLE'				+ ';' +
			'SOURCE_ID'					+ ';' +
			'OPERACION'					+ ';' +
			'PRODUCT_ID'				+ ';' +
			'ISO_COUNTRY'				+ ';' +
			'EMPRESA_ID'				+ ';' +
			'BRANCH_CD'					+ ';' +
			'CLIENTE_ID'				+ ';' +
			'FULL_NAME'					+ ';' +
			'FAMILIA'					+ ';' +
			'PRODUCT_TYPE_CD'			+ ';' +
			'FECHA_CONTABLE'			+ ';' +
			'FECHA_INTERFAZ'			+ ';' +
			'FECHA_APERTURA_OPERAC'		+ ';' +
			'FECHA_INICIO'				+ ';' +
			'FECHA_VCMTO'				+ ';' +
			'FECHA_RENOVACION'			+ ';' +
			'FECHA_PROX_CAMBIO_TASA'	+ ';' +
			'ISO_CURRENCY_CD'			+ ';' +
			'TIPO_MONEDA'				+ ';' +
			'TIPO_OPERACION'			+ ';' +
			'PERIODICIDAD_DE_FLUJOS'	+ ';' +
			'IND_TASA_TRANSFERENCIA'	+ ';' +
			'NRO_CUOTAS_FLUJO_SWAP'		+ ';' +
			'TASA_INTERES'				+ ';' +
			'TASA_TIPO_PARIDAD'			+ ';' +
			'CAP_MONE_ORIGEN'			+ ';' +
			'CAP_MONE_LOCAL'			+ ';' +
			'MONTO_UTIL_ORIGEN'			+ ';' +
			'MONTO_UTIL_LOCAL'			+ ';' +
			'OPERADOR'

	INSERT  INTO #SALIDA
	SELECT	LTRIM(RTRIM(MES_CONTABLE))								+ ';' +
			LTRIM(RTRIM(SOURCE_ID))									+ ';' +
			LTRIM(RTRIM(OPERACION))									+ ';' +
			LTRIM(RTRIM(PRODUCT_ID))								+ ';' +
			LTRIM(RTRIM(ISO_COUNTRY))								+ ';' +
			LTRIM(RTRIM(EMPRESA_ID))								+ ';' +
			LTRIM(RTRIM(BRANCH_CD))									+ ';' +
			LTRIM(RTRIM(CLIENTE_ID))								+ ';' +
			LTRIM(RTRIM(FULL_NAME))									+ ';' +
			LTRIM(RTRIM(FAMILIA))									+ ';' +
			LTRIM(RTRIM(PRODUCT_TYPE_CD))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(8),FECHA_CONTABLE,112)))		+ ';' +
			LTRIM(RTRIM(FECHA_INTERFAZ))							+ ';' +
			LTRIM(RTRIM(FECHA_APERTURA_OPERAC))						+ ';' +
			LTRIM(RTRIM(FECHA_INICIO))								+ ';' +
			LTRIM(RTRIM(FECHA_VCMTO))								+ ';' +
			LTRIM(RTRIM(FECHA_RENOVACION))							+ ';' +
			LTRIM(RTRIM(FECHA_PROX_CAMBIO_TASA))					+ ';' +
			LTRIM(RTRIM(ISO_CURRENCY_CD))							+ ';' +
			LTRIM(RTRIM(TIPO_MONEDA))								+ ';' +
			LTRIM(RTRIM(TIPO_OPERACION))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),PERIODICIDAD_DE_FLUJOS)))  + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),IND_TASA_TRANSFERENCIA)))	+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),NRO_CUOTAS_FLUJO_SWAP)))   + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_INTERES)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_TIPO_PARIDAD)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_ORIGEN)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_LOCAL)))			+ ';' +
			LTRIM(RTRIM(MONTO_UTIL_ORIGEN))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),MONTO_UTIL_LOCAL)))		+ ';' +
			LTRIM(RTRIM(OPERADOR))
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA				-->		tabla antes filtrada

	--		  *****************
	--		  FINALIZA EL AJUSTA DE SALIDA
	--		  *****************

/*
	INSERT	INTO #SALIDA
	SELECT  'MES_CONTABLE'				+ ';' +
			'SOURCE_ID'					+ ';' +
			'OPERACION'					+ ';' +
			'PRODUCT_ID'				+ ';' +
			'ISO_COUNTRY'				+ ';' +
			'EMPRESA_ID'				+ ';' +
			'BRANCH_CD'					+ ';' +
			'CLIENTE_ID'				+ ';' +
			'FULL_NAME'					+ ';' +
			'FAMILIA'					+ ';' +
			'PRODUCT_TYPE_CD'			+ ';' +
			'FECHA_CONTABLE'			+ ';' +
			'FECHA_INTERFAZ'			+ ';' +
			'FECHA_APERTURA_OPERAC'		+ ';' +
			'FECHA_INICIO'				+ ';' +
			'FECHA_VCMTO'				+ ';' +
			'FECHA_RENOVACION'			+ ';' +
			'FECHA_PROX_CAMBIO_TASA'	+ ';' +
			'ISO_CURRENCY_CD'			+ ';' +
			'TIPO_MONEDA'				+ ';' +
			'TIPO_OPERACION'			+ ';' +
			'PERIODICIDAD_DE_FLUJOS'	+ ';' +
			'IND_TASA_TRANSFERENCIA'	+ ';' +
			'NRO_CUOTAS_FLUJO_SWAP'		+ ';' +
			'TASA_INTERES'				+ ';' +
			'TASA_TIPO_PARIDAD'			+ ';' +
			'CAP_MONE_ORIGEN'			+ ';' +
			'CAP_MONE_LOCAL'			+ ';' +
			'MONTO_UTIL_ORIGEN'			+ ';' +
			'MONTO_UTIL_LOCAL'			+ ';' +
			'OPERADOR'

	INSERT  INTO #SALIDA
	SELECT	LTRIM(RTRIM(MES_CONTABLE))								+ ';' +
			LTRIM(RTRIM(SOURCE_ID))									+ ';' +
			LTRIM(RTRIM(OPERACION))									+ ';' +
			LTRIM(RTRIM(PRODUCT_ID))								+ ';' +
			LTRIM(RTRIM(ISO_COUNTRY))								+ ';' +
			LTRIM(RTRIM(EMPRESA_ID))								+ ';' +
			LTRIM(RTRIM(BRANCH_CD))									+ ';' +
			LTRIM(RTRIM(CLIENTE_ID))								+ ';' +
			LTRIM(RTRIM(FULL_NAME))									+ ';' +
			LTRIM(RTRIM(FAMILIA))									+ ';' +
			LTRIM(RTRIM(PRODUCT_TYPE_CD))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(8),FECHA_CONTABLE,112)))		+ ';' +
			LTRIM(RTRIM(FECHA_INTERFAZ))							+ ';' +
			LTRIM(RTRIM(FECHA_APERTURA_OPERAC))						+ ';' +
			LTRIM(RTRIM(FECHA_INICIO))								+ ';' +
			LTRIM(RTRIM(FECHA_VCMTO))								+ ';' +
			LTRIM(RTRIM(FECHA_RENOVACION))							+ ';' +
			LTRIM(RTRIM(FECHA_PROX_CAMBIO_TASA))					+ ';' +
			LTRIM(RTRIM(ISO_CURRENCY_CD))							+ ';' +
			LTRIM(RTRIM(TIPO_MONEDA))								+ ';' +
			LTRIM(RTRIM(TIPO_OPERACION))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),PERIODICIDAD_DE_FLUJOS)))  + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),IND_TASA_TRANSFERENCIA)))	+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),NRO_CUOTAS_FLUJO_SWAP)))   + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_INTERES)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_TIPO_PARIDAD)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_ORIGEN)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_LOCAL)))			+ ';' +
			LTRIM(RTRIM(MONTO_UTIL_ORIGEN))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),MONTO_UTIL_LOCAL)))		+ ';' +
			LTRIM(RTRIM(OPERADOR))
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA
			inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
							from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
							where	tbcateg					= 9000
						)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = OPERADOR
	WHERE	LTRIM(RTRIM( PRODUCT_ID	))  <>	'MD16'
	and		LTRIM(RTRIM( PRODUCT_ID	))  <>	'MD15'

	INSERT	INTO #SALIDA
	SELECT	LTRIM(RTRIM(MES_CONTABLE))								+ ';' +
			LTRIM(RTRIM(SOURCE_ID))									+ ';' +
			LTRIM(RTRIM(OPERACION))									+ ';' +
			LTRIM(RTRIM(PRODUCT_ID))								+ ';' +
			LTRIM(RTRIM(ISO_COUNTRY))								+ ';' +
			LTRIM(RTRIM(EMPRESA_ID))								+ ';' +
			LTRIM(RTRIM(BRANCH_CD))									+ ';' +
			LTRIM(RTRIM(CLIENTE_ID))								+ ';' +
			LTRIM(RTRIM(FULL_NAME))									+ ';' +
			LTRIM(RTRIM(FAMILIA))									+ ';' +
			LTRIM(RTRIM(PRODUCT_TYPE_CD))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(8),FECHA_CONTABLE,112)))		+ ';' +
			LTRIM(RTRIM(FECHA_INTERFAZ))							+ ';' +
			LTRIM(RTRIM(FECHA_APERTURA_OPERAC))						+ ';' +
			LTRIM(RTRIM(FECHA_INICIO))								+ ';' +
			LTRIM(RTRIM(FECHA_VCMTO))								+ ';' +
			LTRIM(RTRIM(FECHA_RENOVACION))							+ ';' +
			LTRIM(RTRIM(FECHA_PROX_CAMBIO_TASA))					+ ';' +
			LTRIM(RTRIM(ISO_CURRENCY_CD))							+ ';' +
			LTRIM(RTRIM(TIPO_MONEDA))								+ ';' +
			LTRIM(RTRIM(TIPO_OPERACION))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18), PERIODICIDAD_DE_FLUJOS					)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18), IND_TASA_TRANSFERENCIA					)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18), NRO_CUOTAS_FLUJO_SWAP						)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18), TASA_INTERES								)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18), TASA_TIPO_PARIDAD							)))		+ ';' +
			ltrim(rtrim(convert(char(18), convert(numeric(18,0), CAP_MONE_ORIGEN	))))	+ ';' +
			ltrim(rtrim(convert(char(18), convert(numeric(18,0), CAP_MONE_LOCAL		))))	+ ';' +
			ltrim(rtrim(convert(char(18), convert(numeric(18,0), MONTO_UTIL_ORIGEN  ))))	+ ';' +
			ltrim(rtrim(convert(char(18), convert(numeric(18,0), MONTO_UTIL_LOCAL   ))))	+ ';' +
			LTRIM(RTRIM(OPERADOR))
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA
			inner join (	select	DISTINCT OPERADOR_MDISTRIBUCION	= tbglosa 
							from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
							where	tbcateg					= 9000
						)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = OPERADOR
	WHERE	LTRIM(RTRIM( PRODUCT_ID	))  =	'MD16'	--> Fltro de Usuarios, aplica para todo a excepción de Renta Fija


	INSERT	INTO #SALIDA
	SELECT	LTRIM(RTRIM(MES_CONTABLE))								+ ';' +
			LTRIM(RTRIM(SOURCE_ID))									+ ';' +
			LTRIM(RTRIM(OPERACION))									+ ';' +
			LTRIM(RTRIM(PRODUCT_ID))								+ ';' +
			LTRIM(RTRIM(ISO_COUNTRY))								+ ';' +
			LTRIM(RTRIM(EMPRESA_ID))								+ ';' +
			LTRIM(RTRIM(BRANCH_CD))									+ ';' +
			LTRIM(RTRIM(CLIENTE_ID))								+ ';' +
			LTRIM(RTRIM(FULL_NAME))									+ ';' +
			LTRIM(RTRIM(FAMILIA))									+ ';' +
			LTRIM(RTRIM(PRODUCT_TYPE_CD))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(8),FECHA_CONTABLE,112)))		+ ';' +
			LTRIM(RTRIM(FECHA_INTERFAZ))							+ ';' +
			LTRIM(RTRIM(FECHA_APERTURA_OPERAC))						+ ';' +
			LTRIM(RTRIM(FECHA_INICIO))								+ ';' +
			LTRIM(RTRIM(FECHA_VCMTO))								+ ';' +
			LTRIM(RTRIM(FECHA_RENOVACION))							+ ';' +
			LTRIM(RTRIM(FECHA_PROX_CAMBIO_TASA))					+ ';' +
			LTRIM(RTRIM(ISO_CURRENCY_CD))							+ ';' +
			LTRIM(RTRIM(TIPO_MONEDA))								+ ';' +
			LTRIM(RTRIM(TIPO_OPERACION))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),PERIODICIDAD_DE_FLUJOS)))  + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),IND_TASA_TRANSFERENCIA)))	+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),NRO_CUOTAS_FLUJO_SWAP)))   + ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_INTERES)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),TASA_TIPO_PARIDAD)))		+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_ORIGEN)))			+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),CAP_MONE_LOCAL)))			+ ';' +
			LTRIM(RTRIM(MONTO_UTIL_ORIGEN))							+ ';' +
			LTRIM(RTRIM(CONVERT(CHAR(18),MONTO_UTIL_LOCAL)))		+ ';' +
			LTRIM(RTRIM(OPERADOR))
	FROM	dbo.MIS_CON_BAC_UTIL_TC_DIARIA
	WHERE	PRODUCT_ID		=	'MD15'	--> Fltro de Usuarios, No aplica para Opciones (Se informan Todas las Operaciones)
*/

	SELECT		LTRIM(RTRIM(RESUMEN)) as RESUMEN 
	FROM		#SALIDA 
	ORDER BY	RESUMEN DESC

	DROP TABLE #SALIDA

END
GO

USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_GENERA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_GENERA] (        
 @fecha_consulta DATETIME = ''        
,@miles   CHAR(10) = 1000        
,@t_camb_rtc  CHAR(7) = ''        
,@t_camb_ny  CHAR(7) = ''        
,@fecha_prox  CHAR(8) =''        
)        
AS        
BEGIN        
 SET NOCOUNT ON        
 DECLARE @fecha CHAR(8)         
        
 DECLARE @sc_activo  FLOAT         
 DECLARE @sc_act_vcto FLOAT        
 DECLARE @sc_pasivo  FLOAT        
 DECLARE @sc_pas_vcto FLOAT        
        
-- PRD12720 
 DECLARE @do_activo  FLOAT       
 DECLARE @do_act_vcto FLOAT      
 DECLARE @do_pasivo  FLOAT      
 DECLARE @do_pas_vcto FLOAT      
 DECLARE @do_delta	FLOAT
-- PRD12720 
      
 DECLARE @ar_activo FLOAT        
 DECLARE @ar_act_vcto FLOAT        
 DECLARE @ar_pasivo  FLOAT        
 DECLARE @ar_pas_vcto FLOAT        
        
 DECLARE @pcs_activo FLOAT        
 DECLARE @pcs_pasivo FLOAT        
        
 DECLARE @opc_activo FLOAT        
 DECLARE @opc_pasivo FLOAT        
        
 DECLARE @ar_activomx FLOAT        
 DECLARE @ar_act_vctomx FLOAT        
 DECLARE @ar_pasivomx  FLOAT        
 DECLARE @ar_pas_vctomx FLOAT        
        
 SELECT  @fecha = CONVERT(CHAR(8),@fecha_consulta,112)        
        
 -->DERIVADOS        
 -->Seguro de Cambio        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','1','C','A','USD','','', @sc_activo  OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','1','C','A','USD','', @fecha, @sc_act_vcto OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','1','V','P','USD','','', @sc_pasivo OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','1','V','P','USD','', @fecha, @sc_pas_vcto OUT        
        
 --> PRD12720
 --> Dolar Observado = 14 Starting
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','14','C','A','USD','','', @do_activo  OUT      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','14','C','A','USD','', @fecha, @do_act_vcto OUT      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','14','V','P','USD','','', @do_pasivo OUT      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','14','V','P','USD','', @fecha, @do_pas_vcto OUT      

 SET @do_delta = 0.0
 EXECUTE DBO.sp_hedge_carga_campoUSD '4','14','C','A','USD','','', @do_delta  OUT      

-- print '@do_activo = ' + convert(varchar(20),@do_activo)
-- print '@do_act_vcto = ' + convert(varchar(20),@do_act_vcto)
-- print '@do_pasivo = ' + convert(varchar(20),@do_pasivo)
-- print '@do_pas_vcto = ' + convert(varchar(20),@do_pas_vcto)
-- print '@do_delta = ' + convert(varchar(20),@do_delta)

 --> PRD12720
    
 -->Arbitraje        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','V','A','','USD','', @ar_activo OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','V','A','','USD', @fecha, @ar_act_vcto OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','C','P','','USD','' , @ar_pasivo OUT          
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','C','P','','USD', @fecha, @ar_pas_vcto OUT          
        
 -->Swap        
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','A','','USD', @fecha, @pcs_activo OUT, 'compra_moneda'          
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','P','','USD', @fecha, @pcs_pasivo OUT ,'venta_moneda'           
         
 -->Opciones        
 EXECUTE DBO.sp_hedge_carga_campoUSD '3','0','C','A','USD','','', @opc_activo OUT         
 EXECUTE DBO.sp_hedge_carga_campoUSD '3','0','C','P','USD','','', @opc_pasivo OUT          
        
 -->Se llena datos de moneda extranjera en temporal        
 CREATE TABLE #MONEDASMX (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (15))        
        
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','C','A','MX','','','ARB_Activo_MX','mnnemo1'        
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','C','A','MX','',@fecha ,'ARB_Act_Vcto_MX','mnnemo1'         
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','V','P','MX','','','ARB_Pasivo_MX','mnnemo1'        
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','V','P','MX','',@fecha  ,'ARB_Pas_Vcto_MX','mnnemo1'  
         
 -->Swap Moneda Extranjera        
 EXECUTE DBO.sp_hedge_carga_campoMX '2','0','C','A','MX','','','PCS_Activo','compra_moneda'        
 EXECUTE DBO.sp_hedge_carga_campoMX '2','0','C','P','MX','','','PCS_Pasivo','venta_moneda'        
        
 CREATE TABLE #RESULTADO_GENERAL (producto CHAR(20), codigo CHAR(4), valor FLOAT, spot FLOAT)        
        
 INSERT INTO #RESULTADO_GENERAL        
 SELECT  'PRODUCTO' = 'DERIVADOS',        
  'MONEDAS'  = nemo_moneda,        
  'SCAMBIO_USD' = ((((@SC_Activo  - @SC_Act_Vcto)/tipo_cambio)-((@SC_Pasivo  - @SC_Pas_Vcto)/tipo_cambio))         
	-- PRD12720	
	+ (((@do_Activo  - @do_Act_Vcto)/tipo_cambio)-((@do_Pasivo  - @do_Pas_Vcto)/tipo_cambio)) + (@do_delta) -- (@do_delta * tipo_cambio)
	-- PRD12720	
    +(((@AR_Activo - @AR_Act_Vcto)/tipo_cambio)-((@AR_Pasivo - @AR_Pas_Vcto)/tipo_cambio))        
    +((@PCS_Activo - @PCS_Pasivo)/tipo_cambio)+ (@OPC_Activo + @OPC_Pasivo))/@MILES,        
            
           
  'VALOR_MONEDA' = tipo_cambio        
 FROM  TBL_HEDGE_MONEDAS WITH(NOLOCK)        
 WHERE  nemo_moneda = 'USD'        
        
 UNION ALL        
        
 SELECT  'DERIVADOS',        
  codigo,        
   ((((((   SUM(CASE descripcion  WHEN  'ARB_Activo_MX ' THEN valor/tipo_cambio ELSE 0 END))-           
           (SUM(CASE descripcion  WHEN  'ARB_Act_Vcto_MX' THEN valor/tipo_cambio ELSE 0 END)))        
   -        
    (( SUM(CASE descripcion  WHEN  'ARB_Pasivo_MX' THEN valor/tipo_cambio ELSE 0 END))-        
   ( SUM(CASE descripcion  WHEN  'ARB_Pas_Vcto_MX' THEN valor/tipo_cambio ELSE 0 END))))        
           
   +        
   ((( SUM(CASE descripcion  WHEN  'PCS_Activo' THEN valor/tipo_cambio ELSE 0 END))-        
   ( SUM(CASE descripcion  WHEN  'PCS_Pasivo' THEN valor/tipo_cambio ELSE 0 END))))))/@MILES) total        
  ,tipo_cambio        
 FROM #MONEDASMX ,tbl_hedge_monedas WITH(NOLOCK)        
 WHERE #MONEDASMX.codigo = TBL_HEDGE_MONEDAS.nemo_moneda       
  AND codigo <> 'USD'      
 GROUP BY codigo,tipo_cambio         
        
 -->SP_HEDGE_CON_POS_CAMB_SPOT        
        
 DECLARE @OPERACION_PAS CHAR(30);        
 SET @OPERACION_PAS = (SELECT DISTINCT VARIABLE        
 FROM TBL_HEDGE_MANT WITH(NOLOCK)        
 WHERE Cod_Origen = 4         
 AND Tipo_Valor = 'P')        
        
 DECLARE @OPERACION_ACT CHAR(30);        
 SET @OPERACION_ACT = (SELECT DISTINCT VARIABLE        
 FROM TBL_HEDGE_MANT WITH(NOLOCK)        
 WHERE Cod_Origen = 4         
 AND Tipo_Valor = 'A')        
        
         
        
 --DECLARE @OPERACION_PAS CHAR(30);        
 --DECLARE @OPERACION_ACT CHAR(30);        
        
 --EXECUTE TBL_HEDGE_OBT_CAMPO 4,'P', @OPERACION_PAS OUT        
 --EXECUTE TBL_HEDGE_OBT_CAMPO 4,'A', @OPERACION_ACT OUT        
        
 CREATE TABLE #MONEDASSPOT (codigo  CHAR(4), valor FLOAT, spot FLOAT)        
        
 INSERT #MONEDASSPOT        
 EXECUTE(' SELECT ''MONEDAS'' = TBL_HEDGE_MONEDAS.NEMO_MONEDA,        
   ''POS_CAMBIO''  = (SUM (CASE TIPO_VALOR WHEN ''P''THEN('+  @OPERACION_PAS +' )/'''+ @MILES +''' ELSE 0 END))-        
      (SUM (CASE TIPO_VALOR WHEN ''A''THEN(' + @OPERACION_ACT + ')/'''+ @MILES +''' ELSE 0 END)),        
   ''PARIDAD''  =  TBL_HEDGE_MONEDAS.SPOTCOMPRA        
 FROM  TBL_HEDGE_MDIV  WITH(NOLOCK)        
 ,  TBL_HEDGE_MONEDAS WITH(NOLOCK)        
 ,  TBL_HEDGE_MANT  WITH(NOLOCK)        
 WHERE  TBL_HEDGE_MONEDAS.NEMO_MONEDA  = TBL_HEDGE_MDIV.MONEDA        
 AND  TBL_HEDGE_MDIV.CUENTA  = TBL_HEDGE_MANT.CUENTA_CONTABLE        
 AND  TBL_HEDGE_MDIV.MONEDA  = TBL_HEDGE_MANT.MONEDA        
 AND  TBL_HEDGE_MANT.COD_ORIGEN = 4        
 AND  TBL_HEDGE_MDIV.FECHA_PROCESO = '''+ @fecha +'''         
 GROUP BY TBL_HEDGE_MONEDAS.NEMO_MONEDA,TBL_HEDGE_MONEDAS.SPOTCOMPRA          
 ')         
        
        
 INSERT INTO #RESULTADO_GENERAL        
 SELECT 'SPOT',* FROM #MONEDASSPOT        
        
 -->SP_HEDGE_CON_OP_PEND_CURSE 
 CREATE TABLE #OP_PENDIENTE_CURSE (codigo CHAR(4), valor FLOAT)        
        
 INSERT INTO #OP_PENDIENTE_CURSE         
 SELECT  MONEDA         
 ,  (SUM(monto_compra)-SUM(monto_venta))/ @miles AS VALOR         
 FROM  TBL_HEDGE_INGRESO_MANUAL WITH(NOLOCK)        
 WHERE  moneda = 'USD'         
 AND  fecha_proceso = @fecha        
 GROUP BY moneda         
        
 INSERT INTO #OP_PENDIENTE_CURSE         
 SELECT  moneda        
 , (SUM(monto_compra)-SUM(monto_venta))/@MILES AS VALOR         
 FROM  TBL_HEDGE_INGRESO_MANUAL WITH(NOLOCK)        
 WHERE  moneda <> 'USD'         
 AND  fecha_proceso = @fecha        
 GROUP BY moneda        
        
        
 CREATE TABLE  #OP_PENDIENTE (CODIGO CHAR(4),VALOR FLOAT, PARIDAD FLOAT)        
 -->Inicio        
 INSERT INTO #OP_PENDIENTE          
  SELECT    CASE WHEN codigo = 'EUR' OR codigo ='GBP' THEN 'USD' ELSE 'USD' END CODIGO        
  ,  ((CASE WHEN codigo = 'USD' THEN  valor ELSE 0 END)-         
    (CASE WHEN codigo = 'EUR' THEN  valor * spotcompra ELSE 0 END)-        
     (CASE WHEN codigo = 'GBP' THEN  valor * spotcompra ELSE 0 END)) AS VALOR        
  , SPOTCOMPRA        
  FROM  #OP_PENDIENTE_CURSE, TBL_HEDGE_MONEDAS WITH(NOLOCK)        
  WHERE  #OP_PENDIENTE_CURSE.codigo = TBL_HEDGE_MONEDAS.NEMO_MONEDA         
  GROUP BY codigo,valor,spotcompra         
        
 UNION        
  SELECT  CODIGO        
  ,  VALOR        
  , SPOTCOMPRA        
  FROM  #OP_PENDIENTE_CURSE,TBL_HEDGE_MONEDAS WITH(NOLOCK)        
  WHERE  #OP_PENDIENTE_CURSE.CODIGO = TBL_HEDGE_MONEDAS.NEMO_MONEDA         
  AND  CODIGO <> 'USD'        
  GROUP BY codigo,valor,spotcompra         
        
 INSERT INTO #RESULTADO_GENERAL        
 SELECT  'OPPENDCURSE', CODIGO, SUM(VALOR) AS VALOR,0.0        
 FROM #OP_PENDIENTE         
 GROUP BY CODIGO        
        
 -->SP_HEDGE_CON_PARTIDA_RTC        
 DECLARE @OP_ACT_DEBE CHAR(30);        
 DECLARE @OP_ACT_HABER CHAR(30);        
 DECLARE @OP_PAS_DEBE CHAR(30);        
 DECLARE @OP_PAS_HABER CHAR(30);        
 DECLARE @OP_ACT_NY CHAR(30);        
 DECLARE @OP_PAS_NY CHAR(30);        
        
 SET @OP_ACT_DEBE =  (SELECT DISTINCT VARIABLE         
     FROM TBL_HEDGE_MANT  WITH(NOLOCK)        
      WHERE   Cod_Origen = 6         
       AND  Tipo_Valor = 'A'         
       AND imputacion = 'A'        
    )        
         
 SET @OP_ACT_HABER =  (SELECT DISTINCT VARIABLE        
      FROM  TBL_HEDGE_MANT  WITH(NOLOCK)        
      WHERE   Cod_Origen = 6         
       AND  Tipo_Valor = 'P'         
       AND imputacion = 'P'        
    )        
 SET @OP_PAS_DEBE =  (SELECT DISTINCT VARIABLE        
      FROM  TBL_HEDGE_MANT  WITH(NOLOCK)        
       WHERE  Cod_Origen = 6         
       AND  Tipo_Valor = 'A'         
       AND imputacion = 'A'        
    )        
        
 SET @OP_PAS_HABER =  (SELECT DISTINCT VARIABLE        
      FROM  TBL_HEDGE_MANT  WITH(NOLOCK)        
       WHERE  Cod_Origen = 6         
       AND  Tipo_Valor = 'P'         
       AND imputacion = 'P'        
    )        
        
 SET @OP_ACT_NY =  (SELECT DISTINCT VARIABLE        
      FROM  TBL_HEDGE_MANT  WITH(NOLOCK)        
       WHERE  Cod_Origen = 6         
       AND  Tipo_Valor = 'A'         
       AND imputacion = 'A'        
       AND cod_producto = 5        
    )        
 SET @OP_PAS_NY =  (SELECT DISTINCT VARIABLE        
      FROM  TBL_HEDGE_MANT  WITH(NOLOCK)        
       WHERE  Cod_Origen = 6         
       AND  Tipo_Valor = 'P'         
       AND imputacion = 'P'        
       AND cod_producto = 5        
    )        
        
 CREATE TABLE #PARTIDA_RTC (CODIGO CHAR(4),TOTAL FLOAT, DESCRIPCION CHAR (20))        
        
 INSERT INTO #PARTIDA_RTC        
 EXECUTE ('        
  SELECT    TBL_HEDGE_MCLP.MONEDA        
   ,(SUM(('+@OP_ACT_DEBE+'/'''+@T_CAMB_RTC+''')/'''+@MILES+'''))-(SUM(('+@OP_ACT_HABER+'/'''+@T_CAMB_RTC+''')/'''+@MILES+''')) AS TOTAL        
   ,''TOTAL_ACTIVO''        
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)        
  , TBL_HEDGE_MCLP WITH(NOLOCK)        
  , TBL_HEDGE_MANT WITH(NOLOCK)        
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE         
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO        
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''        
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen = 6        
AND (TBL_HEDGE_MANT.COD_PRODUCTO <> 5 AND TBL_HEDGE_MANT.COD_PRODUCTO <> 6)  
  GROUP BY TBL_HEDGE_MCLP.MONEDA')        
        
         
 INSERT INTO  #PARTIDA_RTC        
 EXECUTE ('SELECT TBL_HEDGE_MCLP.MONEDA,(SUM(('+@OP_PAS_HABER+'/'''+@T_CAMB_RTC+''')/'''+@MILES+'''))-        
  (SUM(('+@OP_PAS_DEBE+'/'''+@T_CAMB_RTC+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_PASIVO''        
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)        
  , TBL_HEDGE_MCLP WITH(NOLOCK)        
  , TBL_HEDGE_MANT WITH(NOLOCK)        
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE         
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO        
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''P''         
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen = 6        
AND (TBL_HEDGE_MANT.COD_PRODUCTO <> 5 AND TBL_HEDGE_MANT.COD_PRODUCTO <> 6)  
  GROUP         
  BY TBL_HEDGE_MCLP.MONEDA')        
        
-------------------------------------------------------------   
 --> 1.0 Solo para Inversiones utiliza TC NY se reemplaza @T_CAMB_RTC por @T_CAMB_NY  
 --> Activo   
INSERT INTO #PARTIDA_RTC      
 EXECUTE ('      
  SELECT    TBL_HEDGE_MCLP.MONEDA      
   ,(SUM(('+@OP_ACT_DEBE+'/'''+@T_CAMB_NY+''')/'''+@MILES+'''))-(SUM(('+@OP_ACT_HABER+'/'''+@T_CAMB_NY+''')/'''+@MILES+''')) AS TOTAL      
   ,''TOTAL_ACTIVO''    
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)    
  , TBL_HEDGE_MCLP WITH(NOLOCK)      
  , TBL_HEDGE_MANT WITH(NOLOCK)      
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE       
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO      
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''      
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen = 6      
  AND TBL_HEDGE_MANT.COD_PRODUCTO    = 6  
  GROUP BY TBL_HEDGE_MCLP.MONEDA')      
      
--> Pasivo  
 INSERT INTO  #PARTIDA_RTC      
 EXECUTE ('SELECT TBL_HEDGE_MCLP.MONEDA,(SUM(('+@OP_PAS_HABER+'/'''+@T_CAMB_NY+''')/'''+@MILES+'''))-      
  (SUM(('+@OP_PAS_DEBE+'/'''+@T_CAMB_NY+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_PASIVO''      
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)      
  , TBL_HEDGE_MCLP WITH(NOLOCK)      
  , TBL_HEDGE_MANT WITH(NOLOCK)      
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE       
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO      
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''P''       
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen  = 6  
  AND TBL_HEDGE_MANT.COD_PRODUCTO  = 6  
  GROUP       
  BY TBL_HEDGE_MCLP.MONEDA')      
  
--> 1.0 Solo para Inversiones utiliza TC NY  
-------------------------------------------------------------  
      
 INSERT INTO #PARTIDA_RTC        
 EXECUTE (' SELECT TBL_HEDGE_MCLP.MONEDA,        
  ((SUM(CASE TBL_HEDGE_MANT.TIPO_VALOR WHEN ''A''THEN ('+@OP_ACT_NY+' /'''+@T_CAMB_NY+''')/'''+@MILES+''' ELSE 0 END))-        
   (SUM(CASE TBL_HEDGE_MANT.TIPO_VALOR WHEN ''P''THEN  ('+@OP_PAS_NY+' /'''+@T_CAMB_NY+''')/'''+@MILES+''' ELSE 0 END)))AS TOTAL,''DESC_NY_A''        
  FROM  TBL_HEDGE_MCLP WITH(NOLOCK)        
  , TBL_HEDGE_MANT WITH(NOLOCK)         
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE         
  AND TBL_HEDGE_MANT.COD_PRODUCTO = 5        
  --AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''        
  GROUP        
  BY TBL_HEDGE_MCLP.MONEDA ')        
        
         
 INSERT INTO #RESULTADO_GENERAL        
 SELECT   'PARTIDASRTC'        
  ,CASE WHEN CODIGO = 'CLP' THEN 'USD'ELSE CODIGO END AS CODIGO        
  ,(SUM(CASE DESCRIPCION WHEN 'TOTAL_ACTIVO'THEN TOTAL ELSE 0 END))        
   -(SUM(CASE DESCRIPCION WHEN 'TOTAL_PASIVO'THEN TOTAL ELSE 0 END))+        
    (SUM(CASE DESCRIPCION WHEN 'DESC_NY_A'THEN TOTAL ELSE 0 END ))        
  ,0.0         
 FROM  #PARTIDA_RTC        
 GROUP BY CODIGO          
        
 -->SP_HEDGE_CON_VENC_COMPEN_DO        
        
 DECLARE @OPERACION_COMPRA_MX CHAR(30);        
 SET @OPERACION_COMPRA_MX =     ISNULL((SELECT DISTINCT VARIABLE        
     FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
     , TBL_HEDGE_MANT B WITH(NOLOCK)        
     WHERE  A.MNNEMO1 = B.MONEDA        
     AND A.CATIPOPER ='C'        
     AND A.CATIPMODA = 'C'        
     AND A.MNNEMO1 <>'USD'        
     AND A.CACODPOS1= 2        
     AND B.IMPUTACION = 'A'        
     AND B.Cod_Origen = 1),0)        
         
 DECLARE @OPERACION_VENTA_MX CHAR(30);        
 SET @OPERACION_VENTA_MX =      ISNULL((SELECT DISTINCT VARIABLE        
     FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
     , TBL_HEDGE_MANT B WITH(NOLOCK)        
     WHERE  A.MNNEMO1 = B.MONEDA        
     AND A.CATIPOPER ='V'        
     AND A.CATIPMODA = 'C'        
     AND A.MNNEMO1 <>'USD'        
     AND A.CACODPOS1= 2        
     AND B.IMPUTACION = 'P'        
     AND B.Cod_Origen = 1),0)        
        
        
 DECLARE @OPERACION_COMPRA_DO CHAR(30);        
 SET @OPERACION_COMPRA_DO =  ISNULL((SELECT DISTINCT B.VARIABLE        
     FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
     , TBL_HEDGE_MANT B WITH(NOLOCK)        
     WHERE  A.MNNEMO1 = B.MONEDA        
     AND A.CATIPOPER ='C'        
     AND A.CATIPMODA = 'C'        
     AND A.MNNEMO1 ='USD'        
     AND B.IMPUTACION = 'A'        
     AND B.Cod_Origen = 1),0)        
         
 DECLARE @OPERACION_VENTA_DO CHAR(30);        
 SET @OPERACION_VENTA_DO =  ISNULL((SELECT DISTINCT B.VARIABLE        
     FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
     , TBL_HEDGE_MANT B WITH(NOLOCK)        
     WHERE  A.MNNEMO1 = B.MONEDA       
     AND A.CATIPOPER ='V'        
     AND A.CATIPMODA = 'C'        
     AND A.MNNEMO1 ='USD'        
     AND B.IMPUTACION = 'P'        
     AND B.Cod_Origen = 1),0)        
        
        
 CREATE TABLE #VENC_COMPEN_DO (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (20))        
 INSERT INTO #VENC_COMPEN_DO        
 EXECUTE('        
 SELECT CASE WHEN mnnemo1 <>''USD''THEN ''USD'' END CODIGO        
 , CASE WHEN mnnemo1 = ''EUR''OR mnnemo1 = ''GBP'' THEN         
  (SUM('+@OPERACION_COMPRA_MX+')* SPOTCOMPRA) ELSE (SUM('+@OPERACION_COMPRA_MX+')/SPOTCOMPRA) END AS VALOR        
 , ''COMPRA_VCTOS_MX''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 , TBL_HEDGE_MONEDAS WITH(NOLOCK)        
 WHERE TBL_HEDGE_FWD. mnnemo1 = TBL_HEDGE_MONEDAS.NEMO_MONEDA        
 AND catipoper  = ''C''         
 AND mnnemo1  <> ''USD''         
 AND  cacodpos1  = 2         
 AND caFechaProceso  ='''+@FECHA+'''         
 AND  cafecvcto  = '''+@FECHA_PROX+'''        
 AND catipmoda  = ''C''           
 GROUP BY mnnemo1, SPOTCOMPRA')        
        
 INSERT INTO #VENC_COMPEN_DO        
 EXECUTE('        
 SELECT CASE WHEN mnnemo1 <> ''USD''THEN ''USD'' END CODIGO        
 ,  CASE WHEN mnnemo1 = ''EUR''OR mnnemo1 = ''GBP'' THEN         
  (SUM('+ @OPERACION_VENTA_MX+')* SPOTCOMPRA) ELSE (SUM('+@OPERACION_VENTA_MX+')/SPOTCOMPRA) END AS VALOR        
 , ''VENTA_VCTOS_MX''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 , TBL_HEDGE_MONEDAS WITH(NOLOCK)        
 WHERE TBL_HEDGE_FWD. mnnemo1 = TBL_HEDGE_MONEDAS.NEMO_MONEDA        
 AND catipoper = ''V''         
 AND  mnnemo1 <> ''USD''         
 AND  cacodpos1 =2         
 AND caFechaProceso  ='''+@FECHA+'''         
 AND  cafecvcto  = '''+@FECHA_PROX+'''        
 AND catipmoda = ''C''           
 GROUP         
 BY  mnnemo1 , SPOTCOMPRA')        
        
 INSERT INTO #VENC_COMPEN_DO        
 EXECUTE('SELECT mnnemo1        
 , SUM('+@OPERACION_COMPRA_DO+') AS VALOR        
 , ''COMPRA_VCTO_DO''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 WHERE catipoper = ''C''         
 AND  mnnemo1 = ''USD''        
 AND caFechaProceso ='''+@FECHA+'''         
 AND  cafecvcto = '''+@FECHA_PROX+'''        
 AND catipmoda = ''C''        
 GROUP BY mnnemo1')        
        
 INSERT INTO #VENC_COMPEN_DO        
 EXECUTE ('        
  SELECT mnnemo1        
 , SUM('+@OPERACION_VENTA_DO+') AS VALOR        
 , ''VENTA_VCTO_DO''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 WHERE catipoper = ''V''         
 AND  mnnemo1 =''USD''        
 AND caFechaProceso ='''+@FECHA+'''         
 AND  cafecvcto = '''+@FECHA_PROX+'''        
 AND catipmoda = ''C''         
 GROUP BY mnnemo1')        
        
 INSERT INTO #RESULTADO_GENERAL        
 SELECT  'VCTOSCOMPADO'        
 , CODIGO        
 ,  ((((SUM (CASE DESCRIPCION  WHEN 'COMPRA_VCTO_DO' THEN VALOR ELSE 0 END))-(SUM (CASE DESCRIPCION WHEN 'VENTA_VCTO_DO ' THEN VALOR ELSE 0 END)))*-1)        
  -(((SUM (CASE DESCRIPCION WHEN 'COMPRA_VCTOS_MX' THEN VALOR ELSE 0 END))-(SUM (CASE DESCRIPCION WHEN 'VENTA_VCTOS_MX' THEN VALOR ELSE 0 END))) *-1))/@MILES AS VALOR        
 , 0.0        
 FROM  #VENC_COMPEN_DO         
 GROUP BY CODIGO        
          
 ---DROP TABLE #VENC_COMPEN_DO         
        
 -->SP_HEDGE_CON_VENC_COMPENSADO_MX        
        
 DECLARE @OPERACION_COMPRA CHAR(30);        
 SET @OPERACION_COMPRA = ISNULL((SELECT  DISTINCT VARIABLE        
    FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
    , TBL_HEDGE_MANT B WITH(NOLOCK)        
    WHERE  A.MNNEMO1 = B.MONEDA        
    AND B.TIPO_OPE ='C'        
    AND B.MONEDA <>'USD'        
    AND A.CACODPOS1= 2         
    AND A.CATIPMODA = 'C'        
    AND B.IMPUTACION = 'A'        
    AND B.COD_ORIGEN = 1),0)        
         
 DECLARE @OPERACION_VENTA CHAR(30);        
 SET @OPERACION_VENTA =  ISNULL((SELECT  DISTINCT B.VARIABLE        
    FROM  TBL_HEDGE_FWD A WITH(NOLOCK)        
    , TBL_HEDGE_MANT B WITH(NOLOCK)        
    WHERE  A.MNNEMO1 = B.MONEDA        
    AND B.TIPO_OPE ='V'        
    AND B.MONEDA <>'USD'        
    AND A.CACODPOS1= 2        
    AND A.CATIPMODA = 'C'     
    AND B.IMPUTACION = 'P'        
    AND B.Cod_Origen = 1 ),0)        
        
        
 CREATE TABLE #VENC_COMPEN_MX (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (15))        
         
 INSERT INTO #VENC_COMPEN_MX         
 EXECUTE('        
 SELECT mnnemo1        
 ,  SUM('+  @OPERACION_COMPRA +') AS VALOR,''Compra_Vcto''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 WHERE catipoper = ''C'' AND mnnemo1 <> ''USD'' AND cacodpos1 =2         
 AND caFechaProceso ='''+ @FECHA +''' AND cafecvcto = '''+ @FECHA_PROX + '''        
 AND catipmoda = ''C''         
 GROUP BY mnnemo1')        
        
 INSERT INTO #VENC_COMPEN_MX         
 EXECUTE('SELECT mnnemo1        
 ,  SUM('+@OPERACION_VENTA +') AS VALOR,''Vta_Vcto''        
 FROM  TBL_HEDGE_FWD WITH(NOLOCK)        
 WHERE catipoper = ''V'' AND mnnemo1 <> ''USD'' AND cacodpos1 =2         
 AND caFechaProceso =''' + @FECHA +''' AND cafecvcto = '''+ @FECHA_PROX +'''        
 AND catipmoda = ''C''         
 GROUP BY mnnemo1')        
        
 INSERT INTO #RESULTADO_GENERAL        
 SELECT    'VCTOSCOMPMX'        
 ,    CODIGO         
 , (((SUM(CASE  DESCRIPCION WHEN 'Compra_Vcto' THEN VALOR ELSE 0 END))-        
  (SUM(CASE  DESCRIPCION WHEN 'Vta_Vcto'    THEN VALOR ELSE 0 END)))/@MILES)*-1 AS VALOR         
 ,     0.0        
 FROM  #VENC_COMPEN_MX          
 GROUP BY CODIGO        
        
-- DROP TABLE #TMP_HEDGE_PLANTILLA        
 CREATE TABLE #TMP_HEDGE_PLANTILLA (        
     Nemo_Moneda CHAR(4)        
  ,SPOT FLOAT        
  ,DERIVADOS FLOAT        
  ,VCTOSCOMPMX FLOAT        
  ,VCTOSCOMPADO FLOAT        
  ,OPPENDCURSE FLOAT        
  ,PARTIDASRTC FLOAT        
  ,PARIDAD FLOAT        
  ,POSICIONMX FLOAT        
  ,ORDEN INTEGER        
  )        
 -->        
 INSERT INTO #TMP_HEDGE_PLANTILLA        
 SELECT  B.Nemo_Moneda,        
  0.0,        
  0.0,        
  0.0,        
  0.0,        
  0.0,        
  0.0,        
  0.0,        
  0.0,        
    A.ORDEN_MONEDA /*ISNULL(    CASE WHEN B.Nemo_Moneda = 'USD' THEN 1    
    WHEN B.Nemo_Moneda = 'EUR' THEN 2         
    WHEN B.Nemo_Moneda = 'GBP' THEN 3        
    WHEN B.Nemo_Moneda = 'JPY' THEN 4        
    WHEN B.Nemo_Moneda = 'CAD' THEN 5         
    WHEN B.Nemo_Moneda = 'CHF' THEN 6        
    WHEN B.Nemo_Moneda = 'SEK' THEN 7        
    WHEN B.Nemo_Moneda = 'NOK' THEN 8         
    WHEN B.Nemo_Moneda = 'DKK' THEN 9        
    WHEN B.Nemo_Moneda = 'AUD' THEN 10        
    WHEN B.Nemo_Moneda = 'WON' THEN 11         
    WHEN B.Nemo_Moneda = 'MXN' THEN 12        
    WHEN B.Nemo_Moneda = 'PEN' THEN 13        
    WHEN B.Nemo_Moneda = 'BRL' THEN 14        
    WHEN B.Nemo_Moneda = 'COP' THEN 15        
    END,0)*/    
--- INTO #TMP_HEDGE_PLANTILLA        
 FROM TBL_HEDGE_MONEDAS B WITH(NOLOCK), TBL_HEDGE_ORDEN_MONEDAS A  WITH(NOLOCK)    
 WHERE A.CODIGO_MONEDA = B.CODIGO_MONEDA    
 --> SELECT * FROM #TMP_HEDGE_PLANTILLA        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET derivados = b.valor        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.nemo_moneda = B.codigo         
 WHERE B.producto = 'DERIVADOS'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET SPOT = B.VALOR        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.NEMO_MONEDA = B.CODIGO         
 WHERE B.producto = 'SPOT'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET VCTOSCOMPMX = B.VALOR        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.NEMO_MONEDA = B.CODIGO         
 WHERE B.producto = 'VCTOSCOMPMX'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET VCTOSCOMPADO = B.VALOR        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.NEMO_MONEDA = B.CODIGO         
 WHERE B.producto = 'VCTOSCOMPADO'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET OPPENDCURSE = B.VALOR        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.NEMO_MONEDA = B.CODIGO         
 WHERE B.producto = 'OPPENDCURSE'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
SET PARTIDASRTC = B.VALOR        
 FROM #TMP_HEDGE_PLANTILLA A        
  INNER JOIN #RESULTADO_GENERAL B ON A.NEMO_MONEDA = B.CODIGO         
 WHERE B.producto = 'PARTIDASRTC'        
        
 UPDATE #TMP_HEDGE_PLANTILLA         
 SET PARIDAD = ROUND(B.SPOTCOMPRA,4)      
 FROM #TMP_HEDGE_PLANTILLA A        
   INNER JOIN TBL_HEDGE_MONEDAS B ON A.NEMO_MONEDA = B.NEMO_MONEDA         
        
 SELECT  Nemo_Moneda        
 , SPOT         
 , DERIVADOS        
 , VCTOSCOMPMX        
 , VCTOSCOMPADO        
 , OPPENDCURSE        
 , PARTIDASRTC        
 , PARIDAD        
 , ROUND((SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC), 0) AS POSICIONMX       
 , ORDEN         
 ,      CASE WHEN NEMO_MONEDA= 'USD' THEN (SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC)        
   WHEN NEMO_MONEDA= 'EUR'OR NEMO_MONEDA= 'GBP' THEN (ROUND((SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC),0) * PARIDAD )      
   WHEN NEMO_MONEDA= 'AUD' THEN         
     CASE WHEN PARIDAD >= 1 THEN (ROUND((SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC),0) * PARIDAD )      
       WHEN PARIDAD < 1 THEN (ROUND((SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC),0) / PARIDAD )      
     END        
   ELSE (ROUND((SPOT+DERIVADOS+VCTOSCOMPMX+VCTOSCOMPADO+OPPENDCURSE+PARTIDASRTC),0) / ISNULL(NULLIF(PARIDAD,0),1) )END as P_EQUIV_USD      
 FROM #TMP_HEDGE_PLANTILLA ORDER BY ORDEN        
END     

GO

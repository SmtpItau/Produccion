USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_DETALLE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_DETALLE] (      
 @fecha_consulta DATETIME       
,@t_camb_rtc  CHAR(7) =''      
,@t_camb_ny  CHAR(7) =''      
,@miles   CHAR(10) =''      
--,@fecha_prox  CHAR(8) =''      
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
 DECLARE @do_delta_activo	FLOAT
 DECLARE @do_delta_pasivo	FLOAT
-- PRD12720 
      
 DECLARE @ar_activo FLOAT      
 DECLARE @ar_act_vcto FLOAT      
 DECLARE @ar_pasivo  FLOAT      
 DECLARE @ar_pas_vcto FLOAT      
      
 DECLARE @pcs_activo FLOAT      
 DECLARE @pcs_pasivo FLOAT      
 DECLARE @pcs_activo_mx FLOAT      
 DECLARE @pcs_pasivo_mx FLOAT       
      
 DECLARE @pcs_activo_COP FLOAT
 DECLARE @pcs_pasivo_COP FLOAT
      
 DECLARE @opc_activo FLOAT      
 DECLARE @opc_pasivo FLOAT      
      
 DECLARE @ar_activomx FLOAT      
 DECLARE @ar_act_vctomx FLOAT      
 DECLARE @ar_pasivomx  FLOAT      
 DECLARE @ar_pas_vctomx FLOAT      
      
 SELECT  @fecha = CONVERT(CHAR(8),  @fecha_consulta,112)      
       
 -->Arbitraje      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','V','A','','USD','', @ar_activo OUT      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','V','A','','USD', @fecha, @ar_act_vcto OUT      
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','C','P','','USD','' , @ar_pasivo OUT        
 EXECUTE DBO.sp_hedge_carga_campoUSD '1','2','C','P','','USD', @fecha, @ar_pas_vcto OUT        
 -->Opciones      
 EXECUTE DBO.sp_hedge_carga_campoUSD '3','0','C','A','USD','','', @opc_activo OUT       
 EXECUTE DBO.sp_hedge_carga_campoUSD '3','0','C','P','USD','','', @opc_pasivo OUT        
      
 -->Se llena datos de moneda extranjera en temporal      
       
 CREATE TABLE #MONEDASMX (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (15))      
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

 SET @do_delta_activo = 0.0
 SET @do_delta_pasivo = 0.0
 EXECUTE DBO.sp_hedge_carga_campoUSD '4','14','C','A','USD','','', @do_delta_activo  OUT, 'activo'
 EXECUTE DBO.sp_hedge_carga_campoUSD '4','14','C','A','USD','','', @do_delta_pasivo  OUT, 'pasivo'

-- print '@do_activo = ' + convert(varchar(20),@do_activo)
-- print '@do_act_vcto = ' + convert(varchar(20),@do_act_vcto)
-- print '@do_pasivo = ' + convert(varchar(20),@do_pasivo)
-- print '@do_pas_vcto = ' + convert(varchar(20),@do_pas_vcto)
-- print '@do_delta = ' + convert(varchar(20),@do_delta)

 --> PRD12720
      
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','C','A','MX','','','ARB_Activo_MX','mnnemo1'      
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','C','A','MX','',@fecha ,'ARB_Act_Vcto_MX','mnnemo1'       
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','V','P','MX','','','ARB_Pasivo_MX','mnnemo1'      
 EXECUTE DBO.sp_hedge_carga_campoMX '1','2','V','A','MX','',@fecha  ,'ARB_Pas_Vcto_MX','mnnemo1'       
 -->Swap      
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','A','','USD', @fecha, @pcs_activo OUT, 'compra_moneda'        
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','P','','USD', @fecha, @pcs_pasivo OUT ,'venta_moneda'        
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','A','','EUR', @fecha, @pcs_activo_mx OUT, 'compra_moneda'        
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','P','','EUR', @fecha, @pcs_pasivo_mx OUT ,'venta_moneda'      
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','A','','COP', @fecha, @pcs_activo_COP OUT, 'compra_moneda'        
 EXECUTE DBO.sp_hedge_carga_campoUSD '2','0','C','P','','COP', @fecha, @pcs_pasivo_COP OUT ,'venta_moneda'
       
 CREATE TABLE #RESULTADO_GENERAL (CODIGO   INT      
    , PRODUCTO   CHAR(20)      
    ,  MONEDAS   CHAR(4)      
    , ACTIVO_MX    FLOAT      
    ,  PASIVO_MX   FLOAT       
    , DESCALCE_MX  FLOAT      
    , DESCALCE_USD  FLOAT      
    , PARIDAD   FLOAT      
    , VALOR_MONEDA  FLOAT      
    )      
      
 INSERT INTO #RESULTADO_GENERAL      
 SELECT  'CODIGO'  =  1      
 , 'PRODUCTO'  = 'OPCIONES'      
 , 'MONEDAS'   =  nemo_moneda      
 , 'ACTIVO_MX'  = @OPC_Activo        
 , 'PASIVO_MX'  = @OPC_Pasivo      
 , 'DESCALCE_MX'  = (@OPC_Activo + @OPC_Pasivo)      
 , 'DESCALCE_USD'  = 0      
 , 'PARIDAD'  = SPOTCOMPRA      
 , 'VALOR_MONEDA'  = TIPO_CAMBIO      
 FROM  TBL_HEDGE_MONEDAS WITH(NOLOCK)      
 WHERE  nemo_moneda = 'USD'      
       
 INSERT INTO #RESULTADO_GENERAL      
 SELECT  'CODIGO'  =  2      
 , 'PRODUCTO'  = 'SEGURO_CAMBIO'      
 , 'MONEDAS'   =  nemo_moneda      
--> PRD12720
-- , 'ACTIVO_MX'  = ((@sc_activo-@sc_act_vcto)/ISNULL(NULLIF(tipo_cambio,0),1))       
-- , 'PASIVO_MX'  = ((@sc_pasivo-@sc_pas_vcto)/ISNULL(NULLIF(tipo_cambio,0),1))      
-- , 'DESCALCE_USD'  = ((@sc_activo-@sc_act_vcto)-(@sc_pasivo-@sc_pas_vcto))/ISNULL(NULLIF(tipo_cambio,0),1)      
 , 'ACTIVO_MX'  = ((@sc_activo-@sc_act_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + ((@do_activo-@do_act_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + (@do_delta_activo) --(@do_delta_activo * ISNULL(NULLIF(tipo_cambio,0),1))
 , 'PASIVO_MX'  = ((@sc_pasivo-@sc_pas_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + ((@do_pasivo-@do_pas_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + (@do_delta_pasivo) --(@do_delta_pasivo * ISNULL(NULLIF(tipo_cambio,0),1))
 , 'DESCALCE_MX'  = 0      
 , 'DESCALCE_USD'  = (((@sc_activo-@sc_act_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + ((@do_activo-@do_act_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) + (@do_delta_activo)) --(@do_delta_activo * ISNULL(NULLIF(tipo_cambio,0),1)))
					- (abs(@sc_pasivo-@sc_pas_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) - (abs(@do_pasivo-@do_pas_vcto)/ISNULL(NULLIF(tipo_cambio,0),1)) - abs(@do_delta_pasivo) --abs(@do_delta_pasivo * ISNULL(NULLIF(tipo_cambio,0),1))
--> PRD12720
 , 'PARIDAD'  = SPOTCOMPRA      
 , 'VALOR_MONEDA'  = TIPO_CAMBIO      
 FROM  TBL_HEDGE_MONEDAS WITH(NOLOCK)      
 WHERE  nemo_moneda = 'USD'      
       
      
      
 INSERT INTO #RESULTADO_GENERAL      
 SELECT  'CODIGO'  =  3      
 , 'PRODUCTO'  = 'ARBITRAJE_FUTURO'      
 , 'MONEDAS'   =  nemo_moneda      
 , 'ACTIVO_MX'  = ((@AR_Activo - @AR_Act_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))       
 , 'PASIVO_MX'  = ((@AR_Pasivo - @AR_Pas_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))      
 , 'DESCALCE_MX'  = ((@AR_Activo - @AR_Act_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))-((@AR_Pasivo - @AR_Pas_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))      
 , 'DESCALCE_USD'  = ((@AR_Activo - @AR_Act_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))-((@AR_Pasivo - @AR_Pas_Vcto)/ISNULL(NULLIF(tipo_cambio,0),1))      
 , 'PARIDAD'  = SPOTCOMPRA      
 , 'VALOR_MONEDA'  = TIPO_CAMBIO      
 FROM  TBL_HEDGE_MONEDAS WITH(NOLOCK)      
 WHERE  nemo_moneda = 'USD'      
      
 UNION ALL      
      
 SELECT  'CODIGO' = 3      
 , 'PRODUCTO' = 'ARBITRAJE_FUTURO'      
 , 'MONEDAS' = nemo_moneda      
 , 'ACTIVO_MX' =(SUM(CASE DESCRIPCION  WHEN  'ARB_Activo_MX ' THEN VALOR/TIPO_CAMBIO ELSE 0 END))-         
      (SUM(CASE DESCRIPCION  WHEN  'ARB_Act_Vcto_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END))        
 , 'PASIVO_MX'  =(SUM(CASE DESCRIPCION  WHEN  'ARB_Pasivo_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END))-      
     (SUM(CASE DESCRIPCION  WHEN  'ARB_Pas_Vcto_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END))      
      
 , 'DESCALCE_MX'  =((SUM(CASE DESCRIPCION  WHEN  'ARB_Activo_MX ' THEN VALOR/TIPO_CAMBIO ELSE 0 END))-         
      (SUM(CASE DESCRIPCION  WHEN  'ARB_Act_Vcto_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END)))      
     -        
     ((SUM(CASE DESCRIPCION  WHEN  'ARB_Pasivo_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END))-      
     (SUM(CASE DESCRIPCION  WHEN  'ARB_Pas_Vcto_MX' THEN VALOR/TIPO_CAMBIO ELSE 0 END)))      
       
 , 'DESCALCE_USD'  =((SUM(CASE  WHEN DESCRIPCION = 'ARB_Activo_MX 'OR CODIGO = 'EUR' OR CODIGO ='GBP' THEN (VALOR)*spotcompra ELSE (VALOR)/spotcompra END))-         
      (SUM(CASE   WHEN DESCRIPCION = ' ARB_Act_Vcto_MX'OR CODIGO = 'EUR' OR CODIGO ='GBP'  THEN (VALOR)*spotcompra ELSE (VALOR)/spotcompra END)))      
     -        
     ((SUM(CASE  WHEN  DESCRIPCION = 'ARB_Pasivo_MX'OR CODIGO = 'EUR' OR CODIGO ='GBP' THEN(VALOR)*spotcompra ELSE(VALOR)/spotcompra  END))-      
     (SUM(CASE   WHEN DESCRIPCION = 'ARB_Pas_Vcto_MX'OR CODIGO = 'EUR' OR CODIGO ='GBP' THEN (VALOR)*spotcompra ELSE (VALOR)/spotcompra END)))      
 , 'PARIDAD' =SPOTCOMPRA      
 , 'VALOR_MONEDA' = TIPO_CAMBIO      
       
 FROM  #MONEDASMX ,tbl_hedge_monedas WITH(NOLOCK)      
 WHERE  #MONEDASMX.codigo = TBL_HEDGE_MONEDAS.nemo_moneda       
 AND  codigo <> 'USD'      
 GROUP BY codigo,tipo_cambio,spotcompra,nemo_moneda        
      
      
      
 INSERT INTO #RESULTADO_GENERAL      
 SELECT  'CODIGO'  =  4      
 , 'PRODUCTO'  = 'SWAP'      
 , 'MONEDAS'   =  nemo_moneda      
 , 'ACTIVO_MX'  =  @pcs_activo/tipo_cambio       
 , 'PASIVO_MX'  =  @pcs_pasivo/tipo_cambio      
 , 'DESCALCE_MX'  = (@pcs_activo/tipo_cambio)- (@pcs_pasivo/ISNULL(NULLIF(tipo_cambio,0),1))      
 , 'DESCALCE_USD'  = (@pcs_activo/tipo_cambio)- (@pcs_pasivo/ISNULL(NULLIF(tipo_cambio,0),1))      
 , 'PARIDAD'  = SPOTCOMPRA      
 , 'VALOR_MONEDA'  = TIPO_CAMBIO      
 FROM  TBL_HEDGE_MONEDAS WITH(NOLOCK)      
 WHERE  nemo_moneda = 'USD'      
      
 UNION ALL      
      
 SELECT  'CODIGO' = 4      
 , 'PRODUCTO' = 'SWAP'      
 , 'MONEDAS' = nemo_moneda      
 , 'ACTIVO_MX' = CASE WHEN nemo_moneda = 'EUR' THEN @pcs_activo_mx/TIPO_CAMBIO 
 					  WHEN nemo_moneda = 'COP' THEN @pcs_activo_COP/TIPO_CAMBIO END
 	    
 , 'PASIVO_MX'  =CASE WHEN nemo_moneda = 'EUR' THEN @pcs_pasivo_mx/TIPO_CAMBIO 
					  WHEN nemo_moneda = 'COP' THEN @pcs_pasivo_COP/TIPO_CAMBIO END
      
 , 'DESCALCE_MX'  =CASE WHEN nemo_moneda = 'EUR' THEN (@pcs_activo_mx/TIPO_CAMBIO)-(@pcs_pasivo_mx/ISNULL(NULLIF(tipo_cambio,0),1)) 
					    WHEN nemo_moneda = 'COP' THEN (@pcs_activo_COP/TIPO_CAMBIO)-(@pcs_pasivo_COP/ISNULL(NULLIF(tipo_cambio,0),1)) END
 
 
      
 , 'DESCALCE_USD'  =CASE WHEN nemo_moneda = 'EUR'  THEN CASE WHEN mnrrda = 'M' THEN ((@pcs_activo_mx/TIPO_CAMBIO)*spotcompra)-((@pcs_pasivo_mx/ISNULL(NULLIF(tipo_cambio,0),1))*spotcompra) 
								ELSE   ((@pcs_activo_mx/TIPO_CAMBIO)/spotcompra)-((@pcs_pasivo_mx/ISNULL(NULLIF(tipo_cambio,0),1))/spotcompra)  END
					     WHEN nemo_moneda = 'COP' THEN  CASE WHEN mnrrda = 'M' THEN ((@pcs_activo_COP/TIPO_CAMBIO)*spotcompra)-((@pcs_pasivo_COP/ISNULL(NULLIF(tipo_cambio,0),1))*spotcompra) 
								ELSE   ((@pcs_activo_COP/TIPO_CAMBIO)/spotcompra)-((@pcs_pasivo_COP/ISNULL(NULLIF(tipo_cambio,0),1))/spotcompra)  END END



 , 'PARIDAD' =SPOTCOMPRA     
 , 'VALOR_MONEDA' = TIPO_CAMBIO      
 FROM  #MONEDASMX  WITH(NOLOCK)
 	   INNER JOIN  tbl_hedge_monedas WITH(NOLOCK)  ON #MONEDASMX.codigo = TBL_HEDGE_MONEDAS.nemo_moneda 
	   INNER JOIN  Bacparamsuda..moneda Mon WITH(NOLOCK) ON TBL_HEDGE_MONEDAS.CODIGO_MONEDA = Mon.mncodmon
 WHERE   codigo IN ('EUR','COP')         
 GROUP BY codigo,tipo_cambio,spotcompra,nemo_moneda,mnrrda  

      
 --EXECUTE DBO.SP_HEDGE_CON_PARTIDA_RTC  @fecha,@t_camb_rtc,@t_camb_ny,@miles      
      
----------------------------------------------------------------------------------------------------------------------      
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
      
      
      
 CREATE TABLE #PARTIDA_RTC_ACT (CODIGO CHAR(15),TOTAL FLOAT, DESCRIPCION CHAR (20))      
      
 INSERT INTO  #PARTIDA_RTC_ACT       
 EXECUTE(' SELECT  TBL_HEDGE_PRODUCTO.DESCRIPCIÓN,(SUM(('+@OP_ACT_DEBE+'/'''+@T_CAMB_RTC+''')/'''+@MILES+'''))-      
   (SUM(( '+@OP_ACT_HABER+'/'''+@T_CAMB_RTC+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_ACTIVO''      
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)      
  , TBL_HEDGE_MCLP WITH(NOLOCK)      
  , TBL_HEDGE_MANT WITH(NOLOCK)      
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE       
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO      
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''      
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen = 6      
AND (TBL_HEDGE_MANT.COD_PRODUCTO <> 5 AND TBL_HEDGE_MANT.COD_PRODUCTO <> 6)
  GROUP      
  BY TBL_HEDGE_PRODUCTO.DESCRIPCIÓN ')      
      
      
 CREATE TABLE #PARTIDA_RTC_PAS (CODIGO CHAR(15),TOTAL FLOAT, DESCRIPCION CHAR (20))      
      
 INSERT INTO  #PARTIDA_RTC_PAS       
 EXECUTE(' SELECT  TBL_HEDGE_PRODUCTO.DESCRIPCIÓN,(SUM(('+@OP_PAS_HABER+'/'''+@T_CAMB_RTC+''')/'''+@MILES+'''))-      
  (SUM(('+ @OP_PAS_DEBE+'/'''+@T_CAMB_RTC+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_PASIVO''      
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)      
  , TBL_HEDGE_MCLP WITH(NOLOCK)      
  , TBL_HEDGE_MANT WITH(NOLOCK)      
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE       
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO      
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''P''       
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen = 6      
AND (TBL_HEDGE_MANT.COD_PRODUCTO <> 5 AND TBL_HEDGE_MANT.COD_PRODUCTO <> 6)
  GROUP     
  BY TBL_HEDGE_PRODUCTO.DESCRIPCIÓN ')    


------------------------------------------------------------------------------
	--> 1.0 Solo para Inversiones utiliza TC NY se reemplaza @T_CAMB_RTC por @T_CAMB_NY
	--> Activo 
INSERT INTO  #PARTIDA_RTC_ACT     
 EXECUTE(' SELECT  TBL_HEDGE_PRODUCTO.DESCRIPCIÓN,(SUM(('+@OP_ACT_DEBE+'/'''+@T_CAMB_NY+''')/'''+@MILES+'''))-    
   (SUM(( '+@OP_ACT_HABER+'/'''+@T_CAMB_NY+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_ACTIVO''    
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)    
  , TBL_HEDGE_MCLP WITH(NOLOCK)    
  , TBL_HEDGE_MANT WITH(NOLOCK)    
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE     
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO    
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''    
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen	= 6    
  AND TBL_HEDGE_MANT.COD_PRODUCTO		= 6    
  GROUP    
  BY TBL_HEDGE_PRODUCTO.DESCRIPCIÓN ')    
 
 
	--> 1.0 Solo para Inversiones utiliza TC NY se reemplaza @T_CAMB_RTC por @T_CAMB_NY
	--> Pasivo
 INSERT INTO  #PARTIDA_RTC_PAS     
 EXECUTE(' SELECT  TBL_HEDGE_PRODUCTO.DESCRIPCIÓN,(SUM(('+@OP_PAS_HABER+'/'''+@T_CAMB_NY+''')/'''+@MILES+'''))-    
  (SUM(('+ @OP_PAS_DEBE+'/'''+@T_CAMB_NY+''')/'''+@MILES+''')) AS TOTAL,''TOTAL_PASIVO''    
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)    
  , TBL_HEDGE_MCLP WITH(NOLOCK)    
  , TBL_HEDGE_MANT WITH(NOLOCK)    
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE     
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO    
  AND TBL_HEDGE_MANT.TIPO_VALOR = ''P''     
  AND TBL_HEDGE_PRODUCTO.Codigo_Origen	= 6    
  AND TBL_HEDGE_MANT.COD_PRODUCTO		= 6
  GROUP       
  BY TBL_HEDGE_PRODUCTO.DESCRIPCIÓN ')      
      
------------------------------------------------------------------------------
    
    
 CREATE TABLE #PARTIDA_RTC_DESC (CODIGO CHAR(15),TOTAL_ACT FLOAT,TOTAL_PAS FLOAT, DESCRIPCION CHAR (20))      
 INSERT INTO  #PARTIDA_RTC_DESC       
 EXECUTE(' SELECT TBL_HEDGE_PRODUCTO.DESCRIPCIÓN,      
  (SUM(CASE  TBL_HEDGE_MANT.TIPO_VALOR WHEN ''A''THEN ('+@OP_ACT_NY+' /'''+@T_CAMB_NY+''')/'''+@MILES+''' ELSE 0 END))AS TOTAL_ACT,      
  (SUM(CASE  TBL_HEDGE_MANT.TIPO_VALOR WHEN ''P''THEN ('+ @OP_PAS_NY+' /'''+@T_CAMB_NY+''')/'''+@MILES+''' ELSE 0 END))AS TOTAL_PAS,''DESC_NY_A''      
  FROM  TBL_HEDGE_PRODUCTO WITH(NOLOCK)      
  , TBL_HEDGE_MCLP WITH(NOLOCK)      
  , TBL_HEDGE_MANT WITH(NOLOCK)       
  WHERE  TBL_HEDGE_MCLP.CUENTA =TBL_HEDGE_MANT.CUENTA_CONTABLE       
  AND TBL_HEDGE_MANT.COD_PRODUCTO = TBL_HEDGE_PRODUCTO.CODIGO      
  AND TBL_HEDGE_MANT.COD_PRODUCTO = 5      
  --AND TBL_HEDGE_MANT.TIPO_VALOR = ''A''      
  GROUP      
  BY TBL_HEDGE_PRODUCTO.DESCRIPCIÓN')     
      
 CREATE TABLE #PARTIDA_PLANTILLA (CODIGO CHAR(15),DESCRIPCION CHAR(30),ACTIVO_USD FLOAT,PASIVO_USD FLOAT)      
      
 INSERT INTO #PARTIDA_PLANTILLA      
 SELECT  B.CODIGO,B.DESCRIPCIÓN,0,0      
 FROM TBL_HEDGE_PRODUCTO B      
 WHERE Codigo_Origen = 6      
      
 UPDATE #PARTIDA_PLANTILLA       
 SET ACTIVO_USD = A.TOTAL      
 FROM #PARTIDA_PLANTILLA B      
  INNER JOIN #PARTIDA_RTC_ACT A  ON B.DESCRIPCION = A.CODIGO      
      
 UPDATE #PARTIDA_PLANTILLA       
 SET PASIVO_USD = A.TOTAL      
 FROM #PARTIDA_PLANTILLA B      
  INNER JOIN #PARTIDA_RTC_PAS A  ON B.DESCRIPCION = A.CODIGO      
       
 UPDATE #PARTIDA_PLANTILLA       
 SET ACTIVO_USD = A.TOTAL_ACT      
 FROM #PARTIDA_PLANTILLA B      
  INNER JOIN #PARTIDA_RTC_DESC A  ON B.DESCRIPCION = A.CODIGO      
       
 UPDATE #PARTIDA_PLANTILLA       
 SET PASIVO_USD = A.TOTAL_PAS      
 FROM #PARTIDA_PLANTILLA B      
  INNER JOIN #PARTIDA_RTC_DESC A  ON B.DESCRIPCION = A.CODIGO       
      
      
 INSERT INTO #RESULTADO_GENERAL      
 SELECT  'CODIGO'  = CASE  WHEN DESCRIPCION = 'AC 1446'  THEN 5      
      WHEN DESCRIPCION = 'Corfo' THEN 6      
      WHEN DESCRIPCION = 'Inv. Fin.' THEN 7      
      WHEN DESCRIPCION = 'Inversion NY'THEN 8      
      WHEN DESCRIPCION = 'Leasing ' THEN 9      
      WHEN DESCRIPCION = 'N/A' THEN 10     
                     WHEN DESCRIPCION = 'Inversiones' THEN 11 END    
       
 , 'PRODUCTO'  = CASE WHEN DESCRIPCION = 'AC 1446' THEN 'ACUERDO 1446'      
            ELSE UPPER(DESCRIPCION)END      
 , 'MONEDAS'   =  'USD'      
 , 'ACTIVO_MX'  =  ACTIVO_USD      
 , 'PASIVO_MX'  =  PASIVO_USD      
 , 'DESCALCE_MX'  = 0      
 , 'DESCALCE_USD'  = (SUM(ACTIVO_USD)-SUM(PASIVO_USD))       
 , 'PARIDAD'  = 0      
 , 'VALOR_MONEDA'  = 0      
 FROM  #PARTIDA_PLANTILLA        
 GROUP BY DESCRIPCION, ACTIVO_USD,PASIVO_USD      
       
 SELECT  CODIGO      
 , rtrim(ltrim(PRODUCTO))as PRODUCTO      
 , MONEDAS      
 , ACTIVO_MX      
 , PASIVO_MX  --select 4/ISNULL(NULLIF(2.5,0),1)      
 , DESCALCE_MX      
 , DESCALCE_USD      
 ,  CASE  WHEN CODIGO = 3 AND  MONEDAS =  'EUR' OR  MONEDAS = 'GBP'      
   THEN ((SUM(ACTIVO_MX ))-(SUM( PASIVO_MX)))*ISNULL(NULLIF(PARIDAD,0),1)      
   WHEN CODIGO = 3 AND  MONEDAS <> 'EUR' AND  MONEDAS <>'GBP'AND  MONEDAS <>'USD'      
   THEN       
    CASE WHEN CODIGO = 3 AND  MONEDAS = 'AUD' THEN       
     CASE WHEN PARIDAD >= 1 THEN ((SUM(ACTIVO_MX ))-(SUM( PASIVO_MX)))*ISNULL(NULLIF(PARIDAD,0),1)      
     WHEN PARIDAD < 1 THEN ((SUM(ACTIVO_MX ))-(SUM( PASIVO_MX)))/ISNULL(NULLIF(PARIDAD,0),1)      
     END      
    ELSE      
    ((SUM(ACTIVO_MX ))-(SUM( PASIVO_MX)))/ISNULL(NULLIF(PARIDAD,0),1)       
    END      
   WHEN CODIGO = 3 AND  MONEDAS =  'USD'       
   THEN  DESCALCE_MX ELSE DESCALCE_USD END AS DESCALCE_USD_V      
 , PARIDAD      
 , VALOR_MONEDA      
 , ISNULL(B.ORDEN_MONEDA,0)AS ORDEN  
      
 FROM   #RESULTADO_GENERAL,TBL_HEDGE_MONEDAS A,TBL_HEDGE_ORDEN_MONEDAS B  
 WHERE  A.CODIGO_MONEDA= B.CODIGO_MONEDA  
 AND  #RESULTADO_GENERAL.MONEDAS = A.NEMO_MONEDA  
 GROUP BY CODIGO      
 , PRODUCTO      
 , MONEDAS      
 , ACTIVO_MX      
 , PASIVO_MX      
 , DESCALCE_MX      
 , DESCALCE_USD      
 , PARIDAD      
 , VALOR_MONEDA      
 ,  B.ORDEN_MONEDA  
 ORDER BY CODIGO,B.ORDEN_MONEDA  
   
    DELETE FROM  TBL_HEDGE_MONEDAS_DETALLE  
 INSERT INTO TBL_HEDGE_MONEDAS_DETALLE  
 SELECT  CODIGO  
 ,  MONEDAS  
 ,  rtrim(ltrim(PRODUCTO))as PRODUCTO  
 FROM    #RESULTADO_GENERAL  
  
  
      
      
END  

GO

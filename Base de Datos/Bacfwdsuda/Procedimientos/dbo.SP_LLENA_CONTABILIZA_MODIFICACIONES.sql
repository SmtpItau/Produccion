USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA_MODIFICACIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA_MODIFICACIONES]( @Fecha_Hoy DATETIME )
AS
BEGIN
 SET NOCOUNT ON 
 DECLARE @Control_Error  INTEGER  ,
         @PrimerDiaMes       CHAR(8)  ,
  @fecha_proceso   DATETIME ,
  @fecha_anterior  DATETIME ,
  @Dolar_calculo  NUMERIC(16,04) ,
  @UF_calculo  NUMERIC(16,04) 
 SELECT  @fecha_proceso = acfecproc ,
  @fecha_anterior = acfecante
 FROM mfac
 SELECT @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(8),@Fecha_Proceso,112),1,6) + '01'
 SELECT @Dolar_calculo  = a.vmvalor ,
  @UF_calculo = b.vmvalor
 FROM  view_valor_moneda a ,
  view_valor_moneda b ,
  mfac   c ,
  mfac   d 
 WHERE ( a.vmfecha  = c.acfecante AND
    a.vmcodigo = c.accodmondolobs ) AND
  ( b.vmfecha  = d.acfecante AND
    b.vmcodigo = d.accodmonuf )   
 IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(CONVERT(CHAR(8),@fecha_anterior,112),5,2)
  BEGIN
   SELECT @UF_calculo = vmvalor
   FROM  view_valor_moneda ,
    mfac    
   WHERE vmcodigo = accodmonuf  AND
    CONVERT( CHAR(8) , vmfecha , 112 ) = CONVERT( CHAR(8) , CONVERT( DATETIME , DATEADD( DAY , -1 , CONVERT( DATETIME , @PrimerDiaMes ) ) ) , 112 )
  END
 --|========================================================================================|
 --| LLENADO DE ARCHIVO DE PASO CON OPERACIONES MODIFICADAS EN EL LOG DE LA CARTERA    |
 --|========================================================================================|
 SELECT  *
 INTO #tmp_log
 FROM  mfca_log,
  mfac
 WHERE  caprimero='S' and 
  cafecha <> cafecmod and
  cafecmod = acfecproc and
  caestado = 'M'
 
 IF NOT EXISTS( SELECT * FROM #tmp_log )
  RETURN 
 --| ========================================================================================|  
 --| Reversa Seguro Cambio Inicio            |  
 --| ========================================================================================|   
 INSERT bac_cnt_contabiliza
  (
  id_sistema  ,
  tipo_movimiento  ,
  tipo_operacion  ,
  operacion  ,
  correlativo  ,
  codigo_instrumento ,     
  moneda_instrumento ,
  Valor_Compra  ,
  Valor_Futuro  ,
  Valor_Presente  ,
  Perdida   ,
  Utilidad                ,
  articulo84  ,
  moneda_compra  ,
  moneda_venta  ,
  reversa     
  )
 SELECT
  'BFW'        ,
  'MOV'        ,
  '1'+a.catipoper       ,
  a.canumoper       ,
  1        ,
  CONVERT(CHAR(03),a.cacodmon2)     ,
  ''        ,
  a.caequusd1*-1       ,
  a.caclpmoneda2*-1       ,
  a.caequmon1*-1       ,
  ABS(ISNULL(a.caperddiferir,0))*-1      ,
  ABS(ISNULL(a.cautildiferir,0))*-1    ,
  ISNULL(a.cautildiferir,0)*-1     ,
  CASE a.catipoper WHEN 'C' THEN a.cacodmon1 ELSE 0 END  ,        
  CASE a.catipoper WHEN 'V' THEN a.cacodmon1 ELSE 0 END  ,
  1
 FROM #tmp_log a,
  mfca  b
 WHERE ( a.cacodpos1=1 OR a.cacodpos1=7 ) AND
  ( a.catipoper <> b.catipoper OR 
    a.cacodmon2 <> b.cacodmon2 OR 
    a.cafecvcto <> b.cafecvcto OR
    a.camtomon1 <> b.camtomon1 OR
    a.capremon1 <> b.capremon1 OR
    a.camtomon2 <> b.camtomon2  ) AND
  ( a.canumoper = b.canumoper )
 IF @@ERROR<>0
  BEGIN
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO REVERSA INICIO SEGUROS DE CAMBIO FORWARD ARCHIVO CONTABILIZA.'
   RETURN 1
  END
 --| ========================================================================================|  
 --| Ingreso Seguro Cambio Inicio Nuevo           |  
 --| ========================================================================================|   
 INSERT bac_cnt_contabiliza
  (
  id_sistema  ,
  tipo_movimiento  ,
  tipo_operacion  ,
  operacion  ,
  correlativo  ,
  codigo_instrumento ,     
  moneda_instrumento ,
  Valor_Compra  ,
  Valor_Futuro  ,
  Valor_Presente  ,
  Perdida   ,
  Utilidad                ,
  articulo84  ,
  moneda_compra  ,
  moneda_venta
  )
 SELECT
  'BFW'        ,
  'MOV'        ,
  '1'+b.catipoper       ,
  b.canumoper       ,
  1        ,
  CONVERT(CHAR(03),b.cacodmon2)     ,
  ''        ,
  b.caequusd1       ,
  b.caclpmoneda2        ,
  b.caequmon1       ,
  ABS(ISNULL(b.caperddiferir,0))       ,
  ABS(ISNULL(b.cautildiferir,0))     ,
  ISNULL(b.cautildiferir,0)     ,
  CASE b.catipoper WHEN 'C' THEN b.cacodmon1 ELSE 0 END  ,
  CASE b.catipoper WHEN 'V' THEN b.cacodmon1 ELSE 0 END  
 FROM #tmp_log a,
  mfca  b
 WHERE ( b.cacodpos1=1 OR b.cacodpos1=7 ) AND
  ( a.catipoper <> b.catipoper OR 
    a.cacodmon2 <> b.cacodmon2 OR 
    a.cafecvcto <> b.cafecvcto OR
    a.camtomon1 <> b.camtomon1 OR
    a.capremon1 <> b.capremon1 OR
    a.camtomon2 <> b.camtomon2   ) AND
  ( a.canumoper = b.canumoper )
 IF @@ERROR<>0
  BEGIN
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO NUEVO INICIO SEGUROS DE CAMBIO FORWARD ARCHIVO CONTABILIZA.'
   RETURN 1
  END
 --|========================================================================================|  
 --| Reversa Arbitraje Inicio           |  
 --|========================================================================================|
 INSERT bac_cnt_contabiliza
  (
  id_sistema   ,
  tipo_movimiento   ,
  tipo_operacion   ,
  operacion   ,
  correlativo   ,
  codigo_instrumento  ,
  moneda_instrumento  ,
  valor_compra   ,
  valor_venta   ,
  articulo84   ,
                Tipo_Cliente                    ,
  moneda_compra   ,
  moneda_venta   ,
  codigo_producto   ,
  reversa
  )
 SELECT
  'BFW'          ,
  'MOV'          ,
  '2'+a.catipoper         ,
  a.canumoper         ,
  1          ,
  CONVERT(CHAR(03),a.cacodmon2)       ,
  ''          ,
  CASE a.catipoper WHEN 'C' THEN a.camtomon1 * -1 ELSE a.camtomon2 * -1 END ,
  CASE a.catipoper WHEN 'C' THEN a.camtomon2 * -1 ELSE a.camtomon1 * -1 END ,
  a.camtodiferir * -1          ,
                CASE WHEN clpais  = 6 THEN 1 ELSE 2 END      ,
  CASE a.catipoper WHEN 'C' THEN a.cacodmon1 ELSE a.cacodmon2 END  ,
  CASE a.catipoper WHEN 'C' THEN a.cacodmon2 ELSE a.cacodmon1 END  ,
  a.cacodpos1         ,
  1
 FROM #tmp_log a ,
  mfca   b ,
  view_cliente
 WHERE a.cacodpos1=2 AND 
                ( clrut=a.cacodigo and clcodigo=a.cacodcli) AND
  ( a.cacodigo <> b.cacodigo OR 
    a.cacodcli <> b.cacodcli OR 
    a.camtomon1 <> b.camtomon1 OR 
    a.cacodmon1 <> b.cacodmon1 OR
     a.camtomon2 <> b.camtomon2   ) AND
  ( a.canumoper = b.canumoper )
 IF @@ERROR<>0
  BEGIN
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO REVERSA INICIO ARBITRAJES FORWARD ARCHIVO CONTABILIZA.'
   RETURN 1
  END
 --|========================================================================================|  
 --| Inicio Arbitraje Inicio Nuevo          |  
 --|========================================================================================|
 INSERT bac_cnt_contabiliza
  (
  id_sistema   ,
  tipo_movimiento   ,
  tipo_operacion   ,
  operacion   ,
  correlativo   ,
  codigo_instrumento  ,
  moneda_instrumento  ,
  valor_compra   ,
  valor_venta   ,
  articulo84   ,
                Tipo_Cliente                    ,
  moneda_compra   ,
  moneda_venta   ,
  codigo_producto   
  )
 SELECT
  'BFW'         ,
  'MOV'         ,
  '2'+a.catipoper        ,
  a.canumoper        ,
  1         ,
  CONVERT(CHAR(03),b.cacodmon2)      ,
  ''         ,
  CASE b.catipoper WHEN 'C' THEN b.camtomon1 ELSE b.camtomon2 END  ,
  CASE b.catipoper WHEN 'C' THEN b.camtomon2 ELSE b.camtomon1 END  ,
  b.camtodiferir         ,
                CASE WHEN clpais  = 6 THEN 1 ELSE 2 END     ,
  CASE b.catipoper WHEN 'C' THEN b.cacodmon1 ELSE b.cacodmon2 END ,
  CASE b.catipoper WHEN 'C' THEN b.cacodmon2 ELSE b.cacodmon1 END ,
  b.cacodpos1
 FROM #tmp_log a ,
  mfca   b ,
  view_cliente
 WHERE b.cacodpos1=2 AND 
                ( clrut=b.cacodigo and clcodigo=b.cacodcli) AND
  ( a.cacodigo <> b.cacodigo OR 
    a.cacodcli <> b.cacodcli OR 
    a.camtomon1 <> b.camtomon1 OR 
    a.cacodmon1 <> b.cacodmon1 OR
     a.camtomon2 <> b.camtomon2   ) AND
  ( a.canumoper = b.canumoper )
 IF @@ERROR<>0
  BEGIN
   PRINT 'ERROR_PROC FALLA ACTUALIZANDO NUEVO INICIO ARBITRAJES FORWARD ARCHIVO CONTABILIZA.'
   RETURN 1
  END
 -- ======================================================================================== 
 -- REVERSA FORWARD Seguro INFLACION VB                                                              
 -- ======================================================================================== 
 INSERT bac_cnt_contabiliza
  (
  id_sistema   ,
  tipo_movimiento   ,
  tipo_operacion   ,
  operacion   ,
  correlativo   ,
  codigo_instrumento  ,
  moneda_instrumento  ,
  valor_compra   ,
  valor_venta   ,
  utilidad   ,
  perdida                         ,
      Articulo84                ,
  reversa
  )
 SELECT
  'BFW'    ,
  'MOV'    ,
  '3'+a.catipoper   ,
  a.canumoper   ,
  1    ,
  CONVERT(CHAR(03),a.cacodmon2) ,
  ''    ,
  CASE a.catipoper  WHEN 'C' THEN a.caequmon1 * -1 ELSE a.camtomon2 * -1 END ,
  CASE a.catipoper  WHEN 'C' THEN a.camtomon2 * -1 ELSE a.caequmon1 * -1 END ,
  CASE WHEN a.cautildiferir>0 THEN a.cautildiferir * -1  ELSE 0 END  ,
  CASE WHEN a.caperddiferir<0 THEN a.caperddiferir ELSE 0 END  ,
  CASE WHEN a.cautildiferir>0 THEN a.cautildiferir*-1  ELSE 0 END  ,
  1
 FROM #tmp_log a,
  mfca  b
 WHERE a.cacodpos1=3 AND 
  ( a.camtomon1 <> b.camtomon2 OR 
    a.catipoper <> b.catipoper OR 
    a.camtomon2 <> b.camtomon2 OR 
    a.cafecvcto <> b.cafecvcto ) AND
  ( a.canumoper = b.canumoper )
  
 IF @@ERROR<>0
 BEGIN
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO REVERSA SEG. INFLACION ARCHIVO CONTABILIZA.'
  RETURN 1
 END
 -- ======================================================================================== 
 -- FORWARD Seguro INFLACION VB                                                              
 -- ======================================================================================== 
 INSERT bac_cnt_contabiliza
  (
  id_sistema   ,
  tipo_movimiento   ,
  tipo_operacion   ,
  operacion   ,
  correlativo   ,
  codigo_instrumento  ,
  moneda_instrumento  ,
  valor_compra   ,
  valor_venta   ,
  utilidad   ,
  perdida                         ,
      Articulo84               
  )
 SELECT
  'BFW'    ,
  'MOV'    ,
  '3'+b.catipoper   ,
  b.canumoper   ,
  1    ,
  CONVERT(CHAR(03),b.cacodmon2) ,
  ''    ,
  CASE b.catipoper  WHEN 'C' THEN b.caequmon1 ELSE b.camtomon2 END ,
  CASE b.catipoper  WHEN 'C' THEN b.camtomon2 ELSE b.caequmon1 END ,
  CASE WHEN b.cautildiferir>0 THEN b.cautildiferir ELSE 0 END  ,
  CASE WHEN b.caperddiferir<0 THEN ABS(b.caperddiferir) ELSE 0 END ,
  CASE WHEN b.cautildiferir>0 THEN b.cautildiferir ELSE 0 END  
 FROM #tmp_log a,
  mfca  b
 WHERE b.cacodpos1=3 AND 
  ( a.camtomon1 <> b.camtomon2 OR 
    a.catipoper <> b.catipoper OR 
    a.camtomon2 <> b.camtomon2 OR 
    a.cafecvcto <> b.cafecvcto ) AND
  ( a.canumoper = b.canumoper )
  
 IF @@ERROR<>0
 BEGIN
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO NUEVO SEG. INFLACION ARCHIVO CONTABILIZA.'
  RETURN 1
 END
 --|========================================================================================|
 --| Reversa Devengamiento y valorización Seguro Cambio                                     |
 --|========================================================================================|
 INSERT bac_cnt_contabiliza
  (
  id_sistema   ,
  tipo_movimiento   ,
  tipo_operacion   ,
  operacion   ,
  correlativo   ,
  codigo_instrumento  ,
  moneda_instrumento  ,
  utilidad   ,
  perdida    ,
  reversa_valorizacion  ,
  Reversa_Valorizacion_Utilidad ,
  Reversa_Valorizacion_Perdida ,
         Reajuste_UF             ,
  reversa
  )
 SELECT
  'BFW'                        ,
  'DEV'                        ,
  'D1'+a.catipoper               ,
  a.canumoper       ,
  1                            ,
  CONVERT(CHAR(03),a.cacodmon2)     ,  
  ''         ,
  ISNULL((a.cautilacum-a.cautildevenga)* - 1 , 0 )  , -- Utilidad Acumulada
  ISNULL((a.caperdacum-a.caperddevenga) , 0 )          , -- Perdida Acumulada
  ( a.cautilacum-a.cautildevenga ) + ( a.caperdacum-a.caperddevenga ) + ( CASE a.catipoper WHEN 'C' THEN ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 ELSE ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 WHEN a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 ELSE 0 END ) , -- Valorización
  CASE WHEN ( ( a.cautilacum-a.cautildevenga ) + ( a.caperdacum-a.caperddevenga ) + ( CASE a.catipoper WHEN 'C' THEN ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 ELSE ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 ELSE 0 END ) ) >= 0 THEN ( ( a.cautilacum-a.cautildevenga ) + ( a.caperdacum-a.caperddevenga ) + ( CASE a.catipoper WHEN 'C' THEN ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 ELSE ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 ELSE 0 END ) ) ELSE 0 END  ,
  CASE WHEN ( ( a.cautilacum-a.cautildevenga ) + ( a.caperdacum-a.caperddevenga ) + ( CASE a.catipoper WHEN 'C' THEN ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 ELSE ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 ELSE 0 END ) ) <= 0 THEN ABS( ( a.cautilacum-a.cautildevenga ) + ( a.caperdacum-a.caperddevenga ) + ( CASE a.catipoper WHEN 'C' THEN ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 ELSE ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 ELSE 0 END ) ) ELSE 0 END ,
--  ( ( ( a.cautilacum-a.cautildevenga ) * -1 ) + (a.caperdacum-a.caperddevenga) ) + ( ( CASE a.catipoper WHEN 'C' THEN ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 ELSE ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( ( @UF_calculo - a.capremon2 ) * a.camtomon2 ) WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( ( a.capremon2 - @UF_calculo ) * a.camtomon2 ) ELSE 0 END ) * -1 ), -- Valorización
--  CASE WHEN ( ( ( a.cautilacum-a.cautildevenga ) * -1 ) + (a.caperdacum-a.caperddevenga) ) + ( CASE a.catipoper WHEN 'C' THEN ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 ELSE ( @Dolar_calculo - a.capremon1 ) * a.camtomon1  END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2  WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2  ELSE 0 END ) <= 0 THEN ( ( ( a.cautilacum-a.cautildevenga ) * -1 ) + (a.caperdacum-a.caperddevenga) ) + ( ( CASE a.catipoper WHEN 'C' THEN ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 ELSE ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 ELSE 0 END ) * -1 ) ELSE 0 END ,
--  CASE WHEN ( ( ( a.cautilacum-a.cautildevenga ) * -1 ) + (a.caperdacum-a.caperddevenga) ) + ( CASE a.catipoper WHEN 'C' THEN ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 ELSE ( @Dolar_calculo - a.capremon1 ) * a.camtomon1  END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2  WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2  ELSE 0 END ) >= 0 THEN ( ( ( a.cautilacum-a.cautildevenga ) * -1 ) + (a.caperdacum-a.caperddevenga) ) + ( ( CASE a.catipoper WHEN 'C' THEN ( a.capremon1 - @Dolar_calculo ) * a.camtomon1 ELSE ( @Dolar_calculo - a.capremon1 ) * a.camtomon1 END ) + ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 ELSE 0 END ) * -1 ) ELSE 0 END ,
  ( CASE WHEN a.cacodmon2 = 998 AND a.catipoper = 'C' THEN ( @UF_calculo - a.capremon2 ) * a.camtomon2 WHEN  a.cacodmon2 = 998 AND a.catipoper = 'V' THEN ( a.capremon2 - @UF_calculo ) * a.camtomon2 ELSE 0 END ) * -1 ,  -- Sólo para los Contratos UF
  1
 FROM #tmp_log a , 
  mfca  b
 WHERE ( a.cacodpos1=1 OR a.cacodpos1=7 ) AND
  ( a.catipoper <> b.catipoper OR 
    a.cacodmon2 <> b.cacodmon2 OR 
    a.cafecvcto <> b.cafecvcto OR
    a.camtomon1 <> b.camtomon1 OR
    a.capremon1 <> b.capremon1 OR
    a.camtomon2 <> b.camtomon2  ) AND
  ( a.canumoper = b.canumoper )
 --|========================================================================================|
 --| Ingresa Nuevo Devengamiento y valorización Seguro Cambio                               |
 --|========================================================================================|
 INSERT bac_cnt_contabiliza
  (
  id_sistema  , 
  tipo_movimiento  ,
  tipo_operacion  ,
  operacion  ,
  correlativo  ,
  codigo_instrumento ,
  moneda_instrumento ,
  utilidad  ,
  perdida   ,
  valorizacion  ,
  utilidad_valorizacion ,
  perdida_valorizacion ,
         Reajuste_UF            ,
  Reversa
  )
 SELECT
  'BFW'                        ,
  'DEV'                        ,
  'D1'+b.catipoper               ,
  b.canumoper       ,
  1                            ,
  CONVERT(CHAR(03),b.cacodmon2)     ,  
  ''         ,
  ISNULL( (b.cautilacum-b.cautildevenga) , 0 )   , -- Utilidad Acumulada
  ISNULL( (b.caperdacum-b.caperddevenga) , 0 )          , -- Perdida Acumulada
  ( b.cautilacum-b.cautildevenga ) + ( b.caperdacum-b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 ELSE ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( b.capremon2 -  @UF_calculo ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 ELSE 0 END ) , -- Valorización
  CASE WHEN ( ( b.cautilacum-b.cautildevenga ) + ( b.caperdacum-b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 ELSE ( b.capremon1 - @Dolar_calculo ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 ELSE 0 END ) ) >= 0 THEN ( ( b.cautilacum-b.cautildevenga ) + ( b.caperdacum-b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 ELSE ( b.capremon1 - @Dolar_calculo ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 ELSE 0 END ) ) ELSE 0 END ,
  CASE WHEN ( ( b.cautilacum-b.cautildevenga ) + ( b.caperdacum-b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 ELSE ( b.capremon1 - @Dolar_calculo ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 ELSE 0 END ) ) <= 0 THEN ABS( ( b.cautilacum-b.cautildevenga ) + ( b.caperdacum-b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 ELSE ( b.capremon1 - @Dolar_calculo ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 ELSE 0 END ) ) ELSE 0 END ,
--  CASE WHEN ( ( ( b.cautilacum-b.cautildevenga ) * -1 ) + (b.caperdacum-b.caperddevenga) ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2  WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2  ELSE 0 END ) * -1 ) >= 0 THEN ( ( ( b.cautilacum-b.cautildevenga ) * -1 ) + (b.caperdacum-b.caperddevenga) ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 ELSE 0 END ) ) ELSE 0 END ,
--  CASE WHEN ( ( ( b.cautilacum-b.cautildevenga ) * -1 ) + (b.caperdacum-b.caperddevenga) ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2  WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2  ELSE 0 END ) * -1 ) <= 0 THEN ( ( ( b.cautilacum-b.cautildevenga ) * -1 ) + (b.caperdacum-b.caperddevenga) ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 ELSE 0 END ) ) ELSE 0 END ,
--  CASE WHEN ( ( b.cautildevenga * -1 ) + b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2  WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2  ELSE 0 END ) <= 0 THEN ( ( b.cautildevenga * -1 ) + b.caperddevenga ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 ELSE 0 END ) * -1 ) ELSE 0 END ,
--  CASE WHEN ( ( b.cautildevenga * -1 ) + b.caperddevenga ) + ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1  END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2  WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2  ELSE 0 END ) >= 0 THEN ( ( b.cautildevenga * -1 ) + b.caperddevenga ) + ( ( CASE b.catipoper WHEN 'C' THEN ( b.capremon1 - @Dolar_calculo ) * b.camtomon1 ELSE ( @Dolar_calculo - b.capremon1 ) * b.camtomon1 END ) + ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 ELSE 0 END ) * -1 ) ELSE 0 END ,
  ( CASE WHEN b.cacodmon2 = 998 AND b.catipoper = 'C' THEN ( @UF_calculo - b.capremon2 ) * b.camtomon2 WHEN  b.cacodmon2 = 998 AND b.catipoper = 'V' THEN ( b.capremon2 - @UF_calculo ) * b.camtomon2 ELSE 0 END ) , -- Sólo para los Contratos UF
  2
 FROM #tmp_log a ,
  mfca  b
 WHERE ( a.cacodpos1=1 OR a.cacodpos1=7 ) AND
  ( a.catipoper <> b.catipoper OR 
    a.cacodmon2 <> b.cacodmon2 OR 
    a.cafecvcto <> b.cafecvcto OR
    a.camtomon1 <> b.camtomon1 OR
    a.capremon1 <> b.capremon1 OR
    a.camtomon2 <> b.camtomon2  ) AND
  ( a.canumoper = b.canumoper )
 IF @@ERROR<>0
 BEGIN
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO SEGURO CAMBIO, FORWARD ARCHIVO CONTABILIZA.'
  RETURN 1
 END
 SET NOCOUNT OFF
 RETURN 0
END   /* FIN PROCEDIMIENTO */

GO

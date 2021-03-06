USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_CALZADASPOS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONES_CALZADASPOS]
AS
BEGIN
SET NOCOUNT ON
DECLARE @var  FLOAT
SELECT @var = 0
DECLARE @observado  NUMERIC(12,04) ,
     @uf   NUMERIC(12,04) ,
     @fecha_observado CHAR(10) ,
     @fecha_uf  CHAR(10) 
EXECUTE sp_parametros_reporte   @observado  OUTPUT ,
         @uf   OUTPUT ,
    @fecha_observado OUTPUT ,
         @fecha_uf  OUTPUT
SELECT 'POSICION_COMPRA' = ccposcmp    ,
  'POSICION_VENTA'  = ccposvta    ,
  'TIPO_OPERACION'  = catipoper    ,
  'NUMERO_SINTETI'  = ccopecmp    ,
  'DIV_PASIVO'   =  CASE
        WHEN  camtomon1 <> ccmonto THEN
          ccmonto / camtomon1
        ELSE
          1
       END    ,
  'DIV_ACTIVO'   =  @var    ,
  'NUMERO_OPER'   = canumoper    ,
  'MONEDA_SINTETI'  = 0     ,
  'VALOR_DERIVADO'  = valor_actual_cnv   ,
  'UF_SINTETICO'    = @uf     ,
  'MONTO_FINAL'   = camtomon2    ,
  'COD_MON1'        = cacodmon1     ,
  'COD_MON2'        = cacodmon2    ,
  'FECHA_INICIO'    = CONVERT( CHAR(10) , cafecha , 103 ) ,
  'FECHA_VCTO'      = CONVERT( CHAR(10) , cafecvcto,103 ) ,
  'PLAZO'           = caplazo    ,
  'PLAZO_VCTO'      = caplazovto    ,
  'MONTO_MONEDA'    = ccmonto    ,
  'TASA_USD'        = catasausd    ,
  'TASA_CNV'        = catasacon    ,
  'SPOT_OBS'   = c.vmvalor      ,
  'SPOT_UF'   = d.vmvalor      ,
  'FUTURO'          = catipcam    ,
  'COTIZ'           = caprecal    ,
  'TIPO_MODALIDAD'  = catipmoda    ,
  'PRECIO_MONEDA'   = capremon1    ,
  'NEMOTECNICO1'    = a.mnnemo    ,
  'NEMOTECNICO2'    = b.mnnemo    ,
  'NOMBRE_CLIENTE'  = clnombre    ,
  'FECHA_PROCESO'   = CONVERT( CHAR(10) , acfecproc,103 ) ,
  'OBSERVADO'   = @observado    ,
  'UF'    = @uf     ,
  'HORA'            = CONVERT(CHAR (8),GETDATE(),108) ,
  'MARGEN'   = isnull(catipcam,0)   ,
  'FECHA_OBSERVADO' = @fecha_observado   ,
  'FECHA_UF'    = @fecha_uf,
 'entidad' =  acnomprop
 INTO #temp_1
 FROM    mfca   ,
   mfac   ,
   mfcc   ,
   view_cliente  ,
   view_moneda a  ,
   view_moneda b  ,  
   view_valor_moneda c ,
   view_valor_moneda d 
 WHERE  ccposcmp   = 4        and
   cacodmon1  = a.mncodmon      and
   cacodmon2  = b.mncodmon      and
   (cacodigo  = clrut      and
   cacodcli   = clcodigo)      and
   canumoper  = ccopevta      and
   (accodmondolobs = c.vmcodigo    and
   c.vmfecha = cafecha)      and
  (accodmonuf = d.vmcodigo     and
   d.vmfecha = cafecha)      AND
   cafecvcto > acfecproc
SELECT  'POSICION_COMPRA' = ccposcmp    ,
  'POSICION_VENTA'  = ccposvta    ,
  'TIPO_OPERACION'  = catipoper    ,
  'NUMERO_SINTETI'  = ccopevta    ,
  'DIV_PASIVO'   =  @var    ,
  'DIV_ACTIVO'   = CASE
        WHEN  camtomon1 <> ccmonto THEN 
             ccmonto / camtomon1
        ELSE
         1
       END    ,
  'NUMERO_OPER'   = canumoper    ,
  'MONEDA_SINTETI'  = 0     ,
  'VALOR_DERIVADO'  = valor_actual_cnv   ,
  'UF_SINTETICO'    = @uf     ,
  'MONTO_FINAL'   = camtomon2    ,
  'COD_MON1'        = cacodmon1     ,
  'COD_MON2'        = cacodmon2    ,
  'FECHA_INICIO'    = CONVERT( CHAR(10) , cafecha , 103 ) ,
  'FECHA_VCTO'      = CONVERT( CHAR(10) , cafecvcto,103 ) ,
  'PLAZO'           = caplazo    ,
  'PLAZO_VCTO'      = caplazovto    ,
  'MONTO_MONEDA'    = ccmonto    ,
  'TASA_USD'        = catasausd    ,
  'TASA_CNV'        = catasacon    ,
  'SPOT_OBS'   = c.vmvalor      ,
  'SPOT_UF'   = d.vmvalor      , 
  'FUTURO'          = catipcam    ,
  'COTIZ'           = caprecal    ,
  'TIPO_MODALIDAD'  = catipmoda    ,
  'PRECIO_MONEDA'   = capremon1    ,
  'NEMOTECNICO1'    = a.mnnemo    ,
  'NEMOTECNICO2'    = b.mnnemo    ,
  'NOMBRE_CLIENTE'  = clnombre    ,
  'FECHA_PROCESO'   = CONVERT( CHAR(10) , acfecproc,103 ) ,
  'OBSERVADO'   = @observado    ,
  'UF'    = @uf     ,
  'HORA'            = CONVERT(CHAR (8),GETDATE(),108) ,
  'MARGEN'   = isnull(catipcam,0)  ,
  'FECHA_OBSERVADO' = @fecha_observado   ,
  'FECHA_UF'    = @fecha_uf,
 'entidad' =  acnomprop
 INTO #temp_2
 FROM    mfca  ,
   mfac            ,
   mfcc  ,
   view_cliente ,
   view_moneda a ,
   view_moneda b , 
   view_valor_moneda c ,
   view_valor_moneda d
 WHERE  ccposvta = 4        and
   cacodmon1 = a.mncodmon      and
   cacodmon2 = b.mncodmon      and
   (cacodigo = clrut      and
   cacodcli = clcodigo)      and
   canumoper = ccopecmp      and
   (accodmondolobs = c.vmcodigo    and
   c.vmfecha = cafecha)      and
   (accodmonuf = d.vmcodigo     and
   d.vmfecha = cafecha)        AND
   cafecvcto > acfecproc
/*
 |---------------------------------------------------------------|
 | Actualiza las Tasas y determina los porcentajes de los calces |
 |---------------------------------------------------------------|
*/
UPDATE #temp_1 
SET  tasa_usd = catasausd  ,
 tasa_cnv        = catasacon  ,
 moneda_sinteti  = cacodmon2  ,
 valor_derivado = valor_actual_cnv ,
 precio_moneda   = capremon1  ,
 uf_sintetico    = vmvalor  ,
 div_activo = CASE
    WHEN  caequusd1 <> ccmonto THEN 
     ccmonto / caequusd1
    ELSE
     1
    END 
FROM mfca   ,
 mfcc   ,
 mfac   ,
 view_valor_moneda
WHERE  ( numero_sinteti  = canumoper AND
 numero_sinteti  = ccopecmp  ) AND
 numero_oper = ccopevta    AND
 (vmcodigo = accodmonuf AND
  vmfecha = cafecha   ) 
UPDATE #temp_2 
SET  tasa_usd = catasausd  ,
 tasa_cnv        = catasacon  ,
 moneda_sinteti  = cacodmon2  ,
 valor_derivado = valor_actual_cnv ,
 precio_moneda   = capremon1  ,
 uf_sintetico    = vmvalor  ,
 div_pasivo = CASE
     WHEN  caequusd1 <> ccmonto THEN 
    ccmonto / caequusd1
     ELSE
    1
     END 
FROM mfca   ,
 mfcc   ,
 mfac   ,
 view_valor_moneda
WHERE  (numero_sinteti  = canumoper AND
 numero_sinteti  = ccopevta  ) AND
 numero_oper = ccopecmp    AND
 (vmcodigo = accodmonuf AND
  vmfecha = cafecha   ) 
UPDATE #temp_1
SET monto_final = monto_final * div_pasivo ,
 valor_derivado = valor_derivado * div_activo
UPDATE #temp_2
SET monto_final = monto_final * div_activo ,
 valor_derivado = valor_derivado * div_pasivo
/*
 |-----------------------------| 
 |Calcula el Margen        |
 |-----------------------------|
*/
UPDATE #temp_1 
SET margen = isnull(CASE WHEN posicion_venta = 5 OR posicion_compra = 5   THEN 0
   WHEN moneda_sinteti <> cod_mon2 AND moneda_sinteti = 999 THEN ( ( ( ( monto_final / spot_uf ) - ( valor_derivado / uf_sintetico ) ) * @uf ) / @observado ) 
   WHEN moneda_sinteti <> cod_mon2 AND moneda_sinteti = 998 THEN ( ( ( ( monto_final / spot_uf ) - valor_derivado ) * @uf ) / @observado ) 
   WHEN moneda_sinteti =  cod_mon2 AND cod_mon2       = 998 THEN ( ( ( monto_final - valor_derivado ) * @uf ) / @observado ) 
   WHEN moneda_sinteti =  cod_mon2 AND cod_mon2       = 999 THEN ( ( monto_final - valor_derivado ) / @observado ) 
   ELSE 0
    END ,0)
UPDATE #temp_2 
SET margen = isnull(CASE WHEN posicion_venta = 5 OR posicion_compra = 5   THEN 0
   WHEN moneda_sinteti <> cod_mon2 AND moneda_sinteti = 999 THEN ( ( ( ( monto_final / spot_uf ) - ( valor_derivado / uf_sintetico ) ) * @uf ) / @observado ) * -1
   WHEN moneda_sinteti <> cod_mon2 AND moneda_sinteti = 998 THEN ( ( ( ( monto_final / spot_uf ) - valor_derivado ) * @uf ) / @observado ) * -1
   WHEN moneda_sinteti =  cod_mon2 AND cod_mon2       = 998 THEN ( ( ( monto_final - valor_derivado ) * @uf ) / @observado ) * -1
   WHEN moneda_sinteti =  cod_mon2 AND cod_mon2       = 999 THEN ( ( monto_final - valor_derivado ) / @observado ) * -1
   ELSE 0
    END ,0)
SELECT * FROM #temp_1
UNION
SELECT * FROM #temp_2 ORDER BY fecha_vcto
SET NOCOUNT OFF
END
-- sp_operaciones_calzadaspos
-- select caplazo,valor_actual_cnv,cacodmon2,* from mfca where canumoper = 1594
-- select cafecha,* from mfca where canumoper= 28757
-- SELECT * FROM VIEW_VALOR_MONEDA WHERE VMCODIGO = 998 and vmfecha = '20010608'
-- select * from mfcc where ccopecmp = 28757

GO

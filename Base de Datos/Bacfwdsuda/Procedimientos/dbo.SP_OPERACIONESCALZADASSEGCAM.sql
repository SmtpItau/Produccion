USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONESCALZADASSEGCAM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONESCALZADASSEGCAM]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @observado    NUMERIC(12,04) ,
      @uf      NUMERIC(12,04) ,
      @fecha_observado  CHAR(10) ,
      @fecha_uf    CHAR(10) , 
  @entidad  char(40)
select @entidad = acnomprop from mfac
   EXECUTE sp_parametros_reporte @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
   
   SELECT 'numero_op_activo'       = a.ccopecmp                          ,
          'saldo_usd_activo'       = CASE
                                     WHEN c.cafecvcto <> b.acfecproc THEN
                                        a.ccmonto
                                     ELSE
                                        0
                                     END                                 ,
          'div_activo'             = CASE
                                     WHEN c.camtomon1 <> a.ccmonto THEN 
                                        a.ccmonto / c.camtomon1
                                     ELSE
                                        1
                                     END                                 ,
          'reajuste_tc_activo'     = CASE
                                     WHEN d.cafecha  = b.acfecproc AND
                                          c.cafecha <> b.acfecproc THEN
                                        0
                                     ELSE
                                        c.cadiftipcam
                                     END                                 ,
          'reajuste_uf_activo'     = CASE
                                     WHEN d.cafecha  = b.acfecproc AND
                                          c.cafecha <> b.acfecproc THEN
                                        0
                                     ELSE
                                        c.cadifuf
                                     END                                 ,
          'monto_devengado_activo' = c.cautildevenga + c.caperddevenga   ,
          'precio_tasa_activo'     = c.caprecal                          ,
          'moneda_activo'          = c.cacodmon2                         ,
          'numero_op_pasivo'       = a.ccopevta                          ,
          'saldo_usd_pasivo'       = CASE
                                     WHEN d.cafecvcto <> b.acfecproc THEN
                                        a.ccmonto
                                     ELSE
                                        0
                                     END                                 ,
          'div_pasivo'             = CASE
                                     WHEN d.camtomon1 <> a.ccmonto THEN 
                                        a.ccmonto / d.camtomon1
                                     ELSE
                                        1
                                     END                                 ,
          'reajuste_tc_pasivo'     = CASE
                                     WHEN c.cafecha  = b.acfecproc AND
                                          d.cafecha <> b.acfecproc THEN
                                        0
                                     ELSE
                                        d.cadiftipcam
                                     END                                 ,
          'reajuste_uf_pasivo'     = CASE
                                     WHEN c.cafecha  = b.acfecproc AND
                                          d.cafecha <> b.acfecproc THEN
                                        0
                                     ELSE
                                        d.cadifuf
                                     END                                 ,
          'monto_devengado_pasivo' = d.cautildevenga + d.caperddevenga   ,
          'precio_tasa_pasivo'     = d.caprecal                          ,
          'moneda_pasivo'          = d.cacodmon2                         ,
          'fecha_proceso'          = b.acfecproc,
		  'entidad'     = b.acnomprop
   INTO   #temporal
   FROM   mfcc a,
          mfac b,
          mfca c,
          mfca d
   WHERE  a.ccfecven   >= b.acfecproc AND
          a.ccopecmp    = c.canumoper AND
          (c.cacodpos1  = 1  OR
   c.cacodpos1 = 7 )           AND
          a.ccopevta    = d.canumoper AND
          (d.cacodpos1  = 1  OR
    d.cacodpos1 = 7 )
   ORDER BY a.ccopecmp
   IF EXISTS( SELECT * FROM #temporal ) 
 BEGIN
    SELECT 'numero_op_activo'       = numero_op_activo                                 ,
           'saldo_usd_activo'       = saldo_usd_activo                                 ,
           'reajuste_tc_activo'     = ROUND ( reajuste_tc_activo * div_activo, 0 )     ,
           'reajuste_uf_activo'     = ROUND ( reajuste_uf_activo * div_activo, 0 ) * -1,
           'monto_devengado_activo' = ROUND ( monto_devengado_activo * div_activo, 0 ) ,
           'precio_tasa_activo'     = precio_tasa_activo                               ,
           'moneda_activo'          = moneda_activo                                    ,
           'numero_op_pasivo'       = numero_op_pasivo                                 ,
           'saldo_usd_pasivo'       = saldo_usd_pasivo                                 ,
           'reajuste_tc_pasivo'     = ROUND ( reajuste_tc_pasivo * div_pasivo, 0 ) * -1,
           'reajuste_uf_pasivo'     = ROUND ( reajuste_uf_pasivo * div_pasivo, 0 )     ,
           'monto_devengado_pasivo' = ROUND ( monto_devengado_pasivo * div_pasivo, 0 ) ,
           'precio_tasa_pasivo'     = precio_tasa_pasivo                               ,
           'moneda_pasivo'          = moneda_pasivo                                    ,
           'fecha_proceso'          = CONVERT ( CHAR ( 10 ), fecha_proceso, 103 )      ,
           'valor_observado'        = @observado                                       ,
           'valor_uf'               = @uf                                              ,
           'fecha_observado'        = @fecha_observado                                 ,
           'fecha_uf'               = @fecha_uf                                        ,
           'hora'                   = CONVERT ( CHAR ( 8 ), GETDATE ( ), 108 )
    FROM   #temporal         
 END
   ELSE
 BEGIN
    SELECT 'numero_op_activo'       = 0,
           'saldo_usd_activo'       = 0,
           'reajuste_tc_activo'     = 0,
           'reajuste_uf_activo'     = 0,
           'monto_devengado_activo' = 0,
           'precio_tasa_activo'     = 0,
           'moneda_activo'          = '',
           'numero_op_pasivo'       = 0,
           'saldo_usd_pasivo'       = 0,
           'reajuste_tc_pasivo'     = 0,
           'reajuste_uf_pasivo'     = 0,
           'monto_devengado_pasivo' = 0,
           'precio_tasa_pasivo'     = 0,
           'moneda_pasivo'          = '',
           'fecha_proceso'          = '',
           'valor_observado'        = @observado                                       ,
           'valor_uf'               = @uf                                              ,
           'fecha_observado'        = @fecha_observado                                 ,
           'fecha_uf'               = @fecha_uf                                        ,
           'hora'                   = CONVERT ( CHAR ( 8 ), GETDATE ( ), 108 ),
		   'entidad'     =  @entidad
        
 END
 
   SET NOCOUNT OFF
END
-- sp_operacionescalzadassegcam
-- SELECT * FROM mfcc where ccopecmp = 28888
-- SELECT CONVERT ( CHAR ( 8 ), GETDATE ( ), 108 )

GO

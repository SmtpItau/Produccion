USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_TRAN_PEND]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_TRAN_PEND]
      (   @OPERADOR      CHAR(30)
         ,@DESDE         CHAR(10)
         ,@HASTA         CHAR(10)
      )
AS
BEGIN
  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8),
           @oma         char(3),
           @FecDesde    datetime,
           @FecHasta    datetime
   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
           @oma         output
   DECLARE @XFECPROC    DATETIME
   
   SELECT @FecDesde = CONVERT(DATETIME,@DESDE)
   SELECT @FecHasta = CONVERT(DATETIME,@HASTA)
IF EXISTS( SELECT 1 FROM  TRANSFERENCIA_PENDIENTE T
                         ,VIEW_PRODUCTO P
                    WHERE ( T.codigo_producto = 'OVER' OR T.codigo_producto = 'WEEK' )
                      AND   P.codigo_producto                            = T.codigo_producto
                      AND   P.id_sistema                                 = T.id_sistema
                      AND   T.fecha_operacion >= @DESDE      -- CONVERT( CHAR(10), T.fecha_operacion, 112 )  >= CONVERT( CHAR(10), @DESDE, 112 )
                      AND   T.fecha_operacion <= @HASTA      --CONVERT( CHAR(10), T.fecha_operacion, 112 )  <= CONVERT( CHAR(10), @HASTA, 112 )
)
BEGIN
   SELECT 
        'FECHA_OPER'      =   T.fecha_operacion
       ,'FECHA_VCTO'     =   T.fecha_vencimiento
       ,'ID_SISTEMA'     =   T.id_sistema
       ,'COD_PROD'       =   P.descripcion 
       ,'MERCADO'        =   T.tipo_mercado
       ,'NUM_OPE'        =   T.numero_operacion
       ,'COD_MON'        =   T.codigo_moneda
       ,'OPERACION'      =   T.tipo_operacion
       ,'MON_ORIG'       =   T.monto_original
       ,'MON_USD'        =   T.monto_dolares
       ,'MON_CLP'        =   T.monto_pesos
       ,'TIP_CAM'        =   T.tipo_cambio
       ,'PARIDAD'        =   T.paridad
       ,'CLIENTE'        =  ( SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE clrut = T.rut_cliente )
       ,'DESDE'          =   CONVERT(CHAR(10),@FecDesde,103)
       ,'HASTA'          =   CONVERT(CHAR(10),@FecHasta,103)
       ,'FECHA_EMI'      =   CONVERT( CHAR(10), GETDATE(), 103 )
       ,'FECHA_PROC'     =   @XFECPROC  --CONVERT( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
       ,'HORA'           =   CONVERT( CHAR(10), GETDATE(), 108 )
       ,'OPERADOR'       =   @OPERADOR
       ,'DIAS'           =   ( CASE T.tipo_operacion  WHEN 'C' THEN DATEDIFF( DD,  T.fecha_operacion, T.fecha_vencimiento )
                                                     WHEN 'V' THEN DATEDIFF( DD,  T.fecha_vencimiento, T.fecha_operacion )
                              END )
       ,'MONTOFUSD'      =  T.monto_final
       ,'CASAMATRIZ'     =  ( SELECT V.nombre FROM VIEW_PAIS V WHERE T.casa_matriz = V.codigo_pais )
 ,'acfecproc'      =@acfecproc
 ,'acfecprox'      =@acfecprox
 ,'uf_hoy'   =@uf_hoy
 ,'uf_man'   =@uf_man
 ,'ivp_hoy'   =@ivp_hoy
 ,'ivp_man'   =@ivp_man
 ,'do_hoy'   =@do_hoy
 ,'do_man'   =@do_man
 ,'da_hoy'   =@da_hoy
 ,'da_man'   =@da_man
 ,'pmnomprop'   =@acnomprop
 ,'rut_empresa'   =@rut_empresa
   FROM TRANSFERENCIA_PENDIENTE T
       ,VIEW_PRODUCTO P
WHERE ( T.codigo_producto = 'OVER' or T.codigo_producto = 'WEEK' )
     AND   P.codigo_producto = T.codigo_producto
     AND   P.id_sistema      = T.id_sistema
     AND   T.fecha_operacion >= @DESDE
     AND   T.fecha_operacion <= @HASTA
   ORDER BY T.numero_operacion
END ELSE
BEGIN
  SELECT 
        'FECHA_OPER'    =   ''
       ,'FECHA_VCTO'   =   '' 
       ,'ID_SISTEMA'   =   '' 
       ,'COD_PROD'     =   ''
       ,'MERCADO'      =   0
       ,'NUM_OPE'      =  '' 
       ,'COD_MON'      =   '' 
       ,'OPERACION'    =   0
       ,'MON_ORIG'     =   0
       ,'MON_USD'      =   0
       ,'MON_CLP'      =   0
       ,'TIP_CAM'      =   0
       ,'PARIDAD'      =   0
       ,'CLIENTE'      =   ''
       ,'DESDE'        =   CONVERT(CHAR(10),@FecDesde,103)
       ,'HASTA'        =   CONVERT(CHAR(10),@FecHasta,103)
 ,'FECHA_EMI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
       ,'FECHA_PROC'   =   CONVERT( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
       ,'HORA'         =   CONVERT( CHAR(10), GETDATE(), 108 )
       ,'OPERADOR'     =   @OPERADOR
       ,'DIAS'         =   ''
       ,'MONTOFUSD'    =  0
 ,'CASAMATRIZ' =  ''
 ,'acfecproc' =@acfecproc
 ,'acfecprox' =@acfecprox
 ,'uf_hoy' =@uf_hoy
 ,'uf_man' =@uf_man
 ,'ivp_hoy' =@ivp_hoy
 ,'ivp_man' =@ivp_man
 ,'do_hoy' =@do_hoy
 ,'do_man' =@do_man
 ,'da_hoy' =@da_hoy
 ,'da_man' =@da_man
 ,'pmnomprop' =@acnomprop
 ,'rut_empresa' =@rut_empresa
END
END

GO

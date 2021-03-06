USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOPERACIONESANULADAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFOPERACIONESANULADAS]    --'ADMINISTRA', '20010502', '20010502'
            (  
                @OPERADOR    CHAR(30)
               ,@DESDE       CHAR(10)
               ,@HASTA       CHAR(10)
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
           @hora        char(8)
   execute Sp_Base_Del_Informe
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
           @hora        OUTPUT
SET NOCOUNT ON
IF EXISTS ( SELECT 1   FROM  MEMO
                            ,VIEW_FORMA_DE_PAGO B
                            ,VIEW_FORMA_DE_PAGO C
                            ,VIEW_PRODUCTO P
                      WHERE morecib           =    C.codigo
                        AND moentre           =    B.codigo
                        AND motipope          <>   'A'
                        AND P.id_sistema      =    'BCC'
                        AND P.codigo_producto =    motipmer
                        AND moestatus         <>   'A'
                        AND CONVERT( CHAR(10), mofech, 112 ) >= CONVERT( CHAR(10), @DESDE, 112 )
                        AND CONVERT( CHAR(10), mofech, 112 ) <= CONVERT( CHAR(10), @HASTA, 112 )
                        AND CONVERT( CHAR(10), @HASTA, 112 ) <= CONVERT( CHAR(10), (SELECT acfecpro FROM MEAC) , 112 ) 
         )
BEGIN
SELECT 
        'Tipo_Merc'            = P.descripcion
        ,'Numero_Operacion'     = monumope
        ,'Tipo_Opera'           = motipope
        ,'NombreCliente'        = monomcli
        ,'Monto_Dolar'          = moussme
        ,'TipoCambio'           = moticam
        ,'Operador'             = @OPERADOR
        ,'Entregamos'           = b.glosa
        ,'Recibimos'            = b.glosa
        ,'Tipo_Transaccion'     = ''
        ,'Fech_Operacion'       = mofech
        ,'Desde'                = @DESDE
        ,'Hasta'                = @HASTA
        ,'Fecha_Proceso'        = CONVERT( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
        ,'Fecha_Sistema'        = CONVERT ( CHAR(10), GETDATE(), 103 )
        ,'hora'                 = @hora          
        ,'Producto'             = P.DESCRIPCION
 ,'acfecproc'  =@acfecproc
 ,'acfecprox'  =@acfecprox
 ,'uf_hoy'  =@uf_hoy
 ,'uf_man'  =@uf_man
 ,'ivp_hoy'  =@ivp_hoy
 ,'ivp_man'  =@ivp_man
 ,'do_hoy'  =@do_hoy
 ,'do_man'  =@do_man
 ,'da_hoy'  =@da_hoy
 ,'da_man'  =@da_man
   ,'pmnomprop'  =@acnomprop
   ,'rut_empresa'  =@rut_empresa
       
       
--  INTO #TEMP
  FROM  MEMO
       ,VIEW_FORMA_DE_PAGO B
       ,VIEW_FORMA_DE_PAGO C
       ,VIEW_PRODUCTO P
 WHERE morecib              =    C.codigo
   AND moentre              =    B.codigo
   AND motipope             <>   'A'
   AND P.id_sistema         =    'BCC'
   AND P.codigo_producto    =    motipmer
   AND moestatus            =    'A'
   AND CONVERT( CHAR(10), mofech, 112 ) >= CONVERT( CHAR(10), @DESDE, 112 )
   AND CONVERT( CHAR(10), mofech, 112 ) <= CONVERT( CHAR(10), @HASTA, 112 )
   AND CONVERT( CHAR(10), @HASTA, 112 ) <= CONVERT( CHAR(10), (SELECT acfecpro FROM MEAC), 112 ) 
--   SELECT * 
--     FROM #TEMP 
-- ORDER BY NombreCliente
--         ,TipoOpera
--         ,NoOpera
END ELSE
BEGIN
SELECT 
        'Tipo_Merc'            = ''
       ,'Numero_Operacion'     = ''
       ,'Tipo_Opera'           = ''
       ,'NombreCliente'        = ''
       ,'Monto_Dolar'          = ''
       ,'TipoCambio'           = ''
       ,'Operador'             = @OPERADOR
       ,'Entregamos'           = ''
       ,'Recibimos'            = ''
       ,'Tipo_Transaccion'     = ''
       ,'Fech_Operacion'       = CONVERT ( CHAR(10), GETDATE(), 103 )
       ,'Desde'                = @DESDE
       ,'Hasta'                = @HASTA
       ,'Fecha_Proceso'        = CONVERT ( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
       ,'Fecha_Sistema'        = CONVERT ( CHAR(10), GETDATE(), 103 )
       ,'hora'                 = @hora
       ,'Producto'             = ''
 ,'acfecproc'  =@acfecproc
 ,'acfecprox'  =@acfecprox
 ,'uf_hoy'  =@uf_hoy
 ,'uf_man'  =@uf_man
 ,'ivp_hoy'  =@ivp_hoy
 ,'ivp_man'  =@ivp_man
 ,'do_hoy'  =@do_hoy
 ,'do_man'  =@do_man
 ,'da_hoy'  =@da_hoy
 ,'da_man'  =@da_man
   ,'pmnomprop'  =@acnomprop
   ,'rut_empresa'  =@rut_empresa
END
SET NOCOUNT OFF
END

GO

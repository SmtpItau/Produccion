USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TRANSFERENCIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_TRANSFERENCIA]( @Numero_Operacion  NUMERIC(7) =  0 ,
                                        @Tipo                 CHAR(1) = '' ,
                                        @Correlativo          INTEGER =  0 )
AS
BEGIN
     SET NOCOUNT ON
     SELECT t.numero_operacion                                   , -- 1
            t.tipo                                               , -- 2
            'gTipo' = (CASE WHEN t.tipo = 'C' THEN 'Compra'
                            WHEN t.tipo = 'V' THEN 'Venta'
                                              ELSE 'Anulada' END), -- 3
            t.correlativo     , -- 4
            t.mt_32a_fecha    , -- 5
            t.mt_57_cuenta    , -- 6 
            t.codigo          , -- 7
            t.swift           , -- 8
            t.receptor        , -- 9
            t.mt_20           , -- 10
            t.mt_21           , -- 11
            t.mt_32a_fecha    , -- 12
            t.mt_32a_monto    , -- 13
            t.mt_32a_moneda   , -- 14
            t.mt_50           , -- 15
            t.mt_52_cuenta    , -- 16
            t.mt_52_swift     , -- 17
            t.mt_52_direccion , -- 18
            t.mt_53_cuenta    , -- 19
            t.mt_53_swift     , -- 20
            t.mt_53_sucursal  , -- 21
            t.mt_53_direccion , -- 22
            t.mt_54_cuenta    , -- 23
            t.mt_54_swift     , -- 24
            t.mt_54_sucursal  , -- 25
            t.mt_54_direccion , -- 26
            t.mt_56_cuenta    , -- 27
            t.mt_56_swift     , -- 28
            t.mt_56_direccion , -- 29
            t.mt_57_cuenta    , -- 30
            t.mt_57_swift     , -- 31
            t.mt_57_sucursal  , -- 32
            t.mt_57_direccion , -- 33
            t.mt_58_cuenta    , -- 34
            t.mt_58_swift     , -- 35
            t.mt_58_direccion , -- 36
            t.mt_59           , -- 37
            t.mt_70           , -- 38
            t.mt_71a          , -- 39
            t.mt_72           , -- 40
            t.estado          , -- 41
            'gEstado'         = (CASE t.estado WHEN 'A' THEN 'Aprobada' 
                                               WHEN 'E' THEN 'Eliminada' ELSE 'Pendiente' END), -- 42
            t.fecha           , -- 43
            t.usuario         , -- 44
            'nombre'          = t.usuario,  --ISNULL( u.nombre, t.usuario), -- 45
 
            'titulo'          = (CASE WHEN t.codigo = 100 THEN 'Transferencia de Cliente'
                                      WHEN t.codigo = 200 THEN 'Transferencias Bancarias por cuenta propia'
                                      WHEN t.codigo = 202 THEN 'Transferencia Bancaria simple a favor de un tercer Banco'
                                                          ELSE 'Transferencia ...' END)
        
       FROM tbTransferencia  t,
     memo      p
--            gen_usuarios     u
      WHERE (t.numero_operacion = @Numero_Operacion OR @Numero_Operacion =  0)
        AND (t.tipo             = @Tipo             OR @Tipo             = '')
        AND (t.correlativo      = @Correlativo      OR @Correlativo      =  0)
        AND  t.numero_operacion = p.MONUMOPE
--        AND  t.usuario         *= u.usuario
      ORDER BY t.numero_operacion, t.tipo, t.correlativo
END



GO

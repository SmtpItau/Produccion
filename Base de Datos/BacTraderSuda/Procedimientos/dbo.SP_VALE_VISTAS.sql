USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALE_VISTAS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALE_VISTAS]
   (
   @estado        CHAR(1) --NUMERIC (09,0),
  ,@fecha_inicio  DATETIME
  ,@fecha_termino DATETIME
   )
AS
BEGIN
IF EXISTS (SELECT * FROM VALE_VISTA_EMITIDO
                   WHERE documento_estado    = @estado 
                     AND fecha_emision BETWEEN  @fecha_inicio  AND   @fecha_termino
   )
BEGIN
SELECT
            'FECHA GENERACION'   = fecha_generacion
           ,'FECHA_EMISION'      = fecha_emision
           ,'FORMA_PAGO'         = forma_pago
           ,'ID_SISTEMA'         = ( CASE id_sistema  WHEN 'BCC' THEN 'BAC CAMBIO'
                                                      WHEN 'BTR' THEN 'BAC TRADER'
                                                      WHEN 'FRW' THEN 'BAC FORWARD' END )
           ,'COD_PRODUCTO'       = codigo_producto
           ,'NUMERO_OPERACION'   = numero_operacion
           ,'RUT_CLIENTE'        = rut_cliente
           ,'COD_CLIENTE'        = codigo_cliente
           ,'DOCUMENTO_MONTO'    = documento_monto
           ,'DOCUMENTO_NUMERO'   = documento_numero 
           ,'DOCUMENTO_ESTADO'   = ( CASE documento_estado WHEN 'E' THEN 'EMITIDO'
                                                          WHEN 'G' THEN 'GENERADO'
                                                          WHEN 'A' THEN 'ANULADO' END )
           ,'DOCUMENTO_DIVIDE'   = documento_divide
           ,'DOCUMENTO_PROTEJE'  = documento_protege
           ,'NOMBRE_CLIENTE'     = nombre_cliente
           ,'CODIGO_TRANSACCION' = codigo_transaccion
           ,'NUMERO_CTA_CTE'     = numero_ctacte
           ,'CODIGO_SUCURSAL'    = codigo_sucursal
           ,'CONCEPTO'           = concepto
 FROM 
      VALE_VISTA_EMITIDO
      
 WHERE documento_estado = @estado 
   AND fecha_emision BETWEEN  @fecha_inicio  AND   @fecha_termino
END 
ELSE
BEGIN
    SELECT 
            'FECHA GENERACION'   = ''
           ,'FECHA_EMISION'      = ''
           ,'FORMA_PAGO'         = 0
           ,'ID_SISTEMA'         = ''
           ,'COD_PRODUCTO'       = ''
           ,'NUMERO_OPERACION'   = 0
           ,'RUT_CLIENTE'        = 0
           ,'COD_CLIENTE'        = 0
           ,'DOCUMENTO_MONTO'    = 0
           ,'DOCUMENTO_NUMERO'   = 0 
           ,'DOCUMENTO_ESTADO'   = ''
           ,'DOCUMENTO_DIVIDE'   = ''
           ,'DOCUMENTO_PROTEJE'  = ''
           ,'NOMBRE_CLIENTE'     = ''
           ,'CODIGO_TRANSACCION' = ''
           ,'NUMERO_CTA_CTE'     = ''
           ,'CODIGO_SUCURSAL'    = ''
           ,'CONCEPTO'           = ''
END
END


GO

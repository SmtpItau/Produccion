USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AVISO_CTACTE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AVISO_CTACTE]
     
AS
BEGIN
IF EXISTS (SELECT * FROM VALE_VISTA_EMITIDO
                   WHERE forma_pago=11
    )
BEGIN
SELECT
 'NombreCliente'  = isnull(nombre_cliente,''),
 'Direccion'  = (SELECT isnull(cldirecc,'')  from VIEW_CLIENTE where rut_cliente=clrut and codigo_cliente=clcodigo),
 'Comuna'  = (SELECT isnull(nombre,'') from VIEW_COMUNA ,VIEW_CLIENTE C where rut_cliente=clrut and codigo_cliente=clcodigo and codigo_comuna=clcomuna),
 'FechaEmision'   = isnull(fecha_emision,''),
 'Oficina'  = isnull(codigo_sucursal,0),
 'NumeroCtaCte'   = isnull(numero_ctacte,''),
 'CodigoTransac'  = (CASE codigo_transaccion WHEN 'A' THEN 'ABONO'
                 WHEN 'C' THEN 'CARGO' END),
 'CodOperacion'  = isnull(numero_operacion,0),
 'Monto'   = isnull(documento_monto,0),
 'Concepto'  = isnull(concepto,'')
     
 FROM 
      VALE_VISTA_EMITIDO
      
 WHERE forma_pago=11
END 
ELSE
BEGIN
    SELECT 
 'NombreCliente'  = '',
 'Direccion'  = '',
 'Comuna'  = '',
 'FechaEmision'   = '',
 'Oficina'  = 0,
 'NumeroCtaCte'   = '',
 'CodigoTransac'  = '',
 'CodOperacion'  = 0,
 'Monto'   = 0,
 'Concepto'  = ''
END
END


GO

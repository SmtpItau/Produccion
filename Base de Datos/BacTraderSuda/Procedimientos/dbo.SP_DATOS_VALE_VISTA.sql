USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_VALE_VISTA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOS_VALE_VISTA]
AS
BEGIN
 SELECT 
  'FechaGeneracion'  = v.Fecha_Generacion,
  'FechaEmision'    = v.Fecha_Emision,
  'FormaPago'    = (SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE v.forma_pago=codigo), 
  'IdSistema'    = (SELECT nombre_sistema FROM SISTEMA_CNT S WHERE s.id_sistema=v.id_sistema), 
  'CodigoProducto'   = (SELECT descripcion FROM VIEW_PRODUCTO P WHERE p.codigo_producto=v.codigo_producto), 
  'NumeroOperacion'  = v.Numero_Operacion,
  'RutCliente'    = v.Rut_Cliente,
  'CodigoCliente'    = v.Codigo_Cliente,
  'DvCliente'    = (SELECT ISNULL(cldv,' ') FROM VIEW_CLIENTE WHERE v.Rut_Cliente = clrut and  v.Codigo_Cliente = clcodigo ),
 -- 'NombreCliente'    = (SELECT ISNULL(clnombre,'') FROM VIEW_CLIENTE WHERE v.Rut_Cliente = clrut and  v.Codigo_Cliente = clcodigo ),  
  'NombreCliente'    = v.Nombre_Cliente,
  'DocumentoValor'   = v.Documento_Monto,
  'DocumentoNumero'  = v.Documento_Numero,
  'DocumentoEstado'  = v.Documento_Estado,
  'DocumentoDivide'  = v.Documento_Divide,
  'DocumentoProtege' = v.Documento_Protege,
  'CodigoTransaccion'= v.Codigo_Transaccion,
  'NumeroCtaCte'     = v.Numero_CtaCte
  
 FROM
  VALE_VISTA_EMITIDO V
 
END


GO

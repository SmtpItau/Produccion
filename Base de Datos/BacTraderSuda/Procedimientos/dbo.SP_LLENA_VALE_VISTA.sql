USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_VALE_VISTA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_VALE_VISTA]
  (  @FechaGeneracion        datetime ,
   @FechaEmision  datetime ,
   @FormaPago  numeric(5) ,
   @IdSistema  char(3)  ,
   @CodigoProducto  char(5)  ,
   @NumeroOperacion numeric(10) ,
   @RutCliente  numeric(9) ,
   @CodigoCliente        numeric(1)   ,
   @DocumentoMonto  numeric(19) ,
   @DocumentoNumero numeric(19) ,
   @DocumentoEstado char(1)  ,
   @DocumentoDivide char(1)  ,
   @DocumentoProtege char(1)
           )
AS
BEGIN
SET NOCOUNT ON
IF @DocumentoEstado<>'A'
 BEGIN
  IF NOT EXISTS(SELECT * FROM VALE_VISTA_EMITIDO WHERE @RutCliente = Rut_Cliente and @CodigoCliente = Codigo_Cliente  and @NumeroOperacion = Numero_Operacion)
  BEGIN
      INSERT INTO VALE_VISTA_EMITIDO
   (  Fecha_Generacion ,  
    Fecha_Emision  ,
    Forma_Pago  ,
    Id_Sistema  ,
    Codigo_Producto  ,
    Numero_Operacion ,
    Rut_Cliente  ,
    Codigo_Cliente  ,
    Documento_Monto  ,
    Documento_Numero ,
    Documento_Estado ,
    Documento_Divide ,
    Documento_Protege
   
   )
      VALUES(  @FechaGeneracion ,  
    @FechaEmision  ,
    @FormaPago  ,
    @IdSistema  ,
    @CodigoProducto  ,
    @NumeroOperacion ,
    @RutCliente  ,
    @CodigoCliente  ,
    @DocumentoMonto  ,
    @DocumentoNumero ,
    @DocumentoEstado ,
    @DocumentoDivide ,
    @DocumentoProtege
   )   
 
  END
 END
ELSE
 IF EXISTS(SELECT * FROM VALE_VISTA_EMITIDO WHERE @RutCliente = Rut_Cliente and @CodigoCliente = Codigo_Cliente  and @NumeroOperacion=Numero_Operacion)  
 BEGIN
  UPDATE VALE_VISTA_EMITIDO 
  SET    Documento_Estado = @DocumentoEstado 
         WHERE  @RutCliente = Rut_Cliente 
  and    @CodigoCliente = Codigo_Cliente
  and    @NumeroOperacion = Numero_Operacion  
 END
 if @@error <> 0 
  SELECT 'NO', 'NO GRABA INFORMACION'
 else
  SELECT 'SI', ''
 return 0
end   


GO

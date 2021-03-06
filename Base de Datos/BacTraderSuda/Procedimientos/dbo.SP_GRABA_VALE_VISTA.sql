USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VALE_VISTA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_VALE_VISTA]
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
   @DocumentoProtege char(1)  ,
   @NombreCliente  char(50)
                 )
AS
BEGIN
SET NOCOUNT ON
-- BEGIN
   
                --IF NOT EXISTS(SELECT * FROM VALE_VISTA_EMITIDO WHERE @RutCliente = Rut_Cliente and @CodigoCliente = Codigo_Cliente  and @NumeroOperacion = Numero_Operacion)
  
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
    Documento_Protege ,
    Nombre_Cliente
   
   )
      VALUES(  ISNULL(@FechaGeneracion,'') ,  
    ISNULL(@FechaEmision,'') ,
    ISNULL(@FormaPago,0)  ,
    ISNULL(@IdSistema,'')  ,
    ISNULL(@CodigoProducto,'') ,
    ISNULL(@NumeroOperacion,0) ,
    ISNULL(@RutCliente,0)  ,
    ISNULL(@CodigoCliente,0) ,
    ISNULL(@DocumentoMonto,0) ,
    ISNULL(@DocumentoNumero,0) ,
    ISNULL(@DocumentoEstado,'') ,
    ISNULL(@DocumentoDivide,'') ,
    ISNULL(@DocumentoProtege,'') ,
    ISNULL(@NombreCliente,'')
   )   
 
  END
-- END
/* IF EXISTS(SELECT * FROM VALE_VISTA_EMITIDO WHERE @RutCliente = Rut_Cliente and @CodigoCliente = Codigo_Cliente  and @NumeroOperacion=Numero_Operacion)  
 BEGIN
  UPDATE VALE_VISTA_EMITIDO 
  SET    Documento_Estado = @DocumentoEstado ,
         Documento_Monto=@DocumentoMonto   
         WHERE  @RutCliente = Rut_Cliente 
  and    @CodigoCliente = Codigo_Cliente
  and    @NumeroOperacion = Numero_Operacion  
 END*/
 
end   

GO

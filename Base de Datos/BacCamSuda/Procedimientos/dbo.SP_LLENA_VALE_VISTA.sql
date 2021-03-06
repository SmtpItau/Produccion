USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_VALE_VISTA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_VALE_VISTA]
  (  
                        @FechaGeneracion        datetime ,
   @FechaEmision  datetime ,
   @FormaPago  numeric(5) ,
   @IdSistema  char(3)  ,
   @CodigoProducto  char(5)  ,
   @NumeroOperacion numeric(10) ,
   @RutCliente  numeric(9) ,
   @CodigoCliente        numeric(1)   ,
   @DocumentoMonto  numeric(19) ,
   @DocumentoNumero numeric(10) ,
   @DocumentoEstado char(1)  ,
   @DocumentoDivide char(1)  ,
   @DocumentoProtege char(1)  ,
                        @nombre_cliente         Char(50)        , 
   @CodigoTransaccion char(1)  ,
   @NumeroCtaCte  varchar(15) ,
   @CodigoSucursal  varchar(5) ,
   @Concepto  varchar(50) ,   
   @TipoOperacion  char(3)
              )
AS
BEGIN
SET NOCOUNT ON
IF @DocumentoEstado<>'A'
BEGIN
  IF NOT EXISTS(SELECT * FROM VIEW_VALE_VISTA_EMITIDO WHERE @NumeroOperacion  = Numero_Operacion)
--@RutCliente       = Rut_Cliente 
--@CodigoCliente    = Codigo_Cliente  
  BEGIN
      INSERT INTO VIEW_VALE_VISTA_EMITIDO
   (  
                                Fecha_Generacion ,  
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
                                Nombre_Cliente          ,
    Codigo_Transaccion ,
    Numero_CtaCte  ,
    Codigo_Sucursal  ,
    Concepto  ,
    Tipo_Operacion  
   )
      VALUES
                        (  
                                @FechaGeneracion ,  
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
    @DocumentoProtege ,
                                @Nombre_Cliente         ,
    @CodigoTransaccion ,
    @NumeroCtaCte  ,
    @CodigoSucursal  ,
    @Concepto  ,
    @TipoOperacion     
   )   
 
  END
 END
ELSE
 IF EXISTS(SELECT * FROM VIEW_VALE_VISTA_EMITIDO 
                          WHERE @NumeroOperacion = Numero_Operacion)  
--                            @RutCliente      = Rut_Cliente    
--                            AND @CodigoCliente   = Codigo_Cliente  
--                            AND 
 BEGIN
          UPDATE VIEW_VALE_VISTA_EMITIDO 
   SET    Documento_Estado    = @DocumentoEstado 
   WHERE  @NumeroOperacion    = Numero_Operacion  
---                 @RutCliente         = Rut_Cliente 
--   AND    @CodigoCliente      = Codigo_Cliente--
--   AND    
 END
 IF @@ERROR <> 0 
 --SELECT 'NO', 'NO GRABA INFORMACION'
          RETURN 
 ELSE
 --SELECT 'SI', ''
 
RETURN 0
END
GO

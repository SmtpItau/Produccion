USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACTRASRECEPLINCRE_GRABA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACTRASRECEPLINCRE_GRABA] (
                                                            @rut_cliente  NUMERIC(9),
                                                            @codigo_cliente  NUMERIC(9),
                                                            @id_sistema   CHAR(3),
                                                            @codigo_producto  CHAR(5),
                                                            @tipo_operacion  VARCHAR(2),
                                                            @tipo_riesgo  VARCHAR(1),
                                                            @fechainicio  DATETIME,
                                                            @fechavencimiento  DATETIME,
                                                            @montooriginal  NUMERIC(19),
                                                            @tipocambio   NUMERIC(8),
                                                            @matrizriesgo  NUMERIC(8),
                                                            @montotransaccion  NUMERIC(19),
                                                            @operador   CHAR(10),
                                                            @activo   CHAR(1),
           @usuarioautorizo  CHAR(15),
                        @sistemarecibio             CHAR(3)
                                                         )
AS
BEGIN
 DECLARE
 @numoperacion NUMERIC(10)  
 SET NOCOUNT ON
 SET @numoperacion = (SELECT numerotraspaso FROM control_financiero) + 1   
 BEGIN TRANSACTION
 IF NOT EXISTS(SELECT 1 FROM LINEA_TRANSACCION WHERE numerooperacion = @numoperacion) 
 BEGIN
      
  INSERT INTO LINEA_TRANSACCION 
                                                        (
                                                             NumeroOperacion
                                                            ,NumeroDocumento
                                                            ,NumeroCorrelativo
                                                            ,Rut_Cliente
                                                            ,Codigo_Cliente
                                                            ,Id_Sistema
                                                            ,Codigo_Producto
                                                            ,Tipo_Operacion
                                                            ,Tipo_Riesgo
                                                            ,FechaInicio
                                                            ,FechaVencimiento
                                                            ,MontoOriginal
                                                            ,TipoCambio
                                                            ,MatrizRiesgo
                                                            ,MontoTransaccion
                                                            ,Operador
                                                            ,Activo
                                                        )
                                              VALUES (
         
                                                            @numoperacion  ,
                                                            @numoperacion  ,
                                                            1                           ,
                                                            @rut_cliente  ,
                                                            @codigo_cliente  ,
                                                            @id_sistema   ,
                                                            @codigo_producto  ,
                                                            @tipo_operacion  ,
                                                            @tipo_riesgo  ,
                                                            @fechainicio  ,
                                                            @fechavencimiento  ,
                                                            @montooriginal  ,
                                                            @tipocambio   ,
                                                            @matrizriesgo  ,
                                                            @montotransaccion  ,
                                                            @operador   ,
                                                            @activo   
       )
  IF @@ERROR<>0
     BEGIN
   ROLLBACK TRANSACTION
   SELECT 'ERROR'
   RETURN
  END
 
      
  INSERT INTO LINEA_TRASPASO  
                                                        (
                                        NumeroTraspaso
                                                            ,NumeroOperacion
                                                            ,NumeroDocumento
                                                            ,NumeroCorrelativo
                                       ,Rut_Cliente
                                       ,Codigo_Cliente
                                       ,Id_Sistema
                                       ,Codigo_Producto
                                       ,SistemaRecibio
                                       ,TipoOperacion
                                       ,FechaInicio
                                       ,FechaVencimiento
                                       ,Operador
                                       ,MontoTraspasado
                                       ,UsuarioAutorizo
                                       ,Activo
                                                        )
                                          VALUES (    
                                                     @numoperacion  ,
                                                 @numoperacion  ,
                                                 @numoperacion  ,
                                                 1                  ,
                                                     @rut_cliente  ,
                                                      @codigo_cliente  ,
                                                  @id_sistema   ,
                                                      @codigo_producto  ,
                                                     @sistemarecibio  ,
                                                     @tipo_operacion  ,
                                                     @fechainicio  ,
                                                     @fechavencimiento  ,
                                                     @operador   ,
                                                            @montotransaccion  ,
                                                     @usuarioautorizo  ,
                                          @Activo
       )
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'ERROR'
   RETURN
  END
  UPDATE CONTROL_FINANCIERO SET numerotraspaso = @numoperacion 
  SELECT 'Retorno' = @numoperacion
  
  COMMIT TRANSACTION
    END
 ELSE 
    BEGIN
  ROLLBACK TRANSACTION
  SELECT 'NO EXISTE'
        END 
 SET NOCOUNT OFF
END
GO

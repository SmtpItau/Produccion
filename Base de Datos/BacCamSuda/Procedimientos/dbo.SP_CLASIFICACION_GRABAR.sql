USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLASIFICACION_GRABAR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLASIFICACION_GRABAR]
       (   
           @clas_cliente    NUMERIC   (05,0)
          ,@cod_moneda      NUMERIC   (05,0)
          ,@men_swift       VARCHAR   (06)
          ,@tipo_mercado    CHAR      (04)
          ,@tipo_operacion  CHAR      (01)
          ,@id_sistema      CHAR      (03)
          ,@cod_producto    CHAR      (03) 
       )
AS            
BEGIN
             
     SET NOCOUNT ON 
     IF EXISTS( SELECT 1 FROM SWIFT_CLASIFICACION WHERE id_sistema      = @id_sistema
                                                    AND codigo_producto = @tipo_mercado
                                                    AND tipo_mercado    = @tipo_mercado
                                                    AND codigo_moneda   = @cod_moneda
                                                    AND tipo_operacion  = @tipo_operacion)
     BEGIN
     
         UPDATE SWIFT_CLASIFICACION   
            SET clasificacion_cliente = @clas_cliente  
              , codigo_moneda         = @cod_moneda
              , codigo_mensaje_swift  = @men_swift
              , tipo_mercado          = @tipo_mercado
              , tipo_operacion        = @tipo_operacioN
         WHERE id_sistema      = @id_sistema
           AND codigo_producto = @tipo_mercado
           AND tipo_mercado    = @tipo_mercado
           AND codigo_moneda   = @cod_moneda
           AND tipo_operacion  = @tipo_operacion
      IF @@ERROR <>0 
      BEGIN
         SELECT -1, 'ERROR AL ACTUALIZAR LOS DATOS'
         RETURN
      END ELSE
      BEGIN
         SELECT 0, 'ACTUALIZACION REALIZADA CON EXITO'
         RETURN         
      END
     END ELSE BEGIN
         INSERT INTO SWIFT_CLASIFICACION 
              (   
                  clasificacion_cliente
                 ,codigo_moneda 
                 ,codigo_mensaje_swift
                 ,tipo_mercado
                 ,tipo_operacion
                 ,id_sistema
                 ,codigo_producto
              )
           VALUES
              (
                @clas_cliente
               ,@cod_moneda
               ,@men_swift
               ,@tipo_mercado
               ,@tipo_Operacion
               ,@id_sistema
               ,@cod_producto
             )
      
      IF @@ERROR <> 0 
      BEGIN
         SELECT -1, 'ERROR AL GRABAR'
         RETURN
      END ELSE
      BEGIN
         SELECT 0, 'GRABACION REALIZADA CON EXITO'
         RETURN
      END      
END
SET NOCOUNT OFF
END
SELECT * FROM SWIFT_CLASIFICACION   



GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CAMPO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- drop PROCEDURE dbo.SP_GRABAR_CAMPO
CREATE PROCEDURE [dbo].[SP_GRABAR_CAMPO]( @Id_Sistema                 CHAR( 3),
                                  @Tipo_Movimiento            CHAR( 3),  
                                  @Tipo_Operacion             CHAR( 3),  
                                  @Codigo_Campo            NUMERIC( 3),
                                  @descripcion_campo          char(60),
                                  @nombre_campo_tabla         char(40),
                                  @tipo_administracion_campo  char( 1),
                                  @tabla_campo                char(20),
                                  @campo_tabla                char(30),
                                  @campos_tablas              char(30)
                                 )
AS
BEGIN
SET NOCOUNT ON
BEGIN TRANSACTION
     IF EXISTS (SELECT 1 FROM CAMPO_CNT WHERE id_Sistema      = @Id_Sistema
                                               AND tipo_movimiento = @Tipo_Movimiento
                                               AND tipo_operacion  = @Tipo_Operacion
                                               AND codigo_campo    = @Codigo_Campo    )
        BEGIN
             DELETE FROM CAMPO_CNT WHERE id_Sistema      = @Id_Sistema
                                          AND tipo_movimiento = @Tipo_Movimiento
                                          AND tipo_operacion  = @Tipo_Operacion
                                          AND codigo_campo    = @Codigo_Campo   
             IF @@error <> 0
             BEGIN
                  ROLLBACK TRANSACTION
                  SELECT -1, 'No se puede actualizar Valor a Tablas Contables'
                  RETURN
             END
        END
     --<< Valida existencia de Campo
     SELECT @tipo_administracion_campo  = ''
     SELECT @nombre_campo_tabla         = nombre_campo_tabla        ,
            @tipo_administracion_campo  = tipo_administracion_campo ,
            @tabla_campo                = tabla_campo               ,
            @campo_tabla                = campo_tabla               ,
            @campos_tablas              = campos_tablas             
       FROM CAMPO_CNT 
      WHERE id_sistema      = @Id_Sistema
        AND tipo_movimiento = ''
        AND tipo_operacion  = ''
        AND codigo_campo    = @Codigo_Campo    
   
     IF @tipo_administracion_campo = ''
     BEGIN
          ROLLBACK TRANSACTION
          SELECT -1, 'Valor Contable No Existe'
          RETURN
     END
     INSERT INTO CAMPO_CNT VALUES( @Id_Sistema                 ,
                                        @Tipo_Movimiento            ,  
                                        @Tipo_Operacion             ,  
                                        @Codigo_Campo               ,
                                        @descripcion_campo          ,
                                        @nombre_campo_tabla         ,
                                        @tipo_administracion_campo  ,
                                        @tabla_campo                ,
                                        @campo_tabla                ,
                                        @campos_tablas              )
    IF @@error <> 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'No se puede agregar Valor a Tablas Contables'
         RETURN
    end else 
    begin 
     COMMIT TRANSACTION   
     SELECT 0,'se agrego Valor a Tablas Contables'
     SET NOCOUNT OFF
    END
  
  --SELECT 
END
--sp_Grabar_Campo 'BFW', 'MOV', '2V', 415, 'Artículo 84..', 'Articulo84', 'F', '', '', ''
GO

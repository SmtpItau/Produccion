USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_SWIFT_MENSAJE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_SWIFT_MENSAJE]
         (
             @CODIGO_MENSAJE      VARCHAR(6)
            ,@CAMPO_TIPO          CHAR(1)
            ,@CAMPO_OPCION        CHAR(1)
            ,@CAMPO_DESCRIPCION   VARCHAR(50)
            ,@CODIGO_NOMBRE       VARCHAR(5)
            ,@CAMPO_ACTIVO        CHAR(1)
         )
AS
BEGIN
IF NOT EXISTS( SELECT 1 FROM  SWIFT_MENSAJE WHERE  codigo_mensaje_swift = @CODIGO_MENSAJE
                                              AND  campo_nombre         = @CODIGO_NOMBRE
                                              AND  campo_opcion         = @CAMPO_OPCION
                                              AND  campo_tipo           = @CAMPO_TIPO )
BEGIN
   INSERT SWIFT_MENSAJE
      (  codigo_mensaje_swift
         ,campo_nombre
         ,campo_descripcion
         ,campo_opcion
         ,campo_tipo
         ,campo_activo   )
   VALUES
      (   @CODIGO_MENSAJE
         ,@CODIGO_NOMBRE
         ,@CAMPO_DESCRIPCION
         ,@CAMPO_OPCION
         ,@CAMPO_TIPO
         ,@CAMPO_ACTIVO    )      
END ELSE
BEGIN
   UPDATE SWIFT_MENSAJE
   SET    campo_descripcion    = @CAMPO_DESCRIPCION
         ,campo_activo         = @CAMPO_ACTIVO
   WHERE  codigo_mensaje_swift = @CODIGO_MENSAJE
     AND  campo_nombre         = @CODIGO_NOMBRE
     AND  campo_opcion         = @CAMPO_OPCION
     AND  campo_tipo           = @CAMPO_TIPO
END
END
--   delete view_usuario_activo
--   sp_help SWIFT_MENSAJE



GO

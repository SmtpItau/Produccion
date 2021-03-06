USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CREA_USUARIOS    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
CREATE PROCEDURE [dbo].[SP_CREA_USUARIOS]( @tipo          CHAR(1)  ,
                               @usuario       CHAR(15) ,
                               @clave         CHAR(15) ,
                               @nombre        CHAR(40) ,
                               @tipo_usuario  CHAR(15) ,
                               @fecha_expira  DATETIME )
AS
BEGIN
IF @Tipo = 'B'
   SELECT nombre,
          tipo_usuario,
          CONVERT(CHAR(10), fecha_expira, 103),
          clave
     FROM USUARIO
    WHERE usuario = @usuario
IF @tipo = 'E' OR @tipo = 'G'
BEGIN 
   
   DELETE FROM CONTROL_USUARIO  WHERE usuario = @usuario  
   
   DELETE USUARIO WHERE usuario = @usuario
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO USUARIO.'
      RETURN 1
   END     
   IF @Tipo = 'E' 
   BEGIN
      DELETE GEN_PRIVILEGIOS WHERE usuario = @usuario AND tipo_privilegio = 'U'
      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
         RETURN 1
      END
   END
END
IF @Tipo = 'G'
BEGIN 
   ----DELETE FROM Control_Usuario  WHERE Usuario = @Usuario
   INSERT Usuario( usuario,
                        clave,
                        nombre,
                        tipo_usuario,
                        fecha_expira,
                        cambio_clave )
                VALUES( @usuario,
                        @clave,
                        @nombre,
                        @tipo_usuario,
                        @fecha_expira,
                        'S' )
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
      RETURN 1
   END
END
RETURN 0
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM GEN_PRIVILEGIOS
GO

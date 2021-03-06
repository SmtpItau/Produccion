USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Crea_Usuarios]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Sp_Crea_Usuarios]( @tipo          CHAR(1)  ,
                               @usuario       CHAR(15) ,
                               @clave         CHAR(15) ,
                               @nombre        CHAR(40) ,
                               @tipo_usuario  CHAR(15) ,
                               @fecha_expira  DATETIME )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


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
      DELETE PRIVILEGIO WHERE usuario = @usuario AND tipo_privilegio = 'U'

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


GO

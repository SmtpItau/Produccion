USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Usuarios]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_Graba_Usuarios]( 	@Tipo          CHAR(1)  ,
                               		@Usuario       CHAR(15) ,
	                               	@Clave         CHAR(15) ,
        	                       	@Nombre        CHAR(40) ,
                	               	@Tipo_Usuario  CHAR(15) ,
                        	       	@Fecha_Expira  DATETIME ,
				       	@email		CHAR(100) = ' '
				)
AS
BEGIN


   SET DATEFORMAT dmy
   SET NOCOUNT ON

IF @Tipo = 'B'

    IF EXISTS(SELECT NOMBRE FROM USUARIO WHERE USUARIO = @USUARIO AND ACTIVO = 'N')
    BEGIN

	SELECT 'NO ACTIVO','Nombre de Usuario ya fue utilizado'	
	RETURN
    END

   SELECT nombre,
          tipo_usuario,
          CONVERT(CHAR(10), Fecha_Expira, 103),
          clave,
          clase,
          codigo_area,
	  mail_usuario
     FROM USUARIO
    WHERE usuario = @Usuario

IF @Tipo = 'E' OR @Tipo = 'G'
BEGIN 
   
   DELETE USUARIO WHERE usuario = @Usuario
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO USUARIO.'
      RETURN 1
   END     

   IF @Tipo = 'E' 
   BEGIN
      DELETE PRIVILEGIO WHERE usuario = @Usuario AND tipo_privilegio = 'U'

      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
         RETURN 1
      END
   END

END

IF @Tipo = 'G'
BEGIN 

   INSERT USUARIO( usuario,
                        clave,
                        nombre,
                        tipo_usuario,
                        fecha_expira,
                        cambio_clave ,
			mail_usuario)
                VALUES( @Usuario,
                        @Clave,
                        @Nombre,
                        @Tipo_Usuario,
                        @Fecha_Expira,
                        'S' ,
			@email)

   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
      RETURN 1
   END

END

END


GO

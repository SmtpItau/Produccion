USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_USUARIOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_USUARIOS]( @Tipo          CHAR(1)  ,
                               @Usuario       CHAR(15) ,
                               @Clave         CHAR(15) ,
                               @Nombre        CHAR(40) ,
                               @Tipo_Usuario  CHAR(15) ,
                               @Fecha_Expira  DATETIME ,
			       @reset_psw     CHAR(1)	)
AS
BEGIN

	SET NOCOUNT ON

IF @Tipo = 'B'
   SELECT nombre,
          tipo_usuario,
          CONVERT(CHAR(10), Fecha_Expira, 103),
          clave,
          clase,
          Largo_clave,
	  short_circuit
     FROM USUARIO
    WHERE usuario = @Usuario

IF @Tipo = 'E' OR @Tipo = 'G'
BEGIN 
   
----   DELETE FROM Control_Usuario  WHERE Usuario = @Usuario  
   
   DELETE USUARIO WHERE usuario = @Usuario
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO USUARIO.'
      RETURN 1
   END     

   IF @Tipo = 'E' 
   BEGIN
      DELETE GEN_PRIVILEGIOS WHERE usuario = @Usuario AND tipo_privilegio = 'U'

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

   INSERT USUARIO( usuario,
                        clave,
                        nombre,
                        tipo_usuario,
                        fecha_expira,
                        cambio_clave,
			reset_psw )
                VALUES( @Usuario,
                        @Clave,
                        @Nombre,
                        @Tipo_Usuario,
                        @Fecha_Expira,
                        'S',
			'1' )

   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
      RETURN 1
   END
END

RETURN 0

SET NOCOUNT OFF

END   /* FIN PROCEDIMIENTO */


--SELECT * FROM GEN_PRIVILEGIOS
-- SP_GRABA_USUARIOS 'B','PEPE','','','',''
-- SELECT * FROM GEN_USUARIOS
GO

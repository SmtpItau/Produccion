USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TIPOS_USUARIO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_TIPOS_USUARIO]
       ( 
        @Tipo            CHAR(01),
        @Tipo_Usuario    CHAR(15),
        @Descripcion     CHAR(40),
        @Tipo_Clave      CHAR(01),
        @Largo_Clave     NUMERIC(02),                                            
        @Dias_Expiracion NUMERIC(05)
       )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF @Tipo = 'B'
   BEGIN
      SELECT       Descripcion,
                   (CASE WHEN EXISTS(SELECT 1 FROM USUARIO WHERE tipo_usuario = @Tipo_Usuario) THEN 'S' ELSE 'N' END),
                   Tipo_Clave,
                   Largo_Clave,
                   Dias_Expiracion    
             FROM  TIPO_USUARIO 
             WHERE tipo_usuario = @Tipo_Usuario

   END ELSE IF @Tipo = 'E'
   BEGIN 
   
      DELETE PRIVILEGIO WHERE usuario = @Tipo_Usuario AND tipo_privilegio = 'T'

      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE TIPO DE USUARIO.'
         SET NOCOUNT OFF
         RETURN 1

      END

      DELETE TIPO_USUARIO WHERE tipo_usuario = @Tipo_Usuario

      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO TIPO DE USUARIO.'
         SET NOCOUNT OFF
         RETURN 1

      END

   END ELSE IF @Tipo = 'G'
   BEGIN 
      IF NOT EXISTS( SELECT * FROM TIPO_USUARIO WHERE tipo_usuario = @Tipo_Usuario )
      BEGIN
         INSERT INTO TIPO_USUARIO ( 
                                   tipo_usuario,
                                   descripcion ,
                                   Tipo_Clave,
                                   Largo_Clave,
                                   Dias_Expiracion
                                  )
                VALUES            (
                                   @Tipo_Usuario,
                                   @Descripcion,
                                   @Tipo_Clave,
                                   @Largo_Clave,                                            
                                   @Dias_Expiracion
                                  )
 
         IF @@ERROR <> 0
         BEGIN
            PRINT 'ERROR_PROC FALLA AGREGANDO TIPO DE USUARIO.'
            SET NOCOUNT OFF
            RETURN 1

         END

      END ELSE BEGIN
         UPDATE       TIPO_USUARIO
                SET   descripcion     = @Descripcion,
                      Tipo_Clave      = @Tipo_Clave,
                      Largo_Clave     = @Largo_Clave,
                      Dias_Expiracion = @Dias_Expiracion
                WHERE tipo_usuario    = @Tipo_Usuario
 
         IF @@ERROR <> 0
         BEGIN
            PRINT 'ERROR_PROC FALLA AGREGANDO TIPO DE USUARIO.'
            SET NOCOUNT OFF
            RETURN 1

         END

      END

   END

END


GO

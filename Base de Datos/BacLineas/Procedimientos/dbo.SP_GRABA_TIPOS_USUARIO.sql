USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TIPOS_USUARIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_TIPOS_USUARIO]( @Tipo            CHAR(1)   ,
                                    @Tipo_Usuario    CHAR(15)  ,
                                    @Descripcion     CHAR(40)  ,
                                    @Tipo_Clave      CHAR(1)   ,
                                    @Largo_Clave     NUMERIC(2),                                            
                                    @Dias_Expiracion NUMERIC(5)
                                    )
AS
BEGIN
IF @Tipo = 'B'
   SELECT Descripcion,
          (CASE WHEN EXISTS(SELECT 1 FROM USUARIO WHERE tipo_usuario = @Tipo_Usuario) THEN 'S' ELSE 'N' END),
          Tipo_Clave,
          Largo_Clave,
          Dias_Expiracion    
     FROM GEN_TIPOS_USUARIO 
    WHERE tipo_usuario = @Tipo_Usuario
IF @Tipo = 'E' OR @Tipo = 'G'
BEGIN 
   
   DELETE GEN_TIPOS_USUARIO WHERE tipo_usuario = @Tipo_Usuario
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO TIPO DE USUARIO.'
      RETURN 1
   END
   IF @Tipo = 'E' 
   BEGIN
      DELETE GEN_PRIVILEGIOS WHERE usuario = @Tipo_Usuario AND tipo_privilegio = 'T'
      IF @@ERROR <> 0
      BEGIN
         PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE TIPO DE USUARIO.'
         RETURN 1
      END
   END
END
IF @Tipo = 'G'
BEGIN 
   INSERT GEN_TIPOS_USUARIO( tipo_usuario,
                             descripcion ,
                             Tipo_Clave,
                             Largo_Clave,
                             Dias_Expiracion)
                     VALUES( @Tipo_Usuario,
                             @Descripcion,
                             @Tipo_Clave,
                             @Largo_Clave,                                            
                             @Dias_Expiracion
                           )   
 
  IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO TIPO DE USUARIO.'
      RETURN 1
   END
END
RETURN 0
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM GEN_TIPOS_USUARIO
--SP_GRABA_TIPOS_USUARIO  'B', 'ADMINISTRADOR', '','',0,0
GO

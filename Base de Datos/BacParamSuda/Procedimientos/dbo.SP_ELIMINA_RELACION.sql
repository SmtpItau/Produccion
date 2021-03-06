USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_RELACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_RELACION]
   (   @Numero_Credito    NUMERIC(9)
   ,   @Numero_Derivado   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Mensaje  VARCHAR(1000)

   DELETE FROM RELACION_CREDITO_DERIVADO
         WHERE Numero_Credito  = @Numero_Credito
           AND Numero_Derivado = @Numero_Derivado

   DECLARE @nCodEvento   INTEGER
       SET @nCodEvento   = 8 --> Codigo de Eliminacion de Relación

       SET @Mensaje  = ' Se ha generado un evento de ' 
                     + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))
                     + ', sobre el derivado N° : ' + LTRIM(RTRIM( @Numero_Derivado ))
                     + ', el cual se encuentra asociado al crédito N°: '  + LTRIM(RTRIM( @Numero_Credito ))

   SELECT 'Usuario' = Usuario
      ,   'Email'   = EMail
      ,   'Mensaje' = @Mensaje
      ,   'Firma'   = 'Administrador de Eventos'
   FROM   BacParamSuda.dbo.CONFIGURACION_MENSAJE           conf
          INNER JOIN BacParamSuda.dbo.TABLA_ROLES_USUARIOS rol  ON rol.Rol = conf.Rol
   WHERE  Evento    = @nCodEvento
   AND    Estado    = 1
   
END
GO

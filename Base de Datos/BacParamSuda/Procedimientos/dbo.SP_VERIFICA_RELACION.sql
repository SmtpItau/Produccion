USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_RELACION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICA_RELACION]
   (   @NumDerivado   NUMERIC(9)
   ,   @Modulo        CHAR(3)
   ,   @Evento        INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound      INTEGER
       SET @iFound      = 0
   DECLARE @nNumCredito NUMERIC(9)
       SET @nNumCredito = 0

   SELECT @iFound       = 1
       ,  @nNumCredito  = Numero_Credito
     FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
    WHERE Numero_Derivado = @NumDerivado
      AND Modulo_Derivado = @Modulo

   DECLARE @Mensaje  VARCHAR(1000)

   IF @iFound = 1
   BEGIN
       SET @Mensaje  = ' Se ha generado un evento de ' 
                     + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @Evento) ))
                     + ', sobre el derivado N° : ' + LTRIM(RTRIM( @NumDerivado ))
                     + ', el cual se encuentra asociado al crédito N°: '  + LTRIM(RTRIM( @nNumCredito ))

      SELECT 'Usuario' = Usuario
         ,   'Email'   = EMail
         ,   'Mensaje' = @Mensaje
         ,   'Firma'   = 'Administrador de Eventos'
        FROM BacParamSuda.dbo.CONFIGURACION_MENSAJE           cmen
             INNER JOIN BacParamSuda.dbo.TABLA_ROLES_USUARIOS roles ON roles.Rol = cmen.Rol
       WHERE cmen.Estado = 1
         and Evento      = @Evento
   END

END
GO

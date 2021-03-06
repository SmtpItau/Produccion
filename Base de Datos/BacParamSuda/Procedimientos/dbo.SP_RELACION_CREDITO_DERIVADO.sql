USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RELACION_CREDITO_DERIVADO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RELACION_CREDITO_DERIVADO]
   (   @Numero_Credito      NUMERIC(9)
   ,   @Numero_Derivado     NUMERIC(9)
   ,   @Modulo_Derivado     CHAR(3)
   ,   @Producto_Derivado   INTEGER
   ,   @Ajuste_Nocionales   CHAR(1)
   ,   @Estado              INTEGER
   ,   @RutCliente          NUMERIC(9)
   ,   @CodCliente          INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Mensaje        VARCHAR(1000)

   DECLARE @Fecha_Relacion DATETIME
       SET @Fecha_Relacion = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
                      WHERE Numero_Credito    = @Numero_Credito 
                        AND Numero_Derivado   = @Numero_Derivado 
                        AND Modulo_Derivado   = @Modulo_Derivado
                        AND Producto_Derivado = @Producto_Derivado )
   BEGIN

      UPDATE dbo.RELACION_CREDITO_DERIVADO
         SET Ajuste_Nocionales = @Ajuste_Nocionales
         ,   Estado            = @Estado
       WHERE Numero_Credito    = @Numero_Credito 
         AND Numero_Derivado   = @Numero_Derivado 
         AND Modulo_Derivado   = @Modulo_Derivado
         AND Producto_Derivado = @Producto_Derivado

   END ELSE
   BEGIN

      INSERT INTO dbo.RELACION_CREDITO_DERIVADO
      (   Fecha_Relacion
      ,   Numero_Credito
      ,   Numero_Derivado
      ,   Modulo_Derivado
      ,   Producto_Derivado
      ,   Ajuste_Nocionales
      ,   Estado
      ,   RutCliente
      ,   CodCliente

      )
      VALUES
      (   @Fecha_Relacion
      ,   @Numero_Credito
      ,   @Numero_Derivado
      ,   @Modulo_Derivado
      ,   @Producto_Derivado
      ,   @Ajuste_Nocionales
      ,   @Estado
      ,   @RutCliente
      ,   @CodCliente
      )

   END

   DECLARE @nCodEvento   INTEGER
       SET @nCodEvento   = 7 --> Codigo de Creacion de Relación

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

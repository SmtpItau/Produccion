USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONFIGURACION_MENSAJE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONFIGURACION_MENSAJE]
   (   @iTag   INTEGER   
   ,   @Rol    INTEGER   = 0
   ,   @Evento INTEGER   = 0
   ,   @Estado INTEGER   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nContador   INTEGER

   IF @iTag = 0 or @iTag = 1
   BEGIN
      SET @nContador   = ( SELECT COUNT(1) FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
                                          WHERE tbcateg  = CASE WHEN @iTag = 0 THEN 8500 ELSE 8600 END )

      SELECT Cantidad = @nContador
      ,      Codigo   = tbcodigo1
      ,      Glosa    = tbglosa 
      FROM   BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
      WHERE  tbcateg  = CASE WHEN @iTag = 0 THEN 8500 ELSE 8600 END
      ORDER  BY tbglosa
   END

   IF @iTag = 2
   BEGIN
      SELECT Rol    = roles.tbglosa + SPACE(1000) + LTRIM(RTRIM( Rol    ))
      ,      Evento = event.tbglosa + SPACE(1000) + LTRIM(RTRIM( Evento ))
      ,      Estado = CASE WHEN Estado = 1 THEN 'SI' ELSE 'NO' END
      FROM   BacParamSuda.dbo.CONFIGURACION_MENSAJE
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE roles ON roles.tbcateg = 8500 and roles.tbcodigo1 = Rol
             LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE event ON event.tbcateg = 8600 and event.tbcodigo1 = Evento
      ORDER BY Rol
   END

   IF @iTag = 3
   BEGIN

      IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.CONFIGURACION_MENSAJE WHERE Rol = @Rol AND Evento = @Evento )
      BEGIN
         DELETE FROM BacParamSuda.dbo.CONFIGURACION_MENSAJE
               WHERE Rol = @Rol AND Evento = @Evento
      END

      INSERT INTO BacParamSuda.dbo.CONFIGURACION_MENSAJE
      (   Rol
      ,   Evento
      ,   Estado
      )
      VALUES
      (   @Rol
      ,   @Evento
      ,   @Estado
      )

   END

   IF @iTag = 4
   BEGIN
      SELECT Estado = CASE WHEN Estado = 1 THEN 'SI' ELSE 'NO' END
      FROM   BacParamSuda.dbo.CONFIGURACION_MENSAJE
      WHERE  Rol    = @Rol
      AND    Evento = @Evento
   END

END
GO

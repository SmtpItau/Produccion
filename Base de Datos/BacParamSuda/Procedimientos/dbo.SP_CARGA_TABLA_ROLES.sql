USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_ROLES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_ROLES]
   (   @iTag      INTEGER
   ,   @Usuario   VARCHAR(50)  = ''
   ,   @Rol       INTEGER      = 0
   ,   @Email     VARCHAR(150) = ''
   )
AS
BEGIN

   SET NOCOUNT ON
   
   IF @iTag = 0
   BEGIN
      IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.TABLA_ROLES_USUARIOS WHERE usuario = @usuario )
      BEGIN
         UPDATE BacParamSuda.dbo.TABLA_ROLES_USUARIOS
            SET Rol     = @Rol
            ,   EMail   = @Email
          WHERE usuario = @Usuario
      END ELSE
      BEGIN
         INSERT INTO BacParamSuda.dbo.TABLA_ROLES_USUARIOS
         (   Usuario
         ,   Rol
         ,   Email
         )
         VALUES
         (   @Usuario
         ,   @Rol
         ,   @Email
         )
      END
   END

   IF @iTag = 1
   BEGIN
      DELETE FROM BacParamSuda.dbo.TABLA_ROLES_USUARIOS
            WHERE Usuario = @Usuario
   END

   IF @iTag = 2
   BEGIN   
      SELECT Usuario
         ,   tbglosa + SPACE(100) + LTRIM(RTRIM( Rol ))
         ,   Email
       FROM  BacParamSuda.dbo.TABLA_ROLES_USUARIOS
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 8500 and tbcodigo1 = Rol
      ORDER BY Usuario
   END
END
GO

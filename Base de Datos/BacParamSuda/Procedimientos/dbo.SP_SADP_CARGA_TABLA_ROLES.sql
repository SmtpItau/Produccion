USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_TABLA_ROLES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_TABLA_ROLES]
   (   @iTag      INTEGER
   ,   @Usuario   VARCHAR(50)  = ''   
   ,   @Rol       INTEGER      = 0
   ,   @Email     VARCHAR(150) =''   
   )
AS
BEGIN

   SET NOCOUNT ON
   
   IF @iTag = 0
   BEGIN
      IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.SADP_ROLUSUARIO WHERE usuario = @usuario )
      BEGIN
         UPDATE BacParamSuda.dbo.SADP_ROLUSUARIO
            SET RolInterno = @Rol
            ,   EMail      = @Email
          WHERE usuario    = @Usuario
      END ELSE
      BEGIN
         INSERT INTO BacParamSuda.dbo.SADP_ROLUSUARIO
         (   Usuario
         ,   RolInterno
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
      DELETE FROM BacParamSuda.dbo.SADP_ROLUSUARIO
            WHERE Usuario = @Usuario
   END

   IF @iTag = 2
   BEGIN   
      SELECT Usuario
         ,   Descripcion + SPACE(100) + LTRIM(RTRIM( id_Rol ))
         ,   Email
       FROM  BacParamSuda.dbo.SADP_ROLUSUARIO
             LEFT JOIN BacParamSuda.dbo.SADP_ROLES ON ID_ROL=rolInterno
      ORDER BY Usuario
   END
END 
GO

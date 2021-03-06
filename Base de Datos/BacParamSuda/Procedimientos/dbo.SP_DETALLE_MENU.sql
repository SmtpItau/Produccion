USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_MENU]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DETALLE_MENU]
   (   @iTag           INTEGER
   ,   @Modulo         CHAR(3)      = ''
   ,   @Opcion         CHAR(30)     = ''
   ,   @Nombre         CHAR(150)    = ''
   ,   @Descripcion    VARCHAR(255) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT Entidad       = Entidad
      ,      Nombre_Objeto = Nombre_Objeto
      ,      Nombre_Opcion = '-' + REPLICATE('  ', posicion) + LTRIM(RTRIM(Nombre_Opcion))
      ,      Descripcion   = ISNULL(Descripcion, '')
      FROM   BacParamSuda..GEN_MENU 
             LEFT JOIN DETALLE_MENU ON Modulo = Entidad AND Opcion = Nombre_Objeto
      WHERE  Entidad       = @Modulo
      ORDER BY indice
   END

   IF @iTag = 1
   BEGIN
      SELECT id_sistema     = id_sistema
      ,      nombre_sistema = nombre_sistema
      FROM   BacParamSuda..SISTEMA_CNT 
      WHERE  operativo      = 'S'
      ORDER BY nombre_sistema
   END

   IF @iTag = 2
   BEGIN
      IF EXISTS(SELECT 1 FROM DETALLE_MENU WHERE Modulo = @Modulo AND Opcion = @Opcion)
      BEGIN
         UPDATE DETALLE_MENU
            SET Descripcion = @Descripcion
          WHERE Modulo      = @Modulo 
            AND Opcion      = @Opcion
      END ELSE
      BEGIN
         INSERT INTO DETALLE_MENU 
         (   Modulo
         ,   Opcion
         ,   Nombre
         ,   Descripcion
         )   
         VALUES
         (   @Modulo
         ,   @Opcion
         ,   @Nombre
         ,   @Descripcion
         )
      END
   END

END
GO

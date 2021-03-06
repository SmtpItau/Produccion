USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTES_BLOQUEADOS_PRODUCTO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CLIENTES_BLOQUEADOS_PRODUCTO]
   (   @Evento      INTEGER
   ,   @Modulo      CHAR(3)    = ''
   ,   @Producto    VARCHAR(5) = ''
   ,   @Rut         NUMERIC(9) = 0
   ,   @Codigo      INTEGER    = 0
   ,   @Bloqueado   CHAR(1)    = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Evento = 0
   BEGIN
      SELECT Id_Sistema
      ,      Nombre_Sistema 
      FROM   BacParamSuda.dbo.SISTEMA_CNT with(nolock)
      WHERE  operativo  = 'S'
        AND  gestion    = 'N'
        AND  Id_Sistema IN('BFW', 'PCS')
   END

   IF @Evento = 1
   BEGIN
      SELECT Codigo_Producto
         ,   Descripcion 
      FROM   BacParamSuda.dbo.PRODUCTO
      WHERE (id_sistema = @Modulo or @Modulo = '')
      AND    Estado     = 1
      ORDER BY Descripcion 
   END

   IF @Evento = 2
   BEGIN
      DELETE FROM BacParamSuda.dbo.TBL_CLIENTES_BLOQUEADOS_PRODUCTO
            WHERE Rut    = @Rut
              AND Codigo = @Codigo
   END

   IF @Evento = 3
   BEGIN
      INSERT INTO BacParamSuda.dbo.TBL_CLIENTES_BLOQUEADOS_PRODUCTO
      (   Rut
      ,   Codigo
      ,   Modulo
      ,   Producto
      ,   Bloqueado
      )
      VALUES
      (   @Rut
      ,   @Codigo
      ,   @Modulo
      ,   @Producto
      ,   @Bloqueado
      )
   END

   IF @Evento = 4
   BEGIN
      SELECT Modulo
         ,   Producto
         ,   Bloqueado
        FROM BacParamSuda.dbo.TBL_CLIENTES_BLOQUEADOS_PRODUCTO
       WHERE Rut    = @Rut
         AND Codigo = @Codigo
   END

END
GO

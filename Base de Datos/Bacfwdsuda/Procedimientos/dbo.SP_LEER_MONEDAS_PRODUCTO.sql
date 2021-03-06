USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDAS_PRODUCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_MONEDAS_PRODUCTO]
   (   @Sistema    CHAR(3)
   ,   @Producto   INTEGER
   ,   @Tipo       INTEGER   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Tipo = 2
   BEGIN
      SELECT mnrrda FROM BacparamSuda..MONEDA with (nolock)  WHERE mncodmon = @Producto
      RETURN
   END

   IF @Tipo = 0
   BEGIN
      IF EXISTS(SELECT 1 FROM BacParamSuda..PRODUCTO_MONEDA WHERE mpsistema = @Sistema AND mpproducto = @Producto)
      BEGIN
         SELECT mncodmon, mnnemo, mnglosa, mnrrda
         FROM   BacParamSuda..PRODUCTO_MONEDA   with (nolock) 
                INNER JOIN BacParamSuda..MONEDA with (nolock) ON mpcodigo = mncodmon AND mnmx = 'C'
         WHERE  mpsistema  = @Sistema
         AND    mpproducto = @Producto
         ORDER BY mnglosa
      END ELSE
      BEGIN
         SELECT mncodmon, mnnemo, mnglosa, mnrrda
         FROM   BacParamSuda..MONEDA with (nolock) 
         WHERE  mncodmon   = 142
         ORDER BY mnglosa
      END
   END ELSE
   BEGIN
      SELECT mncodmon, mnnemo, mnglosa, mnrrda
      FROM   BacParamSuda..MONEDA with (nolock) 
      WHERE  mncodmon IN(999)
      ORDER BY mnglosa
   END

END
GO

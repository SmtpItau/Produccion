USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDAPRODUCTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_MONEDAPRODUCTO]  
   (   @CodProd   INTEGER =  0 
   ,   @CodMoneda INTEGER =  0 
   ,   @sistema   CHAR(4) = '' 
   ,   @Activo    CHAR(1) = '1'
   )
AS
BEGIN

   SET NOCOUNT ON 

   DECLARE @Producto CHAR(2)
     
   SELECT @Producto = ''
   SELECT @Producto = CASE WHEN @CodProd = 1 THEN 'ST' 
                           WHEN @CodProd = 4 THEN 'SP' --> Swap Promedio Camara
                           ELSE                   'SM'
                      END

   SELECT c.mpProducto
   ,      a.descripcion
   ,      mpCodigo
   ,      b.mnglosa
   ,      c.mpestado
   FROM   bacparamsuda..PRODUCTO_MONEDA c LEFT JOIN bacparamsuda..PRODUCTO a ON c.mpsistema = a.id_sistema and  c.mpproducto = a.codigo_producto
                                          LEFT JOIN bacparamsuda..MONEDA   b ON c.mpcodigo  = b.mncodmon
   WHERE ((c.mpsistema  = @sistema  or @sistema  = '') OR @CodProd = 0)
   AND    (c.mpproducto = @Producto or @Producto = '')
   AND    (c.mpEstado   = @Activo   or @Activo   = '')
   ORDER BY b.mnglosa

END
GO

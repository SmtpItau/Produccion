USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_MATRIZ_CONTROL]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_MATRIZ_CONTROL]
   (   @iMiTag      INTEGER   
   ,   @iSistema    CHAR(3)       = ''
   ,   @iProducto   VARCHAR(5)    = ''
   ,   @iMoneda     NUMERIC(9)    = 0
   ,   @iDesde      NUMERIC(9)    = 0
   ,   @iHasta      NUMERIC(9)    = 0
   ,   @iBanda      NUMERIC(21,4) = 0.0
   )
AS
BEGIN
   
   SET NOCOUNT ON
   
      /*   
      @iMiTag = 1      --> Carga Sistemas
      @iMiTag = 2      --> Carga Productos de un Sistema
      @iMiTag = 3      --> Carga Monedas   de un Producto
      @iMiTag = 4      --> Busca datos de la Matriz

      @iMiTag = 5      --> Elimina Matriz
      @iMiTag = 6      --> inserta registros a la Matriz
      */

   IF @iMiTag = 1
   BEGIN
      SELECT id_sistema
      ,      nombre_sistema
      FROM   bacparamsuda.dbo.SISTEMA_CNT 
      WHERE  operativo = 'S' AND gestion = 'N'

      RETURN
   END

   IF @iMiTag = 2
   BEGIN   
      SELECT codigo_producto , descripcion
        FROM bacparamsuda.dbo.PRODUCTO 
       WHERE id_sistema = @iSistema

      RETURN
   END

   IF @iMiTag = 3
   BEGIN   
      SELECT mncodmon , mnglosa , mnnemo 
      FROM   bacparamsuda.dbo.PRODUCTO_MONEDA RIGHT JOIN bacparamsuda.dbo.MONEDA ON mpcodigo = mncodmon
      WHERE  mpsistema  = @iSistema
      AND    mpproducto = @iProducto

      RETURN
   END

   IF @iMiTag = 4
   BEGIN   
      SELECT Plazo_Desde  
      ,      Plazo_Hasta  
      ,      Ancho_Banda  
      FROM   MATRIZ_DE_CONTROL
      WHERE  Id_Sistema       = @iSistema
      AND    Codigo_Producto  = @iProducto
      AND    Moneda           = @iMoneda

      RETURN
   END


   IF @iMiTag = 5
   BEGIN   
      DELETE MATRIZ_DE_CONTROL
      WHERE  Id_Sistema       = @iSistema
      AND    Codigo_Producto  = @iProducto
      AND    Moneda           = @iMoneda
      
      RETURN
   END

   IF @iMiTag = 6
   BEGIN   
      INSERT INTO MATRIZ_DE_CONTROL
      SELECT @iSistema
      ,      @iProducto
      ,      @iMoneda
      ,      @iDesde
      ,      @iHasta
      ,      @iBanda

      RETURN     
   END

END   
GO

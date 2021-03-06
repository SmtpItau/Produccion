USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_REFERENCIA_MERCADO_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- sp_helptext SP_MNT_REFERENCIA_MERCADO_PRODUCTO 4, 1, 'E', 1, 0
CREATE PROCEDURE [dbo].[SP_MNT_REFERENCIA_MERCADO_PRODUCTO]
   (   @iTag        INTEGER
   ,   @Producto    INTEGER      = 0
   ,   @Modalidad   CHAR(1)      = ''
   ,   @Referencia  INTEGER      = 0
   ,   @DiasValor   NUMERIC(5)   = 0
   ,   @idTipoCambio smallint     = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT codigo_producto
         ,   descripcion
      FROM   BacParamSuda..PRODUCTO
      WHERE  Id_Sistema       = 'BFW'
        AND codigo_producto  IN(1, 2, 12, 14)
      ORDER BY descripcion
   END

   IF @iTag = 1
   BEGIN
      SELECT Codigo   = Codigo
         ,   Glosa    = Glosa
      FROM   REFERENCIA_MERCADO
      WHERE  Estado   = 0 
   END
   
   IF @iTag = 2
   BEGIN
      SELECT Referencia   = Referencia
         ,   Glosa        = Glosa
         ,   DiasValor    = DiasValor
	,   idTipoCambio = idTipoCambio
      FROM   REFERENCIA_MERCADO_PRODUCTO 
             INNER JOIN BacParamSuda..PRODUCTO a ON a.id_sistema = 'BFW' AND codigo_producto = Producto
             INNER JOIN REFERENCIA_MERCADO     ON codigo     = Referencia
      WHERE  Producto     = @Producto
      AND    Modalidad    = @Modalidad
   END

   IF @iTag = 3
   BEGIN
      DELETE FROM REFERENCIA_MERCADO_PRODUCTO
            WHERE Producto   = @Producto
              AND Modalidad  = @Modalidad
   END

   IF @iTag = 4
   BEGIN
      INSERT INTO REFERENCIA_MERCADO_PRODUCTO ( Producto ,  Modalidad,  Referencia,  DiasValor, idTipoCambio  )
                                        VALUES( @Producto, @Modalidad, @Referencia, @DiasValor, @idTipoCambio )
   END
END
GO

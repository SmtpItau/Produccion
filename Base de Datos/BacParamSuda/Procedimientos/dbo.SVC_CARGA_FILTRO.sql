USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CARGA_FILTRO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_CARGA_FILTRO]
   (   @iTag         INTEGER
   ,   @Modulo       CHAR(3)     = ''
   ,   @Producto     VARCHAR(5)  = ''
   ,   @Moneda       INTEGER     = 0
   ,   @fPago        INTEGER     = 0
   ,   @Estado       CHAR(1)     = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   
   IF @iTag = 0
   BEGIN
      SELECT Nombre     = nombre_sistema
         ,   Sigla      = id_sistema
      FROM   BacParamSuda.dbo.SISTEMA_CNT with(nolock)
      WHERE  operativo  = 'S' AND gestion = 'N' 
      AND    id_sistema = 'BFW'
      ORDER BY nombre_sistema

      RETURN
   END 

   IF @iTag = 1
   BEGIN
      SELECT descripcion,  codigo_producto
      FROM   BacparamSuda.dbo.PRODUCTO with(nolock) 
      WHERE  Estado          = 1
      AND   (id_sistema      = @Modulo   OR @Modulo = '')
      AND   (codigo_producto = @Producto OR @Producto = '')
      ORDER BY descripcion

      RETURN
   END

   IF @iTag = 2
   BEGIN
      SELECT mnglosa, mncodmon
        FROM BacParamSuda.dbo.PRODUCTO_MONEDA
             INNER JOIN Bacparamsuda.dbo.MONEDA ON mncodmon = mpcodigo
       WHERE mpsistema  = @Modulo 
         AND mpproducto = @Producto
   END

   IF @iTag = 3
   BEGIN
      SELECT DISTINCT glosa, codigo 
      FROM   MONEDA_FORMA_DE_PAGO
             INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO ON codigo = mfcodfor 
      WHERE  mfcodmon = @Moneda
      ORDER BY glosa
   END

   IF @iTag = 4
   BEGIN
      SELECT Glosa = 'PENDIENTES', codigo = 'P' UNION
      SELECT Glosa = 'ENVIADOS',   codigo = 'E'
      ORDER BY Glosa DESC
   END

END

GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO_II]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO_II]
   (   @sistema CHAR(3)   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT 'CODIGO_GRUPO' = ISNULL(B.codigo_grupo,' ')
   ,      'DESCRIPCION'  = CONVERT(CHAR(50),ISNULL(B.glosa_grupo,' '))
   ,      A.id_sistema
   ,      A.codigo_producto
   INTO   #PASO
   FROM   VIEW_PRODUCTO A
          LEFT JOIN GRUPO_PRODUCTO B ON a.Codigo_Producto = b.Codigo_Producto
   WHERE  A.id_sistema   = @SISTEMA

   UPDATE #Paso
   SET    codigo_Grupo          = a.codigo_producto,
          descripcion           = a.descripcion
   FROM   VIEW_PRODUCTO a
   WHERE (#Paso.codigo_Grupo    = ' ' 
   AND    #Paso.descripcion     = ' ') 
   AND    #Paso.Codigo_Producto = a.Codigo_Producto

   SELECT codigo_Grupo
   ,      MIN(descripcion)
   ,      MIN(id_sistema)
   FROM   #Paso
   GROUP BY codigo_Grupo

END
GO

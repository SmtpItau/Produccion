USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMAN_BUSCAPRODUCTO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMAN_BUSCAPRODUCTO]
   (   @Sistema   CHAR(3)   = ''   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT * FROM PRODUCTO WHERE (id_sistema = @Sistema or @Sistema = '') AND ESTADO = 1) 
   BEGIN
      SELECT   codigo_producto   as Producto
      ,        descripcion       as Glosa
      ,        id_sistema        as Sistema
      FROM     PRODUCTO 
      WHERE    (id_sistema = @Sistema OR @Sistema = '') AND ESTADO = 1
      ORDER BY descripcion
   END ELSE 
   BEGIN
      SELECT 'ERROR'
   END

END
GO

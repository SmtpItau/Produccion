USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEPRODUCTO]
AS BEGIN
   SET NOCOUNT ON
       SELECT  codigo_producto, 
  descripcion, 
  id_sistema 
 FROM PRODUCTO
 ORDER BY descripcion 
   SET NOCOUNT OFF
END
GO

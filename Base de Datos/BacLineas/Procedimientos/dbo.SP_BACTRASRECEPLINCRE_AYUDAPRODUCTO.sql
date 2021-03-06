USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACTRASRECEPLINCRE_AYUDAPRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACTRASRECEPLINCRE_AYUDAPRODUCTO    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACTRASRECEPLINCRE_AYUDAPRODUCTO] (
       @codigo_producto    CHAR(5),
             @id_sistema   CHAR(3))
AS BEGIN
 SET NOCOUNT ON
 SELECT codigo_producto, descripcion, id_sistema  FROM PRODUCTO
  WHERE codigo_producto=@codigo_producto AND  id_sistema = @id_sistema
 SET NOCOUNT OFF
END
GO

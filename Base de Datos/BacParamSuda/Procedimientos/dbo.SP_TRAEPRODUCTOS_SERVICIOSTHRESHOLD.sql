USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEPRODUCTOS_SERVICIOSTHRESHOLD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEPRODUCTOS_SERVICIOSTHRESHOLD]
   (   @Modulo   CHAR(3)   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT descripcion, codigo_producto
   FROM   PRODUCTO 
   WHERE  id_sistema = @Modulo
   AND    Estado     = 1
   ORDER BY descripcion, id_sistema
END
GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERPRODUCTOSSISTEMAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERPRODUCTOSSISTEMAS]
                  (
                  @Sistema CHAR (05)
                  )
AS
BEGIN

	SET NOCOUNT ON

	SELECT codigo_producto
	,      descripcion
	  FROM PRODUCTO_SISTEMA
	 WHERE id_sistema = @Sistema

	SET NOCOUNT OFF

END
GO

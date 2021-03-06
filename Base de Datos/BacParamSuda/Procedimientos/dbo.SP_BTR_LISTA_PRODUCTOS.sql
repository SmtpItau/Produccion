USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_LISTA_PRODUCTOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BTR_LISTA_PRODUCTOS]
	(	@par_sistema	CHAR(05)	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT descripcion
		,  codigo_producto
	  FROM BacparamSuda.dbo.PRODUCTO with(nolock)
	 WHERE id_sistema = @par_sistema
	union
	SELECT Producto, Codigo
	  FROM SADP_PRODUCTO_MODULOEXTERNO with(nolock) 
	WHERE Modulo = @par_sistema

END
GO

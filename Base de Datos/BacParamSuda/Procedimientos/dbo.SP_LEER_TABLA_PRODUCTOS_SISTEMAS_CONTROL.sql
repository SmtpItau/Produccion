USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TABLA_PRODUCTOS_SISTEMAS_CONTROL]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_LEER_TABLA_PRODUCTOS_SISTEMAS_CONTROL 'PCS'

CREATE PROCEDURE [dbo].[SP_LEER_TABLA_PRODUCTOS_SISTEMAS_CONTROL]
			(	@codSistema CHAR(3) = '' )
AS
BEGIN
	SET NOCOUNT ON

	/* 
	---------------------------------------------------------------------
	SETEO Categoria asociada a los productos Swaps registrados en 
	TABLA_GENERAL_DETALLE 
	---------------------------------------------------------------------
	*/
	declare @CategoriaSwaps int
	set @CategoriaSwaps = 1050

	
	IF @codSistema = 'PCS'  /* SISTEMA SWAP */
	BEGIN
		SELECT sis.id_sistema
			,   sis.[nombre_sistema]
			,   tbcodigo1 as codigo_producto
			,   tbglosa as descripcion
		FROM   BacParamSuda..TABLA_GENERAL_DETALLE
		INNER JOIN [dbo].[SISTEMA_CNT] sis ON sis.id_sistema = @codSistema
		
		WHERE  tbcateg       = @CategoriaSwaps
		ORDER BY tbglosa
	END

	IF @codSistema <> 'PCS'  /* RESTO DE LOS SISTEMAS */
	BEGIN
		SELECT		sis.id_sistema
					,sis.nombre_sistema
					,prd.codigo_producto
					,prd.descripcion
					,ISNULL(apli.aplicaControl,'N') AS 'aplicaControl'
		FROM		BacParamSuda..SISTEMA_CNT sis
					,BacParamSuda..PRODUCTO prd
					LEFT JOIN BacParamSuda..TBL_APLICAN_CONTROL_PRECIOSTASAS apli
					ON apli.codProducto = prd.codigo_producto
		WHERE		sis.operativo	= 'S' AND
					prd.Estado = 1 AND
					sis.id_sistema	= prd.id_sistema AND
					(sis.id_sistema  = @codSistema OR @codSistema = '')
		ORDER BY	sis.nombre_sistema, prd.descripcion
	END
END

GO

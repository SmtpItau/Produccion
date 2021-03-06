USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TABLA_APLICAN_CONTROL_PT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_TABLA_APLICAN_CONTROL_PT]
			(	@codSistema CHAR(3) = '' )
AS
BEGIN
	SET NOCOUNT ON

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
GO

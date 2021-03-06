USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOLINEA_BUSCA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOLINEA_BUSCA]
		(	@rutcliente NUMERIC(9)	,
			@codcliente NUMERIC(9)	,
			@id_sistema CHAR   (3)  = ''
		)
AS 
BEGIN

	SET NOCOUNT ON

	SELECT	a.rut_cliente		,	-- 1
		a.codigo_cliente	,	-- 2
		a.id_sistema		,	-- 3
		a.plazodesde		,	-- 4
		a.plazohasta		,	-- 5
		a.porcentaje		,	-- 6
		a.totalasignado		,	-- 7
		a.totalocupado		,	-- 8
		a.totaldisponible	,	-- 9
		a.totalexceso		,	--10 
		a.totaltraspaso		,	--11
		a.totalrecibido         ,	--12
		b.descripcion		,	--13
		b.codigo_producto		--14
	FROM 	LINEA_PRODUCTO_POR_PLAZO	a,
		VIEW_PRODUCTO			b
	WHERE 	( a.rut_cliente	  = @rutcliente
	AND     a.codigo_cliente  = @codcliente )
	AND     a.id_sistema	  = b.id_sistema
	AND     a.Codigo_Producto = b.codigo_producto

	SET NOCOUNT OFF

END
GO

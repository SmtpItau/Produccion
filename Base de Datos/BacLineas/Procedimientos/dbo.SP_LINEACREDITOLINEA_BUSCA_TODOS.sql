USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOLINEA_BUSCA_TODOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOLINEA_BUSCA_TODOS]
		(	@rutcliente NUMERIC(9)	,
			@codcliente NUMERIC(9)
		)
AS 
BEGIN

	SET NOCOUNT ON
/*
	SELECT  rut_cliente	,
		codigo_cliente	,
		id_sistema	,		
		plazodesde	,
		plazohasta	,
		porcentaje	,
		totalasignado	,
		totalocupado	,
		totaldisponible	,
		totalexceso	,
		totaltraspaso	,
		totalrecibido         
	FROM 	LINEA_POR_PLAZO
	WHERE 	rut_cliente=@RUTCLIENTE 	AND
		codigo_cliente=@CODCLIENTE
	ORDER BY id_sistema
*/

	SELECT  a.rut_cliente		,	-- 1
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
		a.totalrecibido		,	--12
		b.descripcion		,	--13
		b.codigo_producto		--14
	FROM 	linea_producto_por_plazo	a	,
		producto			b
	WHERE 	( a.rut_cliente	 = @rutcliente 		AND
		a.codigo_cliente = @codcliente )	AND
		b.id_sistema = a.id_sistema
	ORDER BY b.codigo_producto

	SET NOCOUNT OFF

END

-- SELECT * FROM linea_producto_por_plazo
-- SELECT * FROM producto
GO

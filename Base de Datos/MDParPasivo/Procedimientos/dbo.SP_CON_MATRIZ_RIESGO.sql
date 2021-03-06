USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MATRIZ_RIESGO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_MATRIZ_RIESGO]
		(	@id_sistema		CHAR(3)
		,	@cod_producto		CHAR(5)
		,	@cod_instrumento	NUMERIC(5) = 0
		,	@codigo_moneda  	NUMERIC(5)
		,	@codigo_moneda2 	NUMERIC(5)
		)
AS
BEGIN
	SET NOCOUNT ON 
	SET DATEFORMAT dmy
	
	SELECT	A.dias_grupo_desde
	,	A.dias_grupo_hasta
	,	A.dias_desde
	,	A.dias_hasta
	,	A.porcentaje
	,	B.plazos_matriz
	FROM	MATRIZ_RIESGO	A
	,	PRODUCTO	B
	WHERE	A.id_sistema		= @id_sistema
	AND	A.codigo_producto	= @cod_producto
	AND	A.codigo_instrumento	= @cod_instrumento
	AND	A.codigo_moneda 	= @codigo_moneda
	AND	A.codigo_moneda2	= @codigo_moneda2
	AND 	B.id_sistema		= A.id_sistema
	AND	B.codigo_producto	= A.codigo_producto
	ORDER BY dias_grupo_desde
	,	dias_grupo_hasta
	,	dias_desde
	,	dias_hasta

	SET NOCOUNT OFF
END

-- SP_CON_MATRIZ_RIESGO  'BCC', 'ARBI', 0, '5', '5'



GO

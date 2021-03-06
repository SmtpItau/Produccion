USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devuelve_Productos_Control]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Devuelve_Productos_Control]
			(
			@codigo_control	CHAR(05)
			)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	DECLARE @tipo_control	CHAR(01)

	SELECT @tipo_control = tipo_control FROM TIPO_CONTROL WHERE codigo_control = @codigo_control

	IF @tipo_control = 'G' BEGIN
		SELECT	'codigo_grupos'	= codigo_grupo	,
			'descripcion'	= CONVERT(VARCHAR(60),descripcion)	,
			'estado_grupo'	= 'N'		,
			'producto'	= ' '		,
			'tipo_control'	= @tipo_control	,
			'sistema'	= CONVERT(CHAR(03), ' '),
			'nombre_sis'	= CONVERT(CHAR(30), ' ')
		INTO #TMP
		FROM GRUPO_PRODUCTO
		ORDER BY codigo_grupo

		UPDATE #TMP SET
			estado_grupo = C.Estado
		FROM	PRODUCTO_CONTROL AS C
		WHERE	codigo_grupos	 = C.codigo_grupo	AND
			C.codigo_control = @codigo_control

		SELECT	codigo_grupos	,
			descripcion	,
			estado_grupo	,
			tipo_control	,
			producto	,
			sistema		,
			nombre_sis
		FROM #TMP

	END ELSE BEGIN
		SELECT	'codigo_grupos'	= codigo_producto,--codigo_control,
			'descripcion'	= CONVERT(VARCHAR(60),' '),
			'estado_grupo'	= estado	,
			'producto'	= codigo_producto,
			'tipo_control'  = @tipo_control,
			'sistema'	= id_sistema 	,
			'nombre_sis'	= CONVERT(CHAR(30), ' '),
			'origen'	= 'C'
		INTO #TMP_2
		FROM PRODUCTO_CONTROL
		WHERE codigo_control = @codigo_control
		UNION
		SELECT	'codigo_grupos'	= Codigo_Producto,--codigo_control,
			'descripcion'	= CONVERT(VARCHAR(60),' '),
			'estado_grupo'	= 'N'			,
			'producto'	= Codigo_Producto	,
			'tipo_control'  = @tipo_control,
			'sistema'	= id_sistema 	,
			'nombre_sis'	= CONVERT(CHAR(30), ' '),
			'origen'	= 'P'
		FROM PRODUCTO




		DELETE #TMP_2 FROM #TMP_2
		INNER JOIN PRODUCTO_CONTROL ON
			producto = codigo_producto	AND
			sistema  = id_sistema		AND
			origen	 = 'P'			AND
			codigo_control = @codigo_control



		UPDATE #TMP_2 SET descripcion = A.Descripcion
		FROM #TMP_2
		INNER JOIN PRODUCTO AS A ON 
			sistema = ID_SISTEMA 		AND
			producto= Codigo_Producto


		UPDATE #TMP_2 SET nombre_sis = nombre_sistema
		FROM #TMP_2
		INNER JOIN SISTEMA ON 
			sistema = ID_SISTEMA 

		SELECT	codigo_grupos	,
			descripcion	,
			estado_grupo	,
			tipo_control	,
			producto	,
			sistema		,
			nombre_sis
		FROM #TMP_2
		ORDER BY sistema, producto

	END

SET NOCOUNT OFF
END

GO

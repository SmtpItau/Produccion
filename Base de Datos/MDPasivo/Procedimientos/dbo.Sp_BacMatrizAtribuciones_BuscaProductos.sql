USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_BuscaProductos]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_BuscaProductos]
		(
		@Codigo_control	CHAR(10)
		)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	SELECT	'id_sistema'		= P.id_sistema		,
		'nombre_sistema'	= S.nombre_sistema	,
		'identificador'		= CONVERT(INTEGER, 0)	,
		'codigo_producto'	= CONVERT(CHAR(05), P.codigo_producto),
		'descripcion'		= CONVERT(CHAR(50), P.descripcion),
		'codigo_instrumento'	= CONVERT(INTEGER, 0),
		'familia_instrumento'	= SPACE(12),
		'estado'		= SPACE(1)
	INTO #TEMP_MATRIZ
	FROM PRODUCTO AS P	,
	     SISTEMA  AS S
        WHERE	contabiliza  = 'S'	AND
		P.id_sistema = S.id_sistema

        INSERT #TEMP_MATRIZ
        SELECT id_sistema
            ,  nombre_sistema
            ,  1
            ,  codigo_producto
            ,  descripcion
            ,  incodigo
            ,  inserie
            ,  SPACE(1)
        FROM INSTRUMENTO 
        ,    #TEMP_MATRIZ 
        WHERE id_sistema = 'BTR'
          AND codigo_producto in ('CP','VP')
          AND incodigo not in(992,993)

        UPDATE #TEMP_MATRIZ SET estado = 'S'
        FROM MATRIZ_ATRIBUCION_INSTRUMENTO G ,PRODUCTO d
        WHERE G.codigo_control         = @codigo_control
        AND   #TEMP_MATRIZ.id_sistema  = d.id_sistema
        AND   #TEMP_MATRIZ.codigo_producto    = G.codigo_producto
        AND   #TEMP_MATRIZ.codigo_instrumento = G.Incodigo
        AND   #TEMP_MATRIZ.codigo_producto    = d.Codigo_Producto


        UPDATE #TEMP_MATRIZ SET estado = 'S'
        FROM MATRIZ_ATRIBUCION G ,PRODUCTO d
        WHERE G.codigo_control         = @codigo_control
        AND   #TEMP_MATRIZ.id_sistema  = d.id_sistema
        AND   #TEMP_MATRIZ.codigo_producto    = G.codigo_producto
        AND   #TEMP_MATRIZ.codigo_producto    = d.Codigo_Producto
	AND   #TEMP_MATRIZ.id_sistema  <> 'BTR'







        UPDATE #TEMP_MATRIZ SET estado = 'S'
        FROM MATRIZ_ATRIBUCION G ,PRODUCTO d
        WHERE G.codigo_control         = @codigo_control
        AND   #TEMP_MATRIZ.id_sistema  = d.id_sistema
        AND   #TEMP_MATRIZ.codigo_producto    = G.codigo_producto
        AND   #TEMP_MATRIZ.codigo_producto    = d.Codigo_Producto
	AND   #TEMP_MATRIZ.id_sistema  = 'BTR'
	AND   d.Codigo_Producto NOT IN ('CP','VP')






        UPDATE #TEMP_MATRIZ SET estado = 'N'
        FROM MATRIZ_ATRIBUCION_INSTRUMENTO G ,PRODUCTO d
        WHERE G.codigo_control         <> @codigo_control
        AND   #TEMP_MATRIZ.id_sistema  = d.id_sistema
--        AND   #TEMP_MATRIZ.codigo_producto    = G.codigo_producto
        AND   #TEMP_MATRIZ.codigo_instrumento = G.Incodigo
--        AND   #TEMP_MATRIZ.codigo_producto    = d.Codigo_Producto
	AND   #TEMP_MATRIZ.id_sistema  = 'BTR'



        UPDATE #TEMP_MATRIZ SET estado = 'N'
        FROM MATRIZ_ATRIBUCION G ,PRODUCTO d
        WHERE G.codigo_control         <> @codigo_control
        AND   #TEMP_MATRIZ.id_sistema  = d.id_sistema
        AND   #TEMP_MATRIZ.codigo_producto    = G.codigo_producto
        AND   #TEMP_MATRIZ.codigo_producto    = d.Codigo_Producto
	AND   #TEMP_MATRIZ.id_sistema  <> 'BTR'

        SELECT id_sistema, nombre_sistema, identificador, codigo_producto, descripcion, codigo_instrumento, familia_instrumento, estado
        FROM #TEMP_MATRIZ 
        WHERE (NOT EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO x WHERE x.codigo_producto    = #TEMP_MATRIZ.codigo_producto
                                                                       AND x.incodigo = #TEMP_MATRIZ.codigo_instrumento)
        OR estado = 'S' OR estado = 'N')
        ORDER BY id_sistema, codigo_producto, identificador


END

GO

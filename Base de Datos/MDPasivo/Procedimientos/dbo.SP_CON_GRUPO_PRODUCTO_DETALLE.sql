USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_GRUPO_PRODUCTO_DETALLE]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_GRUPO_PRODUCTO_DETALLE]
		(
		@codigo_grupo        CHAR(10)
		)
AS BEGIN

    SET NOCOUNT ON
    SET DATEFORMAT dmy

    SELECT 'id_sistema'         = P.id_sistema
          ,'nombre_sistema'     = S.nombre_sistema
          ,'identificador'      = CONVERT(INTEGER, 0)
          ,'codigo_producto'    = CONVERT(CHAR(05), P.codigo_producto)
          ,'descripcion'        = CONVERT(CHAR(50), P.descripcion)
          ,'codigo_instrumento' = CONVERT(INTEGER, 0)
          ,'familia_instrumento'= SPACE(12)
          ,'estado'             = SPACE(1)
          ,'Cabeza_nodo'        = CONVERT(INTEGER, 0)
        INTO #TEMP_GRUPO
        FROM PRODUCTO P
            ,SISTEMA  S
        WHERE contabiliza = 'S'
          AND P.id_sistema = S.id_sistema


	UPDATE #TEMP_GRUPO set Cabeza_nodo  = 1
	WHERE id_sistema = 'BTR'
	AND codigo_producto in ('CP','VP')

    INSERT #TEMP_GRUPO
        SELECT id_sistema
            ,  nombre_sistema
            ,  1
            ,  B.codigo_producto
            ,  descripcion
            ,  incodigo
            ,  inserie
            ,  SPACE(1)
	    ,  0
        FROM INSTRUMENTO A
        ,    #TEMP_GRUPO B
        WHERE id_sistema = 'BTR'
          AND B.codigo_producto in ('CP','VP')

            UPDATE #TEMP_GRUPO SET estado = 'S'
            FROM GRUPO_PRODUCTO_DETALLE G
            WHERE G.codigo_grupo                 = @codigo_grupo
            AND   #TEMP_GRUPO.id_sistema         = G.id_sistema
            AND   #TEMP_GRUPO.codigo_producto    = G.codigo_producto
            AND   #TEMP_GRUPO.codigo_instrumento = G.codigo_instrumento


--  IF EXISTS(SELECT 1 FROM GRUPO_PRODUCTO WHERE codigo_grupo = @codigo_grupo)
--    SELECT id_sistema, nombre_sistema, identificador, codigo_producto, descripcion, codigo_instrumento, familia_instrumento, estado
--            FROM #TEMP_GRUPO
--            ORDER BY id_sistema, codigo_producto, identificador
--  ELSE

	SELECT	id_sistema	,
		nombre_sistema	,
		identificador	,
		codigo_producto	,
		descripcion	,
		codigo_instrumento,
		familia_instrumento,
		estado
            FROM #TEMP_GRUPO 
            WHERE NOT EXISTS(SELECT 1 FROM GRUPO_PRODUCTO_DETALLE WHERE GRUPO_PRODUCTO_DETALLE.id_sistema         = #TEMP_GRUPO.id_sistema
                                                                    AND GRUPO_PRODUCTO_DETALLE.codigo_producto    = #TEMP_GRUPO.codigo_producto
                                                                    AND GRUPO_PRODUCTO_DETALLE.codigo_instrumento = #TEMP_GRUPO.codigo_instrumento
								    AND Cabeza_nodo <> 1  )
          OR estado = 'S'
		
            ORDER BY id_sistema, #TEMP_GRUPO.codigo_producto, identificador

   SET NOCOUNT OFF

END

--dbo.SP_CON_GRUPO_PRODUCTO_DETALLE 'CAMBIO'

GO

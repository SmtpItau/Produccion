USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ERRORES_CARGA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ERRORES_CARGA]
	(	@dFecha_Hoy	DATETIME )
AS
BEGIN

IF EXISTS(SELECT 1
	FROM 	ERRORES_CARGA			E
	,	BACPARAMSUDA..SISTEMA_CNT	S
	,	VIEW_CLIENTE			C
	,	VIEW_PRODUCTO			P
	WHERE	E.sistema 	= S.id_sistema
	AND	E.rut_cliente	= C.clrut
	AND	E.cod_cliente	= C.clcodigo
	AND	E.cod_producto  = P.codigo_producto
	AND	E.sistema	= P.id_sistema
	AND	E.fecha_proceso	= @dFecha_Hoy
	)
BEGIN


	SELECT 
	'titulo'	= 'ERRORES EN CARGA DEL ' + CONVERT(CHAR(10),@dFecha_Hoy,103),
	'sistema'	= S.nombre_sistema,
	'cliente'	= E.rut_cliente,
	'nombre'	= C.clnombre,
	'producto'	= P.descripcion,
	'vencimiento'	= CONVERT(CHAR(10),E.fecha_vencimiento,103),
	'numoper'	= E.numero_operacion,
	'fecha'		= CONVERT(CHAR(10),@dFecha_Hoy,103)
	FROM 	ERRORES_CARGA			E
	,	BACPARAMSUDA..SISTEMA_CNT	S
	,	VIEW_CLIENTE			C
	,	VIEW_PRODUCTO			P
	WHERE	E.sistema 	= S.id_sistema
	AND	E.rut_cliente	= C.clrut
	AND	E.cod_cliente	= C.clcodigo
	AND	E.cod_producto  = P.codigo_producto
	AND	E.sistema	= P.id_sistema
	AND	E.fecha_proceso	= @dFecha_Hoy

END ELSE
BEGIN

	SELECT
	'titulo'	= 'ERRORES EN CARGA ' + CONVERT(CHAR(10),@dFecha_Hoy,103),
	'sistema'	= '',
	'cliente'	= 0,
	'nombre'	= 'NO EXISTE INFORMACION',
	'producto'	= '',
	'vencimiento'	= '',
	'numoper'	= 0,
	'fecha'		= CONVERT(CHAR(10),@dFecha_Hoy,103)

END

END
GO

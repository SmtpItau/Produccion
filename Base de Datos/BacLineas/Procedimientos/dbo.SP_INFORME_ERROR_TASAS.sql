USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_ERROR_TASAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INFORME_ERROR_TASAS]
		(
			@fechaproc	DATETIME
		)
AS
BEGIN

SET NOCOUNT ON

CREATE TABLE #TEMPORAL	
	(
		titulo		CHAR (100)
	,	sistema		CHAR(15)
	,	numoper		NUMERIC(10)
	,	numdocu		NUMERIC(10)
	,	rut		NUMERIC(10)
	,	nombre		CHAR(80)
	,	mensaje		CHAR(1000)
	,	fecha		CHAR(10)
	,	producto	CHAR(50)
	)


IF EXISTS(SELECT 1 
	FROM 	linea_transaccion_detalle  	t
	,	VIEW_SISTEMA_CNT		s
	,	VIEW_CLIENTE			c
	WHERE   t.Linea_Transsaccion = 'CTRLTA'
	AND	t.id_sistema = s.id_sistema
	AND	t.rut_cliente = c.clrut
	AND	t.codigo_cliente = c.clcodigo
	AND	t.Error = 'S' )
BEGIN

	INSERT INTO #TEMPORAL
	SELECT  'titulo'	= 'ERRORES EN TASAS DEL ' + CONVERT(CHAR(10),@fechaproc,103)
	,	'sistema' 	= s.nombre_sistema
	,	'numoper'	= t.numerooperacion
	,	'numdocu'	= t.numerodocumento
	,	'rut'		= t.rut_cliente
	,	'nombre'	= c.clnombre
	,	'mensaje'	= t.Mensaje_Error
	,	'fecha'		= CONVERT(CHAR(10),@fechaproc,103)
	,	'producto'	= p.descripcion
	FROM 	linea_transaccion_detalle  	t
	,	VIEW_SISTEMA_CNT		s
	,	VIEW_CLIENTE			c
	,	VIEW_PRODUCTO			p
	WHERE   t.Linea_Transsaccion = 'CTRLTA'
	AND	t.id_sistema = s.id_sistema
	AND	t.rut_cliente = c.clrut
	AND	t.codigo_cliente = c.clcodigo
	AND	t.Error = 'S'
	AND	t.codigo_producto = p.codigo_producto
	ORDER BY s.nombre_sistema
	,	t.numerooperacion

	SELECT * FROM #TEMPORAL

END ELSE
BEGIN


	SELECT  'titulo'	= 'ERRORES EN TASAS DEL ' + CONVERT(CHAR(10),@fechaproc,103)
	,	'sistema' 	= 'NO EXISTE INF.'
	,	'numoper'	= 0
	,	'numdocu'	= 0
	,	'rut'		= 0
	,	'nombre'	= ''
	,	'mensaje'	= ''
	,	'fecha'		= CONVERT(CHAR(10),@fechaproc,103)
	,	'producto'	= ''

END

END

GO

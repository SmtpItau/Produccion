USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACIONESALTA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEROPERACIONESALTA]
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @cFecha_BTR DATETIME
	DECLARE @cFecha_BFW DATETIME
	DECLARE @cFecha_BCC DATETIME
	DECLARE @cFecha_BSW DATETIME
	DECLARE @cFecha_BEX DATETIME

	SELECT	@cFecha_BTR = acfecproc FROM view_mdac
	SELECT	@cFecha_BFW = acfecproc FROM view_mfac
	SELECT	@cFecha_BCC = acfecpro  FROM view_meac

	CREATE TABLE #TEMP1
		(
		Sistema		CHAR(05)	,
		Cod_Producto	CHAR(05)	,
		Glo_Producto	CHAR(40)	,
		numoper		NUMERIC(10)	,
		rutcli		NUMERIC(09)	,
		codcli		NUMERIC(09)	,
		cliente		CHAR(50)	,
		moneda		CHAR(05)	,
		Monto		NUMERIC(19,4)	,
		Operador	CHAR(15)	,
		ErrorG		CHAR(2)		,
		modal		CHAR(1)		,
		fecha_inicio	DATETIME
		)

	INSERT	INTO	#TEMP1
	SELECT	A.Id_Sistema		,
		A.Codigo_Producto	,
		''			,
		A.NumeroOperacion	,
		A.Rut_Cliente		,
		A.Codigo_Cliente	,
		''			,
		'$'			,
		A.MontoOriginal		,
		A.Operador		,
		'NO'			,
		'N'			,
		FechaInicio
	FROM	LINEA_TRANSACCION		A ,
		LINEA_TRANSACCION_DETALLE	B 
	WHERE 	A.NumeroOperacion	= B.NumeroOperacion
	AND	A.NumeroDocumento	= B.NumeroDocumento
	AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
	AND	A.Id_Sistema		= B.Id_Sistema
	AND	B.Linea_Transsaccion	= 'LINGEN'
	AND (	( A.Id_Sistema = 'BTR' AND FechaInicio = @cFecha_BTR AND A.Codigo_Producto = 'ICOL') OR 
		( A.Id_Sistema = 'BFW' AND FechaInicio = @cFecha_BFW ) OR 
		( A.Id_Sistema = 'BCC' AND FechaInicio = @cFecha_BCC ) ) 

/*
	AND (	( A.Id_Sistema = 'BTR' AND FechaVencimiento <= @cFecha_BTR AND A.Codigo_Producto = 'ICOL') OR 
		( A.Id_Sistema = 'BFW' AND FechaVencimiento <= @cFecha_BFW ) OR 
		( A.Id_Sistema = 'BCC' AND FechaVencimiento <= @cFecha_BCC ) ) 
*/
	GROUP
	BY	A.Id_Sistema		,
		A.Codigo_Producto	,
		A.Rut_Cliente		,
		A.Codigo_Cliente	,
		A.NumeroOperacion	,
		A.Operador		,
		A.MontoOriginal		,		
		a.FechaVencimiento	,
		a.FechaInicio

	UPDATE 	#TEMP1
	SET	cliente = LEFT(clnombre,50)
	FROM	VIEW_CLIENTE
	WHERE	rutcli	= clrut	AND
		codcli	= clcodigo

	UPDATE 	#TEMP1
	SET	Glo_Producto = LEFT(descripcion,40)
	FROM	VIEW_PRODUCTO
	WHERE	codigo_producto	= Cod_Producto	AND
		id_sistema	= VIEW_PRODUCTO.id_sistema

	DELETE	#TEMP1
	FROM	VIEW_MFCA
	WHERE	catipmoda 	= 'C'		AND
		canumoper 	= numoper	AND
		Id_Sistema	= 'BFW'

	SELECT 	Sistema		,
		Glo_Producto	,
		numoper		,
		cliente		,
		moneda		,
		Monto		,
		fecha_inicio	
	FROM	#TEMP1	

	SET NOCOUNT OFF
	
		
END

-- SELECT * FROM VIEW_PRODUCTO
GO

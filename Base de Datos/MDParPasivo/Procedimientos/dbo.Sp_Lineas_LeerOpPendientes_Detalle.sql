USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_LeerOpPendientes_Detalle]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_LeerOpPendientes_Detalle]
			(
			@Id_Sistema	CHAR	(12),
			@nNumoper	NUMERIC	(10)
			)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	CREATE TABLE #temp1
		(
		Sistema		CHAR	(03)	,
		numoper		NUMERIC	(10)	,
		numdocu		NUMERIC	(10)	,
		correla		NUMERIC	(10)	,
		rut_cli		NUMERIC	(09)	,
		cod_cli		NUMERIC	(09)	,
		cliente		CHAR	(50)	,
		Monto		NUMERIC	(19,04)	,
		Fecha		CHAR	(10)	,
		ErrorG		CHAR	(02)	,
		MontoEx_Sis	NUMERIC	(19,04)	,
		MontoEx_Gen	NUMERIC	(19,04)	,
		Tipo_Riesgo	CHAR	(01)	,
		Codigo_Producto	CHAR	(06)	,
                MontoOriginal   NUMERIC	(19,04)  ,
                Tipo_Operacion  CHAR	(10)
		)

	INSERT	INTO #temp1
	SELECT	id_sistema		,
		NumeroOperacion		,
		NumeroDocumento		,
		NumeroCorrelativo	,
		rut_cliente		,
		codigo_cliente		,
		' '			,
		MontoTransaccion	,
		CONVERT(CHAR(10),FechaVencimiento,103),
		'NO'			,
		0			,
		0			,
		Tipo_Riesgo		,
		' '	         ,
                (MontoOriginal * TipoCambio),
                (CASE WHEN Tipo_Operacion = 'V' THEN 'VENTA'
                      WHEN Tipo_Operacion = 'C' THEN 'COMPRA' 
	              ELSE 0 
		END)
	FROM	LINEA_TRANSACCION
	WHERE 	NumeroOperacion	= @nNumoper	AND
		id_sistema	= @Id_Sistema



	UPDATE	#temp1
	SET	ErrorG = "SI"
	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	numoper	= NumeroOperacion
	AND	numdocu	= NumeroDocumento
	AND	correla	= NumeroCorrelativo
	AND	Sistema	= Id_Sistema
	AND	Error   = 'S'


	UPDATE	#temp1
	SET	MontoEx_Sis = MontoExceso
	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	numoper	= NumeroOperacion
	AND	numdocu	= NumeroDocumento
	AND	correla	= NumeroCorrelativo
	AND	Sistema	= Id_Sistema
	AND	Error   = 'S'
	AND	Linea_Transsaccion IN ('LINSIS','LINSCR','LINSSR')
	AND	MontoExceso > 0


	UPDATE	#temp1
	SET	MontoEx_Gen = MontoExceso
	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	numoper	= NumeroOperacion
	AND	numdocu	= NumeroDocumento
	AND	correla	= NumeroCorrelativo
	AND	Sistema	= Id_Sistema
	AND	Error   = 'S'
	AND	Linea_Transsaccion = 'LINGEN'
	AND	MontoExceso > 0



	SELECT	Numoper		,
		numdocu		,
		correla		,
		rut_cli		,
		cod_cli		,
		clnombre	,
		Monto		,
		fecha		,
		ErrorG		,
		MontoEx_Sis	,
		MontoEx_Gen	,
		Tipo_Riesgo	,
		Codigo_Producto ,
                MontoOriginal   ,
                Tipo_Operacion

	FROM	#temp1		,
		cliente
	WHERE	clrut	= rut_cli
	AND	clcodigo = cod_cli
	ORDER
	BY	Numoper		,
		numdocu		,
		correla

	SET NOCOUNT OFF

END





--sp_helptext sp_Lineas_LeerOpPendientes_Detalle

GO

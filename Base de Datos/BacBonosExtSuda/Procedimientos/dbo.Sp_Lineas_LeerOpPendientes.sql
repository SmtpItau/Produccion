USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_LeerOpPendientes]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Lineas_LeerOpPendientes]
				(
				@cFecha DATETIME,
				@ID	CHAR(5) = ""

				)
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
	SELECT	@cFecha_BSW = fechaproc FROM view_SwapGeneral
	SELECT	@cFecha_BEX = acfecproc FROM view_text_arc_ctl_dri


	CREATE TABLE
	#Temp1
		(
		Sistema		CHAR(05)	,
		Cod_Producto	CHAR(05)	,
		Glo_Producto	CHAR(30)	,
		numoper		NUMERIC(10)	,
		rutcli		NUMERIC(09)	,
		codcli		NUMERIC(09)	,
		cliente		CHAR(50)	,
		Monto		NUMERIC(19,4)	,
		Operador	CHAR(15)	,
		ErrorG		CHAR(2)		,
		Pendiente	CHAR(1)		,
		Moneda		CHAR(3)		,
		plazo		NUMERIC(5)	,
		linea_total	NUMERIC(21,04)	,
		Forma_Pago	CHAR(30)	,
		fecha		DATETIME	,
		fecha_sistema   DATETIME
		)


	INSERT	INTO	#temp1
	SELECT	A.Id_Sistema		,
		CASE 	WHEN A.Codigo_Producto = '1' AND A.Id_Sistema = 'PCS' THEN 'ST'
			WHEN A.Codigo_Producto = '2' AND A.Id_Sistema = 'PCS' THEN 'SM'
			WHEN A.Codigo_Producto = '3' AND A.Id_Sistema = 'PCS' THEN 'FR'
			ELSE A.Codigo_Producto 
		END	,
		''			,
		A.NumeroOperacion	,
		0			,
		0			,
		''			,
		A.MontoOriginal		,
		A.Operador		,
		'NO'			,
		'N'			,
		''			,
		DATEDIFF(DAY,a.FechaInicio,a.FechaVencimiento)	,
		0			,
		""			,
		FechaInicio		,
		CASE 	WHEN A.Id_Sistema = 'BTR' THEN @cFecha_BTR
			WHEN A.Id_Sistema = 'BFW' THEN @cFecha_BFW
			WHEN A.Id_Sistema = 'BCC' THEN @cFecha_BCC
			WHEN A.id_Sistema = 'PCS' THEN @cFecha_BSW
			WHEN A.id_Sistema = 'BEX' THEN @cFecha_BEX
			ELSE FechaInicio
		END
	FROM	LINEA_TRANSACCION		A ,
		LINEA_TRANSACCION_DETALLE	B
	WHERE 	A.NumeroOperacion	= B.NumeroOperacion
	AND	A.NumeroDocumento	= B.NumeroDocumento
	AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
	AND	A.Id_Sistema		= B.Id_Sistema
	AND (	( A.Id_Sistema = 'BTR' AND FechaInicio = @cFecha_BTR ) OR 
		( A.Id_Sistema = 'BFW' AND FechaInicio = @cFecha_BFW ) OR 
		( A.Id_Sistema = 'PCS' AND FechaInicio = @cFecha_BSW ) OR 
		( A.Id_Sistema = 'BCC' AND FechaInicio = @cFecha_BCC ) OR
		( A.Id_Sistema = 'BEX' AND FechaInicio = @cFecha_BEX )   )
	GROUP
	BY	A.Id_Sistema		,
		A.Codigo_Producto	,
		A.NumeroOperacion	,
		A.Operador		,
		A.MontoOriginal		,
		a.FechaVencimiento	,
		a.FechaInicio


	INSERT	INTO #temp1
	SELECT	Id_Sistema 	,
		Codigo_Producto	,
		''		,
		NumeroOperacion ,
		0		,
		0		,
		''		,
		MontoTransaccion,
		Operador	,
		'NO'		,
		'N'		,
		''		,
		DATEDIFF(DAY,acfecproc,FechaVencimiento)	,
		0		,
		""		,
		FechaOperacion	,
		acfecproc
	FROM	LIMITE_TRANSACCION	,
		view_mdac
	WHERE	NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BTR )
	AND	Check_Operacion   ='S'
	AND	FechaOperacion	= @cFecha_BTR
	AND	LIMITE_TRANSACCION.ID_sistema	= 'BTR'
	GROUP	
	BY 	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		NumeroOperacion ,
		MontoTransaccion,
		Operador	,
		FechaVencimiento,
		FechaOperacion	,
		acfecproc

	INSERT	INTO #temp1
	SELECT	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		''		,
		NumeroOperacion ,
		0		,
		0		,
		''		,
		MontoTransaccion,
		Operador	,
		'NO'		,
		'N'		,
		''		,
		DATEDIFF(DAY,acfecproc,FechaVencimiento)	,
		0		,
		""		,
		cafecha		,
		acfecproc
	FROM	LIMITE_TRANSACCION	,
		view_mfac		,
		view_mfca	
	WHERE	NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BFW )
	AND	Check_Operacion   ='S'
	AND	FechaOperacion	= @cFecha_BFW
	AND	LIMITE_TRANSACCION.ID_sistema	= 'BFW'
	AND 	NumeroOperacion = canumoper
	GROUP	
	BY 	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		NumeroOperacion ,
		MontoTransaccion,
		Operador	,
		FechaVencimiento,
		acfecproc	,
		cafecha

	INSERT	INTO #temp1
	SELECT	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		''		,
		NumeroOperacion ,
		0		,
		0		,
		''		,
		MontoTransaccion,
		Operador	,
		'NO'		,
		'N'		,
		''		,
		DATEDIFF(DAY,acfecpro,FechaVencimiento)	,
		0		,
		""		,
		FechaOperacion	,
		acfecpro
	FROM	LIMITE_TRANSACCION	,
		view_meac
	WHERE	NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BCC )
	AND	Check_Operacion   ='S'
	AND	FechaOperacion	= @cFecha_BCC
	AND	LIMITE_TRANSACCION.ID_sistema	= 'BCC'
	GROUP	
	BY 	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		NumeroOperacion ,
		MontoTransaccion,
		Operador	,
		FechaVencimiento,
		FechaOperacion	,
		acfecpro

	INSERT	INTO #temp1
	SELECT	LIMITE_TRANSACCION.Id_Sistema 	,
		CASE Codigo_Producto 	WHEN '1' THEN 'ST'
					WHEN '2' THEN 'SM'
					ELSE 'FR'
		END  	,
		''		,
		NumeroOperacion ,
		0		,
		0		,
		''		,
		MontoTransaccion,
		Operador	,
		'NO'		,
		'N'		,
		''		,
		DATEDIFF(DAY,fechaproc,FechaVencimiento)	,
		0		,
		""		,
		FechaOperacion	,
		fechaproc
	FROM	LIMITE_TRANSACCION	,
		view_swapgeneral
	WHERE	NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BSW )
	AND	Check_Operacion   ='S'
	AND	FechaOperacion	= @cFecha_BSW
	AND	LIMITE_TRANSACCION.ID_sistema	= 'PCS'
	GROUP	
	BY 	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		NumeroOperacion ,
		MontoTransaccion,
		Operador	,
		FechaVencimiento,
		FechaOperacion	,
		fechaproc

	INSERT	INTO #temp1
	SELECT	Id_Sistema 	,
		Codigo_Producto	,
		''		,
		NumeroOperacion ,
		0		,
		0		,
		''		,
		MontoTransaccion,
		Operador	,
		'NO'		,
		'N'		,
		''		,
		DATEDIFF(DAY,acfecproc,FechaVencimiento)	,
		0		,
		""		,
		FechaOperacion	,
		acfecproc
	FROM	LIMITE_TRANSACCION	,
		view_text_arc_ctl_dri
	WHERE	NOT EXISTS( SELECT * FROM LINEA_TRANSACCION WHERE LINEA_TRANSACCION.NumeroOperacion = LIMITE_TRANSACCION.NumeroOperacion AND LINEA_TRANSACCION.FechaInicio = @cFecha_BEX)
	AND	Check_Operacion   ='S'
	AND	FechaOperacion	= @cFecha_BEX
	AND	LIMITE_TRANSACCION.ID_sistema	= 'BEX'
	GROUP	
	BY 	LIMITE_TRANSACCION.Id_Sistema 	,
		Codigo_Producto	,
		NumeroOperacion ,
		MontoTransaccion,
		Operador	,
		FechaVencimiento,
		FechaOperacion	,
		acfecproc

--MEB

	UPDATE	#temp1
	SET	errorG = 'SI'

--************** Solo hasta que se habilite el modulo completo
--		,Pendiente = 'S'
--**************despues borrar

	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	numoper	= NumeroOperacion
	AND	Sistema	= Id_Sistema
	AND	Error	= 'S'


	UPDATE	#temp1
	SET	Glo_Producto = descripcion
	FROM	PRODUCTO
	WHERE	id_sistema 	= Sistema
	AND	codigo_producto = Cod_Producto


	UPDATE	#temp1
	set	rutcli = morutcli,
		codcli = mocodcli,
		moneda = ISNULL( ( CASE WHEN motipoper IN( 'VP' , 'CP' ) THEN 'CLP' ELSE ( SELECT DISTINCT mnnemo FROM moneda,view_mdmo WHERE numoper = monumoper AND momonpact = mncodmon ) END ) , "" ),
		linea_total = ISNULL( TotalOcupado , 0 )	,
		forma_pago  = ISNULL( ( SELECT DISTINCT glosa FROM forma_de_pago,view_mdmo WHERE numoper = monumoper AND moforpagI = codigo ) , "" )
	FROM	view_mdmo	,
		linea_general	
	WHERE	numoper = monumoper AND 
		( morutcli *= Rut_Cliente     AND
		mocodcli   *= Codigo_Cliente )		
		AND	Sistema = 'BTR'


	UPDATE	#temp1
	SET	rutcli = morutcli,
		codcli = mocodcli,
		Moneda = mocodmon,
		linea_total = ISNULL( TotalOcupado , 0 )	,
		forma_pago  = ISNULL( ( SELECT glosa FROM forma_de_pago,view_memo WHERE numoper = monumope AND morecib= codigo ) , "" )
	FROM	view_memo	,
		linea_general
	WHERE	numoper = monumope		AND 
		( morutcli *= Rut_Cliente     	AND
		mocodcli *= Codigo_Cliente )
	AND	Sistema = 'BCC'

	UPDATE	#temp1
	SET	rutcli = cacodigo,
		codcli = cacodcli,
		moneda = mnnemo,
		linea_total = ISNULL( TotalOcupado , 0 )	,
		forma_pago  = ISNULL( ( SELECT glosa FROM forma_de_pago,view_mfca WHERE numoper = canumoper AND cafpagomn = codigo ) , "" )
	FROM	view_mfca	,
		moneda		,
		linea_general	
	WHERE	numoper = canumoper	AND
		mncodmon = cacodmon1    AND 
		( cacodigo *= Rut_Cliente     	AND
		cacodcli *= Codigo_Cliente )
	AND	Sistema = 'BFW'


	UPDATE	#temp1
	SET	rutcli = a.rut_cliente,
		codcli = a.codigo_cliente,
		moneda = b.mnnemo,
		linea_total = ISNULL( c.TotalOcupado , 0 )	,
		forma_pago  = ISNULL( ( SELECT glosa FROM forma_de_pago,view_cartera WHERE numoper = numero_operacion AND recibimos_documento = codigo AND tipo_flujo = 1 AND numero_flujo =1 ) , "" )
	FROM	view_cartera	a,
		moneda		b,
		linea_general	c
	WHERE	numoper = a.numero_operacion		AND
		mncodmon = a.compra_moneda    		AND 
		( a.rut_cliente  *= c.Rut_Cliente     	AND
		a.codigo_cliente *= c.Codigo_Cliente )  AND
		Sistema = 'PCS'				AND
		a.tipo_flujo = 1			AND
		a.numero_flujo =1 


	UPDATE	#temp1
	set	rutcli = morutcli,
		codcli = mocodcli,
		moneda = ISNULL( ( CASE WHEN motipoper IN( 'VP' , 'CP' ) THEN 'CLP' ELSE ( SELECT DISTINCT mnnemo FROM moneda,view_mdmo WHERE numoper = monumoper AND momonemi = mncodmon ) END ) , "" ),
		linea_total = ISNULL( TotalOcupado , 0 )	,
		forma_pago  = ISNULL( ( SELECT DISTINCT glosa FROM forma_de_pago,view_text_mvt_dri WHERE numoper = monumoper AND FORMA_PAGO = codigo ) , "" )
	FROM	view_text_mvt_dri,
		linea_general	
	WHERE	numoper = monumoper AND 
		( morutcli *= Rut_Cliente     AND
		  mocodcli   *= Codigo_Cliente )		
		  AND	Sistema = 'BEX'


	--MEB
--	SELECT * FROM #TEMP1
	UPDATE	#temp1
	SET	pendiente = 'S'
	FROM	view_mdmo
	WHERE	Sistema   = 'BTR'
	AND	monumoper = numoper
	AND	mostatreg = 'P'

	UPDATE	#temp1
	SET	pendiente = 'N'
	FROM	view_mdmo
	WHERE	Sistema = 'BTR'
	AND	monumoper = numoper
	AND	mostatreg = 'R'

	UPDATE	#Temp1
	SET	pendiente	= 'S'
	FROM	view_memo
	WHERE	Sistema='BCC' AND CONVERT(NUMERIC(10),monumope)=numoper AND
		moestatus='P'

	UPDATE	#Temp1
	SET	pendiente	= 'N'
	FROM	view_memo
	WHERE	Sistema='BCC' AND CONVERT(NUMERIC(10),monumope)=numoper	AND
		moestatus='R'

	UPDATE	#Temp1
	SET	pendiente	= 'S'
	FROM	view_mfca
	WHERE	Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND
		caestado='P'

	UPDATE	#Temp1
	SET	pendiente	= 'N'
	FROM	view_mfca
	WHERE	Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND
		caestado='R'

	UPDATE	#Temp1
	SET	pendiente	= 'S'
	FROM	view_cartera
	WHERE	Sistema='PCS' AND CONVERT(NUMERIC(10),numero_operacion)=numoper AND
		Estado_oper_lineas='P'

	UPDATE	#Temp1
	SET	pendiente	= 'N'
	FROM	view_cartera
	WHERE	Sistema='PCS' AND CONVERT(NUMERIC(10),numero_operacion)=numoper AND
		Estado_oper_lineas='R'

	UPDATE	#temp1
	SET	pendiente = 'S'
	FROM	VIEW_text_mvt_dri
	WHERE	Sistema   = 'BEX'
	AND	monumoper = numoper
	AND	mostatreg = 'P'

-- UPDATE text_mvt_dri SET mostatreg = 'P' WHERE monumoper = 42

	UPDATE	#temp1
	SET	pendiente = 'N'
	FROM	VIEW_text_mvt_dri
	WHERE	Sistema = 'BEX'
	AND	monumoper = numoper
	AND	mostatreg = 'R'

	UPDATE	#temp1
	SET	cliente = LEFT(clnombre,50)
	FROM	cliente
	WHERE	clrut		= rutcli
	AND	clcodigo	= codcli

	--MEB
	SELECT * FROM #temp1 where Sistema = 'BEX'

	SELECT	Sistema		,
		Glo_Producto	,
		numoper		,
		cliente		,
		Monto		,
		Operador	,
		ErrorG		,
		Moneda		,
		Plazo		,
		linea_total	,
		Forma_Pago	,
		fecha		,
		fecha_sistema   
	FROM	#temp1
	WHERE	pendiente	= 'S'
	AND 	(Sistema	= @ID OR @ID = " ")
	ORDER BY Sistema	,
		 numoper

	SET NOCOUNT OFF

END

-- EXECUTE Sp_Lineas_LeerOpPendientes '20020829', 'BEX'
-- SELECT  * FROM LINEA_TRANSACCION WHERE ID_SISTEMA = 'PCS'
-- SELECT * FROM LIMITE_TRANSACCION WHERE ID_SISTEMA = 'pcs' ORDER BY NumeroOperacion
-- EXECUTE Sp_Lineas_LeerOpPendientes '20020702', 'BEX'
-- SELECT mostatreg,* FROM VIEW_text_mvt_dri

--select * from LINEA_TRANSACCION	
--select * from LINEA_TRANSACCION_DETALLE	





GO

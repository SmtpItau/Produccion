USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_LeerOpPendientes]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_LeerOpPendientes]
			(
			@cFecha		DATETIME,
			@Usuario	CHAR(15)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT DMY

--	drop table #tmp_pendientes

	CREATE TABLE #tmp_pendientes
		(
		sistema		CHAR(3)		,
		producto	CHAR(5)		,
		Glo_Producto	CHAR	(70)	,
		numoper		NUMERIC	(10)	,
		numdocu		NUMERIC (10)	,
		correla		NUMERIC (3)	,
		cliente		CHAR	(70)	,
		moneda		CHAR	(05)	,
		Monto		NUMERIC	(19,4)	,
		Operador	CHAR	(20)	,
		ErrorG		CHAR	(02)	,
		muestra		CHAR 	(1)
		)


	-- ********** OPERACIONES DE RENTA FIJA
	-- ************************************
	-- Solo Operaciones del Dia

	INSERT	INTO	#tmp_pendientes
	SELECT	'BTR'			,
		motipoper		,
		''			,
		monumoper		,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		SUM(	CASE	WHEN MOTIPOPER IN ('VI','VIX','CI', 'CIX','RP','FLP','FLI')	THEN MOVALINIP
				WHEN MOTIPOPER IN ('RC','RCX','RV', 'RVX') 	THEN MOVALVENP	
				ELSE MOVALCOMP END),
		mousuario		,
		'NO'			,
		'N'
	FROM	VIEW_MOVIMIENTO_TRADER A 	WITH (NOLOCK),
		MONEDA 				WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	mostatreg 	= 'P'
	AND	mncodmon 	= (CASE	WHEN MOTIPOPER IN ('VI','VIX','CI', 'CIX','RP','FLP','FLI')	THEN MOMONPACT
					WHEN MOTIPOPER IN ('RC','RCX','RV', 'RVX') 	THEN MOMONPACT
					ELSE MOMONEMI END)
	AND	clrut 		= Morutcli
	AND	clcodigo 	= Mocodcli 	
	AND	mofecpro 	= @cFecha
	GROUP
	BY	motipoper		,
		monumoper		,
		clnombre		,
		mnnemo			,
		mousuario



	-- ********** OPERACIONES DE INVERSIONES EN EL EXTERIOR
	-- ****************************************************
	-- Solo Operaciones del Dia

	INSERT	INTO	#tmp_pendientes
	SELECT	'INV'			,
		motipoper		,
		''			,
		monumoper		,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		movalcomp		,
		mousuario		,
		'NO'			,
		'N'
	FROM	VIEW_MOVIMIENTO_INVERSION_EXTERIOR A 	WITH (NOLOCK),
		MONEDA 					WITH (NOLOCK),
		CLIENTE 				WITH (NOLOCK)
	WHERE 	mostatreg 	= 'P'
	AND	mncodmon 	= momonemi
	AND	clrut 		= Morutcli
	AND	clcodigo 	= Mocodcli  	 	
	AND	mofecpro 	= @cFecha


	-- ********** OPERACIONES DE SWAP
	-- ************************************
	-- Todas las operaciones (las modificaiones tabien deben entrar al proceso)


	INSERT	INTO	#tmp_pendientes
	SELECT	'SWP'			,
		a.tipo_swap		,
		''			,
		a.numero_operacion	,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		amortiza_capital+saldo_capital		,
		operador		,
		'NO'			,
		'N'
	FROM	VIEW_CONTRATO A 		WITH (NOLOCK),
		VIEW_CONTRATO_FLUJO B 		WITH (NOLOCK),
		MONEDA 				WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	Estado_oper_lineas	= 'P'
	AND	b.numero_operacion	= a.numero_operacion
	AND	b.numero_flujo		= 1
	AND	b.tipo_flujo		= 1
	AND	mncodmon		= b.moneda_flujo
	AND	clrut			= rut_cliente
	AND	clcodigo		= codigo_cliente

-- update VIEW_CONTRATO set Estado_oper_lineas=''


	-- ********** OPERACIONES DE CAMBIO
	-- ********************************
	-- Solo Operaciones del Dia


	INSERT	INTO	#tmp_pendientes
	SELECT	'BCC'			,
		Motipmer		,
		''			,
		monumope		,
		0			,
		0			,
		clnombre		,
		Mocodmon		,
		Momonmo			,
		Mooper			,
		'NO'			,
		'N'
	FROM	VIEW_MOVIMIENTO_CAMBIO A 	WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	A.moestatus 	= 'P'
	AND	clrut 		= Morutcli
	AND	clcodigo 	= Mocodcli 
	AND	mofech 		= @cFecha


	-- ********** OPERACIONES DE FORWARD
	-- *********************************
	-- Todas las operaciones (las modificaiones tabien deben entrar al proceso)

	INSERT	INTO	#tmp_pendientes
	SELECT	'BFW'			,
		mocodpos1		,
		''			,
		monumoper		,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		momtomon1		,
		mooperador		,
		'NO'			,
		'N'
	FROM	VIEW_MOVIMIENTO_FORWARD A 	WITH (NOLOCK),
		MONEDA 				WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	A.moestado 	= 'P'
	AND	mncodmon 	= mocodmon1
	AND	clrut 		= mocodigo
	AND	clcodigo 	= mocodcli
-- update VIEW_CARTERA_FORWARD set caestado=''


	-- ********** OPERACIONES DE FORWARD DE IRF
	-- ****************************************
	-- Todas las operaciones (las modificaiones tabien deben entrar al proceso)

	INSERT	INTO	#tmp_pendientes
	SELECT	'BFW'			,
		codigo_producto		,
		''			,
		numero_operacion	,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		nominal			,
		operador		,
		'NO'			,
		'N'
	FROM	VIEW_CARTERA_FORWARD_PAPEL A 	WITH (NOLOCK),
		MONEDA 				WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	A.estado 	= 'P'
	AND	mncodmon 	= moneda
	AND	clrut 		= rut_cliente
	AND	clcodigo 	= codigo_cliente



-- select * from VIEW_FRA_CARTERA
	-- ********** OPERACIONES DE FRA
	-- ****************************************
	-- Todas las operaciones (las modificaiones tabien deben entrar al proceso)
/*
	INSERT	INTO	#tmp_pendientes
	SELECT	'SWP'			,
		codigo_producto		,
		''			,
		numero_operacion	,
		0			,
		0			,
		clnombre		,
		mnnemo			,
		monto			,
		operador		,
		'NO'			,
		'N'
	FROM	VIEW_FRA_CARTERA A 		WITH (NOLOCK),
		MONEDA 				WITH (NOLOCK),
		CLIENTE 			WITH (NOLOCK)
	WHERE 	A.estado 	= 'P'
	AND	mncodmon 	= moneda
	AND	clrut 		= rut_cliente
	AND	clcodigo 	= codigo_cliente


*/



	-- ************************************

	UPDATE	P
	SET	muestra = 'S'
	FROM	LINEA_TRANSACCION		A  WITH (NOLOCK),
		LINEA_TRANSACCION_DETALLE	B  WITH (NOLOCK),
		EXCEPCION_USUARIO_DETALLE 	C  WITH (NOLOCK),
		#tmp_pendientes			P
	WHERE 	A.NumeroOperacion	= B.NumeroOperacion
	AND	A.NumeroDocumento	= B.NumeroDocumento
	AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
	AND	C.id_sistema       	= B.id_sistema
	AND	C.codigo_producto	= B.codigo_producto
	AND     C.Usuario		= @Usuario
	AND     C.codigo_excepcion	= B.codigo_excepcion
	AND     C.estado		= 'S'
	AND	A.NumeroOperacion	= P.numoper
	AND	A.id_sistema		= P.sistema


	UPDATE	P
	SET	muestra = 'S'
	FROM	LIMITE_TRANSACCION	  AS A   WITH (NOLOCK),
		EXCEPCION_USUARIO_DETALLE AS B   WITH (NOLOCK),
		#tmp_pendientes		  AS P
	WHERE	B.Usuario		= @Usuario
	AND	A.id_sistema       	= b.id_sistema
	AND	A.codigo_producto	= b.codigo_producto
	AND	B.codigo_excepcion	= CASE	WHEN A.Tipo_control = 'CPREC' THEN 'PR'
						WHEN A.Tipo_control = 'CLCHR' THEN 'LH'
						WHEN A.Tipo_control = 'LINVP' THEN 'CP'
						ELSE 'MA' 
						END
	AND	B.estado		= 'S'
	AND	A.NumeroOperacion	= P.numoper
	AND	A.id_sistema		= P.sistema


	UPDATE	#tmp_pendientes
	SET	glo_producto = descripcion
	FROM 	PRODUCTO c  WITH (NOLOCK)
	WHERE	producto = c.codigo_producto
        AND     sistema = c.Id_Sistema


	SELECT	sistema		,
		Glo_Producto	,
		numoper		,
		cliente		,
		moneda		,
		Monto		,
		Operador	,
		ErrorG
	FROM	#tmp_pendientes
   	WHERE	muestra	= 'S'
	ORDER
	BY	sistema	,
		numoper

END


GO

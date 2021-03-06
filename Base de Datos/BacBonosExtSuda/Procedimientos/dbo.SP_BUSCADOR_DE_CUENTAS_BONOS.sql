USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCADOR_DE_CUENTAS_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCADOR_DE_CUENTAS_BONOS]
AS
BEGIN

	SET NOCOUNT ON

	/*=========================================================7=========================================================*/
	/*==================================================================================================================*/
	DECLARE @rut_estado	NUMERIC(09)
	,	@rut_central	NUMERIC(09)
	,	@RUT_CLIENTE	NUMERIC(9)
	,	@fechaProc	DATETIME
	/*==================================================================================================================*/
	/*==================================================================================================================*/
	SELECT	@rut_estado  = 97030000
	,	@rut_central = 97029000

	SELECT	@RUT_CLIENTE = ACRUTPROP
	,	@fechaProc   = acfecproc	
	FROM	TEXT_ARC_CTL_DRI

	/*==================================================================================================================*/
	/*==================================================================================================================*/
	CREATE TABLE #TMPCARTERA
          (
           Sistema        CHAR(03) ,
           t_movimiento   CHAR(03) ,
           t_operacion    CHAR(04) ,
           RutCartera     NUMERIC(09) ,
           NumDocu        NUMERIC(10) ,
           Correla        NUMERIC(03) ,
           NumOper        NUMERIC(10) ,
           CodigoInst     NUMERIC(05) ,
           Instrumento    VARCHAR(25) ,
           Mascara        VARCHAR(25) ,
           InstSer        VARCHAR(25) ,
           Moneda         NUMERIC(03) ,
           CMoneda        CHAR(03) ,
           Nominal        NUMERIC(19,04),
           Monto          NUMERIC(19,04),
           Variable       VARCHAR(30) ,
           Seriado        CHAR(01) ,
           CtaContable    CHAR(20) ,
           FolPerfil      NUMERIC(05) ,          ---  19 
           CorPerfil      NUMERIC(05) ,          ---  20
           CodigoVariable VARCHAR(30) ,          ---  21
           Fijo           CHAR(01) ,             ---  22
           CampoVariable  NUMERIC(05) ,
           RutCliente     NUMERIC(09) ,
           CodigoCliente  NUMERIC(09) ,
           RutEmisor      NUMERIC(09) ,
           tipobono       CHAR(01) ,
           ForPagI        NUMERIC(04) ,
           ForPagV        NUMERIC(04) ,
           TipoLinea      CHAR(01) ,
           TipoLetra      CHAR(01) ,
           FechaInip      DATETIME ,
           FechaVtop      DATETIME ,
           tipopero       CHAR(03) ,
	   CtaCbleCorr	  CHAR(15) ,
	   EstObj	  CHAR(5)	
        )

	DECLARE @Valor_Observado  		FLOAT

	SELECT	@Valor_Observado = ISNULL( vmvalor, 1.0 )
	FROM	VIEW_VALOR_MONEDA
	,	text_arc_ctl_dri
	WHERE	vmcodigo         = 994
	AND	vmfecha          = acfecproc --@Fecha_Hoy

	/*==================================================================================================================*/
	/*==================================================================================================================*/
	DELETE CARTERA_CUENTA    

	/*==================================================================================================================*/
	/* Tasa Mercado (Agrega Bloque)                                                                                     */
	/*==================================================================================================================*/
	INSERT INTO #TMPCARTERA
	SELECT	DISTINCT	
		'BEX',
		'TMF',
		'TMCP',
		a.morutcart,
		a.monumdocu,
		1,
		a.monumdocu,
		a.cod_familia,
		b.Nom_Familia,
		a.cod_nemo,
		a.id_instrum,
		a.momonemi,
		CONVERT( CHAR(03),a.momonemi ),
		a.monominal,
		(a.modIFsb * CASE WHEN (a.PorcjeCob /100) = 0 THEN 1 ELSE (a.PorcjeCob /100)END)
	,	CASE	WHEN a.codigo_carterasuper = 'T' THEN CASE WHEN a.modifsb  >= 0 THEN CONVERT( VARCHAR(30), 'dif_valor_mercado_pos' )
							 	   ELSE CONVERT( VARCHAR(30), 'dif_valor_mercado_neg' ) END 
			ELSE CASE WHEN a.modifsb  >= 0 THEN CONVERT( VARCHAR(30), 'utilidad' )
				  ELSE CONVERT( VARCHAR(30), 'perdida' ) END 
		END
	,	'S', 
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0,--CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		a.morutcli,
		a.mocodcli,
		a.morutemi,
		0,	
		0,
		0,
		CASE	WHEN   a.modifsb >=0 THEN CONVERT( VARCHAR(30), 'D' )
			ELSE CONVERT( VARCHAR(30), 'H' ) END ,
		'', 
		a.mofecemi,
		a.mofecven,
		''	     ,
		''
	,	CASE WHEN PorcjeCob <> 0 THEN 'CBTO' ELSE 'DCBTO' END
	FROM	TEXT_MVT_DRI_TAS_MERC	A 
	,	TEXT_FML_INM		B 
	,	VIEW_EMISOR 	
	WHERE	A.motipoper	= 'TM'
	AND	A.monominal	> 0.0 
	AND	A.mostatreg	= ''
	AND	A.mofecpro	= @fechaProc
	AND	b.Cod_familia	= A.cod_familia
	AND	emrut		= A.morutemi	

	INSERT	INTO #TMPCARTERA
	SELECT	A.Sistema
	,	A.t_movimiento
	,	A.t_operacion
	,	A.RutCartera
	,	A.NumDocu
	,	A.Correla
	,	A.NumOper
	,	A.CodigoInst
	,	A.Instrumento
	,	A.Mascara
	,	A.InstSer
	,	A.Moneda
	,	A.CMoneda
	,	A.Nominal
	,	(B.modifsb - A.Monto)
	,	A.Variable
	,	A.Seriado
	,	A.CtaContable
	,	A.FolPerfil
	,	A.CorPerfil
	,	A.CodigoVariable
	,	A.Fijo
	,	A.CampoVariable
	,	A.RutCliente
	,	A.CodigoCliente
	,	A.RutEmisor
	,	A.tipobono
	,	A.ForPagI
	,	A.ForPagV
	,	A.TipoLinea
	,	A.TipoLetra
	,	A.FechaInip
	,	A.FechaVtop
	,	A.tipopero
	,	A.CtaCbleCorr
	,	'DCBTO'
	FROM	#TMPCARTERA		A
	,	TEXT_MVT_DRI_TAS_MERC	B
	WHERE	A.Sistema	= 'BEX'
	AND	A.t_movimiento	= 'TMF'
	AND	A.t_operacion	= 'TMCP'
	AND	A.EstObj	= 'CBTO'
	AND	B.motipoper	= 'TM'
	AND	B.monominal	> 0.0 
	AND	B.mostatreg	= ''
	AND	B.mofecpro	= @fechaProc
	AND	B.monumdocu	= A.NumDocu
	AND	B.mocorrelativo	= A.Correla
	AND	B.monumoper	= A.NumOper

	/*==================================================================================================================*/
	/* Compra Propia (Valor compra)                                                                                     */
	/*==================================================================================================================*/
	INSERT INTO #TMPCARTERA
	SELECT	DISTINCT 
		'BEX',
		'MOV',
		'CP',
		a.morutcart,
		a.monumdocu,
		1,--mocorrela,
		a.monumdocu,
		a.cod_familia,
		b.Nom_Familia,
		a.cod_nemo,
		a.id_instrum,
		a.momonemi,
		CONVERT( CHAR(03),a.momonemi ),
		a.monominal,
		CONVERT( FLOAT, a.movalcomp ),
		CONVERT( VARCHAR(30), 'valor_compra' ),
		'S', --cpseriado,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0,		-- CODIGO VARIABLE
		'N',
		CONVERT( NUMERIC(05), 0 ),
		a.morutcli,
		a.mocodcli,
		a.morutemi,
		convert(char(1),E.emtipo), -- Falta de Donde sacar el Tipo Bono (motipobono)
		0,
		0,
		'D',
		'',
		a.mofecemi,
		a.mofecven,
		''	     ,
		ISNULL(convert(char(15),f.codigo_corres) , ' ')    			
	,	''
	FROM	TEXT_MVT_DRI		A 
	INNER JOIN VIEW_EMISOR 		E
	ON E.emrut = A.morutemi
	AND E.emrut = A.morutemi 
	INNER JOIN TEXT_FML_INM		B 
	ON B.Cod_familia = A.cod_familia
	RIGHT OUTER JOIN VIEW_CORRESPONSAL	F
	ON f.codigo_moneda	= a.momonemi
	AND f.codigo_swift	= a.corr_bco_swift
	WHERE	A.mofecpro		= @fechaProc
	AND	A.mofecpago		= @fechaProc
	AND	A.motipoper		= 'CP'
	AND	A.monominal		> 0.0 
	AND		A.mostatreg		<> 'A'
	AND		(f.rut_cliente	= @RUT_CLIENTE	
	AND		f.codigo_cliente = 1
							AND a.forma_pago	IN (2, 11, 12, 13, 14, 111, 112, 113, 122))

	/*==================================================================================================================*/
	/* Compra Propia (Intereses Acumulados)      */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BEX',
		'MOV',
		'CP',
		a.rsrutcart,
		a.rsnumdocu,
		1, --cpcorrela,
		a.rsnumdocu,
		a.cod_familia,
		b.Nom_Familia,
		a.cod_nemo,
		a.id_instrum,
		a.rsmonemi,
		CONVERT( CHAR(03),a.rsmonemi ),
		a.CapitalPeso,
		CONVERT( FLOAT, a.InteresPeso   ), 
		'valor_compra',
		'S',    
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0,	--CODIGO VARIABLE
		'N',
		CONVERT( NUMERIC(05), 0 ),
		a.rsrutcli,
		a.rscodcli,
		CONVERT( NUMERIC(09), 0 ),
		convert(char(1),emtipo), 
		0,
		0,
		'D',
		'',
		a.rsfecemis,
		a.rsfecvcto,
		'',
		' '
	,	'' 
	FROM	TEXT_RSU	A 
	,	TEXT_FML_INM	B 
	,	VIEW_EMISOR 	
	WHERE	A.rsfecpro	= @fechaProc 
	AND	A.rstipoper	= 'DEV'
	AND	A.rsfecpago	< @fechaProc
	AND	A.rsfeccomp	< @fechaProc	
	AND	A.rsnominal	> 0.0
	AND	b.Cod_familia 	= A.cod_familia
	AND	emrut		= A.rsrutemis
		
	/*==================================================================================================================*/
	/* Compra Propia (Intereses Acumulados) -- Interes                                                         */
	/*==================================================================================================================*/
	INSERT INTO #TMPCARTERA
	SELECT	'BEX',
		'DEV',
		'DCP',
		a.rsrutcart,
		a.rsnumdocu,
		1, 
		a.rsnumdocu,
		a.cod_familia,
		b.Nom_Familia,
		a.cod_nemo,
		a.id_instrum,
		a.rsmonemi,
		CONVERT( CHAR(03),a.rsmonemi ),
		a.CapitalPeso,
		CONVERT( FLOAT, a.InteresPeso   ), 
		'interes_papel',
		'S',    
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0,	-- CODIGO VARIABLE 
		'N',
		CONVERT( NUMERIC(05), 0 ),
		a.rsrutcli,
		a.rscodcli,
		CONVERT( NUMERIC(09), 0 ),
		convert(char(1),emtipo), 
		0,
		0,
		'H',
		'',
		a.rsfecemis,
		a.rsfecvcto,
		'',
		' ' 
	,	''
	FROM	TEXT_RSU	A 
	,	TEXT_FML_INM	B 
	,	VIEW_EMISOR 	
	WHERE	rsfecpro	= @fechaProc 
	AND	rstipoper	= 'DEV'
	AND	rsnominal	> 0.0
	AND	a.rsfeccomp	< @fechaProc	
	AND	a.rsfecpago	< @fechaProc	 	
	AND	b.Cod_familia 	= a.cod_familia
	AND	emrut		= a.rsrutemis

	/*************************************************************************************************************/
	/**************************** PROCESO DE ACTUALIZACION DE CAMPO VARIABLE  ************************************/
	/*************************************************************************************************************/

	CREATE TABLE #TEMPORAL
	(	id_sistema	CHAR(03) 
	,	tipo_movimiento	CHAR(05)
	,	tipo_operacion	CHAR(05)
	,	operacion	NUMERIC(10,0)
	,	documento	NUMERIC(10,0)
	,	correlativo	NUMERIC(3,0)
	,	estadocobertura	CHAR(05)
	,	CodClas		CHAR(10)
	,	Estado		CHAR(01)
	)

	INSERT	INTO #TEMPORAL
	SELECT	Sistema
	,	t_movimiento
	,	t_operacion
	,	NumOper    
	,	NumDocu
	,	Correla
	,	EstObj
	,	''
	,	'N'
	FROM	#TMPCARTERA

	DECLARE	@IdSistema		CHAR(03)
	,	@Tipo_Movimiento	CHAR(05)
	,	@Tipo_Operacion		CHAR(05)
	,	@NumOpe			NUMERIC(10,0)
	,	@NumDocu		NUMERIC(10,0)
	,	@NumCorre		NUMERIC(03)
	,	@EstadoCobertura	CHAR(05)
	,	@CodClas		CHAR(10)
	,	@Estado			CHAR(01)

	WHILE 1 = 1 BEGIN

		SELECT	@CodClas = '*'

		SET ROWCOUNT 1

		SELECT	@IdSistema		= id_sistema 
		,	@Tipo_Movimiento	= tipo_movimiento
		,	@Tipo_Operacion		= tipo_operacion
		,	@NumOpe			= operacion
		,	@NumDocu		= documento
		,	@NumCorre		= correlativo
		,	@EstadoCobertura	= estadocobertura
		,	@CodClas		= CodClas
		FROM	#TEMPORAL
		WHERE	Estado			= 'N'

		SET ROWCOUNT 0

		IF @CodClas = '*'
			BREAK

		EXECUTE @CodClas = BACPARAMSUDA.DBO.SP_CON_CLASIFICACION_CARTERA	@IdSistema 
										,	@Tipo_Movimiento 
										,	@Tipo_Operacion 
										,	@NumOpe    
										,	@NumDocu 
										,	@NumCorre
										,	@EstadoCobertura

		SET NOCOUNT ON

		UPDATE	#TEMPORAL
		SET	CodClas		= @CodClas
		,	Estado		= 'S'
		WHERE	id_sistema	= @IdSistema 
		AND	tipo_movimiento	= @Tipo_Movimiento
		AND	tipo_operacion	= @Tipo_Operacion
		AND	operacion	= @NumOpe
		AND	documento	= @NumDocu
		AND	correlativo	= @NumCorre
		AND	estadocobertura	= @EstadoCobertura
	END

	UPDATE	#TMPCARTERA
	SET	CodigoVariable		= CodClas
	FROM	#TEMPORAL		A
	WHERE	#TMPCARTERA.Sistema		= A.id_sistema
	AND	#TMPCARTERA.t_movimiento	= A.tipo_movimiento
	AND	#TMPCARTERA.t_operacion		= A.tipo_operacion
	AND	#TMPCARTERA.NumOper		= A.operacion
	AND	#TMPCARTERA.NumDocu		= A.documento
	AND	#TMPCARTERA.Correla		= A.correlativo
	AND	#TMPCARTERA.EstObj 		= A.EstadoCobertura

	/*==================================================================================================================*/
	/*==================================================================================================================*/
	INSERT	INTO CARTERA_CUENTA
	SELECT	Sistema,
		t_movimiento,
		t_operacion,
		RutCartera,
		NumDocu,
		Correla,
		NumOper,
		CodigoInst,
		Instrumento,
		Mascara,
		InstSer,
		Moneda,
		CMoneda,
		Nominal,
		Monto,
		Variable,
		Seriado,
		0,
		0,
		0,
		CodigoVariable,
		'',
		0,
		RutCliente,
		CodigoCliente,
		RutEmisor,
		tipobono,
		ForPagI,
		ForPagV,
		TipoLinea,
		TipoLetra,
		FechaInip,
		FechaVtop
	FROM #TMPCARTERA

	-------------------------------------------------------------------------------------------------------------
	SELECT   b.id_sistema
	       	,b.tipo_movimiento
		,b.tipo_operacion     
		,b.codigo_instrumento 
		,b.moneda_instrumento  
		,a.nombre_campo_tabla  
		,a.codigo_campo       
		,c.tipo_movimiento_cuenta  
		,c.codigo_cuenta
		,c.folio_perfil        
		,c.correlativo_perfil 
		,c.perfil_fijo     
		,c.codigo_campo_variable
	INTO	#PERFIL
	FROM	VIEW_CAMPO_CNT		a 
	,	VIEW_PERFIL_CNT		b 
	,	VIEW_PERFIL_DETALLE_CNT	c 
	WHERE	a.id_sistema		= 'BEX'
	AND	a.tipo_movimiento	= b.tipo_movimiento
	AND	a.tipo_operacion	= b.tipo_operacion
	AND	b.folio_perfil		= c.folio_perfil
	AND	a.codigo_campo		= c.codigo_campo
	AND	a.id_sistema		= b.id_sistema 	 	
	
	--------------------------------------------------------------------------------------------------
	UPDATE CARTERA_CUENTA
	SET	CtaContable	= codigo_cuenta
	,	FolPerfil	= folio_perfil
	,	CorPerfil	= correlativo_perfil
	,	Fijo		= perfil_fijo
	,	CampoVariable	= codigo_campo_variable
	,	monto		= (monto * (CASE Variable WHEN 'utilidad' THEN @Valor_Observado
							WHEN 'perdida'  THEN @Valor_Observado
							ELSE 1 END))
	FROM	#PERFIL    
	WHERE	tipo_movimiento		= t_movimiento 
	AND	tipo_operacion		= t_operacion 
	AND	codigo_instrumento	= CONVERT(CHAR(5),codigoInst)
	AND	moneda_instrumento	= moneda  
	AND	nombre_campo_tabla	= Variable
	AND	tipo_movimiento_cuenta	= TipoLinea 

	/*==================================================================================================================*/
	/* Recuperar datos para los perfiles logicos                                                                        */
	/*==================================================================================================================*/
	UPDATE	CARTERA_CUENTA
	SET	CtaContable        = a.codigo_cuenta
	FROM	CARTERA_CUENTA
	,	VIEW_PERFIL_VARIABLE_CNT	a
	WHERE	a.folio_perfil		= folperfil
	AND	a.correlativo_perfil	= corperfil
	AND	a.valor_dato_campo	= CodigoVariable --tipobono
	AND	fijo			= 'N' 

	SET NOCOUNT OFF

END

GO

USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_BONOS]
AS  
BEGIN   
  
	SET NOCOUNT ON  
  
	DECLARE @VALORX				NUMERIC(19,4)
	,		@xx15				NUMERIC(19,4)
	,		@nmone				NUMERIC(3)
	,		@campo_26			DATETIME
	,		@xproducto			NUMERIC(10)
	,		@nncup				NUMERIC(5)
	,		@nintel				NUMERIC(19,4)
	,		@reajustes			NUMERIC(19,4)
	,		@cuentaI			CHAR(20)
	,		@cuentaR			CHAR(20)
	,		@cod_instru			NUMERIC(3)
	,		@valor_compra		NUMERIC(19,4)
	,		@valor_compra_X		NUMERIC(19,4)
	,		@vDolar_obs			NUMERIC(19,4)
	,		@nvori				NUMERIC(19,4)
	,		@barra				NUMERIC(19)
	,		@tip_tasa			CHAR(3)
	,		@inst_variable		CHAR(1)
	,		@XX					CHAR(3)
	,		@crut				NUMERIC(9)
	,		@DIG				CHAR(1)
	,		@ccmor				CHAR(3)
	,		@CCMON				CHAR(2)
	,		@var_tasa			CHAR(15)
	,		@saldo				NUMERIC(19,4)
	,		@saldopeso			NUMERIC(19)

	DECLARE @c					CHAR(1)
	,		@c1					CHAR(1)
	,		@mascara			CHAR(20)
	,		@instrumento		CHAR(12)
	,		@codigo				NUMERIC(5)
	,		@nominal			NUMERIC(19,4)
	,		@tir				NUMERIC(19,4)
	,		@taspact			NUMERIC(19,4)
	,		@fecvenpact			DATETIME
	,		@moneda				NUMERIC(5)
	,		@tipoper			CHAR(3)
	,		@valinip			NUMERIC(19,4)
	,		@valvenp			NUMERIC(19,4)
	,		@valcomp			NUMERIC(19,4)
	,		@valcomp2			NUMERIC(19,4)
	,		@rutcli				NUMERIC(9)
	,		@codcli				CHAR(2)
	,		@rutemi				NUMERIC(9)
	,		@tabla				CHAR(4)
	,		@numero				NUMERIC(9)
	,		@cuenta				CHAR(20)
	,		@tipo_tasa			NUMERIC(1)
	,		@tdfecven			DATETIME
	,		@tdamort			NUMERIC(19,4)
	,		@tdsaldo			NUMERIC(19,4)
	,		@inversion			NUMERIC(5)
	,		@tipo_cuenta		CHAR(2)
	,		@fecha				DATETIME
	,		@fecpro				DATETIME
	,		@periodo			INT
	,		@tdcupon			CHAR(3)
	,		@fecvenp			DATETIME
	,		@cliente			NUMERIC(9)
	,		@estado				NUMERIC(9)
	,		@emtipo				CHAR(5)
	,		@nmes				CHAR(2)
	,		@nmes_a				CHAR(2)
	,		@nano				CHAR(4)
	,		@cano				CHAR(4)
	,		@nNumdocu			NUMERIC(10,0)
	,		@nNumoper			NUMERIC(10,0)
	,		@fec_comp			DATETIME
	,		@CTTAS				CHAR(3)
	,		@dias_dife			NUMERIC(6)
	,		@tran_perm			CHAR(10)
	,		@tirc				NUMERIC(19,4)
	,		@DIAS				NUMERIC(19)
	,		@sum_capi			NUMERIC(15)
	,		@nIntasb			NUMERIC(5)
	,		@nIncodigo			NUMERIC(5)
	,		@tasa				NUMERIC(19,4)
	,		@dfecfmes			DATETIME
	,		@dFecFMesProx		DATETIME
	,		@acfecprox			DATETIME
	,		@fecha_emi			DATETIME
	,		@fec_ven			DATETIME
	,		@valpres			NUMERIC(19,4)
	,		@valdolarant		NUMERIC(19,4)
	,		@mto_opc_compra_x	NUMERIC(10,2)
	,		@mto_opc_compra		FLOAT
	,		@valor				NUMERIC(19,4)
	,		@interes_or			NUMERIC(19,4)
	,		@base				NUMERIC(3)
	,		@tasa_int			NUMERIC(20,8)  -- MAP 2016-06-16 NUMERIC(16,8) Monto o tasa 
	,		@destino			NUMERIC(3)
	,		@nomin_en_pesos		NUMERIC(19,4)
	,		@cuotas_rmtes		NUMERIC(5)
	,		@nombre				CHAR(15)
	,		@nomInstr			CHAR(10)
	,		@digito				CHAR(1)
	,		@valormecado		NUMERIC(19,4)
	,		@valormecadopeso	NUMERIC(19,4)
	,		@tasamercado		NUMERIC(19,4)--> se cambia a 19,4 desde 16,8
	,		@codemi				CHAR(1)
	,		@c_riesgo			VARCHAR(3)
	--+++jcamposd CDTCOP
	,		@ciclo				NUMERIC(5)
	--+++jcamposd CDTCOP

	DECLARE	@PrimerDiaMes		CHAR(12)  
	,		@UltimoDiaMes		CHAR(12)  
	,		@vTipo_Cambio		NUMERIC(19,4)  

	SELECT  @fecpro				= acfecproc
	,		@cliente			= acrutprop
	,		@acfecprox			= acfecprox
	,		@valdolarant		= dolarObsFinMes
	FROM	TEXT_ARC_CTL_DRI	with(nolock)

	SET		@vDolar_obs			= isnull( (SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = 994 AND Fecha = @fecpro),0)
	SET		@estado				= (SELECT top 1 emrut FROM VIEW_EMISOR with(nolock) WHERE emgeneric = 'EST')
 
	DECLARE @Fecha_Contable		DATETIME
		SET	@Fecha_Contable		= @fecpro
  
	IF MONTH(@fecpro) <> MONTH(@acfecprox)
	BEGIN
		SET	@PrimerDiaMes		= SUBSTRING((CONVERT(CHAR(8), @acfecprox, 112)),1,6)  + '01'  
		SET	@UltimoDiaMes		= CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY, -1, @PrimerDiaMes)), 112)  
		SET	@fecpro				= CONVERT(DATETIME, @UltimoDiaMes, 112)
	END
  
  
	CREATE TABLE #CARTERA
	(	mascara					CHAR(20)							--   1      
	,	numdocu					CHAR(12)							--   2  
	,	numoper					CHAR(12)							--   3  
	,	instrumento				CHAR(20)							--   4  
	,	codigo					NUMERIC(5)							--   5  
	,	nominal					NUMERIC(19,4)						--   6  
	,	tir						NUMERIC(19,4)						--   7  
	,	taspact					NUMERIC(19,4)	NULL	DEFAULT(0)	--   8  
	,	fecvenpact				DATETIME		NULL				--   9  
	,	moneda					NUMERIC(5)							--   10  
	,	tipoper					CHAR(3)								--   11  
	,	valinip					NUMERIC(19,4)	NULL	DEFAULT(0)	--   14  
	,	rutcli					NUMERIC(9)							--   15  
	,	codcli					CHAR(2)								--   16  
	,	rutemi					NUMERIC(9)							--   17  
	,	tabla					CHAR(4)								--   18  
	,	periodo					INT									--   19  
	,	fecvenp					DATETIME		NULL				--   20  
	,	valpres					NUMERIC(19,4)	NULL	DEFAULT(0)	--   21  
	,	valvenp					NUMERIC(19,4)	NULL	DEFAULT(0)	--   22  
	,	cuenta					CHAR(20)		NULL	DEFAULT('')	--   23  
	,	fecha_compra			DATETIME							--   24  
	,	fec_ven					DATETIME							--   25  
	,	amortizacion			NUMERIC(19,4)						--   26  
	,	saldo					NUMERIC(19,4)						--   27  
	,	invers					NUMERIC(5)							--   28  
	,	cttas					CHAR(3)								--   29  
	,	dias_dife				NUMERIC(6)							--   30  
	,	tran_perm				CHAR(10)							--   31   
	,	tirc					NUMERIC(19,4)						--   32   
	,	campo_26				DATETIME							--   33    
	,	interes					NUMERIC(19,4)						--   34  
	,	reajustes				NUMERIC(19,4)						--   35  
	,	fecha_emi				DATETIME							--   36  
	,	valcomp					NUMERIC(19,4)	NULL	DEFAULT(0)	--   37  
	,	interes_or				NUMERIC(19,4)						--   38  
	,	base					NUMERIC(3)							--   39  
	,	tasa_int				NUMERIC(20,8)						--   40    -- MAP 2016-06-16 NUMERIC(16,8) -- monto o tasa ...
	,	destino					NUMERIC(3)							--   41  
	,	valormecado				NUMERIC(19,4)						--   42  
	,	tasamercado				NUMERIC(19,4)	NOT	NULL DEFAULT(0)	--   43--> se cambia a 19,4 desde 16,8  
	,	c_riesgo				VARCHAR(3)							-->	 45	--> Riesgo Pais PRD-21996
	,	correla					NUMERIC(9)		identity(1,1)		--   44  
   )  

	---------------------------------------------------------------------------------------------  
	CREATE TABLE #NEOSOFT  
	(	codigo_pais				VARCHAR(3)  
	,	fecha_contable			DATETIME  
	,	fecha_interfaz			DATETIME  
	,	ident_interfaz			VARCHAR(14)  
	,	cod_empresa				VARCHAR(3)  
	,	cod_sucursal			VARCHAR(3)  
	,	status_contrato			VARCHAR(3)  
	,	status_crediticio		VARCHAR(1)  
	,	fam_producto			CHAR(4)  
	,	T_producto				CHAR(4)      --10  
	,	C_interno				VARCHAR(16)  
	,	Clase_Producto			VARCHAR(1)  
	,	Tipologia_producto		VARCHAR(1)  
	,	F_operacion				DATETIME  
	,	F_devengamiento			DATETIME  
	,	rut						VARCHAR(12)  
	,	dig						VARCHAR(1)  
	,	costo					VARCHAR(10)  
	,	n_operacion				CHAR(20)  
	,	fecha_inic				DATETIME     --20  
	,	fecha_vcto				DATETIME  
	,	fecha_renovacion		VARCHAR(8)  
	,	indicador				VARCHAR(1)  
	,	cod_inter_mda			VARCHAR(3)  
	,	s_mto_cap_ori			CHAR(1)  
	,	mto_cap_origen			NUMERIC(19,4)  
	,	s_mto_cap_loc			CHAR(1)  
	,	mto_cap_local			NUMERIC(19,4)  
	,	mto_linea_credito		NUMERIC(19,4)  
	,	s_reaj_mda_loc			CHAR(1)  --30  
	,	mto_reaj_loc			NUMERIC(19,4)  
	,	s_int_mda_orig			CHAR(1)  
	,	mto_int_mda_orig		NUMERIC(19,4)  
	,	s_int_mda_loc			CHAR(1)  
	,	mto_int_mda_loc			NUMERIC(19,4) --35  
	,	tasa_f_v				CHAR(1)  
	,	tasa_base				CHAR(4)  
	,	tasa_interes			NUMERIC(19,4) --> se cambia a 19,4 desde 16,8 
	,	tasa_penalidad			NUMERIC(16,8)  
	,	calc_interes			VARCHAR(1) --40  
	,	c_operacion				NUMERIC(16,8)  
	,	c_fondo_oper			VARCHAR(5)  
	,	c_penalidad				VARCHAR(4)  
	,	spread					NUMERIC(16,8)  
	,	spread_pool				NUMERIC(16,8)  
	,	spread_tasa_penalidad	NUMERIC(16,8)  
	,	indicador_p_a			VARCHAR(1)  
	,	s_mto_vencido			VARCHAR(1)  
	,	d_vencidas				NUMERIC(18,2)  
	,	t_tasa					NUMERIC(3) --50  
	,	p_transfronterizo		NUMERIC(2)
	,	t_oper_transfronterizo	NUMERIC(1)  
	,	s_comision				VARCHAR(1)  
	,	mto_comision			NUMERIC(18,2)  
	,	fec_otorgamiento		VARCHAR(8)  
	,	fec_cartera				VARCHAR(8)  
	,	fec_mora				VARCHAR(8)  
	,	fec_cartera_castigada	VARCHAR(8)  
	,	n_operacion_orig		VARCHAR(20)  
	,	n_cuotas				NUMERIC(4) --60  
	,	n_cuotas_mora			NUMERIC(4)  
	,	n_cuotas_total			NUMERIC(4)  
	,	destino					NUMERIC(3)  
	,	f_suspension			VARCHAR(8)  
	,	f_u_pago				VARCHAR(8)  
	,	indicador_renovacion	VARCHAR(1)  
	,	f_renovacion			VARCHAR(8)  
	,	f_cambio				VARCHAR(8)  
	,	f_ultimo_cambio			VARCHAR(8)  
	,	nomin_en_pesos			NUMERIC(18,2) --70  
	,	s_mda_local				NUMERIC(18,2)  
	,	m_mora1					NUMERIC(18,2)  
	,	m_mora2					NUMERIC(18,2)  
	,	m_mora3					NUMERIC(18,2)  
	,	colocacion				NUMERIC(18,2)  
	,	l_credito				NUMERIC(18,2)  
	,	p_minimo				NUMERIC(18,2)  
	,	i_cobranza				VARCHAR(1)  
	,	v_mercado				NUMERIC(18,2)  
	,	v_pesos					NUMERIC(18,2) --80  
	,	t_cartera				CHAR(10)  
	,	n_renegociacion			NUMERIC(3)  
	,	p_cuotas				NUMERIC(4)  
	,	m_pagado				NUMERIC(18,2)  
	,	t_contrato				VARCHAR(1)  
	,	t_operacion				VARCHAR(1)  
	,	t_entrega				VARCHAR(1)  
	,	mto_op_compra			NUMERIC(19,4)  
	,	i_instrumento			VARCHAR(5)  
	,	i_emisor				VARCHAR(15) --90  
	,	s_instrumento			VARCHAR(4)  
	,	s_registrada			VARCHAR(4)  
	,	c_riesgo				VARCHAR(3)
	)
  
	INSERT  INTO #CARTERA
	SELECT	TEXT_RSU.cod_nemo
		,	rsnumdocu
		,	rsnumdocu
		,	id_instrum
		,	cod_familia
		,	rsnominal * (rsvpcomp / 100.0)
		,	rstir
		,	0
		,	''
		,	rsmonemi -- 10
		,	'CP'
		,	0
		,	rsrutcli
		,	ISNULL((SELECT  Cldv FROM VIEW_CLIENTE WHERE Clrut = rsrutcli AND Clcodigo = rscodcli),0)
		,	rsrutemis
		,	'MDCP'
		,	CASE	WHEN	cod_familia	=	2001	THEN	DATEDIFF(DAY, TEXT_RSU.rsfeccomp,TEXT_RSU.rsfecvcto)   
					ELSE									ISNULL((SELECT  per_cupones FROM TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_RSU.cod_nemo),0)
				END
		,	rsfecvcto
		,	rsvalcomu
		,	PrincipalDiaPeso -- 20
		,	CtaContable
		,	rsfeccomp
		,	''
		,	0
		,	0
		,	0
		,	''
		,	DATEDIFF (DAY ,@fecpro,rsfecvcto)
		,	ISNULL((SELECT ccn_codigo_nuevo FROM BACPARAMSUDA..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = codigo_carterasuper),4)
		,	0                -- 30
		,	rsfecpcup
		,	rsinteres_acum
		,	0
		,	rsfecemis
		,	rsvppresen
		,	InteresPesoAcum
		,	rsbasemi
		,	rsinteres
		,	CASE	WHEN	rsrutcli = 97029000 THEN	211
					WHEN	rsrutcli = 97030000	THEN	212
					ELSE								221
				END
		,	rsvalmerc
		,	rstirmerc
        ,   c_riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( rsrutemis, rscodemi, 'BEX' )
	FROM	TEXT_RSU
	,		CARTERA_CUENTA
	WHERE	rsnominal   > 0
	AND		rsrutcart	> 0
	AND		Correla		= rscorrelativo -- 1
	AND		NumOper		= rsnumdocu
	AND		rsfecpro	= @fecpro
	AND		rsfecpago	< @fecpro
	AND		variable	= 'valor_compra'
	AND		t_operacion = 'CP'
	AND		rstipoper	= 'DEV'

	INSERT  INTO #CARTERA
	SELECT	DISTINCT   
			TEXT_CTR_INV.cod_nemo  
		,	monumdocu  
		,	monumdocu  
		,	TEXT_CTR_INV.id_instrum  
		,	TEXT_CTR_INV.cod_familia  
		,	monominal * (movpar/100.0)  
		,	motir  
		,	0  
		,	''  
		,	momonemi  
		,	'CP'  
		,	0  
		,	morutcli  
		,	ISNULL((SELECT cldv FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),0)  
		,	morutemi  
		,	'MDCP'  
		,	CASE	WHEN TEXT_CTR_INV.cod_familia	=	2001	THEN	DATEDIFF(DAY,mofecpago,mofecven)
					ELSE												ISNULL((SELECT  per_cupones FROM TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)
			END
		,	mofecven  
		,	movalcomu  
		,	capitalpeso  
		,	CtaContable  
		,	mofecpro  
		,	''  
		,	0  
		,	0  
		,	0  
		,	''  
		,	DATEDIFF(DAY,@fecpro,mofecven)  
		,	ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = TEXT_MVT_DRI.codigo_carterasuper),4)  
		,	0  
		,	mofecpcup  
		,	CASE	WHEN TEXT_CTR_INV.cod_familia <> 2001 THEN moint_compra  
					ELSE                         (SELECT rsinteres_acum FROM TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV')  
				END  
		,	moreajuste  
		,	mofecemi  
		,	movpresen  
		,	interespeso  
		,	mobasemi  
		,	mointeres  
		,	CASE	WHEN morutcli = 97029000 THEN 211
					WHEN morutcli = 97030000 THEN 212
					ELSE               221
				END  
		,	ISNULL((SELECT rsvalmerc FROM TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)  
		,	ISNULL((SELECT rstirmerc FROM TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)  

                ,       c_riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( cprutemi, cpcodemi, 'BEX' )
	FROM	TEXT_MVT_DRI  
	,		CARTERA_CUENTA  
	,		TEXT_CTR_INV  
	WHERE	monominal     > 0.0  
	AND		morutcart     > 0.0  
	AND		numdocu       = monumdocu  
	AND		Correla       = mocorrelativo  
	AND		NumOper       = monumoper  
	AND		variable      = 'valor_compra'  
	AND		motipoper     = 'CP'  
	AND		mofecpago     = @fecpro  
	AND		mofecpro      = @fecpro  
	AND		mostatreg    <> 'A'  
	AND		cpnumdocu     = monumoper  
	AND		cpcorrelativo = mocorrelativo  
	AND		cpnominal     > 0.0  

	INSERT  INTO #CARTERA
	SELECT	cod_nemo
		,	monumdocu
		,	monumdocu
		,	id_instrum
		,	cod_familia
		,	monominal
		,	motir
		,	0
		,	''
		,	momonemi
		,	'VP'
		,	0
		,	morutcli
		,	ISNULL((SELECT  Cldv        FROM VIEW_CLIENTE WHERE Clrut = morutcli AND Clcodigo = mocodcli),0)
		,	morutemi
		,	'MDCP'
		,	CASE	WHEN cod_familia =	2001	THEN	DATEDIFF(DAY,mofecpago,mofecven)
					ELSE								ISNULL((SELECT  per_cupones FROM TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)
				END
		,	mofecven
		,	movalcomu
		,	capitalpeso
		,	CtaContable
		,	mofecpro
		,	''
		,	0
		,	0
		,	0
		,	''
		,	DATEDIFF (DAY ,@fecpro,mofecven)
		,	ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = codigo_carterasuper),4)
		,	0
		,	mofecpcup
		,	moint_compra
		,	moreajuste
		,	mofecemi
		,	movalcomp
		,	interespeso
		,	mobasemi
		,	mointeres
		,	CASE	WHEN morutcli = 97029000 THEN	211
					WHEN morutcli = 97030000 THEN	212
					ELSE							221 
				END
		,	0
		,	0

                ,	c_riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( morutemi, cod_emi, 'BEX' )
	FROM	TEXT_MVT_DRI
		,	CARTERA_CUENTA
	WHERE	monominal   > 0
	AND		morutcart	> 0
	AND		NumDocu		= monumdocu
	AND		Correla		= mocorrelativo
	AND		NumOper		= monumoper
	AND		variable	= 'valor_venta'
	AND		motipoper	= 'VP'
	AND		mofecpago	= @fecpro
	AND		mostatreg  <> 'A'


	DECLARE CURSOR_INTER CURSOR FOR   
	SELECT	mascara,		instrumento,	codigo,						nominal     
		,	tir,			taspact,		fecvenpact,					moneda        
		,	tipoper,		valinip,		rutcli,						codcli         
		,	rutemi,			tabla,			CONVERT(CHAR(9),correla)     ,'1'              
		,	periodo,		fecvenp,		valpres,					valvenp    
		,	numdocu,		numoper,		cuenta,						fecha_compra    
		,	dias_dife,		tran_perm,		campo_26,					interes  
		,	reajustes,		fecha_emi,		fec_ven,					valcomp  
		,	interes_or,		base,			tasa_int,					destino         
		,	valormecado,	tasamercado                    
                ,	c_riesgo
	FROM	#CARTERA

	OPEN	CURSOR_INTER  
	FETCH	NEXT	FROM CURSOR_INTER
	INTO	@mascara,		@instrumento,	@codigo,					@nominal  
		,	@tir,			@taspact,		@fecvenpact,				@moneda  
		,	@tipoper,		@valinip,		@rutcli,					@codcli  
		,	@rutemi,		@tabla,			@numero,					@c  
		,	@periodo,		@fecvenp,		@valpres,					@valvenp  
		,	@nNumdocu,		@nNumoper,		@cuenta,					@fec_comp  
		,	@dias_dife,		@tran_perm,		@campo_26,					@nintel
		,	@reajustes,		@fecha_emi,		@fec_ven,					@valcomp  
		,	@interes_or,	@base,			@tasa_int,					@destino  
		,	@valormecado,	@tasamercado
       ,	@c_riesgo

	WHILE @@FETCH_STATUS  = 0
	BEGIN
		SET		@nombre		= ISNULL((SELECT  nom_emi		FROM text_emi_itl	WHERE  rut_emi		= @rutemi),'')  
		SET		@digito		= ISNULL((SELECT  digito_ver	FROM text_emi_itl	WHERE  rut_emi		= @rutemi),'')  
		SET		@nomInstr	= ISNULL((SELECT  nom_familia	FROM TEXT_FML_INM	WHERE  cod_familia	= @codigo),'')  
		SET		@codemi		= ISNULL((SELECT  emtipo		FROM view_emisor	WHERE  emrut		= @rutemi),'')  

		IF @moneda IN(994, 13)
		BEGIN  
			SET	@nomin_en_pesos		= ROUND(@nominal		*	@vDolar_obs, 0)  
			SET	@valormecadopeso	= ROUND(@valormecado	*	@vDolar_obs, 0)  
			SET	@valcomp			= CASE	WHEN @moneda = 13 THEN @valcomp
											ELSE                   ROUND(@valcomp * @valdolarant,0)
										END

										-- MAP EMERGENCIA
			SET	@vTipo_Cambio    = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)

		END ELSE
        BEGIN
			SET	@nomin_en_pesos  = ISNULL((@nominal     * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)
			SET	@valormecadopeso = ISNULL((@valormecado * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)
		--	SET	@vDolar_obs      = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)
			SET	@vTipo_Cambio    = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)
		END

		SET @dias           = @dias_dife
		SET @inst_variable  = 'N'
		SET @tip_tasa       = '0'

		SELECT	@nIntasb	= tipo_tasa   
			,	@CTTAS		= CASE	WHEN	tasa_fija	=	'F'	THEN	'FLO'	ELSE	'FIJ'	END
		FROM	TEXT_SER
		WHERE	cod_nemo	= @MASCARA
  
		IF @nIntasb > 1
		BEGIN    
			SELECT	@var_tasa		= (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = @nIntasb AND TBCATEG = 1042)

			SELECT	@inst_variable	= 'S'   
				,	@tip_tasa		= CASE	WHEN @var_tasa = 'LIBOR'	OR @var_tasa = ' LIBOR 90'	OR @var_tasa = ' LIBOR 30'	OR @var_tasa = 'LIBOR 180'	THEN '3'   
											WHEN @var_tasa = 'TIP'																							THEN '2'
											WHEN @var_tasa = 'TAB'		OR @var_tasa = 'TAB 90'		OR @var_tasa = 'TAB 30'		OR @var_tasa = 'TAB 180'	THEN '1'
											ELSE '9'
										END   

			IF	DATEDIFF (DAY ,@fecpro, @campo_26 ) < 30        -- cpfecpcup  
				SET @tip_tasa = '2' + @tip_tasa + '1'

			IF	DATEDIFF (DAY ,@fecpro, @campo_26 ) >= 30 AND  DATEDIFF (DAY ,@fecpro,@campo_26)< 90  
				SET @tip_tasa = '2' + @tip_tasa + '2'

			IF	DATEDIFF (DAY ,@fecpro,@campo_26) >= 90 AND  DATEDIFF (MONTH ,@fecpro,@campo_26) < 6  
				SET @tip_tasa = '2' + @tip_tasa + '3'

			IF	DATEDIFF (MONTH ,@fecpro,@fecvenp) >= 6  AND  DATEDIFF (YEAR ,@fecpro,@campo_26) < 1  
				SET @tip_tasa = '2' + @tip_tasa + '4'

			IF	DATEDIFF (YEAR ,@fecpro,@campo_26) >= 1  AND  DATEDIFF (YEAR ,@fecpro,@campo_26) < 3  
				SET @tip_tasa = '2' + @tip_tasa + '5'

			IF DATEDIFF (YEAR ,@fecpro,@campo_26) >= 3    
				SET @tip_tasa = '2'  + @tip_tasa + '6'

		END

		IF @inst_variable = 'N' 
		BEGIN -- fija  --N  
			IF @dias < 30   
				SET @tip_tasa =  '101'   
			IF @dias >= 30 AND @dias < 90     
				SET @tip_tasa =  '102'   
			IF @dias >= 90 AND  @dias < 180   
				SET @tip_tasa =  '103'  
			IF @dias >= 180  AND  @dias < 365    
				SET @tip_tasa =  '104'   
			IF @dias >= 365 AND  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS  
				SET @tip_tasa =  '105'   
			IF @dias >= 1095					-- MAS DE TRES AÑOS   
				SET @tip_tasa =  '106'  
		END

		IF @codigo = 2001
			SELECT @tdcupon = ISNULL(CASE WHEN (SELECT COUNT(1) FROM text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara )=0 THEN 1 END,1)
		ELSE
			SELECT @tdcupon = isnull((SELECT COUNT(1) FROM text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara ),0)

		IF @tdcupon > 0
		BEGIN
			SELECT @cuotas_rmtes = 1
		END

		SELECT @nncup = convert(numeric(4),@tdcupon)

		INSERT INTO #NEOSOFT   
		VALUES  
/*01*/	(	'CL'
		,	@fecha_Contable  
		,	@fecha_Contable -- GETDATE()  
		,	'OP51'  
		,	'001'  
		,	'1'  
		,	'A'  
		,	SPACE(1)  
		,	'MD01'  
/*10*/	,	'MDIR'   
		,	'MD01'  
		,	SPACE(1)  
		,	'M'  
		,	@fec_comp  
		,	@fecpro  
		,	CONVERT(VARCHAR(9),@rutemi)  
		,	CONVERT(VARCHAR(1),@digito)  
		,	SPACE(1)  
		,	CAST(@nNumdocu AS VARCHAR(5)) + CAST(1 AS VARCHAR(2)) + cast(@nNumoper AS VARCHAR(5))  
/*20*/	,	@fec_comp   
		,	@fecvenp  
		,	SPACE(8)  
		,	'V'  
		,	@moneda  
		,	CASE WHEN @valpres < 0 THEN '-' ELSE  '+' END  
		,	ABS(@valpres)  
		,	CASE WHEN @valvenp < 0 THEN '-' ELSE  '+' END  
	--	,	ABS(@valpres * @vDolar_obs)   
		,	CASE	WHEN @moneda IN (994,13) THEN ABS(@valpres * @vDolar_obs)   
					ELSE ABS(@valpres * @vTipo_Cambio) 
				END  --ABS(@valvenp) Contingencia Rastrear origen de datos incongruencia en estos.   
		,	0  
/*30*/	,	CASE WHEN @reajustes < 0 THEN '-' ELSE  '+' END   
		,	ABS(@reajustes)  
		,	CASE WHEN @nintel < 0 THEN '-' ELSE  '+' END  
		,	ABS(@nintel)  
		,	CASE WHEN @interes_or < 0 THEN '-' ELSE  '+' END  
		--+++jcamposd 20180418 COLTES para la colocación debe informar intereses en moneda local
		--,	ABS(@interes_or)  
		,	CASE WHEN ABS(@interes_or)  = 0 THEN ABS(@nintel * @vTipo_Cambio) ELSE  ABS(@interes_or) END 		
		-----jcamposd 20180418 COLTES para la colocación debe informar intereses en moneda local		
		,	CASE WHEN @CTTAS = 'FLO' THEN 'V' ELSE  'F' END  
		,	@base  
		,	@tir  
		,	0  
/*40*/	,	(CASE	WHEN @moneda = 998 THEN 1  
					WHEN @moneda IN(13,129) THEN 3  --COLTES jcamposd, se suma moneda COL
					WHEN @moneda = 999 THEN 4  
					ELSE 0 
				END)  
		,	0
		,	0
		,	0
		,	0
		,	0
		,	@tasamercado
		,	CASE WHEN @tipoper = 'CP' THEN 'A' ELSE  'P' END
		,	'+'
		,	0
/*50*/	,	@tip_tasa
		,	dbo.Fx_Load_Transfronterizo(@mascara, 1)	-->		51	( Producto Transfronterizo )
		,	dbo.Fx_Load_Transfronterizo(@mascara, 2)	-->		52	( Tipo de Operacion Transfronterizo )
		,	'+'
		,	0
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(8)
		,	' '
		,	@tdcupon
		,	0
		,	@tdcupon
		,	@destino
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(1)
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(8)
		,	@nominal
		,	0
		,	0
		,	0
		,	0
		,	case when @fec_comp = @fecpro THEN @valpres ELSE  0 END
		,	0
		,	0
		,	SPACE(1)
		,	@valormecadopeso
		,	@nomin_en_pesos
		,	@tran_perm
		,	0
		,	@periodo
		,	0
		,	'1'
		,	SPACE(1)
		,	SPACE(1)
				,	CASE WHEN @nomInstr <> 'CDTCOP' THEN @valcomp ELSE 0 END
		/* 20090305 -	Cambio solicitado por Margarita Salas  
						Para la Familia BONEX colocar en el campo 88 lo siguiente:  
						Si el BONEX es Federal o Soberano identificarlo como 'BS'.  
						Si el BONEX es Empresa e Instituciones Financieras  identificarlo como 'BE'.   
						Para la familia DPEX identificar en el campo 88 de la interfaz como 'DPX'   
						Para las Familias CD y NOTEX dejar como el sistema lo identifica , es decir  
						rescatar los 5 caracteres.   
		*/
		-- Ahora  
		,	CASE	WHEN @codigo = 2000 and (@codemi = 1 or @codemi = 2)	THEN 'BE   '
					WHEN @codigo = 2000 and (@codemi = 3 or @codemi = 4)	THEN 'BS   '
					WHEN @codigo = 2003										THEN 'DPX  '
					ELSE														 SUBSTRING(@nomInstr,1,5)
				END
		-- Antes  
		/*  
		,	CASE	WHEN @codemi =1  AND @codigo <> 2001 THEN	'BE   '  
					WHEN @codemi =3  AND @codigo <> 2001 THEN	'BS   '  
					ELSE										SUBSTRING(@nomInstr,1,5) END    
		*/  
		,	@nombre
		,	SPACE(4)
		,	SPACE(4)
                ,	@c_riesgo		-->	SPACE(3)
		)
		FETCH	NEXT FROM CURSOR_INTER
		INTO	@mascara		, @instrumento	, @codigo		, @nominal  
		,		@tir			, @taspact		, @fecvenpact	, @moneda  
		,		@tipoper		, @valinip		, @rutcli		, @codcli  
		,		@rutemi			, @tabla		, @numero		, @c  
		,		@periodo		, @fecvenp		, @valpres		, @valvenp  
		,		@nNumdocu		, @nNumoper		, @cuenta		, @fec_comp  
		,		@dias_dife		, @tran_perm	, @campo_26		, @nintel  
		,		@reajustes		, @fecha_emi	, @fec_ven		, @valcomp  
		,		@interes_or		, @base			, @tasa_int		, @destino  
		,		@valormecado	, @tasamercado  
		,		@c_riesgo
	END  

	CLOSE CURSOR_INTER  
	DEALLOCATE  CURSOR_INTER  

	SELECT	codigo_pais					-->		01
		,	fecha_contable
		,	fecha_interfaz
		,	ident_interfaz
		,	cod_empresa
		,	cod_sucursal
		,	status_contrato
		,	status_crediticio
		,	fam_producto
		,	T_producto					-->		10
		,	C_interno
		,	Clase_Producto
		,	Tipologia_producto
		,	F_operacion
		,	F_devengamiento
		,	rut
		,	dig
		,	costo
		,	n_operacion
		,	fecha_inic					-->		20
		,	fecha_vcto
		,	fecha_renovacion
		,	indicador
		,	cod_inter_mda
		,	s_mto_cap_ori
		,	mto_cap_origen
		,	s_mto_cap_loc
		,	mto_cap_local
		,	mto_linea_credito
		,	s_reaj_mda_loc				-->		30
		,	mto_reaj_loc
		,	s_int_mda_orig
		,	mto_int_mda_orig
		,	s_int_mda_loc
		,	mto_int_mda_loc             -->     35 
		,	tasa_f_v
		,	tasa_base
		,	tasa_interes
		,	tasa_penalidad
		,	calc_interes				-->		40
		,	c_operacion
		,	c_fondo_oper
		,	c_penalidad
		,	spread
		,	spread_pool
		,	spread_tasa_penalidad
		,	indicador_p_a
		,	s_mto_vencido
		,	d_vencidas
		,	t_tasa						-->		50
		,	p_transfronterizo
		,	t_oper_transfronterizo
		,	s_comision
		,	mto_comision
		,	fec_otorgamiento
		,	fec_cartera
		,	fec_mora
		,	fec_cartera_castigada
		,	n_operacion_orig
		,	n_cuotas					-->		60
		,	n_cuotas_mora
		,	n_cuotas_total
		,	destino
		,	f_suspension
		,	f_u_pago
		,	indicador_renovacion
		,	f_renovacion
		,	f_cambio
		,	f_ultimo_cambio
		,	nomin_en_pesos				-->		70
		,	s_mda_local
		,	m_mora1
		,	m_mora2
		,	m_mora3
		,	colocacion
		,	l_credito
		,	p_minimo
		,	i_cobranza
		,	v_mercado
		,	v_pesos						-->		80
		,	t_cartera
		,	n_renegociacion
		,	p_cuotas
		,	m_pagado
		,	t_contrato
		,	t_operacion
		,	t_entrega
		,	mto_op_compra
		,	i_instrumento
		,	i_emisor					-->		90
		,	s_instrumento
		,	s_registrada
		,	c_riesgo					-->		93
		,	CantidadReg		=	(	SELECT COUNT(1) 
									FROM	#NEOSOFT
								)
		FROM	#NEOSOFT

	
END
GO

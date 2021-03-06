USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_BONEX]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_BONEX 
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_BONEX]
(
		@FECHA		 DATE = NULL	
)
AS  
BEGIN   
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--MODIFICACION	: 02-08-2018	operaciones duplicadas
--MODIFICACION	: 05-10-2018	operaciones duplicadas

	--- refactorizar...
	SET NOCOUNT ON  

	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	DECLARE @ENTIDAD VARCHAR(30)

	IF @FECHA IS NULL 
		BEGIN
			SET @FECHA_PROC_FILTRO = (select top 1 acfecproc from Bacfwdsuda.dbo.mfac with(nolock))
--			SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecante FROM BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI WITH(NOLOCK)) 
--			SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI WITH(NOLOCK)) 
		END 
	ELSE
		BEGIN
			SET @FECHA_PROC_FILTRO = @FECHA
		END

	SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

  
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
	,		@codigo				VARCHAR(3)
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
	,		@rutcli				varchar(25)
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
	,		@fecha1				DATETIME -->  
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
	,		@fec_comp			DATEtime
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
	,		@tasa_int			NUMERIC(16,8)
	,		@destino			NUMERIC(3)
	,		@nomin_en_pesos		NUMERIC(19,4)
	,		@cuotas_rmtes		NUMERIC(5)
	,		@nombre				CHAR(15)
	,		@nomInstr			CHAR(10)
	,		@digito				CHAR(1)
	,		@valormecado		NUMERIC(19,4)
	,		@valormecadopeso	NUMERIC(19,4)
	,		@tasamercado		NUMERIC(16,8)
	,		@codemi				CHAR(1)
	,		@COD_SUBPRODU		VARCHAR(3)
	,		@NUM_SECUENCIA_CTO	numeric(5)
	,		@Glosamoneda		varchar(10)
	,		@COD_REAJUSTE		varchar(10)
	,		@COD_GESTOR_PROD	varchar(20)
	,		@COD_BASE_TAS_INT	VARCHAR(3)
	,		@COD_BCA_INT		VARCHAR(3)
	,		@COD_CUR_REF		VARCHAR(20)
	,		@COD_TIP_TAS		VARCHAR(2)
	,		@FRE_PAGO_INT		NUMERIC(5)
	,		@PLZ_CONTRACTUAL	NUMERIC(5)
	,		@IMP_CUO_INI_MO		NUMERIC(20,2)
	,		@total_cuotas		NUMERIC(20,2)
	,		@TAS_INT_ORIGEN		NUMERIC(8,5)
	,		@COD_PORTAFOLIO		VARCHAR(20)
	,		@DES_PORTAFOLIO		VARCHAR(70)
	,		@COD_NEMOTECNICO	VARCHAR(20)
	,		@COD_CARTERA_FINANCI VARCHAR(20)
	,		@COD_TIP_LIBRO		VARCHAR(1)	

	DECLARE	@PrimerDiaMes		CHAR(12)  
	,		@UltimoDiaMes		CHAR(12)  
	,		@vTipo_Cambio		NUMERIC(19,4)  

	SELECT  @fecpro				= acfecproc
	,		@cliente			= acrutprop
	,		@acfecprox			= acfecprox
	,		@valdolarant		= dolarObsFinMes
	FROM	BacBonosExtSuda..TEXT_ARC_CTL_DRI	with(nolock)

	SET		@vDolar_obs			= isnull( (SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = 994 AND Fecha = @fecpro),0)
	SET		@estado				= (SELECT TOP 1 emrut FROM BacBonosExtSuda..VIEW_EMISOR WITH(NOLOCK) WHERE emgeneric = 'EST')
 
	DECLARE @Fecha_Contable		DATETIME
		
	SET	@Fecha_Contable		= @fecpro
  
	IF MONTH(@fecpro) <> MONTH(@acfecprox)
		BEGIN
			SET	@PrimerDiaMes		= SUBSTRING((CONVERT(CHAR(8), @acfecprox, 112)),1,6)  + '01'  
			SET	@UltimoDiaMes		= CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY, -1, @PrimerDiaMes)), 112)  
			SET	@fecpro				= CONVERT(DATETIME, @UltimoDiaMes, 112)
		END
  
	CREATE TABLE #CARTERA
	(	
		mascara					CHAR(20)							--   1      
	,	numdocu					CHAR(12)							--   2  
	,	numoper					CHAR(12)							--   3  
	,	instrumento				CHAR(20)							--   4  
	,	codigo					VARCHAR(3)							--   5
	,	cod_subproducto			VARCHAR(5)								--   6
	,	num_secuencia_cto		NUMERIC(5)							--	 7
	,	Glosamoneda				varchar(10)							--   8 
	,	COD_REAJUSTE			varchar(10)							-- 9
	,	IDF_PERS_ODS			varchar(25)							-- 10
	,	COD_CENTRO_CONT			varchar(4)							-- 11
	,	COD_OFI_COMERCIAL		varchar(5)
	,	COD_GESTOR_PROD			varchar(20)
	,	COD_BASE_TAS_INT		VARCHAR(3)
	,	COD_BCA_INT				VARCHAR(3)
	,   COD_CUR_REF				VARCHAR(20)
	,	FRE_PAGO_INT			NUMERIC(5)
	,	PLZ_CONTRACTUAL			NUMERIC(5)
	,	IMP_CUO_INI_MO			NUMERIC(20,2)
	,	total_cuotas			NUMERIC(20)							-- 20
	,	TAS_INT_ORIGEN			NUMERIC(8,5)
	,	COD_PORTAFOLIO			VARCHAR(20)
	,	DES_PORTAFOLIO			VARCHAR(70)
	,	COD_NEMOTECNICO			VARCHAR(20)
	,	COD_CARTERA_FINANCI		VARCHAR(20)
	,	COD_TIP_LIBRO			VARCHAR(1)	
	,	nominal					NUMERIC(19,4)						--     
	,	tir						NUMERIC(19,4)						--     
	,	taspact					NUMERIC(19,4)	NULL	DEFAULT(0)	--     
	,	fecvenpact				DATETIME		NULL				--   30 
	,	moneda					NUMERIC(5)							--     
	,	tipoper					CHAR(3)								--     
	,	valinip					NUMERIC(19,4)	NULL	DEFAULT(0)	--     
	,	rutcli					varchar(25)							--     
	,	codcli					CHAR(2)								--     
	,	rutemi					NUMERIC(9)							--     
	,	tabla					CHAR(4)								--     
	,	periodo					INT									--     
	,	fecvenp					DATETIME		NULL				--    
	,	valpres					NUMERIC(19,4)	NULL	DEFAULT(0)	--  40   
	,	valvenp					NUMERIC(19,4)	NULL	DEFAULT(0)	--     
	,	cuenta					CHAR(20)		NULL	DEFAULT('')	--     
	,	fecha_compra			DATETIME							--     
	,	fec_ven					DATETIME							--     
	,	amortizacion			NUMERIC(19,4)						--     
	,	saldo					NUMERIC(19,4)						--     
	,	invers					NUMERIC(5)							--     
	,	cttas					CHAR(3)								--     
	,	dias_dife				NUMERIC(6)							--     
	,	tran_perm				CHAR(10)							--  50    
	,	tirc					NUMERIC(19,4)						--      
	,	campo_26				DATETIME							--       
	,	interes					NUMERIC(19,4)						--     
	,	reajustes				NUMERIC(19,4)						--     
	,	fecha_emi				DATETIME							--     
	,	valcomp					NUMERIC(19,4)	NULL	DEFAULT(0)	--     
	,	interes_or				NUMERIC(19,4)						--     
	,	base					NUMERIC(3)							--     
	,	tasa_int				NUMERIC(16,8)						--     
	,	destino					NUMERIC(3)							--  60   
	,	valormecado				NUMERIC(19,4)						--     
	,	tasamercado				NUMERIC(16,8)	NOT	NULL DEFAULT(0)	--     
	,	correla					NUMERIC(9)		identity(1,1)		--  63   
   )  	

	---------------------------------------------------------------------------------------------  
	CREATE TABLE #NEOSOFT  
	(	 
		FEC_DATA				DATETIME											-- 1
	,	COD_ENTIDAD				VARCHAR(4) 											-- 2
	,	COD_PRODUCTO			VARCHAR(4)											-- 3	--- tipo producto Bonex --> select * from 	BacBonosExtSuda..TEXT_FML_INM	
	,   COD_SUBPRODU			VARCHAR(4)											-- 4
	,	NUM_CUENTA				VARCHAR(12)											-- 5
    ,	NUM_SECUENCIA_CTO		NUMERIC(5)											-- 6
	,	COD_DIVISA				varchar(10)											-- 7		
	,	COD_REAJUSTE			varchar(10)											-- 8
	,	IDF_PERS_ODS			varchar(25)											-- 9
	,	COD_CENTRO_CONT			varchar(4)											-- 10
	,	COD_OFI_COMERCIAL		varchar(5)											-- 11	
	,	COD_GESTOR_PROD			varchar(20)											-- 12		-- en definicion es varchar(8)
	,	COD_BASE_TAS_INT		VARCHAR(3)											-- 13
	,	COD_BCA_INT				VARCHAR(3)					-- 14					-- 14
	,	COD_COMPOS_INT			CHAR(1)												-- 15
	,	COD_MOD_PAGO			CHAR(1)												-- 16
	,	COD_MET_AMRT			VARCHAR(4)											-- 17
	,	COD_CUR_REF				VARCHAR(20)											-- 18
	,	COD_TIP_TAS				CHAR(1)			-- tasa_f_v							-- 19
	,	TAS_INT					NUMERIC(16,8)	-- tasa_interes						-- 20
	,	TAS_DIF_INC_REF			NUMERIC(16,8)	-- spread							-- 21 
	,	FEC_ALTA_CTO			DATETIME --NUMERIC(8)		-- F_operacion						-- 22
	,	FEC_INI_GEST			DATE --NUMERIC(8)		-- F_devengamiento					-- 23	
	,	FEC_CAN_ANT				DATE --NUMERIC(8)		-- fecha_vcto						-- 24
	,	FEC_ULT_LIQ				DATE --NUMERIC(8)											-- 25
	,	FEC_PRX_LIQ				DATE --NUMERIC(8)											-- 26
	,	FEC_ULT_REV				DATE --NUMERIC(8)		--	fecha_inic						-- 27
	,	FEC_PRX_REV				DATE --NUMERIC(8)											-- 28	
	,	FEC_VEN					DATE --NUMERIC(8)											-- 29
	,	FRE_PAGO_INT			NUMERIC(5)											-- 30
	,	COD_UNI_FRE_PAGO_INT	CHAR(1)												-- 31
	,	FRE_REV_INT				NUMERIC(5)
	,	COD_UNI_FRE_REV_INT		CHAR(1)
	,	PLZ_CONTRACTUAL			NUMERIC(5)
	,	PLZ_AMRT				NUMERIC(5)
	,	COD_UNI_PLZ_AMRT		CHAR(1)												-- 36
	,	IMP_INI_MO				NUMERIC(20,4)		-- mto_cap_origen				-- 37			
	,	IMP_CUO_MO				NUMERIC(20,2)										-- 38
	,	IMP_CUO_INI_MO			NUMERIC(20,2)										-- 39
	,	NUM_CUO_PAC				NUMERIC(5)			--	n_cuotas					-- 40 
	,	NUM_CUO_PEND			NUMERIC(5)			-- total_cuotas					-- 41
	,	IMP_PAGO_ML				NUMERIC(20,4)		-- mto_cap_local				-- 42
	,	IMP_PAGO_MO				NUMERIC(20,4)
	,	IND_CAN_ANT				CHAR(1)
	,	IND_TAS_PREDEF			CHAR(1)				-- FALTA DEFINIR, VALIDAR
	,	TAS_PREDEF				NUMERIC(8,5)		-- FALTA, NO SE ENCONTRO
	,	IMP_INI_ML				NUMERIC(20,4)		--  mto_cap_local
	,	TAS_INT_ORIGEN			NUMERIC(8,5)
	,	COD_PORTAFOLIO			VARCHAR(20)
	,	DES_PORTAFOLIO			VARCHAR(70)											-- 50
	,	COD_NEMOTECNICO			VARCHAR(20)
	,	COD_CARTERA_FINANCI		VARCHAR(20)
	,	COD_TIP_LIBRO			VARCHAR(1)	
	,	cod_empresa				VARCHAR(3)  
	,	cod_sucursal			VARCHAR(3)  
	,	status_contrato			VARCHAR(3)  
	,	status_crediticio		VARCHAR(1)  
	,	fam_producto			CHAR(4)  
	,	T_producto				CHAR(4)      
	,	C_interno				VARCHAR(16)											-- 60  
	,	Clase_Producto			VARCHAR(1)  
	,	Tipologia_producto		VARCHAR(1)  
	,	rut						VARCHAR(25)  
	,	dig						VARCHAR(1)  
	,	costo					VARCHAR(10)  
	,	n_operacion				CHAR(20)  
	,	fecha_renovacion		VARCHAR(8)			
	,	indicador				VARCHAR(1)  
	,	cod_inter_mda			VARCHAR(3)  
	,	s_mto_cap_ori			CHAR(1)												-- 70			
	,	s_mto_cap_loc			CHAR(1)  			
	,	mto_linea_credito		NUMERIC(19,4)  
	,	s_reaj_mda_loc			CHAR(1)  --30   
	,	mto_reaj_loc			NUMERIC(19,4)  
	,	s_int_mda_orig			CHAR(1)  
	,	mto_int_mda_orig		NUMERIC(19,4)  
	,	s_int_mda_loc			CHAR(1)  
	,	mto_int_mda_loc			NUMERIC(19,4)			
	,	tasa_base				CHAR(4)			
	,	tasa_penalidad			NUMERIC(16,8)										-- 80  
	,	calc_interes			VARCHAR(1)  
	,	c_operacion				NUMERIC(16,8)  
	,	c_fondo_oper			VARCHAR(5)  
	,	c_penalidad				VARCHAR(4)  
	,	spread_pool				NUMERIC(16,8)  
	,	spread_tasa_penalidad	NUMERIC(16,8)  
	,	indicador_p_a			VARCHAR(1)  
	,	s_mto_vencido			VARCHAR(1)  
	,	d_vencidas				NUMERIC(18,2)  
	,	t_tasa					NUMERIC(3)											-- 90  
	,	p_transfronterizo		NUMERIC(2)
	,	t_oper_transfronterizo	NUMERIC(1)  
	,	s_comision				VARCHAR(1)  
	,	mto_comision			NUMERIC(18,2)  
	,	fec_otorgamiento		VARCHAR(8)  
	,	fec_cartera				VARCHAR(8)  
	,	fec_mora				VARCHAR(8)  
	,	fec_cartera_castigada	VARCHAR(8)  
	,	n_operacion_orig		VARCHAR(20)  
	,	n_cuotas_mora			NUMERIC(4)											-- 100
	,	n_cuotas_total			NUMERIC(4)  
	,	destino					NUMERIC(3)  
	,	f_suspension			VARCHAR(8)  
	,	f_u_pago				VARCHAR(8)  
	,	indicador_renovacion	VARCHAR(1)  
	,	f_renovacion			VARCHAR(8)  
	,	f_cambio				VARCHAR(8)  
	,	f_ultimo_cambio			VARCHAR(8)  
	,	nomin_en_pesos			NUMERIC(18,2) 
	,	s_mda_local				NUMERIC(18,2)										-- 110  
	,	m_mora1					NUMERIC(18,2)  
	,	m_mora2					NUMERIC(18,2)  
	,	m_mora3					NUMERIC(18,2)  
	,	colocacion				NUMERIC(18,2)  
	,	l_credito				NUMERIC(18,2)  
	,	p_minimo				NUMERIC(18,2)  
	,	i_cobranza				VARCHAR(1)  
	,	v_mercado				NUMERIC(18,2)  
	,	v_pesos					NUMERIC(18,2)   
	,	t_cartera				CHAR(10)											-- 120
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
	SELECT DISTINCT	
			TEXT_RSU.cod_nemo
		,	rsnumdocu
		,	rsnumdocu
		,	TEXT_RSU.id_instrum
		,	CASE WHEN motipoper = 'CP' THEN 'CPX' ELSE 'VPX' END
		,	TEXT_RSU.cod_familia
		,	rscorrelativo
		,	CASE	WHEN rsmonemi  IN (998,997) THEN 
						ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 999),' ') 
					WHEN rsmonemi  IN (994) THEN 
						ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 13),' ') 
					ELSE 
						ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = rsmonemi),' ')
			END
		,	CASE	WHEN rsmonemi IN (998,997) THEN 
						'UF'  --> COD_REAJUSTE
					ELSE 
						NULL  
			END  --> COD_REAJUSTE
		,	RTRIM(LTRIM(CONVERT(char(9),rsrutcli)))  + '-' + (SELECT  Cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = rsrutcli AND Clcodigo = rscodcli)
		,	2230 -- definición provisoria segun Camilo -- NULL --''		-- 	COD_CENTRO_CONT			
		,	'001'
		,	ISNULL((SELECT TOP 1 mousuario FROM BacBonosExtSuda..TEXT_MVT_DRI, BacBonosExtSuda..TEXT_RSU WHERE monumoper = rsnumoper ),'') -- COD_GESTOR_PROD
		,  ''
		,	CASE	WHEN TEXT_MVT_DRI.base_tasa = '30 - 360' THEN '1'  --		@COD_BCA_INT		FALTA DEFINICION
					WHEN TEXT_MVT_DRI.base_tasa = '360' THEN '2'
					WHEN TEXT_MVT_DRI.base_tasa = '30 - 335' THEN '4'
					ELSE  '6' 
			END
		,	CASE	WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'LIBOR' OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 90'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 30'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'LIBOR 180'	THEN '3'   
					WHEN(SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'TIP'																							THEN '2'
					WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'TAB'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'TAB 90'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'TAB 30'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_RSU.tipo_tasa AND TBCATEG = 1042) = 'TAB 180'	THEN '1'
					ELSE '9'
			END
		,	TEXT_MVT_DRI.forma_pago  --0 -- FRE_PAGO_INT	
		,	CASE	WHEN datedIFf(day,rsfeccomp,rsfecvcto) > 9999 THEN '0000' 
					ELSE RIGHT('0000'+cast(datedIFf(day,rsfeccomp,rsfecvcto) AS VARCHAR(4)),4) 
			END 
		,	rsvalvenc  -- IMP_CUO_INI_MO	
		,	isnull((SELECT max (num_cupon) FROM BacBonosExtSuda..text_dsa where text_dsa.cod_nemo = TEXT_MVT_DRI.cod_nemo),1)
		,	motasemi
		,	TEXT_MVT_DRI.tipo_cartera_financiera
		,	(SELECT tbglosa FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_cartera_financiera AND TBCATEG = 204)
		,	TEXT_MVT_DRI.cod_nemo						--	@COD_NEMOTECNICO	
		,	CASE	WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 1 THEN 'TR'  -- Trading
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 2 THEN 'PLP' -- Portfolio LP
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 3 THEN 'ET' -- Estructuración
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 4 THEN 'BL' -- BALANCE
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 9 THEN 'PR' -- PROPIETARIO
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 10 THEN 'PLO' -- PORTFOLIO LO 180
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 13 THEN 'MT' -- MM TASA   -- REVISAR
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 14 THEN 'MF' -- MM FX -- REVISAR
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 16 THEN 'BGF' -- Balance Gestion Financiera -- REVISAR
					ELSE
					'BGL' -- Balance Gestion Liquidez -- REVISAR
			END   
		,	CASE WHEN Id_Libro = 1 THEN 'N' ELSE 'B' END
		,	rsnominal * (rsvpcomp / 100.0)
		,	rstir
		,	0
		,	''
		,	rsmonemi
		,	'CP'
		,	0
		,	rsrutcli 
		,	ISNULL((SELECT  Cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = rsrutcli AND Clcodigo = rscodcli),0)
		,	rsrutemis
		,	'MDCP'
		,	CASE	WHEN TEXT_RSU.cod_familia =	2001 THEN
						DATEDIFF(DAY, TEXT_RSU.rsfeccomp,TEXT_RSU.rsfecvcto)   
					ELSE 
						ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_RSU.cod_nemo),0)
			END
		,	rsfecvcto
		,	rsvalcomu
		,	PrincipalDiaPeso
		,	CtaContable
		,	rsfeccomp
		,	''
		,	0
		,	0
		,	0
		,	''
		,	DATEDIFF (DAY ,@fecpro,rsfecvcto)
		,	ISNULL((SELECT ccn_codigo_nuevo FROM BACPARAMSUDA..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = TEXT_RSU.codigo_carterasuper),4)
		,	0
		,	rsfecpcup
		,	rsinteres_acum
		,	0
		,	rsfecemis
		,	rsvppresen
		,	InteresPesoAcum
		,	rsbasemi
		,	rstasemi
		,	CASE	WHEN	rsrutcli = 97029000 THEN	211
					WHEN	rsrutcli = 97030000	THEN	212
					ELSE								221
			END

		,	rsvalmerc
		,	rstirmerc
--+++fmo 20180802 operaciones duplicadas
	FROM	BacBonosExtSuda..TEXT_RSU
	inner join BacBonosExtSuda..CARTERA_CUENTA on NumDocu=rsnumdocu and Correla=rscorrelativo and NumOper=rsnumoper --and  NumOper not IN (4108, 4109, 4114, 4115, 4117, 4118, 4119, 4120, 4121, 4122, 4123, 4124, 4125)
	inner join BacBonosExtSuda..TEXT_MVT_DRI on monumoper=rsnumoper and monumdocu=rsnumdocu and mocorrelativo=rscorrelativo and mofecpro=(select MAX(p.mofecpro) from BacBonosExtSuda..TEXT_MVT_DRI p where p.monumoper=rsnumoper and p.monumdocu=rsnumdocu and p.mocorrelativo=rscorrelativo)
	WHERE	rsfecpro		= @FECHA_PROC_FILTRO
	  AND   rsnominal		> 0
	  AND	rsrutcart		> 0
	  AND	rsfecpago		< @fecpro
	  AND	rsnominal		> 0.0  
-----fmo 20180802 operaciones duplicadas

--SELECT 'OJO1',* FROM #CARTERA where numoper=4121

	INSERT  INTO #CARTERA
	SELECT	DISTINCT   
			TEXT_CTR_INV.cod_nemo  
		,	monumdocu  
		,	monumdocu  
		,	TEXT_CTR_INV.id_instrum  
		,	case when motipoper = 'CP' THEN 'CPX' ELSE 'VPX' END
		,	TEXT_CTR_INV.cod_familia 
		,	mocorrelativo
		,	CASE WHEN momonemi  IN (998,997) THEN 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 999),' ') 
				 WHEN momonemi  IN (994) THEN 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 13),' ') 
				 ELSE 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = momonemi),' ')
			END
		,	CASE WHEN momonemi IN (998,997) THEN 'UF'			--> COD_REAJUSTE
						ELSE NULL  END  ---> COD_REAJUSTE
		,	rtrim(ltrim(convert(char(9),morutcli))) + '-' + ISNULL((SELECT cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),0)
		,	2230
		,	'001'
		,	isnull((select usuario from BacBonosExtSuda..VIEW_USUARIO where usuario = TEXT_MVT_DRI.mousuario),'')
		,	''
		,	CASE	WHEN TEXT_MVT_DRI.base_tasa = '30 - 360' THEN '1'
					WHEN TEXT_MVT_DRI.base_tasa = '360' THEN '2'
					WHEN TEXT_MVT_DRI.base_tasa = '30 - 335' THEN '4'
					ELSE  '7'
			END
		,	CASE	WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'LIBOR' OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 90'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 30'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'LIBOR 180'	THEN '3'   
					WHEN(SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TIP'																							THEN '2'
					WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 90'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 30'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 180'	THEN '1'
					ELSE '9'
			END
		,	TEXT_MVT_DRI.forma_pago
		,	CASE	WHEN datedIFf(day,cpfeccomp,cpfecven) > 9999 THEN '0000' 
					ELSE RIGHT('0000'+cast(datedIFf(day,cpfeccomp,cpfecven) AS VARCHAR(4)),4) 
			END
		,	cpvalvenc			-- IMP_CUO_INI_MO
		,	isnull((SELECT max (num_cupon) FROM BacBonosExtSuda..text_dsa where text_dsa.cod_nemo = TEXT_MVT_DRI.cod_nemo),1)
		,	CPtasemi
		,	TEXT_MVT_DRI.tipo_cartera_financiera
		,	(SELECT tbglosa FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_cartera_financiera AND TBCATEG = 204)
		,	TEXT_MVT_DRI.cod_nemo
		,	CASE WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 1 THEN 'TR'  -- Trading
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 2 THEN 'PLP' -- Portfolio LP
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 3 THEN 'ET' -- Estructuración
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 4 THEN 'BL' -- BALANCE
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 9 THEN 'PR' -- PROPIETARIO
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 10 THEN 'PLO' -- PORTFOLIO LO 180
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 13 THEN 'MT' -- MM TASA   -- REVISAR
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 14 THEN 'MF' -- MM FX -- REVISAR
				WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 16 THEN 'BGF' -- Balance Gestion Financiera -- REVISAR
				ELSE
				'BGL'
			END   
		,	CASE WHEN TEXT_MVT_DRI.Id_Libro = 1 THEN 'N' ELSE 'B' END
		,	monominal * (movpar/100.0)  
		,	motir  
		,	0  
		,	''  
		,	momonemi  
		,	'CP'  
		,	0  
		,	morutcli 
		,	ISNULL((SELECT cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),0)  
		,	morutemi  
		,	'MDCP'  
		,	CASE	WHEN TEXT_CTR_INV.cod_familia	=	2001	THEN	
						DATEDIFF(DAY,mofecpago,mofecven)
					ELSE												ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)
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
		,	DATEDIFF(DAY,@fecpro,mofecven)  -- 37
		,	ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = TEXT_MVT_DRI.codigo_carterasuper),4)  
		,	0  
		,	mofecpcup  
		,	CASE	WHEN TEXT_CTR_INV.cod_familia <> 2001 THEN moint_compra  
					ELSE                         (SELECT rsinteres_acum FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV')  
			END  
		,	moreajuste  
		,	mofecemi  
		,	movpresen  
		,	interespeso  
		,	mobasemi  
		,	mointeres  
		,	CASE	WHEN morutcli = 97029000 THEN 211
					WHEN morutcli = 97030000 THEN 212
					ELSE                          221
			END  
		,	ISNULL((SELECT rsvalmerc FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)  
		,	ISNULL((SELECT rstirmerc FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)  
	FROM	BacBonosExtSuda..TEXT_MVT_DRI  
	,		BacBonosExtSuda..CARTERA_CUENTA  
	,		BacBonosExtSuda..TEXT_CTR_INV  
	WHERE	mofecpro		= @FECHA_PROC_FILTRO
	AND     monominal		> 0.0  
	AND		morutcart		> 0.0  
	AND		numdocu			= monumdocu  
	AND		Correla			= mocorrelativo  
	AND		NumOper			= monumoper  
	AND		variable		= 'valor_compra'  
	AND		motipoper		= 'CP'  
	AND		mofecpago		= @fecpro  
	AND		mofecpro		= @fecpro  
	AND		mostatreg		<> 'A'  
	AND		cpnumdocu		= monumoper  
	AND		cpcorrelativo	= mocorrelativo  
	AND		cpnominal		> 0.0  

--SELECT 'OJO2',* FROM #CARTERA where numoper=4121

	INSERT  INTO #CARTERA
	SELECT	cod_nemo
		,	monumdocu
		,	monumdocu
		,	id_instrum
		,	CASE WHEN motipoper = 'CP' THEN 'CPX' ELSE 'VPX' END
		,	cod_familia 
		,	mocorrelativo
		,	CASE WHEN momonemi  IN (998,997) THEN 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 999),' ')
				 WHEN momonemi  IN (994) THEN 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = 13),' ')
				 ELSE 
					ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = momonemi),' ')
			END
		,	CASE WHEN momonemi IN (998,997) THEN 'UF'  --> COD_REAJUSTE
				ELSE NULL
			END
		,	RTRIM(LTRIM(CONVERT(CHAR(9),morutcli))) + '-' + ISNULL((SELECT  Cldv        FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = morutcli AND Clcodigo = mocodcli),0)
		,	2230 -- definición provisoria segun Camilo --NULL --''		-- 	COD_CENTRO_CONT	
		,	''		--	COD_OFI_COMERCIAL	
		,	isnull((select usuario from BacBonosExtSuda..VIEW_USUARIO where usuario = mousuario),'') -- COD_GESTOR_PROD
		,	''  --14
		,	CASE	WHEN TEXT_MVT_DRI.base_tasa = '30 - 360' THEN 1  --		@COD_BCA_INT		FALTA DEFINICION
					WHEN TEXT_MVT_DRI.base_tasa = '360' THEN 2
					WHEN TEXT_MVT_DRI.base_tasa = '30 - 335' THEN 4
					ELSE  7 
			END 
		,	CASE	WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'LIBOR' OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 90'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = ' LIBOR 30'	OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'LIBOR 180'	THEN '3'   
					WHEN(SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TIP'																							THEN '2'
					WHEN (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 90'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 30'		OR (SELECT TBGLOSA FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_tasa AND TBCATEG = 1042) = 'TAB 180'	THEN '1'
					ELSE '9'
			END
		,	TEXT_MVT_DRI.forma_pago   -- FRE_PAGO_INT	
		,	CASE WHEN datedIFf(day,mofecemi,mofecven)>9999 THEN '0000' ELSE RIGHT('0000'+cast(datedIFf(day,mofecemi,mofecven) AS VARCHAR(4)),4) END 	
		,	movalvenc	 -- IMP_CUO_INI_MO
		,	isnull((SELECT max (num_cupon) FROM BacBonosExtSuda..text_dsa where text_dsa.cod_nemo = TEXT_MVT_DRI.cod_nemo),1)
		,	motasemi
		,	TEXT_MVT_DRI.tipo_cartera_financiera
		,	(SELECT tbglosa FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = TEXT_MVT_DRI.tipo_cartera_financiera AND TBCATEG = 204)
		,	TEXT_MVT_DRI.cod_nemo		--	@COD_NEMOTECNICO
		,	CASE	WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 1 THEN 'TR'  -- Trading
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 2 THEN 'PLP' -- Portfolio LP
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 3 THEN 'ET' -- Estructuración
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 4 THEN 'BL' -- BALANCE
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 9 THEN 'PR' -- PROPIETARIO
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 10 THEN 'PLO' -- PORTFOLIO LO 180
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 13 THEN 'MT' -- MM TASA   -- REVISAR
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 14 THEN 'MF' -- MM FX -- REVISAR
					WHEN TEXT_MVT_DRI.tipo_cartera_financiera = 16 THEN 'BGF' -- Balance Gestion Financiera -- REVISAR
					ELSE
					'BGL' -- Balance Gestion Liquidez -- REVISAR
			END
		,	CASE WHEN TEXT_MVT_DRI.Id_Libro = 1 THEN 'N' ELSE 'B' END
		,	monominal
		,	motir
		,	0
		,	''
		,	momonemi
		,	'VP'
		,	0
		,	morutcli 
		,	ISNULL((SELECT  Cldv        FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = morutcli AND Clcodigo = mocodcli),0)
		,	morutemi
		,	'MDCP'
		,	CASE	WHEN cod_familia =	2001 THEN	
						DATEDIFF(DAY,mofecpago,mofecven)
					ELSE 
						ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)
				END
		,	mofecven
		,	movalcomu
		,	capitalpeso
		,	CtaContable  --30
		,	mofecpro
		,	''
		,	0
		,	0
		,	0
		,	''
		,	DATEDIFF (DAY ,@fecpro,mofecven)  -- 37
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
	FROM	BacBonosExtSuda..TEXT_MVT_DRI
		,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	mofecpro = @FECHA_PROC_FILTRO
	AND		monominal   > 0
	AND		morutcart	> 0
	AND		NumDocu		= monumdocu
	AND		Correla		= mocorrelativo
	AND		NumOper		= monumoper
	AND		variable	= 'valor_venta'
	AND		motipoper	= 'VP'
	AND		mofecpago	= @fecpro
	AND		mostatreg  <> 'A'


--SELECT 'OJO3',* FROM #CARTERA where numoper=4121

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
		,	valormecado,	tasamercado,	num_secuencia_cto,			Glosamoneda
		,	COD_REAJUSTE,	COD_GESTOR_PROD, 		COD_BASE_TAS_INT,	COD_BCA_INT	
		,	COD_CUR_REF,	FRE_PAGO_INT,	PLZ_CONTRACTUAL,		IMP_CUO_INI_MO        
		,	total_cuotas,	TAS_INT_ORIGEN   ,	COD_PORTAFOLIO,		DES_PORTAFOLIO     
		,	COD_NEMOTECNICO, COD_CARTERA_FINANCI, COD_TIP_LIBRO
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
		,	@valormecado,	@tasamercado,	@num_secuencia_cto,			@Glosamoneda
		,	@COD_REAJUSTE,	@COD_GESTOR_PROD, 	@COD_BASE_TAS_INT,		@COD_BCA_INT	
		,	@COD_CUR_REF,	@FRE_PAGO_INT,		@PLZ_CONTRACTUAL,		@IMP_CUO_INI_MO	
		,	@total_cuotas,	@TAS_INT_ORIGEN,	@COD_PORTAFOLIO,		@DES_PORTAFOLIO
		,	@COD_NEMOTECNICO, @COD_CARTERA_FINANCI, @COD_TIP_LIBRO



	WHILE @@FETCH_STATUS  = 0
	BEGIN
		SET		@nombre		= ISNULL((SELECT  nom_emi		FROM BacBonosExtSuda..text_emi_itl	WHERE  rut_emi		= @rutemi),'')  
		SET		@digito		= ISNULL((SELECT  digito_ver	FROM BacBonosExtSuda..text_emi_itl	WHERE  rut_emi		= @rutemi),'')  
		SET		@codemi		= ISNULL((SELECT  emtipo		FROM BacBonosExtSuda..view_emisor	WHERE  emrut		= @rutemi),'')  
		
		IF @moneda IN(994, 13)
		BEGIN  
			SET	@nomin_en_pesos		= ROUND(@nominal		*	@vDolar_obs, 0)  
			SET	@valormecadopeso	= ROUND(@valormecado	*	@vDolar_obs, 0)  
			SET	@valcomp			= CASE	WHEN @moneda = 13 THEN @valcomp
											ELSE                   ROUND(@valcomp * @valdolarant,0)
										END
		END ELSE
        BEGIN
			SET	@nomin_en_pesos  = ISNULL((@nominal     * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)
			SET	@valormecadopeso = ISNULL((@valormecado * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)
			SET	@vTipo_Cambio    = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)
		END

		SET @dias           = @dias_dife
		SET @inst_variable  = 'N'
		SET @tip_tasa       = '0'

		SELECT	@nIntasb	= tipo_tasa   
			,	@CTTAS		= CASE	WHEN	tasa_fija	=	'F'	THEN	'FLO'	ELSE	'FIJ'	END
		FROM	BacBonosExtSuda..TEXT_SER
		WHERE	cod_nemo	= @MASCARA
  
		IF @nIntasb > 1
		BEGIN    
		
			SELECT	@var_tasa		= (SELECT tbglosa FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = @nIntasb AND TBCATEG = 1042)
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
				SET @tip_tasa =  '101'      -- diaria
			IF @dias >= 30 AND @dias < 90     
				SET @tip_tasa =  '102'		-- mensual
			IF @dias >= 90 AND  @dias < 180   
				SET @tip_tasa =  '103'		-- semestral
			IF @dias >= 180  AND  @dias < 365    
				SET @tip_tasa =  '104'		-- trimestral
			IF @dias >= 365 AND  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS  -- Anual
				SET @tip_tasa =  '105'   
			IF @dias >= 1095					-- MAS DE TRES AÑOS   
				SET @tip_tasa =  '106'  
			IF @dias < 30   
				SET @COD_BASE_TAS_INT =  'D'      -- diaria
			IF @dias >= 30 AND @dias < 90     
				SET @COD_BASE_TAS_INT =  'M'		-- mensual
			IF @dias >= 90 AND  @dias < 180   
				SET @COD_BASE_TAS_INT =  'M'		-- semestral
			IF @dias >= 180  AND  @dias < 365    
				SET @COD_BASE_TAS_INT =  'M'		-- trimestral
			IF @dias >= 365 AND  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS  -- Anual
				SET @COD_BASE_TAS_INT =  'A'   
			IF @dias >= 1095					-- MAS DE TRES AÑOS   
				SET @COD_BASE_TAS_INT =  'A'  

		END

		IF @codigo = '2001'
			SELECT @tdcupon = ISNULL(CASE WHEN (SELECT COUNT(1) FROM BacBonosExtSuda..text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara )=0 THEN 1 END,1)
		ELSE
			SELECT @tdcupon = isnull((SELECT COUNT(1) FROM BacBonosExtSuda..text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara ),0)

        IF @tdcupon > 0
			BEGIN
				SELECT @cuotas_rmtes = 1
			END

		SELECT @nncup = convert(numeric(4),@tdcupon)

		INSERT INTO #NEOSOFT   
		VALUES  
/*01*/	(--	'CL'
			convert(date,@fecha_Contable)						-- 1
		,	'1769'
		,	@codigo
		,	@codigo
		,	cast(@nNumoper AS VARCHAR(5))  
		,	@num_secuencia_cto
		,	@Glosamoneda
		,	@COD_REAJUSTE
		,	CONVERT(VARCHAR(9),@rutemi) + '-' + CONVERT(VARCHAR(1),@digito)  -- 09
		,	2230 -- definición provisoria segun Camilo --NULL		-- COD_CENTRO_CONT						-- 10
		,	''		-- COD_OFI_COMERCIAL
		,	@cod_gestor_prod --ltrim(rtrim(ISNULL(SUBSTRING(@COD_GESTOR_PROD,1,8),'')))
		,	ISNULL(@COD_BASE_TAS_INT,'')
		,	ISNULL(@COD_BCA_INT,'')	
		,	'C'				-- COD_COMPOS_INT
		,	'V'				-- 	COD_MOD_PAGO	
		,	'1'				-- COD_MET_AMRT			-- 17
		,	@COD_CUR_REF						-- 18
		,	CASE WHEN @CTTAS = 'FLO' THEN 'V' ELSE  'F' END  	-- 19
		,	@tir					-- 20
		,   0									-- spread	-- 21
		,	CONVERT(DATE,@fec_comp)				--	FEC_ALTA_CTO	-- 22
		,	@fecpro								-- FEC_INI_GEST		-- 23							
		,	'19000101'							-- FEC_CAN_ANT		-- 24
		,	@fecvenp							-- FEC_ULT_LIQ		-- 25
		,	CONVERT(CHAR(8),@fecvenp,112)		-- FEC_ULT_LIQ		-- 26
		,	@fec_comp							-- FEC_ULT_REV		-- 27
		,	@fecvenp							-- FEC_PRX_REV		-- 28
		,	@fecvenp							-- FEC_VEN			-- 29
		,	@FRE_PAGO_INT						-- FRE_PAGO_INT		-- 30 REVISAR
		, CASE WHEN @dias < 31 THEN 'D'			-- -- COD_UNI_FRE_PAGO_INT	
			WHEN @dias >= 31 AND @dias < 365 THEN 'M' 
			WHEN @dias >= 365 THEN 'A' END
		,	CASE WHEN @dias < 31 THEN 1			-- -- COD_UNI_FRE_PAGO_INT	
			WHEN @dias >= 31 AND @dias < 365 THEN 2
			WHEN @dias >= 365 THEN 3 END
		,	ISNULL(@COD_BASE_TAS_INT,'')					-- 33
		,	@PLZ_CONTRACTUAL					-- 34
		,   CASE 
				WHEN @dias >= 31 AND @dias < 365 THEN DATEDIFF(MONTH,@fecpro,@fecvenp)
				WHEN @dias >= 365		 THEN DATEDIFF(YEAR,@fecpro,@fecvenp)
				WHEN @dias < 31		 THEN DATEDIFF(DAY,@fecpro,@fecvenp)
				ELSE DATEDIFF(DAY,@fecpro,@fecvenp)
			END				

		,	CASE
				WHEN @dias >= 31 AND @dias < 365 THEN 'M'
				WHEN @dias >= 365		 THEN 'A'
				WHEN @dias < 31		 THEN 'D'
				ELSE 'D'
			END
		
		,	ABS(@valpres)						-- IMP_INI_MO		-- 37
		,	0									-- IMP_CUO_MO		-- 38		-- FALTA
		,	@IMP_CUO_INI_MO						-- IMP_CUO_INI_MO	-- 39
		,	@total_cuotas						-- NUM_CUO_PAC		-- 40	---@tdcupon							
		,	(@total_cuotas - @tdcupon)								-- 41
		,	CASE	WHEN @moneda IN (994,13) THEN ABS(@valpres * @vDolar_obs)			-- IMP_PAGO_ML
					ELSE ABS(@valpres * @vTipo_Cambio) 
				END  --ABS(@valvenp) Contingencia Rastrear origen de datos incongruencia en estos.   
		,	CASE	WHEN @moneda IN (994,13) THEN ABS(@valpres )						-- IMP_PAGO_MO
					ELSE ABS(@valpres ) 
				END  --ABS(@valvenp) Contingencia Rastrear origen de datos incongruencia en estos.   
--+++MGM Cambio en indicador de Cancelacion a 5
		,	5	-- IND_CAN_ANT
-----MGM 30-07-2018
		,	CASE WHEN @TAS_INT_ORIGEN <> 0 THEN 'S' ELSE 'N' END  --'N'									-- IND_TAS_PREDEF			-- FALTA -- DEFINIR
		,	@TAS_INT_ORIGEN --0									-- TAS_PREDEF				-- FALTA DEFINIR, VALIDAR
		,	CASE	
				WHEN @moneda IN (994,13) THEN ABS(@valpres * @vDolar_obs)			-- IMP_PAGO_ML
			ELSE ABS(@valpres * @vTipo_Cambio) 
			END 
		,	@TAS_INT_ORIGEN
		,	@COD_PORTAFOLIO
		,	SUBSTRING(@DES_PORTAFOLIO,1,20)
		,	@COD_NEMOTECNICO
		,	@COD_CARTERA_FINANCI
		,	@COD_TIP_LIBRO
		,	@nncup --@cuotas_rmtes --'001'			-- 42
		,	'1'   -- 43
		,	'A'  
		,	SPACE(1)  
		,	'MD01'  
/*10*/	,	'MDIR'   
		,	'MD01'  
		,	SPACE(1)  
		,	'M'  
		,	CONVERT(VARCHAR(9),@rutemi)   -- 44
		,	CONVERT(VARCHAR(1),@digito)  
		,	SPACE(1)  
		,	CAST(@nNumdocu AS VARCHAR(5)) + CAST(1 AS VARCHAR(2)) + cast(@nNumoper AS VARCHAR(5))  
		,	SPACE(8)  
		,	'V'  
		,	@moneda  --50
		,	CASE WHEN @valpres < 0 THEN '-' ELSE  '+' END    -- 41
		,	CASE WHEN @valvenp < 0 THEN '-' ELSE  '+' END  
		,	0	
/*30*/	,	CASE WHEN @reajustes < 0 THEN '-' ELSE  '+' END   
		,	ABS(@reajustes)  
		,	CASE WHEN @nintel < 0 THEN '-' ELSE  '+' END  
		,	ABS(@nintel)  
		,	CASE WHEN @interes_or < 0 THEN '-' ELSE  '+' END			 -- 50
		,	ABS(@interes_or)				-- 51
		,	@base  
		,	0							-- 53
/*40*/	,	(CASE	WHEN @moneda = 998 THEN 1  
					WHEN @moneda = 13 THEN 3  
					WHEN @moneda = 999 THEN 4  
					ELSE 0 
				END)  
		,	0
		,	0
		,	0
		,	0
		,	@tasamercado
		,	CASE WHEN @tipoper = 'CP' THEN 'A' ELSE  'P' END
		,	'+'
		,	0
/*50*/	,	@tip_tasa
		,	0 --@mascara --dbo.Fx_Load_Transfronterizo(@mascara, 1)	-->		51	( Producto Transfronterizo )
		,	0 --@mascara --dbo.Fx_Load_Transfronterizo(@mascara, 2)	-->		52	( Tipo de Operacion Transfronterizo )
		,	'+'
		,	0
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(8)
		,	SPACE(8)
		,	' '
	--	,	@tdcupon -- 34
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
		,	@valormecadopeso --15
		,	@nomin_en_pesos
		,	@tran_perm
		,	0
		,	@periodo
		,	0
		,	'1'
		,	SPACE(1)
		,	SPACE(1)
		,	@valcomp
		,	CASE	WHEN @codigo = '2000' and (@codemi = 1 or @codemi = 2)	THEN 'BE   '
					WHEN @codigo = '2000' and (@codemi = 3 or @codemi = 4)	THEN 'BS   '
					WHEN @codigo = '2003'										THEN 'DPX  '
					ELSE													''
				END
		,	@nombre
		,	SPACE(4)
		,	SPACE(4)
		,	SPACE(3)
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
		,		@valormecado	, @tasamercado	, @num_secuencia_cto,	@Glosamoneda
		,		@COD_REAJUSTE	, @COD_GESTOR_PROD, @COD_BASE_TAS_INT, 	@COD_BCA_INT	
		,		@COD_CUR_REF	, @FRE_PAGO_INT,	@PLZ_CONTRACTUAL, @IMP_CUO_INI_MO
		,		@total_cuotas	, @TAS_INT_ORIGEN,	@COD_PORTAFOLIO, @DES_PORTAFOLIO
		,		@COD_NEMOTECNICO, @COD_CARTERA_FINANCI, @COD_TIP_LIBRO
	END  
	
	CLOSE CURSOR_INTER  
	DEALLOCATE  CURSOR_INTER  

	SELECT	DISTINCT
			 'NRO_DOCUMENTO'	= NUM_CUENTA
			,'NRO_OPERACION'	= NUM_CUENTA
			,'NRO_CORRELATIVO'	= NUM_SECUENCIA_CTO
			,FEC_DATA = convert(date,FEC_DATA)			
			,COD_ENTIDAD			
			,COD_PRODUCTO	= 'BEX'	
			,COD_SUBPRODU		
			,NUM_CUENTA			
			,NUM_SECUENCIA_CTO = REPLICATE('0', 4 - LEN(NUM_SECUENCIA_CTO)) + CONVERT(CHAR, NUM_SECUENCIA_CTO)
			,COD_DIVISA			
			,COD_REAJUSTE	   = (case when cod_divisa='UFR' then 'UF' when cod_divisa='UF' then 'UF' else null end)
			,IDF_PERS_ODS		
			,COD_CENTRO_CONT		
			,COD_OFI_COMERCIAL	
			,COD_GESTOR_PROD		
			,COD_BASE_TAS_INT	
			,COD_BCA_INT			
			,COD_COMPOS_INT		
			,COD_MOD_PAGO		
			,COD_MET_AMRT		
			,COD_CUR_REF = 0	
			,COD_TIP_TAS			
			,TAS_INT				
			,TAS_DIF_INC_REF	= TAS_INT	
			,FEC_ALTA_CTO = CONVERT(DATE,FEC_ALTA_CTO)	
			,FEC_INI_GEST		
			,FEC_CAN_ANT = CONVERT(DATE, '1900/01/01')
			,FEC_ULT_LIQ			
			,FEC_PRX_LIQ			
			,FEC_ULT_REV			
			,FEC_PRX_REV			
			,FEC_VEN				
			,FRE_PAGO_INT		
			,COD_UNI_FRE_PAGO_INT
			,FRE_REV_INT			
			,COD_UNI_FRE_REV_INT	
			,PLZ_CONTRACTUAL		
			,PLZ_AMRT			
			,COD_UNI_PLZ_AMRT	
			,IMP_INI_MO			
			,IMP_CUO_MO				= imp_cuo_ini_mo	
			,IMP_CUO_INI_MO		
			,NUM_CUO_PAC			
			,NUM_CUO_PEND		
			,IMP_PAGO_ML			
			,IMP_PAGO_MO			
			,IND_CAN_ANT						
			,IND_TAS_PREDEF		
			,TAS_PREDEF			
			,LTRIM(RTRIM(IMP_INI_ML))	AS IMP_INI_ML		
			,TAS_INT_ORIGEN				= 0.0
			,COD_PORTAFOLIO		
			,SUBSTRING(DES_PORTAFOLIO,1,20)	 AS DES_PORTAFOLIO	
			,COD_NEMOTECNICO		
			,COD_CARTERA_FINANCI	
			,COD_TIP_LIBRO
			,NUM_DOC		= NUM_CUENTA
			,NUM_OPE_ANT	= NULL
			,TFLUJO = 0
	FROM #NEOSOFT  

	SET NOCOUNT OFF  

END
GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_BONEX]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_BONEX]
(
		@FECHA	DATE=NULL
)
AS
BEGIN
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDOS OPERACIONES BONEX
--MODIFICACION	: 16-08-2018	
--MODIFICACION	: 04-12-2018	
--MODIFICACION	: 17-01-2019
--MODIFICACION	: 26-04-2019

SET NOCOUNT ON 


   DECLARE	
		@tip_oper       CHAR(4)
 	,	@mascara        CHAR (25)         
 	,	@numdocu        NUMERIC (10,0)    
 	,	@numoper        NUMERIC (10,0)    
 	,	@corre          NUMERIC (03,0)    
 	,	@codigo         NUMERIC (5)       
 	,	@tir            NUMERIC (19,4)    
 	,	@moneda         NUMERIC (5)       
 	,	@seriado        CHAR (1)          
 	,	@cuenta         CHAR(20) 
 	,	@fecha_compra   DATETIME                  
 	,	@dias_dife      NUMERIC(6)                
 	,	@campo_26       DATETIME                  
 	,	@interes        NUMERIC(19,4)
 	,	@vDolar_obs     NUMERIC(19,4)     
 	,	@dias           NUMERIC(1)
 	,	@nIntasb        NUMERIC(5)
 	,	@tip_tasa       CHAR(3)
 	,	@inst_variable  CHAR(1)
 	,	@Ccuenta        CHAR(20)
 	,	@dfecfmes       DATETIME
 	,	@dFecFMesProx   DATETIME
 	,	@acfecprox      DATETIME
 	,	@fecpro         DATETIME 
 	,	@NumCuenta      CHAR(1)
 	,	@monto_origen   NUMERIC(19,4)
 	,	@indicador      CHAR(1)
 	,	@NumValor       CHAR(1)
 	,	@NumReajuste    CHAR(1)
 	,	@NumInteres     CHAR(1)
 	,	@Max            INTEGER
 	,	@Monto          NUMERIC(18,2)
 	,	@cMoneda        NUMERIC(5)
 	,	@monto_oper     NUMERIC(18,2)
 	,	@TipoLinea      CHAR(1)
	,	@Mto_orig		NUMERIC(18,2)
	,	@vDolar_obs_dia NUMERIC(19,4)
	,	@Mto_local      NUMERIC(18,2)
 	,	@feccontable    DATETIME 
 	,	@Tipo_prod		varchar(3) 

   DECLARE      
		@PrimerDiaMes	CHAR(12)
	,	@UltimoDiaMes	CHAR(12)


	SET @fecpro=@FECHA
	SET @feccontable=@FECHA

    IF @fecpro IS NULL 
    BEGIN
		SELECT	
			@fecpro      	= acfecproc 
		,	@acfecprox   	= acfecprox 
		,	@feccontable    = acfecproc 
		FROM	BacBonosExtSuda..TEXT_ARC_CTL_DRI
    END


	IF  MONTH(@fecpro )<> month( @acfecprox ) 
	BEGIN
		SELECT @PrimerDiaMes   = SUBSTRING((convert(char(8), @acfecprox,112)),1,6) + '01'
		SELECT @UltimoDiaMes   = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
		SELECT @fecpro         = CONVERT(DATETIME,@UltimoDiaMes,112)
		SELECT @vDolar_obs_dia = vmvalor from BacBonosExtSuda..view_valor_moneda where vmfecha = @fecpro and vmcodigo = 994         
	END 
	ELSE 
		SELECT @vDolar_obs_dia = isnull (dolarObsFinMes ,0) from  BacBonosExtSuda..TEXT_ARC_CTL_DRI -- Nuevo 

    --> Fuerza la conversion de la Dif. Mercado con el valor del Dolar del Día de tabla BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
	SELECT @vDolar_obs_dia    = Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha = @feccontable AND Codigo_Moneda = 994


	CREATE TABLE #CARTERA
	(	tip_oper     CHAR(4)                                   --  0
	,	mascara      CHAR (25)                                 --  1    
	,	numdocu      NUMERIC (10,0)                            --  2
	,	numoper      NUMERIC (10,0)                            --  3
	,	corre        NUMERIC (03,0)                            --  4
	,	codigo       NUMERIC (5)                               --  5
	,	tir          NUMERIC (19,4)                            --  6
	,	moneda       CHAR (5) --NUMERIC (5)                               --  7
	,	cuenta       CHAR(20) 			               --  11
	,	fecha_compra DATETIME                                  --  12
	,	dias_dife    NUMERIC(6)                                --  13
	,	campo_26     DATETIME                                  --  14  
	,	interes      NUMERIC(19,4)
	,	cMoneda      NUMERIC(5)
	,	monto_oper   NUMERIC(18,2)
	,	TipoLinea    CHAR(1)
	,	Mto_orig     NUMERIC(18,2)
	,	tipo_prod    CHAR (3)                                  --  9
	)

	---------------------------------------------------------------------------------------------
	CREATE TABLE #TABLA_INTERFAZ2
	(	NRO_OPER      NUMERIC(9)
	,	NRO_DOC       NUMERIC(9)
	,	NRO_CORR      NUMERIC(4)
	,	COD_CTAC      CHAR(20)
	,	FEC_INTERFAZ  DATETIME
	,	FEC_CTBL      DATETIME
	,	MDA_CTBLE     CHAR(5) --NUMERIC(5) 
	,	IND_DECR      CHAR(1)
	,	COD_CTBL      CHAR(3)
	,	MDA_ORI       NUMERIC(19,4)
	,	MDA_LOC       NUMERIC(19,4)
	,	MDA_AGR       NUMERIC(19,4)
	,	COD_INT_SUC   CHAR(3)
	,	COD_INT_CEN   CHAR(10)
	,	TIPO_PROD     CHAR(3)
	,	MONEDA        NUMERIC(3)
	)      

	/****************** DEVENGO *********************/
	INSERT #CARTERA 
	SELECT 'MDIR'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	CtaContable	
	,	rsfeccomp      
	,	DATEDIFF(DAY,@fecpro,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum --+ rsinteres
	,	(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) 
	,	CASE WHEN rsmonemi = 13 THEN (rsvppresen  * @vDolar_obs_dia) 
                     ELSE rsvppresen * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END --ValorPresentePeso  corresponde al principal convertido a peso con tipo cambio ayer  
	,	TipoLinea
	,	rsvppresen 
	,	'CPX'	
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsfecpro	= @fecpro 
	AND	rsfecpago	< @fecpro 	
	AND	rstipoper	= 'DEV' 	
	AND	rsnominal	> 0 
	AND	rsrutcart	> 0    
	AND	Correla		= rscorrelativo -- 1
	AND	NumOper		= rsnumdocu
	AND	variable	= 'valor_compra'
	AND	t_operacion	= 'CP'

	/********************** COMPRAS **********************/
	INSERT	INTO #CARTERA 
	SELECT	'MDIR'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	CtaContable	
	,	rsfeccomp      
	,	datediff(day,@fecpro,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum 
	,	(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) 
	,	CASE WHEN rsmonemi = 13 THEN (rsvppresen  * @vDolar_obs_dia) 
                     ELSE rsvppresen * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END --ValorPresentePeso  corresponde al principal convertido a peso con tipo cambio ayer  
	,	TipoLinea
	,	rsvppresen  
	,	'CPX'	
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsnominal   > 0 AND rsrutcart > 0    
	AND	Correla   = rscorrelativo -- 1
	AND	NumOper   = rsnumdocu
	AND	rsfecpro  = @fecpro 
	AND	rsfecpago = @fecpro 	
	AND	variable  = 'valor_compra'
	AND	t_operacion = 'CP'
	AND	rstipoper = 'DEV' 	

	
	/************************* VENTAS ************************/
	INSERT	INTO #CARTERA 
	SELECT	'MDIR' 		--1
	,	cod_nemo 	--2
	,	monumdocu 	--3
	,	monumdocu 	--4
	,	mocorrelativo	--5
	,	cod_familia	--6
	,	motir	 	--7
	,	momonemi	--8
	,	CtaContable	--11
	,	mofecpro	--12
	,	DATEDIFF(DAY,@fecpro,mofecven)--13
	,	mofecven 	--14
	,	mointeres      --15
	,	(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) --16
	,	CAPITALPESO							    --17
	,	TipoLinea
	,	movpresen
	,	'VPX'	
	FROM	BacBonosExtSuda..TEXT_MVT_DRI
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	motipoper	= 'VP'
	AND	mostatreg	<> 'A'
	AND	mofecpago	= @fecpro 
	AND	morutcart	> 0    
	AND	monominal	> 0 
	AND	NumDocu		= monumdocu
	AND	Correla		= mocorrelativo
	AND	NumOper		= monumoper 
	AND	variable	= 'valor_venta'

	/***********   TASA MERCADO (Agrega Bloque)****************/
	INSERT	INTO #CARTERA 
	SELECT	'MDIR'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	CtaContable	
	,	rsfeccomp      
	,	datediff(day,@fecpro,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum 
        ,       CASE WHEN codigo_carterasuper ='P' 
                     THEN (SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE mncodmon=999) 
                     ELSE (SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) 
                END 
        ,	ROUND(CASE WHEN rsmonemi = 13 THEN (rsDiferenciaMerc * @vDolar_obs_dia) 
                     ELSE rsDiferenciaMerc * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END,0) 
	,	TipoLinea
	,	rsDiferenciaMerc -- 
	,	'CPX'	
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsfecpro	= @fecpro 
	AND	rstipoper	= 'DEV' 
	AND	rsnominal	> 0 
	AND	rsrutcart	> 0    
	AND	Correla		= rscorrelativo -- 1
	AND	NumOper		= rsnumdocu
	AND	t_operacion	= 'TMCP'
	AND	variable	= CASE	WHEN codigo_carterasuper = 'T'	THEN CASE WHEN rsDiferenciaMerc >= 0 THEN 'dif_valor_mercado_pos' 
																								 ELSE 'dif_valor_mercado_neg' END 
															ELSE CASE WHEN rsDiferenciaMerc >= 0 THEN 'utilidad' 
																								 ELSE 'perdida'  END  END

-------**********   TASA MERCADO ***************

	DECLARE CURSOR_INTER CURSOR FOR 
	SELECT	tip_oper	, mascara	, numdocu	, numoper 
	,	corre		, codigo	, tir		, moneda
	,	cuenta	, fecha_compra 
	,	dias_dife	, campo_26	, interes	, cmoneda
	,	monto_oper	, Mto_orig	, TipoLinea	, Tipo_prod
	FROM	#CARTERA

	OPEN CURSOR_INTER
	FETCH NEXT FROM CURSOR_INTER
	INTO	@tip_oper	, @mascara	, @numdocu	, @numoper 
	,		@corre		, @codigo	, @tir   	, @moneda	
	,		@cuenta		, @fecha_compra  
	,		@dias_dife	, @campo_26	, @interes	, @cMoneda  
	,		@monto_oper	, @Mto_orig	, @TipoLinea , @Tipo_prod

	WHILE @@FETCH_STATUS  = 0 
	BEGIN 

		IF @TipoLinea = 'D' 
			SELECT @indicador = 'D'
		ELSE
			SELECT @indicador = 'C'

		SELECT	
			@NumCuenta	= ''
		,	@Ccuenta	= '0'
		,	@Monto		= 0
		,	@NumValor	= ''    
		,	@NumReajuste	= ''
		,	@NumInteres	= ''  

		--> Dolar a la Fecha de Compra
		SELECT @vDolar_obs = ISNULL((SELECT vmvalor FROM BacBonosExtSuda..view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecha_compra),0)

		IF @cuenta NOT IN ('0' , '') 
		BEGIN
			SELECT @monto_origen = @Mto_orig
            SELECT @Mto_local    = @monto_oper

			INSERT INTO #TABLA_INTERFAZ2 
			(	NRO_OPER      --NUMERIC(9)
			,	NRO_DOC       --NUMERIC(9)
			,	NRO_CORR      --NUMERIC(4)
			,	COD_CTAC      --CHAR(20)
			,	FEC_INTERFAZ  --DATETIME
			,	FEC_CTBL      --CHAR(8)
			,	MDA_CTBLE     --NUMERIC(5)
			,	IND_DECR      --CHAR(1)
			,	COD_CTBL      --CHAR(3)
			,	MDA_ORI       --NUMERIC(19,4)
			,	MDA_LOC       --NUMERIC(19,4)
			,	MDA_AGR       --NUMERIC(19,4)
			,	COD_INT_SUC   --CHAR(3)	
			,	COD_INT_CEN   --CHAR(10)
			,	TIPO_PROD
			,	MONEDA
			)      
			SELECT  
				'NRO_OPER'     = @numoper
			,	'NRO_DOC'      = @numdocu
			,	'NRO_CORR'     = @corre
			,	'COD_CTAC'     = @cuenta
			,	'FEC_INTERFAZ' = CONVERT(CHAR(8),GETDATE(),112)
			,	'FEC_CTBL'     = @feccontable
			,	'MDA_CTBLE'    = @cMoneda 
			,	'IND_DECR'     = @indicador
			,	'COD_CTBL'     = '0'
			,	'MDA_ORI'      = (@Mto_orig)
			,	'MDA_LOC'      = (@Mto_local)
			,	'MDA_AGR'      = (@interes)
			,	'COD_INT_SUC'  = '1'
			,	'COD_INT_CEN'  = SPACE(10)
			,	'TIPO_PROD'	   = @Tipo_prod
			,	'MONEDA'	   = @Moneda 
		END    

		SELECT	@Ccuenta	= CtaContable  
		,		@Monto		= Monto  
		FROM	BacBonosExtSuda..CARTERA_CUENTA 
		WHERE	NumDocu		= @numdocu 
		AND	Correla		= @Corre  
		AND	NumOper		= @numoper 
		AND	Variable	= 'Reajuste_papel'

		SELECT @monto_origen    = @Mto_orig

		IF @Ccuenta NOT IN ( '0' , '') 
		BEGIN
			INSERT INTO #TABLA_INTERFAZ2 
			SELECT 
				@numoper
			,	@numdocu
			,	@corre
			,	@Ccuenta
			,	CONVERT(CHAR(8),GETDATE(),112) 
			,	convert(char(8),@feccontable,112)
			,	@cMoneda 
			,	@indicador
			,	'1'
			,	CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END 
			,	(@monto_origen)
			,	CASE WHEN @Mto_local    < 0 THEN '-' ELSE '+' END 
			,	(@Mto_local)
			,	CASE WHEN @interes      < 0 THEN '-' ELSE '+' END 
			,	ABS(@interes)
			,	'1'
			,	SPACE(10)
			,	@Tipo_prod
			,   @Moneda 
		END   
        	               
		FETCH NEXT FROM CURSOR_INTER
		INTO	@tip_oper	, @mascara	, @numdocu	, @numoper 
		,		@corre		, @codigo	, @tir		, @moneda	
		,		@cuenta		, @fecha_compra  
		,		@dias_dife	, @campo_26	, @interes	, @cMoneda
		,		@monto_oper	, @Mto_orig	, @TipoLinea , @Tipo_prod
      
	END
	
	CLOSE CURSOR_INTER
	DEALLOCATE  CURSOR_INTER

	UPDATE #TABLA_INTERFAZ2 
		SET MDA_CTBLE = CASE WHEN MDA_CTBLE ='0' THEN '00' ELSE MDA_CTBLE END      

	SELECT	NRO_OPER
	,		NRO_DOC
	,		NRO_CORR
	,		COD_CTAC
	,		COD_T_SALDO
	,		1 as COD_EST_SDO
	,		MNNEMO AS COD_DIVISA
	,		FEC_CTBL
	,		isnull(COD_CLS_SALDO,'') as COD_CLS_SALDO
	,		'1769' as COD_ENTIDAD
	,		'BEX' as COD_PRODUCTO
	,		TIPO_PROD as COD_SUBPRODU
	,		MDA_ORI as IMP_SDO_CONT_MO
	,		MDA_LOC as IMP_SDO_CONT_ML
	,		'2230' as COD_CENTRO_CONT       	
	,		1	as T_FLUJO				
	FROM #TABLA_INTERFAZ2
	INNER JOIN REPORTES.DBO.RNT_INT_MTX_CONTABLE t2 with (nolock) ON CONVERT(NUMERIC,t2.CUENTA) = COD_CTAC AND t2.INTERFAZ='SALDO'
	INNER JOIN BacBonosExtSuda..view_moneda ON mncodmon=MONEDA


END
GO

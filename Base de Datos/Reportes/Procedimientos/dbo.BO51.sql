USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[BO51]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--BO51 '20211001'
CREATE PROCEDURE [dbo].[BO51] (@dFechaProceso DateTime=Null)
AS
BEGIN


   SET NOCOUNT ON 

   DECLARE	@tip_oper       CHAR(4)
 	,	@mascara        CHAR (25)         
 	,	@numdocu        NUMERIC (10,0)    
 	,	@numoper        NUMERIC (10,0)    
 	,	@corre          NUMERIC (03,0)    
 	,	@codigo         NUMERIC (5)       
 	,	@tir            NUMERIC (19,4)    
 	,	@moneda         NUMERIC (5)       
 	,	@seriado        CHAR (1)          
 	,	@tipoper        CHAR (4)          
 	,	@tabla          CHAR (4)                  
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
 	--,	@dFechaProceso         DATETIME 
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
	,	@Mto_orig	NUMERIC(18,2)
	,	@vDolar_obs_dia NUMERIC(19,4)
	,	@Mto_local      NUMERIC(18,2)
 	,	@feccontable    DATETIME 
   DECLARE      @PrimerDiaMes	CHAR(12)
	,	@UltimoDiaMes	CHAR(12)
	
--declare @dFechaProceso DateTime
--set @dFechaProceso ='20211126'

if @dFechaProceso is null  
begin   
	select	@dFechaProceso  =  acfecproc 
		,	@acfecprox   	=  acfecprox 
		,	@feccontable    =  acfecproc
	FROM	BacBonosExtSuda..TEXT_ARC_CTL_DRI
end  
ELSE
BEGIN
	SELECT	
	 	@acfecprox   		=  acfecprox 
	,	@feccontable		=  @dFechaProceso
	FROM	
		BacBonosExtSuda..TEXT_ARC_CTL_DRI
END
	IF  MONTH(@dFechaProceso )<> month( @acfecprox ) 
        BEGIN
           SELECT @PrimerDiaMes   = SUBSTRING((convert(char(8), @acfecprox,112)),1,6) + '01'
	   SELECT @UltimoDiaMes   = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
	   SELECT @dFechaProceso         = CONVERT(DATETIME,@UltimoDiaMes,112)
	   SELECT @vDolar_obs_dia = vmvalor from BacBonosExtSuda..view_valor_moneda where vmfecha = @dFechaProceso and vmcodigo = 994         
	END ELSE 
	   SELECT @vDolar_obs_dia = isnull (dolarObsFinMes ,0) from  BacBonosExtSuda..TEXT_ARC_CTL_DRI -- Nuevo 

        --> Fuerza la conversion de la Dif. Mercado con el valor del Dolar del Día de tabla BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
        SELECT @vDolar_obs_dia    = Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE WHERE Fecha = @feccontable AND Codigo_Moneda = 994




	declare @CARTERA  TABLE 
	(	tip_oper     CHAR(4)                                   --  0
	,	mascara      CHAR (25)                                 --  1    
	,	numdocu      NUMERIC (10,0)                            --  2
	,	numoper      NUMERIC (10,0)                            --  3
	,	corre        NUMERIC (03,0)                            --  4
	,	codigo       NUMERIC (5)                               --  5
	,	tir          NUMERIC (19,4)                            --  6
	,	moneda       CHAR (5) --NUMERIC (5)                    --  7
	,	tipoper      CHAR (4)                                  --  9
	,	tabla        CHAR (4)                                  --  10
	,	cuenta       CHAR(20) 								   --  11
	,	fecha_compra DATETIME                                  --  12
	,	dias_dife    NUMERIC(6)                                --  13
	,	campo_26     DATETIME                                  --  14  
	,	interes      NUMERIC(19,4)
	,	cMoneda      NUMERIC(5)
	,	monto_oper   NUMERIC(18,2)
	,	TipoLinea    CHAR(1)
	,	Mto_orig     NUMERIC(18,2)
	)

	---------------------------------------------------------------------------------------------
	declare @TABLA_INTERFAZ2 TABLE 
	(	COD_PAIS      CHAR(3)
	,	FEC_INTERFAZ  char(8)
	,	NRO_IDEN      CHAR(4)
	,	COD_EMP       CHAR(3)
	,	FAM_PROD      CHAR(4)
	,	TIP_PROD      CHAR(4)
	,	COD_PRO       CHAR(4)
	,	CLS_PROD      CHAR(1)
	,	TIPO_PROD     CHAR(1)
	,	NRO_OPER	 CHAR(20)
	,	FEC_CTBL      CHAR(8)
	,	MDA_CTBLE     CHAR(5) --NUMERIC(5) 
	,	COD_CTAC      CHAR(20)
	,	IND_DECR      CHAR(1)
	,	COD_CTBL      CHAR(3)
	,	SIG_MDO       CHAR(1)
	,	MDA_ORI       NUMERIC(19,4)
	,	SIG_MDL       CHAR(1)
	,	MDA_LOC       NUMERIC(19,4)
	,	SIG_LAG       CHAR(1)
	,	MDA_AGR       NUMERIC(19,4)
	,	COD_INT_SUC   CHAR(3)
	,	COD_INT_CEN   CHAR(10)
	)      


	
Declare @BO51 table(
			 ctry				CHAR(3)				--		1
			,intf_dt			CHAR(8)				--		2
			,src_id				CHAR(14)			--		3
			,cem				CHAR(3)				--		4
			,prod				CHAR(16)			--		5
			,con_no				VARCHAR(20)			--		6
			,book_dt			CHAR(8)				--		7
			,ain				VARCHAR(20)			--		8
			,dr_cr_ind			VARCHAR(1)			--		9
			,actg_evnt_cod		VARCHAR(3)			--		10
			,ocy_bal_sign		VARCHAR(1)			--		11
			,ocy_bal			Numeric(19,4)		--		12
			,lcy_bal_sign		VARCHAR(1)			--		13
			,lcy_bal			Numeric(19,2)		--		14
			,lcy_agg_bal_sign	VARCHAR(1)			--		15
			,lcy_agg_bal		Numeric(19,2)		--		16
			,br					CHAR(04)			--		17
			,cc					VARCHAR(10)			--		18
)

Declare @BO51_SALIDA Table ( REG_SALIDA  Varchar(185))  

	/****************** DEVENGO *********************/
	INSERT @CARTERA 
	SELECT 'MD01'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	'MD01' 	
	,	'MDCP'    	
	,	CtaContable	
	,	rsfeccomp      
	,	DATEDIFF(DAY,@dFechaProceso,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum --+ rsinteres
	,	rsmonemi--(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) 
	,	CASE WHEN rsmonemi = 13 THEN (rsvppresen  * @vDolar_obs_dia) 
                     ELSE rsvppresen * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END --ValorPresentePeso  corresponde al principal convertido a peso con tipo cambio ayer  
	,	TipoLinea
	,	rsvppresen 
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsfecpro	= @dFechaProceso 
	AND	rsfecpago	< @dFechaProceso 	
	AND	rstipoper	= 'DEV' 	
	AND	rsnominal	> 0 
	AND	rsrutcart	> 0    
	AND	Correla		= rscorrelativo -- 1
	AND	NumOper		= rsnumdocu
	AND	variable	= 'valor_compra'
	AND	t_operacion	= 'CP'

	/********************** COMPRAS **********************/
	INSERT	INTO @CARTERA 
	SELECT	'MD01'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	'MD01' 	
	,	'MDCP'    	
	,	CtaContable	
	,	rsfeccomp      
	,	datediff(day,@dFechaProceso,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum 
	,	rsmonemi--(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) 
	,	CASE WHEN rsmonemi = 13 THEN (rsvppresen  * @vDolar_obs_dia) 
                     ELSE rsvppresen * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END --ValorPresentePeso  corresponde al principal convertido a peso con tipo cambio ayer  
	,	TipoLinea
	,	rsvppresen  
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsnominal   > 0 AND rsrutcart > 0    
	AND	Correla   = rscorrelativo -- 1
	AND	NumOper   = rsnumdocu
	AND	rsfecpro  = @dFechaProceso 
	AND	rsfecpago = @dFechaProceso 	
	AND	variable  = 'valor_compra'
	AND	t_operacion = 'CP'
	AND	rstipoper = 'DEV' 	

	
	/************************* VENTAS ************************/
	INSERT	INTO @CARTERA 
	SELECT	'MD01' 		--1
	,	cod_nemo 	--2
	,	monumdocu 	--3
	,	monumdocu 	--4
	,	mocorrelativo	--5
	,	cod_familia	--6
	,	motir	 	--7
	,	momonemi	--8
	,	'MD01'		--9
	,	'MDVP'    	--10
	,	CtaContable	--11
	,	mofecpro	--12
	,	DATEDIFF(DAY,@dFechaProceso,mofecven)--13
	,	mofecven 	--14
	,	mointeres      --15
	,	momonpag--(SELECT mncodfox FROM BacBonosExtSuda..view_moneda WHERE moneda = mncodmon) --16
	,	CAPITALPESO							    --17
	,	TipoLinea
	,	movpresen
	FROM	BacBonosExtSuda..TEXT_MVT_DRI
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	motipoper	= 'VP'
	AND	mostatreg	<> 'A'
	AND	mofecpago	= @dFechaProceso 
	AND	morutcart	> 0    
	AND	monominal	> 0 
	AND	NumDocu		= monumdocu
	AND	Correla		= mocorrelativo
	AND	NumOper		= monumoper 
	AND	variable	= 'valor_venta'

	/***********   TASA MERCADO (Agrega Bloque)****************/
	INSERT	INTO @CARTERA 
	SELECT	'MD01'
	,	cod_nemo 	
	,	rsnumdocu 	
	,	rsnumdocu 	
	,	rscorrelativo  
	,	cod_familia    
	,	rstir 		
	,	rsmonemi	
	,	'MD01' 	
	,	'MDCP'    	
	,	CtaContable	
	,	rsfeccomp      
	,	datediff(day,@dFechaProceso,rsfecvcto)
	,	rsfecvcto 
	,	rsinteres_acum 
    --,       CASE WHEN codigo_carterasuper ='P' 
    --                THEN (SELECT mncodfox FROM view_moneda WHERE mncodmon=999) 
    --                ELSE (SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon) 
    --        END 
	, rsmonemi
    ,	ROUND(CASE WHEN rsmonemi = 13 THEN (rsDiferenciaMerc * @vDolar_obs_dia) 
                     ELSE rsDiferenciaMerc * (SELECT Tipo_Cambio FROM BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                     WHERE Fecha = @feccontable AND Codigo_Moneda = rsmonemi)END,0) 
	,	TipoLinea
	,	rsDiferenciaMerc -- 
	FROM	BacBonosExtSuda..TEXT_RSU
	,	BacBonosExtSuda..CARTERA_CUENTA
	WHERE	rsfecpro	= @dFechaProceso 
	AND	rstipoper	= 'DEV' 
	AND	rsnominal	> 0 
	AND	rsrutcart	> 0    
	AND	Correla		= rscorrelativo -- 1
	AND	NumOper		= rsnumdocu
	AND	t_operacion	= 'TMCP'
	AND	variable	= CASE	WHEN codigo_carterasuper = 'T' THEN CASE WHEN rsDiferenciaMerc >= 0 THEN 'dif_valor_mercado_pos' 
					                               ELSE                            'dif_valor_mercado_neg'
                                                                            END 
                                        ELSE                                CASE WHEN rsDiferenciaMerc >= 0 THEN 'utilidad' 
					                                         ELSE                            'perdida'  
         END  
                                  END



-------**********   TASA MERCADO ***************

	DECLARE CURSOR_INTER CURSOR FOR 
	SELECT	tip_oper	, mascara	, numdocu	, numoper 
	,	corre		, codigo	, tir		, moneda
	,	tipoper		, tabla		, cuenta	, fecha_compra 
	,	dias_dife	, campo_26	, interes	, cmoneda
	,	monto_oper	, Mto_orig	, TipoLinea	
	FROM	@CARTERA

	OPEN CURSOR_INTER
	FETCH NEXT FROM CURSOR_INTER
	INTO	@tip_oper	, @mascara	, @numdocu	, @numoper 
	,	@corre		, @codigo	, @tir   	, @moneda	
	,	@tipoper	, @tabla	, @cuenta	, @fecha_compra  
	,	@dias_dife	, @campo_26	, @interes	, @cMoneda  
	,	@monto_oper	, @Mto_orig	, @TipoLinea

	WHILE @@FETCH_STATUS  = 0 
        BEGIN 

		IF @TipoLinea = 'D' 
			SELECT @indicador = 'D'
		ELSE
			SELECT @indicador = 'C'

		SELECT	@NumCuenta	= ''
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

			INSERT INTO @TABLA_INTERFAZ2 
			(	COD_PAIS      --CHAR(3)
			,	FEC_INTERFAZ  --DATETIME
			,	NRO_IDEN      --CHAR(4)
			,	COD_EMP       --CHAR(3)
			,	FAM_PROD      --CHAR(4)
			,	TIP_PROD      --CHAR(4)
			,	COD_PRO       --CHAR(4)
			,	CLS_PROD      --CHAR(1)
			,	TIPO_PROD     --CHAR(1)
			,	NRO_OPER      --CHAR(20)
			,	FEC_CTBL      --CHAR(8)
			,	MDA_CTBLE     --NUMERIC(5)
			,	COD_CTAC      --CHAR(20)
			,	IND_DECR      --CHAR(1)
			,	COD_CTBL      --CHAR(3)
			,	SIG_MDO       --CHAR(1)
			,	MDA_ORI       --NUMERIC(19,4)
			,	SIG_MDL       --CHAR(1)
			,	MDA_LOC       --NUMERIC(19,4)
			,	SIG_LAG       --CHAR(1)
			,	MDA_AGR       --NUMERIC(19,4)
			,	COD_INT_SUC   --CHAR(3)	
			,	COD_INT_CEN   --CHAR(10)
			)      
			SELECT  'COD_PAIS'     = 'CL'
			,	'FEC_INTERFAZ' = CONVERT(CHAR(8),@dFechaProceso,112)
			,	'NRO_IDEN'     = 'BO51'
			,	'COD_EMP'      = '001'
			,	'FAM_PROD'     = 'MD01'
			,	'TIP_PROD'     = @tip_oper
			,	'COD_PRO'      = @tipoper
			,	'CLS_PROD'     = SPACE(1)
			,	'TIPO_PROD'    = 'M'
			,	'NRO_OPER'     = CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) )
			,	'FEC_CTBL'     = CONVERT(CHAR(8),@feccontable ,112)
			,	'MDA_CTBLE'    = @cMoneda 
			,	'COD_CTAC'     = @cuenta
			,	'IND_DECR'     = @indicador
			,	'COD_CTBL'     = '0'
			,	'SIG_MDO'      = CASE WHEN @Mto_orig  < 0 THEN '-' ELSE '+' END
			,	'MDA_ORI'      = ABS(@Mto_orig)
			,	'SIG_MDL'      = CASE WHEN @Mto_local < 0 THEN '-' ELSE '+' END
			,	'MDA_LOC'      = ABS(@Mto_local)
			,	'SIG_LAG'      = CASE WHEN @interes   < 0 THEN '-' ELSE '+' END
			,	'MDA_AGR'      = ABS(@interes)
			,	'COD_INT_SUC'  = '1'
			,	'COD_INT_CEN'  = SPACE(10)
		END    

		SELECT	@Ccuenta	= CtaContable  
		,	@Monto		= Monto  
		FROM	BacBonosExtSuda..CARTERA_CUENTA 
		WHERE	NumDocu		= @numdocu 
		AND	Correla		= @Corre  
		AND	NumOper		= @numoper 
		AND	Variable	= 'Reajuste_papel'

		SELECT @monto_origen    = @Mto_orig

		IF @Ccuenta NOT IN ( '0' , '') 
                BEGIN
			INSERT INTO @TABLA_INTERFAZ2 
			   SELECT 'CL'
					,	CONVERT(CHAR(8),@dFechaProceso,112) 
					,	'BO51'
					,	'001'
					,	'MD01'   + SPACE(12)
					,	@tip_oper
					,	@tipoper
					,	SPACE(1)
					,	'M'
					,	CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5))
					,	convert(char(8),@feccontable,112)
					,	@Ccuenta
					,	@cMoneda 
					,	@indicador
					,	'1'
					,	CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END 
					,	ABS(@monto_origen)
					,	CASE WHEN @Mto_local    < 0 THEN '-' ELSE '+' END 
					,	ABS(@Mto_local)
					,	CASE WHEN @interes      < 0 THEN '-' ELSE '+' END 
					,	ABS(@interes)
					,	'1'
					,	SPACE(10)
		END   
        	               
		FETCH NEXT FROM CURSOR_INTER
		INTO	@tip_oper	, @mascara	, @numdocu	, @numoper 
		,	@corre		, @codigo	, @tir		, @moneda	
		,	@tipoper 	, @tabla	, @cuenta	, @fecha_compra  
		,	@dias_dife	, @campo_26	, @interes	, @cMoneda
		,	@monto_oper	, @Mto_orig	, @TipoLinea
      
	END
	
	CLOSE CURSOR_INTER
	DEALLOCATE  CURSOR_INTER

    UPDATE @TABLA_INTERFAZ2 
	SET MDA_CTBLE = CASE WHEN MDA_CTBLE ='0' 
                            THEN '00' ELSE MDA_CTBLE 
                        END      

		
	--SELECT @Max = COUNT(1) FROM @TABLA_INTERFAZ2
	--SELECT @Max,* FROM @TABLA_INTERFAZ2

	Insert Into @BO51  
	select COD_PAIS,FEC_INTERFAZ , NRO_IDEN  + SPACE(10), COD_EMP, FAM_PROD + SPACE(12), NRO_OPER,FEC_CTBL,COD_CTAC,IND_DECR,
	CASE WHEN MDA_CTBLE = 13 THEN 'USD' ELSE 'CLP' END ,SIG_MDO,MDA_ORI,SIG_MDL,MDA_LOC,SIG_LAG,MDA_AGR,'0011'	,REPLICATE('0',10)
	from @TABLA_INTERFAZ2

 Declare @TipoSalida bit = 0

if @TipoSalida != 0
	SELECT 
					ctry																																						--		1					
			    , intf_dt																																					--		2	
				, src_id																																					--		3	
				, cem																																						--		4	
				, prod																																						--		5	
				,  left(con_no+space(20), 20) as con_no																																					--		6	
				, book_dt																																					--		7
				, ain																																						--		8	
				, dr_cr_ind																																					--		9	
				, actg_evnt_cod--REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))	as actg_evnt_cod													--		10
				, ocy_bal_sign																																				--		11	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19) as ocy_bal
				, lcy_bal_sign																																				--		13
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19) as lcy_bal
				, lcy_agg_bal_sign																																			--		15
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19) as lcy_agg_bal
				, br																																						--		17
				, cc 
	
	FROM @BO51 Order by cem , ain , prod , con_no
else
	begin
		INSERT INTO @BO51_SALIDA
		select 
				  ctry																																						--		1					
			    + intf_dt																																					--		2	
				+ src_id																																					--		3	
				+ cem																																						--		4	
				+ prod																																						--		5	
				+  left(con_no+space(20), 20)																																					--		6	
				+ book_dt																																					--		7
				+ ain																																						--		8	
				+ dr_cr_ind																																					--		9	
				+ actg_evnt_cod--REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				+ ocy_bal_sign																																				--		11	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				+ lcy_bal_sign																																				--		13
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				+ lcy_agg_bal_sign																																			--		15
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				+ br																																						--		17
				+ cc																																						--		18
				from @BO51
			Order by cem , ain , prod , con_no
		


		select * from @BO51_SALIDA
	end 


	SET NOCOUNT OFF
 
END


GO

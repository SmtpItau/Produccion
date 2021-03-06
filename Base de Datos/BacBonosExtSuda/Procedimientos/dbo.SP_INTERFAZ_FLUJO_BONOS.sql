USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_BONOS]
AS
BEGIN

SET NOCOUNT ON
DECLARE  @VALORX       		numeric(19,4)    ,
         @xx15         		numeric(19,4)    ,
         @nmone        		numeric(3)       ,
         @campo_26     		datetime         ,
         @xproducto    		numeric(10)      ,
         @nncup        		numeric(5)       ,
         @nintel       		numeric(19,4)    ,
         @reajustes    		numeric(19,4)    ,
         @cuentaI      		char (20)        ,
         @cuentaR      		char (20)        ,
         @cod_instru   		numeric(3)       ,
         @valor_compra 		numeric(19,4)    ,
         @valor_compra_X 	numeric(19,4)    ,
         @vDolar_obs   		numeric(19,4)    ,
         @nvori        		numeric(19,4)    ,
         @barra        		numeric(19)      ,
         @tip_tasa      	CHAR(3)		 ,
         @inst_variable 	CHAR(1)		 ,
	 @XX 			CHAR(3)		 ,
	 @crut 			numeric(9)	 , 
	 @DIG 			CHAR(1)		 ,
	 @ccmor 		CHAR(3)		 ,
         @CCMON 		CHAR(2)		 ,
	 @var_tasa              CHAR(15)         ,
         @saldo                  numeric(19,4)    ,
         @saldopeso              numeric(19)    
         
DECLARE @c           		CHAR (1)         ,
        @c1          		CHAR (1)         ,
        @mascara     		CHAR (20)      	 ,
        @instrumento 		CHAR (12)   	 ,
        @codigo  		NUMERIC (5)      ,
        @nominal 		NUMERIC (19,4)   ,
        @tir  			NUMERIC (19,4)   ,
        @taspact 		NUMERIC (19,4)   ,
        @fecvenpact 		DATETIME         ,
        @moneda  		NUMERIC (5)      ,
        @tipoper 		CHAR (3)         ,
        @valinip 		NUMERIC (19,4)   ,
        @valvenp 		NUMERIC (19,4)   ,
        @valcomp 		NUMERIC (19,4)   ,
        @valcomp2 		NUMERIC (19,4)   ,
        @rutcli  		NUMERIC (9)      ,
        @codcli 		NUMERIC (5) 	 ,
        @rutemi  		NUMERIC (9) 	 ,
        @tabla  		CHAR (4) 	 ,
        @numero  		NUMERIC (9) 	 ,
        @cuenta  		CHAR (20) 	 ,
        @tipo_tasa 		NUMERIC (1) 	 ,
        @tdfecven 		DATETIME 	 ,
        @tdamort 		NUMERIC (19,4) 	 ,
        @tdsaldo 		NUMERIC (19,4) 	 ,
        @inversion 		NUMERIC (5)      ,
        @tipo_cuenta 		CHAR (2) 	 ,
        @fecha  		DATETIME 	 ,
        @fecpro  		DATETIME 	 ,
        @periodo  		INTEGER  	 ,
        @tdcupon 		char(3) 	 ,
        @fecvenp 		DATETIME	 ,
        @cliente 		NUMERIC (9) 	 ,
        @estado  		NUMERIC (9) 	 ,
        @emtipo  		CHAR (5) 	 ,
        @nmes   		CHAR (2) 	 ,
        @nmes_a  		CHAR (2) 	 ,
        @nano   		CHAR (4) 	 ,
        @cano   		CHAR (4) 	 ,
        @nNumdocu 		NUMERIC (10,0) 	 ,
        @nNumoper 		NUMERIC (10,0) 	 ,
        @fec_comp 		datetime 	 , 
        @CTTAS   		CHAR (3) 	 ,
        @dias_dIFe 		INTEGER, --NUMERIC(4)	 ,
        @tran_perm 		CHAR (10) 	 ,
        @tirc      		NUMERIC(19,4)	 ,
        @DIAS      		NUMERIC(19)	 ,
        @sum_capi 		NUMERIC(15)	 ,
        @nIntasb      		numeric(5)	 ,
        @nIncodigo    		numeric(5)	 ,
        @tasa         		numeric(19,4)	 ,
        @dfecfmes   		datetime         ,
        @dFecFMesProx  		datetime 	 ,
        @acfecprox 		datetime 	 ,
        @fecha_emi 		datetime 	 ,
        @fec_ven 		datetime 	 ,
        @valpres   		NUMERIC (19,4) 	 ,
	@valdolarant   		NUMERIC (19,4) 	 



 SELECT @fecpro  = acfecproc , 
        @cliente = acrutprop ,
        @acfecprox = acfecprox,
	@valdolarant = dolarObsFinMes
 FROM TEXT_ARC_CTL_DRI

 SELECT @vDolar_obs = isnull((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fecpro),0)
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'

-- SELECT * FROM TABLA_INTERFAZ 
-- BORRA LOS DATOS ANTERIORES
DELETE TABLA_INTERFAZ WHERE descr = 1 
 
 CREATE TABLE #CARTERA
    (
    	mascara      CHAR (20)    	,                             --  1    
	numdocu      CHAR (12)    	,         --4                2
    	numoper      CHAR (12)    	,         --4                3
    	instrumento  CHAR (20)    	,        --    5
    	codigo       NUMERIC (5)    	,                     --    6
    	nominal      NUMERIC (19,4)    	,                      --    7
    	tir          NUMERIC (19,4) 	,                      --    8
    	taspact      NUMERIC (19,4) NULL DEFAULT (0) ,        --    9
    	fecvenpact   DATETIME NULL   	,                        --   10
    	moneda       NUMERIC (5)    	,                         --   11
    	tipoper      CHAR (3)    	,                            --   13
    	valinip      NUMERIC (19,4) NULL DEFAULT (0) ,        --   14
    	rutcli       NUMERIC (9)    	,                         --   15
    	codcli       NUMERIC (5)    	,                         --   16
    	rutemi       NUMERIC (9)    	,                         --   17
    	tabla        CHAR (4)    	,                            --   18
    	periodo      INTEGER     	,                            --   19
    	fecvenp      DATETIME NULL   	,                        --   20
    	valvenp      NUMERIC (19,4) NULL DEFAULT (0) ,     --   21
    	valpres      NUMERIC (19,4) NULL DEFAULT (0) ,     --   22
    	cuenta       CHAR(20) NULL DEFAULT ('')      ,     --   23
    	fecha_compra datetime		,                  --   24
    	fec_ven      datetime		,                  --   25
    	amortizacion numeric(19,4)	,                  --   26
    	saldo        numeric(19,4)	,                  --   27
    	invers       NUMERIC (5) 	,                  --   28
    	cttas        char(3)		,                  --   29
    	dias_dIFe    integer,  --numeric(6)		,                  --   30
    	tran_perm    CHAR (10) 		,                  --   31 
    	tirc         numeric(19,4)	,                  --   32 
    	campo_26     datetime     	,                  --   33  
    	interes      numeric(19,4)	,                  --   34
    	reajustes    numeric(19,4)	,                  --   35
    	fecha_emi    datetime		,                  --   36
    	valcomp      NUMERIC (19,4) NULL DEFAULT (0) ,     --   37
    	correla      NUMERIC (9) IDENTITY (1,1)            --    38
	)

-- SP_HELP TEXT_CTR_INV
--SELECT * FROM TEXT_CTR_CPR
-- SELECT * FROM text_rsu
---------------------------------------------------------------------------------------------

 INSERT #CARTERA 
 SELECT cod_nemo 	,
        rsnumdocu 	,
        rsnumdocu 	,
        id_instrum 	,
        cod_familia	, --cpcodigo ,
        rsnominal 	,
        rstir 	,
        0  		,
        ''  		,
	rsmonemi	,
        'CP'  		,
        0  		,
        rsrutcli 	,
        rscodcli 	,
	rsrutemis	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_rsu.cod_nemo),0),
        rsfecvcto 	,    	--25
        CapitalPeso 	,
        (case when cod_familia = 2000 then PrincipalDiaPeso else CapitalPeso end) ,--valorpresentepeso 	, --monto en peso del valor presente	
        CtaContable	,    	-- cartera cuenta
        rsfeccomp	,    	--13
        ''		,
       0		,
       0		,
       0		,
       ''		,
       datedIFf(day,@fecpro,rsfecvcto),
       codigo_carterasuper,
       0		,
       rsfecpcup  	,    -- 26
       abs(InteresPesoAcum), --rsinteres 	,
       0, --rsreajust 	,
       rsfecemis 	,
       0 --rsvalcomp    ,
 
 FROM TEXT_rsu,CARTERA_CUENTA
 WHERE rsnominal   > 0 AND rsrutcart > 0    
       AND Correla   = rscorrelativo -- 1
       AND NumOper   = rsnumdocu
       and rsfecpro  = @fecpro 
       and rsfecpago  < @fecpro 	
       AND variable  = 'valor_compra'
       AND t_operacion = 'CP'
       AND rstipoper = 'DEV' 	


 INSERT #CARTERA 
 SELECT TEXT_MVT_DRI.cod_nemo 	,--cpmascara ,
        monumdocu 	,
        monumdocu 	,
        TEXT_MVT_DRI.id_instrum 	,
        TEXT_MVT_DRI.cod_familia	, --cpcodigo ,
        monominal 	,
        motir     	,
        0  		,
        ''  		,
	momonemi	,
        'CP'  		,
        0  		,
        morutcli 	,
        mocodcli 	,
	morutemi	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0),
        mofecven 	,    	--25
        capitalpeso,--monominal 	,
        capitalpeso    	,
        CtaContable	,  
        mofecpro, --mofeccomp	,    	--13
        ''		,
        0		,
        0		,
        0		,
        ''		,
        datedIFf(day,@fecpro,mofecven),
        TEXT_MVT_DRI.codigo_carterasuper,
	0		,
       mofecpcup  	,    -- 26
        interespeso 	,
        moreajuste 	,
        mofecemi 	,
        movalcomp
 FROM TEXT_MVT_DRI,CARTERA_CUENTA, TEXT_CTR_INV
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_compra'
       AND motipoper = 'CP'
       AND mofecpago = @fecpro	  	
       and mofecpro  = @fecpro	
       AND mostatreg <> 'A'   	
       and cpnumdocu =  monumoper
       and cpcorrelativo =  mocorrelativo
       and cpnominal >0


 INSERT #CARTERA 
 SELECT cod_nemo 	,--cpmascara ,
        monumdocu 	,
        monumdocu 	,
        id_instrum 	,
        cod_familia	, --cpcodigo ,
        monominal 	,
        motir     	,
        0  		,
        ''  		,
	momonemi	,
        'VP'  		,
        0  		,
        morutcli 	,
        mocodcli 	,
	morutemi	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0),
        mofecven 	,    	--25
        capitalpeso,--monominal 	,
        capitalpeso    	,
        CtaContable	,  
        mofecpro, --mofeccomp	,    	--13
        ''		,
        0		,
        0		,
        0		,
        ''		,
        datedIFf(day,@fecpro,mofecven),
        codigo_carterasuper,
        0		,
        mofecpcup  	,    -- 26
        interespeso 	,
        moreajuste 	,
        mofecemi 	,
        movalcomp
 FROM TEXT_MVT_DRI,CARTERA_CUENTA
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_venta'
       AND motipoper = 'VP'
       AND mofecpago  = @fecpro	  	
       AND mostatreg	<> 'A'   	
-- SELECT * FROM TEXT_MVT_DRI



DECLARE CURSOR_INTER CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal  	, tir          , taspact , fecvenpact 
         , moneda     , tipoper        , valinip , rutcli       , codcli       , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'       	, periodo      , fecvenp , valvenp , valpres -- valcomp          
         , numdocu    , numoper        ,  cuenta , fecha_compra , dias_dIFe 
         , tran_perm  , campo_26       , interes , reajustes	, fecha_emi    , fec_ven , valcomp
  FROM #CARTERA


OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal   , @tir       , @taspact   , @fecvenpact ,
      @moneda  , @tipoper    , @valinip  , @rutcli    , @codcli    , @rutemi    ,
      @tabla   , @numero     , @c        , @periodo   , @fecvenp   , @valvenp   , @valpres ,  -- @valcomp    ,
      @nNumdocu, @nNumoper   , @cuenta   , @fec_comp  , @dias_dIFe ,
      @tran_perm , @campo_26 , @nintel   , @reajustes , @fecha_emi , @fec_ven   ,@valcomp
WHILE @@FETCH_STATUS  = 0
BEGIN 

-- duda con respecto a lla cuenta contable
-- 2
--IF @tipoper ='CP'
     SET  @crut =   @rutemi      --decla
--   else  
--      SET @crut =   @rutcli

--SELECT @crut,@nNumoper
   SELECT @DIG = Cldv FROM VIEW_CLIENTE WHERE Clrut = @crut  

   DECLARE @aa char(10)
   SELECT  @aa =  isnull(cta_sbIF, '0') FROM view_plan_de_cuenta WHERE cuenta = @cuenta
   SELECT  @xproducto =  0--convert(numeric(10,0), @aa)

   IF ltrim(@aa) = 0 begin
	SELECT @aa  =  '0'
   end

   SELECT @emtipo =  emtipo FROM VIEW_EMISOR WHERE emrut = @rutemi

   SET @cod_instru= 460     --10

     
  IF  @emtipo = 1 BEGIN
	SET @inversion = 12001
   END	
   ELSE IF @emtipo = 3 BEGIN
	SET @inversion = 11199
   END	
   ELSE IF @emtipo = 4 BEGIN
	SET @inversion = 30001
   END	
   ELSE BEGIN
	SET @inversion = 30002
   END


-- 11 
  IF @tran_perm = 'T'  
      SET @xx = 'INV'
    else 
      SET @xx = 'PER'

-- 14
  SET @NVORI = @valpres -- @VALCOMP


IF @moneda = 999  or @moneda = 998 BEGIN
   SET @valorx = isnull((SELECT vmvalor  FROM view_valor_moneda    
                                       WHERE vmfecha = @fec_comp and vmcodigo = @moneda),0)

  END
ELSE IF @moneda = 13  or @moneda = 994 BEGIN
	IF month(@fecpro)<> month(@acfecprox) BEGIN
	   SET @valorX =isnull((SELECT vmvalor FROM view_valor_moneda 
                                     WHERE vmcodigo = 994 and vmfecha = @fecpro ),0)

	END
	ELSE BEGIN
	
	   SET @valorX = @valdolarant 

	END
  END

ELSE BEGIN
   SET @valorX =isnull((SELECT vmvalor FROM view_valor_moneda 
                                       WHERE vmcodigo = @moneda and vmfecha = @fecpro ),0)

  END

-- 17

   /******    moneda contable   *****/
	SELECT  @ccmon = MNCODFOX FROM view_moneda WHERE mncodmon = @moneda

   /******     Moneda reajustable segun cod banco *****/
	SELECT @ccmor = '03' -- Porque siempre tenemos MX, es 1 si es Peso, es 2 si es reajustable	

-- 19  
       	IF @moneda = 13 or @moneda = 994 
		BEGIN 
	        	SET @nmone = 994
       		END
	ELSE IF @moneda <> 13 and  @moneda <> 994    -- MAP 2016-06-16  Generalizando pra otras monedas 
		BEGIN
			SET @nmone = @moneda
		END
-- SELECT * FROM text_ser
   SET @dias = @dias_dIFe
   SET @inst_variable  = 'N'
   SET @tip_tasa       = '0'

 	SELECT  @nIntasb   = tipo_tasa ,
		@CTTAS	   = (CASE  WHEN  tasa_fija = 'F' THEN 'FLO' ELSE  'FIJ' END )
	FROM text_ser WHERE cod_nemo  =  @MASCARA 


 IF @nIntasb > 1  BEGIN 
      SELECT @var_tasa = ( SELECT tbglosa FROM view_tabla_general_detalle WHERE TBCODIGO1  =  @nIntasb and TBCATEG = 1042 )

      SET @inst_variable = 'S' 
      SET @tip_tasa = CASE WHEN @var_tasa = 'LIBOR'  OR @var_tasa = ' LIBOR 90' OR @var_tasa = ' LIBOR 30' OR @var_tasa = 'LIBOR 180' THEN 
                              '3' 
                          WHEN  @var_tasa = 'TIP'  THEN
                              '2'
			  WHEN  @var_tasa = 'TAB' OR @var_tasa =  'TAB 90' OR @var_tasa = 'TAB 30' OR @var_tasa = 'TAB 180'  THEN
			      '1'
                          ELSE 
                              '9'
                      	  END 


	IF datedIFf(day,@fecpro, @campo_26 ) < 30         -- cpfecpcup
         SET @tip_tasa = '2' + @tip_tasa + '1'

      IF datedIFf(day,@fecpro, @campo_26 ) >= 30 and  datedIFf(day,@fecpro,@campo_26)< 89
         SET @tip_tasa = '2' + @tip_tasa + '2'

      IF datedIFf(day,@fecpro,@campo_26) >= 90 and  datedIFf(month,@fecpro,@campo_26) < 6
         SET @tip_tasa = '2' + @tip_tasa + '3'

      IF datedIFf(month,@fecpro,@fecvenp) >= 6  and  datedIFf(year,@fecpro,@campo_26) < 1
         SET @tip_tasa = '2' + @tip_tasa + '4'

      IF datedIFf(year,@fecpro,@campo_26) >= 1  and  datedIFf(year,@fecpro,@campo_26) < 3
         SET @tip_tasa = '2' + @tip_tasa + '5'

      IF datedIFf(year,@fecpro,@campo_26) >= 3  
         SET @tip_tasa = '2'  + @tip_tasa + '6'

 END   


   IF @inst_variable= 'N'      -- fija  --N
     BEGIN 
      IF @dias < 30 
         SET @tip_tasa =  '101' 
      IF @dias >= 30 and @dias < 89   
         SET @tip_tasa =  '102' 
      IF @dias >= 90 and  @dias < 179 
	 SET @tip_tasa =  '103'
       IF @dias >= 180  and  @dias < 365  
         SET @tip_tasa =  '104'            
      IF @dias >= 365 and  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS
         SET @tip_tasa =  '105' 
      IF @dias >= 1095                    -- MAS DE TRES AÑOS 
         SET @tip_tasa =  '106'
      END 

IF @tabla  = 'MDCP' BEGIN 
	IF @tipoper  = 'CP' BEGIN
  
   	 SET @valor_compra = @valcomp --* @vDolar_obs 
   	END 
  
END

 SET @tdcupon = isnull((SELECT count(*) FROM text_dsa WHERE cod_nemo = @mascara ),0)
 --SET @nncup = ISNULL((SELECT TOP 1 num_cupon FROM text_dsa WHERE cod_nemo = @mascara and fecha_vcto  >= @fecpro ),0)
   SELECT TOP 1 @nncup = ISNULL(num_cupon,0),
                @saldo = saldo
   FROM text_dsa 
   WHERE cod_nemo = @mascara 
     and fecha_vcto  > @fecpro 

   SELECT @saldopeso = round( (  ( @saldo / 100 ) * @nominal  )  * @valorX , 0 ) 

-- 41 ctacontable @cuenta
   SET @cuentaI =isnull(( SELECT top 1 CtaContable FROM cartera_cuenta WHERE NumDocu = @nNumdocu and Correla = 1 and Variable = 'Interes_papel' ),'0000')

   SET @cuentaR =' ' -- isnull((SELECT top 1 CtaContable FROM cartera_cuenta WHERE NumDocu = @nNumdocu and Correla = 1 and Variable  = 'Reajuste_papel' ),'00000')
--23 mmp   0
   SET @dfecfmes = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )


   IF EXISTS(SELECT RSTIRMERC FROM TEXT_RSU  WHERE cod_nemo = @mascara and  rsfecpro =  @dFecFMesProx ) BEGIN
      SET @tasa =isnull((SELECT RSTIRMERC FROM TEXT_RSU   WHERE cod_nemo = @mascara and rsfecpro = @dFecFMesProx and rsnumdocu = @nNumdocu and rscorrelativo = @numero and rstipoper = 'DEV'),0.0)

   END  ELSE IF EXISTS(SELECT RSTIRMERC FROM TEXT_RSU  WHERE cod_nemo = @mascara and  rsfecpro =  @dfecfmes ) BEGIN
      SET @tasa =isnull(( SELECT RSTIRMERC FROM TEXT_RSU  WHERE cod_nemo = @mascara and  rsfecpro = @dfecfmes and rsnumdocu = @nNumdocu and rscorrelativo = @numero and rstipoper = 'DEV' ),0.0)

   END  ELSE BEGIN  -- sino tasa compra 
      SET @tasa      =  @tir
   END

INSERT TABLA_INTERFAZ VALUES (2, convert(varchar(9),@crut)   , RIGHT('00000000000000000000'+ CAST(@nNumdocu AS VARCHAR(5)) + CAST(@nNumoper AS VARCHAR(5) )+ cast(1 AS VARCHAR(2)) ,20) 
                           --    4         5 @xproducto               6        7           8         9
                              ,@cuenta   ,convert(numeric(10),@aa) ,'000'   , '00'       ,'0'     ,'0000'
                              -- 10           11        12        13     14       15
                             , @cod_instru , @XX     ,'00'    , @fec_comp  , @nvori  ,  0 
  				 -- 16          17        18       19               20       21      
                              ,@valorX   , @ccmon   , @ccmor   , @nmone     , @tip_tasa  ,@tir  
                            --  22           23          24         25      
                              ,@CTTAS    , @tasa    , '000000' , @fecvenp   
                           --    26         27                 28        29             30
			     , @campo_26 , @valpres   , '000'   , @dias_dIFe  , '000'   
                           --   , @campo_26 , @saldopeso   , '000'   , @dias_dIFe  , '000'   
                           -- , @campo_26 , @valor_compra   , '000'   , @dias_dIFe  , '000'   
                           --      31              32   33    34       35     36     37      
                              ,'0000000000000000','00','PCT','00001','00001', '' , '00000'
                          --     38           39         40      41         42        43         44  
                              , @fec_comp , @tdcupon , @nncup , @cuentaI , @nintel , @cuentaR , @reajustes
                           --  45    46      47            48
                             ,'S' , 'S' , @inversion    ,   1 , @nNumoper ,  @DIG 
                              )

FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @tipoper    , @valinip  , @rutcli  , @codcli   , @rutemi    ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp , @valvenp   , @valpres    , --@valcomp    ,
      @nNumdocu, @nNumoper   , @cuenta   , @fec_comp , @dias_dIFe ,
      @tran_perm ,@campo_26  , @nintel   , @reajustes ,@fecha_emi ,@fec_ven  , @valcomp
 
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SET @valcomp2  = ( SELECT SUM(valcomp) FROM #cartera     )
SET @sum_capi  = ( SELECT SUM(ncapoi)  FROM TABLA_INTERFAZ )
SET @barra     = ( SELECT count(*)     FROM TABLA_INTERFAZ )

SELECT *,'barra' = @barra,@valcomp2,@sum_capi FROM  TABLA_INTERFAZ order by crut

END
GO

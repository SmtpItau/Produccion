USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_POSICION_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_POSICION_BONOS]
AS
BEGIN

SET NOCOUNT ON
DECLARE  @VALORX       		NUMERIC(19,4)    ,
         @campo_26     		DATETIME         ,
         @nintel       		NUMERIC(13,2)    ,
         @reajustes    		NUMERIC(13,2)    ,
         @cod_instru   		NUMERIC(3)       ,
         @vDolar_obs   		NUMERIC(19,4)    ,
         @tip_tasa      	CHAR(3)		
         
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
        @valvenp 		NUMERIC (13,2)   ,
        @valcomp 		NUMERIC (19,4)   ,
        @valcomp2 		NUMERIC (19,4)   ,
        @rutcli  		NUMERIC (9)      ,
        @codcli 		CHAR (2) 	 ,
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
        @tdcupon 		CHAR(3) 	 ,
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
        @fec_comp 		DATETIME 	 , 
        @CTTAS   		CHAR (3) 	 ,
        @dias_dife 		NUMERIC(5)	 ,
        @tran_perm 		CHAR (10) 	 ,
        @tirc      		NUMERIC(19,4)	 ,
        @DIAS      		NUMERIC(19)	 ,
        @sum_capi 		NUMERIC(15)	 ,
        @nIntasb      		NUMERIC(5)	 ,
        @nIncodigo    		NUMERIC(5)	 ,
        @tasa         		NUMERIC(19,4)	 ,
        @dfecfmes   		DATETIME         ,
        @dFecFMesProx  		DATETIME 	 ,
        @acfecprox 		DATETIME 	 ,
        @fecha_emi 		DATETIME 	 ,
        @fec_ven 		DATETIME 	 ,
        @valpres   		NUMERIC (13,2) 	 ,
	@valdolarant   		NUMERIC (19,4) 	 ,
	@mto_opc_compra_x     	NUMERIC(10,2)	 ,
	@mto_opc_compra       	FLOAT	 	 ,
      	@valor                	NUMERIC(19,4)	 ,
	@interes_or   		NUMERIC(13,2)	 ,
	@base	     		NUMERIC(3)	 ,
	@tasa_int     		NUMERIC(20,8)    ,   -- MAP 2016-06-16 se confunde concepto con monto NUMERIC(16,8)
	@destino                NUMERIC(3)	 ,
	@nomin_en_pesos       	NUMERIC(19,4)	 ,
	@cuotas_rmtes         	NUMERIC(5)	 ,
	@nombre			CHAR(15)	 ,
	@actividad    		NUMERIC(4)	 ,
	@descripcion		VARCHAR(35)   	 ,
	@plazo                  NUMERIC(5)  


 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop ,
        @acfecprox = acfecprox,
	@valdolarant = dolarObsFinMes
 FROM TEXT_ARC_CTL_DRI

 SELECT @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fecpro),0)
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'

 
 CREATE TABLE #CARTERA
    (
    	mascara      CHAR (20)    	,       	--  1    
	numdocu      CHAR (12)    	,       	--  2
    	numoper      CHAR (12)    	,       	--  3
    	instrumento  CHAR (20)    	,       	--  4
    	codigo       NUMERIC (5)    	,      	 	--  5
    	nominal      NUMERIC (19,4)    	,       	--  6
    	tir          NUMERIC (19,4) 	,       	--  7
    	taspact      NUMERIC (19,4) NULL DEFAULT (0) ,  --   8
    	fecvenpact   DATETIME NULL   	,               --   9
    	moneda       NUMERIC (5)    	,               --   10
    	tipoper      CHAR (3)    	,               --   11
    	valinip   NUMERIC (19,4) NULL DEFAULT (0) ,  --   14
    	rutcli       NUMERIC (9)    	,               --   15
    	codcli       CHAR (2)    	,               --   16
    	rutemi       NUMERIC (9)    	,               --   17
    	tabla        CHAR (4)    	,               --   18
    	periodo      INTEGER     	,               --   19
    	fecvenp      DATETIME NULL   	,               --   20
    	valpres      NUMERIC (13,2) NULL DEFAULT (0) ,  --   21
    	valvenp      NUMERIC (13,2) NULL DEFAULT (0) ,  --   22
    	cuenta       CHAR(20) NULL DEFAULT ('')      ,  --   23
    	fecha_compra DATETIME		,               --   24
    	fec_ven      DATETIME		,               --   25
    	amortizacion NUMERIC(19,4)	,               --   26
    	saldo        NUMERIC(19,4)	,               --   27
    	invers       NUMERIC (5) 	,               --   28
    	cttas        CHAR(3)		,               --   29
    	dias_dife    NUMERIC(5)		,               --   30
    	tran_perm    CHAR (10) 		,               --   31 
    	tirc         NUMERIC(19,4)	,               --   32 
    	campo_26     DATETIME     	,               --   33  
    	interes      NUMERIC(19,4)	,               --   34
    	reajustes    NUMERIC(19,4)	,               --   35
    	fecha_emi    DATETIME		,               --   36
    	valcomp      NUMERIC (19,4) NULL DEFAULT (0) ,  --   37
	interes_or   NUMERIC(19,4)	,
	base	     NUMERIC(3)		,
	tasa_int     NUMERIC(20,8)  	,   -- MAP 20160616 Se confunde concepto con Montos NUMERIC(20,8) 
	destino	     NUMERIC(3)         , -- 39
	actividad    NUMERIC(4)		,
	descripcion  VARCHAR(35)	,
	plazo        NUMERIC(5)		,
	correla      NUMERIC (9) IDENTITY (1,1)           --    38
	)

--------------------------------------------------------------------------------------------

CREATE TABLE #INTERFAZ
   (
            cod_bco                         CHAR(2)                                                     --1
            ,cod_suc                        CHAR(4)                                                     --2
            ,cod_mda                        NUMERIC(4)                                                  --3
            ,cod_cta                        NUMERIC(12)                                                 --4
            ,t_producto                     CHAR(4)                                                     --5
            ,t_proceso                      CHAR(2)                                                     --6     
            ,cod_prod                       CHAR(4)                                                     --7 
            ,cls_cbtle                      NUMERIC(1)                                                  --8
            ,cod_pais                       CHAR( 2)                                                    --9
            ,act_eco                        NUMERIC(4)                                                  --10
            ,tip_prod                       CHAR(1)                                                     --11
            ,F_Infor                        CHAR(3)                                                     --12
            ,descrip                        VARCHAR(35)                                                 --13
            ,mes_proc                       NUMERIC(2)                                                  --14
            ,dia_proc                       NUMERIC(2)                                                  --15
            ,ano_proc                       NUMERIC(4)                                                  --16
            ,cod_mda2                       NUMERIC(3)                                                  --17
            ,n_operac                       NUMERIC(9)                                                  --18
            ,rut                            NUMERIC(9)                                                  --19
            ,dig                            CHAR(1)                                                     --20
            ,est_deuda			    CHAR(1)                    --21
            ,mes_inic                       NUMERIC(2)                                                  --22
            ,dia_inic                       NUMERIC(2)                                  --23
            ,ano_inic                       NUMERIC(4)                                                  --24
            ,mes_vcto                       NUMERIC(2)                                                  --25
            ,dia_vcto                       NUMERIC(2)                                                  --26
            ,ano_vcto                       NUMERIC(4)                                                  --27
            ,plazo                     	    NUMERIC(5)                                                  --28
            ,tip_plazo                      CHAR(2)                                                     --29
	    ,tasa_interes		    NUMERIC(9,6)
	    ,plazo_base			    NUMERIC(4)
	    ,tasa_operacion                 NUMERIC(9,6)
            ,mto_orig                       NUMERIC(13,2)                                          --30
            ,mto_cap                        NUMERIC(13,2)                                          --31
            ,sdo_orig                       NUMERIC(13,2)                                          --32
            ,sdo_cap                        NUMERIC(13,2)                                          --33
            ,int_dev_orig                   NUMERIC(13,2)                                          --34
            ,int_dev_nac                    NUMERIC(13,2)                                          --35
            ,reajuste                       NUMERIC(13,2)                                          --36
            ,cod_proc                       CHAR(2)                                                --37
            ,estatus                        CHAR(1)                                                --39
            ,tasa                           NUMERIC(20,6)    -- MAP 2016-06-16 Error de concepto                                      --41  -- MAP 2016-06-16 NUMERIC(11,6)  se confunde concepto con monto
            ,saldo                          NUMERIC(18,2)                                          --42
            ,signo                          CHAR(1)                                                --43
      )

 INSERT #CARTERA 
 SELECT cod_nemo 	,
        rsnumdocu 	,
        rsnumdocu 	,
        id_instrum 	,
        cod_familia	, 
        rsnominal 	,
        rstir 		,
        0  		,
        ''  		,
	rsmonemi	,
        'CP'  		,
        0  		,   
        rsrutemis 	,
        ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = rsrutemis AND Clcodigo = rscodemi),0) 	,
	rsrutemis	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_rsu.cod_nemo),0),
        rsfecvcto 	,
        rsvalcomu 	,
        CapitalPeso	,
        CtaContable	, 
        rsfeccomp	, 
        ''		,
       0		,
       0		,
       0		,
       ''		,
       datediff(day,@fecpro,rsfecvcto),
       codigo_carterasuper,
       0		,
       rsfecpcup  	,
       rsint_compra	,
       0		,
       rsfecemis 	,
       0 		,
       rsint_compra * ISNULL((select vmvalor from view_valor_moneda where vmcodigo = rsmonemi and vmfecha =  rsfeccomp ),0),  -- VERIFICAR
       rsbasemi		,
       rsinteres	,
       CASE  WHEN rsrutcli = 97029000 THEN 211 
             WHEN rsrutcli = 97030000 THEN 212
       ELSE
       				           221 
       END,
       clactivida,
       ISNULL((select descripcion FROM VIEW_PRODUCTO where codigo_producto = 'CP' AND id_sistema = 'BEX'),0),
       datediff(m,rsfeccomp,rsfecvcto) 
 FROM 	TEXT_rsu
	,CARTERA_CUENTA	,VIEW_CLIENTE 
 WHERE	rsnominal   > 0 AND rsrutcart > 0    
       	AND Correla   	= rscorrelativo -- 1
       	AND NumOper    	= rsnumdocu
       	and rsfecpro  	= @fecpro 
       	and rsfecpago  	< @fecpro 	
       	AND variable  	= 'valor_compra'
	AND t_operacion	= 'CP'
       	AND rsrutcli = clrut
	AND rscodcli    = clcodigo	
	AND rstipoper	= 'DEV'

 INSERT #CARTERA 
 SELECT cod_nemo 	,
        monumdocu 	,
        monumdocu 	,
        id_instrum 	,
        cod_familia	,
        monominal 	,
        motir     	,
        0  		,
        ''  		,
	momonemi	,
        'CP'  		,
        0  		,
        morutemi 	,
        ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = morutemi AND Clcodigo = cod_emi),0) 	,
	morutemi	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0),
        mofecven 	,
        movalcomu	,
        capitalpeso    	,
        CtaContable	,  
        mofecpro	, 
        ''		,
        0		,
        0		,
        0		,
        ''		,
        datediff(day,@fecpro,mofecven),
       	codigo_carterasuper,
	0		,
       	mofecpcup  	,    -- 26
        moint_compra	,
        moreajuste 	,
        mofecemi 	,
        movalcomp	,
	interespeso 	,
	mobasemi	,
	mointeres	,
       CASE  WHEN morutcli = 97029000 THEN 211 
             WHEN morutcli = 97030000 THEN 212
       ELSE
       				           221 
       END,
       clactivida	,
       ISNULL((select descripcion FROM VIEW_PRODUCTO where codigo_producto = motipoper AND id_sistema = 'BEX'),0),
       datediff(m,mofecemi,mofecven)--       datediff(day,mofecemi,mofecven)
 FROM TEXT_MVT_DRI,CARTERA_CUENTA,VIEW_CLIENTE 
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_compra'
       AND motipoper = 'CP'
       AND mofecpro  = @fecpro	  	
       AND mofecpago = @fecpro	  	
       AND morutcli  = clrut
       AND mocodcli  = clcodigo	


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
        morutemi 	,
        ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = morutemi AND Clcodigo = cod_emi),0) 	,
	morutemi	,
        'MDCP'  	,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0),
        mofecven 	,    	--25
        movalcomu	,
        capitalpeso    	,
        CtaContable	,  
        mofecpro, --mofeccomp	,    	--13
        ''		,
        0		,
        0		,
        0		,
        ''		,
        datediff(day,@fecpro,mofecven),
        codigo_carterasuper,
        0		,
        mofecpcup  	,    -- 26
        moint_compra 	,
        moreajuste 	,
        mofecemi 	,
        movalcomp	,
	interespeso	,
	mobasemi	,
	mointeres	,
       CASE  WHEN morutcli = 97029000 THEN 211 
             WHEN morutcli = 97030000 THEN 212
       ELSE
       				           221 
       END,
       clactivida	,
       ISNULL((select descripcion FROM VIEW_PRODUCTO where codigo_producto = motipoper AND id_sistema = 'BEX'),0),
       datediff(m,mofecemi,mofecven)--       datediff(day,mofecemi,mofecven)
 FROM TEXT_MVT_DRI,CARTERA_CUENTA,VIEW_CLIENTE
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_venta'
       AND motipoper = 'VP'
       AND mofecpro  = @fecpro
       AND morutcli  = clrut
       AND mocodcli  = clcodigo	



DECLARE CURSOR_INTER CURSOR FOR 
  SELECT   mascara   	, instrumento   , codigo  	, nominal  	, tir          	, taspact 
	, fecvenpact 	, moneda     	, tipoper	, valinip 	, rutcli       	, codcli       
	, rutemi     	, tabla      	, CONVERT(CHAR(9),correla)    	,'1'           	, periodo      
	, fecvenp    	, valpres	, valvenp 	, numdocu    	, numoper      	, cuenta 
	, fecha_compra 	, dias_dife     , tran_perm  	, campo_26      , interes 	, reajustes	
	, fecha_emi    	, fec_ven 	, valcomp	, interes_or	, base		, tasa_int
	, destino	, actividad	, descripcion	, plazo
  FROM #CARTERA


OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO  	@mascara 	, @instrumento	, @codigo   	, @nominal   	, @tir     	, @taspact   
	,@fecvenpact 	, @moneda  	, @tipoper    	, @valinip  	, @rutcli    	, @codcli 
	,@rutemi	, @tabla   	, @numero     	, @c        	, @periodo   	, @fecvenp   
	,@valpres   	, @valvenp    	, @nNumdocu	, @nNumoper   	, @cuenta   	, @fec_comp  
	,@dias_dife 	, @tran_perm 	, @campo_26 	, @nintel   	, @reajustes 	, @fecha_emi 
	,@fec_ven   	, @valcomp	, @interes_or	, @base		, @tasa_int	, @destino
	,@actividad	, @descripcion	, @plazo
WHILE @@FETCH_STATUS  = 0
BEGIN 




   SELECT @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@moneda and vmfecha = @fec_comp),0.0)  -- VERIFICAR


  IF @valor = 0 
      SET @tasa =  @valvenp/@valpres
  ELSE
      SET @tasa =  @valor

INSERT INTO #INTERFAZ
            VALUES
                   (
             		 '01'
            		,'001'
            		,@moneda
            		,@CUENTA
            		,'MDIR'
            		,CASE WHEN @tipoper = 'CP' THEN '70' ELSE '71' END
            		,'MD01'
            		,CASE WHEN @tipoper = '01' THEN '70' ELSE '02' END
            		,'CL'
            		,@actividad
            		,'M'
            		,'BEX'
            		,@descripcion
            		,CONVERT(NUMERIC(2),MONTH(@fecpro))
            		,CONVERT(NUMERIC(2),DAY(@fecpro))
            		,CONVERT(NUMERIC(4),YEAR(@fecpro))
            		,@moneda
            		,CAST(@nNumdocu AS VARCHAR(5)) + CAST(1 AS VARCHAR(2)) + cast(@nNumoper AS VARCHAR(5))
            		,@rutcli
            		,@codcli
            		,'1'
            		,CONVERT(NUMERIC(2),MONTH(@fec_comp))
            		,CONVERT(NUMERIC(2),DAY(@fec_comp))
            		,CONVERT(NUMERIC(4),YEAR(@fec_comp))
            		,CONVERT(NUMERIC(2),MONTH(@fecvenp))
            		,CONVERT(NUMERIC(2),DAY(@fecvenp))
            		,CONVERT(NUMERIC(4),YEAR(@fecvenp))
            		,@plazo
            		,'1'--,'2'
	    		,@tir
	    		,@base
	    		,@tir
            		,@valpres
            		,@valvenp
            		,@valpres
            		,@valvenp
            		,@nintel
            		,@interes_or
            		,@reajustes
            		,'13'
            		,'A'
            		,@tasa
            		,@valvenp+@interes_or+@reajustes
            		,'+'
                 )

FETCH NEXT FROM CURSOR_INTER
INTO  	@mascara 	, @instrumento	, @codigo   	, @nominal 	, @tir     	, @taspact   
	,@fecvenpact 	, @moneda  	, @tipoper    	, @valinip  	, @rutcli  	, @codcli   
	,@rutemi    	, @tabla   	, @numero     	, @c        	, @periodo 	, @fecvenp  
	,@valpres   	, @valvenp    	, @nNumdocu	, @nNumoper   	, @cuenta  	, @fec_comp 
	,@dias_dife 	, @tran_perm 	, @campo_26  	, @nintel   	, @reajustes 	, @fecha_emi 
	,@fec_ven  	, @valcomp 	, @interes_or	, @base		, @tasa_int	, @destino
	,@actividad     , @descripcion  , @plazo
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER


SET ROWCOUNT 0
END

SET NOCOUNT OFF

SELECT * FROM #INTERFAZ


GO

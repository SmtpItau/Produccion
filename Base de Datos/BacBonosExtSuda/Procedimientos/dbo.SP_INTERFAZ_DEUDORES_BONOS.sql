USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DEUDORES_BONOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_DEUDORES_BONOS]
AS
BEGIN

SET NOCOUNT ON

 DECLARE  @VALORX    NUMERIC(19,4),
                  @xx15      NUMERIC(19,4),
                  @nmone     NUMERIC(3),
                  @campo_26  DATETIME

DECLARE @CCMOR CHAR(3)
DECLARE @CCMON CHAR(2)

DECLARE @c            CHAR (1)       ,
        @mascara      CHAR (25)      ,
        @instrumento  CHAR (25)      ,
        @codigo       NUMERIC (5)    ,
        @nominal      NUMERIC (19,4) ,
        @tir          NUMERIC (19,4) ,
        @taspact      NUMERIC (19,4) ,
        @fecvenpact   DATETIME       ,
        @moneda       NUMERIC 	(5)  ,
        @seriado      CHAR 	(1)  ,
        @tipoper      CHAR 	(3)  ,
        @valinip      NUMERIC (19,4) ,
        @valvenp      NUMERIC (19,4) ,
        @valcomp      NUMERIC (19,4) ,
        @rutcli       CHAR (9)    ,
        @codcli       NUMERIC (5)    ,
        @rutemi       CHAR (9)    ,
        @tabla        CHAR (4)       ,
        @numero       NUMERIC (9)    ,
        @cuenta       CHAR (20)      ,
        @tipo_tasa    NUMERIC (1)    ,
        @inversion    NUMERIC (5)    ,
        @tipo_cuenta  CHAR (2)       ,
        @fecpro       DATETIME       ,
        @periodo      INTEGER        ,
        @fecvenp      DATETIME       ,
        @cliente      NUMERIC (9)    ,
        @estado       NUMERIC (9)    ,
        @emtipo       CHAR (5)       ,
        @nNumdocu     NUMERIC (10,0) ,
        @nNumoper     NUMERIC (10,0) ,
        @nCorrela     NUMERIC (03,0) ,
        @fec_comp     DATETIME       , 
        @CTTAS        CHAR (3)       ,
        @dias_dife    NUMERIC(6)     ,
        @tran_perm    CHAR (10)      ,
        @tirc         NUMERIC(19,4)  ,
        @DIAS         NUMERIC(19)    ,
        @max_fecha    datetime       ,
        @cope         nvarchar(20)   ,
        @corr         NUMERIC(2)     ,
        @ntoc         char(3)        ,
        @sepa         char(1)        ,
        @vcuo         NUMERIC(5,2)  ,
        @svca         NUMERIC(19)    ,
        @tasa         NUMERIC(19,4)  ,
        @rut          CHAR(10)       ,
        @cant         NUMERIC(19)    ,
        @contador     NUMERIC(19)    ,
        @tdmascara    CHAR(10)       ,
        @tdcupon      NUMERIC (5)    ,
        @tdcupon2     NUMERIC (5)    ,
        @tdamort      NUMERIC (19,10),
        @tdfecven     DATETIME       ,
        @tdinteres    NUMERIC(19,10) ,
        @tdflujo      NUMERIC(19,10) ,
        @tdsaldo      NUMERIC(19,10) ,
        @cuenta_flu   CHAR(20)       ,
        @valcomu      numeric(19,4)  ,
        @nsnumdocu    numeric(9)     ,
        @nsfecven     datetime       ,
        @fecha_ami    datetime       ,
        @inte         numeric(19,4)  ,
        @valmoneda    numeric(19,4)  ,
        @ref          NVARCHAR(20)   ,
        @cont_reg     NUMERIC(19)    ,
        @valorpresente NUMERIC(19,4) ,
        @dfecfmes      datetime      ,
        @dFecFMesProx  datetime      ,
        @acfecprox     datetime      ,
        @mas_paso      CHAR (12)     ,
        @Peri_cupon    numeric(3)    ,
        @nsfecemi      datetime      ,
        @porcentaje    numeric(5,2)  ,
        @codigocl      char(1)       ,
        @calculo       numeric(19,10)


 DECLARE @valdolarant      numeric(19,4)

 SELECT @fecpro      	= acfecproc ,
        @cliente   	= acrutprop ,
        @acfecprox   	= acfecprox,
	@valdolarant 	= dolarObsFinMes    
FROM TEXT_ARC_CTL_DRI

SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'

---------------------------------------------------------------------------------------------
SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'
---------------------------------------------------------------------------------------------
 
 CREATE TABLE #CARTERA
    (
    mascara     CHAR (25)             ,         --1
    numdocu     NUMERIC (10,0)        ,         --2
numoper     NUMERIC (10,0)        ,         --3
    corre       NUMERIC (03,0)        ,         --4
    instrumento CHAR 	(25)          ,         --5
    codigo      NUMERIC (5)           ,         --6
    nominal     NUMERIC (19,4)        ,         --7
    tir         NUMERIC (19,4)        ,         --8
    taspact     NUMERIC (19,4) NULL DEFAULT (0) ,--9
    fecvenpact  DATETIME NULL         ,         --10
    moneda      NUMERIC (5)           ,         --11
    tipoper     CHAR (3)              ,         --13
    valinip     NUMERIC (19,4) NULL DEFAULT (0) ,--14
    rutcli      CHAR (9)              ,         --15
    codcli      NUMERIC (5)           ,         --16
    rutemi      CHAR (9)              ,         --17
    tabla       CHAR (4)              ,         --18
    periodo     INTEGER               ,         --19
    fecvenp     DATETIME NULL         ,         --20
    valvenp     NUMERIC (19,4) NULL DEFAULT (0),--21
    valcomp     NUMERIC (19,4) NULL DEFAULT (0) ,--22
    correla     NUMERIC (9) IDENTITY (1,1) ,     --23
    cuenta     CHAR(20) NULL DEFAULT ('')  ,     --24
    fecha_compra datetime            ,           --25
    fec_ven      datetime            ,           --26
    amortizacion numeric(19,4)       ,           --27
    saldo        numeric(19,4)       ,           --28
    invers       NUMERIC (5)         ,           --29
    cttas        char(3)             ,           --30
    dias_dife    numeric(6)          ,           --31
    tran_perm    CHAR (10)           ,           --32
    tirc         numeric(19,4)       ,           --33
    campo_26     datetime            ,           --34
    valorpresente numeric(19,4)      ,           --35
    cuenta2      char(20)            ,           --36
    valcomu      numeric(19,4)       ,           --37
    fecha_ami    datetime            ,           --38
    porcentaje   numeric(5,2)                    --39 
  )

---------------------------------------------------------------------------------------------
CREATE TABLE #TABLA_INTERFAZ
      (    RUT_DEUDOR_DIREC VARCHAR(15)
          ,NUM_OPERAC       VARCHAR(16)
          ,RUT_DEUDOR_RELAC VARCHAR(15)
          ,SISTEMA          VARCHAR(2)
          ,TIPO_CLI         VARCHAR(20)
          ,PORCENTAJE       NUMERIC(5,2)
          ,INDICADOR        VARCHAR(1)
      )



---------------------------------------------------------------------------------------------
 INSERT #CARTERA 
 SELECT cod_nemo 	,--1
        cpnumdocu 	,--2
        cpnumdocu 	,--3
        cpcorrelativo   ,--4
        id_instrum 	,--5
        cod_familia	,--6
        cpnominal 	,--7
        cptircomp 	,--8
        0  		,--9
        ''		,--10
	cpmonemi	,--11
        'CP'  		,--12
        0  		,--13
        cprutcli 	,--14
        cpcodcli 	,--15
	cprutemi	,--16
	'MDCP'		,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_CTR_INV.cod_nemo),0), --17
        cpfecven 	,--18
        cpnominal 	,--19
        cpvalcomp       ,--20
        CtaContable     ,--21
        cpfeccomp       ,--22
        ''              ,--23
        0          	,--24
        0          	,--25
        0          	,--26
        ''         	,--27
        datediff(day,@fecpro,cpfecven),--28
        codigo_carterasuper,--29
        0                  ,--30
        cpfecpcup          ,--31
	cpvptirc           ,--32
        CtaContable        ,--33
        cpvalcomu          ,--34
        cpfecemi           ,--35
	0
 FROM TEXT_CTR_INV,CARTERA_CUENTA
 WHERE cpnominal   > 0 AND cprutcart > 0    
       	AND NumDocu   = cpnumdocu
       	AND Correla   = 1
       	AND NumOper   = cpnumdocu
       	AND variable  = 'valor_compra'
	AND cpfeccomp < @fecpro	


 INSERT #CARTERA 
 SELECT cod_nemo 	,-- 1
        monumdocu 	,--2
        monumdocu 	,--3
	mocorrelativo	,--4
        id_instrum 	,--5
        cod_familia	,--6
        monominal 	,--7
        motir  	,--8
        0  		,--9
        ''		,--10
	momonemi	,--11
        'CP'  		,--12
        0  		,--13
        morutcli 	,--14
        mocodcli 	,--15
	morutemi	,--16
	'MDCP'		,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0), --17
        mofecven 	,--17
        monominal 	,--19
	movalcomp	,--20
	CtaContable     ,--21
	mofecpro	,--22
	''		,--23
	0		,--24
	0		,--25
	0		,--26
	''		,--27
        datediff(day,@fecpro,mofecven),--28
        codigo_carterasuper,--29
	0		,--30
        mofecpcup  	,--31
        motir    	,--32 	
	CtaContable     ,--33
        movalcomu	,--34    	
        mofecemi	,--35 
	0

 FROM TEXT_MVT_DRI,CARTERA_CUENTA
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND mofecpro  = @fecpro
       AND motipoper = 'CP'
       and variable  = 'valor_compra'	
       AND mofecpago  = @fecpro	

 INSERT #CARTERA 
 SELECT cod_nemo 	,-- 1
        monumdocu 	,--2
        monumdocu 	,--3
	mocorrelativo	,--4
        id_instrum 	,--5
        cod_familia	,--6
        monominal 	,--7
        motir     	,--8
        0  		,--9
        ''		,--10
	momonemi	,--11
        'CP'  		,--12
        0  		,--13
        morutcli 	,--14
        mocodcli 	,--15
	morutemi	,--16
	'MDCP'		,
        ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0), --17
        mofecven 	,--17
        monominal 	,--19
	movalcomp	,--20
	CtaContable     ,--21
	mofecpro	,--22
	''		,--23
	0		,--24
	0		,--25
	0		,--26
	''		,--27
        datediff(day,@fecpro,mofecven),--28
        codigo_carterasuper,--29
	0		,--30
        mofecpcup  	,--31
        motir    	,--32 	
	CtaContable     ,--33
        movalcomu	,--34    	
        mofecemi	,--35 
	0
 FROM TEXT_MVT_DRI,CARTERA_CUENTA
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND mofecpro  = @fecpro
       AND motipoper = 'VP'
       and variable  = 'valor_venta'	


DECLARE CURSOR_CARTERA CURSOR FOR 
  SELECT   mascara    , instrumento    	, codigo  , nominal , tir     	, taspact , fecvenpact 
         , moneda     , tipoper 	, valinip , rutcli  , codcli  	, rutemi 
         , tabla      , CONVERT(CHAR(9),correla)  ,'1'      , periodo  	, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        	, corre   , cuenta  , fecha_compra , dias_dife 
         , tran_perm  , campo_26       	, cuenta2 , valcomu , fecha_ami	, porcentaje
  FROM #CARTERA

OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara , @instrumento , @codigo    , @nominal  , @tir       , @taspact    , @fecvenpact ,
      @moneda  , @tipoper     , @valinip   , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero      , @c         , @periodo  , @fecvenp   , @valvenp    , @valcomp    ,
      @nNumdocu, @nNumoper    , @nCorrela  , @cuenta   , @fec_comp  , @dias_dife  ,
      @tran_perm ,@campo_26   , @cuenta_flu, @valcomu  , @fecha_ami , @porcentaje

WHILE @@FETCH_STATUS  = 0
BEGIN 

IF  @rutemi <> 0
BEGIN
      		select @Peri_cupon = ISNULL((SELECT per_cupones FROM text_ser WHERE cod_nemo = @mascara),0)
		SELECT @tdmascara = cod_nemo ,@tdamort= amortizacion ,@tdsaldo = saldo 
			FROM   TEXT_DSA  
			WHERE cod_nemo = @mascara 
			AND   fecha_vcto_cupon  > @fecpro 

               IF @tdsaldo > 0
               begin
                  SET @calculo = ((@nominal*@tdsaldo)/100)
                  SET @VCUO = (@calculo/@nominal)*100
               end else
                  SET @VCUO = @tdamort

           IF @tdamort > 0
               INSERT #TABLA_INTERFAZ 
               VALUES (@rutcli,CAST(@nNumdocu AS VARCHAR(5)) + cast( @nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)),@rutemi ,51,'PL',@VCUO,'I')
END   

-----------------------------------------------------------------------------------------------   



FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento , @codigo     , @nominal  , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @tipoper  	, @valinip    , @rutcli   , @codcli   , @rutemi    ,
      @tabla     , @numero      , @c          , @periodo  , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper    , @nCorrela   , @cuenta   , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26    , @cuenta_flu ,@valcomu   ,@fecha_ami , @porcentaje

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA

 SELECT @cont_reg = COUNT(*) FROM #TABLA_INTERFAZ
 SELECT @cont_reg,* FROM  #TABLA_INTERFAZ
END

GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DEUDORES_TRADER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[SP_INTERFAZ_DEUDORES_TRADER]
CREATE procedure [dbo].[SP_INTERFAZ_DEUDORES_TRADER]
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
        @mascara      CHAR (12)      ,
        @instrumento  CHAR (12)      ,
        @codigo       NUMERIC (5)    ,
        @nominal      NUMERIC (21,4) ,
        @tir          NUMERIC (19,4) ,
        @taspact      NUMERIC (19,4) ,
        @fecvenpact   DATETIME       ,
        @moneda       NUMERIC (5)    ,
        @seriado      CHAR (1)       ,
        @tipoper      CHAR (3)       ,
        @valinip      NUMERIC (21,4) ,
        @valvenp      NUMERIC (21,4) ,
        @valcomp      NUMERIC (21,4) ,
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
        @dias_dife    NUMERIC(5)     ,  --> NUMERIC(4)
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
        @porcentaje    numeric(5,2)   ,
        @codigocl      char(1)       ,
        @calculo       numeric(21,4) -->>>>>>>>> 


SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop ,
        @acfecprox = acfecprox
 FROM MDAC

---------------------------------------------------------------------------------------------
SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'
---------------------------------------------------------------------------------------------
 
 CREATE TABLE #CARTERA
    (
    mascara     CHAR (12)             ,         --1
    numdocu     NUMERIC (10,0)        ,         --2
    numoper     NUMERIC (10,0)        ,         --3
    corre       NUMERIC (03,0)        ,         --4
    instrumento CHAR (12)             ,       --5
 codigo      NUMERIC (5)           ,         --6
    nominal     NUMERIC (19,4)        ,         --7
    tir         NUMERIC (19,4)        ,         --8
    taspact     NUMERIC (19,4) NULL DEFAULT (0) ,--9
    fecvenpact  DATETIME NULL         ,         --10
    moneda      NUMERIC (5)           ,         --11
    seriado     CHAR (1)              ,         --12
    tipoper     CHAR (3)              ,         --13
    valinip     NUMERIC (19,4) NULL DEFAULT (0) ,--14
    rutcli      CHAR (9)           ,         --15
    codcli      NUMERIC (5)           ,         --16
    rutemi      CHAR (9)           ,         --17
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
    dias_dife    numeric(5)          ,           --31 numeric(5)
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
 SELECT 
        cpmascara ,
        cpnumdocu ,
        cpnumdocu ,
        cpcorrela ,
        cpinstser ,
        cpcodigo ,
        cpnominal ,
        cptircomp ,
        0  ,
        ''  ,
        CASE
         WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END  ,
        cpseriado ,
        'CP'  ,
        0  ,
        RTRIM(CONVERT(CHAR(09),cprutcli))  ,
        cpcodcli ,
        CONVERT(CHAR(09),CASE
            WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
            ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END)  ,
        'MDCP'  ,
       ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
       cpfecven ,    --25
       cpnominal ,
       cpvalcomp ,  --14
       CtaContable,
       cpfeccomp,    --13
       '',
       0,
       0,  
       0,
       '',
       datediff(day,@fecpro,cpfecven),
       codigo_carterasuper,
       0,                                    
       CASE WHEN cpseriado = 'N' and cpcodigo = 888 THEN cpfecven ELSE cpfecpcup  END,  -- 26
       cpvptirc,
       CtaContable ,
       cpvalcomu,
       cpfecemi,
       CASE
            WHEN cpseriado='N' THEN 100
            ELSE 0
       END 

FROM MDCP  ,CARTERA_CUENTA 
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = 'CP'
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   variable    = 'valor_compra'


-- select * from mdcp
 INSERT #CARTERA 
 SELECT vimascara ,
        vinumdocu ,  --4
        vinumoper ,  --4
        vicorrela ,  --4
        viinstser ,   
        vicodigo ,
        vinominal ,
        vitircomp ,
        0  ,
        vifecvenp ,   --25
        vimonemi ,
        '', --viseriado ,
        'CP'  ,
        0  ,
        RTRIM(CONVERT(CHAR(09),virutcli)),
        vicodcli ,
        CONVERT(CHAR(09),0),--CASE
        --    WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
        -- ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        --END  ,
        'MDCP'  ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
        vifecven ,
        vinominal ,
        vivalcomp , 
        CtaContable ,
        0,
        '',
        0,
        0,
        0,
        '',
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
        0,
       vifecvenp ,  --26
       vivptirc,
       CtaContable ,
       vivalcomu,
       vifecemi,
       0

   FROM MDVI,CARTERA_CUENTA
 WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'



 -- select * from mdvi
 INSERT #CARTERA 
 SELECT vimascara ,
        vinumdocu ,
        vinumoper ,
        vicorrela ,
        viinstser ,
        vicodigo ,
        vinominal ,
        vitircomp ,
        vitaspact ,
        vifecvenp ,    --25
        CASE
            WHEN viseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
        '', --viseriado ,
        vitipoper ,
        vivalinip ,
        RTRIM(CONVERT(CHAR(09),virutcli)),
        vicodcli ,
        CONVERT(CHAR(09),0),--CASE
         --WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         --ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        --END  ,
        'MDVI'  ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
        ''  ,
        vivalvenp ,   --26
        vivalcomp ,
        CtaContable ,
        0,
        '',
        0,
        0,
        0,
        '',
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
       vivalvenp,
       vifecvenp,    --26
       vivptirc ,
       CtaContable ,
       vivalcomu,
       vifecemi,
       0
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND NumDocu  = vinumdocu
 AND Correla  = vicorrela
 AND NumOper  = vinumoper 
 AND variable = 'valor_compra'



-- select * from mdvi
 INSERT #CARTERA
 SELECT cimascara ,
        cinumdocu ,
        cinumdocu ,
        cicorrela ,
        ciinstser ,
        cicodigo ,
        cinominal ,
        citircomp ,
        citaspact ,
        cifecvenp ,  --25 
        CASE
         WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cimonpact
         ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cimascara)
              END)
        END, 
        '',
        CASE
   WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END        ,
        civalinip  ,
        RTRIM(CONVERT(CHAR(09),cirutcli)),
        cicodcli   ,
        CONVERT(CHAR(09),CASE
            WHEN ciinstser='ICOL'  THEN cirutcli
            WHEN ciinstser='ICAP'  THEN 0
        ELSE
            cirutcli
        END),   
       'MDCI'  ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''  ,
        civalvenp ,  --26
        civalcomp ,
        ctacontable,
        cifeccomp,
        '',
        0,
        0 ,
        0,
        '',
        datediff(day,@fecpro,cifecvenp),
        codigo_carterasuper,
        0,
        cifecvenp ,   --26
        civptirci,
        CtaContable ,
        civalcomu,
        cifecemi,
        CASE
           WHEN ciinstser='ICOL'  THEN 100
           WHEN ciinstser='ICAP'  THEN 0
         ELSE
            100
         END

 FROM MDCI,CARTERA_CUENTA
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND variable = 'valor_compra'

set @contador = 1


DECLARE CURSOR_CARTERA CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal , tir    , taspact , fecvenpact 
         , moneda     , seriado        , tipoper , valinip , rutcli , codcli  , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'      , periodo, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        , corre   , cuenta  , fecha_compra , dias_dife 
         , tran_perm  , campo_26       , cuenta2 , valcomu , fecha_ami, porcentaje
  FROM #CARTERA


OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm ,@campo_26  , @cuenta_flu, @valcomu, @fecha_ami, @porcentaje



WHILE @@FETCH_STATUS  = 0
BEGIN 

--- dbo.Sp_Interfaz_deudores_trader

/*IF @rutemi <> 0
SELECT @rutemi = @rutemi + isnull((select cldv from view_cliente where clrut = @rutemi),0) 
SELECT @rutemi */

--select @nNumoper
IF  @rutemi <> 0
BEGIN
      IF @SERIADO = 'S'   -- SERIADO
      BEGIN

         select @Peri_cupon = isnull( (select top 1 sepervcup from view_serie where  semascara = @mascara  ), 0)
         SELECT @tdmascara = tdmascara ,@tdamort= tdamort ,@tdsaldo = tdsaldo 
         FROM view_tabla_desarrollo  
            WHERE tdmascara = @mascara 
                   and (CASE WHEN @codigo = 20 THEN DATEADD( MONTH, tdcupon * @Peri_cupon, @fecha_ami ) 
                             ELSE tdfecven 
                       END ) = @fecpro 


             IF @codigo <> 31
               IF @tdsaldo > 0
               begin

--                  SELECT '.',    ((@nominal*@tdsaldo)/100), @tdsaldo, @nominal
                  SET @calculo = ((@nominal*@tdsaldo)/100)
--                  SELECT '..', @calculo

                  SET @VCUO = (@calculo/@nominal)*100
               end else
                  SET @VCUO = @tdamort
             ELSE
                SET @VCUO = 100
      
            IF @tdamort > 0
               INSERT #TABLA_INTERFAZ 
               VALUES (@rutcli,CAST(@nNumdocu AS VARCHAR(6)) + cast( @nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(6)),@rutemi ,15,'PL',@VCUO,'I')

      END ELSE BEGIN

         INSERT #TABLA_INTERFAZ 
         VALUES (@rutcli,cast(@nNumdocu AS VARCHAR(6)) + cast(@nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(6)),@rutemi ,15,'PL',@porcentaje,'I')
		
   END
END   

-----------------------------------------------------------------------------------------------   




FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento , @codigo  , @nominal , @tir   , @taspact , @fecvenpact ,
      @moneda    , @seriado     , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla     , @numero      , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper    , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26    , @cuenta_flu ,@valcomu ,@fecha_ami, @porcentaje

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA

 SELECT @cont_reg = COUNT(*) FROM #TABLA_INTERFAZ
 SELECT @cont_reg,* FROM  #TABLA_INTERFAZ

END

GO

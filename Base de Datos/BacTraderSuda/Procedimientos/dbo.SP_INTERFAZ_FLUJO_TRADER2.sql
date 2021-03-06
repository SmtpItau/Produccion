USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_TRADER2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_TRADER2]
AS
BEGIN

SET NOCOUNT ON

   DECLARE @VALORX    NUMERIC(19,4),
           @xx15      NUMERIC(19,4),
           @nmone     NUMERIC(3),
           @campo_26  DATETIME

   DECLARE @CCMOR CHAR(3)
   DECLARE @CCMON CHAR(2)

DECLARE @c            CHAR (1)       ,
        @mascara      CHAR (12)      ,
        @instrumento  CHAR (12)      ,
        @codigo       NUMERIC (5)    ,
        @nominal      NUMERIC (19,4) ,
        @tir          NUMERIC (19,4) ,
        @taspact      NUMERIC (19,4) ,
        @fecvenpact   DATETIME       ,
        @moneda       NUMERIC (5)    ,
        @seriado      CHAR (1)       ,
        @tipoper      CHAR (4)       ,
        @valinip      NUMERIC (19,4) ,
        @valvenp      NUMERIC (19,4) ,
        @valcomp      NUMERIC (19,4) ,
        @rutcli       NUMERIC (9)    ,
        @codcli       NUMERIC (5)    ,
        @rutemi       NUMERIC (9)    ,
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
        @dias_dife    NUMERIC(4)     ,
        @tran_perm    CHAR (10)      ,
        @tirc         NUMERIC(19,4)  ,
        @DIAS         NUMERIC(19)    ,
        @max_fecha    datetime       ,
        @cope         nvarchar(20)   ,
        @corr         NUMERIC(2)     ,
        @ntoc         char(3)        ,
        @sepa         char(1)        ,
        @vcuo         NUMERIC(19,4)  ,
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
        @nsfecemi      datetime      

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
    instrumento CHAR (12)             ,         --5
    codigo      NUMERIC (5)           ,         --6
    nominal     NUMERIC (19,4)        ,         --7
    tir         NUMERIC (19,4)        ,         --8
    taspact     NUMERIC (19,4) NULL DEFAULT (0) ,--9
    fecvenpact  DATETIME NULL         ,         --10
    moneda      NUMERIC (5)           ,         --11
    seriado     CHAR (1)              ,         --12
    tipoper     CHAR (4)              ,         --13
    valinip     NUMERIC (19,4) NULL DEFAULT (0) ,--14
    rutcli      NUMERIC (9)           ,         --15
    codcli      NUMERIC (5)           ,         --16
    rutemi      NUMERIC (9)           ,         --17
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
    dias_dife    numeric(4)          ,           --31
    tran_perm    CHAR (10)           ,           --32
    tirc         numeric(19,4)       ,           --33
    campo_26     datetime            ,           --34
    valorpresente numeric(19,4)      ,           --35
    cuenta2      char(20)            ,           --36
    valcomu      numeric(19,4)       ,           --37
    fecha_ami    datetime                        --38
  )

---------------------------------------------------------------------------------------------
CREATE TABLE #TABLA_INTERFAZ
      (    Cod_Pais         VARCHAR(3)
          ,Num_Fuente       VARCHAR(14)
          ,Cod_Emp          VARCHAR(3)
          ,Cod_Interno      VARCHAR(16)
          ,Numero_Operacion VARCHAR(20)
          ,F_Pago_Cuota     DATETIME
          ,Mto_Moneda_Local NUMERIC(18,2)
          ,Mto_A_Mda_local  NUMERIC(18,2)
          ,Mto_I_Mda_local  NUMERIC(19,2) 
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
        cpseriado,
        'MD01',       --'CP'  ,
        0  ,
        cprutcli ,
        cpcodcli ,
        CASE
            WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
            ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END  ,
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
       cpfecemi

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
        viseriado ,
        'MD01',      --'CP'  ,
        0  ,
        virutcli ,
        vicodcli ,
        CASE
            WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
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
       vifecemi
   FROM MDVI,CARTERA_CUENTA
 WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'

 -- select * from mdvi
/* INSERT #CARTERA 
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
        viseriado ,
        'MD01'    ,         --'vitipoper ,
        vivalinip ,
        virutcli ,
        vicodcli ,
        CASE
         WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
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
       vifecemi
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND NumDocu  = vinumdocu
 AND Correla  = vicorrela
 AND NumOper  = vinumoper 
 AND variable = 'valor_compra'*/
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
        END  , 
        ciseriado ,
        'MD01' ,--CASE
               --WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
               --ELSE 'CI'
               --END  ,
        civalinip ,
        cirutcli ,
        cicodcli ,
        CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
            ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                                                   nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
     ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cimascara)
       END)
       END  ,
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
      cifecemi
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
         , tran_perm  , campo_26       , cuenta2 , valcomu , fecha_ami
  FROM #CARTERA

OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm ,@campo_26  , @cuenta_flu, @valcomu, @fecha_ami

WHILE @@FETCH_STATUS  = 0
BEGIN 

 if @seriado ='S'
    SET @cant = ISNULL(( SELECT COUNT(*) FROM view_tabla_desarrollo  WHERE  DATEADD( MONTH, tdcupon * 3, @fecha_ami ) >= @fecpro AND tdmascara = @mascara  ),0)
 else 
    SET @cant = ISNULL(( SELECT COUNT(*) FROM view_noserie  WHERE nsserie = @mascara  and nsfecven > @fecpro ),0)

IF @cant  > 1
   SET @corr = 1
 ELSE 
   SET @corr = 0

-- 16
    IF EXISTS(SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and  fecha_proceso =  @fecpro) BEGIN
                 SET @tasa =( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and Fecha_proceso = @fecpro)
    end  ELSE BEGIN 
      SET @max_fecha = (SELECT MAX(fecha_proceso)  FROM tasa_mercado WHERE tminstser = @mascara )
      SET @tasa      = ISNULL((SELECT tasa_mercado FROM tasa_mercado WHERE tminstser = @mascara and Fecha_proceso = @max_fecha ),0.0)
   END 


   select @valmoneda = 0

  IF @seriado = 'N'    -- NO SERIADO
  BEGIN
      if @campo_26 = @fecpro 
         set @ntoc = 1
      else
         set @ntoc = 0

     if @moneda = 999 begin
        set @inte = @nominal - @valcomp 
        set @vcuo =  @valcomp
      end else  begin 
        set @valmoneda = ISNULL(( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecpro ),0)
        set @inte      = round(( @nominal - @valcomu ) * @valmoneda ,0)
        set @vcuo      = round(( @inte + @valcomp ),0)
      end 
       
 
   DECLARE CURSOR_INTERFAZ CURSOR FOR 
    SELECT nsserie ,nscorrela, nsnumdocu ,nsfecven,nsfecemi 
       FROM view_noserie 
            WHERE nsserie = @instrumento  and  nsnumdocu = @nNumdocu and nscorrela = @nCorrela and nsfecven > @fecpro 
            ORDER BY nsnumdocu
--   antes     WHERE nsserie = @mascara and nsfecven > @fecpro order by nsnumdocu

    OPEN CURSOR_INTERFAZ
    FETCH NEXT FROM CURSOR_INTERFAZ
    INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi   

    WHILE @@FETCH_STATUS  = 0
    BEGIN 


      IF DATEDIFF(YEAR, @nsfecemi, @nsfecven ) >= 1 begin 
         SET @sepa = 'A'
         SET @contador =  DATEDIFF(YEAR,  @nsfecemi, @nsfecven ) -- @contador = cada cuanto tiempo 
         END  
      ELSE IF DATEDIFF(MONTH,  @nsfecemi, @nsfecven ) >= 1 and DATEDIFF(MONTH, @nsfecemi , @nsfecven ) < 12 begin  
         SET @sepa = 'M'
         SET @contador = DATEDIFF(MONTH,  @nsfecemi, @nsfecven )
      END 
      ELSE IF DATEDIFF(DAY, @nsfecemi, @nsfecven ) >= 1 AND  DATEDIFF(DAY, @nsfecemi, @nsfecven ) <= 31   BEGIN  
         SET @sepa = 'D'
         SET @contador = DATEDIFF(DAY, @nsfecemi, @nsfecven )  
      END       IF @Cuenta <> '0' AND @Cuenta <> ''
      BEGIN
      INSERT #TABLA_INTERFAZ 
         VALUES ('CL' , 'FL15' , '001', @tipoper , RIGHT('00000000000000000000'+ CAST(@nNumdocu AS VARCHAR(5)) + cast(@tdcupon AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5) ) ,20) , @nsfecven,  @vcuo, @valcomp , @inte)
              -- 1   2     3       4         5         6        7       8         9           10        11       12       13    14       15          16     17
      END
    FETCH NEXT FROM CURSOR_INTERFAZ
    INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi   
    END 
    CLOSE       CURSOR_INTERFAZ
    DEALLOCATE  CURSOR_INTERFAZ

  END -- FIN NO SERIADO

------------------------------------------------------------------------------------------------

IF @SERIADO = 'S' begin    -- SERIADO

set @Peri_cupon = isnull( (select top 1 sepervcup from view_serie where  semascara = @mascara  ), 0)

DECLARE CURSOR_INTERFAZ CURSOR FOR 
   SELECT tdmascara , tdcupon , tdfecven , tdinteres , tdamort , tdflujo , tdsaldo 
   FROM view_tabla_desarrollo  
      WHERE tdmascara = @mascara and tdcupon > @nCorrela 
             and (CASE WHEN @codigo = 20 THEN DATEADD( MONTH, tdcupon * @Peri_cupon, @fecha_ami ) 
                  ELSE tdfecven END ) > @fecpro 

   OPEN CURSOR_INTERFAZ
   FETCH NEXT FROM CURSOR_INTERFAZ
   INTO  @tdmascara , @tdcupon , @tdfecven , @tdinteres , @tdamort , @tdflujo , @tdsaldo 

   WHILE @@FETCH_STATUS  = 0
   BEGIN 

   IF @codigo = 20    
      SET @tdfecven = DATEADD( MONTH , @tdcupon * @Peri_cupon, @fecha_ami )


    SET @ntoc = @cant -- numero total de cupones 

-- 8   @campo_26 = fecha vencimiento
   IF @Peri_cupon >= 12 
      SET @sepa = 'A'                 -- @fec_comp se cambio por @fecha_ami 
      SET @contador = @Peri_cupon  -- DATEDIFF(YEAR, @fecha_ami , @tdfecven )    END ELSE 
   IF @Peri_cupon > 1 and @Peri_cupon < 12  BEGIN 
      SET @sepa = 'M'
      SET @contador = @Peri_cupon -- DATEDIFF(MONTH, @fecha_ami , @tdfecven )  
    end else begin 
      SET @sepa = 'D'
      SET @contador = @Peri_cupon -- DATEDIFF(DAY, @fecha_ami , @tdfecven ) 
   END 
--11
    SET @tdamort = (( @tdamort * @nominal)/100)+(( @tdinteres * @nominal ) / 100 ) 

-- 14 
     SET @VCUO =  ROUND( @tdamort + @tdinteres ,0)

-- 15

    IF @tdamort > 0 and @nominal > 0 
      SET @svca =  ROUND( ( @nominal + @tdamort ) / 100,0)
    ELSE 
      SET @svca =  0

-------------------------------------------------------------------------------------------------
      IF @Cuenta <> '0' AND @Cuenta <> ''
      BEGIN
      INSERT #TABLA_INTERFAZ 
         VALUES ('CL' , 'FL15' , '001', @tipoper , RIGHT('00000000000000000000'+ CAST(@nNumdocu AS VARCHAR(5)) + cast(@ncorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5) ) ,20) , @tdfecven,  @vcuo, @svca , @tdinteres )
      END
      
--               1   2       3       4           5         6         7       8         9           10        11          12      13    14       15       16      17
------------------------------------------------------------------------------------------------   

   FETCH NEXT FROM CURSOR_INTERFAZ
   INTO  @tdmascara,@tdcupon,@tdfecven,@tdinteres,@tdamort,@tdflujo,@tdsaldo   
   END  -- fin cursor 
   CLOSE       CURSOR_INTERFAZ
   DEALLOCATE  CURSOR_INTERFAZ

END  -- fin seriado*/
     

------------------------------------------------------------------------------------------------------
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento , @codigo   , @nominal , @tir      , @taspact , @fecvenpact ,
      @moneda    , @seriado     , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla     , @numero      , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper    , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26    , @cuenta_flu ,@valcomu ,@fecha_ami

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA


 SELECT @cont_reg = COUNT(*) FROM #TABLA_INTERFAZ

 SELECT @cont_reg,* FROM  #TABLA_INTERFAZ
END

-- sp_helptext Sp_interfaz_Flujo_Trader
-- sp_helptext Sp_interfaz_Flujo_Vcto_2
-- select * from mdcp


GO

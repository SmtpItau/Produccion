USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_VCTO_2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_VCTO_2]
AS
BEGIN

SET NOCOUNT ON 

DECLARE @VALORX      NUMERIC(19,4),
         @xx15       NUMERIC(19,4),
         @nmone      NUMERIC(3),
         @campo_26   datetime

DECLARE @CCMOR CHAR(3)
DECLARE @CCMON CHAR(2)
DECLARE @c                CHAR (1) ,
        @c1               CHAR (1) ,
        @mascara          CHAR (12) ,
        @instrumento      CHAR (12) ,
        @codigo           NUMERIC (5) ,
        @nominal          NUMERIC (19,4) ,
        @tir              NUMERIC (19,4) ,
        @taspact          NUMERIC (19,4) ,
        @fecvenpact       DATETIME ,
        @moneda           NUMERIC (5) ,
        @seriado          CHAR (1) ,
        @tipoper          CHAR (3) ,
        @valinip          NUMERIC (19,4) ,
        @valvenp          NUMERIC (19,4) ,
        @valcomp          NUMERIC (19,4) ,
        @rutcli           NUMERIC (9) ,
        @codcli           NUMERIC (5) ,
        @rutemi           NUMERIC (9) ,
        @tabla            CHAR (4) ,
        @numero           NUMERIC (9) ,
        @cuenta           CHAR (20) ,
        @tipo_tasa        NUMERIC (1) ,
        @inversion        NUMERIC (5) ,
        @tipo_cuenta      CHAR (2) ,
        @fecha            DATETIME ,
        @fecpro           DATETIME ,
        @periodo          INTEGER  ,
        @fecvenp          DATETIME,
        @cliente          NUMERIC (9) ,
        @estado           NUMERIC (9) ,
        @emtipo           CHAR (5) ,
        @nmes             CHAR (2) ,
        @nmes_a           CHAR (2) ,
        @nano             CHAR (4) ,
        @cano             CHAR (4) ,
        @nNumdocu         NUMERIC (10,0) ,
        @nNumoper         NUMERIC (10,0) ,
        @nCorrela         NUMERIC (03,0)  ,
        @fec_comp         DATETIME , 
        @CTTAS            CHAR (3) ,
        @dias_dife        NUMERIC(4),
        @tran_perm        CHAR (10) ,
        @tirc             NUMERIC(19,4),
        @DIAS             NUMERIC(19),
        @max_fecha        DATETIME,
        @cope             NVARCHAR(20),
        @corr             NUMERIC(2),
        @ntoc             NUMERIC(19) ,--- char(3),   --3
        @sepa             CHAR(1),
        @vcuo             NUMERIC(19,4),
        @svca             NUMERIC(19),
        @tasa             NUMERIC(19,4),
        @rut              CHAR(10),
        @cant             NUMERIC(19),
        @contador         NUMERIC(19),
        @val_presen       NUMERIC(19,4),
        @tdmascara        CHAR(10)       ,
        @tdcupon          NUMERIC (5)    ,
        @tdcupon2         NUMERIC (5)    ,
        @tdamort          NUMERIC (25,10),  --19
        @tdamort2         NUMERIC (19),
        @tdfecven         DATETIME       ,
        @tdinteres        NUMERIC(19,10) ,-- NUMERIC(19,10) ,
        @tdinteres2       NUMERIC(19,10) ,-- NUMERIC(19,10) ,
        @tdflujo          NUMERIC(19,10) ,
        @tdsaldo          NUMERIC(19,10) ,
        @cuenta_flu       CHAR(20),
        @valcomu          NUMERIC(19,4),
        @nsnumdocu        numeric(9),
        @nsfecven         datetime,
        @nsfecemi         datetime,
        @fecha_ami        datetime      ,
        @inte             numeric(19,4) ,
        @valmoneda        numeric(19,4) ,
        @valmoneda_ori    numeric(19,4) ,
        @valmoneda_comp   numeric(19,4) ,
        @valmoneda_dia    numeric(19,4) , 
        @ref              NVARCHAR(20)  ,
        @cont_reg         NUMERIC(19)   ,
        @valorpresente    NUMERIC(25,4) ,--19
        @mas_paso         CHAR (12)     ,
        @Peri_cupon       numeric(19)   ,--numeric(5) ,
        @dfecfmes         datetime      ,
        @dFecFMesProx     datetime      ,
        @acfecprox        datetime      ,
        @fecucup          datetime      ,
        @interes          numeric(19,4)

 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop ,
        @acfecprox = acfecprox
 FROM MDAC

 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

 CREATE TABLE #CARTERA
    (
    mascara              CHAR (12)    ,                                 
    numdocu              NUMERIC (10,0)    ,         --4
    numoper              NUMERIC (10,0)    ,         --4
    corre                NUMERIC (03,0)    ,         --4
    instrumento          CHAR (12)    ,
    codigo               NUMERIC (5)    ,
    nominal              NUMERIC (19,4)    ,
    tir                  NUMERIC (19,4)    ,
    taspact              NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact           DATETIME NULL   ,
    moneda               NUMERIC (5)    ,
    seriado              CHAR (1)    ,
    tipoper              CHAR (3)    ,
    valinip              NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli               NUMERIC (9)    ,
    codcli               NUMERIC (5)    ,
    rutemi               NUMERIC (9)    ,
    tabla                CHAR (4)    ,
    periodo              INTEGER     ,
    fecvenp              DATETIME NULL   ,      --20
    valvenp              NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp              NUMERIC (19,4) NULL DEFAULT (0) ,
    correla              NUMERIC (9) IDENTITY (1,1) ,
    cuenta               CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra         datetime,
    fec_ven              datetime,
    amortizacion         numeric(19,4),
    saldo                numeric(19,4),
    invers               NUMERIC (5) ,
    cttas                char(3),
    dias_dife            numeric(4),    
    tran_perm            CHAR (10) ,
    tirc                 numeric(19,4),
    campo_26             datetime ,                     --- fecha proximo cupon 
    valorpresente        numeric(19,4),
    cuenta2              char(20) ,
    valcomu              numeric(19,4),
    fecha_ami            datetime  ,
    fecucup              datetime  ,                     --- fecha corte cupon     
    interes              numeric(19,4)

  )

-- BORRA LOS DATOS ANTERIORES
DELETE TABLA_INTERFAZ_VCTO WHERE DESCR = 2

  
 INSERT #CARTERA 
 SELECT cpmascara ,
        cpnumdocu ,
        cpnumdocu ,
        cpcorrela ,
        cpinstser ,
        cpcodigo  ,
        cpnominal ,
        cptircomp ,
        0         ,
        ''        ,
        CASE
         WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
	END      ,
        cpseriado ,
        'CP'      ,
        0         ,
        cprutcli  ,
        cpcodcli  ,
        CASE
            WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
            ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END      ,
        'MDCP'   ,
       ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
       cpfecven   ,    --25
       cpnominal  ,
       cpvalcomp  ,  --14
       CtaContable,
       cpfeccomp  ,    --13
       ''         ,
       0          ,
       0          ,
       0          ,
       ''         ,
       datediff(day,@fecpro,cpfecven),
       codigo_carterasuper,
       0                  ,
       cpfecpcup          ,   -- 26
       cpvptirc           ,
       CtaContable        ,
       cpvalcomu          ,
       cpfecemi           ,
       cpfecucup          ,
       cpinteresc
FROM MDCP  ,CARTERA_CUENTA 
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND  RutEmisor <> 97023000
 AND   t_operacion = 'CP'
 AND   NumDocu  = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   CASE WHEN cpcodigo = 20  THEN 'valor_tasa_emision' ELSE 'valor_compra' END  = variable


 INSERT #CARTERA 
 SELECT vimascara ,
        vinumdocu ,  --4
        vinumdocu ,  --4
        vicorrela ,  --4
        viinstser ,   
        vicodigo  ,
        vinominal ,
        vitircomp ,
        0         ,
        vifecvenp ,   --25
        vimonemi  ,
        viseriado ,
        'CP'      ,
        0         ,
        virutcli  ,
        vicodcli  ,
        CASE
            WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END       ,
        'MDCP'    ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
        vifecven  ,
        vinominal ,
        vivalcomp , 
        CtaContable ,
        vifeccomp,--0         ,
        ''        ,
        0         ,
        0         ,
        0         ,
        ''        ,
        datediff(day,@fecpro,vifecvenp),
        codigo_carterasuper,
        0          ,
        vifecvenp  ,  --26
        vivptirc    ,
        CtaContable ,
        vivalcomu   ,
        vifecemi    ,
        vifecucup   ,
        viinteresv
   FROM MDVI,CARTERA_CUENTA
   WHERE -- vitipoper = t_operacion 
     NumDocu       = vinumdocu
     AND Correla   = vicorrela
--   AND NumOper   = vinumoper 
     AND variable  = 'valor_presente'

 INSERT #CARTERA 
 SELECT vimascara ,
        vinumdocu ,
        vinumoper ,
        vicorrela ,
        viinstser ,
        vicodigo  ,
        vinominal ,
        vitircomp ,
        vitaspact ,
        vifecvenp ,    --25
        CASE
            WHEN viseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END       ,
        viseriado ,
        vitipoper ,
        vivalinip ,
        virutcli  ,
        vicodcli  ,
        virutcli  ,
        'MDVI'    ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
        ''        ,
        vivalvenp ,   --26
        vivptirv,--Vivalcomp ,
        CtaContable ,
        vifeccomp,--0         ,

        ''        ,
        0         ,
        0         ,
        0         ,
        ''        ,
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
       vivalvenp   ,
       vifecvenp   ,    --26
       vivptirc    ,
       CtaContable ,
       vivalcomu   ,
       vifecemi    ,
       vifecucup   ,
       viinteresv
 FROM MDVI,CARTERA_CUENTA
 WHERE --vitipoper =t_operacion  AND 
     NumDocu  = vinumdocu
 AND Correla  = vicorrela
 AND NumOper  = vinumoper 
 AND CASE WHEN vicodigo in (4,31,32,33,300,301,888) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 

 
 INSERT #CARTERA
 SELECT cimascara ,                                       -- 1
        cinumdocu ,                                       -- 2
        cinumdocu ,          -- 3
        cicorrela ,                                       -- 4
        ciinstser ,                                       -- 5
        cicodigo  ,                                       -- 6
        cinominal ,                                       -- 7
        citircomp ,                                       -- 8
        citaspact ,      -- 9
        cifecvenp ,  --25                                 -- 10
        cimonpact ,
        ciseriado ,                                       -- 12
        CASE  --13
               WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END       ,
        civalinip ,                                       -- 14
        cirutcli  ,                                       -- 15
        cicodcli  ,                                       -- 16
        CASE                                                -- 17
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
            ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                                                   nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
          ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara = cimascara)
        END)
       END       ,
      'MDCI'     ,                                 --18
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''       ,                                    --19
      civalvenp  ,  --26                                 --20
      civalcomp  ,                                       --21
      ctacontable,                                       --22
      cifeccomp  ,                                       --23
      ''     ,                              --24
      0          ,                                       --25
      0          ,                                       --26
      0          , --27
      ''         ,                                       --28
      datediff(day,@fecpro,cifecvenp),                  --29
      codigo_carterasuper,                               --30  
      0   ,                                       --31
      cifecvenp   ,   --26                                 --32
      civptirci   ,                                       --33
      CtaContable ,                                       --34
      civalcomu   ,                                       --35
      cifecemi    ,                                       --36
      cifecucup   ,                                       --37
      ciinteresci
      --ciinteresc                                          --38
 FROM MDCI,CARTERA_CUENTA
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND variable = 'valor_compra'


delete from #CARTERA where rutemi = 97023000

set @contador = 1

DECLARE CURSOR_CARTERA CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal , tir    , taspact , fecvenpact 
         , moneda     , seriado        , tipoper , valinip , rutcli , codcli  , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'      , periodo, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        , corre   , cuenta  , fecha_compra     , dias_dife 
	 , tran_perm  , campo_26     , cuenta2 , valcomu , fecha_ami        , fecucup  , interes
	 , valorpresente
  FROM #CARTERA

OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento, @codigo    , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @seriado    , @tipoper   , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla     , @numero     , @c         , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper   , @nCorrela  , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26   , @cuenta_flu, @valcomu , @fecha_ami, @fecucup   , @interes    , @val_presen

WHILE @@FETCH_STATUS  = 0
BEGIN 



IF @moneda = 900 OR @moneda = 995 OR @moneda = 13 BEGIN 

 set @valmoneda_dia  = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fecpro ),4),0)
 set @valmoneda_comp = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fec_comp ),4),0)

END ELSE IF @moneda = 999 BEGIN 

 set @valmoneda_dia  = 1
 set @valmoneda_comp = 1
END ELSE BEGIN 

 set @valmoneda_dia  = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecpro ),4),0)
 set @valmoneda_comp = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fec_comp ),4), 0)
end

-- 2
SET @rut = (SELECT TOP 1 RIGHT('000000000'+CONVERT(VARCHAR(9),CLRUT),9) + Cldv FROM view_cliente where Clrut = @rutemi)

-- 3
SET @ref = RIGHT('00000000000000000000'+ CAST(@nNumdocu AS VARCHAR(5)) +  cast(@nNumoper AS VARCHAR(5))+ CAST( @nCorrela AS VARCHAR(2) ) ,20)
-- 5

 IF @seriado ='S' BEGIN
    SET @cant = ISNULL(( SELECT COUNT(*) FROM view_tabla_desarrollo  WHERE  tdmascara = @mascara  ),0)
    	IF @cant = 0 
     	   SELECT @cant = 1
 END
 ELSE BEGIN
    SET @cant = ISNULL(( SELECT COUNT(*) FROM view_noserie  WHERE nsserie = @mascara ),0)
        IF @cant = 0 
	   SELECT @cant = 1
   END  


IF @cant  > 1 begin 
   SET @corr = 1
 END ELSE BEGIN 
   SET @corr = 0
END 


-- 16
   SET @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )

   IF @tabla = 'MDCI' OR @tabla = 'MDVI' begin -- intermediados
      IF DATEDIFF(YEAR, @fec_comp ,@campo_26 ) >= 1  
      BEGIN 
         SET @sepa = 'A'
         SET @contador =  DATEDIFF(YEAR,  @fec_comp ,@campo_26) -- @contador = cada cuanto tiempo 

      END ELSE IF DATEDIFF(MONTH, @fec_comp , @campo_26 ) >= 1 and DATEDIFF(MONTH, @fec_comp ,@campo_26) <= 12 begin  
        SET @sepa = 'M'
        SET @contador = DATEDIFF(MONTH,  @fec_comp ,@campo_26 )
      END 
      ELSE BEGIN  
        SET @sepa = 'D'
        SET @contador = DATEDIFF(DAY, @fec_comp ,@campo_26 )  
      END 
       set @tdamort   = round(@valcomp,0) -- antes @valcomp ojo con este 
       set @vcuo      = round((@valcomp + @interes  ),0)  --valcomp
       set @inte      = ROUND(@vcuo - @tdamort,0)--round((@valcomp+ @interes)- @valcomp ,0)-- ROUND(@vcuo - @tdamort,0)

      
      SET @nToc =  @cant

      SET @rut = (SELECT TOP 1 RIGHT('000000000'+CONVERT(VARCHAR(9),CLRUT),9) + Cldv FROM view_cliente where Clrut = @rutcli)
      INSERT TABLA_INTERFAZ_VCTO
        VALUES (2, @rut , @ref , @cuenta_flu , @corr , @nCorrela , @nToc , @sepa , @contador , @campo_26 ,  @valcomp , @inte , 0  , @vcuo  , @valcomp , @taspact ,  '' ,  2 ) --@tasa
             -- 1   2       3   	4        5         6        7        8         9           10           11        12   13    14       15          16     17   18
   END 
 
/*==============================================================================================*/       
IF @tabla = 'MDCP'
BEGIN   
  IF @seriado = 'N'    -- NO SERIADO
  BEGIN
   set @ntoc = 1
   DECLARE CURSOR_INTERFAZ CURSOR FOR 
   SELECT nsserie ,nscorrela, nsnumdocu ,nsfecven,nsfecemi
       FROM view_noserie 
            WHERE nsserie = @instrumento  and  nsnumdocu = @nNumdocu and nscorrela = @nCorrela and nsfecven > @fecpro 
            ORDER BY nsnumdocu

    OPEN CURSOR_INTERFAZ
    FETCH NEXT FROM CURSOR_INTERFAZ
    INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi   

    WHILE @@FETCH_STATUS  = 0
    BEGIN 

      IF DATEDIFF(YEAR, @fecvenp ,@campo_26 ) >= 1 begin   --or DATEDIFF(YEAR, @fecvenp ,@campo_26 ) = 0 begin 
         SET @sepa = 'A'
         SET @contador =  DATEDIFF(YEAR,  @fecvenp ,@campo_26) -- @contador = cada cuanto tiempo 
         END  
      ELSE IF DATEDIFF(MONTH, @fecvenp ,@campo_26 ) >= 1 and DATEDIFF(MONTH, @fecvenp ,@campo_26) <= 12 begin  
         SET @sepa = 'M'
         SET @contador = DATEDIFF(MONTH,  @fecvenp ,@campo_26 )
 END 
      ELSE IF DATEDIFF(DAY, @fecvenp ,@campo_26) >= 1 AND  DATEDIFF(DAY, @fecvenp ,@campo_26 ) <= 31   BEGIN  
         SET @sepa = 'D'
         SET @contador = DATEDIFF(DAY,@fecvenp ,@campo_26 )  
      END 
     IF @moneda = 999 begin
        set @tdamort =  round(@valcomp,0)                   --round(@valcomp - @interes,0)
        set @vcuo    =  round((@valcomp + @interes  ),0)
        set @inte    =  ROUND(@vcuo - @tdamort,0)           --round(@interes,0) -- @interes

      END ELSE  BEGIN 
        set @valmoneda = round(( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecpro ),4)
        set @tdamort   = round(@valcomp,0) -- antes @valcomp ojo con este 
        set @vcuo      = round((@valcomp + @interes  ),0)  --valcomp
        set @inte      = ROUND(@vcuo - @tdamort,0)

      END 
      INSERT TABLA_INTERFAZ_VCTO 
      VALUES (2, @rut , @ref , @cuenta_flu , @corr , @tdcupon , @ntoc , @sepa , @contador , @nsfecven ,  @tdamort , @inte , 0  , @vcuo  , @valcomp , @tir ,  '' ,  2 ) --@tasa
             -- 1   2     3       4             5         6        7       8         9           10           11        12    13    14       15          16     17   18

 
    FETCH NEXT FROM CURSOR_INTERFAZ
    INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi 
    END 
    CLOSE       CURSOR_INTERFAZ
    DEALLOCATE  CURSOR_INTERFAZ

END
END   -- FIN NO SERIADO
------------------------------------------------------------------------------------------------

IF @tabla = 'MDCP'
BEGIN
IF @SERIADO = 'S' begin    -- SERIADO
	set @tasa = (SELECT DISTINCT setera from view_serie where seserie = @mascara)
	set @Peri_cupon = isnull( (select top 1  sepervcup from view_serie where  semascara = @mascara  ), 0)

   IF @Peri_cupon > 12  begin 
      SET @sepa = 'A'  -- @fec_comp se cambio  por @fecha_ami 
      SET @contador = round(DATEDIFF(MONTH, @campo_26 , @fecucup ),0) --@Peri_cupon  / 12
    end else 
   IF @Peri_cupon >= 1 and @Peri_cupon <= 12  BEGIN 
      SET @sepa = 'M'
      SET @contador = @Peri_cupon  
    END ELSE BEGIN 
      SET @sepa = 'D'
      SET @contador = @Peri_cupon
   END 

   DECLARE CURSOR_INTERFAZ CURSOR FOR 
   SELECT tdmascara , tdcupon , tdfecven , tdinteres , tdamort , tdflujo , tdsaldo 
   FROM view_tabla_desarrollo  
      WHERE tdmascara = @mascara 
             and (CASE WHEN @codigo = 20 THEN DATEADD( MONTH, tdcupon * @Peri_cupon , @fecha_ami )  
                  ELSE tdfecven END ) > @fecpro 

   OPEN CURSOR_INTERFAZ
   FETCH NEXT FROM CURSOR_INTERFAZ
   INTO  @tdmascara , @tdcupon , @tdfecven , @tdinteres , @tdamort , @tdflujo , @tdsaldo 

   WHILE @@FETCH_STATUS  = 0
   BEGIN 
   IF @codigo = 20    BEGIN
     SET @tdfecven = DATEADD( MONTH , @tdcupon * @Peri_cupon, @fecha_ami )
  END 

    SET @nToc =  @cant -- numero total de cupones 
    SET @svca       = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * @valmoneda_comp ) , 0 ) , 0 )
    SET @tdamort2   = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * @valmoneda_dia ) , 0 ) , 0 )

    SET @tdinteres2 = ROUND ((( @tdinteres / 100 ) * @NOMINAL * @valmoneda_dia  ) ,0 )
    SET @VCUO       = ISNULL( ROUND( @tdamort2 + @tdinteres2 ,0) , 0 )

-------------------------------------------------------------------------------------------------
      INSERT TABLA_INTERFAZ_VCTO 
         VALUES (2, @rut , @ref , @cuenta_flu , @corr , @tdcupon , @ntoc , @sepa , @contador , @tdfecven, @tdamort2 , @tdinteres2 , 0   , @vcuo , @svca  ,  @tasa ,  ''   , 2 )
--               1   2       3       4           5         6         7       8         9           10        11           12       13      14       15       16     17     18

------------------------------------------------------------------------------------------------   

   FETCH NEXT FROM CURSOR_INTERFAZ
   INTO  @tdmascara,@tdcupon,@tdfecven,@tdinteres,@tdamort,@tdflujo,@tdsaldo   
END  -- fin cursor 
   CLOSE       CURSOR_INTERFAZ
   DEALLOCATE  CURSOR_INTERFAZ

END
END  -- fin seriado
------------------------------------------------------------------------------------------------------
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento , @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @seriado     , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla     , @numero      , @c       , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper    , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26    , @cuenta_flu ,@valcomu ,@fecha_ami, @fecucup   , @interes  , 
      @val_presen

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA

 SELECT @valorpresente  =  sum(SVCA)  FROM  TABLA_INTERFAZ_VCTO
 SELECT @cont_reg = COUNT(*) FROM TABLA_INTERFAZ_VCTO
 SELECT *,@cont_reg,@valorpresente FROM  TABLA_INTERFAZ_VCTO
 
END

-- delete TABLA_INTERFAZ_VCTO
-- delete TABLA_INTERFAZ
-- SELECT * FROM TABLA_INTERFAZ_VCTO WHERE NTOC <> 1


--SELECT * FROM MDVI


GO

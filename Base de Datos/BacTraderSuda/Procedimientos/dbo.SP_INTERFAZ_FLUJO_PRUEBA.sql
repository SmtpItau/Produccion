USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_PRUEBA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_PRUEBA]
AS
BEGIN
 SET NOCOUNT ON
DECLARE  @VALORX       numeric(19,4)    ,
         @xx15         numeric(19,4)    ,
         @nmone        numeric(3)       ,
         @campo_26     datetime         ,
         @xproducto    numeric(10)      ,
         @nncup        numeric(5)       ,
         @nintel       numeric(19,4)    ,
         @reajustes    numeric(19,4)    ,
         @cuentaI      char (20)        ,
         @cuentaR      char (20)        ,
         @cod_instru   numeric(3)       ,
         @valor_compra numeric(19,4)     ,
         @valor_compra_X numeric(19,4)   ,
         @vDolar_obs   numeric(19,4)     ,
         @nvori        numeric(19,4)     ,
         @barra        numeric(19)       ,
         @tip_tasa         CHAR(3),
         @inst_variable CHAR(1)
DECLARE @XX CHAR(3)
DECLARE @crut numeric(9), @DIG CHAR(1)
DECLARE @ccmor CHAR(3),
        @CCMON CHAR(2)

DECLARE @c           CHAR (1)   ,
        @c1          CHAR (1)   ,
        @mascara     CHAR (12)  ,
        @instrumento CHAR (12)  ,
        @codigo  NUMERIC (5)    ,
        @nominal NUMERIC (19,4) ,
        @tir  NUMERIC (19,4)    ,
        @taspact NUMERIC (19,4) ,
        @fecvenpact DATETIME    ,
        @moneda  NUMERIC (5)    ,
        @seriado CHAR (1)       ,
        @tipoper CHAR (3)       ,
        @valinip NUMERIC (19,4) ,
        @valvenp NUMERIC (19,4) ,
        @valcomp NUMERIC (19,4) ,
        @valcomp2 NUMERIC (19,4),
        @rutcli  NUMERIC (9)    ,
        @codcli  NUMERIC (5)    ,
        @rutemi  NUMERIC (9)    ,
        @tabla  CHAR (4)        ,
        @numero  NUMERIC (9)    ,
        @cuenta  CHAR (20)      ,
        @tipo_tasa NUMERIC (1)  ,
        @tdfecven DATETIME      ,
        @tdamort NUMERIC (19,4) ,
        @tdsaldo NUMERIC (19,4) ,
        @inversion NUMERIC (5) ,
        @tipo_cuenta CHAR (2) ,
        @fecha  DATETIME ,
        @fecpro  DATETIME ,
        @periodo  INTEGER  ,
        @tdcupon char(3) ,  --NUMERIC
        @fecvenp DATETIME,
        @cliente NUMERIC (9) ,
        @estado  NUMERIC (9) ,
        @emtipo  CHAR (5) ,
        @nmes   CHAR (2) ,
        @nmes_a  CHAR (2) ,
        @nano   CHAR (4) ,
        @cano   CHAR (4) ,
        @nNumdocu NUMERIC (10,0) ,
        @nNumoper NUMERIC (10,0) ,
        @nCorrela NUMERIC (03,0)  ,
        @fec_comp datetime , 
        @CTTAS   CHAR (3) ,
        @dias_dife NUMERIC(4),
        @tran_perm CHAR (10) ,
        @tirc      NUMERIC(19,4),
        @DIAS      NUMERIC(19),
        @sum_capi NUMERIC(15),
        @nIntasb      numeric(5),
        @nIncodigo    numeric(5),
        @tasa         numeric(19,4),
        @dfecfmes   datetime       ,
        @dFecFMesProx  datetime ,
        @acfecprox datetime ,
        @fecha_emi datetime ,
        @fec_ven datetime ,
        @valpres   NUMERIC (19,4)

 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop ,
        @acfecprox = acfecprox
 FROM MDAC
 set @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fecpro),0)
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'

 delete TABLA_INTERFAZ where descr = 2

---------------------------------------------------------------------------------------------
-- select * from view_moneda
---------------------------------------------------------------------------------------------
 
 CREATE TABLE #CARTERA
    (
    mascara     CHAR (12)    ,                             --  1    
    numdocu     NUMERIC (10,0)    ,         --4                2
    numoper     NUMERIC (10,0)    ,         --4                3
    corre       NUMERIC (03,0)    ,         --4                4
    instrumento CHAR (12)    ,                           --    5
    codigo      NUMERIC (5)    ,              --    6
    nominal     NUMERIC (19,4)    ,                      --    7
    tir         NUMERIC (19,4)    ,                      --    8
    taspact     NUMERIC (19,4) NULL DEFAULT (0) ,        --    9
    fecvenpact  DATETIME NULL   ,                        --   10
    moneda      NUMERIC (5)    ,                         --   11
    seriado     CHAR (1)    ,                            --   12
    tipoper     CHAR (3)    ,                            --   13
    valinip     NUMERIC (19,4) NULL DEFAULT (0) ,        --   14
    rutcli      NUMERIC (9)    ,                         --   15
    codcli      NUMERIC (5)    ,                         --   16
    rutemi      NUMERIC (9)    ,                         --   17
    tabla       CHAR (4)    ,                            --   18
    periodo     INTEGER     ,                            --   19
    fecvenp     DATETIME NULL   ,                        --   20
    valvenp     NUMERIC (19,4) NULL DEFAULT (0) ,        --   21
    valpres       NUMERIC (19,4) NULL DEFAULT (0) ,      --   22
    cuenta     CHAR(20) NULL DEFAULT ('')  ,             --   23
    fecha_compra datetime,                               --   24
    fec_ven      datetime,                               --   25
    amortizacion numeric(19,4),                          --   26
    saldo        numeric(19,4),                          --   27
    invers       NUMERIC (5) ,                           --   28
    cttas        char(3),                                --   29
    dias_dife    numeric(6),                             --   30
    tran_perm    CHAR (10) ,                             --   31 
    tirc         numeric(19,4),                          --   32 
    campo_26     datetime     ,                          --   33  
    interes      numeric(19,4),                          --   34
    reajustes    numeric(19,4),                          --   35
    fecha_emi    datetime,                               --   36
    valcomp     NUMERIC (19,4) NULL DEFAULT (0) ,        --   37
    correla     NUMERIC (9) IDENTITY (1,1)              --    38
  )
---------------------------------------------------------------------------------------------
 INSERT #CARTERA 
 SELECT cpmascara ,
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
   WHEN cpseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END  ,
        cpseriado ,
        'CP'  ,
        0  ,
        cprutcli ,
        cpcodcli ,
        CASE
            WHEN cpseriado='N' THEN isnull((SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE (SELECT top 1 serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END  ,
        'MDCP'  ,
       ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
       cpfecven ,    --25
       cpnominal ,
       cpvptirc , 
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
       cpfecpcup  ,   
       cpinteresc ,
       cpreajustc ,
       cpfecemi ,
       cpvalcomp
 FROM MDCP  ,CARTERA_CUENTA 
 WHERE cpnominal   > 0 AND cprutcart > 0 AND   
      t_operacion = 'CP'
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu
 AND   variable    = 'valor_compra'


/* INSERT #CARTERA 
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
        vimonemi ,    --vimonpact
        viseriado ,
        'CP'  ,
        0  ,
        virutcli ,
        vicodcli ,
        CASE
            WHEN viseriado='N' THEN (SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
        'MDCP'  ,
        ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
        vifecven ,
        vinominal ,
        vivptirv , --vivalcomp , vivptirc
        CtaContable ,
        vifeccomp, --0,
        '',
        0,
        0,
        0,
        '',
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
        0,
        vifecvenp  , --26
        viinteresv ,
        vireajustv  ,
        vifecemi,
        vivalcomp
   FROM MDVI,CARTERA_CUENTA 
   WHERE  vitipoper = t_operacion     
    AND NumDocu  >10000000
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'


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
            WHEN viseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
      END  ,
        viseriado ,
        vitipoper ,
        vivalinip ,
        virutcli ,
        vicodcli ,
       CASE
         WHEN viseriado='N' THEN (SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT top 1 serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
        'MDVI'  ,
        ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
        vifecven ,--''  ,
        vivptirc ,--vivalvenp ,   --26
        vivptirV , --vivalcomp , 
        CtaContable ,
        vifeccomp, --0,
       '',
        0,
        0,
        0,
        '',
       datediff(day,@fecpro,vifecvenp),  
       codigo_carterasuper,
       vivalvenp,    --27
       vifecvenp ,   --26
       viinteresvi,
       vireajustvi ,
       vifecinip   , 
       vivalcomp
 FROM MDVI , CARTERA_CUENTA 
 WHERE 
     NumDocu  > 1000000
     AND Correla  = vicorrela
     AND NumOper  = vinumoper 
     AND CASE WHEN vicodigo in (4,31,300,301,888) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 


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
        cifecvenp , 
        CASE
         WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cimonpact
         ELSE (CASE WHEN ciseriado='N' THEN isnull((SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
          ELSE isnull((SELECT top 1 semonemi FROM VIEW_SERIE WHERE semascara=cimascara),0)
              END)
        END  , 
        ciseriado ,
        CASE
               WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END  ,
        civalinip ,
        cirutcli ,
        cicodcli ,
        CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
            ELSE (CASE WHEN ciseriado='N' THEN (SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                                                       nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
          ELSE (SELECT top 1 serutemi FROM VIEW_SERIE WHERE semascara=substring(cimascara,1,6))---substring(ciinstser,1,6)
       END)
       END  ,
      'MDCI'  ,
        ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
      cifecvenp, 
      civalvenp ,
      civptirc ,
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
      cifecvenp ,
      ciinteresc,
      cireajustc ,
      cifecemi   ,
      civalcomp
 FROM MDCI,CARTERA_CUENTA 
 WHERE t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu       > 1000000
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'*/


DECLARE CURSOR_INTER CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal  , tir          , taspact , fecvenpact 
         , moneda     , seriado        , tipoper , valinip  , rutcli       , codcli  , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'       , periodo      , fecvenp , valvenp , valpres -- valcomp          
         , numdocu    , numoper        , corre   , cuenta   , fecha_compra , dias_dife 
         , tran_perm  , campo_26       , interes , reajustes, fecha_emi    , fec_ven , valcomp
  FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal   , @tir       , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip   , @rutcli    , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo   , @fecvenp   , @valvenp   , @valpres ,  
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta    , @fec_comp  , @dias_dife ,
      @tran_perm , @campo_26  , @nintel  , @reajustes , @fecha_emi , @fec_ven   ,@valcomp
WHILE @@FETCH_STATUS  = 0
BEGIN 

-- dbo.Sp_interfaz_Flujo_prueba

if @tipoper ='CP'
     SET  @crut =   @rutemi     
   else  
      SET @crut =   @rutcli

  SELECT @DIG = Cldv FROM VIEW_CLIENTE WHERE Clrut = @crut    

select @nNumdocu,@nCorrela,@cuenta
-- select cta_sbif,* from view_plan_de_cuenta where cuenta = 25684
-- update view_plan_de_cuenta set cta_sbif = 1705 where cuenta = 25684


  set @xproducto = isnull(( select cta_sbif from view_plan_de_cuenta where cuenta = @cuenta), 0 )

  SELECT @emtipo =  emtipo FROM VIEW_EMISOR WHERE emrut = @rutemi

  IF @codigo = 15
  BEGIN
      if @rutemi = @estado begin 
         set @cod_instru= 440     --10
         set @inversion = 21402   --47
      end 
      if @emtipo = '1'  begin 
         set @cod_instru= 440
         set @inversion =  22104
      end 

      if @rutemi = 306 and @moneda = 900 begin 
         set @cod_instru = 460
         set @inversion  = 30001
      end 
      if @rutemi = 1500000 and @moneda = 900 begin 
         set @cod_instru= 460
         set @inversion  = 30001
      end 
      if @rutemi = 3 and @moneda = 900  begin 
         set @cod_instru= 460
         set @inversion  = 11199
        end  else begin 
          set @cod_instru= 460
         set @inversion  = 12001
                                                  
      END
     
  END 

  IF @codigo = 14  and @moneda = 142 BEGIN 
        SET @cod_instru = 460
        SET @inversion  = 30002 
  END 

  IF @codigo = 13 and @moneda = 900 BEGIN 
        SET @cod_instru = 460
        SET @inversion  = 30002 
  END
 
  IF @codigo = 33 or @codigo = 34 or @codigo = 35 BEGIN  -- Bonos BC del BCCH
      SET @cod_instru   = 460  

      IF @moneda = 998
        SET @inversion  = 21126 

      IF @moneda = 999
        SET @inversion  = 21125

      IF @moneda = 994
        SET @inversion  = 21127
  END 

 IF @codigo = 20 or @codigo = 21 or @codigo = 22 or @codigo = 23 BEGIN 
    IF @rutemi = @cliente BEGIN 
        SET @cod_instru = 460
        SET @inversion  = 22101
    END

    IF @rutemi = @estado BEGIN 
       SET @cod_instru = 440
       SET @inversion  = 21401
    END ELSE BEGIN 
          SET @cod_instru = 440
          SET @inversion  = 22103
    END 

 END ELSE BEGIN 

  if @codigo = 31  BEGIN 
     SET @cod_instru = 460
     SET @inversion   = 21122
  end 

  IF @codigo = 888  BEGIN 
     SET @cod_instru = 410
     SET @inversion   = 11109
  END 

  IF @codigo = 4  BEGIN 
     SET @cod_instru = 410
     SET @inversion   = 21110
  END 

 END  

  if @tran_perm = 'T'  
      set @xx = 'INV'
    else 
      set @xx = 'PER'

  SET @NVORI = @valpres


 IF @moneda = 999  or @moneda = 998
   SET @valorx = isnull((select vmvalor  from view_valor_moneda    
                                       where vmfecha = @fec_comp and vmcodigo = @moneda),0)

ELSE
   SET @valorX =isnull((select vmvalor from view_valor_moneda 
                                       where vmcodigo = 994 and vmfecha = @fecpro ),0)


  if @moneda = 13
      set @ccmon = '11'
      else 
      set @ccmon = '00'


   if @moneda =  999 
      set @ccmor =  '00'
   if @moneda = 998 
      if @codigo = 888 or @codigo = 889
       set @ccmor = '09'
       else 

      if @moneda <> 999  
          set @ccmor = '11'
        else
          set @ccmor = '09'


   if @moneda = 997 
       set @ccmor = '08'

   if @moneda = 900 or @moneda = 994 or @moneda = 995 or @moneda = 13 or @moneda = 14 or @moneda = 142
       set @ccmor = '11'


 if @tipoper = 'CP'
          if @moneda <> 999  
             set @nmone = 994
           else 
            if substring(@mascara,1,2) = 'BR' or substring(@mascara,1,3) = 'CBR'
              set @nmone = 999
             else 
              set @nmone = @moneda

      if @tipoper = 'CI'
          set @nmone = @moneda  

      if @tipoper = 'VI' 
         if substring(@mascara,1,2) = 'BR' or substring(@mascara,1,3) = 'CBR'
             set @nmone = 995
            else
             set @nmone = @moneda 

      if @tipoper = 'IB' and (@moneda = 900 or @moneda = 995 )
          set @nmone = 994


   set @dias = @dias_dife

   set @nIntasb   = ( select intasest from mdin  where incodigo  =  @codigo  ) 

   set @inst_variable  = 'N'
   set @tip_tasa       = '0'
 
   IF @nIntasb > 0  BEGIN 

     IF ( @codigo > 800 and @codigo < 900 ) BEGIN 
      SET @inst_variable = 'S' 
      SET @tip_tasa = CASE WHEN SUBSTRING(@MASCARA,1,3) = 'PCD' OR SUBSTRING(@MASCARA,1,3) ='PTF' THEN 
                              '2' 
                          WHEN  SUBSTRING(@MASCARA,1,8) = 'BCAPS-A1'  THEN
                              '3'
                          ELSE 
                              '9'
                     END
      
    END 
  END   

   IF @inst_variable= 'N'      -- fija  --N
     BEGIN 
      if @dias < 30 
         set @tip_tasa =  '101' 
      if @dias >= 30 and @dias < 89   
         set @tip_tasa =  '102' 
      if @dias >= 90 and  @dias < 179 
         set @tip_tasa =  '103'
       if @dias >= 180  and  @dias < 365  
         set @tip_tasa =  '104'            
      if @dias >= 365 and  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS
         set @tip_tasa =  '105' 
      if @dias >= 1095                    -- MAS DE TRES AÑOS 
         set @tip_tasa =  '106'
      END 

    ELSE IF @inst_variable = 'S' BEGIN   -- S

      if datediff(day,@fecpro, @campo_26 ) < 30         -- cpfecpcup
         set @tip_tasa = '2' + @tip_tasa + '1'

      if datediff(day,@fecpro, @campo_26 ) >= 30 and  datediff(day,@fecpro,@campo_26)< 89
         set @tip_tasa = '2' + @tip_tasa + '2'

      if datediff(day,@fecpro,@campo_26) >= 90 and  datediff(month,@fecpro,@campo_26) < 6
         set @tip_tasa = '2' + @tip_tasa + '3'

      if datediff(month,@fecpro,@fecvenp) >= 6  and  datediff(year,@fecpro,@campo_26) < 1
         set @tip_tasa = '2' + @tip_tasa + '4'

      if datediff(year,@fecpro,@campo_26) >= 1  and  datediff(year,@fecpro,@campo_26) < 3
         set @tip_tasa = '2' + @tip_tasa + '5'

      if datediff(year,@fecpro,@campo_26) >= 3  
         set @tip_tasa = '2'  + @tip_tasa + '6'
       end 

   IF SUBSTRING(@MASCARA,1,3) = 'PCD' OR SUBSTRING(@MASCARA,1,3) ='PTF' BEGIN 
      SET @CTTAS = 'FLO' END ELSE 
   IF SUBSTRING(@MASCARA,1,8) = 'BCAPS-A1' BEGIN 
      SET @CTTAS = 'VAR' END 
   ELSE 
      SET @CTTAS = 'FIJ'

IF @tabla  = 'MDCP' BEGIN 
IF @tipoper  = 'CP'
  IF @moneda <> 999  begin

    SET @valor_compra = @valcomp * @vDolar_obs 
   END 
  ELSE begin
    SET @valor_compra= @valcomp --ISNULL((SELECT CPVALCOMP FROM MDCP WHERE cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
  END
END

IF @tabla  = 'MDCI' BEGIN 
  
   IF @tipoper ='ICOL' or @tipoper = 'ICAP'
       SET @valor_compra = @valpres
   ELSE
       SET @valor_compra = @valvenp   
END

IF @tabla  = 'MDVI' BEGIN 

      SET @valor_compra = @valcomp
END

  IF @seriado='S'-- AND @tipoper='CP'
      set @tdcupon = isnull((SELECT count(*) FROM view_tabla_desarrollo WHERE tdmascara = @mascara ),0)
   else
   set @tdcupon =isnull((SELECT count(*)FROM view_noserie 
            WHERE nsserie = @instrumento  and  nsnumdocu = @nNumdocu and nscorrela = @nCorrela and nsfecven > @fecpro ),0)

  IF @tipoper ='ICOL' or @tipoper = 'ICAP'
      SET @nncup = 1 
  ELSE IF @SERIADO = 'S'
        SET @nncup = ISNULL((SELECT TOP 1 tdcupon FROM view_tabla_desarrollo WHERE tdmascara = @mascara 
                                     and (CASE WHEN @codigo = 20 THEN DATEADD( MONTH, tdcupon * @periodo , @fecha_emi ) 
                                      ELSE tdfecven END ) >= @fecpro ),0)
  ELSE IF @SERIADO = 'N'
        SET @nncup = isnull((SELECT TOP 1 nscorrela FROM view_noserie 
                      WHERE nsserie = @instrumento  and  nsnumdocu = @nNumdocu 
                      and nscorrela = @nCorrela     and  nsfecven >= @fecpro ),0)



   SET @cuentaI = isnull(( SELECT top 1 CtaContable from cartera_cuenta where NumDocu = @nNumdocu and Correla = @nCorrela and Variable = 'Interes_papel' ),'00000')

   SET @cuentaR = isnull((select top 1 CtaContable from cartera_cuenta where NumDocu = @nNumdocu and Correla = @nCorrela and Variable  = 'Reajuste_papel' ),'00000')

   SET @dfecfmes = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )

   IF EXISTS(SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and  fecha_proceso =  @dFecFMesProx ) BEGIN
      SET @tasa =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and Fecha_proceso = @dFecFMesProx ),0.0)

   END  ELSE IF EXISTS(SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and  fecha_proceso =  @dfecfmes ) BEGIN
      SET @tasa =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = @mascara and Fecha_proceso = @dfecfmes ),0.0)
    END  ELSE BEGIN  -- sino tasa compra 
      SET @tasa      =  @tir
    END 


-------- aquui


 
INSERT TABLA_INTERFAZ VALUES (2, right('000000000'+convert(varchar(9),@crut),9) + @DIG , RIGHT('00000000000000000000'+CAST(@nNumdocu AS VARCHAR(5)) + cast(@nNumoper AS VARCHAR(5)) + CAST(@nCorrela AS VARCHAR(2)) ,20)
                           --    4         5           6        7           8         9
                              ,@cuenta   ,@xproducto,'000'   , '00'       ,'0'     ,'1735'
                              -- 10           11        12        13           14       15
                              , @cod_instru , @XX     ,'00'    , @fec_comp  , @nvori  ,  0 
                              -- 16          17        18       19               20       21      
                              ,@valorX   , @ccmon   ,@ccmor   , @nmone     , @tip_tasa  ,@tir  
                            --  22           23          24         25      
                              ,@CTTAS    , @tasa    , '000000' , @fecvenp   
                           --    26         27                 28        29             30
                              , @campo_26 , @valor_compra   , '000'   , @dias_dife  , '000'   
                           --      31              32   33    34       35     36     37      
                              ,'0000000000000000','00','PCT','00047','00047', '' , '00000'
                          --     38           39         40      41         42        43         44  
                              , @fec_comp , @tdcupon , @nncup , @cuentaI , @nintel , @cuentaR , @reajustes
                           --  45    46      47            48
                             ,'S' , 'S' , @inversion    ,   2 
                              )
 
FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp  , @valvenp   , @valpres    , --@valcomp    ,
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm ,@campo_26  , @nintel   , @reajustes ,@fecha_emi ,@fec_ven  , @valcomp
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

set @valcomp2  = ( select SUM(valcomp) FROM #cartera        )
set @sum_capi  = ( select SUM(ncapoi)  FROM TABLA_INTERFAZ )
set @barra     = ( select count(*)     FROM TABLA_INTERFAZ )

SELECT *,'barra' = @barra,@valcomp2,@sum_capi FROM  TABLA_INTERFAZ where descr=  2

END


GO

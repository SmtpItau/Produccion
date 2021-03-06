USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_VCTO_WILL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_VCTO_WILL]
AS
BEGIN
 SET NOCOUNT ON
DECLARE @VALORX NUMERIC(19,4),
         @xx15 NUMERIC(19,4),
         @nmone NUMERIC(3),
         @campo_26 datetime
declare @ccmor CHAR(3)
DECLARE @CCMON CHAR(2)
 DECLARE @c  CHAR (1) ,
        @c1  CHAR (1) ,
        @mascara  CHAR (12) ,
        @instrumento CHAR (12) ,
        @codigo  NUMERIC (5) ,
        @nominal NUMERIC (19,4) ,
        @tir  NUMERIC (19,4) ,
        @taspact NUMERIC (19,4) ,
        @fecvenpact DATETIME ,
        @moneda  NUMERIC (5) ,
        @seriado CHAR (1) ,
        @tipoper CHAR (3) ,
        @valinip NUMERIC (19,4) ,
        @valvenp NUMERIC (19,4) ,
        @valcomp NUMERIC (19,4) ,
        @rutcli  NUMERIC (9) ,
        @codcli  NUMERIC (5) ,
        @rutemi  NUMERIC (9) ,
        @tabla  CHAR (4) ,
        @numero  NUMERIC (9) ,
        @cuenta  CHAR (20) ,
        @tipo_tasa NUMERIC (1) ,
        @tdfecven DATETIME ,
        @tdamort NUMERIC (19,4) ,
        @tdsaldo NUMERIC (19,4) ,
        @inversion NUMERIC (5) ,
        @tipo_cuenta CHAR (2) ,
        @fecha  DATETIME ,
        @fecpro  DATETIME ,
        @periodo  INTEGER  ,
        @tdcupon NUMERIC (5) ,
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
        @DIAS      NUMERIC(19)
 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop
 FROM MDAC
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
 
 CREATE TABLE #CARTERA
    (
    mascara     CHAR (12)    ,                                 
    numdocu     NUMERIC (10,0)    ,         --4
    numoper     NUMERIC (10,0)    ,         --4
    corre       NUMERIC (03,0)    ,         --4
    instrumento CHAR (12)    ,
    codigo      NUMERIC (5)    ,
    nominal     NUMERIC (19,4)    ,
    tir         NUMERIC (19,4)    ,
    taspact     NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact  DATETIME NULL   ,
    moneda      NUMERIC (5)    ,
    seriado     CHAR (1)    ,
    tipoper     CHAR (3)    ,
    valinip     NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli      NUMERIC (9)    ,
    codcli      NUMERIC (5)    ,
    rutemi      NUMERIC (9)    ,
    tabla       CHAR (4)    ,
    periodo     INTEGER     ,
    fecvenp     DATETIME NULL   ,      
    valvenp     NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp     NUMERIC (19,4) NULL DEFAULT (0) ,
    correla     NUMERIC (9) IDENTITY (1,1) ,
    cuenta     CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra datetime,
    fec_ven      datetime,
    amortizacion numeric(19,4),
    saldo        numeric(19,4),
    invers       NUMERIC (5) ,
    cttas        char(3),
    dias_dife    numeric(4),    
    tran_perm    CHAR (10) ,
    tirc         numeric(19,4),
    campo_26     datetime 
  )
---------------------------------------------------------------------------------------------
CREATE TABLE #TABLA_INTERFAZ
      (
          CREG    NUMERIC(1)                             --  1
         ,CRUT    NUMERIC(9)                             --  2
         ,CREF    CHAR(23)                               --  3
         ,NCOPE   char(20)                               --  4
         ,NCSUP   NUMERIC(4)                             --  5 FALTA
         ,NCTAS   CHAR(3)                                --  6
         ,NSCTA   CHAR(2)                                --  7
         ,NCALI   CHAR(1)                                --  8
         ,NTIPC   CHAR(4)                                --  9
         ,NCPRO   NUMERIC(5)                             -- 10
         ,CTCAR   CHAR(3)                                -- 11
         ,NTCRE   CHAR(2)                                -- 12
         ,DFOTO   DATETIME                               -- 13
         ,NVORI   NUMERIC(19,4)                          -- 14
         ,NCUPO   NUMERIC(15)                            -- 15
         ,NVATC   NUMERIC(19,4)                          -- 16
         ,CCMON   char(2)                                -- 17
         ,CCMOR   char(3)                                -- 18
         ,NMONE   NUMERIC(3)                             -- 19
         ,NBASE   NUMERIC(3)                             -- 20
         ,NTASA1  NUMERIC(19,4)                          -- 21
         ,CTTAS   CHAR(3)                                -- 22
         ,NTCOM   CHAR(6)                                -- 23
         ,NTCOF   CHAR(6)                                -- 24
         ,DFEXT   DATETIME                               -- 25
         ,DFVEN   DATETIME                               -- 26
         ,NCAPOI  NUMERIC(15)                            -- 27
         ,NPCRB   CHAR(3)                                -- 28
         ,NPZOP   NUMERIC(4)                             -- 29
         ,NNCUA   CHAR(3)                                -- 30
         ,NMCUA   CHAR(16)                               -- 31
         ,NMATR   CHAR(2)                                -- 32
         ,NISIS   CHAR(3)                                -- 33
         ,NOFIO   CHAR(5)                                -- 34
         ,NOFCO   CHAR(5)                                -- 35
         ,NCEJE   CHAR(3)                                -- 36
         ,NCCOS   CHAR(5)                                -- 37
         ,DFTAS   DATETIME                               -- 38
         ,NNTO1   NUMERIC(19)                            -- 39
         ,NNCUP   CHAR(3)                                -- 40
         ,NCOPI   CHAR(5)                                -- 41
         ,NINTEL  CHAR(15)                               -- 42
         ,NCOPR   CHAR(5)                                -- 43
         ,NREAJ   CHAR(15)                               -- 44
         ,CCJUD   CHAR(1)                                -- 45
         ,CINFO   CHAR(1)                                -- 46
         ,CRELL   CHAR(15)                               -- 47
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
         WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END  ,
        cpseriado ,
        'CP'  ,
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
       cpfecpcup    -- 26
      
 FROM MDCP  ,CARTERA_CUENTA 
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = 'CP'
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   variable    = 'valor_compra'
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
        'CP'  ,
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
        vifecvenp   --26
   FROM MDVI,CARTERA_CUENTA
 WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
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
            WHEN viseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END  ,
        viseriado ,
        vitipoper ,
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
       vifecvenp    --26
       
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND NumDocu  = vinumdocu
 AND Correla  = vicorrela
 AND NumOper  = vinumoper 
 AND variable = 'valor_compra'
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
        CASE
               WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END  ,
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
      cifecvenp    --26
 FROM MDCI,CARTERA_CUENTA
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND variable = 'valor_compra'
 
  
DECLARE CURSOR_INTER CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal , tir    , taspact , fecvenpact 
         , moneda     , seriado        , tipoper , valinip , rutcli , codcli  , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'      , periodo, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        , corre   , cuenta  , fecha_compra , dias_dife 
         , tran_perm  , campo_26
  FROM #CARTERA
OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm ,@campo_26
WHILE @@FETCH_STATUS  = 0
BEGIN 
--anexo uno   10
   SELECT @emtipo =  emtipo FROM VIEW_EMISOR WHERE emrut=@rutemi
  IF @codigo = 15
  BEGIN
   SELECT @inversion = (CASE @rutemi WHEN @cliente THEN 21402 ELSE   -- 22102
                       (CASE @emtipo WHEN '1'      THEN 22104 ELSE   --'11110'
                       (CASE @rutemi WHEN @estado  THEN 30001 ELSE
                       (CASE @emtipo WHEN '2'      THEN 11199 ELSE 12001 END) END) END)
                        END)
  END
  ELSE  BEGIN
  IF @codigo = 14  and @moneda = 142
     SELECT @inversion = 30002
  IF @codigo = 13 and @moneda = 900
     SELECT @inversion = 30002
  IF @codigo = 20 or @codigo = 21 or @codigo =22 or @codigo = 23
     SELECT @inversion = (CASE @rutemi WHEN @estado THEN 22101 ELSE  
                                        (CASE @rutemi WHEN @cliente THEN 21401 
                                              ELSE 22103
                                         END)
                          END )
  END  
-- 11 
DECLARE @XX CHAR(3)
  if @tran_perm = 'T'  
      set @xx = 'INV'
    else 
      set @xx = 'PER'
-- 14
  if @tabla = 'MDVI'
      set @tirc = isnull((select vivalvenp from mdvi where vinumoper = @nNumoper      
                                                    and vicorrela =  @nCorrela),0)
  if @tabla ='MDCP' and @moneda <> 13 
      set @tirc   = isnull((select cpvalcomp from mdcp where cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
  if @tabla = 'MDCP'  and @moneda = 13
      set @tirc   = isnull((select cpvptirc from mdcp where cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
  if @tipoper <> 'IB' and @tabla = 'MDCI'
      set @tirc = isnull((select civalvenp from mdci where cinumdocu = @nNumoper      
                                                    and cicorrela =  @nCorrela),0)
  if @tipoper = 'IB' and @tabla = 'MDCI'
      set @tirc = isnull((select civalcomu from mdci  where cinumdocu = @nNumoper      
                                                     and cicorrela =  @nCorrela),0)
     
-- 15 tiene valor vi en la tabla
 if @tabla = 'MDCP' 
   if (select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper ) = 0
     set @xx15 = isnull((select cpvptirc from mdcp where  cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
    else 
     set @xx15 = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper ),0) 
   
 if @tabla = 'MDCI' 
   if isnull((select mmvalor from mdmm where mmnumdocu = @nNumdocu and mmnumoper = @nNumoper AND mmcorrela = @NCORRELA),0) = 0
     set @xx15 = isnull((select civptirci from mdci where  CinumDOCU = @nNumoper
                                                      and Cicorrela =  @nCorrela),0)
     else 
     set @xx15 = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper and mmcorrela = @ncorrela ),0)   
 if @tabla = 'MDVI' 
     set @xx15 = isnull( (select vivptirci from mdvi where vinumdocu =@nNumdocu  and vicorrela = @ncorrela ),0)
      else 
     set @xx15 = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper and mmcorrela = @ncorrela ),0)   
--  16
  if @tabla = 'MDCI' or @tabla = 'MDVI'
     set @valorX = isnull((select vmvalor from view_valor_moneda where vmcodigo = @moneda and vmfecha = @fecpro),0)
  if @moneda = 900  and @moneda = 995 and @moneda = 13 and @moneda = 142
     set @valorX =isnull((select vmvalor from view_valor_moneda 
                                       where vmcodigo = 994 and vmfecha = @fecpro),0)
  if @tabla = 'MDCP'
      set @valorx = isnull((select vmvalor  from view_valor_moneda    
                                       where vmfecha = @fec_comp and vmcodigo = @moneda),0)
-- 17
  if @moneda = 13
      set @ccmon = '11'
      else 
      set @ccmon = '00'
-- 18 
   if @moneda =  999 
      set @ccmor =  '000'
   if @moneda = 998
       set @ccmor = '009'
   if @moneda = 997 
       set @ccmor = '007'
   if @moneda = 900 or @moneda = 994 or @moneda = 995 or @moneda = 13 or @moneda = 14 or @moneda = 142
       set @ccmor = '994'
-- 19  
      if @tipoper = 'CP' and (@moneda = 900 or @moneda = 995 or @moneda = 142)
         set @nmone = 994
      if substring(@mascara,1,2) = 'BR' or substring(@mascara,1,3) = 'CBR'
         set @nmone = 999
      if @tipoper = 'CI'
          set @nmone = @moneda  
      if @tipoper = 'VI' and (substring(@mascara,1,2) = 'BR' or substring(@mascara,1,3) = 'CBR') 
          set @nmone = 995
      if @tipoper = 'IB' and (@moneda = 900 or @moneda = 995 or @moneda = 994)
          set @nmone = 994
---------------------------------------------------------------------------------------------
-- 20 anexo dos  
   if @tabla ='MDCP' 
       set @dias = datediff(day,@fecpro,@fecvenpact)
     else
       set @dias = datediff(day,@fecpro,@fecvenp)
--                      codigo del instrumento
   if @dias < 30 
      set @codigo = case when @moneda = 999 then 111 else 121 end 
   if @dias > 30 and @dias < 89 
      set @codigo = case when @moneda = 999 then 113 else 123 end 
   if @dias > 365 and @dias < 1095 
      set @codigo = case when @moneda = 999 then 114 else 124 end 
   if @dias > 1095 
      set @codigo = case when @moneda = 999 then 115 else 125 end 
-- 21 esta en la tabla
-- 22
   IF SUBSTRING(@MASCARA,1,3) = 'PCD' OR SUBSTRING(@MASCARA,1,3) ='PTF' BEGIN 
      SET @CTTAS = 'FLO' END ELSE 
   IF SUBSTRING(@MASCARA,1,8) = 'BCAPS-A1' BEGIN 
      SET @CTTAS = 'VAR' END 
   ELSE 
      SET @CTTAS = 'XXX'
-- 25 esta en la tabla  
-- 26 esta en la tabla  campo_26
-- 27
IF @tabla  = 'MDCP'
   IF @moneda = 995 or @moneda = 13 or @moneda = 994 or @moneda = 142
      SET @TIRC = ISNULL((SELECT CPVPTIRC FROM MDCP WHERE cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
   ELSE 
      SET @TIRC = ISNULL((SELECT CPVALCOMP FROM MDCP WHERE cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
IF @tabla  = 'MDCI' AND @tipoper ='IB'
   SET @TIRC = ISNULL((SELECT CIVALCOMP FROM MDCI WHERE cInumdocu =@nNumdocu and cIcorrela =  @nCorrela),0)
  ELSE 
   SET @TIRC = ISNULL((SELECT CIVALVENP FROM MDCI WHERE cInumdocu =@nNumdocu and cIcorrela =  @nCorrela),0)
IF @tabla  = 'MDVI' 
   SET @TIRC = ISNULL((SELECT vivalvenp FROM MDVI WHERE VInumdocu =@nNumdocu and VIcorrela =  @nCorrela),0)
--29 ESTA EN LA TABLA   dias_dife
--38 ESTA EN LATABLA    fecha_compra
-- 39
  SET ROWCOUNT 0
  IF @seriado='S' AND @tipoper='CP'
  BEGIN
   SELECT @fecha  = @fecpro
   SELECT @tdcupon = 0
--   IF @codigo=20
--     SELECT @fecha = ''
   END
/*
--      1     2                  3
select 'uno'= '1',@rutemi,ltrim(STR(@nNumdocu))+ltrim(STR(@nNumoper))+ltrim(STR(@nCorrela))
                           --    4         5           6        7           8         9
                              ,@cuenta   , 0        ,'000'   , '00'       ,'0'     ,'1735'
--                               10        11          12       13          14       15
                              ,@inversion, @XX      ,'00'    , @FECPRO    ,@tirc   ,@xx15 
--                              16          17         18        19         20      21
                              ,@valorX   , @ccmon   ,@ccmor  , @nmone     ,@codigo ,@tir  
--                              22          23         24       25
                              ,@CTTAS    , '000000' ,'000000', @fecvenpact
--                              26         27         28        29            30
                              ,@campo_26 , @TIRC    ,'000'   ,@dias_dife   ,'000'   
--                                 31               32  33     34      35     36     37
                              ,'0000000000000000','00','PCT','00047','00047','xxx','00000'
--                              38       39  40        41              42       43    44
                              ,@fec_comp,0,'000','00000','000000000000000','00000','000000000000000'
--                              44  45   46   
                              ,'X','X','XXXXXXXXXXXXXXX'
*/
                            --  1    2       3
INSERT #TABLA_INTERFAZ VALUES (1,@rutemi,ltrim(STR(@nNumdocu))+ltrim(STR(@nNumoper))+ltrim(STR(@nCorrela))
                           --    4         5           6        7           8         9
                              ,@cuenta   , 0        ,'000'   , '00'       ,'0'     ,'1735'
                              -- 10         11        12        13          14       15
                              ,@inversion , @XX      ,'00'    , @FECPRO    ,@tirc   ,@xx15  
                              -- 16          17        18       19          20       21      
                              ,@valorX   , @ccmon   ,@ccmor   , @nmone     ,@codigo ,@tir  
                            --  22           23        24       25
                              ,@CTTAS    , '000000' ,'000000', @fecvenpact
                           --    26         27        28        29           30
                              ,@campo_26 , @TIRC    ,'000'   ,@dias_dife   ,'000'   
                           --      31              32    33    34      35     36     37      
                              ,'0000000000000000','00','PCT','00047','00047','xxx','00000'
                          --     38      39 40     41       42              43       44  
                              ,@fec_comp,0,'000','00000','000000000000000','00000','000000000000000'
                           --  45  46    47
                             ,'X','X','XXXXXXXXXXXXXXX'
                              )
FETCH NEXT FROM CURSOR_INTER
INTO  @mascara , @instrumento, @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda  , @seriado    , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi     ,
      @tabla   , @numero     , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu, @nNumoper   , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm ,@campo_26
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER
--SELECT * FROM #CARTERA 
 SELECT * FROM  #TABLA_INTERFAZ
END



GO

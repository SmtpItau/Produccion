USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_VCTO_WILLL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_VCTO_WILLL]
AS
BEGIN
 SET NOCOUNT ON
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
        @rutemi  NUMERIC (9) , @CRUT NUMERIC (9) ,@nvatc numeric(19,4), @dias numeric(19),@nbase numeric(3),
        @tabla  CHAR (4) ,   @CTTAS char(3), @DIG CHAR(1),
        @numero  NUMERIC (3) ,
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
        @tdcupon NUMERIC (10) ,
        @fecvenp DATETIME,
        @cliente NUMERIC (9) ,
        @estado  NUMERIC (9) ,
        @emtipo  CHAR (3) ,
        @nmes   CHAR (2) ,
        @nmes_a  CHAR (2) ,
        @nano   CHAR (4) ,
        @cano   CHAR (4) ,
        @nNumdocu NUMERIC (10,0) ,
        @nNumoper NUMERIC (10,0) ,
        @nCorrela NUMERIC (03) ,
        @tran_per char(10)        ,
        @ctcar     char(3),
        @ncupo numeric(19,4),
        @fec_prox_cupon datetime ,
        @cuenta_cupones numeric(19),
        @xproducto   char(40),--numeric(19) ,
        @cod_instru  numeric(3),
        @cPtra  CHAR(3),
        @ctotr  CHAR(3),
        @nvori NUMERIC(19,4),
        @ccmor CHAR(2),
        @fec_compra datetime,
        @total_registros numeric(19)
declare  @tdinteres   numeric( 19 ,10  ),
        @tdflujo     numeric( 19 ,10  )
 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop
 FROM MDAC
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'
 
 CREATE TABLE #CARTERA
    (
    mascara     CHAR (12)    ,
    numdocu     NUMERIC (10,0)    ,
    numoper     NUMERIC (10,0)    ,
    corre       NUMERIC (03,0)    ,
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
    periodo    INTEGER     ,
    fecvenp    DATETIME NULL   ,      
    valvenp    NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp    NUMERIC (19,4) NULL DEFAULT (0) ,
   correla     NUMERIC (3) , 
  --  correla     NUMERIC (3) IDENTITY (1,1) , 
    cuenta     CHAR(20)        NULL DEFAULT ('') ,
    tran_per   char(10)   ,
    fec_prox_cupon datetime,
    fec_compra datetime
      )
-- sp_help mdcp
CREATE TABLE #interfaz_vcto
                        (
                         creg             char(1) ,        --                              1 
                         crut             char(10),        --                              2 
                         cref             char(20),        --                              3 
                         ncope            char(20) ,       --                              4 
                         ncsup            char(40),        --                              5 
                         nctas            char(3) ,        -- 000                          6
                         nscta            char(2) ,        -- 00                           7
                         ncali    char(1) ,        -- 0                            8
                         ntipc            char(4) ,        -- 1735                         9
                         ncpro            numeric(3) ,        --?????                     10                            -- 10
                         ctcar            char(3) ,        -- PER,INV,                    11 
                         ntcre            char(2) ,        -- 00                          12 
                         dfoto            datetime,        -- feccomp                     13
                         nvori            numeric(19,4),   --                             14
                         ncupo            numeric(19,4),   -- ???                         15 
                         nvatc            numeric(19,4),   --                             16
                         ccmon1           char(2) ,        --                             17 
                         ccmor            char(2) ,        --                             18
                         nmone            numeric(3),      --                             19
                         nbase            numeric(3),      --                             20   
                         ntasa            numeric(19,4) ,   --tir                         21
                         cttas            char(3) ,        --flo,fij,xxx,var              22 
                         ntcom            char(6) ,        -- 000000                      23
                         ntcof            char(6) ,        -- 000000                      24
                         dfext            datetime,        -- fecha                       26
                         dfven            datetime,        --                             27
                         ncapi            numeric(19,4) ,   --                            28 
                         npcrb            char(3) ,        -- 000                         29
                         npzop            char(4) ,        -- 0000                        30
                         nncua            char(3) ,        -- 000                         31
                         nmcua            char(16) ,       -- 0000000000000000            32
                         nmatr            char(3) ,        -- 000                         33
                         nisis            char(3) ,        -- PCT                         34
                         nofio            char(5) ,        -- 00047                       35
                         nofco            char(5) ,        -- 00047                       36
                         nceje            char(3) ,        -- space(3)                    37
                         nccos            char(5) ,        -- 00000                       38 
                         dfta             DATETIME   ,      --                            39
                         difere           numeric(19) ,        -- ????????????????????    40
                         nncup            numeric(10) ,      --                           41 
                         ncopi            char(5) ,        -- 00000                       42 
                         ncopr            char(5) ,        -- 00000                       43 
                         nreaj            char(5) ,        -- 00000                       44 
                         ccjud            char(1) ,        -- S                           45
                         cinfo            char(1) ,        -- S                           46
                         crell            char(3) ,        -- space(3)                    47 
                         ccmon            char(11),        -- 00000000000                 48 
                         inversion        NUMERIC (5),     --                             49
                         cptra            char(3) ,        -- 700 o 000                   50
                         ctotr       char(3)       --                             51
                        ) 
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
   WHEN cpseriado='N' THEN (SELECT top 1 nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT top 1 semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
  END  ,
  cpseriado ,
  'CP'  ,
  0  ,
  cprutcli ,
  cpcodcli ,
  CASE
   WHEN cpseriado='N' THEN (SELECT top 1 nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT top 1 serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
  END  ,
  'MDCP'  ,
  ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
  cpfecven ,
  cpnominal ,
  cpvalcomp ,
  0,
  CtaContable,
  codigo_carterasuper,
  cpfecpcup,
  cpfeccomp
 FROM MDCP,CARTERA_CUENTA
 WHERE cpnominal>0 AND cprutcart>0
 AND t_operacion = 'CP'
 AND  NumDocu = cpnumdocu
        AND     Correla = cpcorrela
        AND NumOper = cpnumdocu 
 AND   variable = 'valor_compra'
/*---------------------------------------------------------------------------------------*/ 
INSERT #CARTERA 
 SELECT vimascara ,
  vinumdocu ,
  vinumoper ,
  vicorrela ,
  viinstser ,
  vicodigo ,
  vinominal ,
  vitircomp ,
  0  ,
  vifecvenp ,
  vimonemi ,
  viseriado ,
  'CP'  ,
  0  ,
  virutcli ,
  vicodcli ,
  CASE
   WHEN viseriado='N' THEN (SELECT  nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
   ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
  END  ,
  'MDCP'  ,
  ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
  vifecven ,
  vinominal ,
  vivalcomp , 
 0,
  CtaContable,
  codigo_carterasuper,
  vifecpcup,
  vifeccomp
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND  NumDocu = vinumdocu
        AND     Correla = vicorrela
        AND NumOper = vinumoper 
 AND   variable = 'valor_compra'
-- select codigo_carterasuper from mdvi
 
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
  vifecvenp ,
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
  ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
  ''  ,
  vivalvenp ,
  vivalcomp ,
  0,
  CtaContable ,
  codigo_carterasuper,
  vifecpcup,
  vifeccomp
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND  NumDocu  = vinumdocu
 AND  Correla  = vicorrela
 AND  NumOper  = vinumoper 
 AND  variable = 'valor_compra'
--select * from mdvi
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
  ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
  ''  ,
  civalvenp ,
  civalcomp ,
  0,
  CtaContable,
  codigo_carterasuper,
  cifecpcup,
  cifeccomp
 FROM MDCI,CARTERA_CUENTA
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND variable = 'valor_compra'
-- select * from mdci
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SET @CUENTA_CUPONES = 0
DECLARE CURSOR_INTER CURSOR FOR 
SELECT mascara, instrumento, codigo , nominal, tir     , Taspact  , fecvenpact  , moneda ,
       seriado, tipoper    , valinip, rutcli , codcli  , rutemi   , tabla       , corre  ,
       periodo, fecvenp    , valvenp, valcomp, numdocu , numoper  , correla     ,
       cuenta , tran_per   , fec_prox_cupon  , fec_compra 
  FROM #CARTERA
OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO @mascara ,@instrumento ,@codigo  ,@nominal ,@tir    ,@taspact ,@fecvenpact ,@moneda  ,
     @seriado ,@tipoper     ,@valinip ,@rutcli  ,@codcli ,@rutemi  ,@tabla      ,@numero  ,     
     @periodo ,@fecvenp     ,@valvenp ,@valcomp ,@nNumdocu,@nNumoper, @nCorrela,
     @cuenta  ,@tran_per    ,@fec_prox_cupon    ,@fec_compra 
WHILE @@FETCH_STATUS  = 0  
BEGIN 
-- 2
   if @tipoper ='CP'
     SET  @crut =   @rutemi      --decla
   else  
      SET @crut =   @rutcli
SELECT @DIG = Cldv FROM VIEW_CLIENTE WHERE Clrut = @crut
-- 3 @nNumdocu + @nNumoper + @nCorrela
-- 4 @cuenta
-- 5 sp_help view_plan_de_cuenta
 set @xproducto = isnull((select cta_sbif from view_plan_de_cuenta where cuenta = @cuenta),'0')
-- 6  '00'-- 7  '00' -- 8  '0'-- 9  1735
-- 10 sp_help VIEW_EMISOR
 SELECT @emtipo =  emtipo FROM VIEW_EMISOR WHERE emrut = @rutemi
  IF @codigo = 15
  BEGIN
      if @rutemi = @estado begin 
         set @cod_instru= 440     
         set @inversion = 21402   
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
      end
   
  END     
  ELSE  BEGIN
  IF @codigo = 14  and @moneda = 142 BEGIN 
     SET @cod_instru = 460
     SET @inversion  = 30002 
  END 
  IF @codigo = 13 and @moneda = 900 BEGIN 
     SET @cod_instru = 460
     SET @inversion  = 30002 
  END 
  IF @codigo = 20 or @codigo = 21 or @codigo =22 or @codigo = 23 BEGIN 
     IF @rutemi = @cliente BEGIN 
        SET @cod_instru = 460
        SET @inversion  = 22101  --ncpro
     END
    IF @rutemi = @estado BEGIN 
       SET @cod_instru = 440
       SET @inversion  = 21401  --ncpro
    END ELSE BEGIN 
          SET @cod_instru = 440
          SET @inversion  = 22103    --ncpro
    END 
   END 
END 
-- 11
 if @tran_per = 'T'  
      set @ctcar = 'INV'
    else 
      set @ctcar = 'PER'
-- 12 '00'
-- 13 dfoto = @fecpro
-- 14 
if @tipoper = 'VI'
      set @nvori = isnull((select vivalvenp from mdvi where vinumoper = @nNumoper      
                                             and vicorrela =  @nCorrela),0)
 
 if @tipoper = 'CP'  and @moneda = 13
      set @nvori   = isnull((select cpvptirc from mdcp where cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
   else
      set @nvori = isnull((select cpvalcomp from mdcp where cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
if @tipoper ='ICOL' or @tipoper = 'ICAP'
       set @nvori = isnull((select civalcomp from mdci where cinumdocu = @nNumoper      
                                                   and cicorrela =  @nCorrela),0)
  else
    set @nvori = isnull((select civalvenp from mdci  where cinumdocu = @nNumoper      
                                                     and cicorrela =  @nCorrela),0)
-- 15   sp_help mdcp select civalvenp from mdci 
if @tipoper = 'CP' 
   if (select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper ) = 0
     set @ncupo = isnull((select cpvptirc from mdcp where  cpnumdocu =@nNumdocu and cpcorrela =  @nCorrela),0)
    else 
     set @ncupo = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper ),0) 
   
 if @tipoper = 'CI' BEGIN 
   if isnull((select mmvalor from mdmm where mmnumdocu = @nNumdocu and mmnumoper = @nNumoper AND mmcorrela = @NCORRELA),0) = 0
     set @ncupo = isnull((select civptirci from mdci where  CinumDOCU = @nNumoper
                                                     and Cicorrela =  @nCorrela),0)
   else 
     set @ncupo = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper and mmcorrela = @ncorrela ),0)   
  END 
 if @tipoper = 'VI' 
     set @ncupo = isnull((select vivptirci from mdvi where vinumdocu =@nNumdocu  and vicorrela = @ncorrela ),0)
      else 
     set @ncupo = isnull((select mmvalor from mdmm where mmnumdocu =@nNumdocu and mmnumoper = @nNumoper and mmcorrela = @ncorrela ),0)   
-- 16 
   set @nvatc = isnull((select vmvalor from view_valor_moneda where vmcodigo = @moneda and vmfecha = @fecpro),0)
--17
if @moneda = 999 
   set @ccmor = '00' else
if @moneda = 998 
   set @ccmor = '09'     else
if @moneda = 997
   set @ccmor = '09' else
if @moneda = 900 or @moneda = 994 or @moneda = 995 or @moneda = 13 or @moneda = 14 or @moneda = 142 
   set @ccmor = '11' 
else
   set @ccmor = '00'
--18
if @tipoper ='CP' 
       set @dias = datediff(day,@fecpro,@fecvenpact)
     else
       set @dias = datediff(day,@fecpro,@fecvenp)
--                   codigo del instrumento
   if @dias < 30 
      set @nbase = 101
   if @dias >= 30 and @dias < 89 
      set @nbase = 102
   if @dias >= 90 and @dias <=179
      set @nbase = 103
   if @dias >= 180 and @dias <=364
      set @nbase = 104
   if @dias >= 365 and @dias <= 1094 
      set @nbase = 105
   if @dias >= 1095 
      set @nbase = 106
-- 19  @tir
-- 20     ????????????????????????????????? revalidar
IF SUBSTRING(@MASCARA,1,3) = 'PCD' OR SUBSTRING(@MASCARA,1,3) ='PTF'
     SET @CTTAS = 'FLO' 
   else
     SET @CTTAS = 'FIJ' 
IF SUBSTRING(@MASCARA,1,8) = 'BCAPS-A1'   
      SET @CTTAS = 'VAR'   
   ELSE 
      SET @CTTAS = 'XXX'
-- 21 nTCom   '000000' -- 22 nTcof   '000000'
-- 23 @fecvenpact 
-- 24 @fecvenp
-- 25 @valcomp
-- 26 nPcRb   '000'  -- 27 nPzop   '0000'-- 28 nNCua   '000'   -- 29 nMCua   '0000000000000000'
-- 30 nMatr   '000'  -- 31 nIsis   'PCT' -- 32 nOfio   '00000' -- 33 nOfco   '00047'
-- 34 nCeje   ''   ' -- 35 nCCos   '00000'
-- 36 dfta   fec_prox_cupon 
-- 37 contador 1 to n cupones 
-- 38 nuemro del cupon tdcupon 
-- 39 0
-- 40 0
-- 41 0
-- 42 'S' -- 43 'S' -- 44 space(3)-- 45 '00000000000'
-- 46  
   If @moneda = 900 begin 
      set @cPtra = '700'   --46  
      set @ctotr = '001'    --47  
     end else begin 
      set @cPtra = '000'  --46
      set @ctotr = '000'  --47
  end
if @codigo = 888  begin 
     set @cod_instru= 410
    set @inversion  = 11109
end 
 
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    set @tdcupon = 0
 
    DECLARE CURSOR_DESARROLLO CURSOR FOR
    SELECT tdcupon,tdinteres,tdamort,tdflujo,tdsaldo
    FROM VIEW_TABLA_DESARROLLO WHERE tdmascara=@mascara AND tdcupon >@tdcupon 
    OPEN CURSOR_DESARROLLO 
    FETCH NEXT FROM CURSOR_DESARROLLO 
    INTO @tdcupon , @tdinteres , @tdamort , @tdflujo , @tdsaldo     
    WHILE @@FETCH_STATUS  = 0
    BEGIN 
    set @cuenta_cupones = @cuenta_cupones + 1
 
--                                1   2               3
    insert #interfaz_vcto values('1',right('000000000'+convert(varchar(9),@crut),9) + @DIG ,ltrim(str(@nNumdocu)) + ltrim(str(@nNumoper))+ltrim(str( @nCorrela)),
--                               4         5           6     7   8    8      10  
                                @cuenta,@xproducto , '000','00','0','1735', @cod_instru,
--                                 11    12    13         14     15      16    17    18
                                 @ctcar,'00',@fec_compra,@nvori,@ncupo,@nvatc,'00' ,@ccmor,
--                                 19    20      21      22         23      24         25      26
                                 @moneda,@nbase,@tir ,@CTTAS, '000000','000000',@fecvenpact,@fecvenp,
--                                 27      28    29      30   31                 32
                                @valcomp,'000','0000','000','0000000000000000','000' ,
--                                  33   34      35      36   37      38
                                 'PCT' ,'00047','00047', ' ','00000',@fec_prox_cupon,
--                                 39               40      41      42      43
                                 @cuenta_cupones, @tdcupon,'00000','00000','00000',
--                                44   45  46      47          48        49       50
                                 'S' ,'S',' ','00000000000',@inversion, @cPtra,@ctotr)
    FETCH NEXT FROM CURSOR_DESARROLLO 
    INTO @tdcupon , @tdinteres , @tdamort , @tdflujo , @tdsaldo     
    END 
    CLOSE CURSOR_DESARROLLO 
    DEALLOCATE  CURSOR_DESARROLLO 
FETCH NEXT FROM CURSOR_INTER
INTO @mascara ,@instrumento ,@codigo  ,@nominal ,@tir    ,@taspact ,@fecvenpact ,@moneda  ,
     @seriado ,@tipoper     ,@valinip ,@rutcli  ,@codcli ,@rutemi  ,@tabla      ,@numero  ,     
     @periodo ,@fecvenp     ,@valvenp ,@valcomp ,@nNumdocu,@nNumoper, @nCorrela,
     @cuenta  ,@tran_per    ,@fec_prox_cupon    ,@fec_compra 
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER
select @total_registros = count(*) FROM #INTERFAZ_VCTO
select  * ,'tot_reg' = @total_registros FROM #INTERFAZ_VCTO
END
 --   Sp_interfaz_Flujo_Vcto_willl


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_VCTO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_VCTO]
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
  @emtipo  CHAR (2) ,
  @nmes   CHAR (2) ,
  @nmes_a  CHAR (2) ,
  @nano   CHAR (4) ,
  @cano   CHAR (4) ,
  @nNumdocu NUMERIC (10,0) ,
  @nNumoper NUMERIC (10,0) ,
  @nCorrela NUMERIC (03,0) 
 SELECT @fecpro  = acfecproc ,
  @cliente = acrutprop
 FROM MDAC
 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'
 
 CREATE TABLE #CARTERA
    (
    mascara  CHAR (12)    ,
    numdocu  NUMERIC (10,0)    ,
    numoper  NUMERIC (10,0)    ,
    corre  NUMERIC (03,0)    ,
    instrumento CHAR (12)    ,
    codigo  NUMERIC (5)    ,
    nominal  NUMERIC (19,4)    ,
    tir  NUMERIC (19,4)    ,
    taspact  NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact DATETIME NULL   ,
    moneda  NUMERIC (5)    ,
    seriado  CHAR (1)    ,
    tipoper  CHAR (3)    ,
    valinip  NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli  NUMERIC (9)    ,
    codcli  NUMERIC (5)    ,
    rutemi  NUMERIC (9)    ,
    tabla  CHAR (4)    ,
    periodo  INTEGER     ,
    fecvenp  DATETIME NULL   ,      
    valvenp  NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp  NUMERIC (19,4) NULL DEFAULT (0) ,
    correla  NUMERIC (9) IDENTITY (1,1) ,
    cuenta  CHAR(20) NULL DEFAULT ('') )
 CREATE TABLE #interfaz (numero_operacion char(15),
    fecha_venc_papel datetime ,
    cuenta char (12) NULL ,
    moneda numeric(9, 0) NULL ,
    tipo_tasa numeric(1, 0) NULL ,
    fechaven datetime NULL ,
    amortizacion numeric(19, 4) NULL ,
    tir numeric(19, 4) NULL ,
    saldo numeric(19, 4) NULL ,
    inversion numeric(5, 0) NULL ,
    tipo_cuenta char (2) NULL ,
    mascara char (12) NULL ,
    inumdocu numeric(10, 0) NULL ,
    inumoper numeric(10, 0) NULL ,
    icorre numeric(3, 0) NULL ,
    interes numeric(19, 4) NULL ,
    cupon int NULL )
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
  ISNULL((SELECT top 1 sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
  cpfecven ,
  cpnominal ,
  cpvalcomp ,
  CtaContable
 FROM MDCP,CARTERA_CUENTA
 WHERE cpnominal>0 AND cprutcart>0
 AND t_operacion = 'CP'
 AND  NumDocu = cpnumdocu
        AND     Correla = cpcorrela
        AND NumOper = cpnumdocu 
 AND   variable = 'valor_compra'
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
   WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
   ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
  END  ,
  'MDCP'  ,
  ISNULL((SELECT top 1  sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
  vifecven ,
  vinominal ,
  vivalcomp , 
  CtaContable
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND  NumDocu = vinumdocu
        AND     Correla = vicorrela
        AND NumOper = vinumoper 
 AND   variable = 'valor_compra'
 
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
  ISNULL((SELECT top 1  sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
  ''  ,
  vivalvenp ,
  vivalcomp ,
  CtaContable 
 FROM MDVI,CARTERA_CUENTA
 WHERE vitipoper =t_operacion 
 AND  NumDocu = vinumdocu
        AND     Correla = vicorrela
        AND NumOper = vinumoper 
 AND     variable = 'valor_compra'
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
  CtaContable
 FROM MDCI,CARTERA_CUENTA
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND  NumDocu = cinumdocu
        AND     Correla = cicorrela
 AND     variable = 'valor_compra'
 
 SELECT @numero = 0
 WHILE (1=1)
 BEGIN
  SELECT @c = '*'
 
  SET ROWCOUNT 1
  SELECT @mascara = mascara  ,
         @instrumento = instrumento ,
   @codigo  = codigo ,
   @nominal = nominal ,
   @tir  = tir  ,
   @taspact = taspact ,
   @fecvenpact = fecvenpact ,
   @moneda  = moneda ,
   @seriado = seriado ,
   @tipoper = tipoper ,
   @valinip = valinip ,
   @rutcli  = rutcli , 
   @codcli  = codcli ,
   @rutemi  = rutemi ,
   @tabla  = tabla  ,
   @numero  = CONVERT(CHAR(9),correla) ,
   @c  = '1'  ,
   @periodo = periodo ,
   @fecvenp = fecvenp ,
   @valvenp = valvenp ,
   @valcomp = valcomp ,
   @nNumdocu = numdocu ,
   @nNumoper = numoper ,
   @nCorrela = corre  ,
   @cuenta  = cuenta
  FROM #CARTERA
  WHERE correla>@numero
  IF @c='*'
  BEGIN
   SET ROWCOUNT 0
   BREAK
  END
  SELECT @emtipo = emtipo FROM VIEW_EMISOR WHERE emrut=@rutemi
  IF @codigo=15
  BEGIN
   SELECT @inversion = (CASE @rutemi WHEN @cliente THEN 22102 ELSE 
       (CASE @emtipo WHEN 1 THEN 11110 ELSE 
       (CASE @rutemi WHEN @estado THEN 21402 ELSE
       (CASE @emtipo WHEN 2 THEN 22104 ELSE 12001 END) END) END)
        END)
  END
  ELSE
  BEGIN
   SELECT @inversion = (CASE @rutemi WHEN @estado THEN 21401 ELSE  
       (CASE @rutemi WHEN @cliente THEN 21101 ELSE
       (CASE @emtipo WHEN 2 THEN 11111 ELSE 22101  END)END)
        END)     
  END
  SET ROWCOUNT 0
  IF @seriado='S' AND @tipoper='CP'
  BEGIN
   SELECT @fecha  = @fecpro
   SELECT @tdcupon = 0
   IF @codigo=20
    SELECT @fecha = ''
   WHILE (1=1)
   BEGIN
    SELECT @c1 = '*'
    SET ROWCOUNT 1
    IF @codigo<>20
    BEGIN   
     SELECT --@cuenta  = ''       ,
      @tdfecven = tdfecven      ,
      @tdamort = ((tdamort*@nominal)/100)+((tdinteres*@nominal)/100) ,
      @tdsaldo = tdsaldo      ,
      @c1  = 1       ,
      @tdcupon = tdcupon
     FROM VIEW_TABLA_DESARROLLO
     WHERE tdmascara=@mascara AND tdfecven>@fecha
    END
    IF @codigo=20
    BEGIN 
     IF CHARINDEX('*',@instrumento)<>0 --** (*) **--
     BEGIN
      IF SUBSTRING(@instrumento,7,2)='**'
       SELECT @instrumento = SUBSTRING(@instrumento,1,6)+' *'+SUBSTRING(@instrumento,9,2)
      ELSE
       SELECT @instrumento = SUBSTRING(@instrumento,1,6)+'01'+SUBSTRING(@instrumento,9,2)
     END
   
     IF CHARINDEX('&',@instrumento)<>0 --** (&) **--
     BEGIN
      IF SUBSTRING(@instrumento,7,2)='&&'
       SELECT @instrumento = SUBSTRING(@instrumento,1,6)+' &'+SUBSTRING(@instrumento,9,2)
      ELSE
      BEGIN
       SELECT @nMes = CONVERT(INTEGER,SUBSTRING(@instrumento,9,2))
       SELECT @nMes_a = DATEPART(MONTH,@fecpro)
 
       IF @nMes>@nMes_a
        SELECT @nAno = DATEPART(YEAR,@fecpro) - 1
       ELSE
        SELECT @nAno = DATEPART(YEAR,@fecpro)
       SELECT @cAno  = CONVERT(CHAR,@nAno)
       SELECT @instrumento = SUBSTRING(@instrumento,1,6)+SUBSTRING(@instrumento,9,2)+SUBSTRING(@cAno,3,2)
      END
     END       
 
     SELECT --@cuenta  = ''              ,
      @tdfecven = DATEADD(mm,(tdcupon*@periodo),RIGHT(RTRIM(@instrumento),2)+SUBSTRING(RIGHT(RTRIM(@instrumento),4),1,2)+'01') ,
      @tdamort = ((tdamort*@nominal)/100)+((tdinteres*@nominal)/100)        ,
      @tdsaldo = tdsaldo             ,
      @c1  = 1              ,
      @tdcupon = tdcupon
     FROM VIEW_TABLA_DESARROLLO
     WHERE tdmascara=@mascara AND tdcupon>@tdcupon                 
    END
   
    IF @c1='*'
    BEGIN
     SET ROWCOUNT 0
     BREAK
    END
    SELECT @fecha = @tdfecven 
  
    IF @tdfecven>@fecpro 
     INSERT #interfaz VALUES (rtrim(convert(char(10),@nNumoper))+ rtrim(convert(char(3),@nCorrela)),@fecvenpact,
             @cuenta,@moneda,0,@tdfecven,@tdamort,@tir,0,@inversion,'',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
   END  
  END
  IF @seriado='N' AND @tipoper='CP'
  BEGIN 
   SELECT @tdamort = @nominal
   IF @codigo=98
    SELECT @tdamort = @valcomp
   IF @codigo=888
    SELECT @tdamort = @valvenp
   INSERT #interfaz VALUES (rtrim(convert(char(10),@nNumoper))+ rtrim(convert(char(3),@nCorrela)),@fecvenpact,
      @cuenta,@moneda,0,@fecvenp,@tdamort,@tir,0,@inversion,'',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
  END
  IF @tipoper='CI' OR @tipoper='VI' OR @tipoper='IB'
   INSERT #interfaz VALUES (rtrim(convert(char(10),@nNumoper))+ rtrim(convert(char(3),@nCorrela)),@fecvenpact,@cuenta,@moneda,0,@fecvenpact,@valinip,@taspact,0,@inversion,'',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
--       SELECT 'insert' = count(*) FROM MDC08 
 END
 SELECT numero_operacion,
  cuenta  ,
  fecha_ven_papel = convert(char(10),fecha_venc_papel,112),
  fecha_proc  = convert(char(10),@fecpro,112),
  moneda  ,
 amortizacion ,
  tir  ,
  saldo  ,
  mascara
 FROM #interfaz
END
-- Sp_interfaz_c8 
-- SELECT * FROM view_noserie
-- sp_helptext sp_md0301c
--sp_help mdc08
--select * from mdci where cicodigo = 992
--select * from cartera_cuenta where codigoinst = 992 and numdocu = 46370
--select * from view_perfil_cnt where folio_perfil = 49
--select * from view_perfil_detalle_cnt where folio_perfil = 49
--select * from view_perfil_variable_cnt where folio_perfil = 49


GO

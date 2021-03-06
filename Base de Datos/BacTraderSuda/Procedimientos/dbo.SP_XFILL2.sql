USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_XFILL2]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_XFILL2]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE       @c  CHAR (1) ,
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
               @tipoper CHAR (5) ,
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
               @nCorrela NUMERIC (03,0) ,
               @nVpresen NUMERIC (19,4) ,
               @tipo_linea     CHAR  (1) ,
               @nValvenc NUMERIC (19,4) 
          SELECT @fecpro  = acfecproc ,
                 @cliente = acrutprop
          FROM MDAC
          SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='ESTAD'
CREATE TABLE #CARTERA
                (
                   mascara        CHAR (12)            ,
                   numdocu        NUMERIC (10,0)       ,
                   numoper        NUMERIC (10,0)       ,
                   corre          NUMERIC (03,0)       ,
                   instrumento    CHAR (12)            ,
                   codigo         NUMERIC (05)         ,
                   nominal        NUMERIC (19,4)       ,
                   tir            NUMERIC (19,4)       ,
                   taspact        NUMERIC (19,4) NULL DEFAULT (0)    ,
                   fecvenpact     DATETIME NULL                      , 
                   moneda         NUMERIC (05)                       ,
                   seriado        CHAR   (01)                        ,
                   tipoper        CHAR (05)                          ,
                   valinip        NUMERIC (19,4) NULL DEFAULT (0)    ,
                   rutcli         NUMERIC (09)                       ,
                   codcli         NUMERIC (05)                       ,
                   rutemi         NUMERIC (09)                       ,
                   tabla          CHAR  (04)                         ,
                   periodo        INTEGER                            ,
                   fecvenp        DATETIME NULL                      ,      
                   valvenp        NUMERIC (19,4) NULL DEFAULT (0)    ,
                   valcomp        NUMERIC (19,4) NULL DEFAULT (0)    ,
                   correla        NUMERIC (09) IDENTITY (1,1)        ,
                   cuenta        CHAR (20) NULL DEFAULT ('')         ,
                   tipo_linea    CHAR (01) NULL DEFAULT ('H')        ,
                   flujea        CHAR (01) NULL                      ,
                   fecemi        DATETIME NULL                       ,
                   vpresen       NUMERIC (19,4) NULL DEFAULT (0)     ,
                   valvenc       NUMERIC (19,4)  NULL DEFAULT (0)    ,
                   sw            CHAR(1)                             ,
                   base          NUMERIC(03)   NULL DEFAULT (0)      ,   
                )
-- DELETE MDC08
    INSERT #CARTERA
          SELECT cpmascara             ,
                 cpnumdocu             ,
                 cpnumdocu             ,
                 cpcorrela             ,
                 cpinstser             ,
                 cpcodigo              ,
                 cpnominal             ,
                 CASE WHEN cpcodigo = 98 THEN 0 ELSE cptircomp END,
                 0                     ,
                 ''                    ,
                 CASE
                     WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                     ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                 END                   ,
                 cpseriado             ,
                 'CP'                  ,
                 0                     ,
                 cprutcli              ,
                 cpcodcli              ,
                 CASE
                  WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                  ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                 END                   ,
                 'MDCP'                ,
                 ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara = cpmascara),0) ,
                 cpfecven              ,
                 cpnominal             ,
                 cpvalcomp             ,
                 CtaContable           ,
                 CASE
                     WHEN tipolinea='H' THEN 'T'
                     ELSE 'C'
                 END                   ,
                 CASE
                     WHEN SUBSTRING(cpinstser,1,3)='SUD' THEN 'S'
                     WHEN codigo_carterasuper='P' THEN 'S'
                     ELSE 'N'
                 END                 ,
                 cpfecemi            ,
                 cpvptirc            ,
                 0                   ,
                 ''                  ,
                 CASE
                     WHEN cpseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                     ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                 END  
             FROM MDCP,   CARTERA_CUENTA
                WHERE   cpnominal   >   0     AND 
                        cprutcart   >   0     AND
                       (t_operacion = 'CP'    AND
                        numdocu = cpnumdocu   AND
                        correla = cpcorrela   AND 
                        numoper = cpnumdocu   and 
                        variable = 'valor_compra')
 
    UPDATE #CARTERA
      SET valvenc = rsvalvenc
       FROM  mdrs, mdac
          WHERE rsfecha = acfecprox
          AND rscartera = '111'
          AND rsnumdocu = numdocu
          AND rsnumoper = numoper
          AND rscorrela = corre
          AND rstipoper = 'DEV'
------------ MODIFICA LA MONEDA PARA ALGUNOS INSTRUMENTOS (AGREGADO  EL 06/02/2002) ---
 UPDATE #CARTERA 
 SET    moneda  = 995
 WHERE  codigo  = 888 OR
        codigo  = 889 OR
        codigo  = 890 OR
        codigo  = 891 OR
        codigo  = 892
 
---------------------------------------------------------------------------------------
 INSERT #CARTERA 
    SELECT vimascara ,
           vinumdocu ,
           vinumoper ,
           vicorrela ,
           viinstser ,
           vicodigo  ,
           vinominal ,
           vitircomp ,
           0         ,
           vifecvenp ,
           vimonemi  ,
           viseriado ,
           'CP'      ,
           0         ,
           virutcli  ,
           vicodcli  ,
           CASE
              WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
               ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
           END      ,
           'MDCP'   ,
           ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
           vifecven  ,
           vinominal ,
           vivalcomp , 
           ctacontable ,
           CASE
               WHEN tipolinea='H' THEN 'T'
            ELSE 'C'
           END        ,
           CASE
               WHEN SUBSTRING(viinstser,1,3)='SUD' THEN 'S'
               WHEN codigo_carterasuper='P' THEN 'S'
               WHEN DATEDIFF(DAY,acfecproc,vifecvenp)>29 AND codigo_carterasuper='T' THEN 'S'
            ELSE 'N'
           END      ,
           vifecemi ,
           vivptirv ,
           0        ,
           ''       ,
           CASE
               WHEN viseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
               ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=vimascara)
           END  
       FROM MDVI , CARTERA_CUENTA , MDAC
          WHERE t_operacion='VI' AND numdocu = vinumdocu AND correla=vicorrela AND numoper=vinumoper  AND
              variable='valor_compra'
-- Cartera VI
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
              vimonpact ,
              viseriado ,
              'VI'  ,
              vivalinip ,
              virutcli ,
              vicodcli ,
              CASE
               WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
               ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
              END  ,
              'MDVI'  ,
             ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
              ''  ,
              vivalvenp ,
              vivalcomp ,
              CtaContable ,
              CASE
               WHEN tipolinea='H' THEN 'T'
               ELSE 'C'
              END        ,
             'S'         ,
             vifecinip   ,
             vivptirvi   ,
             0           ,
             ''          ,
             vibaspact
             FROM MDVI, CARTERA_CUENTA
             WHERE t_operacion='VI' AND numdocu=vinumdocu AND correla=vicorrela AND numoper=vinumoper AND
              variable='valor_venta'
-- Cartera Vi Intereses
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
        vifecvenp ,
        vimonpact ,
        viseriado ,
        'IN-VI'   ,
        vivalinip ,
        virutcli  ,
        vicodcli  ,
        CASE
         WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END      ,
        'MDVI'   ,
        ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
        ''        ,
        vivalvenp ,
        vivalcomp ,
        CtaContable ,
        CASE
            WHEN tipolinea='H' THEN 'T'
            ELSE 'C'
        END        ,
        'S'        ,
        vifecinip  ,
        vivptirvi  ,
        0          ,
        ''         ,
        vibaspact
       FROM MDVI, CARTERA_CUENTA
       WHERE t_operacion='DVVI' AND numdocu=vinumdocu AND correla=vicorrela AND numoper=vinumoper AND
             variable='interes_pacto'
-- Cartera IB-CI
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
        cimonpact ,
        ciseriado ,
        CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END       ,
        civalinip ,
        cirutcli  ,
        cicodcli  ,
        CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
            ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
             nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
             ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cimascara)
        END)
        END        ,
        'MDCI'     ,
        ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''         ,
        civalvenp  ,
        civalcomp  ,
        CtaContable ,
        CASE
            WHEN tipolinea='H' THEN 'T'
            ELSE 'C'
        END        ,
        'S'        ,
        cifecinip  ,
        civptirci  ,
        0          ,
        ''         ,
        cibaspact 
       FROM MDCI, CARTERA_CUENTA
       WHERE  t_operacion=(CASE WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'CP' ELSE 'CI' END) AND
              cicodigo=codigoinst AND t_movimiento='MOV' AND numdocu=cinumdocu AND correla=cicorrela AND
              variable='valor_compra'
-- Cartera IB-CI Intereses
 INSERT #CARTERA
 SELECT  cimascara    ,
         cinumdocu    ,
         cinumdocu    ,
         cicorrela    ,
         ciinstser    ,
         cicodigo     ,
         cinominal    ,
         citircomp    ,
         citaspact    ,
         cifecvenp    ,
         cimonpact    ,
         ciseriado    ,
         CASE
               WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IN-IB'
               ELSE 'IN-CI'
         END          ,
         civalinip    ,
         cirutcli     ,
         cicodcli     ,
         CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
            ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                         nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
                         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cimascara)
                  END)
         END           ,
         'MDCI'        ,
        ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''                 ,
        civalvenp ,
        civalcomp ,
        CtaContable ,
        CASE
            WHEN tipolinea='H' THEN 'T'
            ELSE 'C'
        END        ,
        'S'        ,
        cifecinip  ,
        civptirci  ,
        0          ,
        ''         ,
        cibaspact
       FROM MDCI, CARTERA_CUENTA
      WHERE t_operacion=(CASE WHEN ciinstser='ICOL' THEN 'DICO' WHEN ciinstser='ICAP' THEN 'DICA' ELSE 'DVCI' END) AND
           cicodigo=codigoinst AND numdocu=cinumdocu AND correla=cicorrela AND
           variable=(CASE WHEN ciinstser='ICOL' THEN 'Interes_pacto' WHEN ciinstser='ICAP' THEN 'Interes_papel' ELSE 'Interes_pacto' END)
--** Pasivos **--
 INSERT #CARTERA
 SELECT    cpmascara        ,
           cpnumdocu        ,
           cpnumdocu        ,
           cpcorrela        ,
           cpinstser        ,
           cpcodigo         ,
   cpnominal        ,
           cptircol         ,
           0                ,
           ''               ,
           (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara) ,
           cpseriado        ,
           'CP'             ,
           0                ,
           0                ,
           0                ,
           (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara) ,
           'MDCP'         ,
           ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
           cpfecven        ,
           cpnominal        ,
           cpvalcol        ,
           CtaContable        ,
           CASE
               WHEN tipolinea='H' THEN 'T'
            ELSE 'C'
           END         ,
           'S'         ,
           cpfecemi        ,
           cpvptircol        ,
           0         ,
           ''         ,
           (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara = cpmascara)
       FROM MDPASIVO, CARTERA_CUENTA
       WHERE cpnominal>0 AND cprutcart>0 AND
            (t_operacion='CPP' AND numdocu=cpnumdocu AND correla=cpcorrela 
            AND numoper=cpnumdocu AND variable='valor_compra')
    UPDATE #CARTERA
    SET valvenc = rsvalvenc
    FROM  MDRS, MDAC
       WHERE rsfecha       = acfecprox
             AND rscartera = '211'
             AND rsnumdocu = numdocu
             AND rsnumoper = numoper
             AND rscorrela = corre
             AND rstipoper = 'DEVP'
--** Pasivos **--
 UPDATE #CARTERA 
 SET tir  = tir * 12    ,
  taspact = taspact * 12
    WHERE base=30 AND codigo<>888 AND codigo<>15
 SELECT @numero = 0
 DECLARE @cFlujea CHAR (01) ,
  @dFecemi DATETIME ,
  @iCupones INTEGER
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
         @numero  = CONVERT(CHAR(9),correla),
         @c     = '1'  ,
         @periodo = periodo ,
         @fecvenp = fecvenp ,
         @valvenp = valvenp ,
         @valcomp = valcomp ,
         @nNumdocu = numdocu ,
         @nNumoper = numoper ,
         @nCorrela = corre  ,
         @cuenta  = cuenta ,
         @tipo_linea    = tipo_linea ,
         @cFlujea = flujea ,
         @dFecemi = fecemi ,
         @iCupones = 0  ,
         @nVpresen = vPresen ,
         @nValvenc = Valvenc
     FROM    #CARTERA
     WHERE sw=''
           IF @c='*'
              BEGIN
                  SET ROWCOUNT 0
                  BREAK
              END
-- SELECT emtipo,* FROM VIEW_EMISOR order by emtipo
-- SELECT emtipo,* FROM VIEW_EMISOR order by emnombre
           SELECT @emtipo = emtipo FROM VIEW_EMISOR WHERE emrut=@rutemi
           IF @codigo=15
              BEGIN
                     SELECT @inversion= (CASE @rutemi WHEN @cliente THEN 22102 ELSE 
                                        (CASE @emtipo WHEN 1        THEN 11110 ELSE 
                                        (CASE @rutemi WHEN @estado  THEN 21402 ELSE
                                        (CASE @emtipo WHEN 2        THEN 22104 
                                             ELSE 12001 END) END) END)
                                         END)
              END
  ELSE
  BEGIN
   SELECT @inversion = (CASE @rutemi WHEN @estado THEN 21401 ELSE  
       (CASE @rutemi WHEN @cliente THEN 21101 ELSE
       (CASE @emtipo WHEN 2 THEN 11111 ELSE 22101  END)END)
        END)     
  END
  SELECT @inversion = CASE
     WHEN @codigo =  4  THEN 21110
     WHEN @codigo =  6  THEN 21101
  WHEN @codigo =  7  THEN 21102
     WHEN @codigo =  9  THEN 22111
     WHEN @codigo = 11  THEN 22111
     WHEN @codigo = 31  THEN 22199
     WHEN @codigo = 50  THEN 30002
     WHEN @codigo = 51  THEN 30002
     WHEN @codigo = 52  THEN 30002
     WHEN @codigo = 53  THEN 30002
     WHEN @codigo = 54  THEN 30002
     WHEN @codigo = 98  THEN 12099
     WHEN @codigo = 300 THEN 21123
     WHEN @codigo = 301 THEN 21124
     WHEN @codigo = 888 THEN 11109
--     WHEN @codigo=15 AND SUBSTRING(@mascara,1,4)='USUD' THEN 00000
     WHEN @codigo=15  THEN CASE
         WHEN @rutemi = @cliente THEN 22102
         WHEN @emtipo = 1 THEN 11110
         WHEN @rutemi = @estado THEN 21402
         WHEN @emtipo = 2  THEN 22104
         ELSE 12001 END
     WHEN @codigo=20  THEN CASE
         WHEN @rutemi = @estado THEN 21401
         WHEN @rutemi = @cliente THEN 21101
         ELSE 22103  END
--         WHEN @emtipo = 2 THEN 11111
--         ELSE 22101  END
     END
  SET ROWCOUNT 0
  IF @seriado='S' AND @tipoper='CP' AND @cFlujea='S'
  BEGIN
   SELECT @tipo_linea  = 'C'
                        IF @codigo=15 AND SUBSTRING(@mascara,1,4)='USUD'
                           SELECT   @inversion   = '00000'   ,
                                    @tipo_linea  = '0'                       
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
     SELECT @tdfecven = tdfecven      ,
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
 
--     SELECT @tdfecven = DATEADD(mm,(tdcupon*@periodo),RIGHT(RTRIM(@instrumento),2)+SUBSTRING(RIGHT(RTRIM(@instrumento),4),1,2)+'01') ,
     SELECT @tdfecven = DATEADD(mm,(tdcupon*@periodo),@dFecemi)         ,
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
  
   -- IF @tdfecven>@fecpro 
   --  INSERT MDC08 VALUES (@cuenta,@moneda,0,@tdfecven,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
   END
  END
  IF @seriado='S' AND @tipoper='CP' AND @cFlujea='N'
  BEGIN
   SELECT @tipo_linea  = 'A'
   SELECT @fecha  = @fecpro
   IF @codigo=20
   BEGIN
    SELECT   @tdcupon = 0
    WHILE (1=1)
    BEGIN
     SELECT @c1 = '*'
     SET ROWCOUNT 1
--     SELECT @tdfecven = DATEADD(mm,(tdcupon*@periodo),RIGHT(RTRIM(@instrumento),2)+SUBSTRING(RIGHT(RTRIM(@instrumento),4),1,2)+'01'),
     SELECT @tdfecven = DATEADD(mm,(tdcupon*@periodo),@dFecemi),
            @tdcupon = tdcupon,
            @c1  = 1
     FROM VIEW_TABLA_DESARROLLO
     WHERE tdmascara=@mascara AND tdcupon>@tdcupon
     ORDER BY tdcupon
   
     IF @c1='*'
     BEGIN
      SET ROWCOUNT 0
      BREAK
     END
  
     IF @tdfecven>@fecpro 
      BREAK
    END
   END
   ELSE
   BEGIN
    SET ROWCOUNT 1
    SELECT @tdfecven = tdfecven
    FROM VIEW_TABLA_DESARROLLO
    WHERE tdmascara=@mascara AND tdfecven>@fecha
    SET ROWCOUNT 0
   END
   SELECT @tdamort = 0
   SELECT @tdamort = ISNULL(CASE
                               WHEN @nominal=valor_nominal THEN valor_market
                            ELSE ROUND((@nominal/valor_nominal)*valor_market,0)
                           END,0)
     FROM VALORIZACION_MERCADO, MDAC
     WHERE rmnumdocu=@nNumdocu AND rmnumoper=@nNumoper AND rmcorrela=@nCorrela AND
           acfecsbif2=fecha_valorizacion
   IF @tdamort=0
       SELECT   @tdamort   = @nVpresen
   IF @moneda<>999
         SELECT @tdamort   =  ROUND(@tdamort/vmvalor,4)
          FROM VIEW_VALOR_MONEDA
          WHERE vmfecha=@fecpro AND vmcodigo=@moneda
/*   IF @tdfecven>@fecpro 
   BEGIN
    INSERT MDC08 VALUES (@cuenta,@moneda,0,@tdfecven,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
*/   END
  END
  IF @seriado='N' AND @tipoper='CP' AND @cFlujea='S'
  BEGIN 
   SELECT @tipo_linea  = 'C'
   SELECT @tdamort = @nominal
   IF @codigo=98
    SELECT   @tdamort   = @valcomp
   IF @codigo=888
    SELECT   @tdamort   = @nValvenc
  -- INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenp,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
END
  IF @seriado='N' AND @tipoper='CP' AND @cFlujea='N'
  BEGIN 
   SELECT @tdamort = 0
   SELECT @tipo_linea  = 'A'
   SELECT @tdamort = ISNULL(CASE
       WHEN @nominal=valor_nominal THEN valor_market
       ELSE ROUND((@nominal/valor_nominal)*valor_market,0)
        END,0)
   FROM VALORIZACION_MERCADO, MDAC
   WHERE rmnumdocu=@nNumdocu AND rmnumoper=@nNumoper AND rmcorrela=@nCorrela AND
    acfecsbif2=fecha_valorizacion
   IF @tdamort=0
      SELECT   @tdamort = @nVpresen
   IF @moneda <> 999
   BEGIN 
    SELECT @tdamort =  ROUND( @tdamort / vmvalor ,4 )
    FROM view_valor_moneda
    WHERE vmfecha = @fecpro
    AND vmcodigo = @moneda
   END
  -- INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenp,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
  END
  IF @tipoper='CI' OR @tipoper='VI' OR @tipoper='IB'
  BEGIN
   SELECT @inversion = '00000'
   SELECT @tipo_linea  = '0'
   IF @moneda <> 999
    SELECT @valinip =  ROUND( @valinip / vmvalor ,4 )
    FROM view_valor_moneda
    WHERE vmfecha = @dFecemi
    AND vmcodigo = @moneda
   --INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenpact,@valinip,@taspact,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
  END
  IF @tipoper='IN-CI' OR @tipoper='IN-VI' OR @tipoper='IN-IB'
  BEGIN
   SELECT @inversion = '00000'
   SELECT @tipo_linea  = '0'
   IF @moneda <> 999
    SELECT @valinip =  ROUND( @valinip / vmvalor ,4 )
    FROM view_valor_moneda
    WHERE vmfecha = @dFecemi
    AND vmcodigo = @moneda
--   INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenpact,@valvenp -  @valinip,@taspact,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
  END
select * from MDC08 
select * from #CARTERA
-------------------------------------------------
--UPDATE MDC08 SET moneda = 995 WHERE 
-------------------------------------------------
--  UPDATE #CARTERA
--  SET sw ='S'
--  WHERE  correla = @numero
-- END
/*
 SELECT Distinct cuenta ,
  moneda  ,
  tipo_tasa ,
  inversion ,
  tipo_cuenta
 FROM MDC08 
 order by 
  cuenta ,
  moneda  ,
  tipo_tasa ,
  inversion ,
  tipo_cuenta
*/
-- UPDATE MDAC SET acint_c8 = '1'
-- SELECT 
--     cuenta   ,                                  --1
 --    moneda = isnull(moneda,0),                  --2
--     tipo_tasa ,                                 --3
--     'fecven' = CONVERT(CHAR(8),fechaven,112) ,  --4
--     amortizacion ,                              --5
--     tir  ,                                      --6
--     saldo  ,                                    --7
--     inversion ,                                 --8
--     tipo_cuenta ,                               --9
--     mascara  ,                                  --10
--     'TOTREG '  = (SELECT COUNT(*) FROM MDC08)   --11
--    FROM MDC08 
END
-- 
-- select * from view_instrumento
-- select cuenta,moneda,tipo_tasa,fechaven from mdc08 
-- select cuenta,COUNT(*),round(sum(amortizacion),0) from mdc08 GROUP BY CUENTA  ORDER BY CUENTA
-- Sp_interfaz_c8
-- select distinct Mascara,rutemisor from cartera_cuenta order by rutemisor,Mascara
-- select * from view_plan_de_cuenta where cuenta = 1735608114
-- select * from view_plan_de_cuenta where cuenta = 1710600011
-- select * from view_plan_de_cuenta where cuenta = 1120180009
-- select * from view_plan_de_cuenta where cuenta = 1120890103
-- select * from view_plan_de_cuenta where cuenta = 3415890108
-- select * from view_plan_de_cuenta where cuenta = 3410891106
-- select rsnominal,rsvalvenc,* from mdrs where rscodigo =888
-- sele
-- select CLNOMBRE,VIVALINIP,VIRUTCLI,datediff(day,vifecinip,vifecvenp),* from mdvi,VIEW_CLIENTE where vicodigo=300 and datediff(day,vifecinip,vifecvenp) < 30 AND VIRUTCLI = CLRUT order by VIRUTCLI
-- select VIVALINIP,VIRUTCLI,datediff(day,vifecinip,vifecvenp),* from mdvi where vicodigo=300 and datediff(day,vifecinip,vifecvenp) < 30 order by VIVALINIP
-- select VIVALINIP,VIVALVENP,VIRUTCLI,datediff(day,vifecinip,vifecvenp),* from mdvi where vicodigo=300 order by VIVALINIP
-- select * from mdcp where cpcodigo=15 and cpnominal > 0
-- select datepart(year,cpfecven),codigo_carterasuper,* from mdcp where cpcodigo=20 and substring(cpmascara,1,3)='SUD' AND cpnominal > 0 and cptipoletra = 'V'  order by cpfecven
-- select datepart(year,cpfecven),codigo_carterasuper,* from mdcp where cpcodigo=20 and substring(cpmascara,1,3)='SUD'  order by cpfecven
-- select * from valorizacion_mercado where fecha_valorizacion = '20010831' and rmcodigo = 15
-- select * from VIEW_instrumento
-- select cpinstser,sebasemi from mdcp,view_serie where cpcodigo = 15 and semascara = cpmascara
-- select * from cartera_cuenta where CtaContable = 1705514131
--

GO

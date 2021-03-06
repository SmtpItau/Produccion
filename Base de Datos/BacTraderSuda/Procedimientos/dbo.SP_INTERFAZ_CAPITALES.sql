USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CAPITALES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_CAPITALES] 
AS
BEGIN
 SET NOCOUNT ON
 DECLARE      @c         CHAR (1)           ,
              @c1        CHAR (1)           ,
              @mascara   CHAR (12)          ,
              @instrumento CHAR (12)        ,
              @codigo     NUMERIC (5)       ,
              @nominal    NUMERIC (19,4)    ,
              @tir        NUMERIC (19,4)    ,
              @taspact    NUMERIC (19,4)    ,
              @fecvenpact DATETIME          ,
              @moneda     NUMERIC (5)       ,
              @seriado    CHAR (1)          ,
              @tipoper    CHAR (5)          ,
              @valinip    NUMERIC (19,4)    ,
              @valvenp    NUMERIC (19,4)    ,
              @valcomp    NUMERIC (19,4)    ,
              @rutcli     NUMERIC (9)       ,
              @codcli     NUMERIC (5)       ,
              @rutemi     NUMERIC (9)       ,
              @tabla      CHAR (4)          ,
              @numero     NUMERIC (9)       ,
              @cuenta     CHAR (20)         ,
              @tipo_tasa  NUMERIC (1)       ,
              @tdfecven   DATETIME          ,
              @tdamort    NUMERIC (19,4)    ,
              @tdsaldo    NUMERIC (19,4)    ,
              @inversion  NUMERIC (5)       ,
              @tipo_cuenta CHAR (2)         ,
              @fecha      DATETIME          ,
              @fecpro     DATETIME          ,
              @periodo    INTEGER           ,
              @tdcupon    NUMERIC (5)       ,
              @fecvenp    DATETIME          ,
              @cliente    NUMERIC (9)       ,
              @estado     NUMERIC (9)       ,
              @emtipo     CHAR (2)          ,
              @nmes       CHAR (2)          ,
              @nmes_a     CHAR (2)          ,
              @nano       CHAR (4)          ,
              @cano       CHAR (4)          ,
              @nNumdocu   NUMERIC (10,0)    ,
              @nNumoper   NUMERIC (10,0)    ,
              @nCorrela   NUMERIC (03,0)    ,
              @nVpresen   NUMERIC (19,4)    ,
              @tipo_linea CHAR  (1)         ,
              @nValvenc   NUMERIC (19,4) 
 
SELECT  @fecpro  = acfecproc ,
        @cliente = acrutprop
       FROM MDAC
-- SELECT ACFECPROC , ACRUTPROP FROM MDAC
 
SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='ESTAD'
 
 CREATE TABLE #CARTERA
          (
             mascara        CHAR (12)          ,
             numdocu        NUMERIC (10,0)     ,
             numoper        NUMERIC (10,0)     ,
             corre          NUMERIC (03,0)     ,
             instrumento    CHAR (12)          ,
             codigo         NUMERIC (05)       ,
             nominal        NUMERIC (19,4)     ,
             tir            NUMERIC (19,4)     ,
             taspact        NUMERIC (19,4) NULL DEFAULT (0) ,
             fecvenpact     DATETIME NULL      ,
             moneda         NUMERIC (05)       ,
             seriado        CHAR (01)          ,
             tipoper        CHAR (05)          ,
             valinip        NUMERIC (19,4) NULL DEFAULT (0) ,
             rutcli         NUMERIC (09)       ,
             codcli         NUMERIC (05)       ,
             rutemi         NUMERIC (09)       ,
             tabla          CHAR (04)          ,
             periodo        INTEGER            ,   
             fecvenp        DATETIME       NULL                ,      
             valvenp        NUMERIC (19,4) NULL DEFAULT (0)    ,
             valcomp        NUMERIC (19,4) NULL DEFAULT (0)    ,
             correla        NUMERIC (09) IDENTITY (1,1)        ,
             cuenta         CHAR (20)      NULL DEFAULT ('')   ,
             tipo_linea     CHAR (01)      NULL DEFAULT ('H')  ,
             flujea         CHAR (01)      NULL                ,
             fecemi         DATETIME       NULL                ,
             vpresen        NUMERIC (19,4) NULL DEFAULT (0)    ,
             valvenc        NUMERIC (19,4) NULL DEFAULT (0)    ,
             sw             CHAR(1)                            ,
             base           NUMERIC(03)    NULL DEFAULT (0)     
          )
--  DELETE MDC08
--  select * from MDC08
--  select * from mdcp
--  select * from #CARTERA
--  select * from MDC08
 INSERT #CARTERA
 SELECT           cpmascara       ,
                  cpnumdocu       ,
                  cpnumdocu       ,
                  cpcorrela       ,
                  cpinstser       ,
                  cpcodigo        ,
                  cpnominal       ,               
                  CASE WHEN cpcodigo = 98 THEN 0 ELSE cptircomp END,
                  0               ,
                  ''              ,
                  CASE
                     WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                           ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                     END            ,
                  cpseriado         ,
                  'CP'              ,
                  0                 ,
                  cprutcli          ,
                  cpcodcli          ,
                  CASE
                     WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                     ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                  END                ,
                  'MDCP'             ,
                  ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara = cpmascara),0) ,
                  cpfecven           ,
                  cpnominal          ,
                  cpvalcomp          ,
                  CtaContable        ,
                  CASE
                      WHEN tipolinea='H' THEN 'T'
                      ELSE 'C'
                  END               ,
                  CASE
                        WHEN SUBSTRING(cpinstser,1,3)='COR' THEN 'S'
                        WHEN codigo_carterasuper='P' THEN 'S'
                     ELSE 'N'
                  END                ,
                  cpfecemi           ,
                  cpvptirc           ,
                  0                  ,
                  ''                 ,
                  CASE
                  WHEN cpseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                        ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                  END  
  -- SELECT * FROM MDCP   
          FROM MDCP, CARTERA_CUENTA
          WHERE   cpnominal                  >   0           AND 
                  cprutcart                  >   0           AND
                 (t_operacion                =   'CP'        AND
                  numdocu                    =   cpnumdocu   AND
                  correla                    =   cpcorrela   AND 
                  numoper                    =   cpnumdocu   AND
                  variable                   =   'valor_compra')
--select * from CARTERA_CUENTA
 
 UPDATE #CARTERA
          SET valvenc = rsvalvenc
          FROM  mdrs, mdac
          WHERE rsfecha = acfecprox
               AND rscartera = '111'
               AND rsnumdocu = numdocu
               and rsnumoper = numoper
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
  select * from #CARTERA  ORDER BY numdocu,numoper,corre
-- select * from mdcp
INSERT #CARTERA 
 SELECT    vimascara ,
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
           'CP'     ,
           0  ,
           virutcli ,
           vicodcli ,
           CASE
               WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
               ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
           END  ,
           'MDCP'  ,
           ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
           vifecven ,
           vinominal ,
           vivalcomp , 
           ctacontable ,
           CASE
                  WHEN tipolinea='H' THEN 'T'
                  ELSE 'C'
           END  ,
           CASE
                  WHEN SUBSTRING(viinstser,1,3)='SUD' THEN 'S'
                  WHEN codigo_carterasuper='P' THEN 'S'
                  WHEN DATEDIFF(DAY,acfecproc,vifecvenp)>29 AND codigo_carterasuper='T' THEN 'S'
               ELSE 'N'
           END  ,
           vifecemi ,
           vivptirv ,
           0  ,
           ''  ,
           CASE
               WHEN viseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
               ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=vimascara)
           END  
-- SELECT * FROM  MDAC
          FROM MDVI , CARTERA_CUENTA , MDAC
          WHERE t_operacion='VI' 
               AND numdocu = vinumdocu 
               AND correla=vicorrela 
               AND numoper=vinumoper  
               AND variable='valor_compra'
-----------------------------------------------------------
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
        END  ,
        'S'  ,
        vifecinip ,
        vivptirvi ,
        0  ,
        ''  ,
        vibaspact
          FROM MDVI, CARTERA_CUENTA
          WHERE t_operacion='VI'     AND numdocu=vinumdocu 
               AND correla=vicorrela AND numoper=vinumoper 
               AND  variable='valor_venta'
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
        'IN-VI'  ,
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
            ELSE    'C'
        END  ,
        'S'  ,
        vifecinip ,
        vivptirvi ,
        0  ,
        ''  ,
        vibaspact
       FROM    MDVI, CARTERA_CUENTA
             WHERE t_operacion='DVVI' 
                  AND numdocu=vinumdocu 
                  AND correla=vicorrela 
                  AND numoper=vinumoper 
                  AND variable='interes_pacto'
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
  CtaContable ,
  CASE
   WHEN tipolinea='H' THEN 'T'
   ELSE 'C'
  END  ,
  'S'  ,
  cifecinip ,
  civptirci ,
  0  ,
  ''  ,
  cibaspact 
 FROM MDCI, CARTERA_CUENTA
 WHERE t_operacion=(CASE WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'CP' ELSE 'CI' END) AND
  cicodigo=codigoinst AND t_movimiento='MOV' AND numdocu=cinumdocu AND correla=cicorrela AND
  variable='valor_compra'
-- Cartera IB-CI Intereses
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
   WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IN-IB'
   ELSE 'IN-CI'
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
  CtaContable ,
  CASE
   WHEN tipolinea='H' THEN 'T'
   ELSE 'C'
  END  ,
  'S'  ,
  cifecinip ,
  civptirci ,
  0  ,
  ''  ,
  cibaspact
 FROM MDCI, CARTERA_CUENTA
 WHERE t_operacion=(CASE WHEN ciinstser='ICOL' THEN 'DICO' WHEN ciinstser='ICAP' THEN 'DICA' ELSE 'DVCI' END) AND
  cicodigo=codigoinst AND numdocu=cinumdocu AND correla=cicorrela AND
  variable=(CASE WHEN ciinstser='ICOL' THEN 'Interes_pacto' WHEN ciinstser='ICAP' THEN 'Interes_papel' ELSE 'Interes_pacto' END)
--** Pasivos **--
 INSERT #CARTERA
 SELECT cpmascara        ,
  cpnumdocu        ,
  cpnumdocu        ,
  cpcorrela        ,
  cpinstser        ,
  cpcodigo        ,
  cpnominal        ,
  cptircol        ,
  0         ,
  ''         ,
  (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara) ,
  cpseriado        ,
  'CP'         ,
  0         ,
  0         ,
  0         ,
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
  (t_operacion='CPP' AND numdocu=cpnumdocu AND correla=cpcorrela AND numoper=cpnumdocu AND variable='valor_compra')
 UPDATE #CARTERA
 SET valvenc = rsvalvenc
 FROM  MDRS, MDAC
 WHERE rsfecha = acfecprox
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
 
select * from #CARTERA
end
 


GO

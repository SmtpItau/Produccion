USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_COLOCACIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_COLOCACIONES]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @fecproc CHAR (10) ,
  @fecha  DATETIME ,
  @fechaprox DATETIME ,
  @fechaproc DATETIME
 SELECT @fecproc = acfecproc FROM MDAC
 --*** CAPITAL CP
 --************************
 SELECT rut1  = CASE
     WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
     ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
      END   ,
  Dv1  = '0'   ,
  cpnumdocu    ,
  ctacontable    ,
  rut2  = CASE
     WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
     ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
      END   ,
  dv2  = '0'   ,
         cuenta4  = LEFT(ctacontable,4) ,
  fecha_compra = CONVERT(CHAR(10),cpfeccomp,112),
--  fecha_compra = CASE
--     WHEN cpinstser='DPX' THEN '00000000'
--     ELSE CONVERT(CHAR(10),cpfeccomp,112)
--      END   ,
  'cpvalcomp' = isnull(cpvalcomp,0)   ,
  moneda  = CASE
     WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
     ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
      END   ,
  codigo_tasa = 0   ,
  cptircomp    ,
  fecha_venc = CONVERT(CHAR(10),CPFECVEN,112),
--  fecha_venc = CASE
--     WHEN cpinstser='DPX' THEN '00000000'
--     ELSE CONVERT(CHAR(10),CPFECVEN,112)
--      END   ,
  base  = CASE
     WHEN cpseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
     ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
      END   ,
  grupo  = 1   ,
  tip  = 'CP'   ,
  cpinstser ,
   cpfecpcup    ,
  dias  = 0   ,
  cpvalcomp1 =isnull(cpvalcomp,0)  ,
  cpcorrela    ,
  plazo  = 10000   
 INTO #TCOLOCACIONES
 FROM MDCP ,CARTERA_CUENTA
 WHERE cpnumdocu=numdocu
 AND cpcorrela=correla
 AND t_operacion='CP'
 AND variable='valor_compra'
 AND NOT ( cpcodigo = 20 AND SUBSTRING(cpmascara,1,3)='SUD' )
 AND cpnominal > 0
 --*** CAPITAL INTERMEDIACION
 --**************************
 INSERT INTO
 #TCOLOCACIONES
 SELECT CASE
   WHEN viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
   ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
  END     ,
  '0'     ,
  vinumoper    ,
  ctacontable    ,
  CASE
   WHEN  viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
   ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
  END     ,
  '0'     ,
         LEFT(ctacontable,4)   ,
  CONVERT(CHAR(10),vifeccomp,112)  ,
  vivalcomp    ,
         CASE
   WHEN viseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela )
   ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
  END     ,
  codigo_tasa   = 0 ,
  vitircomp    ,
  CONVERT(CHAR(10),vifecven,112)   ,
  CASE
   WHEN viseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
   ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
  END     ,
  1     ,
  'VI'     ,
  viinstser    ,
   vifecpcup    ,
  0     ,
  vivalcomp    ,
  vicorrela    ,
  0
 FROM MDVI, CARTERA_CUENTA
 WHERE vinumoper=numoper
 AND vinumdocu=numdocu
 AND vicorrela=correla
 AND variable='valor_compra'
 AND NOT ( vicodigo = 20 AND SUBSTRING(vimascara,1,3)='SUD' )
 --*** CAPITAL PACTO CI
 --**************************
 
 INSERT #TCOLOCACIONES
 SELECT  cirutcli    ,
  dv1  = '0'   ,
  cinumdocu    ,
         ctacontable    ,
  cirutcli    ,
  '0'     ,
         LEFT(ctacontable,4)   ,
  CONVERT(CHAR(10),cifecinip,112)  ,
  civalinip    ,
         cimonpact    ,
  0     ,
  citaspact    ,
  CONVERT(CHAR(10),CIFECVENP,112)  ,
         cibaspact    ,
  1     ,
  'CI'     ,
  ciinstser    ,
   cifecpcup    ,
  0     ,
  civalinip    ,
  cicorrela    ,
  0
 FROM MDCI, CARTERA_CUENTA
 WHERE cinumdocu=numdocu
 AND cicorrela=correla
 AND cicodigo=codigoinst
 AND  variable='valor_compra'
 AND NOT ( ciinstser IN ('ICOL','ICAP') )
 --*** CAPITAL IB
 --**************************
 INSERT #TCOLOCACIONES
 SELECT  cirutcli    ,
  dv1  = '0'   ,
  cinumdocu    ,
         ctacontable    ,
  cirutcli    ,
  '0'     ,
         LEFT(ctacontable,4)   ,
  CONVERT(CHAR(10),cifecinip,112)  ,
  civalinip    ,
         cimonpact    ,
  0     ,
  citaspact    ,
  CONVERT(CHAR(10),CIFECVENP,112)  ,
         cibaspact    ,
  1     ,
  'IB'     ,
  ciinstser    ,
   cifecpcup    ,
  0     ,
  civalinip    ,
  cicorrela    ,
  0
 FROM MDCI, CARTERA_CUENTA
 WHERE cinumdocu=numdocu
 AND cicorrela=correla
 AND ciinstser='ICOL'
 AND variable='valor_compra'
 AND cimonpact<>994
 SELECT @fecha  = CONVERT(CHAR(10),LEFT(CONVERT(CHAR(10),acfecproc,112),6)+'01',12) ,
  @fechaproc  = acfecproc        ,
  @fechaprox = acfecprox
 FROM MDAC
 SELECT @fecha = DATEADD(MONTH,1,@fecha)
 SELECT @fecha = DATEDIFF(DAY,1,@fecha )
 IF @fecha>@fechaproc AND @fecha<@fechaprox 
 BEGIN
  INSERT INTO
  #TCOLOCACIONES
  SELECT rsrutemis  ,
   '0'   ,
   rsnumdocu  ,
          ctacontable  ,
   rsrutemis  ,
   '0'   ,
          LEFT(ctacontable,4) ,
   CONVERT(CHAR(10),rsfeccomp,112),
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfeccomp,112)
--   END   ,
   CASE
    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN (rsinteres_acum*(SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo=994 AND vmfecha=@fecha))
    ELSE rsinteres_acum
   END   ,
   rsmonemi  ,
   codigo_tasa = 0 ,
   rstir   ,
   CONVERT(CHAR(10),rsfecvcto,112),
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfecvcto,112)
--   END   ,
          rsbasemi  ,
   2   ,
   'CP'   ,
   rsinstser  ,
    rsfecpcup  ,
   0   ,
   rsvalcomp  ,
   rscorrela  ,
   0
  FROM MDRS, CARTERA_CUENTA
  WHERE rsnumdocu=numdocu
  AND rscorrela=correla
  AND variable='Interes_papel'
  AND rscartera='111'
  AND rstipoper='DEV'
  AND t_operacion = 'DVCP'
  AND rsfecha = @fecha
  AND NOT ( rscodigo = 20 and SUBSTRING(rsmascara,1,3)='SUD' )
  INSERT INTO
  #TCOLOCACIONES
  SELECT rsrutemis  ,
   '0'   ,
   rsnumdocu  ,
          ctacontable  ,
   rsrutemis  ,
   '0'   ,
          LEFT(ctacontable,4) ,
   CONVERT(CHAR(10),rsfeccomp,112),
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfeccomp,112)
--   END   ,
   CASE
    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN (rsinteres_acum*(SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo=994 AND vmfecha=@fecha))
    ELSE rsinteres_acum
   END   ,
   rsmonemi  ,
   codigo_tasa = 0 ,
   rstir   ,
   CONVERT(CHAR(10),rsfecvcto,112),
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfecvcto,112)
--   END   ,
          rsbasemi  ,
   2   ,
   'CP'   ,
   rsinstser  ,
    rsfecpcup  ,
   0   ,
   rsvalcomp  ,
   rscorrela  ,
   0
  FROM MDRS, CARTERA_CUENTA
  WHERE rsnumdocu=numdocu
  AND rscorrela=correla
  AND variable='Interes_papel'
  AND rscartera='114'
  AND rstipoper='DEV'
  AND t_operacion = 'DVIT'
  AND rsfecha = @fecha
  AND NOT ( rscodigo = 20 and SUBSTRING(rsmascara,1,3)='SUD' )
  INSERT INTO
  #TCOLOCACIONES
  SELECT CASE
    WHEN rscartera='112' THEN rsrutcli
    ELSE rsrutemis
   END    ,
   '0'    ,
   rsnumoper   ,
          ctacontable   ,
   CASE
    WHEN rscartera='112' THEN rsrutcli
    ELSE rsrutemis
   END    ,
   '0'    , 
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),rsfecinip,112) ,
   rsinteres_acum   ,
   CASE
    WHEN rscartera='112' THEN rsmonpact
    ELSE rsmonemi
   END    ,
   codigo_tasa = 0  ,
   CASE
    WHEN rscartera='112' THEN rstaspact
    ELSE rstir
   END    ,
   CASE
    WHEN rscartera='112' THEN CONVERT(CHAR(10),rsfecvtop,112)
    ELSE CONVERT(CHAR(10),rsfecvcto,112)
   END    ,
   CASE
    WHEN rscartera='112' THEN 30
    ELSE rsbasemi
   END    ,
   2    ,
   CASE
    WHEN rscartera='112' THEN 'CI'
    ELSE 'VI'
   END    ,
   rsinstser   ,
    rsfecpcup   ,
   0    ,
   rsvalinip   ,
   rscorrela   ,
   0
  FROM MDRS, CARTERA_CUENTA
  WHERE rsnumoper=numoper
  AND rsnumdocu=numdocu
  AND rscorrela=correla
  AND variable='Interes_pacto'
  AND t_operacion = 'DVCI'
  AND rscartera='112'
  AND rsfecha=@fecha 
  INSERT INTO
  #TCOLOCACIONES
  SELECT rsrutemis   ,
   '0'    ,
   rsnumdocu   ,
   ctacontable   ,
   rsrutemis   ,
   '0'    ,
   LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),rsfeccomp,112) ,
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfeccomp,112)
--   END    ,
   CASE
    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN (rsreajuste_acum*(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@fecha))
    ELSE rsreajuste_acum
   END    ,
   rsmonemi   ,
   codigo_tasa = 0  ,
   rstir    ,
   CONVERT(CHAR(10),rsfecvcto,112) ,
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfecvcto,112)
--   END    ,
   rsbasemi   ,
   2    ,
   'CP'    ,
   rsinstser   ,
   rsfecpcup   ,
   0    ,
   rsvalcomp   ,
   rscorrela   ,
   0
  FROM MDRS ,CARTERA_CUENTA
  WHERE rsnumdocu=numdocu
  AND rscorrela=correla
  AND rscartera='111'
  AND rstipoper='DEV'
  AND rsfecha = @fecha 
  AND NOT ( rscodigo = 20 and SUBSTRING(rsmascara,1,3)='SUD' )
  AND rsreajuste_acum <> 0
  AND t_operacion = 'DVCP'
  AND variable='Reajuste_papel'
  INSERT INTO
  #TCOLOCACIONES
  SELECT rsrutemis   ,
   '0'    ,
   rsnumdocu   ,
   ctacontable   ,
   rsrutemis   ,
   '0'    ,
   LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),rsfeccomp,112) ,
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfeccomp,112)
--   END    ,
   CASE
    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN (rsreajuste_acum*(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@fecha))
    ELSE rsreajuste_acum
   END    ,
   rsmonemi   ,
   codigo_tasa = 0  ,
   rstir    ,
   CONVERT(CHAR(10),rsfecvcto,112) ,
--   CASE
--    WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),rsfecvcto,112)
--   END    ,
   rsbasemi   ,
   2    ,
   'CP'    ,
   rsinstser   ,
   rsfecpcup   ,
   0    ,
   rsvalcomp   ,
   rscorrela   ,
   0
  FROM MDRS ,CARTERA_CUENTA
  WHERE rsnumdocu=numdocu
  AND rscorrela=correla
  AND rscartera='114'
  AND rstipoper='DEV'
  AND rsfecha = @fecha 
  AND NOT ( rscodigo = 20 and SUBSTRING(rsmascara,1,3)='SUD' )
  AND rsreajuste_acum <> 0
  AND t_operacion = 'DVIT'
  AND variable='Reajuste_papel'
  INSERT INTO
  #TCOLOCACIONES
  SELECT  CASE
    WHEN rscartera='112' THEN rsrutcli
    ELSE rsrutemis
   END    ,
   '0'    ,
   rsnumoper   ,
          ctacontable   ,
   CASE
    WHEN rscartera='112' THEN rsrutcli
    ELSE rsrutemis
   END    ,
   '0'    ,
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),rsfecinip,112) ,
   rsreajuste_acum   ,
          CASE
    WHEN rscartera='112' THEN rsmonpact
    ELSE rsmonemi
   END    ,
   codigo_tasa = 0   ,
   CASE
    WHEN rscartera='112' THEN rstaspact
    ELSE rstir
   END    ,
   CASE
    WHEN rscartera='112' THEN CONVERT(CHAR(10),rsfecvtop,112)
    ELSE CONVERT(CHAR(10),rsfecvcto,112)
   END    ,
          CASE
    WHEN rscartera='112' THEN 30
    ELSE rsbasemi
   END    ,
   2    ,
   CASE
    WHEN rscartera='112' THEN 'CI'
    ELSE 'VI'
   END    ,
   rsinstser   ,
    rsfecpcup   ,
   0    ,
   rsvalinip   ,
   rscorrela   ,
   0
  FROM MDRS, CARTERA_CUENTA
  WHERE rsnumoper=numoper
  AND rsnumdocu=numdocu
  AND rscorrela=correla
  AND variable='Reajuste_pacto'
  AND t_operacion = 'DVCI'
  AND rscartera='112'
  AND rsfecha=@fecha
 END
 ELSE
 BEGIN
  --*** INTERES CP
  --**************************
  INSERT INTO
  #TCOLOCACIONES
  SELECT CASE
    WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END   ,
   '0'   ,
   cpnumdocu  ,
          ctacontable  ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END   ,
   '0'   ,
          LEFT(ctacontable,4) ,
   CONVERT(CHAR(10),cpfeccomp,112),
--   CASE
--    WHEN SUBSTRING(cpinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),cpfeccomp,112)
--   END   ,
   CASE
    WHEN SUBSTRING(cpinstser,1,3)='DPX' THEN (cpinteresc*(SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo=994 AND vmfecha=@fechaproc))
    
    ELSE cpinteresc
   END   ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END   ,
   codigo_tasa = 0 ,
   cptircomp  ,
   CONVERT(CHAR(10),cpfecven,112),
--   CASE
--    WHEN SUBSTRING(cpinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),cpfecven,112)
--   END   ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END   ,
   2   ,
   'CP'   ,
   cpinstser ,
    cpfecpcup  ,
   0   ,
   'cpvalcomp' = isnull(cpvalcomp,0)  ,
   cpcorrela  ,
   0
  FROM MDCP, CARTERA_CUENTA
  WHERE cpnumdocu=numdocu
  AND cpcorrela=correla
  AND t_operacion = 'DVCP'
  AND variable='Interes_papel'
  AND NOT ( cpcodigo = 20 AND SUBSTRING(cpmascara,1,3)='SUD' )
  AND cpnominal > 0
  AND cpcodigo <> 98
  --*** INTERES INTERMEDIACION
  --**************************
  INSERT INTO
  #TCOLOCACIONES
  SELECT CASE
    WHEN viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   '0'    ,
   vinumoper   ,
          ctacontable   ,
   CASE
    WHEN viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   '0'    ,
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),vifeccomp,112) ,
   viinteresv   ,
   CASE
    WHEN viseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   codigo_tasa = 0  ,
   vitircomp   ,
   CONVERT(CHAR(10),vifecven,112) ,
   CASE
    WHEN viseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
  ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   2    ,
   'VI'    ,
   viinstser   ,
    vifecpcup   ,
   0     ,
   vivalcomp   ,
   vicorrela   ,
   0
  FROM MDVI, CARTERA_CUENTA
  WHERE vinumoper=numoper
  AND vinumdocu=numdocu
  AND vicorrela=correla
  AND t_operacion = 'DVIT'
  AND variable='Interes_papel'
  AND NOT ( vicodigo = 20 AND SUBSTRING(vimascara,1,3)='SUD' )
  AND vinominal > 0
  AND vicodigo <> 98  -- aqui
  --*** INTERES PACTO CI
  --**************************
 
  INSERT #TCOLOCACIONES
  SELECT cirutcli   ,
   Dv1  = '0'  ,
   cinumdocu   ,
          ctacontable   ,
   cirutcli   ,
   '0'    , 
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),cifecinip,112) ,
   ciinteresci   ,
          cimonpact   ,
   0    ,
   citaspact   ,
   CONVERT(CHAR(10),cifecvenp,112) ,
          cibaspact   ,
   2    ,
   'CI'    ,
   ciinstser   ,
    cifecpcup   ,
   0    ,
   civalinip   ,
   cicorrela   ,
   0
  FROM MDCI,CARTERA_CUENTA
  WHERE cinumdocu=numdocu
  AND cicorrela=correla
  AND cicodigo=CodigoInst
  AND t_operacion = 'DVCI'
  AND variable='Interes_papel'
  AND NOT ( ciinstser IN ('ICOL','ICAP') )
--  AND cimonpact <>999
  --*** INTERES PACTO IB
  --**************************
  INSERT #TCOLOCACIONES
  SELECT cirutcli   ,
   Dv1  = '0'  ,
   cinumdocu   ,
          ctacontable   ,
   cirutcli   ,
   '0'    , 
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),cifecinip,112) ,
   ciinteresci   ,
          cimonpact   ,
   0    ,
   citaspact   ,
   CONVERT(CHAR(10),cifecvenp,112) ,
          cibaspact   ,
   2    ,
   'CI'    ,
   ciinstser   ,
    cifecpcup   ,
   0    ,
   civalinip   ,
   cicorrela   ,
   0
  FROM MDCI,CARTERA_CUENTA
  WHERE cinumdocu=numdocu
  AND cicorrela=correla
  AND cicodigo=CodigoInst
  AND variable='Interes_pacto'
  AND ciinstser IN ('ICOL')
--  AND cimonpact <>999
  --*** REAJUSTE CP
  --**************************
  INSERT INTO
  #TCOLOCACIONES
  SELECT CASE
    WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END   ,
   '0'   ,
   cpnumdocu  ,
          ctacontable  ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END    ,
   '0'    ,
          cuenta4 = LEFT(ctacontable,4) ,
   CONVERT(CHAR(10),cpfeccomp,112) ,
--   CASE
--    WHEN SUBSTRING(cpinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),cpfeccomp,112)
--   END    ,
   cpreajustc   ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END    ,
   codigo_tasa = 0  ,
   cptircomp   ,
   CONVERT(CHAR(10),cpfecven,112) ,
--   CASE
--    WHEN SUBSTRING(cpinstser,1,3)='DPX' THEN '00000000'
--    ELSE CONVERT(CHAR(10),cpfecven,112)
--   END    ,
   CASE
    WHEN cpseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
    ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
   END    ,
   3    ,
   'CP'    ,
   cpinstser ,
    cpfecpcup   ,
   0     ,
   'cpvalcomp' = isnull(cpvalcomp,0)   ,
   cpcorrela   ,
   0
  FROM MDCP, CARTERA_CUENTA
  WHERE cpnumdocu=numdocu
  AND cpcorrela=correla
  AND t_operacion = 'DVCP'
  AND variable='Reajuste_papel'
  AND NOT ( cpcodigo = 20 AND SUBSTRING(cpmascara,1,3)='SUD' )
  AND NOT ( cpcodigo IN ( 6 , 9 ) )
  AND cpnominal > 0
  AND cpcodigo <> 98
  AND cpreajustc <> 0
  --*** REAJUSTE INTERMEDIACION
  --**************************
  INSERT INTO
  #TCOLOCACIONES
  SELECT CASE
    WHEN viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   '0'    ,
   vinumoper   ,
          ctacontable   ,
   CASE
    WHEN viseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo = vicodigo AND vimascara = semascara)
   END    ,
   '0'    ,
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),vifeccomp,112) ,
   vireajustv   ,
   CASE
    WHEN viseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
   END    ,
   codigo_tasa = 0  ,
   vitircomp   ,
   CONVERT(CHAR(10),vifecven,112) ,
          CASE
    WHEN viseriado='N' THEN (SELECT nsbasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
    ELSE (SELECT sebasemi FROM VIEW_SERIE WHERE secodigo=vicodigo AND vimascara=semascara)
    END   ,
   3    ,
   'VI'    ,
   viinstser   ,
    vifecpcup   ,
   0     ,
   vivalcomp   ,
   vicorrela   ,
   0
  FROM MDVI, CARTERA_CUENTA
  WHERE vinumoper=numoper
  AND vinumdocu=numdocu
  AND vicorrela=correla
  AND t_operacion = 'DVIT'
  AND variable='Reajuste_papel'
  AND NOT ( vicodigo = 20 AND SUBSTRING(vimascara,1,3)='SUD' )
  AND NOT ( vicodigo IN (6,9) )
  --*** REAJUSTE IB
  --**************************
  INSERT INTO
  #TCOLOCACIONES
  SELECT cirutcli   ,
   Dv1 = '0'   ,
   cinumdocu   ,
          ctacontable   ,
   cirutcli   ,
   '0'    ,
          LEFT(ctacontable,4)  ,
   CONVERT(CHAR(10),cifecinip,112) ,
   cireajustci   ,
          cimonpact   ,
   0    ,
   citaspact   ,
   CONVERT(CHAR(10),cifecvenp,112) ,
          cibaspact   ,
   3    , 
   'CI'    ,
   ciinstser   ,
    cifeccomp   ,
   0    ,
   civalinip   ,
   cicorrela   ,
   0
  FROM MDCI, CARTERA_CUENTA
  WHERE cinumdocu=numdocu
  AND cicorrela=correla
  AND cicodigo=codigoinst
  AND cimonpact<>999
  AND variable='Reajuste_papel' 
  AND NOT ( ciinstser IN ('ICOL','ICAP') )
  AND cimonpact<>994
 END  
-- DELETE #TCOLOCACIONES WHERE grupo=3 AND moneda=999
 UPDATE #TCOLOCACIONES
 SET plazo = DATEDIFF(month,fecha_compra,fecha_venc)
 
 UPDATE #TCOLOCACIONES
 SET dias = CASE
    WHEN cpinstser='PCDUF' OR cpinstser='PTF' OR cpinstser='PCDUS$' THEN DATEDIFF(dd,cpfecpcup,fecha_compra)
    ELSE DATEDIFF(dd,fecha_venc,fecha_compra)
     END
 UPDATE #TCOLOCACIONES
 SET dias = CASE
    WHEN dias<30 THEN  1
    WHEN Dias > 29 AND Dias < 90  THEN 2
    WHEN Dias > 89 AND Dias < 180 THEN 3
    WHEN Dias > 179 AND Dias < 365 THEN 4
    WHEN Dias > 364 AND Dias < 1094 THEN 5
    WHEN Dias > 1094 THEN 6
     END
 UPDATE #TCOLOCACIONES
 SET codigo_tasa = CASE
     WHEN cpinstser='PCDUF'  THEN '22' + CONVERT(CHAR(1),dias)
     WHEN cpinstser='PTF'    THEN '22' + CONVERT(CHAR(1),dias)
     WHEN cpinstser='PCDUS$' THEN '23' + CONVERT(CHAR(1),dias)
     ELSE '10' +CONVERT(CHAR(1),dias)
    END
      
 UPDATE #TCOLOCACIONES SET dv1 = cldv ,dv2 = cldv FROM VIEW_CLIENTE WHERE clrut=rut1    
 UPDATE #TCOLOCACIONES SET dv1 = emdv ,dv2 = emdv FROM VIEW_EMISOR WHERE emrut=rut1
 UPDATE MDAC SET acint_col = '1'
/*SELECT sum(cpvalcomp1) ,
  sum(cpvalcomp) 
 FROM  #TCOLOCACIONES 
*/
 UPDATE #TCOLOCACIONES
 SET cpvalcomp1 = cpvalcomp1 * isnull( vmvalor, 1 ),
  cpvalcomp = cpvalcomp  * isnull( vmvalor, 1 )
 FROM view_valor_moneda
 WHERE moneda = 13
 AND vmcodigo = 994
 AND vmfecha = @fechaproc
 
IF EXISTS (select * FROM  #TCOLOCACIONES WHERE  cpinstser <> 'FMUTUO' ) begin 
 SELECT rut1 = isnull(rut1,0) ,
   Dv1  ,
 cpnumdocu = isnull(cpnumdocu,0) ,
 ctacontable ,
 rut2 = isnull(rut2,0)  ,
 dv2  ,
        cuenta4  ,
 fecha_compra ,
 cpvalcomp1 ,
 moneda = isnull(moneda,0)  ,
 codigo_tasa ,
 cptircomp ,
 fecha_venc ,
 base = isnull(base,0)  ,
 grupo  ,
 tip  ,
 cpinstser  ,
 cpfecpcup  ,
 plazo  ,
 cpvalcomp ,
 cpcorrela  
 FROM  #TCOLOCACIONES WHERE  cpinstser <> 'FMUTUO' 
 ORDER BY cpnumdocu ,cpcorrela,cpvalcomp DESC
 end else begin 
 SELECT rut1   = '0' ,
   Dv1    = '0',
 cpnumdocu = '0' ,
 ctacontable = '0' ,
 rut2    = '0',
 dv2    = '0',
        cuenta4  = '0' ,
 fecha_compra  = '0',
 cpvalcomp1  = '0',
 moneda   = '0',
 codigo_tasa  = '0',
 cptircomp  = '0',
 fecha_venc  = '0',
 base    = '0',
 grupo    = '0',
 tip    = '0',
 cpinstser  = '0' ,
 cpfecpcup   = '0',
 plazo   = '0' ,
 cpvalcomp = '0' ,
 cpcorrela   = '0'
 FROM  #TCOLOCACIONES 
end
 -- SET NOCOUNT OFF
END
-- Sp_Interfaz_Colocaciones
-- select * from cartera_cuenta where t_operacion = 'DVIT' and Instrumento = 'PRBC' and Variable = 'Interes_papel'
-- select * from cartera_cuenta where  ctacontable = 1740620222 order by NumOper
-- select * from cartera_cuenta where Instrumento = 'PRC'
-- select * from mdcp where cpcodigo=98
-- select * from mdvi where vinumoper= 46769
-- select distinct vicodigo from mdvi
-- select cpvalcomp,* from mdcp
-- select * from view_plan_de_cuenta where cuenta = 1725580424
-- select vivalcomp,viinteresv,vireajustv from mdvi
-- select ciinteresci,cireajustci,* from mdci
-- select cpcodigo,cpinteresc,cpreajustc from mdcp where cpcodigo = 98
-- select * from mdrs where rscartera='112'
-- select * from cartera_cuenta where t_operacion = 'DVCI'
-- select * from view_perfil_cnt
-- select * from view_campo_cnt
-- select * from view_perfil_detalle_cnt where folio_perfil = 88
-- sp_autoriza_ejecutar 'BACUSER'
-- SP_HELP MDCP
-- SP_INTERFAZ_COLOCACIONES
-- 


GO

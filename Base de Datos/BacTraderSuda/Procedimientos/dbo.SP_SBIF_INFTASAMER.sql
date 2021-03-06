USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_INFTASAMER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_INFTASAMER]
AS
BEGIN
 DECLARE 
                @dFeccal DATETIME ,
  @dFecpro DATETIME ,
  @nCodigo INTEGER  ,
  @cMascara CHAR (10) ,
  @cInstser CHAR (10) ,
  @cFamilia CHAR (10) ,
  @cGlosa  CHAR (30) ,
  @nMonemi INTEGER  ,
  @dFecemi CHAR (10) ,
  @dFecven CHAR (10)    ,
  @fTasemi FLOAT  ,
  @fBasemi FLOAT  ,
  @fTasest FLOAT  ,
  @fNominal FLOAT  ,
  @fTir  FLOAT  ,
  @fPvp  FLOAT  ,
  @fMT  FLOAT  ,
  @fMTUM  FLOAT  ,
  @fMT_cien FLOAT  ,
  @fVan  FLOAT  ,
  @fVpar  FLOAT  ,
  @nNumucup INTEGER  ,
  @dFecucup DATETIME ,
  @fIntucup FLOAT  ,
  @fAmoucup FLOAT  ,
  @fSalucup FLOAT  ,
  @nNumpcup INTEGER  ,
  @dFecpcup DATETIME ,
  @fIntpcup FLOAT  ,
  @fAmopcup FLOAT  ,
  @fSalpcup FLOAT  ,
  @fDurat  FLOAT  ,
  @fConvx  FLOAT  ,
  @fDurmo  FLOAT  ,
  @nError  INTEGER  ,
  @cProg  CHAR (10) ,
  @x  INTEGER  ,
  @nContador NUMERIC (19,0) ,
  @cSeriado CHAR (01) ,
  @nNumdocu NUMERIC (19,0) ,
  @nCorrela NUMERIC (03,0) ,
  @nFactor NUMERIC (12,5) ,
          @nNewfactor NUMERIC (12,5) ,
  @nValmon NUMERIC (19,4) ,
  @fTe_pcdus FLOAT  ,
  @fTe_pcduf FLOAT  ,
  @fTe_ptf FLOAT  ,
  @nDia  NUMERIC (10,0) ,
  @nMes  INTEGER  ,
  @nAno  INTEGER  ,
  @nSw  INTEGER
 
       SELECT acfecproc,
       acfecprox,
       'uf_hoy'    = CONVERT(FLOAT, 0),
       'uf_man'    = CONVERT(FLOAT, 0),
       'ivp_hoy'   = CONVERT(FLOAT, 0),
       'ivp_man'   = CONVERT(FLOAT, 0),
       'do_hoy'    = CONVERT(FLOAT, 0),
       'do_man'    = CONVERT(FLOAT, 0),
       'da_hoy'    = CONVERT(FLOAT, 0),
       'da_man'    = CONVERT(FLOAT, 0),
       acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #PARAMETROS
  FROM MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
  WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
   AND VIEW_VALOR_MONEDA.vmcodigo = 998
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
CREATE TABLE #TMP7
   (
   nomemp  CHAR (40) NULL  ,
   rutemp  CHAR (12) NULL  ,
   fecpro  CHAR (10) NULL  ,
   codigo  NUMERIC (10,0) NULL  ,
   familia  CHAR (10) NULL  ,
   nomfamilia CHAR (40) NULL  ,
   serie  CHAR (10) NULL  ,
   factor1  NUMERIC (12,5) NULL  ,
   factor2  NUMERIC (12,5) NULL  ,
   tasa  NUMERIC (19,6) NULL  ,
   mascara  CHAR (10) NULL  ,
   seriado  CHAR (01) NULL  ,
   numdocu  NUMERIC (19,0) NULL  ,
   correla  NUMERIC (03,0) NULL  ,
   valnomi  NUMERIC (19,4) NULL  ,
   contador INTEGER IDENTITY(1,1) NOT NULL
   )
 SELECT @x  = 1 ,
  @nContador = 0
 WHILE @x=1
 BEGIN
  SELECT @cInstser = '*'
  SET ROWCOUNT 1
  SELECT  @nCodigo = tmcodigo ,
   @cFamilia = inserie ,
   @cGlosa  = inglosa ,
   @cInstser = tminstser ,
   @nFactor = tmfactor ,
           @nNewfactor = tmnewfactor ,
   @cMascara = cpmascara , 
   @cSeriado = cpseriado ,
   @nNumdocu = cpnumdocu ,
   @nCorrela = cpcorrela ,
   @fNominal = 0.0  ,
   @nContador = tmcontador
  FROM VIEW_INSTRUMENTO, MDTM1, MDCP
  WHERE tmcontador>@nContador AND tmcodigo=incodigo AND tminstser=cpinstser
  ORDER BY tmcontador
  SET ROWCOUNT 0
  IF @cInstser='*'
   BREAK
  IF NOT EXISTS(SELECT * FROM #TMP7 WHERE codigo=@nCodigo AND serie=@cInstser)
   INSERT INTO #TMP7
     (
     nomemp     ,
     rutemp     ,
     fecpro     ,
     codigo     ,
     familia     ,
     nomfamilia    ,
     serie     ,
     factor1     ,
     factor2     ,
     mascara     ,
     seriado     ,
     numdocu     ,
     correla     ,
     valnomi
     )
   SELECT
     ISNULL(acnomprop,'')   ,
     ISNULL(STR(acrutprop)+'-'+acdigprop,'') ,
     CONVERT(CHAR(10),acfecproc,103)  ,
     @nCodigo    ,
     @cFamilia    ,
     @cGlosa     ,
     @cInstser    ,
     @nFactor    ,
     @nNewfactor    ,
     @cMascara    ,
     @cSeriado    ,
     @nNumdocu    ,
     @nCorrela    ,
     @fNominal
   FROM  MDAC
 END
 UPDATE #TMP7
 SET valnomi = (SELECT SUM(cpnominal) FROM MDCP WHERE serie=cpinstser AND cprutcart>0)
 UPDATE #TMP7
 SET valnomi = valnomi + ISNULL((SELECT SUM(vinominal) FROM MDVI WHERE serie=viinstser),0)
 SELECT @dFecpro = acfecproc ,
  @dFeccal = acfecproc ,
  @x  = 1  ,
  @nContador = 0  ,
  @nSw  = 0
 FROM MDAC
 SELECT @dFeccal = DATEADD(MONTH,1,@dFeccal)
 SELECT @nMes  = DATEPART(MONTH,@dFeccal)
 SELECT @nAno  = DATEPART(YEAR,@dFeccal)
 SELECT @dFeccal = CONVERT(DATETIME,STR(@nMes,2,0)+'/'+STR(1,2,0)+'/'+STR(@nAno,4,0))
 SELECT @dFeccal = DATEADD(DAY,-1,@dFeccal)
 WHILE @x=1
 BEGIN
  SELECT @cInstser = '*'
  SET ROWCOUNT 1
  SELECT  @cInstser = serie   ,
   @cMascara = mascara  ,
   @cFamilia = familia  ,
   @nCodigo = codigo  ,
   @cSeriado = seriado  ,
   @nNumdocu = numdocu  ,
   @nCorrela = correla  ,
   @nCodigo = codigo  ,
   @nFactor = factor1  ,
   @nValmon = 1.0   ,
   @fTir  = 0.0   ,
   @fMt  = 0.0   ,
   @fNominal = 100.0   ,
   @dFecemi = ''   ,
   @dFecven = ''   ,
   @nMonemi = 0   ,
   @fTasemi = 0.0   ,
   @fBasemi = 0   ,
   @fTasest = 0.0   ,
   @fPvp  = 0.0   ,
   @fMT  = 0.0   ,
                   @fMTUM  = 0.0   ,
   @fMT_cien = 0.0   ,
   @fVan  = 0.0   ,
   @fVpar  = 0.0   ,
   @nNumucup = 0.0   ,
   @dFecucup = ''   ,
   @fIntucup = 0.0   ,
   @fAmoucup = 0.0   ,
   @fSalucup = 0.0   ,
   @nNumpcup = 0.0   ,
   @dFecpcup = ''   ,
                   @fIntpcup = 0.0   ,
   @fAmopcup = 0.0   ,
   @fSalpcup = 0.0   ,
   @nError  = 0   ,
   @cProg  = ''   ,
   @nContador = contador
  FROM #TMP7
  WHERE contador>@nContador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @cInstser='*'
   BREAK
  IF @cSeriado='S'
   SELECT @fTasemi = setasemi ,
    @nMonemi = semonemi ,
    @fBasemi = sebasemi
   FROM VIEW_SERIE
   WHERE semascara=@cMascara
  ELSE
   SELECT @fTasemi = nstasemi ,
    @nMonemi = nsmonemi ,
    @fBasemi = nsbasemi
   FROM VIEW_NOSERIE
   WHERE nsnumdocu=@nNumdocu AND nscorrela=@nCorrela
  SELECT @cProg  = 'SP_'+inprog FROM VIEW_INSTRUMENTO WHERE incodigo=@nCodigo
  SELECT @nValmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemi AND vmfecha=@dFeccal
  IF @nMonemi=994 AND @nSw=0
  BEGIN
   SELECT @nValmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemi AND vmfecha=@dFeccal
   IF @nValmon<=1.0
   BEGIN
    SELECT @nSw = 1
    IF @nValmon=0
    BEGIN
     SELECT @nValmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemi AND vmfecha=@dFecpro
     UPDATE VIEW_VALOR_MONEDA
     SET vmvalor = @nValmon
     WHERE vmcodigo=@nMonemi and vmfecha=@dFeccal
    END
    ELSE
    BEGIN
     SELECT @nValmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemi AND vmfecha=@dFecpro
     INSERT INTO VIEW_VALOR_MONEDA
      (
      vmcodigo ,
      vmfecha  ,
      vmvalor
      )
     VALUES
      (
      @nMonemi ,
      @dFeccal ,
      @nValmon
      )
    END
   END
  END
  SELECT @fTe_pcdus = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha=@dFecpro AND vmcodigo=302
  SELECT @fTe_pcduf = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha=@dFecpro AND vmcodigo=301
  SELECT @fTe_ptf = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha=@dFecpro AND vmcodigo=300
  SELECT @fTasest = CASE
     WHEN @nCodigo=1 THEN @fTe_pcdus
     WHEN @nCodigo=2 THEN @fTe_pcduf
     WHEN @nCodigo=5 THEN @fTe_ptf
      ELSE CONVERT(FLOAT,0)
       END
  SELECT @fMt = ROUND( @fNominal * @nFactor * @nValmon, 0)
  IF @nFactor>0
   --** Valorizaci½n a Fin de Mes **--
   EXECUTE @nError = @cProg 3, @dFeccal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,@fNominal OUTPUT,@fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
   --************************************--
  IF @nCodigo=20 AND SUBSTRING(@cInstser,1,3)<>'EDW'
   SELECT @cFamilia = 'LCHR OTROS'
   
  UPDATE #TMP7
  SET tasa = @fTir  ,
   familia = @cFamilia
  WHERE @cInstser=serie
 END
 IF @nSw=1
  DELETE VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@dFeccal
 
if exists(select * from #TMP7 WHERE valnomi>0   )
begin
         SELECT nomemp  ,
  rutemp  ,
  fecpro  ,
  familia  ,
  nomfamilia ,
  serie  ,
  factor1  ,
  factor2  ,
  tasa  ,
  sumevalnomi=SUM(valnomi)    ,
                acfecproc =CONVERT(CHAR(10), acfecproc, 103),
           acfecprox = CONVERT(CHAR(10), acfecprox, 103),
         uf_hoy,
  uf_man,
                ivp_hoy,
  ivp_man,
                do_hoy,
         do_man,
  da_hoy,
         da_man,
         acnomprop,
         rut_empresa,
         hora = CONVERT(varchar(30), getdate(),108)
 FROM #TMP7,#PARAMETROS
 WHERE valnomi>0
 GROUP BY nomemp   ,
                 rutemp,
                 fecpro,
                 familia,
                 nomfamilia,
                 serie,   
                 factor1,
                 factor2,
                 tasa   ,
                 acfecproc,
            acfecprox,
                 uf_hoy,
   uf_man,
                 ivp_hoy,
   ivp_man,
                 do_hoy,
          do_man,
   da_hoy,
          da_man,
          acnomprop,
          rut_empresa
end
else
begin
         SELECT 'nomemp'='',
  'rutemp'='',
  'fecpro'='',
  'familia'='',
  'nomfamilia'='',
  'serie' ='',
  'factor1'='',
  'factor2'='',
  'tasa' ='',
  'sumevalnomi'='',
                acfecproc =CONVERT(CHAR(10), acfecproc, 103),
           acfecprox = CONVERT(CHAR(10), acfecprox, 103),
         uf_hoy,
  uf_man,
ivp_hoy,
  ivp_man,
                do_hoy,
         do_man,
  da_hoy,
         da_man,
         acnomprop,
         rut_empresa,
    hora = CONVERT(varchar(30), getdate(),108)
 FROM #PARAMETROS
   end
END

GO

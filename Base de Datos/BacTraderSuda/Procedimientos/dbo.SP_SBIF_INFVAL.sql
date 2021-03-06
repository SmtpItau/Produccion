USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_INFVAL]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_INFVAL]
   (@dFecpro datetime
)
AS
BEGIN
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
        --select @dfecpro = convert(datetime,@dfecpro)
 DECLARE @cArch  CHAR(14) ,
  @nMes  INTEGER  ,
  @nDia  INTEGER  ,
  @cMes  CHAR (02) ,
  @cDia  CHAR (02) ,
  @cStrexec CHAR (255)
 
 SELECT @cArch  = ''  ,
  @nMes  = 0  ,
  @nDia  = 0  ,
  @cMes  = ''  ,
  @cDia  = ''  ,
  @cStrexec = ''
 SELECT @nMes  = DATEPART(MONTH,@dFecpro) ,
  @nDia  = DATEPART(  DAY,@dFecpro)
 IF @nMes<10
  SELECT @cMes = '0'+CONVERT(CHAR(1),@nMes)
 ELSE
  SELECT @cMes = CONVERT(CHAR(2),@nMes)
 IF @nDia<10
  SELECT @cDia = '0'+CONVERT(CHAR(1),@nDia)
 ELSE
  SELECT @cDia = CONVERT(CHAR(2),@nDia)
 SELECT @cArch  = 'RES_INFTM_'+@cMes+@cDia
 SELECT @dFecpro = acfecvmer FROM MDAC
      
 SELECT 'nomemp' = ISNULL(acnomprop,'')         ,
  'rutemp' = ISNULL((RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop),'')    ,
  'fecpro' = @dFecpro                               ,
  'fecppro' = CONVERT(CHAR(10),acfecprox,103)       ,
  'numdoc' = ISNULL(cpnumdocu,0)         ,
  'numoper' = ISNULL(cpnumdocu, 0)         ,
  'rutcart' = ISNULL(cprutcart,0)         ,
  'correla' = ISNULL(cpcorrela, 0)         ,
  'numdocu' = RTRIM(CONVERT(CHAR(10),ISNULL(cpnumdocu,0)))+'-'+CONVERT(CHAR(3),ISNULL(cpcorrela,0)) ,
  'tipoper' = 'CP'           ,
  'serie'  = ISNULL(cpinstser,'')         ,
  'seriado' = SPACE(01)          ,
  'fecemi' = CONVERT(CHAR(10),cpfecemi,103)       ,
  'fecven' = CONVERT(CHAR(10),cpfecven,103)       ,
  'tasemi' = CONVERT(NUMERIC(19,4),0)        ,
  'basemi' = CONVERT(NUMERIC(03,0),0)        ,
  'monemi' = SPACE(5)          ,
  'codmon' = 0           ,
  'codser' = 0           ,
  'familia' = SPACE(12)          ,
  'largo_util' = 0           ,
  'nominal' = ISNULL(CONVERT(NUMERIC(19,4),cpnominal),0)      ,
  'tircomp' = ISNULL(CONVERT(NUMERIC(19,4),cptircomp ),0)      ,
  'vptirc' = ISNULL(CONVERT(NUMERIC(19,4),cpvptirc ),0)      ,
  'factor' = CONVERT(NUMERIC(9,5),0)        ,
  'vpmcd'  = ISNULL(CONVERT(NUMERIC(19,4),0),0)       ,
  'difmcdo' = ISNULL(CONVERT(NUMERIC(19,4),0),0)       ,
  'mascara' = ISNULL(cpmascara,'')         ,
  'codfam' = ISNULL(cpcodigo, 0)         ,
  'dfecven' = ISNULL(cpfecven,'')         ,
  'cartera' = 'CARTERA PROPIA DISPONIBLE'        ,
  'edw'  = ''
 INTO #TEMP1
 FROM MDAC, MDCP
 WHERE cpnominal>0
 INSERT INTO #TEMP1 
   (
   nomemp  ,
   rutemp  ,
   fecpro  ,
   fecppro  ,
   numdoc  ,
   numoper  ,
   rutcart  ,
   correla  ,
   numdocu  ,
   tipoper  ,
   serie  ,
   seriado  ,
   fecemi  ,
   fecven  ,
   tasemi  ,
   basemi  ,
   monemi  ,
   codmon  ,
   codser  ,
   familia  ,
   largo_util ,
   nominal  ,
   tircomp  ,
   vptirc  ,
   factor  ,
   vpmcd  ,
   difmcdo  ,
         mascara  ,
   codfam  ,
   dfecven  ,
   cartera  ,
   edw
   )
 SELECT
   ISNULL(acnomprop,'')         ,
   ISNULL((RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop ),'')    ,
   CONVERT(CHAR(10),acfecproc,103)        ,
   CONVERT(CHAR(10),acfecprox,103)        ,
   ISNULL(vinumdocu,0)         ,
   ISNULL(vinumoper,0)         ,
   ISNULL(virutcart,0)         ,
   ISNULL(vicorrela,0)         ,
   RTRIM(CONVERT(CHAR(10),ISNULL(vinumdocu,0)))+'-'+CONVERT(CHAR(3),ISNULL(vicorrela,0)) ,
   'VI'           ,
   ISNULL(viinstser,'')        ,
   SPACE(01)          ,
   CONVERT(CHAR(10),vifecemi,103)        ,
   CONVERT(CHAR(10),vifecven,103)        ,
   CONVERT(NUMERIC(19,4),0)        ,
   CONVERT(NUMERIC(03,0),0)        ,
   SPACE(5)          ,
   0           ,
   0           ,
   SPACE(12)          ,
   0           ,
   ISNULL(CONVERT(NUMERIC(19,4),vinominal),0)      ,
   ISNULL(CONVERT(NUMERIC(19,4),vitircomp ),0)      ,
   0,--ISNULL(CONVERT(NUMERIC(19,4),vivptirc ),0)      ,
   0           ,
   0           ,
   0           ,
   ISNULL(vimascara,'')         ,
   ISNULL(vicodigo, 0)         ,
   ISNULL(vifecven,'')         ,
   'CARTERA PROPIA INTER'        ,
   ''                          
 FROM MDAC, MDVI
 WHERE vinominal>0 AND vitipoper='CP'
 UPDATE #TEMP1
 SET seriado = cpseriado ,
  codser  = cpcodigo
 FROM MDCP
 WHERE tipoper='CP' AND cprutcart=rutcart AND cpnumdocu=numdoc AND cpcorrela=correla
 UPDATE #TEMP1
 SET vptirc = vptirc - rsreajuste
 FROM MDRS
 WHERE tipoper='CP' AND rscartera='111' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='DEV'
 UPDATE #TEMP1
 SET vptirc  = vptirc + rsvppresenx
 FROM MDRS
 WHERE tipoper='CP' AND rscartera='111' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='VC' AND CHARINDEX(CONVERT(CHAR(3),rscodigo),'  6   7   9 11888')=0
 UPDATE #TEMP1
 SET vptirc  = vptirc + rsvppresenx
 FROM MDFM
 WHERE tipoper='CP' AND rscartera='111' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='VC' AND CHARINDEX(CONVERT(CHAR(3),rscodigo),'  6   7   9 11888')=0
 UPDATE #TEMP1
 SET seriado = viseriado ,
  codser  = vicodigo
 FROM MDVI
 WHERE tipoper='VI' AND virutcart=rutcart AND vinumdocu=numdoc AND vicorrela=correla
 UPDATE #TEMP1
 SET vptirc = vptirc - rsreajuste
 FROM MDRS
 WHERE tipoper='VI' AND rscartera='114' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='DEV'
 UPDATE #TEMP1
 SET vptirc = vptirc + rsvppresenx
 FROM MDRS
 WHERE tipoper='VI' AND rscartera='114' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='VC' AND CHARINDEX(CONVERT(CHAR(3),rscodigo),'  6   7   9 11888')=0
 UPDATE #TEMP1
 SET vptirc = vptirc + rsvppresenx
 FROM MDFM
 WHERE tipoper='VI' AND rscartera='114' AND rsrutcart=rutcart AND rsnumdocu=numdoc AND
  rsnumoper=numoper AND rscorrela=correla AND rstipoper='VC' AND CHARINDEX(CONVERT(CHAR(3),rscodigo),'  6   7   9 11888')=0
 UPDATE #TEMP1
 SET familia = inserie
 FROM VIEW_INSTRUMENTO
 WHERE codser=incodigo
 UPDATE #TEMP1
 SET Largo_UTIL = DATALENGTH(msmascara)
 FROM VIEW_MASCARA_INSTRUMENTO
 WHERE familia=msfamilia 
 UPDATE #TEMP1
 SET tasemi = ISNULL(setasemi,0) ,
  basemi = ISNULL(sebasemi,0) ,
  codmon = semonemi  ,
  monemi = ''
 FROM VIEW_SERIE
 WHERE seriado='S' AND mascara=seserie
 UPDATE #TEMP1
 SET tasemi = ISNULL(nstasemi,0) ,
  basemi = ISNULL(nsbasemi,0) ,
  codmon = nsmonemi  ,
  monemi = ''
 FROM VIEW_NOSERIE
 WHERE seriado<>'S' AND rutcart=nsrutcart AND numdoc=nsnumdocu AND correla=nscorrela
 UPDATE #TEMP1
 SET monemi = ISNULL(mnnemo,'')
 FROM VIEW_MONEDA
 WHERE codmon=mncodmon
 UPDATE #TEMP1
 SET factor = ISNULL(rmfactor,0) ,
  vpmcd = ISNULL(rmvalormer,0) ,
  serie = rminstser
 FROM MDRM
 WHERE rmrutcart=rutcart AND rmnumdocu=numdoc AND rmnumoper=numoper AND
  rmcorrela=correla AND rmtipoper=tipoper
 UPDATE #TEMP1
 SET difmcdo = ISNULL(vpmcd,0)-ISNULL(vptirc,0)
 WHERE dfecven > DATEADD(DAY,365,@dFecpro)
 UPDATE #TEMP1
 SET edw = '1'  ,
  codser  = 100  ,
  codfam  = 100
 WHERE SUBSTRING(serie,1,3)='EDW'
         SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
                'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
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
                'hora' = CONVERT(varchar(10), GETDATE(), 108),
                nomemp  ,  --1
  rutemp  ,  --2
  fecpro  ,  --3
  fecppro  ,  --4
  numdocu  ,  --5
  serie  ,  --6
  fecemi  ,  --7
  fecven  ,  --8
  tasemi  ,  --9
  basemi  ,  --10
  monemi  ,  --11
  cartera  ,  --12
  nominal  ,  --13
  tircomp  ,  --14
  vptirc  ,  --15
  factor  ,  --16
  vpmcd  ,  --17
  difmcdo  ,  --18
  codfam    --19
 FROM #TEMP1, #parametros
 ORDER BY tipoper, codfam, serie, numdoc, correla
 IF DATEPART(DAY,@dFecpro)>=26
 BEGIN
            PRINT 'YA ENTRÉ'
  IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' AND NAME=@cArch)
  BEGIN
   SELECT @cStrexec  = 'SELECT * INTO '+@cArch+' FROM #TEMP1'
   EXECUTE (@cStrexec)
  END
  ELSE
  BEGIN
   SELECT @cStrexec  = 'DROP TABLE '+@cArch
   EXECUTE (@cStrexec)
   SELECT @cStrexec  = 'SELECT * INTO '+@cArch+' FROM #TEMP1'
   EXECUTE (@cStrexec)
  END
 END
END

GO

USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_RCC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INTERFAZ_RCC]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dFecpro DATETIME ,
  @dFecprox DATETIME ,
  @dFinmes DATETIME ,
  @iX  INTEGER  ,
  @nContador INTEGER  ,
  @nNominal NUMERIC (19,4) ,
  @nVpres  NUMERIC (19,0) ,
  @nNumdocu NUMERIC (10,0) ,
  @nCorrela NUMERIC (03,0) ,
  @iConta  INTEGER  ,
  @iSw  INTEGER  ,
  @nMonto  NUMERIC (19,0) ,
  @cMarca  CHAR (10)
 SELECT @dFecpro = acfecproc ,
  @dFecprox = acfecprox
 FROM MDAC
 SELECT rut   = CASE
      WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
      ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
       END     ,
  dv   = '0'     ,
  ctacontable       ,
  cpnumdocu       ,
  moneda   = CASE
      WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
      ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
       END       ,
  tipreaj   = 0       ,
  fecha_compra  = CONVERT(CHAR(10),cpfeccomp,112) ,
  fecha_proceso  = CONVERT(CHAR(10),@dFecpro,112) ,
  fecha_ultcupon  = CONVERT(CHAR(10),CASE WHEN cpfecucup < cpfeccomp THEN cpfeccomp ELSE cpfecucup END,112),
  fecha_venciemiento = CONVERT(CHAR(10),cpfecven,112) ,
  cptircomp       ,
  cpvptirc       ,
  vpres_um   = cpvptirc    ,
  centro_costo   = 2115     ,
  cuenta_cliente   = 0     ,
  cpcorrela       ,
  'sw'   = ' '     ,
  codmon   = CONVERT(NUMERIC(03),0)  ,
  cpfeccomp       ,
  cpnominal       
 INTO #TRCC
 FROM MDCP ,CARTERA_CUENTA
 WHERE cpnumdocu=numdocu AND cpcorrela=correla AND cpcodigo IN (15,9,14,11,992) AND variable='Valor_compra'
 INSERT INTO
 #TRCC
 SELECT CASE
   WHEN cpseriado='N' THEN (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT serutemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
  END        ,
  '0'        ,
  ctacontable       ,
  cpnumdocu       ,
  CASE
   WHEN cpseriado='N' THEN (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
   ELSE (SELECT semonemi FROM VIEW_SERIE WHERE secodigo=cpcodigo AND cpmascara=semascara)
  END        ,
  0        ,
  CONVERT(CHAR(10),cpfeccomp,112)     ,
  CONVERT(CHAR(10),@dFecpro,112)     ,
  CONVERT(CHAR(10),CASE WHEN cpfecucup < cpfeccomp THEN cpfeccomp ELSE cpfecucup END,112),
  CONVERT(CHAR(10),cpfecven,112)     ,
  cptircomp       ,
  cpvptirc       ,
  cpvptirc       ,
  2115        ,
  0        ,
  cpcorrela       ,
  ' '        ,
  0        ,
  cpfeccomp       ,
  cpnominal
 FROM MDCP ,CARTERA_CUENTA
 WHERE cpnumdocu=numdocu AND cpcorrela=correla AND variable='Valor_compra' AND
  cpcodigo=20 AND (cptipoletra='O' OR cptipoletra='E')
 INSERT INTO
 #TRCC
 SELECT cirutcli     ,
  '0'      ,
  ctacontable     ,
  cinumdocu     ,
  cimonpact     ,
  tipreaj     = 0 ,
  CONVERT(CHAR(10),cifeccomp,112)   ,
  CONVERT(CHAR(10),@dFecpro,112)   ,
  CONVERT(CHAR(10),cifeccomp,112)   ,
  CONVERT(CHAR(10),cifecvenp,112)   ,
  citaspact     ,
  civptirci     ,
  civptirci     ,
  centro_costo    = 2115 ,
  cuenta_cliente    = 0 ,
  0      ,
  ' '      ,
  0      ,
--  cimonpact     ,
  cifeccomp     ,
  cinominal
 FROM MDCI, CARTERA_CUENTA
 WHERE cinumdocu=numdocu AND cicorrela=correla AND cicodigo=codigoinst AND ciinstser<>'ICAP' AND
  variable='valor_compra'
 UPDATE #TRCC
 SET vpres_um = ROUND(cpvptirc / vmvalor,2)
 FROM  view_valor_moneda
 WHERE vmfecha = @dFecpro
 AND vmcodigo = moneda
 AND moneda <> 999
 UPDATE #TRCC
 SET tipreaj  = CASE
     WHEN moneda=999 THEN 0
     WHEN moneda=998 THEN 1
     ELSE 2
      END   ,
  cuenta_cliente = clctacte  ,
  dv  = cldv   
--  centro_costo = clcosto
 FROM VIEW_CLIENTE
 WHERE clrut=rut 
 UPDATE #TRCC
 SET dv  = emdv
 FROM VIEW_EMISOR
 WHERE emrut=emrut AND dv=0
 SELECT @dFinMes = DATEADD(MONTH,1,@dFecpro)
 SELECT @dFinMes = STR(DATEPART(YEAR,@dFinMes))+REPLACE(STR(DATEPART(MONTH,@dFinMes),2),' ','0')+'01'
 SELECT @dFinMes = DATEADD(DAY,-1,@dFinMes)
 
 IF @dFecpro<@dFinMes AND @dFecprox>@dFinMes
  UPDATE #TRCC
  SET cpvptirc = rsvppresen
  FROM MDRS
  WHERE cpnumdocu=rsnumdocu AND cpcorrela=rscorrela AND rstipoper='DEV' AND rscartera='111' AND
   rsfecha=@dFinMes
 UPDATE #TRCC
 SET sw = 'S'
 WHERE tipreaj=0
 AND cpnominal >= 1000000000.0  --LEN(RTRIM(LTRIM(STR(CONVERT(NUMERIC(19),cpnominal)))))>=9
 WHILE 1=1
 BEGIN
  SELECT @cMarca = '*'
  SET ROWCOUNT 1
  SELECT  @nNominal = cpnominal  ,
   @nNumdocu = cpnumdocu  ,
   @nCorrela = cpcorrela  ,
   @cMarca  = fecha_compra  ,
   @nVpres  = cpvptirc
  FROM #TRCC
  WHERE sw = 'S'
  SET ROWCOUNT 0
  IF @cMarca='*'
   BREAK
  SELECT @iConta  = 0  ,
   @iSw  = 0  ,
   @nMonto  = 0
  WHILE @iSw=0
  BEGIN
   SELECT @iConta = @iConta + 1
   SELECT @nMonto = ROUND((@nNominal/@iConta),0)
   IF @nMonto<1000000000
    SELECT @iSw = 1
  END
  WHILE @iSw<=@iConta
  BEGIN
    INSERT INTO
    #TRCC
    SELECT rut   ,
     dv   ,
     ctacontable  ,
     CONVERT(NUMERIC(10),LTRIM(RTRIM(CONVERT(CHAR(10),cpnumdocu))) + LTRIM(RTRIM(CONVERT(CHAR(2),@iSw)))),
     moneda   ,
     tipreaj   ,
     fecha_compra  ,
     fecha_proceso  ,
     fecha_ultcupon  ,
     fecha_venciemiento ,
     cptircomp  ,
     ROUND(@nVpres * ( @nMonto / @nNominal ), 0) ,
     ROUND(@nVpres * ( @nMonto / @nNominal ), 0) ,
     centro_costo  ,
     cuenta_cliente  ,
     cpcorrela  ,
     'N'   ,
     codmon   ,
     ''   ,
     0 
    FROM #TRCC
    WHERE cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela
    SELECT @iSw = @iSw + 1
  END
  UPDATE #TRCC
  SET sw = 'D'
  WHERE cpnumdocu=@nNumdocu
  AND cpcorrela=@nCorrela
   
 END
 DELETE #TRCC WHERE sw = 'D'
 UPDATE #TRCC
 SET ctacontable = cta_sbif
 FROM  view_plan_de_cuenta 
 WHERE cuenta = ctacontable
 AND cta_sbif <> ''
 UPDATE #TRCC
 SET codmon = moneda
 UPDATE #TRCC SET moneda = 99 WHERE codmon = 998
 UPDATE #TRCC SET moneda = 5  WHERE codmon = 994
 UPDATE #TRCC SET moneda = 11 WHERE codmon = 13
 UPDATE #TRCC SET moneda = 92 WHERE codmon = 997
 UPDATE #TRCC SET moneda = 0  WHERE codmon = 999
 IF NOT EXISTS(SELECT * FROM #TRCC)
 BEGIN
  SELECT 'OK'
  RETURN
 END  
 SELECT * FROM #TRCC
 
 SET NOCOUNT OFF
END
-- SP_INTERFAZ_RCC
-- select convert(datetime,'20010501')
-- select convert(datetime,'2001 501')
-- select cpinstser from mdcp where ((cptipoletra='O' OR cptipoletra='E') AND cpcodigo=20) AND CHARINDEX(STR(cpcodigo,3),' 15-  9- 14- 11-992- 20')>0
-- select * from mdcp where cpcodigo IN (15,9,14,11,992)
-- select centro_costo,* from CARTERA_CUENTA
-- delete CARTERA_CUENTA
-- select * from mdcp where cpnumdocu=47753
-- select * from mdci where cinumdocu=47753
-- select morutemi,* from mdmo where morutemi = 97018000
-- select * from view_emisor

GO

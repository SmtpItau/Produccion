USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_CARTERA_CPL]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_CARTERA_CPL]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dfecproc  DATETIME ,
  @dfecprox  DATETIME ,
  @nTasaCam FLOAT  ,
  @nNumdocu NUMERIC(10) ,
  @nNumoper NUMERIC(10) ,
  @nCorrela NUMERIC(10) ,
  @Sw_While CHAR(1)  ,
  @fecini  DATETIME ,
  @fecven  DATETIME ,
  @fecha_habil DATETIME ,
  @nDiasF  float  ,
  @nDiasMesA float  ,
  @nDiasMesP float  ,
  @nValUfHoy NUMERIC(19,4) ,
  @nValUfAnt NUMERIC(19,4)
 SELECT @dfecproc = acfecproc,
  @dfecprox = acfecprox
 FROM mdac
 DECLARE @Resultado_Cpl  FLOAT
 DECLARE @Resultado_Lpl  FLOAT
 DECLARE @dfecfmes  DATETIME
 DECLARE @dfecimes  DATETIME
 SELECT @dfecfmes = @dfecprox,
  @dfecimes = @dfecprox
 IF DATEDIFF(MONTH,@dfecproc,@dfecprox)=1
  IF DATEPART(DAY,@dfecprox)>1
   SELECT @dfecimes = DATEADD(day, DATEPART(DAY,@dfecprox) * -1, @dfecprox) + 1
 IF DATEDIFF(MONTH,@dfecproc,@dfecprox)=1
  IF DATEPART(DAY,@dfecprox)>1
   SELECT @dfecfmes = DATEADD(day, DATEPART(DAY,@dfecprox) * -1, @dfecprox)
 SELECT  @nTasaCam = 0
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 SELECT  @nDiasF    = DATEDIFF(day,acfecproc,acfecprox) FROM mdac
 SELECT  @nDiasMesA = DATEDIFF(day,acfecproc,@dfecimes) FROM mdac
 SELECT  @nDiasMesP = DATEDIFF(day,@dfecimes,acfecprox) FROM mdac
 SELECT  @nValUfHoy = vmvalor
 FROM  view_valor_moneda, mdac
 WHERE vmcodigo = 998
 AND vmfecha = acfecproc
 SELECT  @nValUfAnt = vmvalor
 FROM  view_valor_moneda, mdac
 WHERE vmcodigo = 998
 AND vmfecha = acfecante
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 CREATE TABLE #temp_cp(
  fecproc  DATETIME ,
  tipoper  CHAR(03) ,
  numdocu  NUMERIC(10) ,
  numoper  NUMERIC(10) ,
  correla  NUMERIC(10) ,
  instser  CHAR(10) ,
  mascara  CHAR(10) ,
  moneda  NUMERIC(03) ,
  nominal  NUMERIC(19,4) ,
  valcomp  NUMERIC(19,4) ,
  valcomu  NUMERIC(19,4) ,
  vpresen  NUMERIC(19,4) ,
  fecini  DATETIME ,
  fecven  DATETIME ,
  rutcli  NUMERIC(10) ,
  codcli  NUMERIC(10) ,
  tasa  NUMERIC(19,4) ,
  tasaefec NUMERIC(19,4) ,
  tasacam  NUMERIC(19,4) ,
  basetasa NUMERIC(3) ,
  resultado FLOAT  ,
  sw  CHAR(01) ,
  fecini_nexth DATETIME ,
  fecven_nexth DATETIME ,
  valmonini_nexth NUMERIC(19,4) ,
  seriado  CHAR(1)  ,
  codigo  NUMERIC(03) ,
  costo  NUMERIC(19,4) ,
  interes  NUMERIC(19,4) ,
  reajuste NUMERIC(19,4) ,
  forpag  NUMERIC(4) ,
  difdia  NUMERIC(4) )
 INSERT INTO #temp_cp
 SELECT @dfecproc ,
  'CP'  ,
  cpnumdocu ,
  cpnumdocu ,
  cpcorrela ,
  cpinstser ,
  cpmascara ,
  0  ,
  cpnominal ,
  cpvalcomp ,
  cpvalcomu ,
  cpvptirc ,
  cpfeccomp ,
  cpfecven ,
  cprutcli ,
  cpcodcli ,
  cptircomp ,
  0  ,
  @nTasaCam ,
  0  ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  cpseriado ,
  cpcodigo ,
  0  ,
  0  ,
  0  ,
  0  ,
  0
 FROM mdcp
 WHERE cpnominal > 0
 INSERT INTO #temp_cp
 SELECT @dfecproc ,
  'VI'  ,
  vinumdocu ,
  vinumoper ,
  vicorrela ,
  viinstser ,
  vimascara ,
  0  ,
  vinominal ,
  vivalcomp ,
  vivalcomu ,
  vivptirv ,
  vifeccomp ,
  vifecven ,
  virutcli ,
  vicodcli ,
  vitircomp ,
  0  ,
  @nTasaCam ,
  0  ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  viseriado ,
  vicodigo ,
  0  ,
  0  ,
  0  ,
  0  ,
  0
 FROM mdvi
 UPDATE #temp_cp
 SET forpag=cpforpagi
 FROM  mdcp
 WHERE numdocu = cpnumdocu
 AND correla = cpcorrela
 UPDATE #temp_cp
 SET moneda=nsmonemi,
  basetasa=nsbasemi
 FROM  view_noserie
 WHERE seriado = 'N'
 AND numdocu = nsnumdocu
 AND correla = nscorrela
 UPDATE #temp_cp
 SET moneda=semonemi,
  basetasa=sebasemi
 FROM  view_serie
 WHERE seriado = 'S'
 AND mascara = semascara
 DELETE #temp_cp
 WHERE moneda<>999
 AND moneda<>998
 AND moneda<>997
 DELETE #temp_cp
 WHERE codigo <> 6
 AND codigo <> 7
 AND codigo <> 9
 AND codigo <> 11
 AND codigo <> 15
 AND codigo <> 888
 AND codigo <> 300
 AND codigo <> 20
 AND codigo <> 4
 UPDATE #temp_cp
 SET interes = rsinteres,
  reajuste = rsreajuste
 FROM mdrs
 WHERE rsfecha = @dfecfmes
 AND rscartera = '111'
 AND rsnumdocu = numdocu
 AND rscorrela = correla
 AND rstipoper = 'DEV'
 AND tipoper = 'CP'
 UPDATE #temp_cp
 SET interes = rsinteres,
  reajuste = rsreajuste
 FROM mdrs
 WHERE rsfecha = @dfecfmes
 AND rscartera = '114'
 AND rsnumdocu = numdocu
 AND rsnumoper = numoper
 AND rscorrela = correla
 AND rstipoper = 'DEV'
 AND tipoper = 'VI'
 IF @dfecimes < @dfecprox
 BEGIN
  UPDATE #temp_cp
  SET interes = interes + rsinteres,
   reajuste = reajuste + rsreajuste
  FROM mdrs
  WHERE rsfecha = @dfecprox
  AND rscartera = '111'
  AND rsnumdocu = numdocu
  AND rscorrela = correla
  AND rstipoper = 'DEV'
  AND tipoper = 'CP'
  UPDATE #temp_cp
  SET interes = interes + rsinteres,
   reajuste = reajuste + rsreajuste
  FROM mdrs
  WHERE rsfecha = @dfecprox
  AND rscartera = '114'
  AND rsnumdocu = numdocu
  AND rsnumoper = numoper
  AND rscorrela = correla
  AND rstipoper = 'DEV'
  AND tipoper = 'VI'
 END
--select * from #temp_cp
 WHILE 1=1
 BEGIN
  SELECT @Sw_While = '*'
  SET ROWCOUNT 1
  SELECT @nNumdocu = Numdocu ,
   @nNumoper = Numoper ,
   @nCorrela = Correla ,
   @fecini  = fecini ,
   @fecven  = fecven ,
   @Sw_While = 'x'
  FROM  #temp_cp
  WHERE sw='N'
   
  SET ROWCOUNT 0
  IF @Sw_While = '*' BREAK
  EXECUTE SP_BUSCA_FECHA_HABIL @fecini , 1 , @fecha_habil OUTPUT
  UPDATE #temp_cp
  SET sw='S',
   fecini_nexth=@fecha_habil
  WHERE Numdocu = @nNumdocu
  AND Numoper = @nNumoper
  AND Correla = @nCorrela
  EXECUTE SP_BUSCA_FECHA_HABIL @fecven , 1 , @fecha_habil OUTPUT
  UPDATE #temp_cp
  SET sw='S',
   fecven_nexth=@fecha_habil
  WHERE Numdocu = @nNumdocu
  AND Numoper = @nNumoper
  AND Correla = @nCorrela
 END
 UPDATE #temp_cp
 SET valmonini_nexth = 1
 UPDATE #temp_cp
 SET valmonini_nexth = vmvalor
 FROM view_valor_moneda
 WHERE moneda <> 999
 AND vmcodigo = moneda
 AND vmfecha = fecini_nexth
 UPDATE #temp_cp
 SET difdia = CASE
    WHEN codigo = 7   THEN DATEDIFF(day,fecini_nexth,fecven      )
    WHEN codigo = 300 THEN DATEDIFF(day,fecini_nexth,fecven      )
    WHEN codigo = 11  THEN DATEDIFF(day,fecini_nexth,fecven_nexth)
    WHEN codigo = 6   THEN DATEDIFF(day,fecini_nexth,fecven      )
    WHEN codigo = 9   THEN DATEDIFF(day,fecini_nexth,fecven_nexth)
    END
 WHERE codigo IN(6,7,9,11,300)
 AND forpag <> 4
 AND forpag <> 8
 
 UPDATE #temp_cp
 SET tasaefec = CASE
    WHEN codigo = 7   THEN ( ( ( ( nominal / ( valcomp / valmonini_nexth ) ) - 1 ) * 360 ) / difdia ) * 100
    WHEN codigo = 300 THEN ( ( ( ( nominal / ( valcomp / valmonini_nexth ) ) - 1 ) * 360 ) / difdia ) * 100
    WHEN codigo = 11  THEN ( ( ( ( nominal / ( valcomp / valmonini_nexth ) ) - 1 ) * 360 ) / difdia ) * 100
    WHEN codigo = 6   THEN ( ( ( ( nominal / valcomp                       ) - 1 ) * 30  ) / difdia ) * 100
    WHEN codigo = 9   THEN ( ( ( ( nominal / valcomp                       ) - 1 ) * 30  ) / difdia ) * 100
    END
 WHERE codigo IN(6,7,9,11,300)
 AND forpag <> 4
 AND forpag <> 8
 UPDATE #temp_cp
 SET tasaefec = Tasa
 WHERE codigo IN(6,7,9,11,300)
 AND forpag IN (4, 8)
 UPDATE #temp_cp
 SET resultado = CASE
    WHEN codigo = 6 THEN vpresen * (( tasaefec - @nTasaCam )/100.0) * @nDiasF/30.0
    WHEN codigo = 7 THEN vpresen * ( (((( ( 1.0 +  ((tasaefec/100.0) * (@nDiasF/360.0)) ) * (@nValUfHoy/@nValUfAnt) ) -1 )* (30.0 /@nDiasF) ) - (@nTasaCam/100.0) ) ) *  (@nDiasF/30.0)
    END
 WHERE codigo IN(6,7)
 UPDATE #temp_cp
 SET costo = ( vpresen * (@nTasaCam/100.0) * @nDiasF )/30.0
 WHERE NOT codigo IN(6,7)
 UPDATE #temp_cp
 SET resultado = interes+reajuste-costo
 WHERE NOT codigo IN(6,7)
 DELETE renta_cp
 WHERE fecproc = @dfecproc
 UPDATE #temp_cp
 SET resultado = ROUND(resultado,0)
--select @nDiasMesA / @nDiasF , @nDiasMesA,@nDiasF 
 INSERT INTO renta_cp
 SELECT  @dfecproc ,
  tipoper  ,
  numdocu  ,
  numoper  ,
  correla  ,
  instser  ,
  mascara  ,
  moneda  ,
  nominal  ,
  valcomp  ,
  valcomu  ,
  vpresen  ,
  fecini  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasaefec ,
  tasacam  ,
  basetasa ,
  resultado * ( @nDiasMesA / @nDiasF ),
  seriado  ,
  codigo  ,
  costo  ,
  interes   * ( @nDiasMesA / @nDiasF ),
  reajuste  * ( @nDiasMesA / @nDiasF )
 FROM #temp_cp
 SELECT @Resultado_Cpl = 0,
  @Resultado_Lpl = 0
 SELECT  @Resultado_Cpl = ISNULL(SUM(resultado),0)  FROM renta_cp WHERE fecproc = @dfecproc AND       codigo IN (6,7,9,11)
 SELECT  @Resultado_Lpl = ISNULL(SUM(resultado),0)  FROM renta_cp WHERE fecproc = @dfecproc AND NOT ( codigo IN (6,7,9,11) )
 IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecproc )
  UPDATE renta_resumen
  SET cartera_cpl = @Resultado_Cpl,
   cartera_lpl = @Resultado_Lpl
  WHERE fecproc = @dfecproc
 ELSE
  INSERT INTO renta_resumen(
   fecproc  ,
   interb  ,
   cartera_cpl ,
   cartera_lpl ,
   pactos_ci ,
   pactos_vi ,
   ventas_cpl ,
   ventas_lpl )
  SELECT  @dfecproc ,
   0  ,
   @Resultado_Cpl ,
   @Resultado_Lpl ,
   0  ,
   0  ,
   0  ,
   0
 IF @dfecimes < @dfecprox
 BEGIN
  DELETE renta_cp
  WHERE fecproc = @dfecimes
  INSERT INTO renta_cp
  SELECT  @dfecimes ,
   tipoper  ,
   numdocu  ,
   numoper  ,
   correla  ,
   instser  ,
   mascara  ,
   moneda  ,
   nominal  ,
   valcomp  ,
   valcomu  ,
   vpresen  ,
   fecini  ,
   fecven  ,
   rutcli  ,
   codcli  ,
   tasa  ,
   tasaefec ,
   tasacam  ,
   basetasa ,
   resultado * ( @nDiasMesP / @nDiasF ),
   seriado  ,
   codigo  ,
   costo  ,
   interes   * ( @nDiasMesP / @nDiasF ),
   reajuste  * ( @nDiasMesP / @nDiasF )
  FROM #temp_cp
  SELECT @Resultado_Cpl = 0,
   @Resultado_Lpl = 0
  SELECT  @Resultado_Cpl = ISNULL(SUM(resultado),0)  FROM renta_cp WHERE fecproc = @dfecimes AND       codigo IN (6,7,9,11)
  SELECT  @Resultado_Lpl = ISNULL(SUM(resultado),0)  FROM renta_cp WHERE fecproc = @dfecimes AND NOT ( codigo IN (6,7,9,11) )
  IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecimes )
   UPDATE renta_resumen
   SET cartera_cpl = @Resultado_Cpl,
    cartera_lpl = @Resultado_Lpl
   WHERE fecproc = @dfecimes
  ELSE
   INSERT INTO renta_resumen(
    fecproc  ,
    interb  ,
    cartera_cpl ,
    cartera_lpl ,
    pactos_ci ,
    pactos_vi ,
    ventas_cpl ,
    ventas_lpl )
   SELECT  @dfecimes ,
    0  ,
    @Resultado_Cpl ,
    @Resultado_Lpl ,
    0  ,
    0  ,
    0  ,
    0
 END
 SET NOCOUNT OFF
END
-- SELECT * FROM renta_cp
-- SELECT * FROM renta_resumen
-- select * from mdcp where cpforpagi=8
-- select rstipoper,* from mdrs where rscartera = '121'
-- select * from  view_instrumento
-- select * from  view_forma_de_pago
-- sp_help mdcp

GO

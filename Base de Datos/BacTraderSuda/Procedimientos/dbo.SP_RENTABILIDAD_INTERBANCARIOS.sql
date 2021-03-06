USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_INTERBANCARIOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_INTERBANCARIOS]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dfecproc  DATETIME ,
  @dfecprox  DATETIME ,
  @nTasaCam FLOAT  ,
  @nNumdocu NUMERIC(10) ,
  @Sw_While CHAR(1)  ,
  @fecini  DATETIME ,
  @fecven  DATETIME ,
  @fecha_habil DATETIME ,
  @nDiasF  FLOAT
 DECLARE @Resultado  FLOAT
 SELECT  @dfecproc = acfecproc,
  @dfecprox = acfecprox
 FROM mdac
 SELECT  @nTasaCam = 0
 SELECT  @nDiasF   = DATEDIFF(day,acfecproc,acfecprox) FROM mdac
 DECLARE @dfecfmes  DATETIME
 DECLARE @dfecimes  DATETIME ,
  @nDiasMesA FLOAT  ,
  @nDiasMesP FLOAT
 SELECT @dfecfmes = @dfecprox,
  @dfecimes = @dfecprox
 IF DATEDIFF(MONTH,@dfecproc,@dfecprox)=1
  IF DATEPART(DAY,@dfecprox)>1
   SELECT @dfecimes = DATEADD(day, DATEPART(DAY,@dfecprox) * -1, @dfecprox) + 1
 IF DATEDIFF(MONTH,@dfecproc,@dfecprox)=1
  IF DATEPART(DAY,@dfecprox)>1
   SELECT @dfecfmes = DATEADD(day, DATEPART(DAY,@dfecprox) * -1, @dfecprox)
 SELECT  @nDiasF    = DATEDIFF(day,acfecproc,acfecprox) FROM mdac
 SELECT  @nDiasMesA = DATEDIFF(day,acfecproc,@dfecimes) FROM mdac
 SELECT  @nDiasMesP = DATEDIFF(day,@dfecimes,acfecprox) FROM mdac
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 CREATE TABLE #temp_ib(
  fecproc  DATETIME ,
  tipoper  CHAR(03) ,
  numdocu  NUMERIC(10) ,
  instser  CHAR(10) ,
  moneda  NUMERIC(03) ,
  nominal  NUMERIC(19,4) ,
  valcomp  NUMERIC(19,4) ,
  valcomu  NUMERIC(19,4) ,
  fecini  DATETIME ,
  fecven  DATETIME ,
  rutcli  NUMERIC(9) ,
  codcli  NUMERIC(9) ,
  tasa  NUMERIC(9,4) ,
  tasaefec NUMERIC(9,4) ,
  tasacam  NUMERIC(9,4) ,
  basetasa NUMERIC(3) ,
  resultado FLOAT  ,
  sw  CHAR(01) ,
  fecini_nexth DATETIME ,
  fecven_nexth DATETIME ,
  valmonini_nexth NUMERIC(19,4) ,
  forpag  NUMERIC(3) )
 INSERT INTO #temp_ib
 SELECT @dfecproc ,
  rstipoper ,
  rsnumdocu ,
  rsinstser ,
  rsmonemi ,
  rsnominal ,
  rsvalinip ,
  0  ,
  rsfecinip ,
  rsfecvtop ,
  rsrutcli ,
  rscodcli ,
  rstir  ,
  0  ,
  @nTasaCam ,
  rsbasemi ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  rsforpagv 
 FROM mdrs
 WHERE rsfecha = @dfecproc
 AND rstipoper = 'VC'
 AND rscartera = '121'
 AND rsmonemi IN (998,999)
 AND rsforpagv = 1
 INSERT INTO #temp_ib
 SELECT @dfecproc ,
  'IB'  ,
  cinumdocu ,
  ciinstser ,
  cimonpact ,
  cinominal ,
  civalinip ,
  0  ,
  cifecinip ,
  cifecven ,
  cirutcli ,
  cicodcli ,
  citaspact ,
  0  ,
  @nTasaCam ,
  cibaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  ciforpagi
 FROM mdci
 WHERE ciinstser IN ('ICAP','ICOL')
 AND cimonpact IN (998,999)
 AND cifecinip < @dfecproc
 AND ciforpagi IN (1,4,6)
 INSERT INTO #temp_ib
 SELECT @dfecproc ,
  'IB'  ,
  cinumdocu ,
  ciinstser ,
  cimonpact ,
  cinominal ,
  civalinip ,
  0  ,
  cifecinip ,
  cifecven ,
  cirutcli ,
  cicodcli ,
  citaspact ,
  0  ,
  @nTasaCam ,
  cibaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  ciforpagi
 FROM mdci
 WHERE ciinstser IN ('ICAP','ICOL')
 AND cimonpact IN (998,999)
 AND cifecinip = @dfecproc
 AND ciforpagi IN (4,6)
 WHILE 1=1
 BEGIN
  SELECT @Sw_While = '*'
  SET ROWCOUNT 1
  SELECT @nNumdocu = Numdocu ,
   @fecini  = fecini ,
   @fecven  = fecven ,
   @Sw_While = 'x'
  FROM  #temp_ib
  WHERE sw='N'
   
  SET ROWCOUNT 0
  IF @Sw_While = '*' BREAK
  EXECUTE SP_BUSCA_FECHA_HABIL @fecini , 1 , @fecha_habil OUTPUT
  UPDATE #temp_ib
  SET sw='S',
   fecini_nexth=@fecha_habil
  WHERE Numdocu = @nNumdocu
  EXECUTE SP_BUSCA_FECHA_HABIL @fecven , 1 , @fecha_habil OUTPUT
  UPDATE #temp_ib
  SET sw='S',
   fecven_nexth=@fecha_habil
  WHERE Numdocu = @nNumdocu
 END
 UPDATE #temp_ib
 SET resultado = CASE
    WHEN instser = 'ICOL' THEN nominal * (( ( CASE WHEN moneda = 999 THEN tasa ELSE tasa / 12 END ) - @nTasaCam )/100.0 ) * @nDiasF/30.0
    WHEN instser = 'ICAP' THEN nominal * (( @nTasaCam - ( CASE WHEN moneda = 999 THEN tasa ELSE tasa / 12 END ) )/100.0 ) * @nDiasF/30.0
    END
 WHERE tipoper = 'VC'
 UPDATE #temp_ib
 SET resultado = CASE
    WHEN instser = 'ICOL' THEN nominal * (( ( CASE WHEN moneda = 999 THEN tasa ELSE tasa / 12 END ) - @nTasaCam )/100.0 ) * @nDiasF/30.0
    WHEN instser = 'ICAP' THEN nominal * (( @nTasaCam - ( CASE WHEN moneda = 999 THEN tasa ELSE tasa / 12 END ) )/100.0 ) * @nDiasF/30.0
    END
 WHERE tipoper = 'IB'
/*
 UPDATE #temp_ib
 SET valmonini_nexth = vmvalor
 FROM view_valor_moneda
 WHERE moneda = 998
 AND vmcodigo = moneda
 AND vmfecha = fecini_nexth
 
 UPDATE #temp_ib
 SET tasaefec = CASE
    WHEN moneda = 998 THEN ( ( nominal / ( valcomp / valmonini_nexth ) ) - 1 ) * ( 360 / DATEDIFF(day,fecini,fecini_nexth))
    WHEN moneda = 999 THEN ( ( nominal / valcomp                       ) - 1 ) * ( 360 / DATEDIFF(day,fecini,fecini_nexth))
    END
 WHERE tipoper = 'IB'
 UPDATE #temp_ib
 SET resultado = CASE
    WHEN instser = 'ICOL' THEN nominal * ( tasaefec - @nTasaCam ) * @nDiasF/30.0
    WHEN instser = 'ICAP' THEN nominal * ( @nTasaCam - tasaefec ) * @nDiasF/30.0
    END
 WHERE tipoper = 'IB'
 AND moneda = 999 
*/
 UPDATE #temp_ib
 SET resultado = ROUND(resultado,0)
 DELETE renta_ib
 WHERE fecproc = @dfecproc
 INSERT INTO renta_ib
 SELECT  fecproc  ,
  tipoper  ,
  numdocu  ,
  instser  ,
  moneda  ,
  nominal  ,
  valcomp  ,
  valcomu  ,
  fecini  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasaefec ,
  tasacam  ,
  basetasa ,
  resultado * ( @nDiasMesA / @nDiasF ),
  forpag
 FROM #temp_ib
 SELECT @Resultado = 0
 SELECT  @Resultado = ISNULL(SUM(resultado),0)  FROM renta_ib WHERE fecproc = @dfecproc
 IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecproc )
  UPDATE renta_resumen
  SET interb = @Resultado
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
   @Resultado ,
   0  ,
   0  ,
   0  ,
   0  ,
   0  ,
   0
 IF @dfecimes < @dfecprox
 BEGIN
  DELETE renta_ib
  WHERE fecproc = @dfecimes
  INSERT INTO renta_ib
  SELECT  @dfecimes  ,
   tipoper  ,
   numdocu  ,
   instser  ,
   moneda  ,
   nominal  ,
   valcomp  ,
   valcomu  ,
   fecini  ,
   fecven  ,
   rutcli  ,
   codcli  ,
   tasa  ,
   tasaefec ,
   tasacam  ,
   basetasa ,
   resultado * ( @nDiasMesP / @nDiasF ),
   forpag
  FROM #temp_ib
  SELECT @Resultado = 0
  SELECT  @Resultado = ISNULL(SUM(resultado),0)  FROM renta_ib WHERE fecproc = @dfecimes
  IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecimes )
   UPDATE renta_resumen
   SET interb = @Resultado
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
    @Resultado ,
    0  ,
    0  ,
    0  ,
    0  ,
    0  ,
    0
 END
  
 SET NOCOUNT OFF
END
-- SELECT * FROM renta_ib
-- SELECT * FROM renta_resumen
-- select citaspact,* from mdci
-- select rstipoper,* from mdrs where rscartera = '121'
-- select * from  view_moneda

GO

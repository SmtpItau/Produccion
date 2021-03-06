USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_PACTOS_CI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_PACTOS_CI]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dfecproc  DATETIME ,
  @dfecprox  DATETIME ,
  @nTasaCam FLOAT  ,
  @nNumoper NUMERIC(10) ,
  @Sw_While CHAR(1)  ,
  @fecini  DATETIME ,
  @fecven  DATETIME ,
  @fecha_habil DATETIME ,
  @nDiasF  FLOAT  ,
  @nValUfHoy NUMERIC(19,4) ,
  @nValUfAnt NUMERIC(19,4)
 DECLARE @Resultado_Ci  FLOAT
 DECLARE @Resultado_Vi  FLOAT
 SELECT @dfecproc = acfecproc,
  @dfecprox = acfecprox
 FROM mdac
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
 SELECT  @nTasaCam = 0
 SELECT  @nValUfHoy = vmvalor
 FROM  view_valor_moneda, mdac
 WHERE vmcodigo = 998
 AND vmfecha = acfecproc
 SELECT  @nValUfAnt = vmvalor
 FROM  view_valor_moneda, mdac
 WHERE vmcodigo = 998
 AND vmfecha = DATEADD(day,-1,acfecproc)
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 CREATE TABLE #temp_ib(
  tipo  INTEGER  ,
  fecproc  DATETIME ,
  tipoper  CHAR(03) ,
  numoper  NUMERIC(10) ,
  moneda  NUMERIC(03) ,
  valinip  NUMERIC(19,4) ,
  valvtop  NUMERIC(19,4) ,
  valvtop_pe NUMERIC(19,4) ,
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
  forpagi  NUMERIC(3) ,
  forpagv  NUMERIC(3) ,
  dif_real NUMERIC(5) ,
  dif_efec NUMERIC(5) ,
  dif_flo  NUMERIC(5) )
 INSERT INTO #temp_ib
 SELECT 1  ,
  @dfecproc ,
  'CI'  ,
  cinumdocu ,
  cimonpact ,
  SUM(civalinip) ,
  SUm(civalvenp) ,
  CASE WHEN cimonpact = 998 THEN SUM(civalvenp*@nValUfHoy) ELSE SUM(civalvenp) END,
  cifecinip ,
  cifecvenp ,
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
  ciforpagi ,
  ciforpagv ,
  0  ,
  0  ,
  0  
 FROM mdci, mdac
 WHERE NOT ( ciinstser IN ('ICAP','ICOL') )
 AND cifecinip < acfecproc
 GROUP BY 
  cinumdocu ,
  cimonpact ,
  cifecinip ,
  cifecvenp ,
  cirutcli ,
  cicodcli ,
  citaspact ,
  cibaspact ,
  ciforpagi ,
  ciforpagv
 INSERT INTO #temp_ib
 SELECT 2  ,
  @dfecproc ,
  'CI'  ,
  cinumdocu ,
  cimonpact ,
  SUM(civalinip) ,
  SUm(civalvenp) ,
  CASE WHEN cimonpact = 998 THEN SUM(civalvenp*@nValUfHoy) ELSE SUM(civalvenp) END,
  cifecinip ,
  cifecvenp ,
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
  ciforpagi ,
  ciforpagv ,
  0  ,
  0  ,
  0  
 FROM mdci, mdac
 WHERE NOT ( ciinstser IN ('ICAP','ICOL') )
 AND cifecinip = acfecproc
 AND ciforpagi in(4,8)
 GROUP BY 
  cinumdocu ,
  cimonpact ,
  cifecinip ,
  cifecvenp ,
  cirutcli ,
  cicodcli ,
  citaspact ,
  cibaspact ,
  ciforpagi ,
  ciforpagv
 INSERT INTO #temp_ib
 SELECT 3  ,
  @dfecproc ,
  motipoper ,
  monumdocu ,
  momonpact ,
  SUM(movalinip) ,
  SUm(movalvenp) ,
--  CASE WHEN momonpact = 998 THEN SUM(movalvenp*@nValUfHoy) ELSE SUM(movalvenp) END,
  SUM(movalvenp) , -- Viene en Pesos para los Pactos en UF
  mofecinip ,
  mofecvenp ,
  morutcli ,
  mocodcli ,
  motaspact ,
  0  ,
  @nTasaCam ,
  mobaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  moforpagi ,
  moforpagv ,
  0  ,
  0  ,
  0  
 FROM mdmo
 WHERE motipoper in ('RV','RVA')
 AND moforpagv <> 4
 AND moforpagv <> 8
 GROUP BY 
  monumdocu ,
  motipoper ,
  momonpact ,
  mofecinip ,
  mofecvenp ,
  morutcli ,
  mocodcli ,
  motaspact ,
  mobaspact ,
  moforpagi ,
  moforpagv
 INSERT INTO #temp_ib
 SELECT 1  ,
  @dfecproc ,
  'VI'  ,
  vinumoper ,
  vimonpact ,
  SUM(vivalinip) ,
  SUm(vivalvenp) ,
  CASE WHEN vimonpact = 998 THEN SUM(vivalvenp*@nValUfHoy) ELSE SUM(vivalvenp) END,
  vifecinip ,
  vifecvenp ,
  virutcli ,
  vicodcli ,
  vitaspact ,
  0  ,
  @nTasaCam ,
  vibaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  viforpagi ,
  viforpagv ,
  0  ,
  0  ,
  0  
 FROM mdvi, mdac
 WHERE vifecinip < acfecproc
 GROUP BY 
  vinumoper ,
  vimonpact ,
  vifecinip ,
  vifecvenp ,
  virutcli ,
  vicodcli ,
  vitaspact ,
  vibaspact ,
  viforpagi ,
  viforpagv
 INSERT INTO #temp_ib
 SELECT 2  ,
  @dfecproc ,
  'VI'  ,
  vinumoper ,
  vimonpact ,
  SUM(vivalinip) ,
  SUm(vivalvenp) ,
  CASE WHEN vimonpact = 998 THEN SUM(vivalvenp*@nValUfHoy) ELSE SUM(vivalvenp) END,
  vifecinip ,
  vifecvenp ,
  virutcli ,
  vicodcli ,
  vitaspact ,
  0  ,
  @nTasaCam ,
  vibaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  viforpagi ,
  viforpagv ,
  0  ,
  0  ,
  0  
 FROM mdvi, mdac
 WHERE vifecinip = acfecproc
 AND viforpagi IN (4,8)
 GROUP BY 
  vinumoper ,
  vimonpact ,
  vifecinip ,
  vifecvenp ,
  virutcli ,
  vicodcli ,
  vitaspact ,
  vibaspact ,
  viforpagi ,
  viforpagv
 INSERT INTO #temp_ib
 SELECT 3  ,
  @dfecproc ,
  motipoper ,
  monumoper ,
  momonpact ,
  SUM(movalinip) ,
  SUm(movalvenp) ,
--  CASE WHEN momonpact = 998 THEN SUM(movalvenp*@nValUfHoy) ELSE SUM(movalvenp) END,
  SUm(movalvenp) , -- Viene en Pesos para los Pactos en UF
  mofecinip ,
  mofecvenp ,
  morutcli ,
  mocodcli ,
  motaspact ,
  0  ,
  @nTasaCam ,
  mobaspact ,
  0  ,
  'N'  ,
  ''  ,
  ''  ,
  0  ,
  moforpagi ,
  moforpagv ,
  0  ,
  0  ,
  0  
 FROM mdmo
 WHERE motipoper IN ('RC','RCA')
 AND moforpagv <> 4
 AND moforpagv <> 8
 GROUP BY 
  monumoper ,
  motipoper ,
  momonpact ,
  mofecinip ,
  mofecvenp ,
  morutcli ,
  mocodcli ,
  motaspact ,
  mobaspact ,
  moforpagi ,
  moforpagv
 WHILE 1=1
 BEGIN
  SELECT @Sw_While = '*'
  SET ROWCOUNT 1
  SELECT @nNumoper = Numoper ,
   @fecini  = fecini ,
   @fecven  = fecven ,
   @Sw_While = 'x'
  FROM  #temp_ib
  WHERE sw='N'
   
  SET ROWCOUNT 0
  IF @Sw_While = '*' BREAK
  EXECUTE Sp_Busca_Fecha_Habil @fecini , 1 , @fecha_habil OUTPUT
  UPDATE #temp_ib
  SET sw='S',
   fecini_nexth=@fecha_habil
  WHERE Numoper = @nNumoper
  EXECUTE Sp_Busca_Fecha_Habil @fecven , 1 , @fecha_habil OUTPUT
  UPDATE #temp_ib
  SET sw='S',
   fecven_nexth=@fecha_habil
  WHERE Numoper = @nNumoper
 END
 UPDATE  #temp_ib
 SET dif_real = DATEDIFF(day,fecini,fecven),
  dif_efec = DATEDIFF(day,fecini_nexth,fecven_nexth),
  dif_flo  = ABS( DATEDIFF(day,fecini,fecini_nexth) - DATEDIFF(day,fecven,fecven_nexth) )
 UPDATE #temp_ib
 SET tasaefec = CASE
    WHEN moneda = 999 THEN  ROUND(  (( (tasa / 30.0) * dif_real ) / dif_efec * 30.0 ) + ( 0.09 * (@nTasaCam) * ( dif_flo / 30.0 ))   ,4)
    WHEN moneda = 998 THEN  ( 1 + ( ( (tasa * dif_real) / DATEDIFF(day,fecini_nexth,fecven_nexth)) / 360.0 ) ) + ( ( ( @nValUfHoy / @nValUfAnt ) -1 ) * 30.0)
    END
 WHERE tipo <> 2
 UPDATE #temp_ib
 SET tasaefec = CASE
    WHEN moneda = 999 THEN  tasa
    WHEN moneda = 998 THEN  ( 1 + ( tasa / 360.0 )) * ( ( ( @nValUfHoy / @nValUfAnt ) -1 ) * 30.0)
    END
 WHERE tipo = 2
 UPDATE #temp_ib
 SET resultado = (( ( (@nTasaCam - tasaefec)/100.0)/30.0) * valvtop_pe ) * @nDiasF
 WHERE tipoper in ('VI','RC','RCA')
 UPDATE #temp_ib
 SET resultado = (( ( (tasaefec - @nTasaCam)/100.0)/30.0) * valvtop_pe ) * @nDiasF
 WHERE tipoper in ('CI','RV','RVA')
 UPDATE #temp_ib
 SET resultado = ROUND(resultado,0)
 DELETE renta_ci
 WHERE fecproc = @dfecproc
 INSERT INTO renta_ci
 SELECT  @dfecproc ,
  tipoper  ,
  numoper  ,
  moneda  ,
  valinip  ,
  valvtop  ,
  fecini  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasaefec ,
  tasacam  ,
  basetasa ,
  resultado * ( @nDiasMesA / @nDiasF ),
  forpagi  ,
  forpagv  ,
  dif_flo
 FROM #temp_ib
 SELECT @Resultado_Ci = 0,
  @Resultado_Vi = 0
 SELECT  @Resultado_Ci = ISNULL(SUM(resultado),0)  FROM renta_ci WHERE fecproc = @dfecproc AND tipoper IN ('CI','RV')
 SELECT  @Resultado_Vi = ISNULL(SUM(resultado),0)  FROM renta_ci WHERE fecproc = @dfecproc AND tipoper IN ('VI','RC')
 IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecproc )
  UPDATE renta_resumen
  SET pactos_ci = @Resultado_Ci,
   pactos_vi = @Resultado_Vi
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
   0  ,
   0  ,
   @Resultado_Ci ,
   @Resultado_Vi ,
   0  ,
   0
 IF @dfecimes < @dfecprox
 BEGIN
  DELETE renta_ci
  WHERE fecproc = @dfecimes
  INSERT INTO renta_ci
  SELECT  @dfecimes ,
   tipoper  ,
   numoper  ,
   moneda  ,
   valinip  ,
   valvtop  ,
   fecini  ,
   fecven  ,
   rutcli  ,
   codcli  ,
   tasa  ,
   tasaefec ,
   tasacam  ,
   basetasa ,
   resultado * ( @nDiasMesP / @nDiasF ),
   forpagi  ,
   forpagv  ,
   dif_flo
  FROM #temp_ib
  SELECT @Resultado_Ci = 0,
   @Resultado_Vi = 0
  SELECT  @Resultado_Ci = ISNULL(SUM(resultado),0)  FROM renta_ci WHERE fecproc = @dfecimes AND tipoper IN ('CI','RV')
  SELECT  @Resultado_Vi = ISNULL(SUM(resultado),0)  FROM renta_ci WHERE fecproc = @dfecimes AND tipoper IN ('VI','RC')
  IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecimes )
   UPDATE renta_resumen
   SET pactos_ci = @Resultado_Ci,
    pactos_vi = @Resultado_Vi
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
    0  ,
    0  ,
    @Resultado_Ci ,
    @Resultado_Vi ,
    0  ,
    0
 END
/*  
 SELECT * from #temp_ib
 WHERE tasa <> tasaefec
 SELECT * from #temp_ib
 WHERE tasa = tasaefec
SELECT * FROM renta_resumen
*/
 SET NOCOUNT OFF
END
-- SELECT * FROM renta_ci
-- SELECT * FROM renta_resumen
-- select citaspact,* from mdci
-- select rstipoper,* from mdrs where rscartera = '121'
-- select * from  view_forma_de_pago

GO

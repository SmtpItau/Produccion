USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_VENTAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_VENTAS]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dfecproc  DATETIME ,
  @nTasaCam FLOAT  ,
  @nNumdocu NUMERIC(10) ,
  @nNumoper NUMERIC(10) ,
  @nCorrela NUMERIC(10) ,
  @Sw_While CHAR(1)  ,
  @fecini  DATETIME ,
  @fecven  DATETIME ,
  @fecha_habil DATETIME ,
  @nDiasF  INTEGER  ,
  @nValUfHoy NUMERIC(19,4) ,
  @nValUfAnt NUMERIC(19,4)
 DECLARE @Resultado_Cpl  FLOAT
 DECLARE @Resultado_Lpl  FLOAT
 SELECT  @dfecproc = acfecproc FROM mdac
 SELECT  @nTasaCam = 0
 SELECT  @nDiasF   = DATEDIFF(day,acfecproc,acfecprox) FROM mdac
 SELECT  @nTasaCam = vmvalor
 FROM  view_valor_moneda
 WHERE vmcodigo = 8
 AND vmfecha = @dfecproc
 CREATE TABLE #temp_vp(
  fecproc  DATETIME ,
  numdocu  NUMERIC(10) ,
  numoper  NUMERIC(10) ,
  correla  NUMERIC(10) ,
  instser  CHAR(10) ,
  mascara  CHAR(10) ,
  moneda  NUMERIC(03) ,
  nominal  NUMERIC(19,4) ,
  vpresen  NUMERIC(19,4) ,
  vventa  NUMERIC(19,4) ,
  fecven  DATETIME ,
  rutcli  NUMERIC(9) ,
  codcli  NUMERIC(9) ,
  tasa  NUMERIC(9,4) ,
  tasacam  NUMERIC(9,4) ,
  basetasa NUMERIC(3) ,
  resultado FLOAT  ,
  seriado  CHAR(1)  ,
  codigo  NUMERIC(03) ,
  forpago  NUMERIC(03) ,
  restxventa NUMERIC(19,4) )
 INSERT INTO #temp_vp
 SELECT @dfecproc ,
  monumdocu ,
  monumdocu ,
  mocorrela ,
  moinstser ,
  momascara ,
  momonemi ,
  monominal ,
  movpresen ,
  movalven ,
  mofecven ,
  morutcli ,
  mocodcli ,
  motir  ,
  @nTasaCam ,
  mobasemi ,
  0  ,
  moseriado ,
  mocodigo ,
  moforpagi ,
  CASE WHEN moutilidad > 0 THEN moutilidad
   WHEN moperdida > 0  THEN moperdida * (-1)
   END
 FROM mdmo
 WHERE motipoper = 'VP'
 AND momonemi in(999,998,997)
 AND mocodigo <> 98        
 UPDATE #temp_vp
 SET resultado = restxventa
 WHERE NOT( codigo IN (6,7) ) 
 UPDATE #temp_vp
 SET resultado = restxventa
 WHERE forpago=4
 AND codigo IN (6,7)
 UPDATE #temp_vp
 SET resultado = restxventa - ( vpresen * ( @nTasaCam/100.0 ) * (@nDiasF/30.0) * 0.91 )
 WHERE forpago<>4
 AND codigo IN (6,7)
 UPDATE #temp_vp
 SET resultado = ROUND(resultado,0)
 DELETE  renta_vp
 WHERE fecproc = @dfecproc
 INSERT INTO renta_vp
 SELECT  fecproc  ,
  numdocu  ,
  numoper  ,
  correla  ,
  instser  ,
  mascara  ,
  moneda  ,
  nominal  ,
  vpresen  ,
  vventa  ,
  fecven  ,
  rutcli  ,
  codcli  ,
  tasa  ,
  tasacam  ,
  basetasa ,
  resultado ,
  seriado  ,
  codigo  ,
  forpago  ,
  restxventa 
 FROM #temp_vp
 SELECT @Resultado_Cpl = 0,
  @Resultado_Lpl = 0
 SELECT  @Resultado_Cpl = ISNULL(SUM(resultado),0)  FROM renta_vp WHERE fecproc = @dfecproc AND codigo IN (6,7)
 SELECT  @Resultado_Lpl = ISNULL(SUM(resultado),0)  FROM renta_vp WHERE fecproc = @dfecproc AND NOT ( codigo IN (6,7) )
 IF EXISTS( SELECT * FROM renta_resumen WHERE fecproc = @dfecproc )
  UPDATE renta_resumen
  SET ventas_cpl = @Resultado_Cpl,
   ventas_lpl = @Resultado_Lpl
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
   0  ,
   0  ,
   @Resultado_Cpl ,
   @Resultado_Lpl
-- SELECT * from #temp_vp
 SET NOCOUNT OFF
END
-- SELECT * FROM renta_vp
-- SELECT * FROM renta_resumen
-- select * from mdmo
-- select rstipoper,* from mdrs where rscartera = '121'
-- select * from  view_FORMA_DE_PAGO

GO

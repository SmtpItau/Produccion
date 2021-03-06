USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORENTCP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORENTCP]
    (
    @iMes INTEGER ,
    @iAno INTEGER
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @dFechai DATETIME ,
  @dFechav DATETIME ,
  @dFecha  DATETIME ,
  @nNomicap NUMERIC (19,4) ,
  @nTasacap NUMERIC (19,4) ,
  @nNomiredes NUMERIC (19,4) ,
  @nTasaredes NUMERIC (19,4) ,
  @nNomicol NUMERIC (19,4) ,
  @nTasacol NUMERIC (19,4) ,
  @nTotdias INTEGER  ,
  @nResucap NUMERIC (19,4) ,
  @nResuredes NUMERIC (19,4) ,
  @nResucol NUMERIC (19,4) ,
  @nUtilidad NUMERIC (19,4) ,
  @cInstser CHAR (10) ,
  @cDiasem CHAR (01) ,
  @cFeriado CHAR (50) ,
  @cPlaza  CHAR (05) ,
  @cMespal CHAR (21) ,
  @iSw  INTEGER  ,
  @nx  NUMERIC (19,0) ,
  @nContador NUMERIC (19,0) ,
  @dFechinab DATETIME
 SELECT @cMespal = CASE
     WHEN @iMes= 1 THEN 'Enero-'+STR(@iAno,4)
     WHEN @iMes= 2 THEN 'Febrero-'+STR(@iAno,4)
     WHEN @iMes= 3 THEN 'Marzo-'+STR(@iAno,4)
     WHEN @iMes= 4 THEN 'Abril-'+STR(@iAno,4)
     WHEN @iMes= 5 THEN 'Mayo-'+STR(@iAno,4)
     WHEN @iMes= 6 THEN 'Junio-'+STR(@iAno,4)
     WHEN @iMes= 7 THEN 'Julio-'+STR(@iAno,4)
     WHEN @iMes= 8 THEN 'Agosto-'+STR(@iAno,4)
     WHEN @iMes= 9 THEN 'Septiembre-'+STR(@iAno,4)
     WHEN @iMes=10 THEN 'Octubre-'+STR(@iAno,4)
     WHEN @iMes=11 THEN 'Noviembre-'+STR(@iAno,4)
     ELSE 'Diciembre-'+STR(@iAno,4)
      END
 SELECT @dFechai = CONVERT(DATETIME,STR(@iAno)+REPLACE(STR(@iMes,2),' ','0')+'01')
 SELECT @dFechav = DATEADD(DAY,-1,DATEADD(MONTH,1,@dFechai))
 SELECT @nx  = 0     ,
  @iSw  = 0     ,
  @nContador = 1     ,
  @cPlaza  = '00001'    ,
  @nTotdias = DATEDIFF(DAY,@dFechai,@dFechav) ,
  @dFechinab = @dFechai
 SELECT 'fecha'  = rsfecha    ,
  'nominal' = rsnominal    ,
  'tasa'  = rstir     ,
  'tcamara' = vmvalor    ,
  'feccomp' = rsfeccomp    ,
  'fecvcto' = rsfecvcto    ,
  'interes' = rsinteres    ,
  'reajuste' = rsreajuste    ,
  'vpresent' = rsvppresenx    ,
  'diasfin' = DATEDIFF(DAY,rsfecctb,rsfecprox) ,
  'costo'  = CONVERT(NUMERIC(19,0),0)  ,
  'utilidad' = CONVERT(NUMERIC(19,0),0)  ,
  'familia' = CASE 
     WHEN rstipoletra='E' THEN 'LCHR ESTA'
     WHEN rstipoletra='V' THEN 'LCHR VIV'
     WHEN rstipoletra='F' THEN 'LCHR F.GEN'
     WHEN rstipoletra='O' THEN 'LCHR OTROS'
     ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo)
      END     ,
  'moneda' = rsmonemi    ,
  'tipocartera' = rscartera    ,
  'instser' = rsinstser
 INTO #TEMPO
 FROM MDRS, VIEW_VALOR_MONEDA
 WHERE (rsfecha>=@dFechai AND rsfecha<=@dFechav) AND rstipoper='DEV' AND CHARINDEX(rscartera,'111-114')>0 AND
  (rsfecha=vmfecha AND 8=vmcodigo) AND CHARINDEX(STR(rscodigo,3),'  6-  7')<=0
 UPDATE #TEMPO
 SET costo  = vpresent*(tcamara/CONVERT(FLOAT,100))*(diasfin/CONVERT(FLOAT,30))
 UPDATE #TEMPO
 SET utilidad = ROUND(interes/1000,0)+ROUND(reajuste/1000,0)-costo
 SELECT 'afecha' = fecha   ,
  'anominal' = SUM(nominal)  ,
  'atasa'  = SUM(tasa*nominal) ,
  'ainteres' = SUM(interes)  ,
  'areajuste' = SUM(reajuste)  ,
  'atcamara' = tcamara  ,
  'avpresent' = SUM(vpresent)  ,
  'acosto' = SUM(costo)  ,
  'autilidad' = SUM(utilidad)  ,
  'afamilia' = familia  ,
  'amoneda' = moneda  ,
  'atipocartera' = tipocartera
 INTO #TEMPO1
 FROM #TEMPO
 GROUP BY familia,moneda,tipocartera,fecha,tcamara
 SELECT atipocartera    ,
  CONVERT(CHAR(10),afecha,103)  ,
  afamilia    ,
  mnnemo     ,
  ROUND(atasa/anominal,4)   ,
  anominal    ,
  avpresent    ,
  atcamara    ,
  autilidad    ,
  @cMespal
 FROM #TEMPO1, VIEW_MONEDA
 WHERE mncodmon=amoneda
 ORDER BY atipocartera,afamilia,amoneda,afecha
 SET NOCOUNT OFF
END
-- select * from VIEW_MONEDA
-- SP_INFORENTCP 06,2001
-- select * from mdrs where rsfecha>'20010501' and rsfecha>'20010530' and rscartera='114'
-- update mdrs set rstipoletra='' where rscodigo<>20


GO

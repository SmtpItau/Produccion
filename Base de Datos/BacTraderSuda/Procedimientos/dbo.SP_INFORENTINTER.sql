USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORENTINTER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORENTINTER]
    (
    @iMes  INTEGER  ,
    @iAno  INTEGER  ,
    @sUsuario VARCHAR (20)
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
     WHEN @iMes= 1 THEN 'ENERO-'+STR(@iAno,4)
     WHEN @iMes= 2 THEN 'FEBRERO-'+STR(@iAno,4)
     WHEN @iMes= 3 THEN 'MARZO-'+STR(@iAno,4)
     WHEN @iMes= 4 THEN 'ABRIL-'+STR(@iAno,4)
     WHEN @iMes= 5 THEN 'MAYO-'+STR(@iAno,4)
     WHEN @iMes= 6 THEN 'JUNIO-'+STR(@iAno,4)
     WHEN @iMes= 7 THEN 'JULIO-'+STR(@iAno,4)
     WHEN @iMes= 8 THEN 'AGOSTO-'+STR(@iAno,4)
     WHEN @iMes= 9 THEN 'SEPTIEMBRE-'+STR(@iAno,4)
     WHEN @iMes=10 THEN 'OCTUBRE-'+STR(@iAno,4)
     WHEN @iMes=11 THEN 'NOVIEMBRE-'+STR(@iAno,4)
     ELSE 'DICIEMBRE-'+STR(@iAno,4)
      END
 SELECT @dFechai = CONVERT(DATETIME,STR(@iAno)+REPLACE(STR(@iMes,2),' ','0')+'01')
 SELECT @dFechav = DATEADD(DAY,-1,DATEADD(MONTH,1,@dFechai))
 SELECT @nx  = 0     ,
  @iSw  = 0     ,
  @nContador = 1     ,
  @cPlaza  = '00001'    ,
  @nTotdias = DATEDIFF(DAY,@dFechai,@dFechav) ,
  @dFechinab = @dFechai
 SELECT 'fecha'  = mofecpro    ,
  'nominal' = movalcomp/CONVERT(FLOAT,1000)  ,
  'tasa'  = motir     ,
  'tcamara' = vmvalor    ,
  'fecini' = mofecinip    ,
  'fecvcto' = mofecvenp    ,
  'interes' = movalvenp-movalinip   ,
  'intgan' = CONVERT(NUMERIC (19,0),0)  ,
  'diasfin' = DATEDIFF(DAY,mofecinip,mofecvenp) ,
  'utilidad' = CONVERT(NUMERIC(19,0),0)  ,
  'forpagi' = moforpagi    ,
  'forpagv' = moforpagv    ,
  'familia' = moinstser    ,
  'usuario'       = mousuario
 INTO #TEMPO
 FROM MDMH, VIEW_VALOR_MONEDA
 WHERE (mofecpro>=@dFechai AND mofecpro<=@dFechav) AND motipoper='IB' AND mostatreg='' AND momonpact=999 AND
  (mofecpro=vmfecha AND 8=vmcodigo)
 INSERT INTO #TEMPO
 SELECT mofecpro    ,
  movalcomp/CONVERT(FLOAT,1000)  ,
  motir     ,
  vmvalor     ,
  mofecinip    ,
  mofecvenp    ,
  movalvenp-movalinip   ,
  0     ,
  DATEDIFF(DAY,mofecinip,mofecvenp) ,
  CONVERT(FLOAT,0)   ,
  moforpagi    ,
  moforpagv    ,
  moinstser    ,
  mousuario
 FROM MDMH, VIEW_VALOR_MONEDA
 WHERE (mofecpro>=@dFechai AND mofecpro<=@dFechav) AND motipoper='IB' AND moinstser='ICAP' AND mostatreg='' AND momonpact=999 AND
  (mofecpro=vmfecha AND 7=vmcodigo)
 UPDATE #TEMPO
 SET utilidad  = ((tcamara-tasa)/CONVERT(FLOAT,100))*(diasfin/CONVERT(FLOAT,30))*(nominal*CONVERT(FLOAT,1000))
 SELECT 'afecha' = fecha   ,
  'anominal' = SUM(nominal)  ,
  'atasa'  = SUM(tasa*nominal) ,
  'atcamara' = tcamara  ,
  'ainteres' = SUM(interes)  ,
  'adiasfin' = SUM(diasfin)  ,
  'autilidad' = SUM(utilidad)  ,
  'afamilia' = familia  
 INTO #TEMPO1
 FROM #TEMPO
 GROUP BY familia,fecha,tcamara
 IF (SELECT COUNT(*) FROM #TEMPO)=0
 BEGIN
  SELECT 'fecha'  = ''  ,
   nominal  = 0.0  ,
   'fecvcto' = ''  ,
   diasfin  = 0  ,
   tasa  = 0.0  ,
   tcamara  = 0.0  ,
   intgan  = 0  ,
   interes  = 0  ,
   utilidad = 0  ,
   'mes'  = @cMespal ,
   familia  = ''  ,
   usuario  = 0
  RETURN
 END
 IF UPPER(@sUsuario)='TODOS'
  SELECT 'fecha'  = CONVERT(CHAR(10),fecha,103) ,
   nominal      ,
   'fecvcto' = CONVERT(CHAR(10),fecvcto,103) ,
   diasfin      ,
   tasa      ,
   tcamara      ,
   intgan      ,
   interes      ,
   utilidad     ,
   'mes'  = @cMespal   ,
   familia      ,
   usuario
 FROM #TEMPO
  ORDER BY fecha,familia
 ELSE
  SELECT 'fecha'  = CONVERT(CHAR(10),fecha,103) ,
   nominal      ,
   'fecvcto' = CONVERT(CHAR(10),fecvcto,103) ,
   diasfin      ,
   tasa      ,
   tcamara      ,
   intgan      ,
   interes      ,
   utilidad     ,
   'mes'  = @cMespal   ,
   familia      ,
   usuario
  FROM #TEMPO
  WHERE usuario=@sUsuario
  ORDER BY fecha,familia
 SET NOCOUNT OFF
END
-- SP_INFORENTINTER 07,2001,'TODOS'
-- select * from mdmh where motipoper='IB'
-- sp_helptext SP_INFORENTINTER
-- update mdmh set motipoper='IB',momonpact=momonemi where moinstser='ICOL'
-- update mdmh set motipoper='IB',momonpact=momonemi,mofecinip=mofecpro where moinstser='ICAP'
-- select * from mdmh where motipoper='IB' and (mofecpro>='20010801' and mofecpro<='20010831') and mostatreg='' AND momonpact=999
-- select movalvenp,movalinip,mofecinip,mofecvenp,mofecemi from mdmh where motipoper='IB'
-- sp_autoriza_ejecutar 'bacuser'


GO

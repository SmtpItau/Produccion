USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORENTPACTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORENTPACTOS]
    (
    @iMes INTEGER ,
    @iAno INTEGER ,
    @sUsuario varchar(50)
    )
AS
BEGIN
 SET NOCOUNT ON
CREATE TABLE #TEMPOFECHA
   (
   feriado  DATETIME NULL
   )
 DECLARE @dFechai DATETIME ,
  @dFechav DATETIME ,
  @dFecha  DATETIME ,
  @dFecinip DATETIME ,
  @dFecvenp DATETIME ,
  @cDiaini CHAR (03) ,
  @cDiafin CHAR (03) ,
  @cInstser CHAR (10) ,
  @cDiasem CHAR (01) ,
  @cFeriado CHAR (50) ,
  @cPlaza  CHAR (05) ,
  @iMesBus INTEGER  ,
  @iAnoBus INTEGER  ,
  @cMespal CHAR (21) ,
  @fTCamProm FLOAT  ,
  @ix  INTEGER  ,
  @nNumoper NUMERIC (10,0) ,
  @nTotdias INTEGER  ,
  @iSw  INTEGER  ,
  @nContador NUMERIC (19,0)
 SELECT @cMespal = CASE
     WHEN @iMes= 1 THEN 'ENERO '+STR(@iAno,4)
     WHEN @iMes= 2 THEN 'FEBRERO '+STR(@iAno,4)
     WHEN @iMes= 3 THEN 'MARZO '+STR(@iAno,4)
     WHEN @iMes= 4 THEN 'ABRIL '+STR(@iAno,4)
     WHEN @iMes= 5 THEN 'MAYO '+STR(@iAno,4)
     WHEN @iMes= 6 THEN 'JUNIO '+STR(@iAno,4)
     WHEN @iMes= 7 THEN 'JULIO '+STR(@iAno,4)
     WHEN @iMes= 8 THEN 'AGOSTO '+STR(@iAno,4)
     WHEN @iMes= 9 THEN 'SEPTIEMBRE '+STR(@iAno,4)
     WHEN @iMes=10 THEN 'OCTUBRE '+STR(@iAno,4)
     WHEN @iMes=11 THEN 'NOVIEMBRE '+STR(@iAno,4)
     ELSE 'DICIEMBRE-'+STR(@iAno,4)
      END
 SELECT @dFechai = CONVERT(DATETIME,STR(@iAno)+REPLACE(STR(@iMes,2),' ','0')+'01')
 SELECT @dFechav = DATEADD(DAY,-1,DATEADD(MONTH,1,@dFechai))
 SELECT @cPlaza  = '00001'    ,
  @nTotdias = DATEDIFF(DAY,@dFechai,@dFechav) ,
  @dFecha  = acfecproc
 FROM MDAC
 SELECT @fTCamProm = SUM(vmvalor)
 FROM VIEW_VALOR_MONEDA
 WHERE (vmfecha>=@dFechai AND vmfecha<=@dFechav) AND vmcodigo=8
 SELECT @fTCamProm = ROUND(@fTCamProm/@nTotdias,2)
 SELECT @fTCamProm = 0.69
 SELECT 'fecinip' = mofecinip    , -- 1
  'fecvenp' = mofecvenp    , -- 2
  'nominal' = movalinip    , -- 3
  'tasa'  = motaspact    , -- 4
  'moneda' = momonpact    , -- 5
  'baspact' = mobaspact    , -- 6
  'serie'  = inserie    , -- 7
  'tcamara' = vmvalor    , -- 8
  'valvenp' = movalvenp    , -- 9
  'tasefec' = CONVERT(FLOAT,0)   , -- 10
  'fecinefe' = mofecinip    , -- 11
  'diaini' = CASE
     WHEN DATEPART(WEEKDAY,mofecinip)=1 THEN 'LUN'
     WHEN DATEPART(WEEKDAY,mofecinip)=2 THEN 'MAR'
     WHEN DATEPART(WEEKDAY,mofecinip)=3 THEN 'MIE'
     WHEN DATEPART(WEEKDAY,mofecinip)=4 THEN 'JUE'
     WHEN DATEPART(WEEKDAY,mofecinip)=5 THEN 'VIE'
     ELSE '---'
      END     , -- 12
  'fecveefe' = mofecvenp    , -- 13
  'diafin' = CASE
     WHEN DATEPART(WEEKDAY,mofecvenp)=1 THEN 'LUN'
     WHEN DATEPART(WEEKDAY,mofecvenp)=2 THEN 'MAR'
     WHEN DATEPART(WEEKDAY,mofecvenp)=3 THEN 'MIE'
     WHEN DATEPART(WEEKDAY,mofecvenp)=4 THEN 'JUE'
     WHEN DATEPART(WEEKDAY,mofecvenp)=5 THEN 'VIE'
     ELSE '---'
      END     , -- 14
  'diaspac' = DATEDIFF(DAY,mofecinip,mofecvenp) , -- 15
  'diasfin' = CONVERT(INTEGER,0)   , -- 16
  'floati' = CONVERT(INTEGER,0)   , -- 17
  'numoper' = monumoper    , -- 18
  'forpagi' = moforpagi    , -- 19
  'forpagv' = moforpagv    , -- 20
  'estado' = mostatreg    , -- 21
  'vv'  = mostatreg    , -- 22
  'usuario'       = mousuario                               -- 23
 INTO #TEMPO
 FROM MDMH, VIEW_VALOR_MONEDA, VIEW_INSTRUMENTO
 WHERE (mofecpro>=@dFechai AND mofecpro<=@dFechav) AND motipoper='VI' AND mostatreg='' AND incodigo=mocodigo AND
  (mofecpro=vmfecha AND 8=vmcodigo) AND mofecvenp<>@dFecha
 SELECT @nContador = COUNT(*) FROM #TEMPO
-- IF @nContador=0
-- BEGIN
--  SELECT '1', 'No Existen Datos'
--  RETURN
-- END
 IF DATEPART(MONTH,@dFecha)=@iMes AND DATEPART(YEAR,@dFecha)=@iAno
  INSERT INTO #TEMPO
  SELECT mofecinip    , -- 1
   mofecvenp    , -- 2
   movalinip    , -- 3
   motaspact    , -- 4
   momonpact    , -- 5
   mobaspact    , -- 6
   inserie     , -- 7
   vmvalor     , -- 8
   movalvenp    , -- 9
   CONVERT(FLOAT,0)   , -- 10
   mofecinip    , -- 11
   CASE
     WHEN DATEPART(WEEKDAY,mofecinip)=1 THEN 'LUN'
     WHEN DATEPART(WEEKDAY,mofecinip)=2 THEN 'MAR'
     WHEN DATEPART(WEEKDAY,mofecinip)=3 THEN 'MIE'
     WHEN DATEPART(WEEKDAY,mofecinip)=4 THEN 'JUE'
     WHEN DATEPART(WEEKDAY,mofecinip)=5 THEN 'VIE'
     ELSE '---'
      END    , -- 12
   mofecvenp    , -- 13
   CASE
     WHEN DATEPART(WEEKDAY,mofecvenp)=1 THEN 'LUN'
     WHEN DATEPART(WEEKDAY,mofecvenp)=2 THEN 'MAR'
     WHEN DATEPART(WEEKDAY,mofecvenp)=3 THEN 'MIE'
     WHEN DATEPART(WEEKDAY,mofecvenp)=4 THEN 'JUE'
     WHEN DATEPART(WEEKDAY,mofecvenp)=5 THEN 'VIE'
     ELSE '---'
      END    , -- 14
   DATEDIFF(DAY,mofecinip,mofecvenp) , -- 15
   CONVERT(INTEGER,0)   , -- 16
   CONVERT(INTEGER,0)   , -- 17
   monumoper    , -- 18
   moforpagi    , -- 19
   moforpagv    , -- 20
   ' '     , -- 21
   ' '     , -- 22
   ' '       -- 23
  FROM MDMO, VIEW_VALOR_MONEDA,VIEW_INSTRUMENTO
  WHERE motipoper='RC' AND incodigo=mocodigo AND (mofecpro=vmfecha AND 8=vmcodigo)
 INSERT INTO #TEMPO
 SELECT vifecinip    , -- 1
  vifecvenp    , -- 2
  vivalinip    , -- 3
  vitaspact    , -- 4
  vimonpact    , -- 5
  vibaspact    , -- 6
  inserie     , -- 7
  vmvalor     , -- 8
  vivalvenp    , -- 9
  CONVERT(FLOAT,0)   , -- 10
  vifecinip    , -- 11
  CASE
   WHEN DATEPART(WEEKDAY,vifecinip)=1 THEN 'LUN'
   WHEN DATEPART(WEEKDAY,vifecinip)=2 THEN 'MAR'
   WHEN DATEPART(WEEKDAY,vifecinip)=3 THEN 'MIE'
   WHEN DATEPART(WEEKDAY,vifecinip)=4 THEN 'JUE'
   WHEN DATEPART(WEEKDAY,vifecinip)=5 THEN 'VIE'
   ELSE '---'
  END     , -- 12
  vifecvenp    , -- 13
  CASE
   WHEN DATEPART(WEEKDAY,vifecvenp)=1 THEN 'LUN'
   WHEN DATEPART(WEEKDAY,vifecvenp)=2 THEN 'MAR'
   WHEN DATEPART(WEEKDAY,vifecvenp)=3 THEN 'MIE'
   WHEN DATEPART(WEEKDAY,vifecvenp)=4 THEN 'JUE'
   WHEN DATEPART(WEEKDAY,vifecvenp)=5 THEN 'VIE'
   ELSE '---'
  END     , -- 14
  DATEDIFF(DAY,vifecinip,vifecvenp) , -- 15
  CONVERT(INTEGER,0)   , -- 16
  CONVERT(INTEGER,0)   , -- 17
  vinumoper    , -- 18
  viforpagi    , -- 19
  viforpagv    , -- 20
  ' '     , -- 21
  ' '     , -- 22
  ' '        -- 23
 FROM MDVI, VIEW_VALOR_MONEDA,VIEW_INSTRUMENTO
 WHERE (vifecinip>=@dFechai AND vifecinip<=@dFechav) AND incodigo=vicodigo AND
  (vifecinip=vmfecha AND 8=vmcodigo) AND vifecinip<>@dFecha AND 
         NOT EXISTS(SELECT * FROM #TEMPO WHERE #TEMPO.numoper=vinumoper)
 UPDATE #TEMPO
 SET estado = CASE
    WHEN diafin='VIE' THEN 'F'
    WHEN diaini='VIE' AND diafin='VIE' THEN '-'
    WHEN diaini='VIE' THEN 'I'
    ELSE '-'
     END  ,
  vv = CASE
    WHEN CHARINDEX(STR(forpagi,3),'  1-  4-  8-  9- 10')>0 THEN 'N'
    ELSE 'S'
     END
 SELECT @ix  = 1
 SELECT @nContador = COUNT(*)
 FROM #TEMPO
 WHERE vv='S' AND (diaini<>'-' AND diafin<>'-')
 WHILE @ix<=@nContador
 BEGIN
  SELECT @cInstser = '*'
  SET ROWCOUNT @ix
  SELECT @nNumoper = numoper ,
   @cInstser = serie  ,
   @dFecinip = fecinip ,
   @dFecvenp = fecvenp ,
   @cDiaini = diaini ,
   @cDiafin = diafin
  FROM #TEMPO
  WHERE vv='S' AND (diaini<>'-' AND diafin<>'-')
  SET ROWCOUNT 0
  SELECT @ix = @ix + 1
  IF @cInstser='*'
   BREAK
  --** Tabla Feriados Inicio Pacto
  DELETE #TEMPOFECHA
  SELECT @iMesBus = DATEPART(MONTH,@dFecinip) ,
   @iAnoBus = DATEPART(YEAR,@dFecinip)
  SELECT @cFeriado = CASE
      WHEN @iMesBus= 1 THEN (SELECT feene FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 2 THEN (SELECT fefeb FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 3 THEN (SELECT femar FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 4 THEN (SELECT feabr FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 5 THEN (SELECT femay FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 6 THEN (SELECT fejun FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 7 THEN (SELECT fejul FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 8 THEN (SELECT feago FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 9 THEN (SELECT fesep FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=10 THEN (SELECT feoct FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=11 THEN (SELECT fenov FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=12 THEN (SELECT fedic FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
        END
  SELECT @iSw = 3
  WHILE @iSw<=DATALENGTH(RTRIM(@cFeriado))
  BEGIN
   SELECT @dFecha = CONVERT(DATETIME,STR(@iAnoBus,4)+REPLACE(STR(@iMesBus,2),' ','0')+SUBSTRING(@cFeriado,(@iSw-2),2))
   INSERT INTO #TEMPOFECHA VALUES (@dFecha)
   SELECT @iSw = @iSw + 3
  END
  SELECT @iSw = 0
  WHILE @iSw=0
  BEGIN
   SELECT @dFecinip = DATEADD(DAY,1,@dFecinip)
   IF NOT EXISTS(SELECT * FROM #TEMPOFECHA WHERE feriado=@dFecinip)
    SELECT @iSw = 1
  END
  --** Tabla Feriados Vencimiento Pacto
  DELETE #TEMPOFECHA
  SELECT @iMesBus = DATEPART(MONTH,@dFecvenp) ,
   @iAnoBus = DATEPART(YEAR,@dFecvenp)
  SELECT @cFeriado = CASE
      WHEN @iMesBus= 1 THEN (SELECT feene FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 2 THEN (SELECT fefeb FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 3 THEN (SELECT femar FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 4 THEN (SELECT feabr FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 5 THEN (SELECT femay FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 6 THEN (SELECT fejun FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 7 THEN (SELECT fejul FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 8 THEN (SELECT feago FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus= 9 THEN (SELECT fesep FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=10 THEN (SELECT feoct FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=11 THEN (SELECT fenov FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
      WHEN @iMesBus=12 THEN (SELECT fedic FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoBus)
        END
  SELECT @iSw = 3
  WHILE @iSw<=DATALENGTH(RTRIM(@cFeriado))
  BEGIN
   SELECT @dFecha = CONVERT(DATETIME,STR(@iAnoBus,4)+REPLACE(STR(@iMesBus,2),' ','0')+SUBSTRING(@cFeriado,(@iSw-2),2))
   INSERT INTO #TEMPOFECHA VALUES (@dFecha)
   SELECT @iSw = @iSw + 3
  END
   
  SELECT @iSw = 0
  WHILE @iSw=0
  BEGIN
   SELECT @dFecvenp = DATEADD(DAY,1,@dFecvenp)
   IF NOT EXISTS(SELECT * FROM #TEMPOFECHA WHERE feriado=@dFecvenp)
    SELECT @iSw = 1
  END
  UPDATE #TEMPO
  SET fecinefe = @dFecinip ,
   fecveefe = @dFecvenp
  WHERE numoper=@nNumoper
 END
 UPDATE #TEMPO
 SET diasfin = DATEDIFF(DAY,fecinefe,fecveefe)     ,
  floati = ABS(DATEDIFF(DAY,fecinefe,fecinip)-DATEDIFF(DAY,fecveefe,fecvenp))
 UPDATE #TEMPO
 SET tasefec = (((tasa/3000)*diaspac)/30)+(9/100)*(@fTCamProm*(floati/30))
 WHERE moneda=999
 SET NOCOUNT OFF
-- SELECT * FROM #TEMPO
-- SELECT CONVERT(CHAR(10),fecinip,103) ,
--  valvenp    ,
--  CONVERT(CHAR(10),fecvenp,103) ,
--  diasfin    ,
--  tasa    ,
--  tcamara    ,
--  tasefec    ,
--  @cMespal
-- FROM #TEMPO
-- ORDER BY moneda,fecinip
 
 IF (SELECT COUNT(*) FROM #TEMPO)=0
 BEGIN
  SELECT 'fecinip' = ''  ,
   'fecvenp' = ''  ,
   'tasa'  = 0.0  ,
   'baspact' = 0  ,
   'serie'  = ''  ,
   'tcamara' = 0.0  ,
   'valvenp' = 0  ,
   'tasefec' = 0.0  ,
   'fecinefe' = ''  ,
   'fecveefe' = ''  ,
   'diaspac' = 0  ,
   'diasfin' = 0  ,
   'floati' = 0.0  ,
   'moneda' = 0  ,
   'mes'  = @cMespal ,
   'usuario'
  RETURN
 END
 IF UPPER(@sUsuario)='TODOS'
  SELECT 'fecinip' = CONVERT(CHAR(10),fecinip,103) ,
   'fecvenp' = CONVERT(CHAR(10),fecvenp,103) ,
   tasa      ,
   baspact      ,
   serie      ,
   tcamara      ,
   valvenp      ,
   tasefec      ,
   'fecinefe' = CONVERT(CHAR(10),fecinefe,103),
   'fecveefe' = CONVERT(CHAR(10),fecveefe,103),
   diaspac      ,
   diasfin      ,
   floati      ,
   moneda      ,
   'mes'  = @cMespal   ,
   usuario
  FROM #TEMPO
 ELSE
  SELECT 'fecinip' = CONVERT(CHAR(10),fecinip,103) ,
   'fecvenp' = CONVERT(CHAR(10),fecvenp,103) ,
   tasa      ,
   baspact      ,
   serie      ,
   tcamara      ,
   valvenp      ,
   tasefec      ,
   'fecinefe' = CONVERT(CHAR(10),fecinefe,103),
   'fecveefe' = CONVERT(CHAR(10),fecveefe,103),
   diaspac      ,
   diasfin      ,
   floati      ,
   moneda      ,
   'mes'  = @cMespal   ,
   usuario
  FROM #TEMPO
  WHERE usuario=@sUsuario
END
/*
 SP_INFORENTPACTOS 08,2001,'ADMINISTRA'
 SP_INFORENTPACTOS 05,2001,'ADMINISTRA'
 select * from mdmh
 SELECT * FROM VIEW_FORMA_DE_PAGO
 select * from mdvi
 sp_helpdb
 sp_helptext sp_trae_usuario
 select * from view_moneda
sp_autoriza_ejecutar 'bacuser'
*/


GO

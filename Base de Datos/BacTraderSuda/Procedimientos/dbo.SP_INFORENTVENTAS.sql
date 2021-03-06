USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORENTVENTAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORENTVENTAS]
    (
    @iMes INTEGER ,
    @iAno INTEGER
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
  @ix  INTEGER  ,
  @nNumoper NUMERIC (10,0) ,
  @iSw  INTEGER  ,
  @nContador NUMERIC (19,0)
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
 SELECT @cPlaza  = '00001'    ,
  @dFecha  = acfecproc
 FROM MDAC
 SELECT 'fecha'  = mofecpro    , -- 1
  'vpresen' = movalven    , -- 2
  'utilidad' = CASE
     WHEN moutilidad>0 THEN moutilidad
     ELSE moperdida
      END     , -- 3
  'tasa'  = motaspact    , -- 4
  'serie'  = inserie    , -- 5
  'tcamara' = vmvalor    , -- 6
  'forpagi' = moforpagi    , -- 7
  'vv'  = mostatreg    , -- 8
  'utilfinan' = CONVERT(FLOAT,0)   , -- 9
  'numoper' = monumoper    , -- 10
  'diasfin' = CONVERT(INTEGER,0)   , -- 11
  'fecpago' = mofecinip    , -- 12
  'usuario' = mousuario    , -- 13
  'pago'  = glosa     , -- 14
  'instser' = moinstser      -- 15
 INTO #TEMPO
 FROM MDMH, VIEW_VALOR_MONEDA, VIEW_INSTRUMENTO, VIEW_FORMA_DE_PAGO
 WHERE (mofecpro>=@dFechai AND mofecpro<=@dFechav) AND motipoper='VP' AND mostatreg='' AND incodigo=mocodigo AND
  (mofecpro=vmfecha AND 8=vmcodigo) AND moforpagi=codigo
 SELECT @nContador = COUNT(*) FROM #TEMPO
 IF @nContador=0
 BEGIN
  SELECT '1', 'No Existen Datos'
  RETURN
 END
 UPDATE #TEMPO
 SET vv = CASE
    WHEN CHARINDEX(STR(forpagi,3),'  1-  4-  8-  9- 10')>0 THEN 'N'
    ELSE 'S'
     END
 SELECT @ix  = 1
 SELECT @nContador = COUNT(*) FROM #TEMPO WHERE vv='S'
 WHILE @ix<=@nContador
 BEGIN
  SELECT @cInstser = '*'
  SET ROWCOUNT @ix
  SELECT @nNumoper = numoper ,
   @cInstser = serie  ,
   @dFecinip = fecha
  FROM #TEMPO
  WHERE vv='S'
  SET ROWCOUNT 0
  SELECT @ix = @ix + 1
  IF @cInstser='*'
   BREAK
  --** Tabla Feriados Proximo dia Habil
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
  UPDATE #TEMPO
  SET fecpago = @dFecinip
  WHERE numoper=@nNumoper
 END
 UPDATE #TEMPO
 SET diasfin  = DATEDIFF(DAY,fecha,fecpago)
 WHERE vv='S'
 UPDATE #TEMPO
 SET utilfinan = utilidad-vpresen*((tcamara/100)*(diasfin/30))+utilidad
 WHERE vv='S'
 UPDATE #TEMPO
 SET utilfinan = utilidad
 WHERE vv<>'S'
 SELECT 'fecha'  = CONVERT(CHAR(10),fecha,103) ,
  serie      ,
  'vpresen' = SUM(vpresen)   ,
  'utilidad' = sum(utilidad)   ,
  pago      ,
  utilfinan = SUM(utilfinan)
 FROM #TEMPO
 GROUP BY fecha,serie,pago
 SET NOCOUNT OFF
END
/*
SP_INFORENTVENTAS 08,2001
SELECT * FROM VIEW_FORMA_DE_PAGO
select * from mdvi
sp_helpdb
sp_helptext sp_trae_usuario
select * from view_moneda
*/


GO

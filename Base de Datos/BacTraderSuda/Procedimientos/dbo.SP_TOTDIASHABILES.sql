USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTDIASHABILES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TOTDIASHABILES]
    (
    @nRutcli NUMERIC (09,0) ,
    @dFecini DATETIME ,
    @dFecven DATETIME
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @iDiastot INTEGER  ,
  @iDiashab INTEGER  ,
  @cPlaza  numeric (05) ,
  @iAnoini INTEGER  ,
  @iAnovto INTEGER  ,
  @iMesini INTEGER  ,
  @iMesvto INTEGER  ,
  @cMesini CHAR (50) ,
  @cMesvto CHAR    (50) ,
  @nI  INTEGER  ,
  @dFecvtop DATETIME ,
  @cTipcli numeric (5) ,
  @iDias  INTEGER
 SELECT @cPlaza  = Folio FROM GEN_FOLIOS WHERE Codigo = 'PLAZA_CHIL'
 SELECT @iDiastot = DATEDIFF(DAY,@dFecini,@dFecven) ,
  @iAnoini = DATEPART(YEAR,@dFecini)  ,
  @iAnovto = DATEPART(YEAR,@dFecven)  ,
  @iMesini = DATEPART(MONTH,@dFecini)  ,
  @iMesvto = DATEPART(MONTH,@dFecven)  ,
  @cMesini = ''     ,
  @cMesvto = ''     ,
  @iDiashab = 0     ,
  @iDias  = 0     ,
  @nI  = 3     ,
  @cTipcli = cltipcli
 FROM VIEW_CLIENTE
 WHERE clrut=@nRutcli
 IF @iMesvto>=@iMesini
 BEGIN
  IF @iMesvto-@iMesini>1
   SELECT @iMesvto = @iMesini+1
  IF @iAnoini<>@iAnovto
   SELECT @iAnovto = @iAnoini
 END
 ELSE
 BEGIN
  IF @iMesini+1>12
   SELECT @iMesvto = 1
  ELSE
   SELECT @iMesvto = @iMesini+1 ,
    @iAnovto = @iAnoini
 END
 SELECT @cMesini = CASE
    WHEN @iMesini= 1 THEN (SELECT feene FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 2 THEN (SELECT fefeb FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 3 THEN (SELECT femar FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 4 THEN (SELECT feabr FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 5 THEN (SELECT femay FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 6 THEN (SELECT fejun FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 7 THEN (SELECT fejul FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 8 THEN (SELECT feago FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini= 9 THEN (SELECT fesep FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini=10 THEN (SELECT feoct FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini=11 THEN (SELECT fenov FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
    WHEN @iMesini=12 THEN (SELECT fedic FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnoini)
      END
 IF @iMesini<>@iMesvto
  SELECT @cMesvto = CASE
     WHEN @iMesvto= 1 THEN (SELECT feene FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 2 THEN (SELECT fefeb FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 3 THEN (SELECT femar FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 4 THEN (SELECT feabr FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 5 THEN (SELECT femay FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 6 THEN (SELECT fejun FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 7 THEN (SELECT fejul FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 8 THEN (SELECT feago FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto= 9 THEN (SELECT fesep FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto=10 THEN (SELECT feoct FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto=11 THEN (SELECT fenov FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
     WHEN @iMesvto=12 THEN (SELECT fedic FROM VIEW_FERIADO WHERE feplaza=@cPlaza AND feano=@iAnovto)
       END
 IF @iMesini=@iMesvto
 BEGIN
  WHILE @nI<=DATALENGTH(RTRIM(@cMesini))
  BEGIN
   IF DATEPART(DAY,@dFecven)>=CONVERT(INTEGER,SUBSTRING(@cMesini,@nI-2,2))
    SELECT @iDiashab = @iDiashab + 1
   IF DATEPART(DAY,@dFecini)>=CONVERT(INTEGER,SUBSTRING(@cMesini,@nI-2,2))
    SELECT @iDiashab = @iDiashab - 1
   SELECT @nI = @nI + 3
  END
 
 END
 ELSE
 BEGIN
  SELECT @dFecvtop = DATEADD(DAY,-1,CONVERT(DATETIME,STR(@iMesvto)+'/01/'+STR(@iAnoini)))
  WHILE @nI<=DATALENGTH(RTRIM(@cMesini))
  BEGIN
   IF DATEPART(DAY,@dFecvtop)>=CONVERT(INTEGER,SUBSTRING(@cMesini,@nI-2,2))
    SELECT @iDiashab = @iDiashab + 1
   IF DATEPART(DAY,@dFecini)>=CONVERT(INTEGER,SUBSTRING(@cMesini,@nI-2,2))
    SELECT @iDiashab = @iDiashab - 1
   SELECT @nI = @nI + 3
  END
 END
 IF @iMesini<>@iMesvto
 BEGIN
  SELECT @nI = 3
  WHILE @nI<=DATALENGTH(RTRIM(@cMesvto))
  BEGIN
   IF DATEPART(DAY,@dFecven)>=CONVERT(INTEGER,SUBSTRING(@cMesvto,@nI-2,2))
    SELECT @iDiashab = @iDiashab + 1
   SELECT @nI = @nI + 3
  END
 END
 SELECT @iDias = @iDiastot-@iDiashab
/*
 IF @iDias<4 AND @cTipcli>3
  SELECT @iDias,'No se pueden realizar operaciones con el cliente seleccionado por menos de 4 dias'
 ELSE
*/ -- Se comenta ya que no debe haber restricción para ningún tipo de cliente
  SELECT 'OK'
 SET NOCOUNT OFF
END

GO

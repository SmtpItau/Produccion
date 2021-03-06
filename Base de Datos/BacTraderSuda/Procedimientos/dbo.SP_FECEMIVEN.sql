USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECEMIVEN]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECEMIVEN]
   (
   @carchivo CHAR (2) ,
   @cmesaux CHAR (2) ,
   @canoaux CHAR (4) ,
   @dfecaux DATETIME ,
   @crefnomi CHAR (1) ,
   @ntipfec INTEGER  ,
   @ndiavcup INTEGER  ,
   @npervcup INTEGER  ,
   @ncupones INTEGER  ,
   @dfecemi DATETIME OUTPUT ,
   @dfecven DATETIME OUTPUT
   )
AS
BEGIN
 DECLARE @cdiaaux CHAR (2)
 IF @ntipfec=2
 BEGIN
  IF @crefnomi='E'
  BEGIN
   SELECT @dfecemi = @dfecaux
   IF @carchivo='SE'
   BEGIN
    SELECT @dfecven = DATEADD(MONTH,@npervcup*@ncupones,@dfecemi)
   END
   ELSE
   BEGIN
    SELECT @dfecven = NULL
   END
  END
  ELSE
  BEGIN
   SELECT @dfecven = @dfecaux
   IF @carchivo='SE'
   BEGIN
    SELECT @dfecemi = DATEADD(MONTH,-@npervcup*@ncupones,@dfecven)
   END
   ELSE
   BEGIN
    SELECT @dfecemi = NULL
   END
  END
 END
 IF @ntipfec=3
 BEGIN
  SELECT @dfecemi = CONVERT(DATETIME,'28/'+@cmesaux+'/'+@canoaux,103)
  SELECT @dfecemi = DATEADD(DAY,4,@dfecemi)
  SELECT @dfecemi = DATEADD(DAY,-DATEPART(DAY,@dfecemi),@dfecemi)
  SELECT @dfecven = DATEADD(MONTH,@npervcup*@ncupones,@dfecemi)
  SELECT @dfecven = DATEADD(DAY,4,@dfecven )
  SELECT @dfecven = DATEADD(DAY,-DATEPART(DAY,@dfecven),@dfecven)
 END
 IF @ntipfec=4
 BEGIN
  SELECT @cdiaaux = STR(@ndiavcup,2)
  SELECT @dfecemi = CONVERT(DATETIME,@cdiaaux+'/'+@cmesaux+'/'+@canoaux,103)
  SELECT @dfecemi = DATEADD(MONTH,@npervcup*@ncupones,@dfecemi)
 END
 IF @ntipfec=5
 BEGIN
  SELECT @dfecemi = acfecproc FROM MDAC
  SELECT @dfecven = DATEADD(YEAR,20,@dfecemi)
 END
 RETURN 0
END
-- select * from view_instrumento

GO

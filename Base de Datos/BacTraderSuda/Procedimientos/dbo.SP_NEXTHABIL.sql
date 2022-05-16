USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NEXTHABIL]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_NEXTHABIL]
                  (@dfecha1 DATETIME, @cPlaza NUMERIC(3), @dfechasal DATETIME OUTPUT)
AS
BEGIN
 DECLARE  @cdias1 VARCHAR(255) ,
   @icontadia INTEGER  ,
   @dfechaaux DATETIME 
 SELECT @dfechaaux = @dfecha1
 SELECT @icontadia = 1
 
 WHILE 1=1
 BEGIN
  
  SELECT @cdias1 =CASE DATEPART(MONTH, @dfechaaux)  
    WHEN  1 THEN feene
    WHEN  2 THEN fefeb
    WHEN  3 THEN femar
    WHEN  4 THEN feabr
    WHEN  5 THEN femay
    WHEN  6 THEN fejun
    WHEN  7 THEN fejul
    WHEN  8 THEN feago
    WHEN  9 THEN fesep
    WHEN 10 THEN feoct
    WHEN 11 THEN fenov
    WHEN 12 THEN fedic
   END
  FROM VIEW_FERIADO
  WHERE feano  = DATEPART(YEAR,@dfecha1)
  AND   feplaza = @cplaza
  IF  CHARINDEX( RTRIM(CONVERT(CHAR(02),DATEPART(DAY,@dfechaaux))),@cdias1) > 0 OR 
     (DATEPART(WEEKDAY,@dfechaaux)= 7 OR DATEPART(WEEKDAY,@dfechaaux)=1 ) BEGIN      
   SELECT @dfechaaux = DATEADD(DAY,@icontadia,@dfecha1)   
  END
  ELSE BREAK
  SELECT @icontadia = @icontadia + 1
 END
 SELECT @dfechasal =  @dfechaaux
END

GO

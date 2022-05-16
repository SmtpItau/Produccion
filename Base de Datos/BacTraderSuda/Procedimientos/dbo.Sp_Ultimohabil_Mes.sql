USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ultimohabil_Mes]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Ultimohabil_Mes]
                  (@dfecha1  DATETIME ,
                  @dfechasal DATETIME OUTPUT )
 
AS
BEGIN
 DECLARE @dfecha2 DATETIME ,
--  @cdias1  CHAR(250) ,
  @Mes     INTEGER ,
  @cdias1  CHAR(250) 
-- SELECT @dfecha2 = CONVERT(DATETIME,CONVERT(CHAR(04),DATEPART(YEAR,@dfecha1)) + CONVERT(CHAR(02),DATEPART(MONTH,DATEADD(MONTH,1,@dfecha1))) +'01',112)
 SELECT @dfecha2 = DATEADD( MONTH,1,@dfecha1)
 SELECT @dfecha2 = DATEADD( DAY, (CONVERT(INTEGER,DATEPART(DAY,@dfecha1))*-1) ,@dfecha2)
--DATEADD(MONTH,1,@dfecha1))) END)+'01',112)
-- SELECT @dfecha2 = CONVERT(DATETIME,CONVERT(CHAR(04),DATEPART(YEAR,@dfecha1)) + (CASE WHEN DATEPART(MONTH,DATEADD(MONTH,1,@dfecha1)) < 10 THEN '0' + RTRIM(CONVERT(CHAR(02),DATEPART(MONTH,DATEADD(MONTH,1,@dfecha1)))) ELSE CONVERT(CHAR(02),DATEPART(MONTH,

-- select  @dfecha1, @dfecha2 
 SELECT @dfecha2 = DATEADD(DAY,-1,@dfecha2)  -- ultimo dia del fin de mes
 
 
DECLARE @I INTEGER
SELECT @I = 0
-- WHILE @dfecha1<=@dfecha2
 WHILE  @I = 0
 BEGIN 
  SELECT @Mes =  DATEPART(MONTH, @dfecha2)  
--DATEPART(MONTH, @dfecha2)  
  SELECT @cdias1 = CASE @Mes   
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
  WHERE feano   = DATEPART(YEAR,@dfecha1)
  AND   feplaza = 6           --Plaza Chile
  IF  CHARINDEX( RTRIM(CONVERT(CHAR(02),DATEPART(DAY,@dfecha2))),@cdias1) > 0 OR 
     (DATEPART(WEEKDAY,@dfecha2)= 7 OR DATEPART(WEEKDAY,@dfecha2)=1 ) 
  BEGIN 
   SELECT @dfecha2 = DATEADD(DAY,-1,@dfecha2)
  END
  ELSE  
  BEGIN
   SELECT @I = 1
   BREAK
  END
   
 END
 SELECT @dfechasal =@dfecha2  
SELECT @dfechasal

-- select @dfecha1,@dfecha2
END
-- 01,07,08,14,15,21,22,28,29,                                                                          
-- select * from mdfe 
-- SP_GENERA_RESBAN '20001026'
--  sp_ultimohabil_mes '20020930',''
-- select * from  mdfe where feplaza =6
--update mdfe set fedic = '02,03,09,10,16,17,23,24,29,30,31,                                                                    '


GO

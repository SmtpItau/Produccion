USE [Bacfwdsuda]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularDiaHabil]    Script Date: 13-05-2022 9:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalcularDiaHabil]
	(	@Fecha	as DATETIME	)
RETURNS DATETIME  
AS  
BEGIN  

    DECLARE @Date      DATETIME  
    DECLARE @Year      INT  
    DECLARE @Month     INT  
    DECLARE @Feriados  VARCHAR(100)  
    DECLARE @Day       VARCHAR(02)  
  
    SET @Date = @Fecha  
  
    WHILE (1=1)  
    BEGIN  
        IF (DatePart(Weekday, @Date)) = 7  
        BEGIN  
            SET @Date = DATEADD( DAY, 2, @Date)  
  
        END  
        ELSE IF (DatePart(Weekday, @Date)) = 1  
        BEGIN  
            SET @Date = DATEADD( DAY, 1, @Date)  
        END  
        ELSE  
        BEGIN  
            SET @Year  = DATEPART( YEAR, @Date )  
            SET @Month = DATEPART( MONTH, @Date )  
            SET @Day   = RIGHT( '00' + CONVERT( VARCHAR(02), DATEPART( DAY, @Date ) ), 2)  
            SELECT @Feriados = CASE @Month WHEN  1 THEN feene  
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
              FROM BacParamSuda.dbo.Feriado  
             WHERE feano    = @Year  
               AND feplaza  = 6  
  
            IF (CHARINDEX(@Day, @Feriados) > 0)  
            BEGIN  
                SET @Date = DATEADD( DAY, 1, @Date)  
            END ELSE  
            BEGIN  
                BREAK  
  
            END  
        END  
          
    END  
  
    RETURN @Date  
  
END

GO

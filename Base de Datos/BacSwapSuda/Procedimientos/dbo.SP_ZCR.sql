USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ZCR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ZCR]( 
                         @CodigoTasa   INTEGER,
                         @CodigoMoneda INTEGER,
                         @Dias         INTEGER,
                         @TasaZCR      FLOAT = 0 OUTPUT )
AS
BEGIN

--<< para interpolar ZCR
DECLARE @minDay   INTEGER,
        @maxDay   INTEGER,
        @minRate  FLOAT,
        @maxRate  FLOAT

--<< ZCR
DECLARE @Year     INTEGER,
        @Day      INTEGER,
        @Days     INTEGER,
        @ZCR      FLOAT,
        @Cont     INTEGER

SELECT @Year = (@Dias / 365),
       @Days = (CASE WHEN @Dias <= 365 THEN @Dias ELSE 365 END),
       @Day  = 2

SELECT @Year = @Year + (CASE WHEN (@Dias / 365.00) > @Year THEN 1 ELSE 0 END)

--<< Tasa a menos de un year
EXECUTE dbo.SP_TASA @CodigoTasa, @CodigoMoneda, @Days, @TasaZCR OUTPUT      -- Este retorna SELECT @TasaZCR  

IF @Dias <= 365
   RETURN

--<< Tasa a mas de un year

IF EXISTS (SELECT * FROM sysobjects WHERE name = '#ZCR' AND type = 'U')
   DROP TABLE #ZCR    

CREATE TABLE #ZCR ( tasaZCR FLOAT, yearZCR INTEGER )

INSERT INTO #ZCR VALUES( @TasaZCR , 1.00 )       -- ZCR a 365 dias, o sea, un year

WHILE (@Day <= @Year)
BEGIN

     SELECT @ZCR     = 100,
            @TasaZCR = 0  ,
            @Days    = (@Day * 365),
            @Cont    = 0  

     EXECUTE dbo.SP_TASA @CodigoTasa, @CodigoMoneda, @Days, @TasaZCR OUTPUT  
     
     --<< Formula
     WHILE ((SELECT COUNT(*) FROM #ZCR) > @Cont)
     BEGIN

          SELECT @Cont = @Cont + 1

          SELECT @ZCR  = @ZCR - @TasaZCR / POWER(1.00 + (tasaZCR/100.00) , yearZCR*1.00)  -- n.00 le da mayor precion a decimales
            FROM #ZCR
           WHERE yearZCR = @Cont

     END  -- ((SELECT COUNT(*) FROM #ZCR) >= @Cont)

     IF @ZCR <> 0
        SELECT @ZCR = ( @TasaZCR + 100.00 ) / (@ZCR * 1.00)

     SELECT @ZCR = POWER( @ZCR , ( 1.00 / (@Day*1.00) ) )
     SELECT @ZCR = @ZCR - 1.00
     SELECT @ZCR = @ZCR * 100.00

     --<< ZCR a @Day year
     INSERT INTO #ZCR VALUES( @ZCR , @Day*1.00 )

     SELECT @Day = @Day + 1

END -- WHILE (@Day <= @Year)

--<< Elimina y deja solo ZCR max & min
DELETE FROM #ZCR WHERE yearZCR < @Year-1
SELECT @TasaZCR = 0
SELECT @minDay  = (yearZCR * 365), @minRate = tasaZCR  FROM #ZCR WHERE yearZCR < @Year
SELECT @maxDay  = (yearZCR * 365), @maxRate = tasaZCR  FROM #ZCR WHERE yearZCR = @Year

EXECUTE dbo.SP_INTERPOLAR_TASAS @maxDay, @maxRate, @minDay, @minRate, @Dias, @TasaZCR OUTPUT  

END -- PROCEDURE
GO

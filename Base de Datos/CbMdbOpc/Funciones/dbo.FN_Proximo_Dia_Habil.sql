USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_Proximo_Dia_Habil]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[FN_Proximo_Dia_Habil]
       (
         @Fecha    datetime,
         @Plaza    int
       )
RETURNS DATETIME
AS
BEGIN

    DECLARE @cDiasFeriados       VARCHAR(255)
    DECLARE @Result              DATETIME
    DECLARE @Month               INT
    DECLARE @cCaracter           CHAR(2)


    SET @Result = DATEADD( DAY, 1, @Fecha )

    WHILE (1=1)
    BEGIN
        IF DATEPART(WEEKDAY,@Result) IN ( 7, 1 )
        BEGIN
            SET @Result = DATEADD( DAY, 1, @Result )

        END ELSE
        BEGIN
            SET @Month = DATEPART( MONTH, @Result )
            SELECT @cDiasFeriados = CASE @Month WHEN  1 THEN feene
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
              FROM lnkBac.BacParamSuda.dbo.FERIADO
             WHERE feano               = DATEPART( YEAR, @Result )
               AND feplaza             = @Plaza

            IF @@ROWCOUNT = 0
            BEGIN
                SET @Result = '19000101'
                BREAK

            END

            SET @cCaracter = Right( '00' + RTRIM(CONVERT( VARCHAR(2), DATEPART( DAY, @Result ) ) ), 2 )

            IF   CHARINDEX( RTRIM( CONVERT( CHAR(02),@cCaracter ) ), @cDiasFeriados ) > 0 
            BEGIN
                SET @Result = DATEADD( DAY, 1, @Result )
            END ELSE
            BEGIN
                BREAK
            END
        END
    END

    RETURN @Result

END

GO

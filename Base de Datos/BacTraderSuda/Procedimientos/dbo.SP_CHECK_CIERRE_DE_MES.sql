USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECK_CIERRE_DE_MES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHECK_CIERRE_DE_MES]
       (
        @dFecha      DATETIME OUTPUT
       )
AS
BEGIN
   DECLARE @dFechaRet     DATETIME
   DECLARE @dUltFinMes    DATETIME
   DECLARE @dProxFinMes   DATETIME
   DECLARE @nPlaza        NUMERIC(3)
   DECLARE @nAno          INTEGER
   DECLARE @nMes          INTEGER
   DECLARE @nDia          INTEGER
   DECLARE @cDia          CHAR(02)
   DECLARE @cMes          VARCHAR(60)
   SELECT @nPlaza = 6
   SELECT @nMes = DATEPART( MONTH, @dfecha )
   SELECT @nAno = DATEPART(  YEAR, @dfecha )
   SELECT @dProxFinMes   = CONVERT( VARCHAR(04), DATEPART( YEAR, @dFecha ) ) + 
                           RIGHT( '0' + CONVERT( VARCHAR(02), @nMes ), 2 ) + '01'
   SELECT @dProxFinMes   = DATEADD(   DAY, -1, @dProxFinMes )
   SELECT @dUltFinMes    = CONVERT( VARCHAR(04), DATEPART( YEAR, @dFecha ) ) + 
                           RIGHT( '0' + CONVERT( VARCHAR(02), @nMes ), 2 ) + '01'
   SELECT @dUltFinMes    = DATEADD(   DAY, -1, DATEADD( MONTH, 1, @dUltFinMes ) )
   IF @dUltFinMes = @dFecha BEGIN
      SELECT @dFechaRet = @dUltFinMes
   END ELSE BEGIN
      SELECT @dFechaRet = @dProxFinMes
   END
   SELECT @dFechaRet = @dUltFinMes
/*SELECT @dUltFinMes, @dFecha, @dFechaRet, @dUltFinMes
   SELECT @nMes = DATEPART( MONTH, @dFechaRet )
   SELECT       @cMes = CASE @nMes WHEN 01 THEN feene
                                   WHEN 02 THEN fefeb
                                   WHEN 03 THEN femar
                                   WHEN 04 THEN feabr
                                   WHEN 05 THEN femay
                                   WHEN 06 THEN fejun
                                   WHEN 07 THEN fejul
                                   WHEN 08 THEN feago
                                   WHEN 09 THEN fesep
                                   WHEN 10 THEN feoct
                                   WHEN 11 THEN fenov
                                   WHEN 12 THEN fedic
                        END
          FROM  VIEW_FERIADO
          WHERE feplaza = @nPlaza   AND
                   feano   = @nano
   WHILE (1=1) BEGIN
       SELECT @nDia = DATEPART(   DAY, @dfechaRet )
       SELECT @cDia = RIGHT( '0' + CONVERT( VARCHAR(02), @nDia ), 2 )
      IF CHARINDEX( @cDia, @cMes ) > 0 BEGIN
         SELECT @dFechaRet = DATEADD( DAY, -1, @dFechaRet )
      END ELSE BEGIN
         BREAK
      END
   END
*/
   SELECT @dFecha = @dFechaRet
END

GO

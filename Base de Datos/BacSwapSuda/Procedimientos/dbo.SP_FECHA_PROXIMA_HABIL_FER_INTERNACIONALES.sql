USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHA_PROXIMA_HABIL_FER_INTERNACIONALES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHA_PROXIMA_HABIL_FER_INTERNACIONALES]
   (   @dFecha     DATETIME
   ,   @dFecRet    DATETIME OUTPUT
   ,   @FeriadoFlujoChile int
   ,   @FeriadoFlujoEEUU  int
   ,   @FeriadoFlujoEnglan int
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @cDiasFeriadosChile  VARCHAR(255)
   ,       @cDiasFeriadosEEUU  VARCHAR(255)
   ,       @cDiasFeriadosEnglan  VARCHAR(255)
   ,       @iContaDia	   INTEGER
   ,       @dFechaAux	   DATETIME
   ,       @cPlaza         NUMERIC(3)
   ,       @cCaracter      CHAR(2)

   Set DATEFIRST 7                 

   SELECT  @cPlaza      = 6
   SELECT  @iContaDia   = 1
   SELECT  @dFechaAux   = @dFecha

   SELECT @dFechaAux = DATEADD(DAY,1,@dFecha)

   WHILE (1 = 1)
   BEGIN
      if @FeriadoFlujoChile = 1 
          SELECT @cDiasFeriadosChile = CASE WHEN DATEPART(MONTH,@dFechaAux) = 1  THEN feene
                                   WHEN DATEPART(MONTH,@dFechaAux) = 2  THEN fefeb
                                   WHEN DATEPART(MONTH,@dFechaAux) = 3  THEN femar
                                   WHEN DATEPART(MONTH,@dFechaAux) = 4  THEN feabr
                                   WHEN DATEPART(MONTH,@dFechaAux) = 5  THEN femay
                                   WHEN DATEPART(MONTH,@dFechaAux) = 6  THEN fejun
                                   WHEN DATEPART(MONTH,@dFechaAux) = 7  THEN fejul
                                   WHEN DATEPART(MONTH,@dFechaAux) = 8  THEN feago
                                   WHEN DATEPART(MONTH,@dFechaAux) = 9  THEN fesep
                                   WHEN DATEPART(MONTH,@dFechaAux) = 10 THEN feoct
                                   WHEN DATEPART(MONTH,@dFechaAux) = 11 THEN fenov
                                   WHEN DATEPART(MONTH,@dFechaAux) = 12 THEN fedic
                              END
          FROM   BacParamSuda..FERIADO
          WHERE  feano 	= DATEPART(YEAR,@dFechaAux)
                 and feplaza    = 6 -- Chile
      if @FeriadoFlujoEEUU = 1   
          SELECT @cDiasFeriadosEEUU = CASE WHEN DATEPART(MONTH,@dFechaAux) = 1  THEN feene
                                   WHEN DATEPART(MONTH,@dFechaAux) = 2  THEN fefeb
                                   WHEN DATEPART(MONTH,@dFechaAux) = 3  THEN femar
                                   WHEN DATEPART(MONTH,@dFechaAux) = 4  THEN feabr
                                   WHEN DATEPART(MONTH,@dFechaAux) = 5  THEN femay
                                   WHEN DATEPART(MONTH,@dFechaAux) = 6  THEN fejun
                                   WHEN DATEPART(MONTH,@dFechaAux) = 7  THEN fejul
                                   WHEN DATEPART(MONTH,@dFechaAux) = 8  THEN feago
                                   WHEN DATEPART(MONTH,@dFechaAux) = 9  THEN fesep
                                   WHEN DATEPART(MONTH,@dFechaAux) = 10 THEN feoct
                                   WHEN DATEPART(MONTH,@dFechaAux) = 11 THEN fenov
                                   WHEN DATEPART(MONTH,@dFechaAux) = 12 THEN fedic
                              END
          FROM   BacParamSuda..FERIADO
          WHERE  feano 	= DATEPART(YEAR,@dFechaAux)
                 and feplaza    =225 -- EEUU
      if @FeriadoFlujoEnglan = 1 
          SELECT @cDiasFeriadosEnglan = CASE WHEN DATEPART(MONTH,@dFechaAux) = 1  THEN feene
                                   WHEN DATEPART(MONTH,@dFechaAux) = 2  THEN fefeb
                                   WHEN DATEPART(MONTH,@dFechaAux) = 3  THEN femar
                                   WHEN DATEPART(MONTH,@dFechaAux) = 4  THEN feabr
                                   WHEN DATEPART(MONTH,@dFechaAux) = 5  THEN femay
                                   WHEN DATEPART(MONTH,@dFechaAux) = 6  THEN fejun
                                   WHEN DATEPART(MONTH,@dFechaAux) = 7  THEN fejul
                                   WHEN DATEPART(MONTH,@dFechaAux) = 8  THEN feago
                                   WHEN DATEPART(MONTH,@dFechaAux) = 9 THEN fesep
                                   WHEN DATEPART(MONTH,@dFechaAux) = 10 THEN feoct
                                   WHEN DATEPART(MONTH,@dFechaAux) = 11 THEN fenov
                                   WHEN DATEPART(MONTH,@dFechaAux) = 12 THEN fedic
                              END
          FROM   BacParamSuda..FERIADO
          WHERE  feano 	= DATEPART(YEAR,@dFechaAux)
                 and feplaza    = 510 -- Inglaterra
      
      SELECT @cCaracter = CASE WHEN DATEPART(DAY,@dFechaAux) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,@dFechaAux))
                               ELSE CONVERT(CHAR(2),DATEPART(DAY,@dFechaAux))
                          END
      IF   CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriadosChile) > 0 
         or CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriadosEEUU) > 0 
         or CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriadosEnglan) > 0 
         OR (DATEPART(WEEKDAY,@dFechaAux) = 7 OR DATEPART(WEEKDAY,@dFechaAux) = 1) 
      BEGIN
         SELECT @dFechaAux = DATEADD(DAY,1,@dFechaAux)
      END ELSE
      BEGIN
         BREAK
      END
   END

   SELECT @dFecRet =  @dFechaAux

END
GO

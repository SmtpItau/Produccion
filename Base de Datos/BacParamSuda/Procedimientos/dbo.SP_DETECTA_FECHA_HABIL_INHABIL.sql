USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETECTA_FECHA_HABIL_INHABIL]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DETECTA_FECHA_HABIL_INHABIL] (@fecha DATETIME , @fechabil CHAR(02) OUTPUT )
AS
BEGIN

  SET NOCOUNT ON
   DECLARE @cDiasFeriados  VARCHAR(255)
   ,       @dFechaAux	   DATETIME
   ,       @cPlaza         NUMERIC(3)
   ,       @cCaracter      CHAR(2)

   SELECT  @cPlaza      = 6
   SELECT @dFechaAux = @fecha

      SELECT @cDiasFeriados = CASE WHEN DATEPART(MONTH,@dFechaAux) = 1  THEN feene
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
      FROM   FERIADO
      WHERE  feano 	= DATEPART(YEAR,@dFechaAux)
      AND    feplaza	= @cplaza

      SELECT @cCaracter = CASE WHEN DATEPART(DAY,@dFechaAux) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,@dFechaAux))
                               ELSE CONVERT(CHAR(2),DATEPART(DAY,@dFechaAux))
                          END

      IF CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriados) > 0 
         OR (DATEPART(WEEKDAY,@dFechaAux) = 7 OR DATEPART(WEEKDAY,@dFechaAux) = 1) 
      BEGIN
	SELECT @fechabil='NO'
      END ELSE
      BEGIN
	SELECT @fechabil='SI'
      END



END
GO

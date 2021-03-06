USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHA_VALOR_MONEDA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHA_VALOR_MONEDA]
   (   @dFecha       DATETIME   
   ,   @dFechaValMon DATETIME OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @cCaracter              CHAR(2)
   ,       @cDiasFeriados          VARCHAR(255)

   DECLARE @dFechaCierreMes        DATETIME
   SELECT  @dFechaCierreMes        = DATEADD(DAY,-1,DATEADD(MONTH,1,DATEADD(DAY,1,DATEADD(DAY, DAY(@dFecha)*-1,@dFecha))))

   DECLARE @dFechaCierreMesHabil   DATETIME
   SELECT  @dFechaCierreMesHabil   = @dFechaCierreMes

   WHILE (1=1)
   BEGIN
      SELECT @cDiasFeriados = CASE WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 1  THEN feene
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 2  THEN fefeb
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 3  THEN femar
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 4  THEN feabr
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 5  THEN femay
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 6  THEN fejun
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 7  THEN fejul
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 8  THEN feago
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 9  THEN fesep
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 10 THEN feoct
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 11 THEN fenov
                                   WHEN DATEPART(MONTH,@dFechaCierreMesHabil) = 12 THEN fedic
                              END
      FROM   BacParamSuda..FERIADO
      WHERE  feano 	= DATEPART(YEAR,@dFechaCierreMesHabil)
      AND    feplaza	= 6

      SELECT @cCaracter = CASE WHEN DATEPART(DAY,@dFechaCierreMesHabil) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,@dFechaCierreMesHabil))
                               ELSE CONVERT(CHAR(2),DATEPART(DAY,@dFechaCierreMesHabil))
                          END

      IF CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriados) > 0 
         OR (DATEPART(WEEKDAY,@dFechaCierreMesHabil) = 7 OR DATEPART(WEEKDAY,@dFechaCierreMesHabil) = 1) 
      BEGIN
         SELECT @dFechaCierreMesHabil = DATEADD(DAY,-1,@dFechaCierreMesHabil)
      END ELSE
      BEGIN
         BREAK
      END
   END

   IF (@dFecha = @dFechaCierreMesHabil) AND (@dFechaCierreMesHabil <> @dFechaCierreMes)
   BEGIN
      SELECT @dFechaValMon = @dFechaCierreMes
   END ELSE
   BEGIN
      SELECT @dFechaValMon = @dFecha
   END

END

GO

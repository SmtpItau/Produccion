USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHA_N_DIAS_HABILES_ANTERIORES_MAP]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHA_N_DIAS_HABILES_ANTERIORES_MAP]

   (   @dFecha     DATETIME
   ,   @Dias       integer
   ,   @dFecRet    DATETIME  OUTPUT 

   )
AS
BEGIN
   /* Utilización del requerimiento 

   declare @fecha datetime
   exec SP_FECHA_N_DIAS_HABILES_ANTERIORES '20090113' , 3, @fecha output
   select '@fecha', @fecha

   */

   SET NOCOUNT ON

   DECLARE @cDiasFeriadosChile  VARCHAR(255)
   ,       @iContaDia	   INTEGER
   ,       @dFechaAux	   DATETIME
   ,       @cPlaza         NUMERIC(3)
   ,       @cCaracter      CHAR(2)
   ,       @CtaDias        int
   ,        @FeriadoFlujoChile int

   Set DATEFIRST 7                 

   SELECT  @cPlaza      = 6
   SELECT  @iContaDia   = 1
   SELECT  @dFechaAux   = @dFecha

   select @FeriadoFlujoChile = 1
   select @CtaDias  = 0

   WHILE  (1=1)
   BEGIN

      SELECT @dFechaAux = DATEADD(DAY,-1, @dFechaAux)
      select @CtaDias   = @CtaDias + 1
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

         SELECT @cCaracter = CASE WHEN DATEPART(DAY,@dFechaAux) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,@dFechaAux))
                                  ELSE CONVERT(CHAR(2),DATEPART(DAY,@dFechaAux))
                             END
         IF   CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriadosChile) > 0 
            OR (DATEPART(WEEKDAY,@dFechaAux) = 7 OR DATEPART(WEEKDAY,@dFechaAux) = 1) 
         BEGIN
            SELECT @dFechaAux = DATEADD(DAY,-1,@dFechaAux)
         END ELSE
         BEGIN
            BREAK
         END
      END
      if @CtaDias >= @Dias BREAK
      
   END

   SELECT @dFecRet =  @dFechaAux

END  
GO

USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHA_ANTERIOR_HABIL]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHA_ANTERIOR_HABIL]
   (   @dFecha     DATETIME
   ,   @dFecRet    DATETIME OUTPUT
   )
AS
BEGIN

/* Ejemplo Ejecución: 
DROP PROCEDURE dbo.SP_FECHA_ANTERIOR_HABIL
dbo.SP_FECHA_ANTERIOR_HABIL '20090601' , '20090601'

Resultado:
Ejecuta Control                                                                          Fecha                       FechaProx                   
------- -------------------------------------------------------------------------------- --------------------------- --------------------------- 
OK      Ejecuta SP_FECHA_PROXIMA_HABIL correctamente                                     2009-05-20 00:00:00.000     2009-05-22 00:00:00.000

*/
   SET NOCOUNT ON

   DECLARE @cDiasFeriadosChile  VARCHAR(255)
   ,       @iContaDia	   INTEGER
   ,       @dFechaAux	   DATETIME
   ,       @cPlaza         NUMERIC(3)
   ,       @cCaracter      CHAR(2)
   ,       @FeriadoFlujoChile NUMERIC(1)
   ,       @MsgError       Varchar(80)




   Set DATEFIRST 7                  -- Para determinar el dábado y domingo correctamente            


   select @FeriadoFlujoChile = 1    -- Se mirarán solo feriados locales de Chile.
   SELECT @cPlaza      = 6          -- Plaza Local: Chile

   SELECT @iContaDia   = -1
   SELECT @dFechaAux   = @dFecha


   SELECT @dFechaAux = DATEADD(DAY,-1,@dFecha)

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
          FROM   lnkBac.BacParamSuda.dbo.FERIADO
          WHERE  feano 	= DATEPART(YEAR,@dFechaAux)
                 and feplaza    = @cPlaza 
          IF @@error <> 0 BEGIN
             SELECT  @MsgError = 'Error: SP_FECHA_PROXIMA_HABIL 51' 
             GOTO FinProcesoError
          END
      
      SELECT @cCaracter = CASE WHEN DATEPART(DAY,@dFechaAux) <= 9 THEN '-2' + CONVERT(CHAR(1),DATEPART(DAY,@dFechaAux))
                               ELSE CONVERT(CHAR(2),DATEPART(DAY,@dFechaAux))
                          END
      IF   CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriadosChile) > 0 
         OR (DATEPART(WEEKDAY,@dFechaAux) = 7 OR DATEPART(WEEKDAY,@dFechaAux) = 1) 
      BEGIN
         SELECT @dFechaAux = DATEADD(DAY,-2,@dFechaAux)
      END ELSE
      BEGIN
         BREAK
      END
   END

   SELECT @dFecRet =  @dFechaAux

FinProcesoOK:
   select  Ejecuta   = convert( varchar(2) , 'OK' )
         , Control   = convert( varchar(80), 'Ejecuta SP_FECHA_ANTERIOR_HABIL correctamente'  )
         , Fecha     = @dFecha
         , FechaAnt = @dFecRet 
   return(0)
FinProcesoERROR:
   select  Ejecuta   = convert( varchar(2) , 'NO' )
         , Control   = convert( varchar(80), @MsgError )
         , Fecha     = @dFecha
         , FechaAnt = @dFecRet 
   return(1)

END

GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EVALUA_FERIADO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--EXEC SP_EVALUA_FERIADO '20141018',6


CREATE PROCEDURE [dbo].[SP_EVALUA_FERIADO](    @dFecha   DATETIME ,
										   @cPlaza   NUMERIC(05)  )

AS

BEGIN

   SET NOCOUNT ON

   
   DECLARE @lFlag	INTEGER

   DECLARE @nDia     INTEGER

   DECLARE @nMonth   INTEGER

   DECLARE @nAno     INTEGER

   DECLARE @cCampo   CHAR(100)

   DECLARE @nCou     INTEGER

   DECLARE @cann     CHAR(04)

   DECLARE @cpla     CHAR(05)

   DECLARE @nFin     INTEGER

   DECLARE @xDia     INTEGER

   DECLARE @cdia     CHAR(04)

   DECLARE @primerdiasql INTEGER

   DECLARE @sabado   INTEGER

   DECLARE @domingo   INTEGER

   SELECT @nDia   = DATEPART(DAY,   @dFecha)

   SELECT @nMonth = DATEPART(MONTH, @dFecha)

   SELECT @nAno   = DATEPART(YEAR , @dFecha)

   

   SELECT @sabado = 7

   SELECT @domingo = 1

   SELECT @primerdiasql = CASE @@DATEFIRST WHEN 1 THEN 0 ELSE 1 END 

   IF @primerdiasql = 0

 BEGIN

    SELECT @sabado = 6

    SELECT @domingo = 7

  

 END

   SELECT @cCampo = (CASE WHEN @nMonth = 1  THEN feene

                          WHEN @nMonth = 2  THEN fefeb

                          WHEN @nMonth = 3  THEN femar

                          WHEN @nMonth = 4  THEN feabr

                          WHEN @nMonth = 5  THEN femay

                          WHEN @nMonth = 6  THEN fejun

                          WHEN @nMonth = 7  THEN fejul

                          WHEN @nMonth = 8  THEN feago

                          WHEN @nMonth = 9  THEN fesep

                          WHEN @nMonth = 10 THEN feoct

                          WHEN @nMonth = 11 THEN fenov

                          WHEN @nMonth = 12 THEN fedic

                     END) FROM feriado 

         WHERE feano = @nano AND feplaza = @cplaza

  SELECT @cann = CONVERT( CHAR(04),DATEPART( YEAR, @dfecha )  )

  SELECT @cpla = CONVERT( CHAR(04),@cPlaza )

  SELECT @nCou = 1

  WHILE ( @nCou < 51 ) BEGIN

     SELECT @xDia = CONVERT( INTEGER, SUBSTRING( @cCampo,( (@nCou - 1 ) * 3 ) + 1, 2 ) )

     SELECT @nFin = DATEPART( dw, @dFecha )

     IF @nFin = @sabado OR @nFin = @domingo BEGIN

 SELECT @lFlag = -1

 BREAK

     END

     If @nDia = @xDia  BEGIN

 SELECT @lFlag = -1

 BREAK

     END

     If @nDia = 0 BEGIN

 SELECT @lFlag = 0

 BREAK

     END

     SELECT @lFlag = 0

     SELECT @nCou = @nCou + 1

   END

   SET NOCOUNT OFF


SELECT @lFlag AS Retorno


END

-- select * from view_feriado

-- SP_HELP view_feriado
GO

USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TASA]( @CodigoTasa   INTEGER,  
                               @CodigoMoneda INTEGER,
                               @Dias         INTEGER,
                               @Tasa         FLOAT = 0 OUTPUT,
                               @Fecha        CHAR(8) = 'YYYYMMDD' )
AS
BEGIN

--<< Fecha de tasas a capturar

IF @Fecha = 'YYYYMMDD'  
   SELECT @Fecha = CONVERT(CHAR(8),fechaproc,112) FROM SwapGeneral

--<< para interpolar
DECLARE @minDay   INTEGER,
        @maxDay   INTEGER,
        @minRate  FLOAT,
        @maxRate  FLOAT

SELECT  @minDay   = 0,
        @maxDay   = 0,
        @minRate  = 0,
        @maxRate  = 0

--<< Dia y Tasa Maximo
SET ROWCOUNT 1

SELECT @maxDay = desde, @maxRate = tasafinal
  FROM View_Tasa_Moneda
 WHERE CodigoTasa   = @CodigoTasa 
   AND CodigoMoneda = @CodigoMoneda 
   AND Desde       >= @Dias 
   AND tasafinal   <> 0
   AND fecha        = @Fecha
 ORDER BY desde

SET ROWCOUNT 0

--<< Dia y Tasa Minima
SELECT @minDay = (CASE WHEN @maxDay = 0 THEN @Dias ELSE @maxDay END)

SELECT @minDay = MAX(desde)
  FROM View_Tasa_Moneda
 WHERE CodigoTasa   = @CodigoTasa 
   AND CodigoMoneda = @CodigoMoneda 
   AND Desde        < @MinDay 
   AND tasafinal   <> 0
   AND fecha        = @Fecha

SELECT @minRate = tasafinal
  FROM View_Tasa_Moneda
 WHERE CodigoTasa = @CodigoTasa AND CodigoMoneda = @CodigoMoneda AND Desde = @minDay

--<< interpolar
EXECUTE dbo.SP_INTERPOLAR_TASAS @maxDay, @maxRate, @minDay, @minRate, @Dias, @Tasa OUTPUT -- Este retorna SELECT @Tasa  

END
GO

USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TASA]( 
                          @CodigoTasa   INTEGER,
                          @CodigoMoneda INTEGER,
                          @Dias         INTEGER,
                          @Tasa         FLOAT = 0 OUTPUT )
AS
BEGIN

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
  FROM mdtasas
 WHERE CodigoTasa = @CodigoTasa AND CodigoMoneda = @CodigoMoneda AND Desde >= @Dias AND tasafinal <> 0
 ORDER BY desde

SET ROWCOUNT 0

--<< Dia y Tasa Minima
SELECT @minDay = (CASE WHEN @maxDay = 0 THEN @Dias ELSE @maxDay END)

SELECT @minDay = MAX(desde)
  FROM mdtasas
 WHERE CodigoTasa = @CodigoTasa AND CodigoMoneda = @CodigoMoneda AND Desde < @MinDay AND tasafinal <> 0

SELECT @minRate = tasafinal
  FROM mdtasas
 WHERE CodigoTasa = @CodigoTasa AND CodigoMoneda = @CodigoMoneda AND Desde = @minDay

--<< interpolar
EXECUTE dbo.SP_INTERPOLAR_TASAS @maxDay, @maxRate, @minDay, @minRate, @Dias, @Tasa OUTPUT -- Este retorna SELECT @Tasa  

END

GO

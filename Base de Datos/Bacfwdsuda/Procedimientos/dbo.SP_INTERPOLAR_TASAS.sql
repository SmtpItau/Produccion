USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERPOLAR_TASAS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SP_INTERPOLAR_TASAS]
   (   @minDay   FLOAT  = 0           --> Plazo Minimo
   ,   @minRate  FLOAT = 0            --> Tasa  Minima
   ,   @maxDay   FLOAT = 0            --> Plazo Maximo
   ,   @maxRate  FLOAT = 0            --> Tasa  Maxima
   ,   @Day      FLOAT = 0            --> Plazo Real
   ,   @Rate     FLOAT   OUTPUT       --> Tasa  Retorno
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @difDay   INTEGER

   SELECT  @difDay = (@maxDay - @minDay) 
   IF @difDay <> 0
      SELECT @Rate = (@maxRate - @minRate) / (@difDay)
   ELSE
      SELECT @Rate = 0.00
   
   if @Day >= @minDay and @day <= @maxDay  -- Interpolacion común
      SELECT @Rate = @minRate + ( @Rate * ( @Day - @minDay ) )
   else
   if @Day <  @minDay -- Extrapolacion Inferior  
      SELECT @Rate = @minRate - ( @Rate * ( @minDay - @Day ) )
   else  -- Extrapolacion Superior
      SELECT @Rate = @maxRate + ( @Rate * ( @Day - @maxDay ) )
  
END


GO

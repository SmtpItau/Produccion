USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERPOLAR_TASAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERPOLAR_TASAS]( @minDay   INTEGER = 0 ,  
                                      @minRate  FLOAT   = 0 ,
                                      @maxDay   INTEGER = 0 ,
                                      @maxRate  FLOAT   = 0 ,
                                      @Day      INTEGER = 0 ,
                                      @Rate     FLOAT   = 0 OUTPUT )
AS
BEGIN
     
     DECLARE @difDay INTEGER

     SELECT  @difDay = (@maxDay - @minDay)
 
     IF @difDay <> 0
        SELECT @Rate = (@maxRate - @minRate) / (@difDay)

     ELSE
        SELECT @Rate = 0.00


     SELECT @Rate = @minRate + (@Rate * (@Day - @minDay ))
  
     SELECT @Rate
    
END

GO

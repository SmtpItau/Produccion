USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFAMILIAS_DPX]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIFAMILIAS_DPX]
                               ( @rutcart1  numeric(09,0)  ,
     @parestipoper char(03) ,
     @parenumcart numeric(09,00) )
 
AS
BEGIN
SET NOCOUNT ON
 if  @parestipoper ='VP'
  select 
   distinct 'serie' = inserie 
  from  
   MDDI ,
   VIEW_INSTRUMENTO
  where 
   inserie = diserie 
  and  dirutcart = @rutcart1 
  and  ditipoper <>'IB' 
  and  dinominal > 0
  and ditipoper ='CP'
  and ditipcart = @parenumcart
  and     SUBSTRING( diserie, 1, 3 ) = 'DPX'
 else
  select 
   distinct 'serie' = inserie 
  from  
   MDDI ,
   VIEW_INSTRUMENTO
  where 
   inserie = diserie 
  and  dirutcart = @rutcart1 
  and  ditipoper <>'IB' 
  and  dinominal > 0
  and ditipcart = @parenumcart
  and  digenemi  = 'BCCH'
  and     SUBSTRING( diserie, 1, 3 ) = 'DPX'
END


GO

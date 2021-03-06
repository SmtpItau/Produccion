USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIEMISORES_DPX]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIEMISORES_DPX]
   (@rutcart1 numeric (09,0) ,
    @paretipoper char(03) ,
    @parenumcart numeric(09,00) )
   
AS
BEGIN
SET NOCOUNT ON
 if @paretipoper ='VP'
               
  select 
   distinct 'generico' = emgeneric
  from 
   MDDI , 
   VIEW_EMISOR
  where emgeneric=digenemi 
  and  dirutcart=@rutcart1 
  and  dinominal>0
  and ditipoper = 'CP'
  and ditipcart = @parenumcart
  and     SUBSTRING( diserie, 1, 3 ) = 'DPX'
 else
  
                  select 
   distinct 'generico' = emgeneric
  from 
   MDDI , 
   VIEW_EMISOR
  where emgeneric=digenemi 
  and  dirutcart=@rutcart1 
  and  dinominal>0
  and ditipcart = @parenumcart  
  and digenemi  = 'BCCH'
  and     SUBSTRING( diserie, 1, 3 ) = 'DPX' 
SET NOCOUNT OFF
END


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIMONEDAS_DPX]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIMONEDAS_DPX] ( @rutcart1  numeric(09,0),
    @paretipoper  char(03) ,
        @parenumcart numeric(09,0) )
AS
BEGIN
 if @paretipoper ='VP'
  select 
   distinct 'Nemotecnico'= b.mnnemo 
  from 
 MDDI a,
 VIEW_MONEDA  b
  where 
   b.mnnemo = a.dinemmon 
  and  a.dirutcart = @rutcart1 
  and  a.dinominal > 0
  and a.ditipoper ='CP'
  and a.ditipcart = @parenumcart
  and SUBSTRING( diserie, 1, 3 ) = 'DPX'
  
 else
  select 
   distinct 'Nemotecnico'= b.mnnemo 
  from 
   MDDI  a,
   VIEW_MONEDA  b
  where 
   b.mnnemo = a.dinemmon 
  and  a.dirutcart = @rutcart1 
  and  a.dinominal > 0
  and  a.ditipcart = @parenumcart
  and a.digenemi = 'BCCH' 
  and SUBSTRING( diserie, 1, 3 ) = 'DPX'
end


GO

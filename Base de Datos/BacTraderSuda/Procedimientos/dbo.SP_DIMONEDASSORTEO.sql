USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIMONEDASSORTEO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIMONEDASSORTEO]
   (   @rutcart1     numeric(09,0)   )
as
begin

  select distinct 
         'nemotecnico'          = b.mnnemo 
  from   mddi a   
   ,     view_moneda  b
  where  b.mnnemo               = a.dinemmon 
  and    a.dirutcart            = @rutcart1 
  and    a.dinominal            > 0
  and    a.ditipoper            = 'CP'
  and    SUBSTRING(diserie,1,4) = 'LCHR'
  
end


GO

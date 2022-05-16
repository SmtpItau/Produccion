USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFAMILIASSORTEO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIFAMILIASSORTEO]
   (   @rutcart1 numeric(09,0)   )
as
begin

   set nocount on

   select distinct 'serie' = inserie
   from  MDDI, VIEW_INSTRUMENTO
   where inserie   = diserie 
   and   dirutcart = @rutcart1 
   and   dinominal > 0 
   and   diserie   = 'LCHR'

end


GO

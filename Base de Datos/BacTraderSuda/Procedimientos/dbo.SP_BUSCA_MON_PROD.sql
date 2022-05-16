USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_MON_PROD]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_MON_PROD]
               ( @tipoper char(4) )
as
begin
select  mpmoneda , 
 mnnemo  ,
 mnbase 
   from MDMP, 
        VIEW_MONEDA 
  where mptipoper = @tipoper
    and mpmoneda  = mncodmon
end


GO

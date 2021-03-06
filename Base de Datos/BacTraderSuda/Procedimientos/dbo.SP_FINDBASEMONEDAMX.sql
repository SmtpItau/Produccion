USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASEMONEDAMX]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FINDBASEMONEDAMX]
               ( @parcodmoneda numeric(03) )
as
begin
   set nocount on
   select 'BASE' = isnull(mnbase,0)
      from VIEW_MONEDA 
         where isnull(mnmx,'')= 'C'
           and mncodmon = @parcodmoneda
    
   set nocount off
end


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFORPAG]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEEFORPAG]
  (@ncodtab integer  ,
   @cforpag char (03) ,
   @IB  char(1)   = 'N' )
as
begin

   if @IB = 'S' 
   begin

      select  codigo 
      ,       glosa   
      ,       cc2756
      from    VIEW_FORMA_DE_PAGO
      where   codigo in ( 4, 5,11,12,13,14, 122, 123, 124, 125, 126, 127 ,128 ,129 , 130,132,133,134,135,136,137,138,139 ) or @ib = ' '

   end else
   begin
      select  codigo 
      ,       glosa   
      ,       cc2756
      from    VIEW_FORMA_DE_PAGO
      where   codigo <> 140	
   end

end


GO

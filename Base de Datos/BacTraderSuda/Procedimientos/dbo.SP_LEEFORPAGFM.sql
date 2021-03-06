USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEFORPAGFM]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEFORPAGFM]
  (@ncodtab integer  ,
   @cforpag char (03) ,
   @IB  char(1)   = 'N' )
as
begin

   if @cforpag = 'USD'
   begin
	   if @IB = 'S' 
	   begin
	      select  codigo 
	      ,       glosa   
	      ,       cc2756
	      from    VIEW_FORMA_DE_PAGO
	      where   codigo in ( 4, 5,11,12,13,14, 122, 123, 124, 125, 126, 127 ,128 ,129 , 130,132,133,134,135,136,137,138,139 ) or @ib = ' '
		      and cc2756 = 'S'	
	   end else
	   begin
	      select  codigo 
	      ,       glosa   
	      ,       cc2756
	      from    VIEW_FORMA_DE_PAGO
	      where   codigo <> 140	
		      and cc2756 = 'S'	
	   end
   end
   else
   begin
	   if @IB = 'S' 
	   begin
	      select  codigo 
	      ,       glosa   
	      ,       cc2756
	      from    VIEW_FORMA_DE_PAGO
	      where   codigo in ( 4, 5,11,12,13,14, 122, 123, 124, 125, 126, 127 ,128 ,129 , 130,132,133,134,135,136,137,138,139 ) or @ib = ' '
		      and cc2756 <> 'S'	
	   end else
	   begin
	      select  codigo 
	      ,       glosa   
	      ,       cc2756
	      from    VIEW_FORMA_DE_PAGO
	      where   codigo <> 140	
		      and cc2756 <> 'S'	
	   end
   end

end


GO

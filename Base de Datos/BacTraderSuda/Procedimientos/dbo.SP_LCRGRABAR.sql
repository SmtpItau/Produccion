USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCRGRABAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LCRGRABAR]
       ( @ccodigo    char(10)        ,
         @nvalor     float           ,
         @ctipo      char(01)       )
as
begin
set nocount on  
   /*=======================================================================*/
   /*=======================================================================*/
   if exists( select * from mdlcr where lcrcodigo = @ccodigo ) begin
      update mdlcr set   lcrvalor = @nvalor
                   where lcrcodigo = @ccodigo
   /*=======================================================================*/
   /*=======================================================================*/
   end else begin
       insert into mdlcr ( lcrcodigo, lcrvalor, lcrtipo )
              values     (  @ccodigo,  @nvalor,  @ctipo )
   end
   /*=======================================================================*/
   /*=======================================================================*/
   update bacuser set sw_mdlre = '1',
                      sw_MDLRC = '1',
                      sw_mdlri = '1'
   select 'OK'
set nocount off
end


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COELIMCORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COELIMCORTES]
                                ( @nrutcart   numeric  (9,0) ,
                                  @nnumdocu   numeric (10,0) ,
                                  @ncorrela   numeric  (5,0) )
as
begin
         set nocount on 
      
         delete from MDCO
              where corutcart = @nrutcart and
                    conumdocu = @nnumdocu and
                    cocorrela = @ncorrela
   set nocount off
   select 'OK'    
   return
end


GO

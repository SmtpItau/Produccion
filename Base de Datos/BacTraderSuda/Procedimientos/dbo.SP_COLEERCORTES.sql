USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COLEERCORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COLEERCORTES]
                                ( @nrutcart   numeric (09,0) ,
                                  @nnumdocu   numeric (10,0) ,
                                  @ncorrela   numeric (05,0) )
as
begin
   set nocount on
 if exists( select * from  MDCO where corutcart = @nrutcart and conumdocu = @nnumdocu and cocorrela = @ncorrela and cocantcortd > 0 )
 begin  
  select 
   corutcart ,
   conumdocu ,
   cocorrela ,
   comtocort ,
   cocantcorto ,
   cocantcortd 
  from
   MDCO
  where
   corutcart = @nrutcart 
  and conumdocu = @nnumdocu
  and cocorrela = @ncorrela 
  and cocantcortd > 0
 end
 else
 begin
                set nocount on
  select 'RESPUESTA'=0,'NO SE ENCONTRO INSTRUMENTO EN TABLA DE CORTES'
  return 1
 end
          
                return 0
end
--select * from MDCO
/*
sp_coleercortes
            78221830 ,
             7 ,
             1 
*/


GO

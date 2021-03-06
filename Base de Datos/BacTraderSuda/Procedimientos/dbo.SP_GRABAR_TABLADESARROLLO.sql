USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_TABLADESARROLLO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_TABLADESARROLLO]
                                                      (  @tdmascara1    char      (12)  ,
                              @tdcupon1      numeric (03,0)  , 
                                     @tdfecven1     datetime  ,
                                     @tdinteres1  numeric (19,10)  ,
                                     @tdamort1  numeric (19,10)  ,
                                     @tdflujo1      numeric (19,10)  ,
                                     @tdsaldo1      numeric (19,10)  )
as
begin
     set nocount on   
                
     insert into VIEW_TABLA_DESARROLLO   (   tdmascara,   tdcupon,   tdfecven,   tdinteres,   tdamort,   tdflujo,   tdsaldo )
                     values ( @tdmascara1, @tdcupon1, @tdfecven1, @tdinteres1, @tdamort1, @tdflujo1, @tdsaldo1 )
if @@error <> 0 begin
  set nocount off
  SELECT 'NO'
  return
end
set nocount off
SELECT 'SI'
end


GO

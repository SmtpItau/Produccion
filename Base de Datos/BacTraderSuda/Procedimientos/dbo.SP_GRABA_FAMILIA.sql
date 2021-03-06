USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FAMILIA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_FAMILIA]
                                       (@xserie  char(12) ,
     @xglosa  char(40) ,
     @xcodigo  numeric(3) ,
     @xprog  char(8)  ,
     @xrefnom  char(1)  ,
     @xrutemi  numeric(9) ,
     @xmonemi  numeric(3) ,
     @xbasemi  numeric(3) ,
     @xtasaest  numeric(3) ,
     @xtipo   char(3)  ,
     @xmdse  char(1)  ,
     @xmdpr  char(1)  ,
     @xmdtd  char(1)  ,
     @xtipofec  numeric(1) ,
     @xemision  char(3)  ,
     @xeleg   char(1)  ,
     @xcontab  char(1)  ,
     @xtotalemitido          float           ,
     @xsecuritytype          char(2)         ,
     @xintiporig             char(3)  ) 
as
begin
      set nocount on
  if exists(select * from VIEW_INSTRUMENTO where inserie = @xserie) 
                      update VIEW_INSTRUMENTO set inglosa  = @xglosa  ,
    incodigo = @xcodigo  ,
    inprog  = @xprog  ,
    inrefnomi = @xrefnom  ,
    inrutemi =  @xrutemi  ,
    inmonemi = @xmonemi  ,
    inbasemi = @xbasemi  ,
    intasest = @xtasaest  ,
    intipo  = @xtipo   ,
    inmdse  = @xmdse  ,
    inmdpr  = @xmdpr  ,
    inmdtd  = @xmdtd  ,
    intipfec  = @xtipofec  ,
    inemision = @xemision  ,
    ineleg  = @xeleg   ,
    incontab = @xcontab                ,
    intotalemitido  =       @xtotalemitido          ,
    insecuritytype  =       @xsecuritytype          ,
    intiporig       =       @xintiporig            
 
    where inserie = @xserie
  else
            insert into VIEW_INSTRUMENTO ( inserie      ,
    inglosa      ,
    incodigo     ,
    inprog      ,
    inrefnomi     ,
    inrutemi     ,
    inmonemi     ,
    inbasemi     ,
    intasest     ,
    intipo      ,
    inmdse      ,
    inmdpr      ,
    inmdtd      ,
    intipfec      ,
    inemision     ,
    ineleg      ,
    incontab     ,
    intotalemitido                                  ,
    insecuritytype                                  ,
    intiporig )
 values  ( @xserie     ,
    @xglosa     ,
    @xcodigo     ,
    @xprog     ,
    @xrefnom     ,
    @xrutemi     ,
    @xmonemi     ,
    @xbasemi     ,
    @xtasaest     ,
    @xtipo      ,
    @xmdse     ,
    @xmdpr     ,
    @xmdtd     ,
    @xtipofec     ,
    @xemision     ,
    @xeleg      ,
    @xcontab      ,
    @xtotalemitido                                  ,
    @xsecuritytype                                 ,
    @xintiporig)
if @@error <> 0 begin
  set nocount off
  SELECT 'NO'
  return
end
set nocount off
SELECT 'SI'
end
--sp_help mdin

GO

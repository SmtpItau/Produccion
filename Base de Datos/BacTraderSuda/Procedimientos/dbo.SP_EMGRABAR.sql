USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMGRABAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMGRABAR] 
                             (@emcodigo1  numeric (10,0),
                              @emrut1     numeric (9,0) ,
                              @emdv1      char    (01)  ,
                              @emnombre1  char    (30)  ,                
                @emgeneric1 char    (10)  ,
                              @emdirecc1  char    (40)  ,
                              @emcomuna1  numeric (04)  ,
                              @emtipo1    char    (03)  )
as
begin   
   set nocount on
    if @emcodigo1 <>  0 
       begin
          if exists(select emcodigo from VIEW_EMISOR where emrut <> @emrut1 and emcodigo = @emcodigo1)
             begin
               set nocount off
               select '11010'
               return 
             end
       end
  
    if exists(select emgeneric from VIEW_EMISOR where emrut <> @emrut1 and emgeneric = @emgeneric1)
       begin
       set nocount off  
       select '11011'
       return 
       end
    if exists(select emrut from VIEW_EMISOR where emrut = @emrut1 )
        update VIEW_EMISOR  set emcodigo = @emcodigo1  ,           
                 emrut    = @emrut1     ,
                        emdv     = @emdv1      ,
                        emnombre = @emnombre1  ,
                        emgeneric= @emgeneric1 ,
                        emdirecc = @emdirecc1  ,                
          emcomuna = @emcomuna1  ,
                        emtipo   = @emtipo1  
               where    emrut    = @emrut1
    else
         
        insert into VIEW_EMISOR    (   emcodigo,   emrut,   emdv,   emnombre,   emgeneric,   emdirecc,   emcomuna,emtipo )
                    values ( @emcodigo1, @emrut1, @emdv1, @emnombre1, @emgeneric1, @emdirecc1, @emcomuna1,@emtipo1 ) 
 
     set nocount off 
     select 'OK'
     return
end 

GO

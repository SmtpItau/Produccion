USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGACODIGOPAIS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[SP_ENTREGACODIGOPAIS]
         (   @glosapais         char(40),
             @categoria         int      )
as
begin
set nocount on
   select   tbcodigo1, 
            tbglosa 
   from     MDTC 
   where  tbglosa= @glosapais
    and tbcateg = @categoria
set nocount off
end 


GO

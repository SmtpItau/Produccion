USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERSERIE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERSERIE]
               
as
begin
set nocount on
       select secodigo                       ,
              semascara                      ,
              seserie                        ,
              serutemi                       ,
              convert(char(10),sefecemi,103) ,
              convert(char(10),sefecven,103) ,
              setasemi                       ,
              setera                         ,
              sebasemi                       ,           
       semonemi                       ,
              secupones                      ,
              sediavcup                      ,
              sepervcup                      ,
              setipvcup                      ,
              seplazo                        ,
              setipamort                     ,
              senumamort                     ,
              seffijos                       ,
              sebascup                       ,
              sedecs                         ,
              secorte
       from
              VIEW_SERIE
 
 order by secodigo       
set nocount off
return
end

GO

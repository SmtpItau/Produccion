USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATABLA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABATABLA]( @tbcateg    numeric (   5), 
        @tbcodigo1  char    (   6),
        @tbtasa     numeric (   3),
        @tbfecha    datetime      ,
        @tbvalor    numeric (18,6),
        @tbglosa    char    (  50),
        @nemo       char    (  10) 
    )
as
begin
set nocount on
    if exists(select * from VIEW_TABLA_GENERAL_DETALLE where tbcateg = @tbcateg and tbcodigo1 = @tbcodigo1 and tbtasa = @tbtasa and tbfecha = @tbfecha) 
       update VIEW_TABLA_GENERAL_DETALLE        set  tbtasa  = @tbtasa ,
                      tbfecha = @tbfecha,
          tbvalor = @tbvalor,
            tbglosa = @tbglosa   
                           where tbcateg = @tbcateg and tbcodigo1 = @tbcodigo1 and tbtasa = @tbtasa and tbfecha = @tbfecha
      
    else 
       insert into VIEW_TABLA_GENERAL_DETALLE    (tbcateg    , 
       tbcodigo1  ,
       tbtasa     ,
       tbfecha    ,
       tbvalor    ,
       tbglosa    ,
       nemo          
                            ) 
                        values (@tbcateg    , 
           @tbcodigo1  ,
           @tbtasa     ,
           @tbfecha    ,
           @tbvalor    ,
           @tbglosa    ,
    @nemo
        )
set nocount off
SELECT 'OK'
end


GO

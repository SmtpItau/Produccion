USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESFECAMD]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ESFECAMD]( @amd     char(6)         ,
                            @dfecaux datetime output )
as
begin
     declare @dd  char(2)
     declare @mm  char(2)
     declare @aa  char(2)
     set arithignore on
     select @dd = substring(@dd,1,2)
     select @mm = substring(@dd,3,2)
     select @aa = substring(@dd,5,2)
     if convert(integer,@aa) > 50
           select @dfecaux = convert( datetime, '19'+@aa+'/'+@mm+'/'+@dd , 102 )
     else
           select @dfecaux = convert( datetime, '20'+@aa+'/'+@mm+'/'+@dd , 102 )
     set arithignore off
     if @dfecaux is null
           return 1
     else
           return 0
end

GO

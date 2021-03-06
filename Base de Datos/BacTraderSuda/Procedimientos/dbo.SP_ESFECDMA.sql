USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESFECDMA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ESFECDMA]( @amd     char(6)         ,
                            @dfecaux datetime output )
as
begin
     declare @dd  char(2)
     declare @mm  char(2)
     declare @aa  char(2)
     set arithignore on
     select @dd = substring(@amd,1,2)
     select @mm = substring(@amd,3,2)
     select @aa = substring(@amd,5,2)
     if convert(integer,@aa) > 50
           select @dfecaux = convert( datetime, @dd+'/'+@mm+'/'+'19'+@aa , 103 )
     else
           select @dfecaux = convert( datetime, @dd+'/'+@mm+'/'+'20'+@aa , 103 )
     set arithignore off
     if @dfecaux is null
           return 1
     else
           return 0
end

GO

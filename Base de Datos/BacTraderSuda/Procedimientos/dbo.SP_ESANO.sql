USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESANO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ESANO]( @aa       char(2) ,
                         @canoaux  char(4) output )
as
begin
     if charindex(substring(@aa,1,1),'0123456789') > 0 and  charindex(substring(@aa,2,1), '0123456789') > 0
        begin
             if convert(integer,@aa) > 50
                   select @canoaux = '19'+@aa
             else
                   select @canoaux = '20'+@aa
             return 0
        end
     return 1
end

GO

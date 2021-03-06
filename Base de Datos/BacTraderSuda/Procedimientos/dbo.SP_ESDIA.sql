USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESDIA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ESDIA]( @dd  char(2) )
as
begin
     if charindex(substring(@dd,1,1),'0123') > 0 and  charindex(substring(@dd,2,1),'0123456789') > 0
        begin
             if convert(integer,@dd) >= 1 and convert(integer,@dd) <= 31
                 return 0
        end
     return 1
end

GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ESMES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ESMES]( @mm       char(2) ,
                         @cmesaux  char(2) output )
as
begin
     if charindex(substring(@mm,1,1),'01') > 0 and  charindex(substring(@mm,2,1),'0123456789') > 0
        begin
             if convert(integer,@mm) >= 1 and convert(integer,@mm) <= 12
                begin
                     select @cmesaux = @mm
                     return 0
                end
        end
     return 1
end

GO

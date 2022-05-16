USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIV]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIV]( @n   float        ,
                         @d   float        ,
                         @r   float output )
as
begin
       if @d = 0.0
                   select @r = 0.0
       else
                   select @r = @n/@d
end


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFDIA30]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_DIFDIA30]( @dfecuno datetime, @dfecdos datetime, @ndiastot numeric(10,0) output  )
as
begin
 declare  @idias  integer,
   @idia1  integer,
   @idia2  integer,
   @idiastot      integer 
   select @idia1 = case when datepart(day,@dfecdos)=31 then 30 else datepart(day,@dfecdos) end
   select @idia2 = case when datepart(day,@dfecuno)=31 then 30 else datepart(day,@dfecuno) end
   select @idias = (@idia1-@idia2)
   select @idiastot = ((datediff(month,@dfecuno,@dfecdos)*30)+@idias)
   select @ndiastot = @idiastot
end

GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HACELOASI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_HACELOASI]
as
begin
declare @x         integer
declare @y         integer
declare @rut       numeric(9)
declare @serie     char(12)
select @x = 1
select @y = count(*) from series
while @x < @y
begin
 set rowcount @x
   
  select @rut=emisor, @serie = serie from SERIES
 set rowcount 0
 
  if @serie <> '' and @rut <> 0 
  begin 
 
    update VIEW_SERIE set serutemi = @rut where seserie = @serie
 
  end
  select @x = @x + 1
end
end
--sp_haceloasi

GO

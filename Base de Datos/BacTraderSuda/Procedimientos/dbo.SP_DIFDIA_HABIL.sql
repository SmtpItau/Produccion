USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFDIA_HABIL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIFDIA_HABIL]( 
    @dfecha1 datetime , 
    @dfecha2 datetime ,
    @iplazo  integer  output )
as
begin
 declare  @cdias1 varchar(255) ,
   @iplazoori integer  ,
   @icontadia integer  ,
   @dfechaaux datetime ,
    @iplazoaux integer 
 select @iplazoori = datediff(day,@dfecha1,@dfecha2)
 select @iplazoaux = @iplazoori
 select @dfechaaux  = @dfecha1
 select @icontadia = 1
 
 while @icontadia <=@iplazoori
 begin
  
  select @cdias1 =case datepart(month, @dfechaaux)  
    when  1 then feene
    when  2 then fefeb
    when  3 then femar
    when  4 then feabr
    when  5 then femay
    when  6 then fejun
    when  7 then fejul
    when  8 then feago
    when  9 then fesep
    when 10 then feoct
    when 11 then fenov
    when 12 then fedic
   end
  from VIEW_FERIADO
  where  feano   = datepart(year,@dfecha1)
  and feplaza =  6
--  select @cdias1, datepart(weekday,@dfechaaux), rtrim(convert(char(02),datepart(day,@dfechaaux)))
  if  charindex( rtrim(convert(char(02),datepart(day,@dfechaaux))),@cdias1) > 0 or 
     (datepart(weekday,@dfechaaux)= 7 or datepart(weekday,@dfechaaux)=1 ) begin 
 
   select @iplazoaux = @iplazoaux - 1
 --  select @dfechaaux
  end
  select @icontadia = @icontadia + 1
  select @dfechaaux = dateadd(day,1,@dfechaaux)
 end
 select @iplazo = @iplazoaux
-- select @iplazo 
end
/*
sp_difdia_habil  '20000922','20001003',1
*/

GO

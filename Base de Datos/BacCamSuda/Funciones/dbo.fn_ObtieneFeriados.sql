USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ObtieneFeriados]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_ObtieneFeriados](@fecha datetime, @plaza int) returns varchar(250)
as 
begin


	if not exists(select 1 from bacParamSuda..Feriado where feano = year(@fecha)
														and feplaza = @plaza
			     )
		select @plaza = 225 -- Plaza USA en caso de no existir plaza para la moneda seleccionada


	return (  select case when month(@fecha) = 1  then feene
						  when month(@fecha) = 2  then fefeb
						  when month(@fecha) = 3  then femar
						  when month(@fecha) = 4  then feabr
						  when month(@fecha) = 5  then femay
						  when month(@fecha) = 6  then fejun
						  when month(@fecha) = 7  then fejul
						  when month(@fecha) = 8  then feago
						  when month(@fecha) = 9  then fesep
						  when month(@fecha) = 10 then feoct
						  when month(@fecha) = 11 then fenov
						  when month(@fecha) = 12 then fedic
				     end
			    from bacParamSuda..Feriado
			   where feano   = year(@fecha)
				 and feplaza = @plaza
		    )
		    
		    

end
GO

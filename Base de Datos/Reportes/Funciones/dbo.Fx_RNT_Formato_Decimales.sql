USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RNT_Formato_Decimales]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_RNT_Formato_Decimales]
(
	 @number		numeric(38,10)	
	,@precision		int				
	,@decimales		int				
	,@discount_prec bit = 'true'	
)
RETURNS VARCHAR(max)
AS
BEGIN
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: RETORNA UN NUMERO CONVERTIDO A CARACTER, SEGUN PRECISION Y DECIMALES ESPECIFICADOS
	AUTOR		: RODRIGO SILVA RAMIREZ  

	PARAMETROS:
	- @number			:	numero a convertir
	- @precision		:	cantidad de enteros
	- @decimales		:	cantidad de decimales
	- @discount_prec	:	descontar precision (resta de la prescion vs decimales)
			- ejemplo:
					-@discount_prec = true  -> @presicion= 20,@decimales = 4 
							--> 16 enteros y 4 decimales. >20 caracteres resultantes
				 	-@discount_prec = false -> @presicion= 20,@decimales = 4 
							--> 20 enteros y 4 decimales. >24 caracteres resultantes			  	
*/
--@number			numeric(38,10)	
--,@precision		int				
--,@decimales		int				
--,@discount_prec	bit = 'true'	
--set @number = -0.49380
--set @number = -999.08000
--set @precision = 8
--set @decimales = 5
--set @discount_prec = 1


	declare 
		@return_value	varchar(max)
		,@raw_number	varchar(max)		
		,@aux_number	varchar(max)
		
	if @discount_prec = 'true' begin		
		set @precision = @precision - @decimales
	end 
	
	--si el numero es 0 o nulo
	if @number = 0 or ISNULL(@number,0)=0 begin		
		return replicate('0',@precision+@decimales)	
	end
				 
	set @raw_number = convert(varchar(max),@number)
		
	-- validacion parte entera
	-- error cuando sobrepasa el numero el tamaño de la presicion solicitada.
	if len(substring(@raw_number,1,patindex('%.%',@raw_number)-1))>@precision 
	begin
		--raiseerror(14198,10,0,N'@number','@precision')
		--return 'N/C' 
		return right(replicate(' ',@precision+@decimales)+'N/C',9)
		--return replicate('9',@precision+@decimales)		
	end
	declare 
		@str_decimales varchar(max)
	,	@str_enteros   varchar(max)

	set @str_enteros	= (select substring(@raw_number,1,patindex('%.%',@raw_number)-1))
	set @str_decimales	= (select substring(@raw_number,patindex('%.%',@raw_number)+1,@decimales))

	set @return_value = 
	(case 
		when @number<0 then
			stuff(
				right(replicate('0',@precision)
				+ replace(
					substring(@raw_number,1,patindex('%.%',@raw_number)-1),'-',''),@precision),1,1,'-')
		when @number>0 then
			right( replicate('0',@precision) 
			+ SUBSTRING(@raw_number,1,patindex('%.%',@raw_number)-1),@precision)
		end
	)
	set @return_value = @return_value + @str_decimales
	return @return_value
end
GO

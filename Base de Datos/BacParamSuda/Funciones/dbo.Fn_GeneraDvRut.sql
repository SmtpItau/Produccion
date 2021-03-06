USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_GeneraDvRut]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fn_GeneraDvRut]
	(	@nRut	numeric(11)	)	returns char(5)
as
begin

	declare @sRut	varchar(11)
		set @sRut	=	ltrim(rtrim( replicate('0', 9 - len( rtrim(ltrim(@nRut)) ))))
					+	rtrim(ltrim( @nRut ))
		
	declare @d		numeric(9)
		set @d		= 2
	declare @suma	numeric(9)
		set @suma	= 0
	declare @i		int
		set @i		= len( @sRut )
	declare @multi	float

	while @i >= 0
	begin
		set @multi	= substring( @sRut, @i, 1)
		set @multi	= @multi * @d
		set @suma	= @suma  + @multi
		
		set @d = @d + 1
		set @i = @i - 1
		
		if @d = 8
			set @d = 2
	end
	
	declare @divi	int
		set @divi	= (@suma / 11.0)
		set @multi	= (@divi * 11)

	declare @digito	char(2)
		set @digito	= ltrim(rtrim( (11 - (@suma - @multi)) ))

	if @digito = '10'
		set @digito	= 'K'
	
	if @digito = '11'
		set @digito	= '0'

	return @digito
end
GO

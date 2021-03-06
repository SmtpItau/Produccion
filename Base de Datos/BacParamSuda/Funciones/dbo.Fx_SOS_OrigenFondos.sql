USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_OrigenFondos]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_OrigenFondos]
	(	@iMedioPago	int	
	)	returns		char(1)
as
begin

	declare @cRetorno	char(1)
		set @cRetorno	= case	when @iMedioPago in(123, 15, 16, 143, 20, 144, 140, 19) then '2'
								when @iMedioPago in(17, 103, 104, 8, 105, 106, 134, 135, 136, 124, 125, 122, 137, 138, 139, 132, 133, 128, 129, 130, 12, 13, 14, 11, 131) then '0'
								else 'N' --> Definido con Fecha 21-07-2014 por Roberto Fuentes Hernandez
							end

	return @cRetorno

end
GO

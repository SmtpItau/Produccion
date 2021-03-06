USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_Causal]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_Causal]
	(	@iMedioPago	int	
	)	returns		char(2)
as
begin

	declare @cRetorno	char(2)
		set @cRetorno	= case	when @iMedioPago in(123, 15, 16, 143, 20, 144, 140, 19) then 'TH'
								when @iMedioPago in(17, 103, 104, 8, 105, 106, 134, 135, 136, 124, 125, 122, 137, 138, 139, 132, 133, 128, 129, 130, 12, 13, 14, 11, 131) then 'TH'
								else 'N' --> Definido el 21-07-2014 por Roberto Fuentes
							end

	return @cRetorno

end

GO

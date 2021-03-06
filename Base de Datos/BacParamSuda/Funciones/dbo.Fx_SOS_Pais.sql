USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_Pais]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_Pais]
	(	@IdPais		int
	,	@nCampo		int
	)	Returns		varchar(40)	
as
begin

	declare @cRetorno	varchar(40)
		set @cRetorno	= ''

	select	@cRetorno	= case	when @nCampo = 1 then Nemo
								when @nCampo = 2 then Nemo
								when @nCampo = 3 then Nemo
							end
	from	dbo.Sos_Pais
	where	Codigo		= @IdPais
	
	if len(@cRetorno) = 0 or @cRetorno is null
	begin
		select	@cRetorno	= case	when @nCampo = 1 then Nemo
									when @nCampo = 2 then Nemo
									when @nCampo = 3 then Nemo
								end
		from	dbo.Sos_Pais
		where	Codigo		= 999 --> Otro - SI
	end

	return @cRetorno

end
GO

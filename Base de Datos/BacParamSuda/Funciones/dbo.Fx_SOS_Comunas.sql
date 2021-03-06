USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_Comunas]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_Comunas]
	(	@Id_Comuna		int
	)	returns			varchar(4)	
as
begin

	declare	@cRetorno		varchar(4)
		set @cRetorno		= ''
	declare @cComuna		varchar(50)
		set @cComuna		= ''
		
	select	@cComuna		= isnull(nombre, 'Sin Información')
	from	BacParamSuda.dbo.Comuna with(nolock) 
	where	codigo_comuna	= @Id_Comuna

	select	top 1 
			@cRetorno	= Id
	from	BacParamSuda.dbo.SOS_Comunas
	where	Comuna		like '%' + @cComuna + '%'

	IF len( ltrim(rtrim( @cRetorno )) ) = 0
		SET @cRetorno = 9999

	return	isnull(@cRetorno, 9999)
	
end

GO

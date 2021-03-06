USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_MoveEventControls]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[SP_MID_MoveEventControls]
	(	@IdModulo	Int
	,	@IdEvento	Int
	,	@IdEstado	Int
	)
as
begin

	set nocount on

	declare @Estado		varchar(50)
		set @Estado		=	(	select	Descripcion
								from	BacParamSuda.dbo.MID_Estados with(nolock)
								where	Id = @IdEstado
							)

	update	BacParamSuda.dbo.MID_Monitor_Eventos
	set		IdEstado	= @IdEstado
	,		Estado		= @Estado
	where	IdModulo    = @IdModulo
	and		IdEvento	= @IdEvento


	if @IdEstado = 1
		update	BacParamSuda.dbo.MID_Monitor_Eventos
		set		HoraInicio	= convert(char(8), GetDate(), 108)
		where	IdModulo    = @IdModulo
		and		IdEvento	= @IdEvento

	if @IdEstado > 1
		update	BacParamSuda.dbo.MID_Monitor_Eventos
		set		HoraTermino	= convert(char(8), GetDate(), 108)
		where	IdModulo    = @IdModulo
		and		IdEvento	= @IdEvento

end
GO

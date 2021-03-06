USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_MoveEventControls_NY]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[SP_MID_MoveEventControls_NY]
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

	update	BacParamSuda.dbo.MID_Monitor_EventosNY
	set		IdEstado	= @IdEstado
	,		Estado		= @Estado
	where	IdModulo    = @IdModulo
	and		IdEvento	= @IdEvento


	if @IdEstado = 1
		update	BacParamSuda.dbo.MID_Monitor_EventosNY
		set		HoraInicio	= convert(char(8), GetDate(), 108)
		where	IdModulo    = @IdModulo
		and		IdEvento	= @IdEvento

	if @IdEstado > 1
		update	BacParamSuda.dbo.MID_Monitor_EventosNY
		set		HoraTermino	= convert(char(8), GetDate(), 108)
		where	IdModulo    = @IdModulo
		and		IdEvento	= @IdEvento

	-->	Fuerza el cerrado de los procesos de NY, una vez finalizado BONEX NY.
	if @IdModulo = 3 and @IdEvento = 1 and @IdEstado = 2
	begin
		execute SP_MID_InicioProceso_NY 2
	end

end
GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ServicioCierre_ControlActividades]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_ServicioCierre_ControlActividades]
	(	@nId		int
	,	@nModulo	int
	,	@nEstado	int
	,	@nReinicio	int		= 0
	)
as
begin

	set nocount on

	-->	Reinicio de Actividades y preparacion para servicio
	if (@nReinicio = 1) 
	begin
		update	dbo.ServicioCierre_ControlActividades
		set		Estado		= 0
			,	HoraInicio	= '00:00:00'
			,	HoraTermino	= '00:00:00'

		if @@error <> 0
			select -1, 'Error en Reiniciar Estados, en tabla de eventos'
		else
			select 0, 'Reinicio de Estados Ok'
		return
	end
	-->	Reinicio de Actividades y preparacion para servicio


	-->	Marca el Evento como Iniciado
	if (@nEstado = 1) and (@nReinicio = 0)
	begin
		update	dbo.ServicioCierre_ControlActividades
		set		Estado		= @nEstado
			,	HoraInicio	= convert(char(10), getdate(),108)
		where	Id			= @nId
		and		Modulo		= case	when @nModulo = 1 then 'BFW'
									when @nModulo = 2 then 'PCS'
									when @nModulo = 3 then 'BEX'
								end
		if @@error <> 0
			select -1, 'Error en cambio de estado'
		else
			select 0, 'Cambio de estado ok'
		return
	end
	-->	Marca el Evento como Iniciado

	
	-->	Marca el Evento como Finalizado o Cancelado
	if ((@nEstado = 2) or (@nEstado = 3)) and (@nReinicio = 0)
	begin
		update	dbo.ServicioCierre_ControlActividades
		set		Estado		= @nEstado
			,	HoraTermino	= convert(char(10), getdate(),108)
		where	Id			= @nId
		and		Modulo		= case	when @nModulo = 1 then 'BFW'
									when @nModulo = 2 then 'PCS'
									when @nModulo = 3 then 'BEX'
								end
		if @@error <> 0
			select -1, 'Error en cambio de estado'
		else
			select 0, 'Cambio de estado ok'
		return
	end
	-->	Marca el Evento como Finalizado o Cancelado

end
GO

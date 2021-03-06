USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[ServicioCierre_StopAndGo_General]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ServicioCierre_StopAndGo_General]
	(	@nEstado	int		
	,	@nModulo	int = 0
	)
as
begin

	set nocount on

	declare @nAuxEstado	int
		set @nAuxEstado	= ( select Estado from ServicioCierre_Control with(nolock) )

	-->	Inicializa los Status por modulos
	if (@nModulo > 0)
	begin
		if @nModulo = 1
			update dbo.ServicioCierre_Control	set SwForward	= @nEstado
		if @nModulo = 2
			update dbo.ServicioCierre_Control	set SwSwap		= @nEstado
		if @nModulo = 3
			update dbo.ServicioCierre_Control	set SwBonex		= @nEstado
		if @nModulo = 4
			update dbo.ServicioCierre_Control	set SwOpciones	= @nEstado

		if @nEstado = 1
			select 0, 'Inicialización de ' + case	when @nModulo = 1 then 'Forward' 
													when @nModulo = 2 then 'Swap' 
													when @nModulo = 3 then 'Bonex' 
													else ''
												end	+ ', ha sucedido de forma correcta.'
		if @nEstado = 2
			select 0, 'Finalización de '	+ case	when @nModulo = 1 then 'Forward' 
													when @nModulo = 2 then 'Swap' 
													when @nModulo = 3 then 'Bonex' 
													else ''
												end	+ ', ha sucedido de forma correcta.'

		if @nEstado = 3
			select 0, 'Cancelación de '		+ case	when @nModulo = 1 then 'Forward' 
													when @nModulo = 2 then 'Swap' 
													when @nModulo = 3 then 'Bonex' 
													else ''
												end	+ ', ha sucedido de forma correcta.'
		return
	end
	-->	Inicializa los Status por modulo


	-->	Reinicia los datos para alistar la ejecucion
	if (@nEstado = -1 and @nModulo = 0)
	begin
		set @nEstado = 0	--> En Espera
		update	dbo.ServicioCierre_Control
			set	Estado			=	@nEstado
			,	SwForward		=	@nEstado
			,	SwSwap			=	@nEstado
			,	SwBonex			=	@nEstado
			,	SwOpciones		=	@nEstado
			,	HoraInicio		=	'00:00:00'
			,	HoraTermino		=	'00:00:00'
		
		select 0, 'Reinicio de Estados, ha ocurrido correctamente.'
		return
	end
	-->	Reinicia los datos para alistar la ejecucion


	-->	Marca Estado General del proceso : "En Espera", siempre y cuando el estado actual corresponda a : "Finalizado" o "Cancelado"
	if (@nEstado = 0 and @nModulo = 0)
	begin
		if (@nAuxEstado = 2 or @nAuxEstado = 3)
		begin
			update	dbo.ServicioCierre_Control
				set	Estado			=	@nEstado
				,	SwForward		=	@nEstado
				,	SwSwap			=	@nEstado
				,	SwBonex			=	@nEstado
				,	SwOpciones		=	@nEstado
				,	HoraInicio		=	'00:00:00'
				,	HoraTermino		=	'00:00:00'

			select 0, 'Reinicio de Estados, ha ocurrido correctamente.'
		end else
		begin
			select -1, 'Reinicio de Estados, ha fallado, estado anterior : ' + ltrim(rtrim( @nAuxEstado ))
		end
		return
	end 
	-->	Marca Estado General del proceso : "En Espera", siempre y cuando el estado actual corresponda a : "Finalizado" o "Cancelado"

	
	-->	Marca Estado General del proceso : "Iniciado", siempre y cuando el estado actual corresponda a : "En Espera", "Finalizado" o "Cancelado"
	if (@nEstado = 1 and @nModulo = 0)
	begin
		if (@nAuxEstado = 0 or @nAuxEstado = 2 or @nAuxEstado = 3)
		begin
			update	dbo.ServicioCierre_Control
				set	Estado			=	@nEstado
				,	HoraInicio		=	convert(char(10), getdate(), 108)

			select 0, 'Inicialización de Estado, ha ocurrido correctamente.'
		end else
		begin
			select -1, 'Inicialización de Estado, ha fallado, estado anterior : '  + ltrim(rtrim( @nAuxEstado ))
		end
		return
	end
	-->	Marca Estado General del proceso : "Iniciado", siempre y cuando el estado actual corresponda a : "En Espera", "Finalizado" o "Cancelado"


	-->	Marca Estado General del proceso : "Finalizado", siempre y cuando el estado actual corresponda a : "Iniciado"
	if (@nEstado = 2 and @nModulo = 0)
	begin
		if (@nAuxEstado = 1)
		begin
			update	dbo.ServicioCierre_Control
				set	Estado			=	@nEstado
				,	HoraTermino		=	convert(char(10), getdate(), 108)
				,	ProximaFecha	=	(select fechaprox from BacSwapNy.dbo.SwapGeneral with(nolock))

			select 0, 'Finalización de Estado, ha ocurrido correctamente.'
		end else
		begin
			select -1, 'Finalización de Estado, ha fallado, estado anterior : ' + ltrim(rtrim( @nAuxEstado ))
		end
		return		
	end
	-->	Marca Estado General del proceso : "Finalizado", siempre y cuando el estado actual corresponda a : "Iniciado"


	-->	Marca Estado General del proceso : "Cancelado", siempre y cuando el estado actual corresponda a : "Iniciado"
	if (@nEstado = 3 and @nModulo = 0)
	begin
		if (@nAuxEstado = 1)
		begin
			update	dbo.ServicioCierre_Control
				set	Estado			=	@nEstado
				,	HoraTermino		=	convert(char(10), getdate(), 108)
				,	ProximaFecha	=	(select fechaproc from BacSwapNy.dbo.SwapGeneral with(nolock))

			select 0, 'Cancelación de Estado, ha ocurrido correctamente.'
		end else
		begin
			select -1, 'Cancelación de Estado, ha fallado, estado anterior : ' + ltrim(rtrim( @nAuxEstado ))
		end
		return		
	end
	-->	Marca Estado General del proceso : "Cancelado", siempre y cuando el estado actual corresponda a : "Iniciado"

end

GO

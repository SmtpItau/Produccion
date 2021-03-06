USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[ServicioCierre_ControlInicio]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ServicioCierre_ControlInicio]
as
begin

	set nocount on

	select -1, 'False', 'Aviso, Proceso de Cierre de Día Automático, Desactivado !!!! '

	return


	-->		Constantes
	declare @iSwOn				int	;	set @iSwOn				= 1
	declare @iSwOff				int	;	set @iSwOff				= 0
	declare @iSwCancel			int	;	set @iSwCancel			= -1

	declare @iSwCtrl_BEX		int	;	set	@iSwCtrl_BEX		= @iSwOn	--> Activa la validacion en Bonex
	declare @iSwCtrl_BFW		int	;	set	@iSwCtrl_BFW		= @iSwOn	--> Activa la validacion en Forward
	declare @iSwCtrl_PCS		int	;	set	@iSwCtrl_PCS		= @iSwOn	--> Activa la validacion en Swap
	declare @iSwCtrl_OPC		int	;	set	@iSwCtrl_OPC		= @iSwOff	--> Activa la validacion en SAO

	-->		Para Procesos Por Modulos
	declare @iSw_Es				int	;	set	@iSw_Es				= @iSwCancel
	declare @iSw_Bn				int	;	set	@iSw_Bn				= @iSwCancel
	declare @iSw_Fw				int	;	set	@iSw_Fw				= @iSwCancel
	declare @iSw_Sp				int	;	set	@iSw_Sp				= @iSwCancel

	declare @dPrxFe				datetime
	declare @dFechaSistema		datetime
		set @dFechaSistema		= convert(datetime, convert(char(10), GetDate(), 112))

	-->		Para Procesos Diarios (Sw de procesos de cada uno de los modulos)
	declare @iSw_Id				int
	declare @iSw_Cm				int
	declare @iSw_Tm				int
	declare @iSw_Dv				int
	declare @iSw_Co				int
	declare @iSw_Fd				int

	-->		Para Retornos Finales y controles mod modulo y a nivel general (Enmarca los Estados de las validaciones)
	declare @nEstadoGeneral		int	;	set @nEstadoGeneral		= @iSwCancel
	declare @nEstadoBonex		int	;	set @nEstadoBonex		= case when @iSwCtrl_BEX	= @iSwOn then @iSwCancel	else @iSwOn end
	declare @nEstadoForward		int	;	set	@nEstadoForward		= case when @iSwCtrl_BFW	= @iSwOn then @iSwCancel	else @iSwOn end
	declare @nEstadoSwap		int	;	set	@nEstadoSwap		= case when @iSwCtrl_PCS	= @iSwOn then @iSwCancel	else @iSwOn end
	declare @nEstadoOpciones	int	;	set	@nEstadoOpciones	= case when @iSwCtrl_OPC	= @iSwOn then @iSwCancel	else @iSwOn end

	/************************************************************
	La definición de mensajes para el retorno
			Estado numerico = (-1	: Error ; 0		: Ok)
		,	Estado booleano = (False: Error ; True	: Ok)
		,	Mensaje			= Texto de Caracter libre

	Recordatorio de los Estados
		-1 : no Configurado
		 0 : En Espera de ejecución
		 1 : En Ejecución
		 2 : Finalizado
		 3 : Cancelado o Finalizado con Error
	************************************************************/


Configuracion_Original:
	-->	Control de Cierre para la primera vez
	if (select ProximaFecha from dbo.ServicioCierre_Control with(nolock) ) = '19000101'
	begin
		-- Debiese solo ejecutarce una vez en la vida del proceso de cierre
		update	dbo.ServicioCierre_Control
			set ProximaFecha = ( select fechaprox from BacSwapNy.dbo.SwapGeneral with(nolock) ) --> Utilzia esta base por los feriados chilenos.
	end
	-->	Control de Cierre para la primera vez


Primer_Control:
	-->		I.- Inicio de Control General de Procesos
	select	@iSw_Es			= Estado
		,	@iSw_Fw			= SwForward
		,	@iSw_Sp			= SwSwap
		,	@iSw_Bn			= SwBonex 
		,	@dPrxFe			= ProximaFecha
	from	dbo.ServicioCierre_Control with(nolock)

	-->		para la validacion de la fecha de proceso a cerrar
	declare @dFechaControl	datetime
		set	@dFechaControl	= (	select fechaprox from BacSwapNy.dbo.SwapGeneral with(nolock) ) --> 2014-10-17
	-->		para la validacion de la fecha de proceso a cerrar

	/*
	-->	Fecha a Cerrar, debe coincidir con la fecha calendario a Cerrar. ... Eso quiere decir que, si por retraso en las tareas diarias no se 
	if (@dFechaSistema <> @dFechaControl)
		begin
			select @nEstadoGeneral, 'False'	, 'Control General, Fecha de Proceso a cerrar no concuerda... '
											+ ' Fecha a Cerrar.   '	+ convert(char(10), @dFechaControl, 103) + ' v/s'
											+ ' Fecha de Sistema. ' + convert(char(10), @dFechaSistema, 103)
			return
		end
	-->	Fecha a Cerrar, debe coincidir con la fecha calendario a Cerrar. ... Eso quiere decir que, si por retraso en las tareas diarias no se 
	*/


	-->		Estado General de Servicio
	if (@iSw_Es = @iSwOn)	--> Servicio se encuentra en ejecución
		begin
			select @nEstadoGeneral, 'False', 'Advertencia. Control General, Proceso de Cierre, se encuentra en ejecución.'
			return
		end

	if (@iSw_Es = @iSwCancel) or (@iSw_Es = @iSwOff)	--> Servicio a la espera de la ejecución
		begin
			if @dPrxFe <> @dFechaControl				--> Error de fechas, no concuerdan
				begin
					select @nEstadoGeneral, 'False'	, 'Advertencia. Control General, Fecha de Proceso a cerrar no concuerda... '
													+ ' Fecha Esperada. '	+ convert(char(10), @dPrxFe, 103)
													+ ' <> Fecha Proxima '	+ convert(char(10), @dFechaControl, 103)
					return
				end
		end
	-->		I.- Fin de Control General de Procesos


	-->		II.- Inicio de Control Especifico de Procesos
Segundo_Control:
	-->		Inversiones al Exterior o Bonex
	if @iSwCtrl_BEX = @iSwOn
	begin
		select	@iSw_Id	= acsw_pd
			,	@iSw_Cm	= acsw_mesa
			,	@iSw_Tm	= acsw_tm
			,	@iSw_Dv	= acsw_dv
			,	@iSw_Co	= acsw_co
			,	@iSw_Fd	= acsw_fd
		from	BacBonosExtNy.dbo.text_arc_ctl_dri with(nolock)

		if (@iSw_Id = @iSwOff)
			begin
				select @nEstadoBonex, 'False', 'Advertencia. Control de Cierre de Bonex, Proceso de apertura no se ha generado.'
				return
			end
		if (@iSw_Fd = @iSwOn)
			begin
				select @nEstadoBonex, 'False',  'Advertencia. Control de Cierre de Bonex, Módulo se encuentra cerrado.'
				return
			end
		if (@iSw_Cm = @iSwOff)
			begin
				select @nEstadoBonex, 'False',  'Advertencia. Control de Cierre de Bonex, Cierre de mesa no generado.'
				return
			end
		if (@iSw_Dv = @iSwOff)
			begin
				select @nEstadoBonex, 'False',  'Advertencia. Control de Cierre de Bonex, Proceso de devengamiento, no generado'
				return
			end
		if (@iSw_Tm = @iSwOff)
			begin
				select @nEstadoBonex, 'False', 'Advertencia. Control de Cierre de Bonex, Proceso de valorización a mercado no generado.'
				return
			end

		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
		if	(@iSw_Id = @iSwOn and @iSw_Cm = @iSwOn and @iSw_Dv = @iSwOn and @iSw_Tm = @iSwOn and @iSw_Co = @iSwOff and @iSw_Fd = @iSwOff) 
		and (@iSw_Bn = @iSwOff)
			begin
					set @nEstadoBonex = @iSwOn
			--	select	@nEstadoBonex, 'True', 'Control de cierre de Bonex, Procesos estan OK para iniciar.'
			end else
			begin
					set @nEstadoBonex = @iSwCancel
				select	@nEstadoBonex, 'False', 'Advertencia. Control de Cierre de Bonex, Proceso se encuentra en ejecución'
				return
			end
		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
	-->		Inversiones al Exterior o Bonex
	end		-->	if @iSwCtrl_BEX = 1


Tercer_Control:
	-->		Forward
	if @iSwCtrl_BFW = @iSwOn
	begin
		select	@iSw_Id	= acsw_pd
			,	@iSw_Cm	= acsw_ciemefwd
			,	@iSw_Dv	= acsw_devenfwd
			,	@iSw_Co	= acsw_contafwd
			,	@iSw_Fd	= acsw_fd
		from	BacFwdNy.dbo.mfac with(nolock)

		if (@iSw_Id = @iSwOff)
			begin
				select @nEstadoForward, 'False', 'Advertencia. Control de Cierre de Forward, Proceso de Apertura no se ha generado.'
				return
			end
		if (@iSw_Fd = @iSwOn)
			begin
				select @nEstadoForward, 'False',  'Advertencia. Control de Cierre de Forward, Módulo se encuentra cerrado.'
				return
			end
		if (@iSw_Cm = @iSwOff)
			begin
				select @nEstadoForward, 'False',  'Advertencia. Control de Cierre de Forward, Cierre de mesa no generado.'
				return
			end

		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
		if	(@iSw_Id = @iSwOn and @iSw_Cm = @iSwOn and @iSw_Dv = @iSwOff and @iSw_Co = @iSwOff and @iSw_Fd = @iSwOff) and (@iSw_Fw = @iSwOff)
			begin
				set		@nEstadoForward = @iSwOn
			--	select	@nEstadoForward, 'True', 'Control de cierre de Foward, Procesos estan OK para iniciar.'
			end else
			begin
				set		@nEstadoForward = @iSwCancel
				select	@nEstadoForward, 'False', 'Advertencia. Control de Cerre de Forward, Proceso se encuentra en ejecución.'
				return
			end
		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
	-->		Forward
	end		-->	if @iSwCtrl_BFW = 1


Cuarto_Control:
	-->		Swap
	if @iSwCtrl_PCS = @iSwOn
	begin
		select	@iSw_Id	= iniciodia
			,	@iSw_Cm	= cierreMesa
			,	@iSw_Dv	= devengo
			,	@iSw_Co	= contabilidad
			,	@iSw_Fd	= findia
		from	BacSwapNy.dbo.SwapGeneral with(nolock)

		if (@iSw_Id = @iSwOff)
			begin
				select @nEstadoSwap, 'False', 'Advertencia. Control de Cierre de Swap, Proceso de Apertura no se ha generado.'
				return
			end
		if (@iSw_Fd = @iSwOn)
			begin
				select @nEstadoSwap, 'False',  'Advertencia. Control de Cierre de Swap, Módulo se encuentra cerrado.'
				return
			end
		if (@iSw_Cm = @iSwOff)
			begin
				select @nEstadoSwap, 'False',  'Advertencia. Control de Cierre de Swap, Cierre de mesa no generado.'
				return
			end
			
		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
		if	(@iSw_Id = @iSwOn and @iSw_Cm = @iSwOn and @iSw_Dv = @iSwOff and @iSw_Co = @iSwOff and @iSw_Fd = @iSwOff) and (@iSw_Sp = @iSwOff)
			begin
				set		@nEstadoSwap = @iSwOn	
			--	select	@nEstadoSwap, 'True', 'Control de cierre de Swap, Procesos estan OK para iniciar.'
			end else
			begin
				set		@nEstadoSwap = @iSwCancel
				select	@nEstadoSwap, 'False', 'Advertencia. Control de Cierre de Swap, Proceso se encuentra en ejecución.'
				return
			end
		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
	-->		Swap
	end		-->	if @iSwCtrl_PCS = 1


Quinto_Control:
	-->		Opciones
	if @iSwCtrl_OPC = @iSwOn
	begin
		select	@iSw_Id	= iniciodia
			,	@iSw_Cm	= cierreMesa
			,	@iSw_Dv	= devengo
			,	@iSw_Co	= contabilidad
			,	@iSw_Fd	= findia
		from	lnkopc.cbmdbopcny.dbo.OpcionesGeneral

		if (@iSw_Id = @iSwOff)
			begin
				select @nEstadoOpciones, 'False', 'Advertencia. Control de Cierre de Opciones, Proceso de Apertura no se ha generado.'
				return
			end
		if (@iSw_Fd = @iSwOn)
			begin
				select @nEstadoOpciones, 'False',  'Advertencia. Control de Cierre de Opciones, Módulo se encuentra cerrado.'
				return
			end
		if (@iSw_Cm = @iSwOff)
			begin
				select @nEstadoOpciones, 'False',  'Advertencia. Control de Cierre de Opciones, Cierre de mesa no generado.'
				return
			end

		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
		if	(@iSw_Id = @iSwOn and @iSw_Cm = @iSwOn and @iSw_Dv = @iSwOff and @iSw_Co = @iSwOff and @iSw_Fd = @iSwOff) and (@iSw_Sp = @iSwOff)
			begin
				set		@nEstadoOpciones = @iSwOn	
			--	select	@@nEstadoOpciones, 'True', 'Control de cierre de Opciones, Procesos estan OK para iniciar.'
			end else
			begin
				set		@nEstadoOpciones = @iSwCancel
				select	@nEstadoOpciones, 'False', 'Advertencia. Control de Cierre de Opciones, Proceso se encuentra en ejecución.'
				return
			end
		--> Control para aplicar : Sobre Ejecución o Entre las Ejecuciones
	-->		Opciones
	end		-->	if @iSwCtrl_OPC = @iSwOn


Sexto_Control:
	if (@nEstadoBonex = @iSwOn	and @nEstadoForward = @iSwOn and @nEstadoSwap = @iSwOn and @nEstadoOpciones = @iSwOn)
	begin
		set @nEstadoGeneral = @iSwOn
		select	@nEstadoGeneral, 'True', 'Ok, Control de Cierre General, Proceso se encuentra listo para ejecutar.'
	end
end

GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MID_Control_Inicio_NY]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_MID_Control_Inicio_NY]
	(	@Pruebas_Si_No		int	= 0		)	-->	Si = 1; No = 0
		/*
		Este parametro se Agrego para no estar modificando el procedimiento
		1. Que este en "Cero", su valor por defecto, indica que es la forma natural de ejecución (Pruebas No)
		2. Que este en "Uno",  Indica que el proceso se esta ejecutando solo para verificar los controles aplicados
				y el posible retorno de un valor Falso para la ejecución. (Prueba de Control)
		*/
as
begin

	set nocount on

	declare @dFechaSistema	datetime
	declare @dFechaControl	datetime
	declare @swInicioDia	int
	declare @swFinDia		int
	declare @iEstado		int

/*	*****************************************************	*/
	/*		Para forzar los cierres de los modulos No-Activos	*/
	declare @Sw_FuerzaCierre_Fwd	int
		set	@Sw_FuerzaCierre_Fwd	= 1

	declare @Sw_FuerzaCierre_Opt	int
		set @Sw_FuerzaCierre_Opt	= 1
	/*		Para forzar los cierres de los modulos No-Activos	*/

	/*		Se aplica cierre automatico de New York, para el modulo de Opciones	*/
	if ( @Sw_FuerzaCierre_Opt = 1)
		begin
			update	lnkopc.cbmdbopcny.dbo.OpcionesGeneral
				set	iniciodia		= 0
				,	cierreMesa		= 1
				,	devengo			= 1
				,	contabilidad	= 1
				,	findia			= 1
		end
	/*		Se aplica cierre automatico de New York, para el modulo de Opciones	*/

	begin transaction
			
	/*		Se aplica cierre automatico de New York, para el modulo de Forward	*/
	if ( @Sw_FuerzaCierre_Fwd = 1 ) 
		begin
			update	BacFwdNy.dbo.mfac 
				set acsw_pd			= 0
				,	acsw_ciemefwd	= 1
				,	acsw_devenfwd	= 1
				,	acsw_contafwd	= 1
				,	acsw_fd			= 1
		end
	/*		Se aplica cierre automatico de New York, para el modulo de Forward	*/
/*	*****************************************************	*/

	/*
		Se extraen las fechas de Proceso y Servidor, Los Switch de Inicio y Fin de Día del Modulo de Forward
	*/

	select	@dFechaSistema	= convert(datetime, convert(char(10), GetDate(), 112))
		,	@dFechaControl	= acfecprox
		,	@swInicioDia	= acsw_pd
		,	@swFinDia		= acsw_fd
	from	BacFwdNy.dbo.Mfac

	/*
		Este control es irrelevante, la hora se configuro finalmente en el Web Config del Servicio
	*/

	declare @cHoraEjecucion		char(10)
		set @cHoraEjecucion		=	(select Hora from MID_HoraEjecucion )

	/*
		Lee el Estado del Proceso de Inicio (Estado = 1: Proceso en Ejecucion
											 Estado = 2: Proceso en Espera de nueva Ejecución)
	*/

	set		@iEstado		=	(select Estado from BacParamSuda.dbo.MID_Control_InicioNY)

	if @iEstado = 1
	begin
		rollback transaction
		select Estado = 'False', Mensaje = 'Warning', Descripcion = 'Proceso en Ejecución'
		return
	end

	-->		Control de Sincronizacion de Fechas y Sitch de Procesos.
	/*
		Se obtienene los Sw de Inicio y Fin de día de todos los modulos, para determinar la Sincronia entre ellos 
		y verificar que se encuentren en condiciones de ejecutar el proceso.
		El retorno Normal es que indique : (@iFinDia = 1;	@iRegistros = 1)
		@iFinDia	= 1, indica que todos los sistemas generaron ya su fin de día
						 en caso contrario retorna = 0 (Cero)
		@iRegistros = 1, indica que solo existe un retorno de datos lo cual es correcto
						 en caso contrario retornaria = 1 (Ningun sistema ha cerrado)
						                              > 1 (Existe algun sistema que no esta sincronizado)
	*/

	declare @iFinDia	int
	declare @iRegistros	int

	select	@iFinDia	= MIN( ControlInicioDia.fDia )
		,	@iRegistros	= SUM( Reg )
	from	(	
				select	fDia	= FinDia.fDia
					,	FecPrx	= FinDia.FecPrx
					,	Reg		= Count(1)
				from	(	select fDia		= acsw_fd,	FecPrx = acfecprox	from BacFwdNy.dbo.Mfac						with(nolock) 
					union	select fDia		= acsw_fd,	FecPrx = acfecprox	from BacBonosExtNy.dbo.Text_Arc_Ctl_Dri		with(nolock)
					union	select fDia		= findia,	FecPrx = fechaprox	from BacSwapNy.dbo.SwapGeneral				with(nolock)
		--			union	select fDia		= findia,	FecPrx = fechaprox	from lnkOpc.CbMdbOpcNy.dbo.OpcionesGeneral	with(nolock)
						)	FinDia
				group
				by		FinDia.fDia
					,	FinDia.FecPrx
			)	ControlInicioDia

	--	   Retorno Esperado (Correcto)
	if NOT(@iFinDia = 1 and @iRegistros = 1)
	begin
		rollback transaction
		select  Estado			= 'False'
			,	Mensaje			= 'Err.'
			,	Descripcion		= 'Error en Sincronización de Modulos...'
			,	Hora			= @cHoraEjecucion
			,	dFechaControl	= @dFechaControl
			,	dFechaSistema	= @dFechaSistema
		return
	end
	-->		Control de Sincronizacion de Fechas y Sitch de Procesos.

	-->		Control de Indices (Valore de Monedas cargados para el Proximo día)
	declare @iMonedas	int
		set @iMonedas	= -1

	select	@iMonedas	= Count(1)
	from	(	select	vmfecha, vmcodigo, mnglosa, vmvalor, mntipmon 
				from	BacParamSuda.dbo.Valor_Moneda with(nolock)
						inner join BacParamSuda.dbo.Moneda with(nolock) On mncodmon = vmcodigo
				where	vmfecha		= (select acfecprox from BacFwdNy.dbo.Mfac with(nolock) )
				and		vmcodigo	IN(302, 800, 801, 802, 997, 994, 995, 998 )
			)	ValMon
	where	ValMon.vmvalor = 0

	if @iMonedas <> 0
	begin
		rollback transaction
		select  Estado			= 'False'
			,	Mensaje			= 'Err.'
			,	Descripcion		= 'Error en parametros, falta ingreso de valor para indice diario.'
			,	Hora			= @cHoraEjecucion
			,	dFechaControl	= @dFechaControl
			,	dFechaSistema	= @dFechaSistema
		return
	end
	-->		Control de Indices (Valore de Monedas cargados para el Proximo día)

	if (@dFechaSistema <> @dFechaControl)
	begin
		rollback transaction
		select  Estado = 'False', Mensaje = 'Err.', Descripcion = 'Fechas no coinciden.', Hora = @cHoraEjecucion
			,	dFechaControl = @dFechaControl
			,	dFechaSistema = @dFechaSistema
		return
	end

	if (@swInicioDia = 1)
	begin
		rollback transaction
		select	Estado = 'False', Mensaje = 'Err.', Descripcion = 'Inicio de Día Ya Realizado', Hora = @cHoraEjecucion
			,	dFechaControl = @dFechaControl
			,	dFechaSistema = @dFechaSistema
		return
	end

	if (@swFinDia = 0)
	begin
		rollback transaction
		select	Estado = 'False', Mensaje = 'Err.', Descripcion = 'Fin de Día No Realizado', Hora = @cHoraEjecucion
			,	dFechaControl = @dFechaControl
			,	dFechaSistema = @dFechaSistema
		return
	end

	if (@dFechaSistema = @dFechaControl) and (@swInicioDia = 0 and @swFinDia = 1)
	begin
		--> Si @Pruebas_Si_No, está en Uno  = "Pruebas Si", No Ejecuta los Procesos
		-->	Si @Pruebas_Si_No. esta en Cero = "Pruebas No", Si Ejecuta los Procesos
		if @Pruebas_Si_No = 0
		begin
			/*  Borra todos los datos y crea en estado Espera todos los procesos	*/
			Execute BacParamSuda.dbo.SP_MID_Inicializa_Estado_Control_NY
			/*	Mueve el Switch, de manera de dejar en ejecucion el proceso, evitando 
			que entre al ciclo mientras el proceso no hubiese terminado previamente */
			Execute BacParamSuda.dbo.SP_MID_InicioProceso_NY 1
		end

		commit transaction
		select  Estado = 'True', Mensaje = 'Ok',    Descripcion = 'Es posible generar los procesos de apertura.', Hora = @cHoraEjecucion
			,	dFechaControl = @dFechaControl
			,	dFechaSistema = @dFechaSistema
	end else
	begin
		rollback transaction
		select  Estado = 'False', Mensaje = 'Err.', Descripcion = 'Fechas no coinciden.', Hora = @cHoraEjecucion
			,	dFechaControl = @dFechaControl
			,	dFechaSistema = @dFechaSistema
	end

end
GO

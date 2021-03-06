USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_Inicializa_Estado_Control_NY]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MID_Inicializa_Estado_Control_NY]
as
begin

	set nocount on

	Delete 
	From	BacParamSuda.dbo.MID_Control_InicioNY
	
	Insert Into BacParamSuda.dbo.MID_Control_InicioNY
	select	Estado		= 0
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	,		Fecha		= acfecprox
	,		Prioxima	= acfecprox
	from	BacFwdNy.dbo.Mfac	with(nolock)

	Truncate Table BacParamSuda.dbo.MID_Monitor_EventosNY

	-->		Forward
	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Leer Valore de Monedas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Devengameinto'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	
	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 4
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Traspaso de Operaciones'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 5
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Carga de Vencimientos'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 1
	,		IdEvento	= 6
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Vencimiento Ticket'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Forward

	-->		Swap
	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 2
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Valores de Monedas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 2
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 2
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Genera de ICP'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 2
	,		IdEvento	= 4
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Limpia Tabla Simulaciones'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Swap

	-->		Bonex
	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 3
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'BEX'
	,		Evento		= 'Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Bonex

	-->		Opciones
	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 4
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Cambia Fechas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 4
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 4
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Prepara SDA'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Opciones

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 6
	,		IdEvento	= 16
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Calculo de Lineas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_EventosNY
	select	IdModulo	= 6
	,		IdEvento	= 19
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Calculo de Lineas DRV'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'


end

GO

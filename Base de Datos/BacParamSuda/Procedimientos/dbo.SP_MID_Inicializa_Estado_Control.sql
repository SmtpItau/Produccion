USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_Inicializa_Estado_Control]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MID_Inicializa_Estado_Control]
as
begin

	set nocount on

	Delete 
	From	BacParamSuda.dbo.MID_Control_Inicio
	
	Delete 
	From	BacParamSuda.dbo.MDI_Mensajes

	Insert Into BacParamSuda.dbo.MID_Control_Inicio
	select	Estado		= 0
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	,		Fecha		= acfecprox
	,		Prioxima	= acfecprox
	from	BacTraderSuda.dbo.Mdac	with(nolock)

	Truncate Table BacParamSuda.dbo.MID_Monitor_Eventos

	-->		Forward
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 1
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Leer Valore de Monedas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 1
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 1
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Devengameinto'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 1
	,		IdEvento	= 4
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Traspaso de Operaciones'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 1
	,		IdEvento	= 5
	,		IdEstado	= 0
	,		Modulo		= 'BFW'
	,		Evento		= 'Carga de Vencimientos'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'


	insert into BacParamSuda.dbo.MID_Monitor_Eventos
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
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 2
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Valores de Monedas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 2
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 2
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'PCS'
	,		Evento		= 'Genera de ICP'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
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
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
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
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 4
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Cambia Fechas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 4
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 4
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'OPC'
	,		Evento		= 'Prepara SDA'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Opciones

	-->		Spot
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 5
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'BCC'
	,		Evento		= 'Genera Inicio de Día'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 5
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'BCC'
	,		Evento		= 'Libera Lineas Retenidas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 5
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'BCC'
	,		Evento		= 'Traspaso TxOnLine Tarde'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 5
	,		IdEvento	= 4
	,		IdEstado	= 0
	,		Modulo		= 'BCC'
	,		Evento		= 'Captura Vcto Forward'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'
	-->		Spot

	-->		Trader
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 1
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Lee Parametros'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 2
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Graba Valores de Monedas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 3
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Graba Parametros'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 4
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Traspaso Vencimientos'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 5
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Chequea Fecha para Devengamiento'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 6
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Devengo En Dolares (Cartera Inversiones)'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 7
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Devengo En Dolares (Compras c/ pacto)'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 8
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Devengo En Dolares (Ventas c/ pacto)'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 9
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Devengo En Dolares (Interbancarios)'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 10
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Actualiza Cartera'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 11
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Actualiza Cartera Libre Trading'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 12
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Recompras'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 13
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Reventas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 14
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Traspaso Sorteo de Letras'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 15
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Procesos de Cobertura'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 16
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Calculo de Lineas'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 17
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Carga Prestamos IBS'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 18
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Carga Anticipos IBS'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 19
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Calculo de Lineas DRV'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	--- Nuevo para LD1 
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 20
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Nuevo Calculo de Lineas DRV'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	---- Modificado para LD1
	insert into BacParamSuda.dbo.MID_Monitor_Eventos
	select	IdModulo	= 6
	,		IdEvento	= 21
	,		IdEstado	= 0
	,		Modulo		= 'BTR'
	,		Evento		= 'Graba Garantias Faltantes'
	,		Estado		= 'En Espera'
	,		HoraInicio	= '00:00:00'
	,		HoraTermino	= '00:00:00'

	

end

GO

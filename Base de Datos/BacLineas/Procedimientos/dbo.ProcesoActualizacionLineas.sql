USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[ProcesoActualizacionLineas]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[ProcesoActualizacionLineas]
	(	@nRutCliente	NUMERIC(15)	)  
as  
begin  
				/*
	Esta en Revisión de procesos 
	Estado			:	Revisión Finaliza	|	Cambios para New York
	PRD				:						|	21033
	Mensaje			:	NO MODIFICAR		|	Modificado
	Fecha			:	30-01-2014			|	14-10-2014
	Desarrollador	:	Adrián González		|	Adrian Gonzalez / Manuel Correa
	Anexo			:	6265				|	
	Entrega			:	Finalizada			|	Finalizada
				*/

	SET NOCOUNT OFF


 
	declare @Id					INT  
	declare @dFecPro			DATETIME  
	declare @nRutcli			NUMERIC(09,0)  
	declare @nCodigo			NUMERIC(09,0)  
	declare @dFecvctop			DATETIME  
	declare @nMonto				NUMERIC(19,4)  
	declare @cTipo_Riesgo		CHAR(1)  
	declare @nInCodigo			NUMERIC(05)  
	declare @nMonedaOp			NUMERIC(05,0)  
	declare @FormaPago			NUMERIC(03,0)  
	declare @MetodoLCR			NUMERIC(5)  
	declare @Id_Sistema			CHAR(3)  
	declare @Codigo_Producto	CHAR(5)  
	declare @nNumoper			NUMERIC(10)  
	declare @NumeroCorrelativo	NUMERIC(10,0)  
	declare @fTipcambio         NUMERIC(19,4)  
	declare @cUsuario           CHAR(15)  
	declare @nContraMoneda		NUMERIC(03)  
	declare @nMonedaOpera		NUMERIC(03)  
	declare @SW					INT;			SET @SW = 0  
	declare @Resultado          FLOAT  
	declare @Garantia           FLOAT  
	declare @Avr				NUMERIC(21,4)  
	declare @nPlazoResidual		NUMERIC(21,4)  
	declare @nMontoOriginal		NUMERIC(19,4)  
	declare @cCatipoper			CHAR(1)  
	declare @iRutPaso			NUMERIC(09,0);	SET @iRutPaso = 0  

	declare	@iStatus			int  
		set @iStatus			= isnull( (Select SwStatus from StatusLinea with(nolock)), 1)  


	-- MNAVARRO 20180823
	-- Cerrar todas las mesas para 
	-- trasmitir que la imputación 
	-- no es online.
    update bacfwdsuda.dbo.mfac          set acsw_ciemefwd = 1
	update bacSwapSuda.dbo.swapgeneral  set CierreMesa = 1
	update BacSwapNY.dbo.swapgeneral    set CierreMesa = 1 

	-- OPCIONES está cerrado y nos evitamos problemas de acceso
	--  Se usará switch de Forward
	--  update lnkopc.Cbmdbopc.dbo.OpcionesGeneral set cierreMesa = 1 
	--	update Cbmdbopc.dbo.OpcionesGeneral set cierreMesa = 1 
	
	update BacBonosExtNY.dbo.text_arc_ctl_dri set  acsw_mesa = 1 
	update BacBonosExtSuda.dbo.text_arc_ctl_dri set  acsw_mesa = 1  
	update BacTraderSuda.dbo.MDAC  set  acsw_mesa = 1
	UPDATE BacCamsuda.dbo.meac SET aclogdig = SUBSTRING(aclogdig,1,5)+'1'+SUBSTRING(aclogdig,7,4) 



  
	--> 1.0 Si el Sw de Estado, SwStatus esta en 1, Indica que las lineas finalizaron  
	if @iStatus = 1  
	begin  
		-->  ***********************************************************************  
		-->  INICIALIZA LOS REGISTROS DE TODAS LAS TABLAS INVOLUCRADAS EN EL PROCESO  
		-->  *********************************************************************** 
		
		--+++Jcamposd 20180730 recalculo de líneas solicitud camilo pino, hoy baclineas no ocupa estructura sonda
		/* 
		update	baclineas.dbo.linea_general 
			set	moneda	= 999
		where	moneda	= ''
		update	baclineas.dbo.linea_general 
			set	moneda	= 999
		where	moneda	= 0

		update	baclineas.dbo.linea_sistema
			set	moneda	= 999
		where	moneda	= ''
		update	baclineas.dbo.linea_sistema
			set	moneda	= 999
		where	moneda	= 0

		-->  Limpia los montos Ocupados y Excedidos   
		update	BacLineas.dbo.Linea_General  
		set		TotalOcupado	= 0  
		,		TotalExceso		= 0  
		,		TotalDisponible = TotalAsignado  

		-->  Limpia los montos Ocupados y Excedidos   
		update	BacLineas.dbo.Linea_Sistema  
		set		TotalOcupado	= 0  
		,		TotalExceso		= 0  
		,		TotalDisponible = TotalAsignado  

		-->  Limpia los montos Ocupados y Excedidos   
		update	BacLineas.dbo.Linea_Producto_por_Plazo  
		set		TotalOcupado	= 0  
		,		TotalExceso		= 0  
		,		TotalDisponible = TotalAsignado  

		*/
		-----Jcamposd 20180730 recalculo de líneas solicitud camilo pino
		
		set nocount on

		-- PENDIENTE Ver en que otro lado se hace esto
		-- para sacarlo
		UPDATE BacLineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO   
          SET Acumulado_Diario = 0  

			-->  Linea Transaccion  
		delete BacLineas.dbo.Linea_Transaccion  

		-->  Linea Transaccion  
		delete BacLineas.dbo.Linea_Transaccion_Detalle  

		-->  Limpia la Tabla de Lineas Chequear  
		delete BacLineas.dbo.Linea_Chequear  

		-->  Borra la tabla de Registros  
		delete dbo.StatusLinea  

		-->  Borra los registros de lineas por cliente  
		delete dbo.StatusLineaCliente  

		-->  REGISTRO DE INICIALIZACION DE PROCESO  
		delete dbo.StatusLinea

		insert into dbo.StatusLinea  
		select	0 --> Inicializa con Status 0  
		,		getdate()  
		,		getdate()  

		-->  REGISTRO DE CONTROL DE EJECUCION POR MODULO  
		--> Inicializa con Status -1  
		delete dbo.StatusLineaModulo  

		insert into dbo.StatusLineaModulo   
		select  Btr	=-1  
		,		Bex	=-1  
		,		Bcc	=-1  
		,		Bfw	=-1  
		,		Opt	=-1  
		,		Pcs	=-1  

	end  


	-->   Modificaciones por PRD-21033
	-->   Extraigo la fecha de proceso de la base de forward local
	declare @dFechaChile	datetime
		set @dFechaChile	= ( select  acfecproc from BacFwdSuda.dbo.mfac with(nolock) )

	--> Extraigo la fecha de proceso de la base de forward New York
	declare @dFechaNy		datetime
		set @dFechaNy		= ( select  acfecproc from BacFwdNy.dbo.mfac with(nolock) )

	-->   Se modifica para determinar la fecha, a la que debe correr el proceso, contemplando chile y new york
	declare @dFecha			datetime  
--	set		@dFecha			= ( select  acfecproc from BacFwdSuda.dbo.mfac with(nolock) )  
	set		@dFecha			= case	when @dFechaChile = @dFechaNy then @dFechaChile
									when @dFechaChile > @dFechaNy then @dFechaChile
									when @dFechaChile < @dFechaNy then @dFechaNy
								end	
	-->   Se modifica para determinar la fecha, a la que debe correr el proceso, contemplando chile y new york
	-->   Modificaciones por PRD-21033

	declare @dDolarHoy	Float  
	set		@dDolarHoy	= (	select	vmvalor from BacParamSuda.dbo.Valor_Moneda with(nolock) 
							where	vmfecha = @dFecha and vmcodigo = 994	)  


	-->  Crea una estructura para almacenar los registros a imputar  
	------if exists( select 1 from sys.sysobjects where name = 'tmp_Linea_Chequear_Cont' and type = 'U' )  
	------begin  
	------	drop table tmp_Linea_Chequear_Cont  
	------end  
  
	------select * into dbo.tmp_Linea_Chequear_Cont from BacLineas.dbo.Linea_Chequear with(nolock) where 1 = 2  
	
	------create clustered index ix_tmp_Modulo_Rut_cont on tmp_Linea_Chequear_Cont
	------												(Id_Sistema, Rut_Cliente, NumeroOperacion, NumeroCorrelativo)  

	delete tmp_Linea_Chequear_Cont
	-->  ------------------------------------------------------------  

  
	set @iStatus = ( Select SwStatus from StatusLinea with(nolock) )  
  
	--> Inicia el proceso de Recalculo   
	if @iStatus  = 0 --> Estado Inicializado (0), pero NO Finalizado (1)  
	begin  

		--> Deshabilitamos Renta Fija
		-->  RENTA FIJA  
		if  ( select Btr from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Btr No Iniciado Previamente   ( -1 )   
		or	( select Btr from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Btr Iniciado, pero no Finalizado (  0 )  
		begin  
			update dbo.StatusLineaModulo set Btr = 0         --> Inicio Proceso Btr  

			Execute BacTraderSuda.dbo.SP_LINEAS_ACTUALIZARMONTOS_OTRO @dFecha, 'BTR'  --> Ejecuta El Proceso   

			update dbo.StatusLineaModulo set Btr = 1         --> Finalizo Proceso Btr  
		end  
		-->  ------------------------------------------------------------  
		--> Habilitamos Renta Fija


		--> Deshabilitamos Bonex
		-->  BONEX  
		if  ( select Bex from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Btr No Iniciado Previamente   ( -1 )   
		or	( select Bex from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Btr Iniciado, pero no Finalizado (  0 )  
		begin  
			update dbo.StatusLineaModulo set Bex = 0         --> Inicio Proceso Btr  
  
			Execute BacBonosExtSuda.dbo.SP_RECALC_LINEAS_INV --> Ejecuta El Proceso
			-->   Modificaciones por PRD-21033
			Execute BacBonosExtNY.dbo.SP_RECALC_LINEAS_INV   --> Ejecuta El Proceso pata la Bonos NY
			-->   Modificaciones por PRD-21033
  
			update dbo.StatusLineaModulo set Bex = 1         --> Finalizo Proceso Btr  
		end  
		-->  ------------------------------------------------------------  
		--> Habilitamos Bonex

		--> Deshabilitamos Opciones
		-->  OPCIONES   
		if  ( select Opt from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Btr No Iniciado Previamente   ( -1 )   
		or	( select Opt from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Btr Iniciado, pero no Finalizado (  0 )  
		begin  
			update dbo.StatusLineaModulo set Opt = 0         --> Inicio Proceso Btr  
  
			Execute Lnkopc.CbmdbOpc.dbo.SP_RECALCULO_LINEAS_OPCIONES_OTRO 'OPT', 0

			/*
						-->  Linea Transaccion  
						delete BacLineas.dbo.Linea_Transaccion  
						-->  Linea Transaccion  
						delete BacLineas.dbo.Linea_Transaccion_Detalle  

						select count(1) from BacLineas.dbo.Linea_Transaccion  where id_sistema = 'OPT'
			*/

  
			update dbo.StatusLineaModulo set Opt = 1         --> Finalizo Proceso Btr  
		end  
		-->  ------------------------------------------------------------  
		--> Habilitamos Opciones

		-- Se deja la configuracion de Mesas del inicio de día
		-- despues de hacer el recálco
		update bacfwdsuda.dbo.mfac                  set acsw_ciemefwd = 0
		update bacSwapSuda.dbo.swapgeneral          set CierreMesa    = 0   
		update BacSwapNY.dbo.swapgeneral            set CierreMesa    = 1  
		-- Se usará el switch de Forward
		-- update lnkOpc.Cbmdbopc.dbo.OpcionesGeneral  set cierreMesa    = 1 
		update BacBonosExtNY.dbo.text_arc_ctl_dri   set acsw_mesa     = 1 
		update BacBonosExtSuda.dbo.text_arc_ctl_dri set acsw_mesa     = 0  
		update BacTraderSuda.dbo.MDAC               set acsw_mesa     = 1
		UPDATE BacCamsuda.dbo.meac                  SET aclogdig = SUBSTRING(aclogdig,1,5)+'1'+SUBSTRING(aclogdig,7,4) -- Cierre Mesa

		--> Deshabilitamos Spot  
		-->  SPOT  
		
		--+++jcamposd 20180730 no considerar otros productos solo RF y OPT
		/*
		if  ( select Bcc from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Bcc No iniciado Previamente   ( -1 )  
		or	( select Bcc from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Bcc Iniciado, pero no finalizado (  0 )  
		begin  
			
			delete	BacLineas.dbo.LINEAS_RETENIDAS
			where	fecha_pago			<  (select acfecante from BacTraderSuda.dbo.mdac with(nolock) )
			and		id_sistema			= 'BCC'
			and		estado_liberacion	= 'N'

			truncate table tmp_Linea_Chequear_Cont
  
			INSERT INTO dbo.tmp_Linea_Chequear_Cont
			( /*01*/ FechaOperacion  
			, /*01*/ NumeroOperacion  
			, /*01*/ Numerodocumento  
			, /*01*/ NumeroCorrelativo  
			, /*01*/ Rut_Cliente  
			, /*01*/ Codigo_Cliente  
			, /*01*/ Id_Sistema  
			, /*01*/ Codigo_Producto  
			, /*01*/ MontoTransaccion  
			, /*01*/ TipoCambio  
			, /*01*/ FechaVencimiento  
			, /*01*/ Operador  
			, /*01*/ Rut_Emisor  
			, /*01*/ Moneda_Emision  
			, /*01*/ FechaVctoInst  
			, /*01*/ InCodigo  
			, /*01*/ Seriado  
			, /*01*/ MonedaOperacion  
			, /*01*/ Tipo_Riesgo  
			, /*01*/ codigo_pais  
			, /*01*/ Pago_Cheque  
			, /*01*/ Rut_Cheque  
			, /*01*/ FechaVctoCheque  
			, /*01*/ FactorVenta  
			, /*01*/ FormaPago  
			, /*01*/ Tir  
			, /*01*/ TasaPacto  
			, /*01*/ Instser  
			, /*01*/ Avr  
			, /*01*/ PrcLCR  
			, /*01*/ Resultado  
			, /*01*/ MetodoLCR  
			, /*01*/ Garantia  
			, /*01*/ Cod_Emisor  
			)  
			SELECT  
					/*01*/ FechaOperacion		= @dFecha    
			,		/*04*/ NumeroOperacion		= Spot.monumope  
			,		/*05*/ Numerodocumento		= Spot.monumope  
			,		/*06*/ NumeroCorrelativo	= 0  
			,		/*07*/ Rut_Cliente			= Spot.morutcli  
			,		/*08*/ Codigo_Cliente		= Spot.mocodcli  
			,		/*02*/ Id_Sistema			= 'BCC'  
			,		/*03*/ Codigo_Producto		= Spot.motipmer  
			,		/*09*/ MontoTransaccion		= Spot.moussme  
			,		/*10*/ TipoCambio			= 0.0  
			,		/*11*/ FechaVencimiento		= Spot.movaluta2  
			,		/*12*/ Operador				= Spot.mooper  
			,		/*13*/ Rut_Emisor			= 0
			,		/*14*/ Moneda_Emision		= 0
			,		/*15*/ FechaVctoInst		= @dFecha
			,		/*16*/ InCodigo				= 0
			,		/*17*/ Seriado				= 'N'
			,		/*18*/ MonedaOperacion		= 0  
			,		/*19*/ Tipo_Riesgo			= 'C'  
			,		/*20*/ codigo_pais			= 0  
			,		/*21*/ Pago_Cheque			= Spot.MercadoLc  
			,		/*22*/ Rut_Cheque			= 0  
			,		/*23*/ FechaVctoCheque		= @dFecha  
			,		/*24*/ FactorVenta			= 0  
			,		/*25*/ FormaPago			= 0  
			,		/*26*/ Tir					= 0  
			,		/*27*/ TasaPacto			= 0  
			,		/*28*/ Instser				= ''  
			,		/*29*/ Avr					= 0.0  
			,		/*30*/ PrcLCR				= 0.0  
			,		/*31*/ Resultado			= 0.0  
			,		/*32*/ MetodoLCR			= 1 --> 0.0  
			,		/*33*/ Garantia				= 0.0  
			,		/*34*/ Cod_Emisor			= 0  
			from	(	select	motipmer	= motipmer  
						,		monumope	= monumope    
						,		morutcli	= morutcli    
						,		mocodcli	= mocodcli    
						,		moussme		= moussme  
						,		movaluta2	= movaluta2  
						,		MercadoLc	= CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END    
						,		Moneda		= 0  
						,		mooper		= mooper  
						from	BacCamSuda.dbo.Memo	with(nolock)
								inner join BacParamSuda.dbo.cliente with(nolock) on clrut = morutcli and clcodigo = mocodcli  
						where	moestatus  <> 'A'  
						and		motipope = 'C'  
						and not ( motipmer = 'ccbb' and morutcli = 97023000 )  
							union  
						select	motipmer	= motipmer  
						,		monumope	= monumope    
						,		morutcli	= morutcli    
						,		mocodcli	= mocodcli    
						,		moussme		= moussme  
						,		movaluta2	= movaluta2  
						,		MercadoLc	= CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END    
						,		Moneda		= 0  
						,		mooper		= mooper  
						from	BacCamSuda.dbo.Memo  with(nolock)
								inner join BacParamSuda.dbo.cliente with(nolock) on clrut = morutcli and clcodigo = mocodcli  
						where	moestatus  <> 'A'  
						and		motipope	= 'V'  
						and not ( motipmer	= 'ccbb' and morutcli = 97023000  )  
						and		( movaluta2 <> movaluta1 and movaluta2 > movaluta1 )  
					) Spot  

			-->  Traspaso para el Control de Imputacion por Cliente, siempre y cuando no se ubiese cargado previamente  
			if ( select count(1) from dbo.StatusLineaCliente ) =  0 --> Control de Datos sobre la Tabla Clientes  
			or ( select Bcc		 from dbo.StatusLineaModulo  ) = -1 --> Control de Inicio de Proceso Spot ( -1)  
			begin
				update  dbo.StatusLineaModulo set Bcc = 0 --> Inicio el proceso de Spot  

				-->  Cargo la lista de clientes que se van a recalcular  
				truncate table dbo.StatusLineaCliente  
	  
				insert  into dbo.StatusLineaCliente   
				select	distinct   
						Rut		= Rut_Cliente  
					,	Status	= 0  
				from	dbo.tmp_Linea_Chequear_Cont  
			end else  
			begin
				if ( select Bcc from dbo.StatusLineaModulo	) = 0 --> Proceso Iniciado, pero no Finalizado ( 0 )  
				begin  
					-->  Elimina los Clientes ya recalculados para no colver a leerlos.  
					delete	tmp_Linea_Chequear_Cont  
					from	StatusLineaCliente  
					where	StatusLineaCliente.Rut		= Rut_Cliente  
					and		StatusLineaCliente.Status	= 1  
				end  
			end  

			DECLARE	LineasChequearBcc	CURSOR FOR   
	     
			SELECT  FechaOperacion		= FechaOperacion  
				,	Rut_Cliente			= Rut_Cliente  
				,	Codigo_Cliente		= Codigo_Cliente  
				,	FechaVencimiento	= FechaVencimiento  
				,	MontoTransaccion	= SUM(MontoTransaccion)  
				,	Tipo_Riesgo			= Tipo_Riesgo  
				,	InCodigo			= InCodigo     --> = 0  
				,	MonedaOperacion		= MonedaOperacion  
				,	FormaPago			= FormaPago     --> = 0  
				,	MetodoLCR			= MetodoLCR  
				,	Id_Sistema			= Id_Sistema  
				,	Codigo_Producto		= Codigo_Producto  
				,	Avr					= SUM( Avr )  
				-------------------------------------------  
				,	NumeroOperacion		= ( NumeroOperacion   )  
				,	NumeroCorrelativo	= ( NumeroCorrelativo )  
				,	TipoCambio			= TipoCambio  
				,	Operador			= Operador     --> = ''  
				,	ContraMoneda		= Moneda_Emision  
				,	MonedaOpera			= Cod_Emisor  
				-------------------------------------------  
				,	Resultado			= Resultado  
				,	Garantia			= Garantia  
				,	TasaPacto			= TasaPacto  
				,	PrcLCR				= PrcLCR  
				,	Pago_Cheque			= Pago_Cheque  
			FROM	dbo.tmp_Linea_Chequear_Cont  
			GROUP 
			BY		FechaOperacion	
				,	Id_Sistema  
				,	Rut_Cliente  
				,	Codigo_Cliente  
				,	FechaVencimiento  
				,	Tipo_Riesgo  
				,	InCodigo  
				,	MonedaOperacion  
				,	FormaPago  
				,	MetodoLCR  
				,	Codigo_Producto  
				-------------------------------------------  
				,	NumeroOperacion  
				,	NumeroCorrelativo  
				,	TipoCambio  
				,	Operador  
				,	Moneda_Emision  
				,	Cod_Emisor  
				-------------------------------------------  
				,	Resultado  
				,	Garantia  
				,	TasaPacto  
				,	PrcLCR  
				,	Pago_Cheque  
			order 
			by		Rut_Cliente  
				,	Codigo_Cliente  
				,	Id_Sistema  
				,	NumeroOperacion  
				,	NumeroCorrelativo  

			OPEN	LineasChequearBcc   

			FETCH NEXT FROM LineasChequearBcc  
			INTO	@dFecPro  
				,	@nRutcli  
				,	@nCodigo  
				,	@dFecvctop  
				,	@nMonto  
				,	@cTipo_Riesgo  
				,	@nInCodigo  
				,	@nMonedaOp  
				,	@FormaPago  
				,	@MetodoLCR  
				,	@Id_Sistema  
				,	@Codigo_Producto  
				,	@Avr  
			-------------------------------------------  
				,	@nNumoper  
				,	@NumeroCorrelativo  
				,	@fTipcambio  
				,	@cUsuario  
				,	@nContraMoneda  
				,	@nMonedaOpera  
				-------------------------------------------  
				,	@Resultado  
				,	@Garantia  
				,	@nPlazoResidual  
				,	@nMontoOriginal  
				,	@cCatipoper  

			if @Id_Sistema = 'BCC'  
			begin  
				set @iRutPaso = @nRutcli  
			end  

			WHILE @@FETCH_STATUS = 0  
			BEGIN  

				Execute BacLineas.dbo.SVC_IMPUTACION_LINEAS		@dFecPro			--> OK      
															,	@Id_Sistema			--> OK  
															,	@Codigo_Producto	--> OK  
															,	@nRutcli			--> OK  
															,	@nCodigo			--> OK  
															,	@nNumoper			--> OK  
															,	@nNumoper			--> OK @nNumPantalla  
															,	@NumeroCorrelativo	--> OK  
															,	@dFecPro			--> OK  
															,	@nMonto				--> OK  
															,	@fTipcambio			--> OK  
															,	@dFecvctop			--> OK  
															,	@cUsuario			--> OK  
															,	@nMonedaOp			--> OK  
															,	@cTipo_Riesgo		--> OK  
															,	@nInCodigo			--> OK  
															,	@FormaPago			--> OK  
															,	@nContraMoneda		--> OK  
															,	@nMonedaOpera		--> OK  
														--	,	@SwithEjecucion  
															,	@SW					--> OK  
															,	@Resultado			--> OK  
															,	@MetodoLCR			--> OK  
															,	@Garantia			--> OK  
															,	@Avr				-->   
				-->  Marco loas cliente que ya recalcularon  
				update	dbo.StatusLineaCliente  
				set		Status		= 1  
				where	(	Rut		= @nRutcli   
				or			Rut		= @iRutPaso  
						)
	  
				IF @iRutPaso <> @nRutcli and @Id_Sistema = 'BCC'  
				BEGIN
					EXECUTE BacLineas.dbo.SP_RETIENE_LINEAS_SPOT @iRutPaso  
					SET @iRutPaso = @nRutcli  
				END

				FETCH NEXT FROM LineasChequearBcc
				INTO	@dFecPro  
				,		@nRutcli  
				,		@nCodigo  
				,		@dFecvctop  
				,		@nMonto  
				,		@cTipo_Riesgo  
				,		@nInCodigo  
				,		@nMonedaOp  
				,		@FormaPago  
				,		@MetodoLCR  
				,		@Id_Sistema  
				,		@Codigo_Producto  
				,		@Avr  
				-------------------------------------------  
				,		@nNumoper  
				,		@NumeroCorrelativo  
				,		@fTipcambio  
				,		@cUsuario  
				,		@nContraMoneda  
				,		@nMonedaOpera  
				-------------------------------------------  
				,		@Resultado  
				,		@Garantia  
				,		@nPlazoResidual  
				,		@nMontoOriginal  
				,		@cCatipoper  
			END  --> Cursor para Imputar Spot  

			CLOSE LineasChequearBcc  
			DEALLOCATE LineasChequearBcc  

			update  dbo.StatusLineaModulo set Bcc = 1 --> Finaliza proceso Bcc  
		END
		--> Spot
		--> Habilitamos Spot
  
		-----jcamposd 20180730 no considerar otros productos solo RF y OPT
		*/
  
		--+++jcamposd 20180730 no considerar otros productos solo RF y OPT
		/*
		-->	Deshabilitamos Forward
		-->  FORWARD  
		if  ( select Bfw from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Bcc No iniciado Previamente   ( -1 )  
		or	( select Bfw from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Bcc Iniciado, pero no finalizado (  0 )  
		begin  
  
			truncate table tmp_Linea_Chequear_Cont  

			INSERT INTO dbo.tmp_Linea_Chequear_Cont  
			(	FechaOperacion  
			,	NumeroOperacion  
			,	Numerodocumento  
			,	NumeroCorrelativo  
			,	Rut_Cliente  
			,	Codigo_Cliente  
			,	Id_Sistema  
			,	Codigo_Producto  
			,	MontoTransaccion  
			,	TipoCambio  
			,	FechaVencimiento  
			,	Operador  
			,	Rut_Emisor  
			,	Moneda_Emision  
			,	FechaVctoInst  
			,	InCodigo  
			,	Seriado  
			,	MonedaOperacion  
			,	Tipo_Riesgo  
			,	codigo_pais  
			,	Pago_Cheque  
			,	Rut_Cheque  
			,	FechaVctoCheque  
			,	FactorVenta  
			,	FormaPago  
			,	Tir  
			,	TasaPacto  
			,	Instser  
			,	Avr  
			,	PrcLCR  
			,	Resultado  
			,	MetodoLCR  
			,	Garantia  
			,	Cod_Emisor  
			)  

			SELECT  /*01*/ FechaOperacion		= @dFecha    
			,		/*04*/ NumeroOperacion		= car.canumoper  
			,		/*05*/ Numerodocumento		= car.canumoper		--> Case when @nNumdocu = 0 then @nNumoper else @nNumdocu end  
			,		/*06*/ NumeroCorrelativo	= 0					--> @nCorrela  
			,		/*07*/ Rut_Cliente			= car.cacodigo		--> @nRutcli  
			,		/*08*/ Codigo_Cliente		= car.cacodcli		--> @nCodigo  
			,		/*02*/ Id_Sistema			= 'BFW'				--> case when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) NOT IN(1,4) THEN grprod.id_Grupo ELSE grprod.Id_Sistema END  
			,		/*03*/ Codigo_Producto		= car.cacodpos1		--> @cProducto  
			,		/*09*/ MontoTransaccion		= case	when car.cacodpos1 = 2	then ((	car.camtomon1 * tcambio) / @dDolarHoy)  
														when car.cacodpos1 = 3	then ((	car.camtomon1 * tcambio) / @dDolarHoy)  
														when car.cacodpos1 = 10 then	car.caequusd2  
														else							car.camtomon1  
													end				--> @nMonto  
			,		/*10*/ TipoCambio			= 0.0				--> @fTipcambio  
			,		/*11*/ FechaVencimiento		= car.cafecvcto		--> @dFecvctop  
			,		/*12*/ Operador				= ''				--> @cUsuario  
			,		/*13*/ Rut_Emisor			= 0					--> @nRut_emisor  
			,		/*14*/ Moneda_Emision		= case  when Contra_Moneda  = 'S' and cacodpos1  = 2 then cacodmon1   
														when Contra_Moneda  = 'S' and cacodpos1 <> 2 then cacodmon2   
														when Contra_Moneda <> 'S'      then 0  
														else 0  
													end  
			,		/*15*/ FechaVctoInst		= @dFecha			--> @dFecvctoInst  
			,		/*16*/ InCodigo				= 0					--> @nInCodigo  
			,		/*17*/ Seriado				=	'N'				--> @cSeriado    
			,		/*18*/ MonedaOperacion		= car.cacodmon1		--> @nMonedaOp  
			,		/*19*/ Tipo_Riesgo			= 'C'				--> @cTipo_Riesgo  
			,		/*20*/ codigo_pais			= 0					--> @nCodigo_pais  
			,		/*21*/ Pago_Cheque			= car.catipoper     --> 'N'    --> @cPagoCheque  
			,		/*22*/ Rut_Cheque			= 0					--> @nRutCheque  
			,		/*23*/ FechaVctoCheque		= @dFecha			--> @dFecvctoCehque  
			,		/*24*/ FactorVenta			= 0					--> @nFactorVenta  
			,		/*25*/ FormaPago			= 0					--> @formapago  
			,		/*26*/ Tir					= 0					--> @nTir  
			,		/*27*/ TasaPacto			= DATEDIFF(DAY, @dFecha, cafecvcto)     --> @nTasaPact  
			,		/*28*/ Instser				= 0					--> @cInstser  
			,		/*29*/ Avr					= case when round(car.fres_obtenido, 0.0) > 0 then round(car.fres_obtenido, 0.0) else 0.0 end --> @Avr  
			,		/*30*/ PrcLCR				= car.camtomon1		--> @PrcLCR  
			,		/*31*/ Resultado			= 0					--> @Resultado  
			,		/*32*/ MetodoLCR			= BacLineas.dbo.FN_RIEFIN_METODO_LCR     ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
			,		/*33*/ Garantia				= case	when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
														when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
														else 0  
													end    --> @Garantia  
			,		/*34*/ Cod_Emisor			= case	when car.cacodpos1 = 2 then car.cacodmon2 
														else car.cacodmon1 
													end  
			from	BacFwdSuda.dbo.Mfca car  with(nolock)
					inner	join (	select	clrut, clcodigo, clnombre, clpais   
									from	BacParamSuda.dbo.cliente with(nolock)
								)	Clie	On Clie.clrut = car.cacodigo and Clie.clcodigo = car.cacodcli  
								
					left	join (	select	codigo = mncodmon, tcambio = case when mncodmon = 13 then @dDolarHoy else isnull(vmvalor, 1.0) end , tipo = mnrrda  
									from	BacParamSuda.dbo.Moneda					with(nolock)
											left join BacParamSuda.dbo.Valor_Moneda with(nolock) on vmfecha = @dFecha and vmcodigo = mncodmon  
								)	vmon	On vmon.codigo = car.cacodmon1  
								
					left	join	BacLineas.dbo.tbl_agrprod grprod			with(nolock) on grprod.Id_Sistema = 'BFW'  
					left	join (	select	clrut_padre, clcodigo_padre, clnom_Padre = clnombre, clrut_hijo, clcodigo_hijo   
									from	BacLineas.dbo.cliente_relacionado	with(nolock)
											inner join BacParamSuda.dbo.cliente with(nolock) on	clrut		= clrut_Padre 
																							and clcodigo	= clcodigo_Padre  
								)	clrel	on	clrel.clrut_hijo	= Clie.clrut 
											and clrel.clcodigo_hijo = Clie.clcodigo  
					left	join	BacParamSuda.dbo.Producto prod	with(nolock)	on	prod.id_sistema			= 'BFW' 
																					and prod.Codigo_producto	= car.cacodpos1  

			where	car.cafecvcto	> @dFecha  
			and (	car.cacodigo	= @nRutCliente or @nRutCliente = 0 )  
			and		car.cacodpos1	IN(1,2,3,7,10,12,11,14)  

			-->	Modificaciones por PRD-21033
				union all	--> Se agrega para agregar la base de New York para el modulos

			SELECT  /*01*/ FechaOperacion		= @dFecha    
			,		/*04*/ NumeroOperacion		= car.canumoper  
			,		/*05*/ Numerodocumento		= car.canumoper		--> Case when @nNumdocu = 0 then @nNumoper else @nNumdocu end  
			,		/*06*/ NumeroCorrelativo	= 0					--> @nCorrela  
			,		/*07*/ Rut_Cliente			= car.cacodigo		--> @nRutcli  
			,		/*08*/ Codigo_Cliente		= car.cacodcli		--> @nCodigo  
			,		/*02*/ Id_Sistema			= 'BFW'				--> case when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) NOT IN(1,4) THEN grprod.id_Grupo ELSE grprod.Id_Sistema END  
			,		/*03*/ Codigo_Producto		= car.cacodpos1		--> @cProducto  
			,		/*09*/ MontoTransaccion		= case	when car.cacodpos1 = 2	then ((	car.camtomon1 * tcambio) / @dDolarHoy)  
														when car.cacodpos1 = 3	then ((	car.camtomon1 * tcambio) / @dDolarHoy)  
														when car.cacodpos1 = 10 then	car.caequusd2  
														else							car.camtomon1  
													end				--> @nMonto  
			,		/*10*/ TipoCambio			= 0.0				--> @fTipcambio  
			,		/*11*/ FechaVencimiento		= car.cafecvcto		--> @dFecvctop  
			,		/*12*/ Operador				= ''				--> @cUsuario  
			,		/*13*/ Rut_Emisor			= 0					--> @nRut_emisor  
			,		/*14*/ Moneda_Emision		= case  when Contra_Moneda  = 'S' and cacodpos1  = 2 then cacodmon1   
														when Contra_Moneda  = 'S' and cacodpos1 <> 2 then cacodmon2   
														when Contra_Moneda <> 'S'      then 0  
														else 0  
													end  
			,		/*15*/ FechaVctoInst		= @dFecha			--> @dFecvctoInst  
			,		/*16*/ InCodigo				= 0					--> @nInCodigo  
			,		/*17*/ Seriado				=	'N'				--> @cSeriado    
			,		/*18*/ MonedaOperacion		= car.cacodmon1		--> @nMonedaOp  
			,		/*19*/ Tipo_Riesgo			= 'C'				--> @cTipo_Riesgo  
			,		/*20*/ codigo_pais			= 0					--> @nCodigo_pais  
			,		/*21*/ Pago_Cheque			= car.catipoper     --> 'N'    --> @cPagoCheque  
			,		/*22*/ Rut_Cheque			= 0					--> @nRutCheque  
			,		/*23*/ FechaVctoCheque		= @dFecha			--> @dFecvctoCehque  
			,		/*24*/ FactorVenta			= 0					--> @nFactorVenta  
			,		/*25*/ FormaPago			= 0					--> @formapago  
			,		/*26*/ Tir					= 0					--> @nTir  
			,		/*27*/ TasaPacto			= DATEDIFF(DAY, @dFecha, cafecvcto)     --> @nTasaPact  
			,		/*28*/ Instser				= 0					--> @cInstser  
			,		/*29*/ Avr					= case when round(car.fres_obtenido, 0.0) > 0 then round(car.fres_obtenido, 0.0) else 0.0 end --> @Avr  
			,		/*30*/ PrcLCR				= car.camtomon1		--> @PrcLCR  
			,		/*31*/ Resultado			= 0					--> @Resultado  
			,		/*32*/ MetodoLCR			= BacLineas.dbo.FN_RIEFIN_METODO_LCR     ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
			,		/*33*/ Garantia				= case	when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
														when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  BacLineas.dbo.FN_RIEFIN_GARANTIA   ( Clie.clrut, Clie.clcodigo, 4, 'BFW', car.canumoper )  
														else 0  
													end    --> @Garantia  
			,		/*34*/ Cod_Emisor			= case	when car.cacodpos1 = 2 then car.cacodmon2 
														else car.cacodmon1 
													end  
			from	BacFwdNy.dbo.Mfca car  with(nolock)
					inner	join (	select	clrut, clcodigo, clnombre, clpais   
									from	BacParamSuda.dbo.cliente with(nolock)
								)	Clie	On Clie.clrut = car.cacodigo and Clie.clcodigo = car.cacodcli  
								
					left	join (	select	codigo = mncodmon, tcambio = case when mncodmon = 13 then @dDolarHoy else isnull(vmvalor, 1.0) end , tipo = mnrrda  
									from	BacParamSuda.dbo.Moneda					with(nolock)
											left join BacParamSuda.dbo.Valor_Moneda with(nolock) on vmfecha = @dFecha and vmcodigo = mncodmon  
								)	vmon	On vmon.codigo = car.cacodmon1  
								
					left	join	BacLineas.dbo.tbl_agrprod grprod			with(nolock) on grprod.Id_Sistema = 'BFW'  
					left	join (	select	clrut_padre, clcodigo_padre, clnom_Padre = clnombre, clrut_hijo, clcodigo_hijo   
									from	BacLineas.dbo.cliente_relacionado	with(nolock)
											inner join BacParamSuda.dbo.cliente with(nolock) on	clrut		= clrut_Padre 
																							and clcodigo	= clcodigo_Padre  
								)	clrel	on	clrel.clrut_hijo	= Clie.clrut 
											and clrel.clcodigo_hijo = Clie.clcodigo  
					left	join	BacParamSuda.dbo.Producto prod	with(nolock)	on	prod.id_sistema			= 'BFW' 
																					and prod.Codigo_producto	= car.cacodpos1  

			where	car.cafecvcto	> @dFecha  
			and (	car.cacodigo	= @nRutCliente or @nRutCliente = 0 )  
			and		car.cacodpos1	IN(1,2,3,7,10,12,11,14)  
				-->	Modificaciones por PRD-21033

			-->  Traspaso para el Control de Imputacion por Cliente, siempre y cuando no se ubiese cargado previamente  
			if	( select count(1)	from dbo.StatusLineaCliente ) =  0 --> Control de Datos sobre la Tabla Clientes  
			or	( select Bfw		from dbo.StatusLineaModulo  ) = -1 --> Control de Inicio de Proceso Spot ( -1)  
			begin  
				update  dbo.StatusLineaModulo set Bfw = 0 --> Inicio el proceso de Spot  

				-->  Cargo la lista de clientes que se van a recalcular  
				truncate table dbo.StatusLineaCliente  
  
				insert  into dbo.StatusLineaCliente   
				select	distinct   
						Rut  = Rut_Cliente  
					,	Status = 0  
				from	dbo.tmp_Linea_Chequear_Cont  
			end else  
			begin  
				if ( select Bfw   from dbo.StatusLineaModulo  ) = 0 --> Proceso Iniciado, pero no Finalizado ( 0 )  
				begin  
					-->  Elimina los Clientes ya recalculados para no colver a leerlos.  
					delete	tmp_Linea_Chequear_Cont  
					from	StatusLineaCliente  
					where	StatusLineaCliente.Rut  = Rut_Cliente  
					and		StatusLineaCliente.Status = 1  
				end
			end    

			DECLARE LineasChequearBfw	CURSOR FOR   

			SELECT	FechaOperacion		= FechaOperacion  
			,		Rut_Cliente			= Rut_Cliente  
			,		Codigo_Cliente		= Codigo_Cliente  
			,		FechaVencimiento	= FechaVencimiento  
			,		MontoTransaccion	= SUM(MontoTransaccion)  
			,		Tipo_Riesgo			= Tipo_Riesgo  
			,		InCodigo			= InCodigo     --> = 0  
			,		MonedaOperacion		= MonedaOperacion  
			,		FormaPago			= FormaPago     --> = 0  
			,		MetodoLCR			= MetodoLCR  
			,		Id_Sistema			= Id_Sistema  
			,		Codigo_Producto		= Codigo_Producto  
			,		Avr					= SUM( Avr )  
			-------------------------------------------  
			,		NumeroOperacion		= ( NumeroOperacion   )  
			,		NumeroCorrelativo	= ( NumeroCorrelativo )  
			,		TipoCambio			= TipoCambio  
			,		Operador			= Operador     --> = ''  
			,		ContraMoneda		= Moneda_Emision  
			,		MonedaOpera			= Cod_Emisor  
			-------------------------------------------  
			,		Resultado			= Resultado  
			,		Garantia			= Garantia  
			,		TasaPacto			= TasaPacto  
			,		PrcLCR				= PrcLCR  
			,		Pago_Cheque			= Pago_Cheque  
			FROM	dbo.tmp_Linea_Chequear_Cont  
			GROUP 
			BY		FechaOperacion  
			,		Id_Sistema  
			,		Rut_Cliente  
			,		Codigo_Cliente  
			,		FechaVencimiento  
			,		Tipo_Riesgo  
			,		InCodigo  
			,		MonedaOperacion  
			,		FormaPago  
			,		MetodoLCR  
			,		Codigo_Producto  
			-------------------------------------------  
			,		NumeroOperacion  
			,		NumeroCorrelativo  
			,		TipoCambio  
			,		Operador  
			,		Moneda_Emision  
			,		Cod_Emisor  
			-------------------------------------------  
			,		Resultado  
			,		Garantia  
			,		TasaPacto  
			,		PrcLCR  
			,		Pago_Cheque  
			order 
			by		Rut_Cliente  
			,		Codigo_Cliente  
			,		Id_Sistema  
			,		NumeroOperacion  
			,		NumeroCorrelativo  

			OPEN  LineasChequearBfw  
  
			FETCH NEXT FROM LineasChequearBfw  
			INTO	@dFecPro  
			,		@nRutcli  
			,		@nCodigo  
			,		@dFecvctop  
			,		@nMonto  
			,		@cTipo_Riesgo  
			,		@nInCodigo  
			,		@nMonedaOp  
			,		@FormaPago  
			,		@MetodoLCR  
			,		@Id_Sistema  
			,		@Codigo_Producto  
			,		@Avr  
			-------------------------------------------  
			,		@nNumoper  
			,		@NumeroCorrelativo  
			,		@fTipcambio  
			,		@cUsuario  
			,		@nContraMoneda  
			,		@nMonedaOpera  
			-------------------------------------------  
			,		@Resultado  
			,		@Garantia  
			,		@nPlazoResidual  
			,		@nMontoOriginal  
			,		@cCatipoper  
  
			WHILE @@FETCH_STATUS = 0
			BEGIN  

				Execute BacLineas.dbo.SVC_IMPUTACION_LINEAS   @dFecPro				--> OK      
															, @Id_Sistema			--> OK  
															, @Codigo_Producto		--> OK  
															, @nRutcli				--> OK  
															, @nCodigo				--> OK  
															, @nNumoper				--> OK  
															, @nNumoper				--> OK @nNumPantalla  
															, @NumeroCorrelativo	--> OK  
															, @dFecPro				--> OK  
															, @nMonto				--> OK  
															, @fTipcambio			--> OK  
															, @dFecvctop			--> OK  
															, @cUsuario				--> OK  
															, @nMonedaOp			--> OK  
															, @cTipo_Riesgo			--> OK  
															, @nInCodigo			--> OK  
															, @FormaPago			--> OK  
															, @nContraMoneda		--> OK  
															, @nMonedaOpera			--> OK  
														--	, @SwithEjecucion  
															, @SW					--> OK  
															, @Resultado			--> OK  
															, @MetodoLCR			--> OK  
															, @Garantia				--> OK  
															, @Avr					-->   
				if @Id_Sistema <> 'BCC'  
				begin  
					Execute BacLineas.dbo.SP_LIMITES_GRABAR		  @dFecPro				--> OK  
																, @Id_Sistema			--> OK  
																, @Codigo_Producto		--> OK  
																, 0						--> OK  
																, @nNumoper				--> OK  
																, @nMonto				--> OK  
																, @dFecvctop			--> OK  
																, @cUsuario				--> OK  
																, 'S'					--> OK ( @cCheckLimOPER )  
																, 'N'					--> OK   
	  
					Execute BacLineas.dbo.SP_LIMITES_GRABAR		  @dFecPro				--> OK  
																, @Id_Sistema			--> OK  
																, @Codigo_Producto		--> OK  
																, @nInCodigo			--> OK  
																, @nNumoper				--> OK  
																, @nMonto				--> OK  
																, @dFecvctop			--> OK  
																, @cUsuario				--> OK  
																, 'S'					--> OK  
																, 'S'					--> OK (@cCheckLimInst)  
				end  
  
				if @Id_Sistema = 'BFW'  
				begin  
					Execute BacLineas.dbo.SP_LIMITES_CHEQUEAR	   @Id_Sistema			--> OK  
																,  @nNumoper			--> OK  
	  
					Execute BacLineas.dbo.SP_LIMITES_RECHEQUEAR    @Id_Sistema			--> OK  
																,  @nNumoper			--> OK  
																,  @cUsuario			--> OK  
																,  'I'					--> OK  
	  
					Execute BacFwdSuda.dbo.SP_Graba_Registro_Utilidad_Banco   @nNumoper			--> OK  
																			, @Codigo_Producto	--> OK  
																			, @nRutcli			--> OK  
																			, @nCodigo			--> OK  
																			, @nMonedaOpera		--> OK  
																			, @Avr				--> OK  
																			, @nContraMoneda  
																			, @nPlazoResidual  
																			, @nMontoOriginal  
																			, @nMonto  
																			, @cCatipoper  
				end

				-->  Marco loas cliente que ya recalcularon  
				update	dbo.StatusLineaCliente  
				set		Status = 1  
				where	(	Rut  = @nRutcli   
					or		Rut  = @iRutPaso  
						)  

				FETCH NEXT FROM LineasChequearBfw  
				INTO	@dFecPro  
				,		@nRutcli  
				,		@nCodigo  
				,		@dFecvctop  
				,		@nMonto  
				,		@cTipo_Riesgo  
				,		@nInCodigo  
				,		@nMonedaOp  
				,		@FormaPago  
				,		@MetodoLCR  
				,		@Id_Sistema  
				,		@Codigo_Producto  
				,		@Avr  
				-------------------------------------------  
				,		@nNumoper  
				,		@NumeroCorrelativo  
				,		@fTipcambio  
				,		@cUsuario  
				,		@nContraMoneda  
				,		@nMonedaOpera  
				-------------------------------------------  
				,		@Resultado  
				,		@Garantia  
				,		@nPlazoResidual  
				,		@nMontoOriginal  
				,		@cCatipoper  
			END  
			CLOSE LineasChequearBfw  
			DEALLOCATE LineasChequearBfw  

			update  dbo.StatusLineaModulo set Bfw = 1 --> Finaliza proceso Bcc  
		end 
		--> FORWARD  
		--> Habilitamos Forward

		-----jcamposd 20180730 no considerar otros productos solo RF y OPT
		*/


		--+++jcamposd 20180730 no considerar otros productos solo RF y OPT
		/*
		-->	Deshabilitamos Swap
		-->  SWAP  
		if  ( select Pcs from dbo.StatusLineaModulo with(nolock) ) = -1 --> Proceso Pcs No iniciado Previamente   ( -1 )  
		or	( select Pcs from dbo.StatusLineaModulo with(nolock) ) = 0  --> Proceso Pcs Iniciado, pero no finalizado (  0 )  
		begin  

			truncate table tmp_Linea_Chequear_Cont  
			
			INSERT INTO dbo.tmp_Linea_Chequear_Cont  
			(		FechaOperacion  
			,		NumeroOperacion  
			,		Numerodocumento  
			,		NumeroCorrelativo  
			,		Rut_Cliente  
			,		Codigo_Cliente  
			,		Id_Sistema  
			,		Codigo_Producto  
			,		MontoTransaccion  
			,		TipoCambio  
			,		FechaVencimiento  
			,		Operador  
			,		Rut_Emisor  
			,		Moneda_Emision  
			,		FechaVctoInst  
			,		InCodigo  
			,		Seriado  
			,		MonedaOperacion  
			,		Tipo_Riesgo  
			,		codigo_pais  
			,		Pago_Cheque  
			,		Rut_Cheque  
			,		FechaVctoCheque  
			,		FactorVenta  
			,		FormaPago  
			,		Tir  
			,		TasaPacto  
			,		Instser  
			,		Avr  
			,		PrcLCR  
			,		Resultado  
			,		MetodoLCR  
			,		Garantia  
			,		Cod_Emisor  
			)  

			SELECT  
				/*01*/ FechaOperacion		= @dFecha    
			,	/*04*/ NumeroOperacion		= car.numero_operacion  
			,	/*05*/ Numerodocumento		= car.numero_operacion  
			,	/*06*/ NumeroCorrelativo	= 0      --> @nCorrela  
			,	/*07*/ Rut_Cliente			= car.rut_cliente  --> @nRutcli  
			,	/*08*/ Codigo_Cliente		= car.codigo_cliente --> @nCodigo  
			,	/*02*/ Id_Sistema			= 'PCS'  
			,	/*03*/ Codigo_Producto		= car.tipo_swap   --> @cProducto  
			,   /*09*/ MontoTransaccion		= car.compra_capital --> @nMonto  
			,   /*10*/ TipoCambio			= 0.0     --> @fTipcambio  
			,   /*11*/ FechaVencimiento		= car.Fecha_Termino  --> @dFecvctop  
			,   /*12*/ Operador				= ''     --> @cUsuario  
			,   /*13*/ Rut_Emisor			= 0      --> @nRut_emisor  
			,   /*14*/ Moneda_Emision		= 0      --> @nMonedaEmision  
			,   /*15*/ FechaVctoInst		= @dFecha    --> @dFecvctoInst  
			,   /*16*/ InCodigo				= 0      --> @nInCodigo  
			,   /*17*/ Seriado				= 'N'     --> @cSeriado    
			,   /*18*/ MonedaOperacion		= car.compra_moneda  --> @nMonedaOp  
			,   /*19*/ Tipo_Riesgo			= 'C'     --> @cTipo_Riesgo  
			,   /*20*/ codigo_pais			= 0      --> @nCodigo_pais  
			,   /*21*/ Pago_Cheque			= 'N'     --> @cPagoCheque  
			,   /*22*/ Rut_Cheque			= 0      --> @nRutCheque  
			,   /*23*/ FechaVctoCheque		= @dFecha    --> @dFecvctoCehque  
			,   /*24*/ FactorVenta			= 0      --> @nFactorVenta  
			,   /*25*/ FormaPago			= 0      --> @formapago  
			,   /*26*/ Tir					= 0      --> @nTir  
			,   /*27*/ TasaPacto			= 0      --> @nTasaPact  
			,   /*28*/ Instser				= 0      --> @cInstser  
			,   /*29*/ Avr					= case when round(car.Valor_RazonableCLP, 0.0) > 0 then round(car.Valor_RazonableCLP, 0.0) else 0.0 end --> @Avr  
			,   /*30*/ PrcLCR				= 0      --> @PrcLCR  
			,   /*31*/ Resultado			= 0      --> @Resultado  
			,   /*32*/ MetodoLCR			= BacLineas.dbo.FN_RIEFIN_METODO_LCR   ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
			,   /*33*/ Garantia				= case	when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
													when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
													else 0  
												end    --> @Garantia  
			,	/*34*/ Cod_Emisor			= 0 --> case when car.cacodpos1 = 2 then car.cacodmon2 else car.cacodmon1 end  
			from	BacSwapSuda.dbo.Cartera car with(nolock)
					inner join (	select	nContrato = numero_operacion, nflujo = min(numero_flujo)  
									from	BacSwapSuda.dbo.Cartera where tipo_flujo = 1 and estado <> 'C' group by numero_operacion  
								)	Agrupa	On	Agrupa.nContrato	= car.numero_operacion 
											and Agrupa.nflujo		= car.numero_flujo  
					inner join (	select	clrut, clcodigo, clnombre, clpais   
									from	BacParamSuda.dbo.cliente with(nolock)   
								)	Clie	On	Clie.clrut			= car.rut_cliente 
											and	Clie.clcodigo		= car.codigo_cliente  
			where	car.Estado			<> 'C'  
			and		car.tipo_flujo		= 1  
			and		car.Compra_Capital  > 0   
			and		car.Compra_Moneda	> 0  
			and (	car.Rut_Cliente		= @nRutCliente or @nRutCliente = 0 )  

				-->	Modificaciones por PRD-21033
				union all	--> Se agrega para agregar la base de New York para el modulos

			SELECT  
				/*01*/ FechaOperacion		= @dFecha    
			,	/*04*/ NumeroOperacion		= car.numero_operacion  
			,	/*05*/ Numerodocumento		= car.numero_operacion  
			,	/*06*/ NumeroCorrelativo	= 0      --> @nCorrela  
			,	/*07*/ Rut_Cliente			= car.rut_cliente  --> @nRutcli  
			,	/*08*/ Codigo_Cliente		= car.codigo_cliente --> @nCodigo  
			,	/*02*/ Id_Sistema			= 'PCS'  
			,	/*03*/ Codigo_Producto		= car.tipo_swap   --> @cProducto  
			,   /*09*/ MontoTransaccion		= car.compra_capital --> @nMonto  
			,   /*10*/ TipoCambio			= 0.0     --> @fTipcambio  
			,   /*11*/ FechaVencimiento		= car.Fecha_Termino  --> @dFecvctop  
			,   /*12*/ Operador				= ''     --> @cUsuario  
			,   /*13*/ Rut_Emisor			= 0      --> @nRut_emisor  
			,   /*14*/ Moneda_Emision		= 0      --> @nMonedaEmision  
			,   /*15*/ FechaVctoInst		= @dFecha    --> @dFecvctoInst  
			,   /*16*/ InCodigo				= 0      --> @nInCodigo  
			,   /*17*/ Seriado				= 'N'     --> @cSeriado    
			,   /*18*/ MonedaOperacion		= car.compra_moneda  --> @nMonedaOp  
			,   /*19*/ Tipo_Riesgo			= 'C'     --> @cTipo_Riesgo  
			,   /*20*/ codigo_pais			= 0      --> @nCodigo_pais  
			,   /*21*/ Pago_Cheque			= 'N'     --> @cPagoCheque  
			,   /*22*/ Rut_Cheque			= 0      --> @nRutCheque  
			,   /*23*/ FechaVctoCheque		= @dFecha    --> @dFecvctoCehque  
			,   /*24*/ FactorVenta			= 0      --> @nFactorVenta  
			,   /*25*/ FormaPago			= 0      --> @formapago  
			,   /*26*/ Tir					= 0      --> @nTir  
			,   /*27*/ TasaPacto			= 0      --> @nTasaPact  
			,   /*28*/ Instser				= 0      --> @cInstser  
			,   /*29*/ Avr					= case when round(car.Valor_RazonableCLP, 0.0) > 0 then round(car.Valor_RazonableCLP, 0.0) else 0.0 end --> @Avr  
			,   /*30*/ PrcLCR				= 0      --> @PrcLCR  
			,   /*31*/ Resultado			= 0      --> @Resultado  
			,   /*32*/ MetodoLCR			= BacLineas.dbo.FN_RIEFIN_METODO_LCR   ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo )  
			,   /*33*/ Garantia				= case	when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 4 then  BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
													when BacLineas.dbo.FN_RIEFIN_METODO_LCR ( Clie.clrut, Clie.clcodigo, Clie.clrut, Clie.clcodigo ) = 5 then  BacLineas.dbo.FN_RIEFIN_GARANTIA ( Clie.clrut, Clie.clcodigo, 4, 'PCS', car.numero_operacion )  
													else 0  
												end    --> @Garantia  
			,	/*34*/ Cod_Emisor			= 0 --> case when car.cacodpos1 = 2 then car.cacodmon2 else car.cacodmon1 end  
			from	BacSwapNy.dbo.Cartera car with(nolock)
					inner join (	select	nContrato = numero_operacion, nflujo = min(numero_flujo)  
									from	BacSwapNy.dbo.Cartera where tipo_flujo = 1 and estado <> 'C' group by numero_operacion  
								)	Agrupa	On	Agrupa.nContrato	= car.numero_operacion 
											and Agrupa.nflujo		= car.numero_flujo  
					inner join (	select	clrut, clcodigo, clnombre, clpais   
									from	BacParamSuda.dbo.cliente with(nolock)   
								)	Clie	On	Clie.clrut			= car.rut_cliente 
											and	Clie.clcodigo		= car.codigo_cliente  
			where	car.Estado			<> 'C'  
			and		car.tipo_flujo		= 1  
			and		car.Compra_Capital  > 0   
			and		car.Compra_Moneda	> 0  
			and (	car.Rut_Cliente		= @nRutCliente or @nRutCliente = 0 )  
				-->	Modificaciones por PRD-21033

			-->  Traspaso para el Control de Imputacion por Cliente, siempre y cuando no se ubiese cargado previamente  
			if ( select count(1) from dbo.StatusLineaCliente ) =  0 --> Control de Datos sobre la Tabla Clientes  
			or ( select Pcs		 from dbo.StatusLineaModulo  ) = -1 --> Control de Inicio de Proceso Spot ( -1)  
			begin  
				update  dbo.StatusLineaModulo set Pcs = 0 --> Inicio el proceso de Spot  

				-->  Cargo la lista de clientes que se van a recalcular  
				truncate table dbo.StatusLineaCliente  

				insert  into dbo.StatusLineaCliente   
				select	distinct   
						Rut  = Rut_Cliente  
					,	Status = 0  
				from	dbo.tmp_Linea_Chequear_Cont  
			end else  
			begin  

				if ( select Pcs   from dbo.StatusLineaModulo  ) = 0 --> Proceso Iniciado, pero no Finalizado ( 0 )  
				begin  
					-->  Elimina los Clientes ya recalculados para no colver a leerlos.  
					delete	tmp_Linea_Chequear_Cont  
					from	StatusLineaCliente  
					where	StatusLineaCliente.Rut  = Rut_Cliente  
					and		StatusLineaCliente.Status = 1  
				end  
			end  
  
			DECLARE LineasChequearPcs	CURSOR FOR   
			SELECT  FechaOperacion		= FechaOperacion  
			,		Rut_Cliente			= Rut_Cliente  
			,		Codigo_Cliente		= Codigo_Cliente  
			,		FechaVencimiento	= FechaVencimiento  
			,		MontoTransaccion	= SUM(MontoTransaccion)  
			,		Tipo_Riesgo			= Tipo_Riesgo  
			,		InCodigo			= InCodigo     --> = 0  
			,		MonedaOperacion		= MonedaOperacion  
			,		FormaPago			= FormaPago     --> = 0  
			,		MetodoLCR			= MetodoLCR  
			,		Id_Sistema			= Id_Sistema  
			,		Codigo_Producto		= Codigo_Producto  
			,		Avr					= SUM( Avr )  
			-------------------------------------------  
			,		NumeroOperacion		= ( NumeroOperacion   )  
			,		NumeroCorrelativo	= ( NumeroCorrelativo )  
			,		TipoCambio			= TipoCambio  
			,		Operador			= Operador     --> = ''  
			,		ContraMoneda		= Moneda_Emision  
			,		MonedaOpera			= Cod_Emisor  
			-------------------------------------------  
			,		Resultado			= Resultado  
			,		Garantia			= Garantia  
			,		TasaPacto			= TasaPacto  
			,		PrcLCR				= PrcLCR  
			,		Pago_Cheque			= Pago_Cheque  
			FROM	dbo.tmp_Linea_Chequear_Cont  
			GROUP 
			BY		FechaOperacion  
			,		Id_Sistema  
			,		Rut_Cliente  
			,		Codigo_Cliente  
			,		FechaVencimiento  
			,		Tipo_Riesgo  
			,		InCodigo  
			,		MonedaOperacion  
			,		FormaPago  
			,		MetodoLCR  
			,		Codigo_Producto  
			-------------------------------------------  
			,		NumeroOperacion  
			,		NumeroCorrelativo  
			,		TipoCambio  
			,		Operador  
			,		Moneda_Emision  
			,		Cod_Emisor  
			-------------------------------------------  
			,		Resultado  
			,		Garantia  
			,		TasaPacto  
			,		PrcLCR  
			,		Pago_Cheque  
			order 
			by		Rut_Cliente  
			,		Codigo_Cliente  
			,		Id_Sistema  
			,		NumeroOperacion  
			,		NumeroCorrelativo  
  
			OPEN  LineasChequearPcs  
  
			FETCH NEXT FROM LineasChequearPcs  
			INTO	@dFecPro  
			,		@nRutcli  
			,		@nCodigo  
			,		@dFecvctop  
			,		@nMonto  
			,		@cTipo_Riesgo  
			,		@nInCodigo  
			,		@nMonedaOp  
			,		@FormaPago  
			,		@MetodoLCR  
			,		@Id_Sistema  
			,		@Codigo_Producto  
			,		@Avr  
			-------------------------------------------  
			,		@nNumoper  
			,		@NumeroCorrelativo  
			,		@fTipcambio  
			,		@cUsuario  
			,		@nContraMoneda  
			,		@nMonedaOpera  
			-------------------------------------------  
			,		@Resultado  
			,		@Garantia  
			,		@nPlazoResidual  
			,		@nMontoOriginal  
			,		@cCatipoper  
  
			WHILE @@FETCH_STATUS = 0  
			BEGIN  
  
				Execute BacLineas.dbo.SVC_IMPUTACION_LINEAS		@dFecPro			--> OK      
														,		@Id_Sistema			--> OK  
														,		@Codigo_Producto	--> OK  
														,		@nRutcli			--> OK  
														,		@nCodigo			--> OK  
														,		@nNumoper			--> OK 
														,		@nNumoper			--> OK @nNumPantalla  
														,		@NumeroCorrelativo	--> OK  
														,		@dFecPro			--> OK  
														,		@nMonto				--> OK  
														,		@fTipcambio			--> OK  
														,		@dFecvctop			--> OK  
														,		@cUsuario			--> OK  
														,		@nMonedaOp			--> OK  
														,		@cTipo_Riesgo		--> OK  
														,		@nInCodigo			--> OK  
														,		@FormaPago			--> OK  
														,		@nContraMoneda		--> OK  
														,		@nMonedaOpera		--> OK  
													--	,		@SwithEjecucion  
														,		@SW					--> OK  
														,		@Resultado			--> OK  
														,		@MetodoLCR			--> OK  
														,		@Garantia			--> OK  
														,		@Avr				-->   
  
				if @Id_Sistema <> 'BCC'  
				begin  
					Execute BacLineas.dbo.SP_LIMITES_GRABAR		@dFecPro			--> OK  
														,		@Id_Sistema			--> OK  
														,		@Codigo_Producto	--> OK  
														,		0					--> OK  
														,		@nNumoper			--> OK  
														,		@nMonto				--> OK  
														,		@dFecvctop			--> OK  
														,		@cUsuario			--> OK  
														,		'S'					--> OK ( @cCheckLimOPER )  
														,		'N'					--> OK   
  
					Execute BacLineas.dbo.SP_LIMITES_GRABAR		@dFecPro			--> OK  
														,		@Id_Sistema			--> OK  
														,		@Codigo_Producto	--> OK  
														,		@nInCodigo			--> OK  
														,		@nNumoper			--> OK  
														,		@nMonto				--> OK  
														,		@dFecvctop			--> OK  
														,		@cUsuario			--> OK  
														,		'S'					--> OK  
														,		'S'					--> OK (@cCheckLimInst)  
				end  
  
				-->  Marco loas cliente que ya recalcularon  
				update	dbo.StatusLineaCliente  
				set		Status		= 1  
				where	(	Rut		= @nRutcli   
					or		Rut		= @iRutPaso  
						)  

				FETCH NEXT FROM LineasChequearPcs  
				INTO	@dFecPro  
				,		@nRutcli  
				,		@nCodigo  
				,		@dFecvctop  
				,		@nMonto  
				,		@cTipo_Riesgo  
				,		@nInCodigo  
				,		@nMonedaOp  
				,		@FormaPago  
				,		@MetodoLCR  
				,		@Id_Sistema  
				,		@Codigo_Producto  
				,		@Avr  
				-------------------------------------------  
				,		@nNumoper  
				,		@NumeroCorrelativo  
				,		@fTipcambio  
				,		@cUsuario  
				,		@nContraMoneda  
				,		@nMonedaOpera  
				-------------------------------------------  
				,		@Resultado  
				,		@Garantia  
				,		@nPlazoResidual  
				,		@nMontoOriginal  
				,		@cCatipoper  
			END  

			CLOSE LineasChequearPcs  
			DEALLOCATE LineasChequearPcs  

			UPDATE  dbo.StatusLineaModulo SET Pcs = 1 --> Finaliza proceso Bcc  
		END
		--> SWAP  
		--> Habilitamos Swap
		-----jcamposd 20180730 no considerar otros productos solo RF y OPT
		*/

		--> Deshabilitamos Otros
		--+++jcamposd 20180730 no considerar otros productos solo RF y OPT
			--EXECUTE BacLineas.dbo.SP_CARGA_LINEAS_RETENIDAS_otro @dFecha		
			--EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL
			--EXECUTE BacLineas.dbo.SP_LINEAS_ACTUALIZA
		-----jcamposd 20180730 no considerar otros productos solo RF y OPT
		
		
		UPDATE  BacLineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO   
		SET		Acumulado_Diario	= 0  
		WHERE   Id_Sistema			IN('PCS', 'BFW', 'OPT')  
		AND		Acumulado_Diario	> 0  
  
		update	dbo.StatusLinea  
		set		SwStatus	= 1  
		,		Finish		= getdate()  
	--> Habilitamos Otros
	end
	--> if @iStatus = -1  

end
GO

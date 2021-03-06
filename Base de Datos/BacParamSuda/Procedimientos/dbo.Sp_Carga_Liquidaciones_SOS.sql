USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Liquidaciones_SOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Carga_Liquidaciones_SOS]
as
begin

	-->		(	C A M B I A R    S O L O   P A R A   C O N T I N U I D A D   O P E R A T I V A	)
	declare @bMostrarMensajes	int
		set @bMostrarMensajes	= 0 --> Conf.Original (Activa las Banderas de separación entre producto e indica lo que se esta realizando)
		set @bMostrarMensajes	= 0 --> Conf. a cambiar en caso de ser requerido

	declare @bMostrarResultado	int
		set @bMostrarResultado	= 0 --> Conf.Original (Muestra el resultado de la carga, por defecto despliega la Inf. de lo que se debe Informar)
		set @bMostrarResultado	= 0 --> Conf. a cambiar en caso de ser requerido

	declare @bMostrarLoCargado	int
		set @bMostrarLoCargado	= 0 --> Conf.Original (Muestra el resultado de la carga, se activa para desplegar la Inf. Cargada no lo que se debe informar)
		set @bMostrarLoCargado	= 0 --> Conf. a cambiar en caso de ser requerido

	declare @bHabilitaSpot		int
	declare @bHabilitaForward	int
	declare @bHabilitaOpciones	int
	declare @bHabilitaSwap		int
	declare @bHabilitaTrader	int
	declare @bHabilitaBonex		int

		set @bHabilitaSpot		= 1	--> Habilita la carga de operaciones del Producto Spot
		set @bHabilitaForward	= 1	--> Habilita la carga de operaciones del Producto Forward
		set	@bHabilitaOpciones	= 1	--> Habilita la carga de operaciones del Producto Opciones
		set @bHabilitaSwap		= 1	--> Habilita la carga de operaciones del Producto Swap
		set @bHabilitaTrader	= 1 --> Habilita la carga de operaciones del Producto Renta Fija Nacional
		set @bHabilitaBonex		= 1 --> Habilita la carga de operaciones del Producto Renta Fija Extranjera

	declare @bCargaTabla		int
		set @bCargaTabla		= 1 --> Conf.Original (Activa el Insert de los Datos a la Tabla Final.)
		set @bCargaTabla		= 1 --> Conf. a cambiar en caso de ser requerido
	-->		(	C A M B I A R    S O L O   P A R A   C O N T I N U I D A D   O P E R A T I V A	)


	declare @nFilas				float
		set @nFilas				= 0

	declare @dFechaProceso		datetime
		set @dFechaProceso		= ( select acfecproc from BacTraderSuda.dbo.Mdac with(nolock) )

	-->
	if @bMostrarMensajes = 1
		set nocount on --> off
	else
		set nocount on

	if @bMostrarMensajes = 1
	begin
		print ''
		print ''
		print '<< I N I C I O - P R O C E S O >>'
		print '---------------------------------'
		print ''
		print ''
	end



	if @bHabilitaSpot = 1
	begin
		if @bMostrarMensajes = 1
			print '<< S P O T - H A B I L I T A D O >>'
			
		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'BCC'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - S P O T >>				' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		-->		Carga Operaciones Spot del Dia, calculando la fecha de liquidación
		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= BCC.IdCliente
				,	NumTransaccion					= BCC.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos( BCC.MedioPago )	-->	9 --> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= BCC.Mercado
				,	NumeroDeOperacion				= BCC.FolioContrato
				,	OficialCta						= substring(BCC.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'SPOT'
				,	EspeciaTransadaCantidad			= BCC.Monto
				,	EspeciaTransadaTipo				= BCC.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal( BCC.MedioPago )		-->	'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( BCC.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= BCC.Ingreso
				,	FechaDeLaLiquidacion			= BCC.Liquidacion
				,	RutCliente						= BCC.Rut
				,	CodigoCliente					= BCC.Codigo
				,	OrigenDeLosDatos				= 'BCC'
				,	Operador						= BCC.Operador
			from	(	select	FolioContrato	= Spot.FolioContrato
							,	TipoOperacion	= Spot.TipoOperacion
							,	Tipo			= case	when Spot.Tipo = 'C' then '0'  --> Cargo = Debito
														when Spot.Tipo = 'A' then '5'  --> Abono = Credito
													end
							,	Mercado			= Spot.Mercado
							,	Moneda			= Spot.Moneda
							,	Monto			= Spot.Monto
							,	MedioPago		= Spot.MedioPago
							,	Ingreso			= Spot.Ingreso
							,	Vencimiento		= Spot.Vencimiento
							,	DiasValor		= Spot.DiasValor
							,	Liquidacion		= BacParamSuda.dbo.Fx_SOS_Feriados( Spot.Vencimiento, Spot.DiasValor, case when Spot.Moneda = 'CLP' then 1 else 2 end)
							,	IdCliente		= Spot.IdCliente
							,	Rut				= Spot.Rut
							,	Codigo			= Spot.Codigo
							,	Operador		= Spot.Operador
						from	(	select	FolioContrato	= monumope
										,	TipoOperacion	= motipope
										,	Mercado			= motipmer
										,	Rut				= morutcli
										,	Codigo			= mocodcli
										,	Moneda			= case	when motipope = 'C' then mocodmon 
																	else mocodcnv end
										,	MedioPago		= case	when motipope = 'C' then morecib  
																	else moentre  end
										,	Monto			= case	when motipope = 'C' then momonmo
																	else case when motipmer = 'ARBI' then moussme else momonpe end
																end
										,	Tipo			= case	when motipope = 'C' then 'C'
																	else 'A' end
										,	Ingreso			= mofech
										,	Vencimiento		= mofech
										,	Liquidacion		= mofech
										,	Operador		= mooper
										,	DiasValor		= isnull(MPago.diasvalor, 0)
										,	IdCliente		= cliente.IdCliente
									from	BacCamSuda.dbo.MEMO		with(nolock)
											left join	(	select	codigo, glosa, diasvalor
															from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
														)	MPago	On MPago.codigo = case when motipope = 'C' then morecib else moentre  end

											inner join	(	select	clrut, clcodigo, clnombre, cltipcli
																,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
															from	BacParamSuda.dbo.Cliente with(nolock)
														)	cliente	On	cliente.clrut		= morutcli
																	and cliente.clcodigo	= mocodcli

									where	mofech			= @dFechaProceso
									and		motipmer		IN('PTAS','EMPR', 'ARBI', 'OVER')
									and		moestatus		= ''

										union				

									select	FolioContrato	= monumope
										,	TipoOperacion	= motipope
										,	Mercado			= motipmer
										,	Rut				= morutcli
										,	Codigo			= mocodcli
										,	Moneda			= case	when motipope = 'C' then mocodcnv
																	else mocodmon	end
										,	MedioPago		= case	when motipope = 'C' then moentre
																	else morecib 	end
										,	Monto			= case	when motipope = 'C' then case when motipmer = 'ARBI' then moussme else momonpe end
																	else momonmo
																end
										,	Tipo			= case	when motipope = 'C' then 'A'
																	else 'C' end
										,	Ingreso			= mofech
										,	Vencimiento		= mofech
										,	Liquidacion		= mofech
										,	Operador		= mooper
										,	DiasValor		= isnull(MPago.diasvalor, 0)
										,	IdCliente		= cliente.IdCliente
									from	BacCamSuda.dbo.MEMO with(nolock)
											left join	(	select	codigo, glosa, diasvalor
															from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
														)	MPago	On MPago.codigo = case when motipope = 'C' then morecib else moentre  end

											inner join	(	select	clrut, clcodigo, clnombre, cltipcli
																,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
															from	BacParamSuda.dbo.Cliente with(nolock)
														)	cliente	On	cliente.clrut		= morutcli
																	and cliente.clcodigo	= mocodcli

									where	mofech			= @dFechaProceso
									and		motipmer		IN('PTAS','EMPR', 'ARBI', 'OVER')
									and		moestatus		= ''
								)	Spot
						)	BCC
	
			set		@nFilas = @@RowCount
			if @bMostrarMensajes = 1
			print '			<< C A R G A - S P O T >>			' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '
	end

	if @bMostrarMensajes = 1
		print ' '

	if @bHabilitaForward = 1
	begin
		if @bMostrarMensajes = 1
			print '<< F O R W A R D - H A B I L I T A D O >>'

		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'BFW'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - F O R W A R D >>		' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		-->		Carga Vencimeintos Forward Compensados del Día, calculando la fecha de liquidación
		--		set @dFechaProceso		= ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= Forward.IdCliente
				,	NumTransaccion					= Forward.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos( Forward.MedioPago )	-->	9			--> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= Forward.Mercado
				,	NumeroDeOperacion				= Forward.Folio
				,	OficialCta						= substring(Forward.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'FWD'
				,	EspeciaTransadaCantidad			= Forward.Monto
				,	EspeciaTransadaTipo				= Forward.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal( Forward.MedioPago )		-->	'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( Forward.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= Forward.Ingreso
				,	FechaDeLaLiquidacion			= BacParamSuda.dbo.Fx_SOS_Feriados( Forward.Liquidacion, Forward.DiasValor, case when Forward.Moneda = 'CLP' then 1 else 2 end)
				,	RutCliente						= Forward.Rut
				,	CodigoCliente					= Forward.Codigo
				,	OrigenDeLosDatos				= 'BFW'
				,	Operador						= Forward.Operador
			from	(	
						select	Folio			= canumoper
							,	TipoOperacion	= catipoper
							,	Mercado			= ltrim(rtrim( catipoper )) + ltrim(rtrim( cacodpos1 ))
							,	Rut				= cacodigo
							,	Codigo			= cacodcli
							,	Moneda			= case	when cacodpos1 = 1  and cliente.clpais =  6	then 'CLP'
														when cacodpos1 = 1  and cliente.clpais <> 6	then 'USD'
														when cacodpos1 = 14 and cliente.clpais =  6	then 'CLP'
														when cacodpos1 = 14 and cliente.clpais <> 6	then 'USD'
														when cacodpos1 = 3							then 'CLP'
														when cacodpos1 = 13							then 'CLP'
														when cacodpos1 = 2  and cliente.clpais =  6	then 'CLP'
														when cacodpos1 = 2  and cliente.clpais <> 6	then 'USD'
														when cacodpos1 = 10							then 
																(		select	top 1 mnnemo 
																		from	BacParamSuda.dbo.moneda with(nolock) 
																		where	mncodmon = cacodmon1 )

													end
							,	MedioPago		= case	when cacodpos1 = 1  and cliente.clpais =  6	then cafpagomn
														when cacodpos1 = 1  and cliente.clpais <> 6	then case when cafpagomx = 0 then cafpagomn else cafpagomx end --> cafpagomx
														when cacodpos1 = 14 and cliente.clpais =  6	then cafpagomn
														when cacodpos1 = 14 and cliente.clpais <> 6	then case when cafpagomx = 0 then cafpagomn else cafpagomx end --> cafpagomx
														when cacodpos1 = 3							then cafpagomn
														when cacodpos1 = 13							then cafpagomn
														when cacodpos1 = 2  and cliente.clpais =  6	then cafpagomn
														when cacodpos1 = 2  and cliente.clpais <> 6	then cafpagomx
														when cacodpos1 = 10							then cafpagomn
													end
							,	Monto			= abs( camtocomp )
							,	Tipo			= case	when camtocomp >= 0 then '5'	-->	'A' 
														else '0'						--> 'C' 
													end
							,	Ingreso			= cafecha
							,	Vencimiento		= cafecvcto
							,	Liquidacion		= cafecvcto
							,	Operador		= caoperador
							,	DiasValor		= isnull(MPago.diasvalor, 0)
							,	IdCliente		= cliente.IdCliente
						from	BacFwdSuda.dbo.Mfca	with(nolock)	-->	BacFwdSuda.dbo.Mfca	with(nolock)
								inner join	(	select	clrut, clcodigo, clnombre, cltipcli, clpais
													,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
												from	BacParamSuda.dbo.Cliente with(nolock)
											)	cliente	On	cliente.clrut		= cacodigo
														and cliente.clcodigo	= cacodcli

								left join	(	select	codigo, glosa, diasvalor
												from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
											)	MPago	On MPago.codigo = case	when cacodpos1 = 1  and cliente.clpais =  6	then cafpagomn
																				when cacodpos1 = 1  and cliente.clpais <> 6	then case when cafpagomx = 0 then cafpagomn else cafpagomx end
																				when cacodpos1 = 14 and cliente.clpais =  6	then cafpagomn
																				when cacodpos1 = 14 and cliente.clpais <> 6	then case when cafpagomx = 0 then cafpagomn else cafpagomx end
																				when cacodpos1 = 3							then cafpagomn
																				when cacodpos1 = 13							then cafpagomn
																				when cacodpos1 = 2  and cliente.clpais =  6	then cafpagomn
																				when cacodpos1 = 2  and cliente.clpais <> 6	then cafpagomx
																			end
						where	cafecvcto		= @dFechaProceso
						and		var_moneda2		= 0
						and		catipmoda		= 'C'
						and		camtocomp		<> 0
						
								union
						
						select	Folio			= canumoper
							,	TipoOperacion	= catipoper
							,	Mercado			= ltrim(rtrim( catipoper )) + ltrim(rtrim( cacodpos1 ))
							,	Rut				= cacodigo
							,	Codigo			= cacodcli
							,	Moneda			= case	when cacodpos1 = 2 and cliente.clpais =  6	then 'CLP'
														when cacodpos1 = 2 and cliente.clpais <> 6	then 'USD'
													end
							,	MedioPago		= case	when cacodpos1 = 2 and cliente.clpais =  6	then cafpagomn
														when cacodpos1 = 2 and cliente.clpais <> 6	then cafpagomx
													end
							,	Monto			= abs( MxClp.camtocomp )
							,	Tipo			= case	when MxClp.camtocomp >= 0 then '5'	-->	'A' 
														else '0'						--> 'C' 
													end
							,	Ingreso			= cafecha
							,	Vencimiento		= cafecvcto
							,	Liquidacion		= cafecvcto
							,	Operador		= 'MXCLP' --> caoperador
							,	DiasValor		= isnull(MPago.diasvalor, 0)
							,	IdCliente		= cliente.IdCliente
						from	BacFwdSuda.dbo.Mfca	with(nolock)	-->	BacFwdSuda.dbo.Mfca	with(nolock)
								inner join (	select	Folio		 = var_moneda2
													,	Producto	 = MAX(cacodpos1)
													,	camtocomp	 = SUM(camtocomp)
												from	BacFwdSuda.dbo.Mfcares
												where	cafechaproceso	= @dFechaProceso
												and		cafecvcto		= @dFechaProceso
												and		var_moneda2  <> 0
												group
												by		var_moneda2
											)	MxClp	On	MxClp.Folio		= canumoper
														and MxClp.Producto	= cacodpos1
						
								inner join	(	select	clrut, clcodigo, clnombre, cltipcli, clpais
													,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
												from	BacParamSuda.dbo.Cliente with(nolock)
											)	cliente	On	cliente.clrut		= cacodigo
														and cliente.clcodigo	= cacodcli

								left join	(	select	codigo, glosa, diasvalor
												from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
											)	MPago	On MPago.codigo = case	when cacodpos1 = 1 and cliente.clpais =  6	then cafpagomn
																				when cacodpos1 = 1 and cliente.clpais <> 6	then case when cafpagomx = 0 then cafpagomn else cafpagomx end
																				when cacodpos1 = 3							then cafpagomn
																				when cacodpos1 = 13							then cafpagomn
																				when cacodpos1 = 2 and cliente.clpais =  6	then cafpagomn
																				when cacodpos1 = 2 and cliente.clpais <> 6	then cafpagomx
																			end
					--	where	cafechaproceso	= @dFechaProceso
						where	cafecvcto		= @dFechaProceso
						and		var_moneda2		<> 0
						and		catipmoda		= 'C'
						and		MxClp.camtocomp	<> 0
						
					)	Forward

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '			<< C A R G A - F O R W A R D >>		'  + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '
	end

	if @bMostrarMensajes = 1
		print ' '

	
	if @bHabilitaOpciones =1
	begin
		if @bMostrarMensajes = 1
			print '<< O P C I O N E S - H A B I L I T A D O >>'

		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'OPC'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - O P C I O N E S >>		' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		-->		Carga Vencimeintos Opciones Compensados del Día, Caja
		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= Opciones.IdCliente
				,	NumTransaccion					= Opciones.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos( Opciones.MedioPago ) --> 9			--> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= Opciones.Mercado
				,	NumeroDeOperacion				= Opciones.Folio
				,	OficialCta						= substring(Opciones.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'OPC'
				,	EspeciaTransadaCantidad			= Opciones.Monto
				,	EspeciaTransadaTipo				= Opciones.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal( Opciones.MedioPago )	--> 'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( Opciones.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= Opciones.Ingreso
				,	FechaDeLaLiquidacion			= Opciones.Liquidacion
												--	BacParamSuda.dbo.Fx_SOS_Feriados( Opciones.Liquidacion, Opciones.DiasValor, case when Opciones.Moneda = 'CLP' then 1 else 2 end)
				,	RutCliente						= Opciones.Rut
				,	CodigoCliente					= Opciones.Codigo
				,	OrigenDeLosDatos				= 'OPC'
				,	Operador						= Opciones.Operador
			from	(
						select	Folio				= caCaja.CaNumContrato
							,	Mercado				= contrato.CaCodEstructura
							,	Rut					= Contrato.Rut
							,	Codigo				= Contrato.Codigo
							,	Monto				= ABS(SUM(caCaja.CaCajMtoMon1))
							,	Moneda				= Moneda.mnnemo --> caCaja.CaCajMdaM1
							,	MedioPago			= caCaja.CaCajFormaPagoMon1
							,	Tipo				= case	when SUM(caCaja.CaCajMtoMon1) >= 0 then '5'	-->	'A' 
															else '0'						--> 'C' 
														end
							,	Ingreso				= caCaja.CaCajFechaGen
							,	Vencimiento			= caCaja.CaCajFecPago
							,	Liquidacion			= caCaja.CaCajFecPago
							,	Operador			= Contrato.CaOperador
							,	DiasValor			= MPago.diasvalor
							,	IdCliente			= Contrato.IdCliente
						from	LNKOPC.CbMdbOpc.dbo.caCaja caCaja
								inner join (	select	CaNumContrato	= contrato.CaNumContrato
													,	CaRutCliente	= contrato.CaRutCliente
													,	CaCodigo		= contrato.CaCodigo
													,	CaOperador		= contrato.CaOperador
													,	CaCodEstructura	= contrato.CaCodEstructura
													,	CaCVEstructura	= contrato.CaCVEstructura
													,	OpcEstDsc		= Estruc.OpcEstDsc
													,	IdCliente		= cliente.IdCliente
													,	Rut				= contrato.CaRutCliente
													,	Codigo			= contrato.CaCodigo
												from	LNKOPC.CbMdbOpc.dbo.CaEncContrato contrato
														inner join (	select	Folio	= CaNumFolio
																			,	Id		= MAX(CaNumContrato)
																		from	LNKOPC.CbMdbOpc.dbo.CaEncContrato with(nolock)
																		group 
																		by		CaNumFolio
																	)	Vigente	On	Vigente.Folio	= contrato.CaNumFolio
																				and Vigente.Id		= contrato.CaNumContrato

														inner join	(	select	clrut, clcodigo, clnombre, cltipcli, clpais
																			,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
																		from	BacParamSuda.dbo.Cliente with(nolock)
																	)	cliente	On	cliente.clrut		= contrato.CaRutCliente
																				and cliente.clcodigo	= contrato.CaCodigo
																				
														inner join	(	select	OpcEstCod, OpcEstDsc
																		from	LNKOPC.CbMdbOpc.dbo.OpcionEstructura with(nolock)
																	)	Estruc	On Estruc.OpcEstCod = contrato.CaCodEstructura

										)	Contrato	On Contrato.CaNumContrato	= caCaja.CaNumContrato

								left join	(	select	codigo, glosa, diasvalor
												from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
											)	MPago	On MPago.codigo = caCaja.CaCajFormaPagoMon1
											
								left join	(	select	mncodmon, mnnemo
												from	BacParamSuda.dbo.Moneda with(nolock)
											)	Moneda	On Moneda.mncodmon	= caCaja.CaCajMdaM1

					--	where	caCaja.CaCajFechaGen		= @dFechaProceso
						where	caCaja.CaCajFecPago			= @dFechaProceso
						and		caCaja.CaCajModalidad		= 'C'
						group 
						by		caCaja.CaNumContrato
							,	caCaja.CaCajMdaM1
							,	caCaja.CaCajFormaPagoMon1
							,	caCaja.CaCajFechaGen
							,	caCaja.CaCajFecPago
							,	Contrato.Rut
							,	Contrato.Codigo
							
							,	contrato.CaCodEstructura
							,	Contrato.CaOperador
							,	MPago.diasvalor
							,	Contrato.IdCliente
							,	Moneda.mnnemo
					)	Opciones			

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '			<< C A R G A - O P C I O N E S >>	'  + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '
	end

	if @bMostrarMensajes = 1
		print ' '
	
	if @bHabilitaSwap = 1
	begin
		if @bMostrarMensajes = 1
			print '<< S W A P - H A B I L I T A D O >>'

		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'PCS'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - S W A P >>				' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		-->		Carga Vencimeintos Swap Compensados.
		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= Swap.IdCliente
				,	NumTransaccion					= Swap.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos( Swap.MedioPago ) --> 9			--> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= Swap.Mercado
				,	NumeroDeOperacion				= Swap.Folio
				,	OficialCta						= substring(Swap.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'SWAP'
				,	EspeciaTransadaCantidad			= case when Moneda.mnnemo = 'CLP' then round(Swap.Monto, 0) else round(Swap.Monto, 4) end
				,	EspeciaTransadaTipo				= Moneda.mnnemo --> Swap.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal(Swap.MedioPago)	-->  'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( Swap.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= Swap.Ingreso
				,	FechaDeLaLiquidacion			= Swap.Liquidacion
				,	RutCliente						= Swap.Rut
				,	CodigoCliente					= Swap.Codigo
				,	OrigenDeLosDatos				= 'PCS'
				,	Operador						= Swap.Operador
			from	(	
						select	Folio		= Contratos.Folio
--							,	Mercado		= Contratos.Mercado
							,	Mercado		= case	when Contratos.Mercado = 1 then 'IRS'
													when Contratos.Mercado = 2 then 'CCS'
													when Contratos.Mercado = 3 then 'FRA'
													when Contratos.Mercado = 4 then 'ICP'
												end
							,	Rut			= Contratos.Rut
							,	Codigo		= Contratos.Codigo

							,	Moneda		= case	when isnull(Activo.Monto, 0) <> 0 and isnull(Pasivo.Monto, 0) <> 0 then 
														case	when isnull(Activo.Monto, 0) - isnull(Pasivo.Monto, 0) >= 0 then isnull(Activo.Moneda,0)
																else isnull(Pasivo.Moneda,0)
															end
													else
														case	when isnull(Activo.Monto, 0) <> 0 then isnull(Activo.Moneda,0)
																else isnull(Pasivo.Moneda,0)
															end
												end
							,	MedioPago	= case	when isnull(Activo.Monto, 0) <> 0 and isnull(Pasivo.Monto, 0) <> 0 then 
														case	when isnull(Activo.Monto, 0) - isnull(Pasivo.Monto, 0) >= 0 then isnull(Activo.FPago,0)
																else isnull(Pasivo.FPago,0)
															end
													else
														case	when isnull(Activo.Monto, 0) <> 0 then isnull(Activo.FPago,0)
																else isnull(Pasivo.FPago,0)
															end
												end
							,	Monto		= abs(isnull(Activo.Monto, 0) - isnull(Pasivo.Monto, 0))
							,	Tipo		= case	when isnull(Activo.Monto, 0) - isnull(Pasivo.Monto, 0) >= 0 then '5'
													else '0' 
												end
							,	Ingreso		= Contratos.Ingreso
							,	Vencimiento	= Contratos.Liquidacion
							,	Liquidacion	= Contratos.Liquidacion
							,	Operador	= Contratos.Operador
							,	DiasValor	= case	when isnull(Activo.Monto, 0) - isnull(Pasivo.Monto, 0) >= 0 then Activo.Dias
													else Pasivo.Dias
												end
							,	IdCliente	= Contratos.IdCliente
						from	(	select	Folio		= cart.numero_operacion
										,	Mercado		= cart.tipo_swap
										,	Rut			= clie.clrut
										,	Codigo		= clie.clcodigo
										,	IdCliente	= clie.IdCliente
										,	Ingreso		= cart.fecha_cierre
										,	Liquidacion	= cart.FechaLiquidacion
										,	Operador	= cart.operador
									from	BacSwapSuda.dbo.Cartera cart with(nolock)
											inner join	(	select	clrut, clcodigo, clnombre, cltipcli
																,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
															from	BacParamSuda.dbo.Cliente with(nolock)
														)	clie	on clie.clrut = cart.rut_cliente and clie.clcodigo = cart.codigo_cliente
									where	cart.FechaLiquidacion	= @dFechaProceso
									and		cart.modalidad_pago		= 'C'
									group
									by		cart.numero_operacion, cart.tipo_swap, cart.fecha_cierre, cart.FechaLiquidacion, cart.operador
										,	clie.clrut,clie.clcodigo,clie.IdCliente
								)	Contratos
								
								left join	(	select	Folio			= numero_operacion 
													,	FechaTermino	= FechaAnticipo
													,	FlujoPagamos	= Pagamos_Monto
													,	FlujoRecibimos	= Recibimos_Monto
													,	MontoFlujo		= case	when (Pagamos_Moneda + Recibimos_Moneda)  = 999 then (Recibimos_Monto_CLP - Pagamos_Monto_CLP)
																				when (Pagamos_Moneda + Recibimos_Moneda) <> 999 then (Recibimos_Monto_USD - Pagamos_Monto_USD)
																				else                                                 (Recibimos_Monto     - Pagamos_Monto)
																			end
												from	BacSwapSuda.dbo.Cartera_Unwind
												where	FechaAnticipo	= @dFechaProceso
												and	(	Pagamos_Monto 
													+	Recibimos_Monto
													)					> 0
											)	Unwind	On Unwind.Folio	= Contratos.Folio

								left 
								join	(
										select	Folio	= cartera.numero_operacion
											,	Moneda	= cartera.recibimos_moneda
											,	FPago	= cartera.recibimos_documento
											,	Monto	= case	when cartera.estado = 'N' then cartera.recibimos_monto 
																else cartera.compra_interes + cartera.compra_amortiza * cartera.intercprinc + cartera.compra_flujo_adicional
															end	
														*
														( case	when cartera.estado = 'N' then 1.0
																else case	when cartera.recibimos_moneda = cartera.compra_moneda then 1.0 
																			else isnull(vmoneda.vmvalor, 0.0)
																		end
																/	case	when cartera.recibimos_moneda = cartera.compra_moneda then 1.0 
																			else case when vmpago.vmvalor = 0 then 1 else isnull(vmpago.vmvalor, 1.0) end
																		end
															end
														)
											,	Dias	= MPago.diasvalor
										from	BacSwapSuda.dbo.Cartera cartera
										left join	(	select	codigo, glosa, diasvalor
														from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
													)	MPago	On MPago.codigo = cartera.recibimos_documento

										left join	(	select  vmfecha, vmcodigo, vmvalor from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	<> 13
												union	select	vmfecha, 999,	   1.0	   from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 998
												union	select	vmfecha, 13,	   vmvalor from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 994
													)	vmoneda	On vmoneda.vmcodigo = cartera.compra_moneda

										left join	(	select  vmfecha, vmcodigo, vmvalor	from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	<> 13
												union	select	vmfecha, 999,		1.0		from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 998
												union	select	vmfecha, 13,	   vmvalor	from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 994
													)	vmpago	On vmpago.vmcodigo = cartera.recibimos_moneda

										where	cartera.FechaLiquidacion	= @dFechaProceso
										and		cartera.tipo_flujo			= 1
										)	Activo	On Activo.Folio	= Contratos.Folio

								left 
								join	(
										select	Folio	= cartera.numero_operacion
											,	Moneda	= cartera.pagamos_moneda
											,	FPago	= cartera.pagamos_documento
											,	Monto	= case	when cartera.estado = 'N' then cartera.pagamos_monto 
																else cartera.venta_interes + cartera.venta_amortiza * cartera.intercprinc + cartera.venta_flujo_adicional
															end	
														*
														( case	when cartera.estado = 'N' then 1.0
																else case	when cartera.pagamos_moneda = cartera.venta_moneda then 1.0 
																			else isnull(vmoneda.vmvalor, 0.0)
																		end
																   / case	when cartera.pagamos_moneda = cartera.venta_moneda then 1.0 
																			else case when vmpago.vmvalor = 0 then 1 else isnull(vmpago.vmvalor, 1.0) end
																		end
															end
														)
											,	Dias	= MPago.diasvalor
										from	BacSwapSuda.dbo.Cartera cartera
										left join	(	select	codigo, glosa, diasvalor
														from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
													)	MPago	On MPago.codigo = cartera.pagamos_documento

										left join	(	select  vmfecha, vmcodigo, vmvalor from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	<> 13
												union	select	vmfecha, 999,	   1.0	   from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 998
												union	select	vmfecha, 13,	   vmvalor from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	 = 994
													)	vmoneda	On vmoneda.vmcodigo = cartera.venta_moneda

										left join	(	select  vmfecha, vmcodigo, vmvalor	from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	<> 13
												union	select	vmfecha, 999,		1.0		from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	= 998
												union	select	vmfecha, 13,	   vmvalor	from BacparamSuda.dbo.Valor_Moneda with(nolock) where vmfecha = @dFechaProceso and vmcodigo	= 994
													)	vmpago	On vmpago.vmcodigo = cartera.pagamos_moneda

										where	cartera.FechaLiquidacion	= @dFechaProceso
										and		cartera.tipo_flujo			= 2
										)	Pasivo	On Pasivo.Folio	= Contratos.Folio

								where 	isnull(Activo.Monto,0) - isnull(Pasivo.Monto,0) <> 0
					) Swap
						left join	(	select	mncodmon, mnnemo
										from	BacParamSuda.dbo.Moneda with(nolock)
									)	Moneda	On Moneda.mncodmon	= Swap.Moneda
	

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '			<< C A R G A - S W A P >>			'  + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '
	end

	if @bMostrarMensajes = 1
		print ' '

	if @bHabilitaTrader	= 1
	begin
		if @bMostrarMensajes = 1
			print '<< T R A D E R - H A B I L I T A D O >>'

		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'BTR'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - T R A D E R >>			' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		-->		Carga Vencimeintos Swap Compensados.
		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= Trader.IdCliente
				,	NumTransaccion					= Trader.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos(Trader.MedioPago) -->  9			--> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= Trader.Mercado
				,	NumeroDeOperacion				= Trader.Folio
				,	OficialCta						= substring(Trader.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'RFN'
				,	EspeciaTransadaCantidad			= Trader.Monto
				,	EspeciaTransadaTipo				= Trader.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal(Trader.MedioPago)	--> 'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( Trader.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= Trader.Ingreso
				,	FechaDeLaLiquidacion			= BacParamSuda.dbo.Fx_SOS_Feriados( Trader.Liquidacion, Trader.DiasValor, case when Trader.Moneda = 'CLP' then 1 else 2 end)
				,	RutCliente						= Trader.Rut
				,	CodigoCliente					= Trader.Codigo
				,	OrigenDeLosDatos				= 'BTR'
				,	Operador						= Trader.Operador
			from	(
						select	Folio		= RentaFija.Folio
							,	Tipo		= case	when RentaFija.CargoAbono = 'C' then '0'  --> Cargo = Debito
													when RentaFija.CargoAbono = 'A' then '5'  --> Abono = Credito
												end
							,	Mercado		= RentaFija.Mercado
							,	Rut			= RentaFija.Rut
							,	Codigo		= RentaFija.Codigo
							,	Moneda		= Moneda.mnnemo --> RentaFija.Moneda
							,	MedioPago	= RentaFija.MedioPago
							,	Monto		= RentaFija.Monto
							,	IdCliente	= clie.IdCliente
							,	Ingreso		= RentaFija.Ingreso
							,	Liquidacion	= RentaFija.Liquidacion
							,	Operador	= RentaFija.Operador
							,	DiasValor	= isnull(MPago.diasvalor, 0)
							,	CargoAbono	= RentaFija.CargoAbono
						from (	
								select	Folio			= mov.monumoper
									,	Tipo			= mov.motipoper
									,	Mercado			= case	when mov.motipoper = 'IB'	then 'ICOL' 
																else mov.motipoper end
									,	Rut				= mov.morutcli
									,	Codigo			= mov.mocodcli
									,	Moneda			= mov.momonpact
									,	MedioPago		= case	when mov.motipoper = 'RC'	then mov.moforpagv
																when mov.motipoper = 'RCA'	then mov.moforpagv
																else							 mov.moforpagi
															end
									,	Monto			= case	when mov.motipoper = 'CI'	then sum(mov.movpresen)
																when mov.motipoper = 'IB'	then sum(mov.movpresen)
																when mov.motipoper = 'RC'	then sum(mov.movalvenp)
																when mov.motipoper = 'RCA'	then sum(mov.movalvenp)
															end
									,	IdCliente		= 0
									,	Ingreso			= mov.mofecpro
									,	Liquidacion		= mov.mofecpro
									,	Operador		= mov.mousuario
									,	CargoAbono		= 'C'
								from	BacTraderSuda.dbo.mdmo mov
								where	mov.mofecpro	= @dFechaProceso
								and	(	mov.motipoper	in('rc','rca','ci')
									or	mov.moinstser	= 'icol'
									)
								and		mov.mostatreg	= ''
								group
								by		mov.mofecpro
									,	mov.monumoper
									,	motipoper
									,	case	when mov.motipoper = 'IB'	then 'ICOL' 
												else mov.motipoper end
									,	mov.morutcli
									,	mov.mocodcli
									,	mov.momonpact
									,	case	when mov.motipoper = 'RC'	then mov.moforpagv
												when mov.motipoper = 'RCA'	then mov.moforpagv
												else							 mov.moforpagi
											end
									,	mov.mousuario


									union
								
								select	Folio			= mov.monumoper
									,	Tipo			= mov.motipoper
									,	Mercado			= case	when mov.motipoper = 'IB'	then 'ICAP' 
																else mov.motipoper end
									,	Rut				= mov.morutcli
									,	Codigo			= mov.mocodcli
									,	Moneda			= mov.momonpact
									,	MedioPago		= case	when mov.motipoper = 'RV'	then mov.moforpagv
																when mov.motipoper = 'RVA'	then mov.moforpagv
																else							 mov.moforpagi
															end
									,	Monto			= case	when mov.motipoper = 'VI'	then sum(mov.movpresen)
																when mov.motipoper = 'IB'	then sum(mov.movpresen)
																when mov.motipoper = 'RV'	then sum(mov.movalvenp)
																when mov.motipoper = 'RVA'	then sum(mov.movalvenp)
															end
									,	IdCliente		= 0
									,	Ingreso			= mov.mofecpro
									,	Liquidacion		= mov.mofecpro
									,	Operador		= mov.mousuario
									,	CargoAbono		= 'A'
								from	BacTraderSuda.dbo.mdmo mov
								where	mov.mofecpro	= @dFechaProceso
								and	(	mov.motipoper	in('rv','rva','vi')
									or	mov.moinstser	= 'icap'
									)
								and		mov.mostatreg	= ''
								group
								by		mov.mofecpro
									,	mov.monumoper
									,	mov.motipoper
									,	mov.momonpact
									,	case	when mov.motipoper = 'RV'	then mov.moforpagv
												when mov.motipoper = 'RVA'	then mov.moforpagv
												else							 mov.moforpagi
											end
									,	mov.mousuario
									,	mov.morutcli
									,	mov.mocodcli

									union

								select	Folio			= mov.monumoper
									,	Tipo			= mov.motipoper
									,	Mercado			= mov.motipoper
									,	Rut				= mov.morutcli
									,	Codigo			= mov.mocodcli
									,	Moneda			= case	when mov.momonemi = 999 then 999
																when mov.momonemi = 998 then 999
																when mov.momonemi = 994 then 999
																else mov.momonemi
															end
									,	MedioPago		= mov.moforpagi
									,	Monto			= SUM(mov.movpresen)
									,	IdCliente		= 0
									,	Ingreso			= mov.mofecpro
									,	Liquidacion		= mov.mofecpro
									,	Operador		= mov.mousuario
									,	CargoAbono		= 'C'
								from	BacTraderSuda.dbo.mdmo mov with(nolock)
								where	mov.mofecpro	= @dFechaProceso
								and		mov.motipoper	in('cp')
								and		mov.mostatreg	= ''
								group
								by		mov.mofecpro
									,	mov.monumoper
									,	mov.motipoper
									,	mov.motipoper
									,	case	when mov.momonemi = 999 then 999
												when mov.momonemi = 998 then 999
												when mov.momonemi = 994 then 999
												else mov.momonemi
											end
									,	mov.moforpagi
									,	mov.mousuario
									,	mov.morutcli
									,	mov.mocodcli

									union

								select	Folio			= mov.monumoper
									,	Tipo			= mov.motipoper
									,	Mercado			= mov.motipoper
									,	Rut				= mov.morutcli
									,	Codigo			= mov.mocodcli
									,	Moneda			= case	when mov.momonemi = 999 then 999
																when mov.momonemi = 998 then 999
																when mov.momonemi = 994 then 999
																else mov.momonemi
															end
									,	MedioPago		= mov.moforpagi
									,	Monto			= SUM(mov.movalven)
									,	IdCliente		= 0
									,	Ingreso			= mov.mofecpro
									,	Liquidacion		= mov.mofecpro
									,	Operador		= mov.mousuario
									,	CargoAbono		= 'A'
								from	BacTraderSuda.dbo.mdmo mov with(nolock)
								where	mov.mofecpro	= @dFechaProceso
								and		mov.motipoper	in('vp', 'fli')
								and		mov.mostatreg	= ''
								group
								by		mov.mofecpro
									,	mov.monumoper
									,	mov.motipoper
									,	mov.motipoper
									,	case	when mov.momonemi = 999 then 999
												when mov.momonemi = 998 then 999
												when mov.momonemi = 994 then 999
												else mov.momonemi
											end
									,	mov.moforpagi
									,	mov.mousuario
									,	mov.morutcli
									,	mov.mocodcli

									union

								select	Folio			= rs.rsnumdocu
									,	Tipo			= 'V' + ltrim(rtrim( rs.rsinstser ))
									,	Mercado			= rs.rstipoper
									,	Rut				= rs.rsrutcli
									,	Codigo			= rs.rscodcli
									,	Moneda			= case	when rs.rsmonpact = 999 then 999
																when rs.rsmonpact = 998 then 999
																when rs.rsmonpact = 994 then 999
																else rs.rsmonpact
															end
									,	MedioPago		= rs.rsforpagv
									,	Monto			= SUM(rs.rsvppresenx)
									,	IdCliente		= 0
									,	Ingreso			= rs.rsfecha
									,	Liquidacion		= rs.rsfecha
									,	Operador		= 'AUTOMATICO' --> 'VCUP'
									,	CargoAbono		= case	when rs.rsinstser = 'ICAP' then 'C' else 'A' end
								from	BacTraderSuda.dbo.Mdrs rs
								where	rsfecha			= @dFechaProceso
								and		rstipoper		= 'VC'
								and		rscodigo	   <> 888
								and		rscartera		= 130	--> Vencimiento Interbancario
								group
								by		rs.rsfecha
									,	rs.rsnumdocu
									,	rs.rsinstser
									,	rs.rstipoper
									,	rs.rsrutcli
									,	rs.rscodcli
									,	case	when rs.rsmonpact = 999 then 999
												when rs.rsmonpact = 998 then 999
												when rs.rsmonpact = 994 then 999
												else rs.rsmonpact
											end
									,	rs.rsforpagv
									,	case	when rs.rsinstser = 'ICAP' then 'C' else 'A' end

									union

								select	Folio			= rs.rsnumdocu
									,	Tipo			= 'VCUP'
									,	Mercado			= rs.rstipoper
									,	Rut				= rs.rsrutemis
									,	Codigo			= 1
									,	Moneda			= case	when rs.rsmonpact = 999 then 999
																when rs.rsmonpact = 998 then 999
																when rs.rsmonpact = 994 then 999
																else rs.rsmonpact
															end
									,	MedioPago		= rs.rsforpagv
									,	Monto			= SUM(rs.rsflujo) --> SUM(rs.rsvppresenx)
									,	IdCliente		= 0
									,	Ingreso			= rs.rsfecha
									,	Liquidacion		= rs.rsfecha
									,	Operador		= 'AUTOMATICO' --> 'VCUP'
									,	CargoAbono		= case	when rs.rsrutemis = 97023000 then 'A' else 'C' end
								from	BacTraderSuda.dbo.Mdrs rs
								where	rsfecha			= @dFechaProceso
								and		rstipoper		= 'VC'
								and		rscodigo	   <> 888
								and		rscartera		= 111	-->		Vencimientos de Cupón
								group
								by		rs.rsfecha
									,	rs.rsnumdocu
		--							,	rs.rsinstser
									,	rs.rstipoper
									,	rs.rsrutemis
									,	case	when rs.rsmonpact = 999 then 999
												when rs.rsmonpact = 998 then 999
												when rs.rsmonpact = 994 then 999
												else rs.rsmonpact
											end
									,	rs.rsforpagv
									,	case	when rs.rsrutemis = 97023000 then 'A' else 'C' end

							 )	RentaFija
								left join	(	select	clrut, clcodigo, clnombre, cltipcli
													,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
												from	BacParamSuda.dbo.Cliente with(nolock)
											)	clie	on clie.clrut = RentaFija.Rut and clie.clcodigo = RentaFija.codigo

								left join	(	select	codigo, glosa, diasvalor
												from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
											)	MPago	On MPago.codigo = RentaFija.MedioPago
											
								left join	(	select	mncodmon, mnnemo
												from	BacParamSuda.dbo.Moneda with(nolock)
											)	Moneda	On Moneda.mncodmon	= RentaFija.Moneda
					)	Trader

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '			<< C A R G A - T R A D E R >>		'  + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '
	end


	if @bMostrarMensajes = 1
		print ' '

	if @bHabilitaBonex	= 1
	begin
		if @bMostrarMensajes = 1
			print '<< I N V E X - H A B I L I T A D O >>'

		delete	from	dbo.Liquidaciones_SOS
				where	FechaCarga			= @dFechaProceso
				and		OrigenDeLosDatos	= 'BEX'

		set		@nFilas = @@RowCount
		if @bMostrarMensajes = 1
			print '		<< D E L E T E - I N V E X >>			' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '

		if @bCargaTabla = 1
			insert into dbo.Liquidaciones_SOS
			select	FechaCarga						= @dFechaProceso
				,	IdentificacionCliente			= '01'
				,	IdentificadorClienteNumero		= Invex.IdCliente
				,	NumTransaccion					= Invex.Tipo
				,	OrigenDeLosFondos				= BacParamSuda.dbo.Fx_SOS_OrigenFondos(Invex.MedioPago)	--> 9			--> 9 = Documento ; 0 = Efectivo
				,	TipoOperacion					= Invex.Mercado
				,	NumeroDeOperacion				= Invex.Folio
				,	OficialCta						= substring(Invex.Operador, 1, 12)
				,	NumeroCheque					= ''		--> No Existe Dato
				,	TipoCta							= 'BONX'
				,	EspeciaTransadaCantidad			= Invex.Monto
				,	EspeciaTransadaTipo				= Invex.Moneda
				,	Causal							= BacParamSuda.dbo.Fx_SOS_Causal(Invex.MedioPago) --> 'TH'		--> TH = Compra/Venta ; DB = Deposito ; BD = Giro
				,	BeneficiarioOrdenanteDelExte	= ''		--> No Existe Dato
				,	PaisDelBeneficiarioOrdenante	= ''		--> No Existe Dato
				,	MedioPago						= BacParamSuda.dbo.Fx_SOS_MedioPago( Invex.MedioPago )
				,	Sucursal						= '001'
				,	FechaDeLaOperacion				= Invex.Ingreso
				,	FechaDeLaLiquidacion			= BacParamSuda.dbo.Fx_SOS_Feriados( Invex.Liquidacion, Invex.DiasValor, case when Invex.Moneda = 'CLP' then 1 else 2 end)
				,	RutCliente						= Invex.Rut
				,	CodigoCliente					= Invex.Codigo
				,	OrigenDeLosDatos				= 'BEX'
				,	Operador						= Invex.Operador
			from	(	
						select	Folio		= Bex.Folio
							,	Tipo		= case	when Bex.CargoAbono = 'C' then '0'
													when Bex.CargoAbono = 'A' then '5'
												end
							,	Mercado		= Bex.Mercado
							,	Rut			= Bex.Rut
							,	Codigo		= Bex.Codigo
							,	Moneda		= Moneda.mnnemo
							,	MedioPago	= Bex.MedioPago
							,	Monto		= Bex.Monto
							,	IdCliente	= clie.IdCliente
							,	Ingreso		= Bex.Ingreso
							,	Liquidacion	= Bex.Liquidacion
							,	Operador	= Bex.Operador
							,	DiasValor	= isnull(MPago.diasvalor, 0)
							,	CargoAbono	= Bex.CargoAbono
						from	(
									select	Folio			= mo.monumoper
										,	Tipo			= mo.motipoper
										,	Mercado			= case when mo.cod_nemo = 'CD' then 'BCD' else 'B' + ltrim(rtrim(mo.motipoper)) end
										,	Rut				= mo.morutcli
										,	Codigo			= mo.mocodcli
										,	Moneda			= mo.momonemi
										,	MedioPago		= mo.forma_pago
										,	Monto			= mo.movpresen
										,	Ingreso			= mo.mofecpro
										,	Liquidacion		= mo.mofecpro
										,	Operador		= mo.mousuario
										,	CargoAbono		= case	when mo.cod_nemo = 'CD' then 'A'
																	else case when mo.motipoper	= 'CP' then 'A' else 'C' end
																end
									from	BacBonosExtSuda.dbo.Text_Mvt_Dri mo with(nolock)
									where	mo.mofecpro		= @dFechaProceso
									and		mo.motipoper	IN('CP','VP')
									and		mo.mostatreg	= ''

										union

									select	Folio			= rs.rsnumdocu
										,	Tipo			= rs.rstipoper
										,	Mercado			= case when rs.rstipoper = 'vcp' then 'BCUP'		else 'BVEN'			end
										,	Rut				= case when rs.rstipoper = 'vcp' then rs.rsrutemis	else rs.rsrutcli	end
										,	Codigo			= case when rs.rstipoper = 'vcp' then 1				else rs.rscodcli	end
										,	Moneda			= case when rs.rstipoper = 'vcp' then rs.rsmonemi	else rs.rsmonpag	end
										,	MedioPago		= case when rs.rstipoper = 'vcp' then 122			else 122			end
										,	Monto			= case when rs.rstipoper = 'vcp' then rs.rsflujo	else rs.rsvppresenx	end
										,	Ingreso			= rs.rsfecpro
										,	Liquidacion		= rs.rsfecpro --> rsfecvcto
										,	Operador		= 'AUTOMATICO' --< 'VCUP'
										,	CargoAbono		= case	when rs.rstipoper = 'vcp' and rs.rsrutemis =  97023000 then 'A'
																	when rs.rstipoper = 'vcp' and rs.rsrutemis <> 97023000 then 'C'
																	else 'C' --> case when rs.rstipoper = 'CP' then 'C' else 'A' end
																end
									from	BacBonosExtsuda.dbo.Text_Rsu rs with(nolock)
									where	rs.rsfecpro		= @dFechaProceso --> between '20110101' and '20140609' -- 
									and		rs.rstipoper	= 'VCP'

										union

									select	Folio			= rs.rsnumdocu
										,	Tipo			= rs.rstipoper
										,	Mercado			= case when rs.rstipoper = 'vcp' then 'BCUP'		else 'BVEN'			end
										,	Rut				= case when rs.rstipoper = 'vcp' then rs.rsrutemis	else rs.rsrutcli	end
										,	Codigo			= case when rs.rstipoper = 'vcp' then 1				else rs.rscodcli	end
										,	Moneda			= case when rs.rstipoper = 'vcp' then rs.rsmonemi	else rs.rsmonpag	end
										,	MedioPago		= case when rs.rstipoper = 'vcp' then 122			else 122			end
										,	Monto			= case when rs.rstipoper = 'vcp' then rs.rsflujo	else rs.rsvppresenx	end
										,	Ingreso			= rs.rsfecpro
										,	Liquidacion		= rs.rsfecvcto
										,	Operador		= 'AUTOMATICO' --> 'VCUP'
										,	CargoAbono		= case	when rs.rstipoper = 'vcp' and rs.rsrutemis =  97023000 then 'A'
																	when rs.rstipoper = 'vcp' and rs.rsrutemis <> 97023000 then 'C'
																	else 'C' --> case when rs.rstipoper = 'CP' then 'C' else 'A' end
																end
									from	BacBonosExtsuda.dbo.Text_Rsu rs with(nolock)
									where	rs.rsfecvcto	= @dFechaProceso
									and		rs.rstipoper	= 'V'
									and		rs.rsfecpro		= rs.rsfecvcto
								)	Bex
								left join	(	select	clrut, clcodigo, clnombre, cltipcli
													,	IdCliente = ltrim(rtrim( clrut )) + ltrim(rtrim( cldv ))
												from	BacParamSuda.dbo.Cliente with(nolock)
											)	clie	on clie.clrut = Bex.Rut and clie.clcodigo = Bex.codigo

								left join	(	select	codigo, glosa, diasvalor
												from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
											)	MPago	On MPago.codigo = Bex.MedioPago
														
								left join	(	select	mncodmon, mnnemo
												from	BacParamSuda.dbo.Moneda with(nolock)
											)	Moneda	On Moneda.mncodmon	= Bex.Moneda
					) Invex

			set		@nFilas = @@RowCount
			if @bMostrarMensajes = 1
			print '			<< C A R G A - I N V E X >>			' + ltrim(rtrim( @nFilas )) + ' Filas Afectadas '			
	end



	if @bMostrarMensajes = 1
	begin
		print ''
		print ''
		print '<< F I N - P R O C E S O >>'
		print '---------------------------------'
		print ''
		print ''
	end

	if @bMostrarResultado = 1
	begin
		select	*
		from	dbo.Liquidaciones_SOS
		where	@dFechaProceso		 = case when @bMostrarLoCargado = 1 then FechaCarga else FechaDeLaLiquidacion end
	end

end
GO

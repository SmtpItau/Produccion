USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S011_Vencimientos]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S011_Vencimientos]
   (   @FechaDesde        DATETIME
   ,   @FechaHasta        DATETIME
   ,   @MedaDistibucion   INT = 1
   )
as
begin

	set nocount on

	DECLARE @dFechaProceso		DATETIME        
		SET @dFechaProceso		= ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE @dFechaAnterior		DATETIME        
		SET @dFechaAnterior		= ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	declare @dFechaDesde		datetime
		set @dFechaDesde		= @FechaDesde

	declare @dFechaHasta		datetime
		set	@dFechaHasta		= @FechaHasta

	-->		Inicio Producto Forward
	select	[Rut_Cliente]			=	CONVERT(CHAR(20), cliente.rut )
		,	[Producto]				=	CONVERT(CHAR(40), prod.producto )
		,	[Monto_CLP]				=	CONVERT(CHAR(60), FORMAT(Forward.Pesos,		'F2', 'es-cl'))
		,	[Monto_USD]				=	CONVERT(CHAR(60), FORMAT(Forward.Dolares,	'F2', 'es-cl'))
		,	[Monto_Transaccion]		=	CONVERT(CHAR(60), FORMAT(Forward.camtomon1,	'F2', 'es-cl'))
		,	[Moneda_Transaccion]	=	CONVERT(CHAR(6),  Mon.moneda)
		,	[Moneda_Conversión]		=	CONVERT(CHAR(6),  Cnv.Moneda)
		,	[Operador]				=	CONVERT(CHAR(20), Usuario.Rut)
		,	[Fecha_Emision]			=	CONVERT(VARCHAR(10), Forward.cafecha,	126)
		,	[Fecha_Vencimiento]		=	CONVERT(VARCHAR(10), Forward.cafecvcto,	126)	-->	cafecEfectiva
		,	[Folio]					=	Forward.canumoper
	from	(	-->		Cartera Vigente, ingresada hoy
				select	cartera			= 'vigente'
					,	car.canumoper
					,	car.cacodigo,	car.cacodcli,	car.cacodpos1
					,	car.cacodmon1,	car.cacodmon2
					,	car.camtomon1,	car.camtomon2,	car.caequmon1, car.caequusd1
					,	car.caoperador
					,	car.cafecha,	car.cafecvcto,	car.cafecEfectiva
					,	Dolares			= case car.cacodpos1 when 2 then car.camtomon2 else car.caequusd1 end
					,	Pesos			= car.caequmon1
				from	BacFwdSuda.dbo.mfca car with(nolock)
				where	cafecha			= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))

					union
				-->		Cartera Modificada
				select	cartera			= 'modificada'
					,	car.canumoper
					,	car.cacodigo,	car.cacodcli,	car.cacodpos1
					,	car.cacodmon1,	car.cacodmon2
					,	car.camtomon1,	car.camtomon2,	car.caequmon1, car.caequusd1
					,	car.caoperador
					,	car.cafecha,	car.cafecvcto,	car.cafecEfectiva
					,	Dolares			= case car.cacodpos1 when 2 then car.camtomon2 else car.caequusd1 end
					,	Pesos			= car.caequmon1
				from	BacFwdSuda.dbo.mfca car with(nolock)
						inner join 
						(	select	canumoper
								,	cafecha
							from	bacfwdsuda.dbo.mfca_log with(nolock)
							where	cafecmod	= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
							and		caantici	= ''
							and		caestado	= 'M'
						)	modif	On modif.canumoper = car.canumoper

					union
				-->		Cartera Anticipada
				select	cartera			= 'anticipada'
					,	car.canumoper
					,	car.cacodigo,	car.cacodcli,	car.cacodpos1
					,	car.cacodmon1,	car.cacodmon2
					,	car.camtomon1,	car.camtomon2,	car.caequmon1, car.caequusd1
					,	car.caoperador
					,	modif.cafecha,	car.cafecvcto,	car.cafecEfectiva
					,	Dolares			= case car.cacodpos1 when 2 then car.camtomon2 else car.caequusd1 end
					,	Pesos			= car.caequmon1
				from	BacFwdSuda.dbo.mfca car with(nolock)
						inner join
						(	select	canumoper
								,	cafecha
							from	bacfwdsuda.dbo.mfca_log with(nolock)
							where	cafecmod	= (select acfecproc from bacfwdsuda.dbo.mfac with(nolock))
							and		caantici	= 'A'
							and		caestado	= 'A'
						)	modif	On modif.canumoper = car.canumoper
			)	Forward

			inner join
			(	select	clrut, clcodigo, cldv, Rut = upper( ltrim(rtrim( clrut )) + ltrim(rtrim( cldv )) )
				from	BacParamSuda.dbo.Cliente with(nolock)
			)	cliente	On	cliente.clrut		= Forward.cacodigo
						and	cliente.clcodigo	= Forward.cacodcli
			left join
			(	select	Id = codigo_producto, Producto = descripcion
				from	BacParamSuda.dbo.Producto with(nolock)
				where	id_sistema	= 'BFW'
			)	prod	On	prod.Id	= Forward.cacodpos1

			left join
			(	select	Id = mncodmon, Moneda = mnnemo
				from	BacparamSuda.dbo.Moneda	with(nolock)
			)	Mon		On Mon.Id = Forward.cacodmon1

			left join
			(	select	Id = mncodmon, Moneda = mnnemo
				from	BacparamSuda.dbo.Moneda	with(nolock)
			)	Cnv		On Cnv.Id = Forward.cacodmon1

			left join
			(	select	Usuario	= usuario
					,	Rut		= case	when RutUsuario = '' then ''
										else upper( replace(RutUsuario, '-', '') )
									end
				from	BacParamSuda.dbo.Usuario with(nolock)
			)	Usuario	On Usuario.Usuario = Forward.caoperador

			inner join
			(	select	Id	= ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg = case	when @MedaDistibucion = 1 then 9000
										else 9001
									end
			)	oper	On oper.Id	= Forward.caoperador
	-->		Fin Producto Forward

		union
	-->		inicio Producto Swap
	select	[Rut_Cliente]			= clien.Rut
		,	[Producto]				= Prod.Producto
		,	[Monto_CLP]				= CONVERT(CHAR(60), FORMAT(BacParamSuda.dbo.fx_convierte_monto(Swap.Fecha, Swap.Moneda, Swap.Monto, 999), 'F2', 'es-cl'))
		,	[Monto_USD]				= CONVERT(CHAR(60), FORMAT(BacParamSuda.dbo.fx_convierte_monto(Swap.Fecha, Swap.Moneda, Swap.Monto, 13) , 'F2', 'es-cl'))
		,	[Monto_Transaccion]		= CONVERT(CHAR(60), FORMAT(Swap.Monto , 'F2', 'es-cl'))
		,	[Moneda_Transaccion]	= CONVERT(CHAR(6),  Mon.Moneda)
		,	[Moneda_Conversión]		= CONVERT(CHAR(6),  Cnv.Moneda)
		,	[Operador]				= CONVERT(CHAR(20), usuar.Rut)
		,	[Fecha_Emision]			= CONVERT(VARCHAR(10), Swap.Fecha, 126)
		,	[Fecha_Vencimiento]		= CONVERT(VARCHAR(10), Swap.Termino, 126)
		,	[Folio]					= Swap.Contrato
	from	(	-->		Ingresos del Día
				select	cartera			= 'vigente'
					,	Fecha			= car.fecha_cierre
					,	Contrato		= car.numero_operacion
					,	Rut				= car.rut_cliente
					,	Codigo			= car.codigo_cliente
					,	Producto		= car.tipo_swap
					,	Moneda			= car.compra_moneda
					,	MonedaCnv		= SwapPas.venta_moneda
					,	Monto			= car.compra_capital
					,	Termino			= car.fecha_termino
					,	Traders			= car.operador
				from	bacswapsuda.dbo.cartera car with(nolock)
						inner join
						(	select	Contrato	= numero_operacion
								,	flujo		= min( numero_flujo )
								,	Tipo		= tipo_flujo
							from	bacswapsuda.dbo.cartera with(nolock)
							where	fecha_cierre= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		estado		= ''
							and		tipo_flujo	= 1
							group 
							by		numero_operacion
								,	tipo_flujo
						)	SwapAct	On	SwapAct.Contrato = car.numero_operacion
									and	SwapAct.flujo	 = car.numero_flujo
									and SwapAct.Tipo	 = car.tipo_flujo
						inner join
						(	select	numero_operacion, venta_moneda
							from	bacswapsuda.dbo.cartera with(nolock)
							where	fecha_cierre= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		estado		= ''
							and		tipo_flujo	= 2
							group 
							by		numero_operacion, venta_moneda
						)	SwapPas	On SwapPas.numero_operacion	= car.numero_operacion
				where	car.fecha_cierre= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
				-->		Ingresos del Día
					union
				-->		Modificaciones del Dia
				select	cartera			= 'modificada'
					,	Fecha			= car.fecha_cierre
					,	Contrato		= car.numero_operacion
					,	Rut				= car.rut_cliente
					,	Codigo			= car.codigo_cliente
					,	Producto		= car.tipo_swap
					,	Moneda			= car.compra_moneda
					,	MonedaCnv		= SwapPas.venta_moneda
					,	Monto			= car.compra_capital
					,	Termino			= car.fecha_termino
					,	Traders			= car.operador
				from	bacswapsuda.dbo.cartera car with(nolock)
						inner join
						(	select	Folio		= numero_operacion
								,	Flujo		= min( numero_flujo )
								,	Tipo		= tipo_flujo
								,	estado		= estado
								,	Cierre		= fecha_cierre
								,	Modifica	= fecha_modifica
							from	bacswapsuda.dbo.carteralog with(nolock)
							where	fecha_modifica	= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		fecha_cierre	< fecha_modifica
							and		estado			= 'M'
							and		tipo_flujo		= 1
							group
							by		numero_operacion
								,	tipo_flujo
								,	estado
								,	fecha_cierre
								,	fecha_modifica
						)	SwapAct	On	SwapAct.Folio	= car.numero_operacion
									and	SwapAct.Flujo	= car.numero_flujo
									and	SwapAct.Tipo	= car.tipo_flujo

						inner join
						(	select	numero_operacion, venta_moneda
							from	bacswapsuda.dbo.carteralog with(nolock)
							where	fecha_modifica	= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		fecha_cierre	< fecha_modifica
							and		estado			= 'M'
							and		tipo_flujo		= 2
							group 
							by		numero_operacion, venta_moneda
						)	SwapPas	On SwapPas.numero_operacion	= car.numero_operacion
					-->		Modificaciones del Dia
					union
					-->		Anticipos del Dia
				select	cartera			= 'anticipada'
					,	Fecha			= car.fecha_cierre
					,	Contrato		= car.numero_operacion
					,	Rut				= car.rut_cliente
					,	Codigo			= car.codigo_cliente
					,	Producto		= car.tipo_swap
					,	Moneda			= car.compra_moneda
					,	MonedaCnv		= SwapPas.venta_moneda
					,	Monto			= car.compra_capital
					,	Termino			= car.fecha_termino
					,	Traders			= car.operador
				from	bacswapsuda.dbo.cartera car with(nolock)
						inner join
						(	select  numero_operacion, estado, fecha_cierre, fechaanticipo
							from	bacswapsuda.dbo.cartera_unwind with(nolock)
							where	fechaanticipo		= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		tipo_flujo			= 1
							and		estado				= 'N'
							group
							by		numero_operacion, estado, fecha_cierre, fechaanticipo
						)	SwapAct	on	SwapAct.numero_operacion = car.numero_operacion

						inner join
						(	select  numero_operacion, estado, fecha_cierre, fechaanticipo, venta_moneda
							from	bacswapsuda.dbo.cartera_unwind with(nolock)
							where	fechaanticipo		= (select fechaproc from bacswapsuda.dbo.swapgeneral with(nolock))
							and		tipo_flujo			= 2
							and		estado				= 'N'
							group
							by		numero_operacion, estado, fecha_cierre, fechaanticipo, venta_moneda
						)	SwapPas	on	SwapPas.numero_operacion = car.numero_operacion
				where	car.tipo_flujo		= 1
			)	Swap

			inner join
			(	select	clrut, clcodigo
					,	Rut = upper( ltrim(rtrim( clrut )) + ltrim(rtrim( cldv )) )
				from	BacParamSuda.dbo.cliente with(nolock)
			)	clien	On	clien.clrut		= Swap.Rut
						and	clien.clcodigo	= Swap.Codigo

			inner join
			(	select	Id	= 1, Producto = 'SWAP DE TASAS'	union
				select	Id	= 2, Producto = 'SWAP DE MONEDAS' union
				select	Id	= 4, Producto = 'SWAP PROMEDIO CAMARA' union
				select	Id	= 3, Producto = 'FRA'
			)	Prod	On	Prod.Id	= Swap.Producto

			left join
			(	select	Id			= mncodmon
					,	Moneda		= mnnemo
					,	Mnrrda		= mnrrda
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	Mon		On Mon.Id	= Swap.Moneda

			left join
			(	select	Id			= mncodmon
					,	Moneda		= mnnemo
					,	Mnrrda		= mnrrda
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	Cnv		On Cnv.Id	= Swap.MonedaCnv

			inner join
			(	select	Id	= usuario
					,	Rut	= upper(replace(RutUsuario, '-', ''))
				from	BacParamSuda.dbo.Usuario with(nolock)
			)	usuar	On usuar.Id	= Swap.Traders

			inner join
			(	select	Id	= ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle with(nolock)
				where	tbcateg = case	when @MedaDistibucion = 1 then 9000
										else 9001
									end
			)	oper	On oper.Id	= Swap.Traders
	-->		Fin Producto Swap

		union
	-->		Inicio Producto Opciones
	select	[Rut_Cliente]			= clien.Rut
		,	[Producto]				= Prod.Nombre
		,	[Monto_CLP]				= CONVERT(CHAR(60), FORMAT( Opt.Pesos, 'F2', 'es-cl'))
		,	[Monto_USD]				= CONVERT(CHAR(60), FORMAT( Opt.Dolares, 'F2', 'es-cl'))
		,	[Monto_Transaccion]		= CONVERT(CHAR(60), FORMAT(	Opt.Monto, 'F2', 'es-cl'))
		,	[Moneda_Transaccion]	= CONVERT(CHAR(6),  Mon.Moneda)
		,	[Moneda_Conversión]		= CONVERT(CHAR(6),  Cnv.Moneda)
		,	[Operador]				= CONVERT(CHAR(20), usuar.Rut)
		,	[Fecha_Emision]			= CONVERT(VARCHAR(10), Opt.Fecha, 126)
		,	[Fecha_Vencimiento]		= CONVERT(VARCHAR(10), Opt.Termino, 126)
		,	[Folio]					= Opt.Contrato
	from	(	-->		Ingresos del Día
				select	Crtera		= 'vigente'
					,	Fecha		= car.cafechacontrato
					,	Contrato	= car.canumcontrato
					,	Rut			= car.carutcliente
					,	Codigo		= car.cacodigo
					,	Producto	= car.cacodestructura
					,	Moneda		= det.Moneda
					,	MonedaCnv	= det.MonedaCnv
					,	Monto		= det.Monto
					,	Pesos		= det.Pesos
					,	Dolares		= det.Dolares
					,	Termino		= det.Termino
					,	Traders		= car.caoperador
				from	LNKOPC.cbmdbopc.dbo.caenccontrato car with(nolock) 
						inner join
						(	select  Folio		= canumcontrato
								,	Monto		= sum( camontomon1 )
								,	Pesos		= sum( camontomon2 ) 
								,	Dolares		= sum( camontomon1 )
								,	Moneda		= cacodmon1
								,	MonedaCnv	= cacodmon1
								,	Emision		= cafechainicioopc
								,	Termino		= cafechavcto
							from	LNKOPC.cbmdbopc.dbo.cadetcontrato with(nolock)
							where	cafechainicioopc	= ( select fechaproc from LNKOPC.cbmdbopc.dbo.opcionesgeneral with(nolock) )
							group
							by		cafechainicioopc
								,	canumcontrato
								,	cacodmon1
								,	cacodmon1
								,	cafechavcto
						)	det		On det.Folio	= car.canumcontrato
				where	car.cafechacontrato = ( select fechaproc from LNKOPC.cbmdbopc.dbo.opcionesgeneral with(nolock) )
				-->		Ingresos del Día
					union
				-->		Modificaciones del Día
				select	Crtera		= 'modificada'
					,	Fecha		= car.cafechacontrato
					,	Contrato	= car.canumcontrato
					,	Rut			= car.carutcliente
					,	Codigo		= car.cacodigo
					,	Producto	= car.cacodestructura
					,	Moneda		= det.Moneda
					,	MonedaCnv	= det.MonedaCnv
					,	Monto		= det.Monto
					,	Pesos		= det.Pesos
					,	Dolares		= det.Dolares
					,	Termino		= det.Termino
					,	Traders		= car.caoperador
				from	LNKOPC.cbmdbopc.dbo.caenccontrato car with(nolock) 
						inner join
						(	select  Folio		= canumcontrato
								,	Monto		= sum( camontomon1 )
								,	Pesos		= sum( camontomon2 ) 
								,	Dolares		= sum( camontomon1 )
								,	Moneda		= cacodmon1
								,	MonedaCnv	= cacodmon1
								,	Emision		= cafechainicioopc
								,	Termino		= cafechavcto
							from	LNKOPC.cbmdbopc.dbo.cadetcontrato det
									inner join
									(	select	Contrato = monumcontrato
											,	Folio	 = max(monumfolio)
										from	LNKOPC.cbmdbopc.dbo.moenccontrato 
										where	motipotransaccion = 'MODIFICA'
										group 
										by		monumcontrato
									)	modi	On modi.Contrato	= det.canumcontrato
							group
							by		cafechainicioopc
								,	canumcontrato
								,	cacodmon1
								,	cacodmon1
								,	cafechavcto
						)	det		On det.Folio	= car.canumcontrato
				-->		Modificaciones del Día
					union
				-->		Anticipos del Día
				select	Crtera		= 'anticipada'
					,	Fecha		= car.cafechacontrato
					,	Contrato	= car.canumcontrato
					,	Rut			= car.carutcliente
					,	Codigo		= car.cacodigo
					,	Producto	= car.cacodestructura
					,	Moneda		= det.Moneda
					,	MonedaCnv	= det.MonedaCnv
					,	Monto		= det.Monto
					,	Pesos		= det.Pesos
					,	Dolares		= det.Dolares
					,	Termino		= det.Termino
					,	Traders		= car.caoperador
				from	LNKOPC.cbmdbopc.dbo.caenccontrato car with(nolock) 
						inner join
						(	select  Folio		= canumcontrato
								,	Monto		= sum( camontomon1 )
								,	Pesos		= sum( camontomon2 ) 
								,	Dolares		= sum( camontomon1 )
								,	Moneda		= cacodmon1
								,	MonedaCnv	= cacodmon1
								,	Emision		= cafechainicioopc
								,	Termino		= cafechavcto
							from	LNKOPC.cbmdbopc.dbo.cadetcontrato det
									inner join
									(	select	Contrato = monumcontrato
											,	Folio	 = max(monumfolio)
										from	LNKOPC.cbmdbopc.dbo.moenccontrato 
										where	motipotransaccion = 'EJERCE'
										group 
										by		monumcontrato
									)	modi	On modi.Contrato	= det.canumcontrato
							group
							by		cafechainicioopc
								,	canumcontrato
								,	cacodmon1
								,	cacodmon1
								,	cafechavcto
						)	det		On det.Folio	= car.canumcontrato
				-->		Anticipos del Día
			)	Opt

			inner join
			(	select	clrut, clcodigo
					,	Rut = upper( ltrim(rtrim( clrut )) + ltrim(rtrim( cldv )) )
				from	BacParamSuda.dbo.cliente with(nolock)
			)	clien	On	clien.clrut		= Opt.Rut
						and	clien.clcodigo	= Opt.Codigo

			inner join
			(	select	Id			= OpcEstCod
					,	Nombre		= upper( OpcEstDsc )
				from	LNKOPC.cbmdbopc.dbo.OpcionEstructura with(nolock)
			)	prod	On prod.Id	= Opt.Producto

			left join
			(	select	Id			= mncodmon
					,	Moneda		= mnnemo
					,	Mnrrda		= mnrrda
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	Mon		On Mon.Id	= Opt.Moneda

			left join
			(	select	Id			= mncodmon
					,	Moneda		= mnnemo
					,	Mnrrda		= mnrrda
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	Cnv		On Cnv.Id	= Opt.MonedaCnv

			inner join
			(	select	Id	= usuario
					,	Rut	= upper(replace(RutUsuario, '-', ''))
				from	BacParamSuda.dbo.Usuario with(nolock)
			)	usuar	On usuar.Id	= Opt.Traders

			inner join
			(	select	Id	= ltrim(rtrim( tbglosa ))
				from	bacparamsuda.dbo.tabla_general_detalle 
				where	tbcateg = case	when @MedaDistibucion = 1 then 9000
										else 9001
									end
			)	oper	On oper.Id	= Opt.Traders
	-->		Fin Producto Opciones

	order
	by		Fecha_Vencimiento
		,	Rut_Cliente
		,	Producto

end

GO

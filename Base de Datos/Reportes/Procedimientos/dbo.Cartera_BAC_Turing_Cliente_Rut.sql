USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Cartera_BAC_Turing_Cliente_Rut]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cartera_BAC_Turing_Cliente_Rut]
(

		@rut_rut				int = 0
	,	@rut_dv					int = 0

	,	@ConForward				int = 1
	,	@ConSwap				int = 1
	,	@ConSpot				int = 1
	,	@ConOpciones			int = 1
	,	@ConRentaFijaNacional	int = 1
	,	@ConBonex				int = 1
		
	,	@ConVigentes			int = 1
	,	@ConHistoricos			int = 0
	,	@ConAnulados			int = 0

	,	@FechaRevisarMin		datetime = ''
	,	@FechaRevisarMax		datetime = ''
)
AS
BEGIN

	-----------------------------------------------------------------------------
	------------------------------Tablas Temporales y Variables------------------
	-----------------------------------------------------------------------------
	--IF OBJECT_ID('tempdb..#AuxCartera') IS NOT NULL DROP TABLE #AuxCartera
	--IF OBJECT_ID('tempdb..#ruts')		IS NOT NULL DROP TABLE #ruts


	create table #AuxCartera(
		sistema					nvarchar(max),
		orden					nvarchar(max),
		rut						nvarchar(max),
		CodigoBac				nvarchar(max),
		CodigoItau				nvarchar(max),
		NombreCliente			nvarchar(max),
		numerooperacion			nvarchar(max),
		NumeroDocumento			nvarchar(max),
		Correlativo				nvarchar(max),
		NominalActivo			nvarchar(max),
		MonedaActiva			nvarchar(max),
		NominalPasivo			nvarchar(max),
		MonedaPasivo			nvarchar(max),
		Estado					nvarchar(max),
		FechaInicio				datetime,
		FechaFin				datetime,
		SubProducto				nvarchar(max),
		Operador				nvarchar(max),
		Cartera_Financiera_1	nvarchar(max),
		Cartera_Financiera_2	nvarchar(max),
		Libro					nvarchar(max),
		Cartera_Super			nvarchar(max),
		Sub_Cartera_Super		nvarchar(max),
		CodigoAS400				nvarchar(max)
	)
	create table #ruts(
		rut		int,
		codigo	int
	)

	delete from #AuxCartera
	delete from #ruts


	-----------------------------------------------------------------------------
	------------------------------Rut por Revisar--------------------------------
	-----------------------------------------------------------------------------
	insert into #ruts values
	(@rut_rut,@rut_dv)

	-----------------------------------------------------------------------------
	------------------------------Forward Suda Cartera---------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					sistema					=	'Forward'
				,	orden					=	1
				,	rut						=	CACODIGO
				,	CodigoBac				=	cacodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), canumoper )
				,	NumeroDocumento			=	var_moneda2
				,	Correlativo				=	''
				,	NominalActivo			=	camtomon1
				,	MonedaActiva			=	cacodmon1
				,	NominalPasivo			=	camtomon2
				,	MonedaPasivo			=	cacodmon2
				,	Estado					=	caestado
				,	FechaInicio				=	cafecha
				,	FechaFin				=	cafecvcto
				,	SubProducto				=	prod.descripcion
				,	Operador				=	car.caoperador
				,	Cartera_Financiera_1	=	cacodcart
				,	Cartera_Financiera_2	=	cacodcart
				,	Libro					=	calibro
				,	Cartera_Super			=	cacartera_normativa
				,	Sub_Cartera_Super		=	casubcartera_normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				Bacfwdsuda.DBO.MFCA car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConForward = 1
													and	car.cacodigo = case when ruts.rut	 > 0	then ruts.rut		else car.cacodigo end
													and car.cacodcli = case when ruts.codigo > 0	then ruts.codigo	else car.cacodcli end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.cacodpos1 = prod.codigo_producto and prod.id_sistema = 'BFW'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cacodigo = cl.clrut and car.cacodcli = cl.clcodigo
	where		@ConVigentes = 1
			and	car.caestado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	cafecha		>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	cafecvcto	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)

	-------------------------------------------------------------------------------
	--------------------------------Forward Suda HIST------------------------------
	-------------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Forward Hist'
				,	orden					=	1
				,	rut						=	CACODIGO
				,	CodigoBac				=	cacodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), canumoper )
				,	NumeroDocumento			=	var_moneda2
				,	Correlativo				=	''
				,	NominalActivo			=	camtomon1
				,	MonedaActiva			=	cacodmon1
				,	NominalPasivo			=	camtomon2
				,	MonedaPasivo			=	cacodmon2
				,	Estado					=	caestado
				,	FechaInicio				=	cafecha
				,	FechaFin				=	cafecvcto
				,	SubProducto				=	prod.descripcion
				,	Operador				=	car.caoperador
				,	Cartera_Financiera_1	=	cacodcart
				,	Cartera_Financiera_2	=	cacodcart
				,	Libro					=	calibro
				,	Cartera_Super			=	cacartera_normativa
				,	Sub_Cartera_Super		=	casubcartera_normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				Bacfwdsuda.DBO.mfcah car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConForward = 1
													and	car.cacodigo = case when ruts.rut    > 0	then ruts.rut		else car.cacodigo end
													and car.cacodcli = case when ruts.codigo > 0	then ruts.codigo	else car.cacodcli end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.cacodpos1 = prod.codigo_producto and prod.id_sistema = 'BFW'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cacodigo = cl.clrut and car.cacodcli = cl.clcodigo
	where		@ConHistoricos = 1
			and	car.caestado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	cafecha		>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	cafecvcto	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)

	-----------------------------------------------------------------------------
	------------------------------Forward NY-------------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Forward NY'
				,	orden					=	1
				,	rut						=	CACODIGO
				,	CodigoBac				=	cacodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), canumoper )
				,	NumeroDocumento			=	var_moneda2
				,	Correlativo				=	''
				,	NominalActivo			=	camtomon1
				,	MonedaActiva			=	cacodmon1
				,	NominalPasivo			=	camtomon2
				,	MonedaPasivo			=	cacodmon2
				,	Estado					=	caestado
				,	FechaInicio				=	cafecha
				,	FechaFin				=	cafecvcto
				,	SubProducto				=	prod.descripcion
				,	Operador				=	car.caoperador
				,	Cartera_Financiera_1	=	cacodcart
				,	Cartera_Financiera_2	=	cacodcart
				,	Libro					=	calibro
				,	Cartera_Super			=	cacartera_normativa
				,	Sub_Cartera_Super		=	casubcartera_normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacFwdNY.DBO.MFCA car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConForward = 1
													and	car.cacodigo = case when ruts.rut	 > 0	then ruts.rut		else car.cacodigo end
													and car.cacodcli = case when ruts.codigo > 0	then ruts.codigo	else car.cacodcli end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.cacodpos1 = prod.codigo_producto and prod.id_sistema = 'BFW'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cacodigo = cl.clrut and car.cacodcli = cl.clcodigo
	where		@ConVigentes = 1
			and	car.caestado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	cafecha		>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	cafecvcto	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)

	-----------------------------------------------------------------------------
	------------------------------Forward NY HISTORICO---------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Forward NY Hist'
				,	orden					=	1
				,	rut						=	CACODIGO
				,	CodigoBac				=	cacodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), canumoper )
				,	NumeroDocumento			=	var_moneda2
				,	Correlativo				=	''
				,	NominalActivo			=	camtomon1
				,	MonedaActiva			=	cacodmon1
				,	NominalPasivo			=	camtomon2
				,	MonedaPasivo			=	cacodmon2
				,	Estado					=	caestado
				,	FechaInicio				=	cafecha
				,	FechaFin				=	cafecvcto
				,	SubProducto				=	prod.descripcion
				,	Operador				=	car.caoperador
				,	Cartera_Financiera_1	=	cacodcart
				,	Cartera_Financiera_2	=	cacodcart
				,	Libro					=	calibro
				,	Cartera_Super			=	cacartera_normativa
				,	Sub_Cartera_Super		=	casubcartera_normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacFwdNY.DBO.mfcah car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConForward = 1
													and	car.cacodigo = case when ruts.rut    > 0	then ruts.rut		else car.cacodigo end
													and car.cacodcli = case when ruts.codigo > 0	then ruts.codigo	else car.cacodcli end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.cacodpos1 = prod.codigo_producto and prod.id_sistema = 'BFW'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cacodigo = cl.clrut and car.cacodcli = cl.clcodigo
	where		@ConHistoricos = 1
			and	car.caestado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	cafecha		>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	cafecvcto	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)

	-------------------------------------------------------------------------------
	--------------------------------Swap Suda--------------------------------------
	-------------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Swap'
				,	orden					=	2
				,	rut						=	rut_cliente
				,	CodigoBac				=	codigo_cliente
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), numero_operacion )
				,	NumeroDocumento			=	numero_flujo
				,	Correlativo				=	tipo_flujo
				,	NominalActivo			=	compra_capital + compra_amortiza
				,	MonedaActiva			=	compra_moneda
				,	NominalPasivo			=	venta_capital + venta_amortiza
				,	MonedaPasivo			=	venta_moneda
				,	Estado					=	car.Estado
				,	FechaInicio				=	fecha_cierre
				,	FechaFin				=	fecha_termino
				,	SubProducto				=	pr.descripcion
				,	Operador				=	car.operador
				,	Cartera_Financiera_1	=	cartera_inversion
				,	Cartera_Financiera_2	=	cartera_inversion
				,	Libro					=	car_Libro
				,	Cartera_Super			=	car_Cartera_Normativa
				,	Sub_Cartera_Super		=	car_SubCartera_Normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacSwapSuda.DBO.cartera car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConSwap = 1
													and	car.rut_cliente    = case when ruts.rut    > 0	then ruts.rut		else car.rut_cliente	end
													and car.codigo_cliente = case when ruts.codigo > 0	then ruts.codigo	else car.codigo_cliente end
			inner join	bacparamsuda.dbo.producto pr	with (nolock)  on pr.id_sistema='pcs' and convert(char(5), pr.codigo_producto) = case	when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='1' then convert(char(5), ltrim(rtrim('ST')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='2' then convert(char(5), ltrim(rtrim('SM')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='3' then convert(char(5), ltrim(rtrim('FR')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='4' then convert(char(5), ltrim(rtrim('SP')))
																  																			end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.rut_cliente = cl.clrut and car.codigo_cliente = clcodigo
	where		@ConVigentes = 1
			and	car.estado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	fecha_cierre	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	fecha_termino	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)
			and car.estado not in ('C')


	-----------------------------------------------------------------------------
	------------------------------Swap Suda Hist---------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Swap Hist'
				,	orden					=	2
				,	rut						=	rut_cliente
				,	CodigoBac				=	codigo_cliente
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), numero_operacion )
				,	NumeroDocumento			=	numero_flujo
				,	Correlativo				=	tipo_flujo
				,	NominalActivo			=	compra_capital + compra_amortiza
				,	MonedaActiva			=	compra_moneda
				,	NominalPasivo			=	venta_capital + venta_amortiza
				,	MonedaPasivo			=	venta_moneda
				,	Estado					=	car.Estado
				,	FechaInicio				=	fecha_cierre
				,	FechaFin				=	fecha_termino
				,	SubProducto				=	pr.descripcion
				,	Operador				=	car.operador
				,	Cartera_Financiera_1	=	cartera_inversion
				,	Cartera_Financiera_2	=	cartera_inversion
				,	Libro					=	chi_Libro
				,	Cartera_Super			=	chi_Cartera_Normativa
				,	Sub_Cartera_Super		=	chi_SubCartera_Normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacSwapSuda.DBO.CarteraHis car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConSwap = 1
													and	car.rut_cliente    = case when ruts.rut    > 0	then ruts.rut		else car.rut_cliente	end
													and car.codigo_cliente = case when ruts.codigo > 0	then ruts.codigo	else car.codigo_cliente end
			inner join	bacparamsuda.dbo.producto pr	with (nolock)  on pr.id_sistema='pcs' and convert(char(5), pr.codigo_producto) = case	when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='1' then convert(char(5), ltrim(rtrim('ST')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='2' then convert(char(5), ltrim(rtrim('SM')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='3' then convert(char(5), ltrim(rtrim('FR')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='4' then convert(char(5), ltrim(rtrim('SP')))
																  																			end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.rut_cliente = cl.clrut and car.codigo_cliente = clcodigo
	where		@ConHistoricos = 1
			and	car.estado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	fecha_cierre	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	fecha_termino	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)
			and car.estado not in ('C')

	-----------------------------------------------------------------------------
	------------------------------Swap NY----------------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Swap NY'
				,	orden					=	2
				,	rut						=	rut_cliente
				,	CodigoBac				=	codigo_cliente
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), numero_operacion )
				,	NumeroDocumento			=	numero_flujo
				,	Correlativo				=	tipo_flujo
				,	NominalActivo			=	compra_capital + compra_amortiza
				,	MonedaActiva			=	compra_moneda
				,	NominalPasivo			=	venta_capital + venta_amortiza
				,	MonedaPasivo			=	venta_moneda
				,	Estado					=	car.Estado
				,	FechaInicio				=	fecha_cierre
				,	FechaFin				=	fecha_termino
				,	SubProducto				=	pr.descripcion
				,	Operador				=	car.operador
				,	Cartera_Financiera_1	=	cartera_inversion
				,	Cartera_Financiera_2	=	cartera_inversion
				,	Libro					=	car_Libro
				,	Cartera_Super			=	car_Cartera_Normativa
				,	Sub_Cartera_Super		=	car_SubCartera_Normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacSwapny.DBO.cartera car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConSwap = 1
													and	car.rut_cliente = case when ruts.rut	   > 0	then ruts.rut		else car.rut_cliente	end
													and car.codigo_cliente = case when ruts.codigo > 0	then ruts.codigo	else car.codigo_cliente end
			inner join	bacparamsuda.dbo.producto pr	with (nolock)  on pr.id_sistema='pcs' and convert(char(5), pr.codigo_producto) = case	when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='1' then convert(char(5), ltrim(rtrim('ST')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='2' then convert(char(5), ltrim(rtrim('SM')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='3' then convert(char(5), ltrim(rtrim('FR')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='4' then convert(char(5), ltrim(rtrim('SP')))
																  																	 end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.rut_cliente = cl.clrut and car.codigo_cliente = clcodigo
	where		@ConVigentes = 1
			and	car.estado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	fecha_cierre	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	fecha_termino	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)
			and car.estado not in ('C')


	-----------------------------------------------------------------------------
	------------------------------Swap NY HIST-----------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Swap NY HIST'
				,	orden					=	2
				,	rut						=	rut_cliente
				,	CodigoBac				=	codigo_cliente
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	numerooperacion			=	convert(nvarchar(max), numero_operacion )
				,	NumeroDocumento			=	numero_flujo
				,	Correlativo				=	tipo_flujo
				,	NominalActivo			=	compra_capital + compra_amortiza
				,	MonedaActiva			=	compra_moneda
				,	NominalPasivo			=	venta_capital + venta_amortiza
				,	MonedaPasivo			=	venta_moneda
				,	Estado					=	car.Estado
				,	FechaInicio				=	fecha_cierre
				,	FechaFin				=	fecha_termino
				,	SubProducto				=	pr.descripcion
				,	Operador				=	car.operador
				,	Cartera_Financiera_1	=	cartera_inversion
				,	Cartera_Financiera_2	=	cartera_inversion
				,	Libro					=	chi_Libro
				,	Cartera_Super			=	chi_Cartera_Normativa
				,	Sub_Cartera_Super		=	chi_SubCartera_Normativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				BacSwapny.DBO.carterahis car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConSwap = 1
													and	car.rut_cliente = case when ruts.rut	   > 0	then ruts.rut		else car.rut_cliente	end
													and car.codigo_cliente = case when ruts.codigo > 0	then ruts.codigo	else car.codigo_cliente end
			inner join	bacparamsuda.dbo.producto pr	with (nolock)  on pr.id_sistema='pcs' and convert(char(5), pr.codigo_producto) = case	when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='1' then convert(char(5), ltrim(rtrim('ST')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='2' then convert(char(5), ltrim(rtrim('SM')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='3' then convert(char(5), ltrim(rtrim('FR')))
																  																				when convert(char(5), ltrim(rtrim(car.tipo_swap))) ='4' then convert(char(5), ltrim(rtrim('SP')))
																  																	 end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.rut_cliente = cl.clrut and car.codigo_cliente = clcodigo
	where		@ConHistoricos = 1
			and	car.estado not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	fecha_cierre	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	fecha_termino	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)
			and car.estado not in ('C')

	-----------------------------------------------------------------------------
	------------------------------SPOT MEMO--------------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Spot Hoy'
				,	Orden					=	3
				,	RutCliente				=	morutcli
				,	CodigoBacCliente		=	mocodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), monumope )
				,	NumeroDocumento			=	''
				,	Correlativo				=	''
				,	NominalActivo			=	MOMONMO
				,	MonedaActiva			=	MOCODMON
				,	NominalPasivo			=	momonpe
				,	MonedaPasivo			=	MOCODCNV
				,	Estado					=	moestatus
				,	FechaInicio				=	mofech
				,	FechaFin				=	case	when movaluta1 >= movaluta2 then	movaluta1
														else								movaluta2
												end
				,	Producto				=	prod.descripcion
				,	Operador				=	car.mooper
				,	Cartera_Financiera_1	=	''
				,	Cartera_Financiera_2	=	''
				,	Libro					=	''
				,	Cartera_Super			=	''
				,	Sub_Cartera_Super		=	''
				,	CodigoAS400				=	cl.codigo_as400
	FROM				baccamsuda.dbo.memo car with(nolock)
			inner join	#ruts ruts with(nolock) on		@ConSpot = 1
													and	car.morutcli = case when ruts.rut > 0		then ruts.rut		else car.morutcli	end
													and car.mocodcli = case when ruts.codigo > 0	then ruts.codigo	else car.mocodcli	end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.motipmer = prod.codigo_producto and prod.id_sistema = 'BCC'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.morutcli = cl.clrut and car.mocodcli = clcodigo
	where		@ConVigentes = 1
			and	car.MOESTATUS not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	mofech	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and (	case when movaluta1 >= movaluta2 then movaluta1 else movaluta2 end
									<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)


	-----------------------------------------------------------------------------
	------------------------------SPOT HIST--------------------------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Spot Vigente Hist'
				,	Orden					=	3
				,	RutCliente				=	morutcli
				,	CodigoBacCliente		=	mocodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), monumope )
				,	NumeroDocumento			=	''
				,	Correlativo				=	''
				,	NominalActivo			=	MOMONMO
				,	MonedaActiva			=	MOCODMON
				,	NominalPasivo			=	momonpe
				,	MonedaPasivo			=	MOCODCNV
				,	Estado					=	moestatus
				,	FechaInicio				=	mofech
				,	FechaFin				=	case	when movaluta1 >= movaluta2 then	movaluta1
														else								movaluta2
												end
				,	Producto				=	prod.descripcion
				,	Operador				=	car.mooper
				,	Cartera_Financiera_1	=	''
				,	Cartera_Financiera_2	=	''
				,	Libro					=	''
				,	Cartera_Super			=	''
				,	Sub_Cartera_Super		=	''
				,	CodigoAS400				=	cl.codigo_as400
	FROM				baccamsuda.dbo.memoh car with(nolock)
			inner join	BacCamSuda.dbo.meac meac with(nolock) on meac.ACFECPRO = case when movaluta1 <= movaluta2 then movaluta1 else movaluta2 end
			inner join	#ruts ruts with(nolock) on		@ConSpot = 1
													and	car.morutcli = case when ruts.rut > 0		then ruts.rut		else car.morutcli	end
													and car.mocodcli = case when ruts.codigo > 0	then ruts.codigo	else car.mocodcli	end
			inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.motipmer = prod.codigo_producto and prod.id_sistema = 'BCC'
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.morutcli = cl.clrut and car.mocodcli = clcodigo
	where		@ConHistoricos = 1
			and	car.MOESTATUS not in ( case when @ConAnulados = 1 then '.' else 'A' end )
			and	(		(	mofech	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
					and	(	case when movaluta1 >= movaluta2 then movaluta1 else movaluta2 end
									<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
				)

	---------------------------------------------------------------------------
	----------------------------Opciones Suda----------------------------------
	---------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Opciones'
				,	Orden					=	4
				,	RutCliente				=	car.carutcliente
				,	CodigoBacCliente		=	car.cacodigo
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), car.canumcontrato )
				,	NumeroDocumento			=	CaNumEstructura
				,	Correlativo				=	''
				,	NominalActivo			=	CaMontoMon1
				,	MonedaActiva			=	CaCodMon1
				,	NominalPasivo			=	CaMontoMon2
				,	MonedaPasivo			=	CaCodMon2
				,	Estado					=	caestado
				,	FechaInicio				=	car.cafechacontrato
				,	FechaFin				=	det.CaFechaVcto
				,	Producto				=	prod.opcestdsc
				,	Operador				=	car.CaOperador
				,	Cartera_Financiera_1	=	CaCarteraFinanciera
				,	Cartera_Financiera_2	=	CaCarteraFinanciera
				,	Libro					=	CaLibro
				,	Cartera_Super			=	CaCarNormativa
				,	Sub_Cartera_Super		=	CaSubCarNormativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				CbMdbOpc.dbo.CaEncContrato car with(nolock)
			inner join	CbMdbOpc.dbo.CaDetContrato det with(nolock) on car.CaNumContrato = det.CaNumContrato
			inner join	#ruts ruts with(nolock) on		@ConOpciones = 1
													and	car.carutcliente = case when ruts.rut > 0	then ruts.rut		else car.carutcliente	end
													and car.cacodigo = case when ruts.codigo > 0	then ruts.codigo	else car.cacodigo		end
			inner join	cbmdbopc.dbo.opcionestructura  prod with(Nolock) on car.CaCodEstructura = prod.OpcEstCod
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.carutcliente = cl.clrut and car.cacodigo = clcodigo
	where		@ConVigentes = 1 and
			(		(	car.cafechacontrato	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
				and (	det.CaFechaVcto		<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
			)


	-------------------------------------------------------------------------
	--------------------------Opciones NY------------------------------------
	-------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Opciones NY'
				,	Orden					=	4
				,	RutCliente				=	car.carutcliente
				,	CodigoBacCliente		=	car.cacodigo
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), car.canumcontrato )
				,	NumeroDocumento			=	CaNumEstructura
				,	Correlativo				=	''
				,	NominalActivo			=	CaMontoMon1
				,	MonedaActiva			=	CaCodMon1
				,	NominalPasivo			=	CaMontoMon2
				,	MonedaPasivo			=	CaCodMon2
				,	Estado					=	caestado
				,	FechaInicio				=	car.cafechacontrato
				,	FechaFin				=	det.CaFechaVcto
				,	Producto				=	prod.opcestdsc
				,	Operador				=	car.CaOperador
				,	Cartera_Financiera_1	=	CaCarteraFinanciera
				,	Cartera_Financiera_2	=	CaCarteraFinanciera
				,	Libro					=	CaLibro
				,	Cartera_Super			=	CaCarNormativa
				,	Sub_Cartera_Super		=	CaSubCarNormativa
				,	CodigoAS400				=	cl.codigo_as400
	FROM				CbMdbOpcny.dbo.CaEncContrato car with(nolock)
			inner join	CbMdbOpcny.dbo.CaDetContrato det with(nolock) on car.CaNumContrato = det.CaNumContrato
			inner join	#ruts ruts with(nolock) on		@ConOpciones = 1
													and	car.carutcliente = case when ruts.rut > 0	then ruts.rut		else car.carutcliente	end
													and car.cacodigo = case when ruts.codigo > 0	then ruts.codigo	else car.cacodigo		end
			inner join	cbmdbopc.dbo.opcionestructura  prod with(Nolock) on car.CaCodEstructura = prod.OpcEstCod
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.carutcliente = cl.clrut and car.cacodigo = clcodigo
	where	
				@ConVigentes = 1 and
			(		(	car.cafechacontrato	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
				and (	det.CaFechaVcto		<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
			)


	-----------------------------------------------------------------------------
	------------------------------Renta Fija Extranjera Suda---------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Renta Fija Extranjera'
				,	Orden					=	6
				,	RutCliente				=	cprutcart
				,	CodigoBacCliente		=	cpcodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), cpnumdocu)
				,	NumeroDocumento			=	cpnumdocu
				,	Correlativo				=	cpcorrelativo
				,	NominalActivo			=	case	when car.cpnominal > 0 then convert(numeric(30,16), car.cpvptirc * ISNULL((1 - (car.cpnomi_vta / car.cpnominal)),1))
														else 0 end
				,	MonedaActiva			=	CpMonEmi
				,	NominalPasivo			=	''
				,	MonedaPasivo			=	''
				,	Estado					=	isnull(mov.mostatreg, '')
				,	FechaInicio				=	cpfecneg
				,	FechaFin				=	CpFecVen
				,	Producto				=	'CP'
				,	Operador				=	isnull( car.mousuario, ISNULL(mov.mousuario, ''))
				,	Cartera_Financiera_1	=	car.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	car.Tipo_Cartera_Financiera
				,	Libro					=	car.id_libro
				,	Cartera_Super			=	car.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	FROM				bacbonosextsuda.dbo.text_ctr_inv car with(nolock)
			LEFT  JOIN	bacbonosextsuda.dbo.TEXT_MVT_DRI mov with (nolock)	ON	@ConBonex = 1 and car.cpnumdocu = mov.monumdocu AND car.cpcorrelativo = mocorrelativo
			inner join	#ruts ruts with(nolock) on		car.cprutcart = case when ruts.rut > 0		then ruts.rut		else car.cprutcart	end
													and car.cpcodcli  = case when ruts.codigo > 0	then ruts.codigo	else car.cpcodcli	end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cprutcli = cl.clrut and car.cpcodcli = clcodigo
			--inner join	BacParamSuda.dbo.producto prod with(Nolock) on car.motipmer = prod.codigo_producto and prod.id_sistema = 'BEX'
	where		@ConVigentes = 1 and			
			(		(	cpfecneg	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
				and (	CpFecVen	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
			)

	-----------------------------------------------------------------------------
	------------------------------Renta Fija Extranjera NY-----------------------
	-----------------------------------------------------------------------------
	Insert into #AuxCartera
	SELECT DISTINCT
					Sistema					=	'Renta Fija Extranjera NY'
				,	Orden					=	10
				,	RutCliente				=	cprutcart
				,	CodigoBacCliente		=	cpcodcli
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	convert(nvarchar(max), cpnumdocu)
				,	NumeroDocumento			=	cpnumdocu
				,	Correlativo				=	cpcorrelativo
				,	NominalActivo			=	case	when car.cpnominal > 0 then convert(numeric(30,16), car.cpvptirc * ISNULL((1 - (car.cpnomi_vta / car.cpnominal)),1))
														else 0 end
				,	MonedaActiva			=	CpMonEmi
				,	NominalPasivo			=	''
				,	MonedaPasivo			=	''
				,	Estado					=	isnull(mov.mostatreg, '')
				,	FechaInicio				=	cpfecneg
				,	FechaFin				=	CpFecVen
				,	Producto				=	'CP'
				,	Operador				=	isnull( car.mousuario, ISNULL(mov.mousuario, ''))
				,	Cartera_Financiera_1	=	car.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	car.Tipo_Cartera_Financiera
				,	Libro					=	car.id_libro
				,	Cartera_Super			=	car.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	FROM				bacbonosextny.dbo.text_ctr_inv car with(nolock)
			LEFT  JOIN	bacbonosextny.dbo.TEXT_MVT_DRI mov with (nolock)	ON @ConBonex = 1 and car.cpnumdocu = mov.monumdocu AND car.cpcorrelativo = mocorrelativo
			inner join	#ruts ruts with(nolock) on		car.cprutcart = case when ruts.rut > 0		then ruts.rut		else car.cprutcart	end
													and car.cpcodcli  = case when ruts.codigo > 0	then ruts.codigo	else car.cpcodcli	end
			inner join	bacparamsuda.dbo.cliente cl with(nolock) on car.cprutcli = cl.clrut and car.cpcodcli = clcodigo
	where		@ConVigentes = 1 and	
			(		(	cpfecneg	>=	@FechaRevisarMin or @FechaRevisarMin  = ''	)
				and (	CpFecVen	<=	@FechaRevisarMax or @FechaRevisarMax  = ''	)
			)



	-----------------------------------------------------------------------------------------
	------------------------------------------Renta Fija Nacional----------------------------
	-----------------------------------------------------------------------------------------

	Insert into #AuxCartera
	select
					Sistema					=	'Renta Fija Nacional CP'
				,	Orden					=	5
				,	RutCliente				=	cl.clrut
				,	CodigoBacCliente		=	1
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	cpnumdocu
				,	NumeroDocumento			=	convert(nvarchar(max), cpnumdocu)
				,	Correlativo				=	convert(nvarchar(max), cpcorrela)
				,	NominalActivo			=	isnull(mddi.divptirc,0) + isnull(mdvi.vivptirc,0)
				,	MonedaActiva			=	999
				,	NominalPasivo			=	0
				,	MonedaPasivo			=	999
				,	Estado					=	mdcp.estado_operacion_linea
				,	FechaInicio				=	mdcp.cpfeccomp
				,	FechaFin				=	mddi.difecsal
				,	Producto				=	'CP'
				,	Operador				=	ISNULL(mdmo.mousuario, '')
				,	Cartera_Financiera_1	=	mddi.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	mddi.ditipcart
				,	Libro					=	mddi.id_libro
				,	Cartera_Super			=	mddi.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	from					BacTraderSuda.dbo.MDDI mddi
				LEFT  join	BacTraderSuda.dbo.mdvi mdvi						with (nolock)	on mddi.dinumdocu = mdvi.vinumdocu and mddi.dicorrela = mdvi.vicorrela
				inner join	bactradersuda.dbo.mdcp mdcp						with (nolock)	on mddi.dinumdocu = mdcp.cpnumdocu and mddi.dicorrela = mdcp.cpcorrela
				inner join	bacparamsuda.dbo.instrumento bacInstrumento		with (nolock)	on bacinstrumento.inserie = mddi.diserie

				left join	BacTraderSuda.dbo.mdmo mdmo						with (nolock)	on mddi.dinumdocu = mdmo.monumdocu and mddi.dicorrela = mdmo.mocorrela

				left  join	bacparamsuda.dbo.NOSERIE noserie				with (nolock)	on noserie.nsnumdocu =	case when bacInstrumento.inmdse = 'N' then mddi.dinumdocu
																														 else null
																													end and noserie.nscorrela = mddi.dicorrela
				left  join	bacparamsuda.dbo.serie  serie					with (nolock)	on serie.semascara =	case	when bacInstrumento.inmdse = 'S' then mdcp.cpmascara
																															else null
																													end

				inner join	BacParamSuda.dbo.moneda monbac					with (nolock)	on monbac.mncodmon = case	when bacInstrumento.inmdse = 'N' then	CASE	WHEN noserie.nsmonemi is not null
																																										then noserie.nsmonemi ELSE 999 END
																														when bacInstrumento.inmdse = 'S' then	CASE	WHEN serie.semonemi   is not null
																																										then serie.semonemi   ELSE 999 END
																												  else 0 end
				inner join	#ruts ruts with(nolock) on		mdcp.cprutcli  = case when ruts.rut > 0		then ruts.rut		else mdcp.cprutcli	end
														and mdcp.cpcodcli  = case when ruts.codigo > 0	then ruts.codigo	else mdcp.cpcodcli end
				inner join	bacparamsuda.dbo.cliente cl with(nolock) on mdcp.cprutcli = cl.clrut and mdcp.cpcodcli = clcodigo
	where		1 = 1
			and	mdcp.cpnominal	> 0

	Insert into #AuxCartera
	select
					Sistema					=	'Renta Fija Nacional CI'
				,	Orden					=	5
				,	RutCliente				=	cl.clrut
				,	CodigoBacCliente		=	1
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	cinumdocu
				,	NumeroDocumento			=	convert(nvarchar(max), cinumdocu)
				,	Correlativo				=	convert(nvarchar(max), cicorrela)
				,	NominalActivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaActiva			=	999
				,	NominalPasivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaPasivo			=	999
				,	Estado					=	mdci.Estado_Operacion_Linea
				,	FechaInicio				=	mdci.cifecinip
				,	FechaFin				=	mdci.cifecvenp
				,	Producto				=	'CI'
				,	Operador				=	ISNULL(mdmo.mousuario, '')
				,	Cartera_Financiera_1	=	mdci.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	''
				,	Libro					=	mdci.id_libro
				,	Cartera_Super			=	mdci.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	from					BacTraderSuda.dbo.mdci mdci		with(nolock)
				left  join	BacTraderSuda.dbo.mdmo mdmo		with(nolock)	on	mdci.cinumdocu = mdmo.monumdocu and mdci.cicorrela = mdmo.mocorrela
				inner join	BacParamSuda.dbo.moneda monbac	with(nolock)	on	monbac.mncodmon = mdci.cimonemi
				inner join	bacparamsuda.dbo.producto pr	with(nolock)	on	mdci.ciinstser not in ('ICAP', 'ICOL') and pr.codigo_producto = 'ci' and pr.id_sistema = 'btr'
				inner join	#ruts ruts						with(nolock)	on	mdci.cirutcli  = case when ruts.rut > 0 then ruts.rut else mdci.cirutcli	end
				inner join	bacparamsuda.dbo.cliente cl		with(nolock)	on	mdci.cirutcli  = cl.clrut and mdci.cirutcli  = clcodigo
	where			1 = 1
				and	mdci.cinominal > 0


	Insert into #AuxCartera
	select
					Sistema					=	'Renta Fija Nacional ICOL'
				,	Orden					=	5
				,	RutCliente				=	cl.clrut
				,	CodigoBacCliente		=	1
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	cinumdocu
				,	NumeroDocumento			=	convert(nvarchar(max), cinumdocu)
				,	Correlativo				=	convert(nvarchar(max), cicorrela)
				,	NominalActivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaActiva			=	999
				,	NominalPasivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaPasivo			=	999
				,	Estado					=	mdci.Estado_Operacion_Linea
				,	FechaInicio				=	mdci.cifecinip
				,	FechaFin				=	mdci.cifecvenp
				,	Producto				=	'ICOL'
				,	Operador				=	ISNULL(mdmo.mousuario, '')
				,	Cartera_Financiera_1	=	mdci.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	''
				,	Libro					=	mdci.id_libro
				,	Cartera_Super			=	mdci.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	from					BacTraderSuda.dbo.mdci mdci		with (nolock)
				left  join	BacTraderSuda.dbo.mdmo mdmo		with (nolock)	on mdci.cinumdocu = mdmo.monumdocu and mdci.cicorrela = mdmo.mocorrela
				inner join	BacParamSuda.dbo.moneda monbac	with (nolock)	on monbac.mncodmon = mdci.cimonemi
				inner join	bacparamsuda.dbo.producto pr	with (nolock)	on pr.codigo_producto = 'ICOL' and mdci.ciinstser = pr.codigo_producto and pr.id_sistema = 'BTR'
				inner join	#ruts ruts						with(nolock)	on	mdci.cirutcli  = case when ruts.rut > 0 then ruts.rut else mdci.cirutcli	end
				inner join	bacparamsuda.dbo.cliente cl		with(nolock)	on	mdci.cirutcli  = cl.clrut and mdci.cirutcli  = clcodigo
	where			1 = 1
				and	mdci.cinominal > 0

	Insert into #AuxCartera
	select
					Sistema					=	'Renta Fija Nacional ICAP'
				,	Orden					=	5
				,	RutCliente				=	cl.clrut
				,	CodigoBacCliente		=	1
				,	CodigoItau				=	cl.Secuencia
				,	NombreCliente			=	ltrim(rtrim(cl.clnombre))
				,	NumeroOperacion			=	cinumdocu
				,	NumeroDocumento			=	convert(nvarchar(max), cinumdocu)
				,	Correlativo				=	convert(nvarchar(max), cicorrela)
				,	NominalActivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaActiva			=	999
				,	NominalPasivo			=	convert(numeric(30,16), mdci.civptirci)
				,	MonedaPasivo			=	999
				,	Estado					=	mdci.Estado_Operacion_Linea
				,	FechaInicio				=	mdci.cifecinip
				,	FechaFin				=	mdci.cifecvenp
				,	Producto				=	'ICAP'
				,	Operador				=	ISNULL(mdmo.mousuario, '')
				,	Cartera_Financiera_1	=	mdci.Tipo_Cartera_Financiera
				,	Cartera_Financiera_2	=	''
				,	Libro					=	mdci.id_libro
				,	Cartera_Super			=	mdci.codigo_carterasuper
				,	Sub_Cartera_Super		=	0
				,	CodigoAS400				=	cl.codigo_as400
	from					BacTraderSuda.dbo.mdci mdci		with (nolock)
				left  join BacTraderSuda.dbo.mdmo mdmo		with (nolock)	on mdci.cinumdocu = mdmo.monumdocu and mdci.cicorrela = mdmo.mocorrela
				inner join BacParamSuda.dbo.moneda monbac	with (nolock)	on monbac.mncodmon = mdci.cimonemi
				inner join bacparamsuda.dbo.producto pr		with (nolock)	on pr.codigo_producto = 'ICAP' and mdci.ciinstser = pr.codigo_producto and pr.id_sistema = 'btr'
				inner join	#ruts ruts						with(nolock)	on	mdci.cirutcli  = case when ruts.rut > 0 then ruts.rut else mdci.cirutcli	end
				inner join	bacparamsuda.dbo.cliente cl		with(nolock)	on	mdci.cirutcli  = cl.clrut and mdci.cirutcli  = clcodigo
	where			1 = 1
				and	mdci.cinominal > 0


	-----------------------------------------------------------------------------------------
	------------------------------------------Renta Fija Nacional querys antiguos----------------------------
	-----------------------------------------------------------------------------------------

	--Insert into #AuxCartera
	--select
	--				Sistema			=	'Renta Fija Nacional 1'
	--			,	Orden			=	5
	--			,	RutCliente		=	cli.clrut
	--			,	CodigoBacCliente	=	1
	--			--,	NumeroOperacion	=	concat(cpnumdocu, '-', cpcorrela )
	--			,	NumeroOperacion	=	cpnumdocu
	--			,	NumeroDocumento =	convert(nvarchar(max), cpnumdocu)
	--			,	Correlativo		=	convert(nvarchar(max), cpcorrela)
	--			,	Estado			=	mdcp.estado_operacion_linea
	--			,	FechaInicio		=	''
	--			,	FechaFin		=	''
	--			,	Producto		=	''
	--			,	Operador		=	''
	--			--cpnumdocu, cpcorrela, cpinstser, cli.clrut, cli.Clnombre
	--from				BacTraderSuda.dbo.mdcp with(nolock)
	--		inner join	BacTraderSuda.dbo.mddi with(nolock) on dinumdocu = cpnumdocu and	dicorrela = cpcorrela
	--		left join ( select distinct clrut, Clnombre from BacParamsuda.dbo.cliente with(nolock) ) cli on	cli.clrut = cprutcli
	--		inner join #ruts ruts with(nolock)	on	cli.clrut = case when ruts.rut > 0 then ruts.rut else cli.clrut	end
	--where		1 = 1
	--		--and	cprutcli	= @nRut
	--		and	cpnominal	> 0

	--UNION

	--select
	--				Sistema			=	'Renta Fija Nacional 2'
	--			,	Orden			=	5
	--			,	RutCliente		=	cli.clrut
	--			,	CodigoBacCliente	=	1
	--			--,	NumeroOperacion	=	concat(cpnumdocu, '-', cpcorrela )
	--			,	NumeroOperacion	=	cpnumdocu
	--			,	NumeroDocumento =	convert(nvarchar(max), cpnumdocu)
	--			,	Correlativo		=	convert(nvarchar(max), cpcorrela)
	--			,	Estado			=	mdcp.estado_operacion_linea
	--			,	FechaInicio		=	''
	--			,	FechaFin		=	''
	--			,	Producto		=	''
	--			,	Operador		=	''
	--				--cpnumdocu, cpcorrela, cpinstser, cli.clrut, cli.Clnombre
	--from				BacTraderSuda.dbo.mdcp with(nolock)
	--		inner join	BacTraderSuda.dbo.mddi with(nolock) on dinumdocu = cpnumdocu and	dicorrela = cpcorrela
	--		inner join	BacParamSuda.dbo.EMISOR on emgeneric = digenemi
	--		left join ( select distinct clrut, Clnombre from BacParamsuda.dbo.cliente with(nolock) ) cli  on     cli.clrut    = emrut
	--		inner join	#ruts ruts with(nolock) on	cli.clrut = case when ruts.rut > 0		then ruts.rut		else cli.clrut	end
	--where		1 = 1
	--		--and	emrut		= @nRut
	--		and	cpnominal	> 0


	--UNION

	--select
	--				Sistema			=	'Renta Fija Nacional 3'
	--			,	Orden			=	5
	--			,	RutCliente		=	cli.clrut
	--			,	CodigoBacCliente	=	1
	--			--,	NumeroOperacion	=	concat(cinumdocu,'-', cicorrela )
	--			,	NumeroOperacion	=	cinumdocu
	--			,	NumeroDocumento =	convert(nvarchar(max), cinumdocu)
	--			,	Correlativo		=	convert(nvarchar(max), cicorrela)
	--			,	Estado			=	estado_operacion_linea
	--			,	FechaInicio		=	''
	--			,	FechaFin		=	''
	--			,	Producto		=	''
	--			,	Operador		=	''
	--				--cinumdocu, cicorrela,ciinstser, cli.clrut, cli.Clnombre
	--from				BacTradersuda.dbo.mdci with(nolock)
	--		left join ( select distinct clrut, Clnombre from BacParamsuda.dbo.cliente with(nolock) ) cli on     cli.clrut    = cirutcli
	--		inner join	#ruts ruts with(nolock) on	cli.clrut = case when ruts.rut > 0		then ruts.rut		else cli.clrut	end
	--where		1 = 1
	--		--and	cirutcli	= @nRut


	--UNION

	--select
	--				Sistema			=	'Renta Fija Nacional 4'
	--			,	Orden			=	5
	--			,	RutCliente		=	cli.clrut
	--			,	CodigoBacCliente	=	1
	--			,	NumeroOperacion	=	convert(nvarchar(max), vinumoper)
	--			,	NumeroDocumento =	convert(nvarchar(max), vinumdocu)
	--			,	Correlativo		=	convert(nvarchar(max), vicorrela)
	--			,	Estado			=	''
	--			,	FechaInicio		=	''
	--			,	FechaFin		=	''
	--			,	Producto		=	''
	--			,	Operador		=	''
	--				--vinumdocu, vicorrela, vinumoper, cli.clrut, cli.Clnombre, *
	--from				BacTraderSuda.dbo.mdvi with(nolock)
	--		left join ( select distinct clrut, Clnombre from BacParamsuda.dbo.cliente with(nolock) ) cli on cli.clrut = virutcli
	--		inner join	#ruts ruts with(nolock) on	cli.clrut = case when ruts.rut > 0		then ruts.rut		else cli.clrut	end
	--where		1 = 1
	--		--and	virutcli     = @nRut

	--------------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------FIN Sistemas-Operaciones--------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------Cargando Carteras y Libros------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------

	-------------------------------
	------------Libros-------------
	-------------------------------
	update	car
	set		libro = ltrim(rtrim(libros.tbglosa))
	from	#AuxCartera car
			inner join BacParamSuda.dbo.Tabla_General_Detalle libros on car.libro = libros.tbcodigo1 AND libros.tbcateg = 1552
	
	-------------------------------------------------
	---------------Cartera Financiera 01-------------
	-------------------------------------------------
	update	car
	set		Cartera_Financiera_1 = ltrim(rtrim(cartera.tbglosa))
	from	#AuxCartera car
			inner join BacParamSuda.dbo.Tabla_General_Detalle cartera on car.Cartera_Financiera_1 = cartera.tbcodigo1 AND cartera.tbcateg = 204
	
	
	-------------------------------------------------
	---------------Cartera Financiera 02-------------
	-------------------------------------------------
	update	car
	set		Cartera_Financiera_2 = ltrim(rtrim(cartera.tbglosa))
	from	#AuxCartera car
			inner join BacParamSuda.dbo.Tabla_General_Detalle cartera on car.Cartera_Financiera_2 = cartera.tbcodigo1 AND cartera.tbcateg = 204


	-------------------------------------------------
	---------------Cartera Super---------------------
	-------------------------------------------------
	update	car
	set		Cartera_Super = ltrim(rtrim(cartera.tbglosa))
	from	#AuxCartera car
			inner join BacParamSuda.dbo.Tabla_General_Detalle cartera on car.Cartera_Super = cartera.tbcodigo1 AND cartera.tbcateg = 1111

	-------------------------------------------------
	---------------Sub Cartera Super---------------------
	-------------------------------------------------
	update	car
	set		Sub_Cartera_Super = ltrim(rtrim(cartera.tbglosa))
	from	#AuxCartera car
			inner join BacParamSuda.dbo.Tabla_General_Detalle cartera on car.Sub_Cartera_Super = cartera.tbcodigo1 AND cartera.tbcateg = 1554

	--------------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------ FIN Cargando Carteras y Libros------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------



	select	*
	from	#AuxCartera car with(nolock)
	where		1 = 1
			--and sistema like '%ny%'
			--and orden in( 5)
			--and rut = 472655828
			--and codigo = 1
			--and numerooperacion in(12391)
			--and estado  in ( 'P', 'p' )
			--and FechaInicio = convert(date, getdate())
			--and FechaFin = convert(date, getdate())
			--and FechaFin = '2018-01-16'
			--and numerooperacion IN(582253,607909,10487,10883,3879,638124,673,611698)
			--and operador in ( 'lperez', 'lperezv')
			--and FechaInicio = '2017-12-07'
			--and codigoas400 <= 0
			--and	numerooperacion IN(213131,213147,207462,213560,213629,213631,213630)
	--group by car.FechaInicio
	--order by sistema, Fechafin

	--select	distinct concat(clrut, '-', cldv)
	--from	#AuxCartera car with(nolock)
	--		inner join bacparamsuda.dbo.cliente cl with(nolock) on car.rut = cl.clrut and car.codigobac = cl.clcodigo


	-----------------------------------------------------------------------------
	------------------------------Tablas Temporales y Variables------------------
	-----------------------------------------------------------------------------
	--IF OBJECT_ID('tempdb..#AuxCartera') IS NOT NULL DROP TABLE #AuxCartera
	--IF OBJECT_ID('tempdb..#ruts')		IS NOT NULL DROP TABLE #ruts

END

GO

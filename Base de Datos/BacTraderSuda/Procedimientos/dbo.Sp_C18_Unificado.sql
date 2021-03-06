USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_C18_Unificado]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_C18_Unificado]
	(	@sgBacFecp	datetime	)
AS
BEGIN

	set nocount on

	-->		Define el Primer Día del Mes A Generar
	declare @sgFirstDay	datetime
		set @sgFirstDay	=	@sgBacFecp	-- dateadd( day,  1, dateadd( day, (day( dateadd( month, -1, @sgBacFecp) ) *-1), dateadd( month, -1, @sgBacFecp)))
					-->		dateadd(day, 1, dateadd(day, (day(dateadd( month, -1, @sgBacFecp))*-1), @sgBacFecp))

	declare @gsLastDay	datetime
		set @gsLastDay	=	dateadd( day, -1, dateadd( month, 1, @sgFirstDay))

--	select @sgFirstDay, @gsLastDay
	--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014 
    IF OBJECT_ID('tempdb..#tmp_interfaz_c18_unificada')IS NOT NULL 
		DROP TABLE #tmp_interfaz_c18_unificada
	--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014

	create table #tmp_interfaz_c18_unificada
	(	c18_CAMPO_01	char(02)		--> 01 Dia								( CODIGO DE LA IF )				-- PRIMER REGISTRO
	,	c18_CAMPO_02	char(14)		--> 02 Activo Circulante				( IDENTIFICACION DEL ARCHIVO )	-- PRIMER REGISTRO
	,	c18_CAMPO_03	char(03)		--> 03 Codigo del Banco Acreedor		( PERIODO AAAAMM )				-- PRIMER REGISTRO
	,	c18_CAMPO_04	char(122)		--> 04 Plazo Residual de Vencimiento	( FILLER)						-- PRIMER REGISTRO
	,	c18_CAMPO_05	char(14)		--> 05 Moneda de Pago
	,	c18_CAMPO_06	char(14)		--> 06 Cuentas Corrientes
	,	c18_CAMPO_07	char(14)		--> 07 Otras Obligaciones a la Vista
	,	c18_CAMPO_08	numeric(14,0)	--> 08 Operaciones con Liquidacion en Curso
	,	c18_CAMPO_09	char(14)		--> 09 Contratos de Retrocompra y Prestamos de Valores
	,	c18_CAMPO_10	char(14)		--> 10 depositos y otras captaciones a Plazo
	,	c18_CAMPO_11	char(14)		--> 11 Contratos de derivados financieros
	,	c18_CAMPO_12	char(14)		--> 12 Obligaciones Con Bancos
	,	c18_CAMPO_13	char(14)		--> 13 Monto Cubierto con Garantias Validas para Limites
	,	c18_CAMPO_14	char(122)		--> 14 Fille
--	,	c18_Sistema		char(003)		--> sistema... no se retorna solo dato de control
	)

	-->		Elimina los Pagos realizados en el mismo periodo, para evitar duplicaciones
	delete	from	dbo.Tbl_Operaciones_C18_Mesa
			where	Month( FechaCurse ) = Month( @sgFirstDay )
	-->		Elimina los Pagos realizados en el mismo periodo, para evitar duplicaciones


	--		SPOT
	insert into dbo.Tbl_Operaciones_C18_Mesa
	select	FechaCurse	= Spot.mofech
		,	Moneda		= Mon.mncodmon
		,	Mediopago	= Spot.moentre
		,	Monto		= case	when Spot.motipope = 'V' then Spot.momonmo
								when Spot.motipope = 'C' then Spot.momonpe
							end
		,	FechaVcto	= case	when Spot.motipope = 'V' then case	when Spot.mocodmon = 'CLP' then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Spot.mofech, MPago.DiasValor, 6)
																	else							BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Spot.mofech, MPago.DiasValor, 225)
																end
								when Spot.motipope = 'C' then case	when Spot.mocodmon = 'CLP' then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Spot.mofech, MPago.DiasValor, 6)
																	else							BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Spot.mofech, MPago.DiasValor, 225)
																end
							end
		--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		--,	Codigo		= Clie.Cod_Inst
		,	Codigo		= CASE WHEN Clie.Cod_Inst = 57 THEN 14 ELSE Clie.Cod_Inst END
		--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		,	Modulo		= 'BCC'
	from	(	SELECT	mofech,		motipmer,	mocodmon,	mocodcnv,	moestatus,	moterm
					,	monumope,	morutcli,	mocodcli
					,	momonmo,	momonpe,	moussme,	moentre,	morecib,	movaluta1
					,	movaluta2,	motipope
				FROM	BacCamSuda.dbo.MEMOH	with(nolock)
				WHERE	mofech		between @sgFirstDay and @gsLastDay
				AND		motipmer	= 'PTAS'
				AND		mocodmon	= 'USD'
				AND		mocodcnv	= 'CLP'
				AND		moestatus	= ''
				AND		moterm		<> 'CORREDORA'

				UNION ALL

				SELECT	mofech,		motipmer,	mocodmon,	mocodcnv,	moestatus,	moterm
					,	monumope,	morutcli,	mocodcli
					,	momonmo,	momonpe,	moussme,	moentre,	morecib,	movaluta1
					,	movaluta2,	motipope
				FROM	BacCamSuda.dbo.MEMOH	with(nolock)
				WHERE	mofech		between @sgFirstDay and @gsLastDay
				AND		motipmer	= 'EMPR'
				AND		mocodmon	= 'USD'
				AND		mocodcnv	= 'CLP'
				AND		moestatus	= ''
				AND		moterm		<> 'CORREDORA'
			)	Spot

			inner join	(	Select	Codigo
								,	DiasValor
							from	BacParamSuda.dbo.Forma_de_Pago with(nolock)
							where	(	Codigo IN(11,  12,  13,  14, 128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139) -->	Telex y --> Spav
--								or		Codigo IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 )	--> Spav
									)
						)	MPago	On MPago.codigo = case	when Spot.motipope = 'V' then Spot.moentre
															when Spot.motipope = 'C' then Spot.morecib
														end
			inner join	(	select	clrut		= clrut
								,	clcodigo	= clcodigo
								,	cltipcli	= cltipcli
								,	clpais		= clpais
								,	Cod_Inst	= Cod_Inst
							from	BacParamSuda.dbo.Cliente with(nolock)
							where	cltipcli	= 1 --> Bancos Nacionales
							and		clpais		= 6 --> Chile
						)	Clie	On	Clie.clrut		= Spot.morutcli
									and Clie.clcodigo	= Spot.mocodcli

			inner join	BacParamSuda.dbo.Moneda Mon	On Mon.mnnemo =	case	when Spot.motipope = 'V' then Spot.mocodmon
																			when Spot.motipope = 'C' then Spot.mocodcnv
																		end

	union all

	--		FORWARD
	SELECT	FechaCurse	= cafecvcto
		,	Moneda		= CASE WHEN Moneda = 998 THEN 999 ELSE Moneda END
		,	MedioPago	= cafpago
		,	Monto		= Monto	--> ABS(Monto)
		,	FechaVcto	= BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Forward.cafecvcto, MPago.DiasValor, 6)
		--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		--,	Codigo		= Clie.Cod_Inst
		,Codigo		= CASE WHEN Clie.Cod_Inst = 57 THEN 14 ELSE Clie.Cod_Inst END
		--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		,	Modulo		= 'BFW'
	FROM	(	SELECT	cafecvcto		= cafecvcto
				,		canumoper		= canumoper
				,		Monto			= abs(camtocomp)
				,		cafpago			= cafpagomn
				,		moneda			= cacodmon2
				,		morutcli		= cacodigo
				,		mocodcli		= cacodcli
				FROM	BacFwdSuda.dbo.MFCAH	with(nolock)
				WHERE	cafecvcto		BETWEEN @sgFirstDay and @gsLastDay
				AND		cacodpos1		= 10
				AND		caestado		<> 'P'
				AND		catipmoda		= 'C'
				AND		caantici		<> 'A'
					UNION
				SELECT	cafecvcto		= cafecvcto
				,		canumoper		= canumoper
				,		Monto			= abs(camtocomp)
				,		cafpago			= cafpagomn
				,		moneda			= case when cacodmon2 = 998 then 999 else cacodmon2 end
				,		morutcli		= cacodigo
				,		mocodcli		= cacodcli
				FROM	BacFwdSuda.dbo.MFCAH	with(nolock)
				WHERE	cafecvcto		BETWEEN @sgFirstDay and @gsLastDay
				AND		cacodpos1		IN(1, 3)
				AND		cacodmon1		IN(999, 998)
				AND		camtocomp		< 0
				AND		caestado		= ''
				AND		catipmoda		= 'C'
				AND		caantici		<> 'A'
					UNION
				SELECT	cafecvcto		= cafecvcto
				,		canumoper		= numerocontratocliente
				,		Monto			= ABS(caantmtomdacomp)
				,		cafpago			= caantforpagmdacomp
				,		moneda			= moneda_compensacion
				,		morutcli		= cacodigo
				,		mocodcli		= cacodcli
				FROM	BacFwdSuda.dbo.MFCARES	with(nolock)
				WHERE	CaFechaProceso	between @sgFirstDay and @gsLastDay
				and		cafecvcto		= CaFechaProceso
				and		caantmtomdacomp	< 0
				and		caestado		<> 'P'
				and		caantici		= 'A'
			)	Forward

				inner join	(	Select	Codigo
								,		DiasValor
								from	BacParamSuda.dbo.Forma_de_pago with(nolock)
								where	(	Codigo IN(11,  12,  13,  14)										-->	Telex
									or		Codigo IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 )	--> Spav
										)
							)	MPago	On MPago.codigo = Forward.cafpago

				inner join	(	select	clrut		= clrut
								,		clcodigo	= clcodigo
								,		cltipcli	= cltipcli
								,		clpais		= clpais
								,		Cod_Inst	= Cod_Inst
								from	BacParamSuda.dbo.Cliente with(nolock)
								where	cltipcli	= 1 --> Bancos Nacionales
								and		clpais		= 6 --> Chile
							)	Clie	On	Clie.clrut		= Forward.morutcli
										and Clie.clcodigo	= Forward.mocodcli

	union all

	--		RENTA FIJA
	select	FechaCurse	= RentaFija.FechaCurse
		,	Moneda		= RentaFija.Moneda
		,	MedioPago	= RentaFija.MedioPago
		,	Monto		= RentaFija.Monto
		,	FechaVcto	= case	when RentaFija.Moneda <> 13 then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(RentaFija.FechaCurse, MPago.DiasValor, 6)
								else							 BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(RentaFija.FechaCurse, MPago.DiasValor, 225)
							end
		--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		--,	Codigo		= Clie.Cod_Inst
		, Codigo		= CASE WHEN Clie.Cod_Inst = 57 THEN 14 ELSE Clie.Cod_Inst END
		--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		,	Modulo		= 'BTR'
	from	(	select	FechaCurse	= mofecpro
					,	Moneda		= momonpact
					,	MedioPago	= moforpagi
					,	Monto		= case	when motipoper = 'CI'  then sum( movpresen )                
											when motipoper = 'IB'  then sum( movpresen )
											when motipoper = 'RC'  then sum( movalvenp )
											when motipoper = 'RCA' then sum( movalvenp )
										end
					,	Rut			= morutcli
					,	Codigo		= mocodcli
				from	BacTraderSuda.dbo.MDMH with(nolock)
				where	mofecpro	between @sgFirstDay and @gsLastDay
				and		motipoper	IN('CI','RC','RCA')
				and		mostatreg	= ''
				and		momonpact	<> 13
				group 
				by		mofecpro, moforpagi, momonpact, motipoper, morutcli, mocodcli
					union
				select	FechaCurse	= mofecpro
					,	Moneda		= momonpact
					,	MedioPago	= moforpagi
					,	Monto		= sum( movpresen )
					,	Rut			= morutcli
					,	Codigo		= mocodcli
				from	BacTraderSuda.dbo.MDMH with(nolock)
				where	mofecpro	between @sgFirstDay and @gsLastDay
				and		motipoper	IN('IB')
				and		moinstser	= 'ICOL'
				and		mostatreg	= ''
				and		momonpact	<> 13
				group 
				by		mofecpro, moforpagi, momonpact, morutcli, mocodcli
					union
				select	FechaCurse	= mofecpro
					,	Moneda		= 999
					,	MedioPago	= moforpagi
					,	Monto		= sum( movpresen )
					,	Rut			= morutcli
					,	Codigo		= mocodcli
				from	BacTraderSuda.dbo.MDMH with(nolock)
				where	mofecpro	between @sgFirstDay and @gsLastDay
				and		motipoper	IN('CP')
				and		mostatreg	= ''
				and		momonpact	<> 13
				group 
				by		mofecpro, moforpagi, momonpact, morutcli, mocodcli
					union
				select	FechaCurse	= rsfecha
					,	Moneda		= rsmonpact
					,	MedioPago	= rsforpagv
					,	Monto		= sum( rsvppresenx )
					,	Rut			= rsrutcli
					,	Codigo		= rscodcli
				from	BacTraderSuda.dbo.Mdrs with(nolock)
				where	rsfecha		between @sgFirstDay and @gsLastDay
				and		rsinstser	= 'ICAP'
				and		rstipoper	= 'VC'
				group
				by		rsfecha, rsmonpact, rsforpagv, rsrutcli, rscodcli
			)	RentaFija
			inner join	(	Select	Codigo
							,		DiasValor
							from	BacParamSuda.dbo.Forma_de_pago with(nolock)
							where	(	Codigo IN(11,  12,  13,  14)										-->	Telex
								or		Codigo IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 )	--> Spav
									)
						)	MPago	On MPago.codigo = RentaFija.MedioPago
			inner join	(	select	clrut		= clrut
							,		clcodigo	= clcodigo
							,		cltipcli	= cltipcli
							,		clpais		= clpais
							,		Cod_Inst	= Cod_Inst
							from	BacParamSuda.dbo.Cliente with(nolock)
							where	cltipcli	= 1 --> Bancos Nacionales
							and		clpais		= 6 --> Chile
						)	Clie	On	Clie.clrut		= RentaFija.Rut
									and Clie.clcodigo	= RentaFija.Codigo

	union all

	--		SWAP
	SELECT	FechaCurse	= Swap.Liquida
		,	Moneda		= Swap.Moneda
		,	MedioPago	= Swap.MedioPago
		,	Monto		= Swap.Monto
		,	FechaVcto	= case	when Swap.Moneda = 999 then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Swap.Liquida, MPago.DiasValor, 6)
								when Swap.Moneda = 998 then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Swap.Liquida, MPago.DiasValor, 6)
								when Swap.Moneda = 13  then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Swap.Liquida, MPago.DiasValor, 225)
							end
		--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		--,	Codigo		= Clie.Cod_Inst
		, Codigo		= CASE WHEN Clie.Cod_Inst = 57 THEN 14 ELSE Clie.Cod_Inst END
		--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		,	Modulo		= 'PCS'
	FROM	(	SELECT	Folio		= SwapPasivo.Folio
					,	Rut			= SwapPasivo.Rut
					,	Codigo		= SwapPasivo.Codigo
					,   Moneda		= SwapPasivo.Moneda
					,   MedioPago	= SwapPasivo.MedioPago
					,   Inicia		= SwapPasivo.Inicia
					,   Liquida		= SwapPasivo.Liquida
					,	Monto		= isnull(SwapActivo.Monto,0)	- isnull(SwapPasivo.Monto, 0)
				FROM	(	select	Folio	= Numero_Operacion
								,   Monto	= Devengo_Monto_Peso
							from	BacSwapSuda.dbo.Carterahis with(nolock)
							where	fecha_vence_flujo	between @sgFirstDay and @gsLastDay
							and		tipo_swap			= 4
							and		tipo_flujo			= 1
							and		Modalidad_Pago		= 'C'
						)	SwapActivo
						left join	(	select	Folio		= Numero_Operacion
											,	Rut			= Rut_Cliente
											,	Codigo		= Codigo_cliente
											,   Moneda		= Pagamos_Moneda
											,   MedioPago	= Pagamos_Documento
											,   Inicia		= Fecha_Inicio_Flujo
											,   Liquida		= Fecha_Vence_Flujo
											,   Monto		= Devengo_Monto_Peso
										from	BacSwapSuda.dbo.Carterahis with(nolock)
										where	fecha_vence_flujo	between @sgFirstDay and @gsLastDay
										and		tipo_swap			= 4
										and		tipo_flujo			= 2
										and		Modalidad_Pago		= 'C'
									)	SwapPasivo	On SwapPasivo.Folio	= SwapActivo.Folio
			)	Swap
			inner join	(	Select	Codigo
								,	DiasValor
							from	BacParamSuda.dbo.Forma_de_Pago with(nolock)
							where	(	Codigo IN(11,  12,  13,  14)										-->	Telex
								or		Codigo IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 )	--> Spav
									)
						)	MPago	On MPago.codigo = Swap.MedioPago

			inner join	(	select	clrut		= clrut
								,	clcodigo	= clcodigo
								,	cltipcli	= cltipcli
								,	clpais		= clpais
								,	Cod_Inst	= Cod_Inst
							from	BacParamSuda.dbo.Cliente with(nolock)
							where	cltipcli	= 1 --> Bancos Nacionales
							and		clpais		= 6 --> Chile
						)	Clie	On	Clie.clrut		= Swap.Rut
									and Clie.clcodigo	= Swap.Codigo
	WHERE Swap.Monto	<	0	-->	define que son Cargos

	union all

	--		OPCIONES
	SELECT	FechaCurse	= Opciones.Liquida
		,	Moneda		= Opciones.Moneda
		,	MedioPago	= Opciones.MedioPago
		,	Monto		= Opciones.Monto
		,	FechaVcto	= case	when Opciones.Moneda = 999 then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Opciones.Liquida, MPago.DiasValor, 6)
								when Opciones.Moneda = 998 then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Opciones.Liquida, MPago.DiasValor, 6)
								when Opciones.Moneda = 13  then BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(Opciones.Liquida, MPago.DiasValor, 225)
							end
		--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		--,	Codigo		= Opciones.Cod_Inst
		, Codigo		= CASE WHEN Opciones.Cod_Inst = 57 THEN 14 ELSE Opciones.Cod_Inst END
		--< --- 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
		,	Modulo		= 'OPT'
	FROM	(	select	Liquida				= a.CaCajFecPago
					,	Moneda				= a.CaCajMdaM1
					,	MedioPago			= a.CaCajFormaPagoMon1
					,	Monto				= SUM( a.CaCajMtoMon1 )
					,	FechaVcto			= a.CaCajFecPago
					,	Cod_Inst			= Clie.Cod_Inst
				from	LnkOpc.CbMdbOpc.dbo.CaResCaja a with(nolock)
						inner join (	select	CaEncFechaRespaldo, CaNumContrato, CaNumFolio, CaEstado, CaRutCliente, CaCodigo
										from	LnkOpc.CbMdbOpc.dbo.CaResEncContrato with(nolock) 
										where	CaEncFechaRespaldo		between @sgFirstDay and @gsLastDay
									)	b	On	b.CaEncFechaRespaldo	= a.CaCajaFechaRespaldo
											and b.CaNumContrato			= a.CaNumContrato

						inner join (	Select	clrut, clcodigo, cldv, cltipcli, clpais, Cod_Inst
										from	BacParamSuda.dbo.Cliente with(nolock)
										where	cltipcli	= 1 --> Bancos Nacionales
										and		clpais		= 6 --> Chile
									)	Clie	On	Clie.clrut			= b.CaRutCliente
												and Clie.clcodigo		= b.CaCodigo

				where	a.CaCajaFechaRespaldo	between @sgFirstDay and @gsLastDay
				and		a.CaCajFecPago			= CaCajaFechaRespaldo
				and		b.CaEstado				= ''
				and		a.CaCajModalidad		= 'C'
				and		a.CaCajMdaM1			= 999
				and		a.CaCajMtoMon1			< 0
				group
				by		b.CaNumContrato
					,	b.CaRutCliente
					,	b.CaCodigo
					,	Clie.Cod_Inst
					,	a.CaCajMdaM1
					,	a.CaCajFormaPagoMon1
					,	a.CaCajFechaGen
					,	a.CaCajFecPago
			)	Opciones

			inner join	(	Select	Codigo
								,	DiasValor
							from	BacParamSuda.dbo.Forma_de_Pago with(nolock)
							where	(	Codigo IN(11,  12,  13,  14)										-->	Telex
								or		Codigo IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139 )	--> Spav
									)
						)	MPago	On MPago.codigo = Opciones.MedioPago

	-->		Generacion del Informe Dia a Día, en caso que el día (Fecha) no corresponda a un día habil, se replcia el día anterior
	declare @dFechaGeneracion	datetime;	set @dFechaGeneracion	= @gsLastDay
	declare @dFechaDatos		Datetime;	set @dFechaDatos		= @dFechaGeneracion
	declare @nDays				int;		set @nDays				= Day( @gsLastDay ) -1
	declare @nContador			int;		set @nContador			= 0
	declare @EsHabil			char(2)


	while @nContador <= @nDays
	begin
		
		set @dFechaGeneracion	= dateadd(day, @nContador, @sgFirstDay)
		set @dFechaDatos		= @dFechaGeneracion

		Execute BacParamSuda.dbo.SP_DETECTA_FECHA_HABIL_INHABIL	@dFechaGeneracion
															,	@EsHabil		output

		if @EsHabil = 'NO'
			Execute BacParamSuda.dbo.SP_FECHA_HABIL_ANTERIOR	@dFechaGeneracion
															,	@dFechaDatos	output
		
		insert into	#tmp_interfaz_c18_unificada
		select	'c18_CAMPO_01' = LTRIM(RTRIM( DATEPART(DAY, @dFechaGeneracion ) )) --> Grupo.Col05	-->	LTRIM(RTRIM( DATEPART(DAY, Lbtr.Fecha ) ))
		,		'c18_CAMPO_02' = Grupo.Ceros	--> REPLICATE('0', 14)
		,		'c18_CAMPO_03' = Grupo.Col03	-->	CONVERT(CHAR(3), REPLICATE('0', 3 - LEN( Clie.Cod_Inst )) + RTRIM(LTRIM( Clie.Cod_Inst )) )
		,		'c18_CAMPO_04' = Grupo.Col04	-->	CASE	WHEN DATEDIFF(DAY, Lbtr.fecha, Lbtr.fecha_vencimiento) = 0   THEN '1'
												--			WHEN DATEDIFF(DAY, Lbtr.fecha, Lbtr.fecha_vencimiento) > 364 THEN '3'
												--			ELSE                                                    '2' --> Entre 2 y 365
												--	END
		,		'c18_CAMPO_05' = Grupo.Col05	--> CASE	WHEN Lbtr.moneda = 999        THEN	1
												--			WHEN Lbtr.moneda IN(998, 994) THEN	2
												--			ELSE								3
												--	END 
		,		'c18_CAMPO_06' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_07' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_08' = Grupo.Monto	-->	SUM( ABS( Lbtr.monto_operacion ) )
		,		'c18_CAMPO_09' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_10' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_11' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_12' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_13' = Grupo.Ceros	--> REPLICATE('0',14)
		,		'c18_CAMPO_14' = 0
		from	(
					select	Col03	= CONVERT(CHAR(3), REPLICATE('0', 3 - LEN( Codificacion )) + RTRIM(LTRIM( Codificacion )) )	--> Codificacion
						,	Col04	= CASE	WHEN DATEDIFF(DAY, FechaCurse, FechaVcto) = 0   THEN	'1'
											WHEN DATEDIFF(DAY, FechaCurse, FechaVcto) > 364 THEN	'3'
											ELSE	/* --> Entre 2 y 365 */							'2' 
										END
						,	Col05	= CASE	WHEN Moneda	= 999			THEN 1
											WHEN Moneda	IN(998, 994)	THEN 2
											ELSE							 3
										END
						,	Col01	= LTRIM(RTRIM( DATEPART(DAY, FechaCurse ) ))
						,	Ceros	= REPLICATE('0', 14)
						,	Monto	= SUM( ABS( Monto ) )
					from	dbo.Tbl_Operaciones_C18_Mesa
					where	FechaCurse = @dFechaDatos
					group 
					by		Codificacion
						,	CASE	WHEN DATEDIFF(DAY, FechaCurse, FechaVcto) = 0   THEN	'1'
									WHEN DATEDIFF(DAY, FechaCurse, FechaVcto) > 364 THEN	'3'
									ELSE	/* --> Entre 2 y 365 */							'2' 
								END
						,	CASE	WHEN Moneda	= 999			THEN 1
									WHEN Moneda	IN(998, 994)	THEN 2
									ELSE							 3
								END
						,	LTRIM(RTRIM( DATEPART(DAY, FechaCurse ) ))
				)	Grupo
				

		-->	Mueve el día de corma correlativa
		set @nContador		= @nContador + 1
		
	-->	Fin del Cliclo correspondiente a los días del Mes
	end

	select * from #tmp_interfaz_c18_unificada

end
--> +++ 2018.07.27 cvegasan Eliminar Codigo 057 y cambiarlo por 014
GO

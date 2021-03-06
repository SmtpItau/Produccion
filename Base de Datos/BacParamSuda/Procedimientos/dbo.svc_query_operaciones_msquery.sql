USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[svc_query_operaciones_msquery]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[svc_query_operaciones_msquery]
	(	@omodulo char(5)
	,	@desde	 datetime
	,	@hasta	 datetime
	)
as
begin

	set nocount on

	DECLARE @dFechaInicio	DATETIME;	SET @dFechaInicio	= @desde
	DECLARE @dFechaTermino	DATETIME;	SET @dFechaTermino	= @hasta

if (@omodulo = 'bfw')
begin
	SELECT	Modulo		= 'Forward'
		,	Periodo		= case	when ltrim(rtrim( month(Forward.mofecha))) <= 9 then '0' + ltrim(rtrim( month(Forward.mofecha)))
								else												 ltrim(rtrim( month(Forward.mofecha)))
							end	  
						+ '-' + ltrim(rtrim(year(Forward.mofecha)))
		,	Producto	= case	when Forward.mocodpos1 = 1		then 'Seguro de Cambio'
								when Forward.mocodpos1 = 2		then 'Arbitraje Forward'
								when Forward.mocodpos1 = 3		then 'Seguro de Inflacion'
								when Forward.mocodpos1 = 10		then 'Forward Bond Trades'
								when Forward.mocodpos1 = 13		then 'Segurop de Inflacion Hipotecario'
								when Forward.mocodpos1 = 14		then 
										case when sum( Forward.momtomon2 ) = 0 then 'Forward Starting' else 'Forward Observado' end
								else ''
		 	        	  end
		,	Tipo		= case	when Forward.motipoper	= 'C' then 'Compra' else 'Venta' end
		,	Moneda		= mon.mnnemo
		,	Nocional	= sum( Forward.momtomon1 )
		,	ContraMoneda= cnv.mnnemo
		,	Equivalente	= sum( Forward.xMonto ) 
		,	Cantidad	= count(1)
		,	Año			= year(Forward.mofecha)
		,	Mes			= month(Forward.mofecha)
		,	Estado		= case when Forward.moestado = 'A' then 'ANULADAS' else 'VIGENTES' end 
	FROM	
		(	SELECT	mocodigo, mocodcli, mocodpos1, motipoper, monumoper, momtomon1, motipmoda, mocodmon1, mocodmon2, momtomon2, mofecha, moequmon1
				,	xMonto = case when mocodpos1 = 14 and momtomon2 = 0 then moequmon1 else momtomon2  end
				,	moestado 
			FROM	BacFwdSuda.dbo.MFMO with(nolock)
			WHERE	mofecha		between @dFechaInicio and @dFechaTermino
			and		moestado	= ''
					union
			SELECT	mocodigo, mocodcli, mocodpos1, motipoper, monumoper, momtomon1, motipmoda, mocodmon1, mocodmon2, momtomon2, mofecha, moequmon1
				,	xMonto = case when mocodpos1 = 14 and momtomon2 = 0 then moequmon1 else momtomon2  end
				,	moestado
			FROM	BacFwdSuda.dbo.MFMOH with(nolock)
			WHERE	mofecha between @dFechaInicio and @dFechaTermino
			and		moestado	= ''

					union
			SELECT	cacodigo, cacodcli, cacodpos1, catipoper, canumoper, camtomon1, catipmoda, cacodmon1, cacodmon2, camtomon2, cafecha, caequmon1
				,	xMonto	= case when cacodpos1 = 14 and camtomon2 = 0 then caequmon1 else camtomon2 end
				,	caestado
			from	BacFwdSuda.dbo.mfca_log with(nolock)
			WHERE	cafecha between @dFechaInicio and @dFechaTermino
			and		caestado = 'A'
			
		)	Forward
			left join bacparamsuda.dbo.moneda mon with(nolock) on mon.mncodmon = forward.mocodmon1
			left join bacparamsuda.dbo.moneda cnv with(nolock) on cnv.mncodmon = forward.mocodmon2
	GROUP 
	BY		year(Forward.mofecha)
		,	month(Forward.mofecha)
		,	Forward.mocodpos1
		,	Forward.motipoper
		,	mon.mnnemo
		,	cnv.mnnemo
		,	Forward.moestado
	ORDER 
	BY		year(Forward.mofecha)
		,	month(Forward.mofecha)
		,	Forward.mocodpos1
		,	mon.mnnemo
		,	Forward.motipoper
		,	Forward.moestado
end

if (@omodulo = 'pcs')
begin
	SELECT	Modulo		= 'Swap'
		,	Periodo		= case	when ltrim(rtrim( month(Swap.fecha_cierre) )) <= 9 then '0' + ltrim(rtrim( month(Swap.fecha_cierre) ))
								else ltrim(rtrim( month(Swap.fecha_cierre) ))
							end	+ '-' + ltrim(rtrim(  year(Swap.fecha_cierre) ))
		,	Producto	= Swap.Producto 
		,	Tipo		= 'N/A'
		,	Moneda		= Swap.compra_moneda
		,	Nocional	= sum( Swap.compra_capital )
		,	ContraMoneda= Swap.venta_moneda
		,	Equivalente	= sum( Swap.venta_capital )
		,	Cantidad	= count(1)
		,	Año			= year(Swap.fecha_cierre)
		,	Mes			= month(Swap.fecha_cierre)
		,	estado		= 'VIGENTES'
	FROM
	(
		SELECT	tipo_swap		= SwapActivo.tipo_swap
			,	tipo_flujo		= SwapActivo.tipo_flujo
			,	fecha_cierre	= SwapActivo.fecha_cierre
			,	compra_moneda	= mon.mnnemo
			,	compra_capital	= SwapActivo.compra_capital
			,	venta_moneda	= cnv.mnnemo
			,	venta_capital	= SwapPasivo.venta_capital
			,	Producto		= case	when SwapActivo.tipo_swap = 1 then 'IRS'
										when SwapActivo.tipo_swap = 2 then 'CCS'
										when SwapActivo.tipo_swap = 3 then 'FRA'
										when SwapActivo.tipo_swap = 4 then 'Swap Promedio Camara'
									end
		FROM	
			(	SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, compra_capital, compra_moneda, compra_codigo_tasa
				FROM	BacSwapSuda.dbo.MovDiario with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				and		tipo_Flujo		= 1
				and		Estado <> 'P'
					union
				SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, compra_capital, compra_moneda, compra_codigo_tasa
				FROM	BacSwapSuda.dbo.MovHistorico with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				and		tipo_Flujo		= 1
				and		Estado <> 'P'
			)	SwapActivo
		left join
			(	SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, venta_capital, venta_moneda, venta_codigo_tasa
			 	FROM	BacSwapSuda.dbo.MovDiario with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				AND		tipo_Flujo		= 2
				and		Estado <> 'P'
					union
				SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, venta_capital, venta_moneda, venta_codigo_tasa
				FROM	BacSwapSuda.dbo.MovHistorico with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				AND		tipo_Flujo		= 2
				and		Estado <> 'P'
			)	SwapPasivo		On	SwapPasivo.numero_operacion	= SwapActivo.numero_operacion
		left join bacparamsuda.dbo.moneda mon with(nolock) on mon.mncodmon = SwapActivo.compra_moneda
		left join bacparamsuda.dbo.moneda cnv with(nolock) on cnv.mncodmon = SwapPasivo.venta_moneda
	)	Swap
	group 
	by		year(Swap.fecha_cierre)
		,	month(Swap.fecha_cierre)
		,	Swap.Producto
		,	Swap.compra_moneda
		,	Swap.venta_moneda
	/*
	order 
	by		year(Swap.fecha_cierre)
		,	month(Swap.fecha_cierre)
		,	Swap.Producto
		,	Swap.compra_moneda
		,	Swap.venta_moneda
	*/
		union

	SELECT	Modulo		= 'Swap'
		,	Periodo		= case	when ltrim(rtrim( month(Swap.fecha_cierre) )) <= 9 then '0' + ltrim(rtrim( month(Swap.fecha_cierre) ))
								else ltrim(rtrim( month(Swap.fecha_cierre) ))
							end	+ '-' + ltrim(rtrim(  year(Swap.fecha_cierre) ))
		,	Producto	= Swap.Producto 
		,	Tipo		= 'N/A'
		,	Moneda		= Swap.compra_moneda
		,	Nocional	= sum( Swap.compra_capital )
		,	ContraMoneda= Swap.venta_moneda
		,	Equivalente	= sum( Swap.venta_capital )
		,	Cantidad	= count(1)
		,	Año			= year(Swap.fecha_cierre)
		,	Mes			= month(Swap.fecha_cierre)
		,	estado		= 'ANULADAS'
	FROM
	(
		SELECT	tipo_swap		= SwapActivo.tipo_swap
			,	tipo_flujo		= SwapActivo.tipo_flujo
			,	fecha_cierre	= SwapActivo.fecha_cierre
			,	compra_moneda	= mon.mnnemo
			,	compra_capital	= SwapActivo.compra_capital
			,	venta_moneda	= cnv.mnnemo
			,	venta_capital	= SwapPasivo.venta_capital
			,	Producto		= case	when SwapActivo.tipo_swap = 1 then 'IRS'
										when SwapActivo.tipo_swap = 2 then 'CCS'
										when SwapActivo.tipo_swap = 3 then 'FRA'
										when SwapActivo.tipo_swap = 4 then 'Swap Promedio Camara'
									end
		FROM	
			(	
				SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, compra_capital, compra_moneda, compra_codigo_tasa
				FROM	BacSwapSuda.dbo.CarteraLog with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				and		tipo_Flujo		= 1
				and		Estado			= 'A'
			)	SwapActivo
		left join
			(	
				SELECT	DISTINCT numero_operacion, tipo_swap, tipo_flujo, fecha_cierre, venta_capital, venta_moneda, venta_codigo_tasa
				FROM	BacSwapSuda.dbo.CarteraLog with(nolock)
				WHERE	fecha_cierre	between @dFechaInicio and @dFechaTermino
				and		tipo_Flujo		= 2
				and		Estado			= 'A'
			)	SwapPasivo		On	SwapPasivo.numero_operacion	= SwapActivo.numero_operacion

		left join bacparamsuda.dbo.moneda mon with(nolock) on mon.mncodmon = SwapActivo.compra_moneda
		left join bacparamsuda.dbo.moneda cnv with(nolock) on cnv.mncodmon = SwapPasivo.venta_moneda
	)	Swap
	group 
	by		year(Swap.fecha_cierre)
		,	month(Swap.fecha_cierre)
		,	Swap.Producto
		,	Swap.compra_moneda
		,	Swap.venta_moneda
	order 
	by		year(Swap.fecha_cierre)
		,	month(Swap.fecha_cierre)
		,	Swap.Producto
		,	Swap.compra_moneda
		,	Swap.venta_moneda

end

if (@omodulo = 'opt')
begin

 	SELECT	Modulo		= 'Opciones'
		,	Periodo		= case	when month(Opciones.Fecha) <= 9 then '0' + ltrim(rtrim( month(Opciones.Fecha) )) 
								else ltrim(rtrim( month(Opciones.Fecha) ))
							end	+ '-' +  ltrim(rtrim( year(Opciones.Fecha) ))
		,	Producto	=  Opciones.Estructura
		,	Tipo		= 'N/A'
		
		,	Moneda		= mon.mnnemo
		,	Nocional	= sum(Opciones.Monto)
		,	ContraMoneda= cnv.mnnemo
		,	Equivalente	= sum(Opciones.Conversion)
		,	Cantidad	= count(1)
		,	Año			= year(Opciones.Fecha)
		,	Mes			= month(Opciones.Fecha)
		,	Estado		= Opciones.Estado
	FROM	
		(		
			select	MoNumContrato	= Enc.MoNumContrato
			,		MoNumFolio		= Det.MoNumFolio
			,		morutcliente	= enc.morutcliente
			,		Estructura		= OpcEstDsc
			,		Monto			= det.momontomon1 
			,		Vencido			= case when det.mofechavcto <= @dFechaTermino then det.momontomon1 else 0.0 end
			,		Saldo			= case when det.mofechavcto <= @dFechaTermino then 0.0 else det.momontomon1 end
			,		Fecha			= Enc.MoFechaContrato
			,		Moneda			= Det.MoCodMon1
			,		ContraMoneda	= Det.MoCodMon2
			,		Conversion		= det.momontomon2 
			,		Estado			= CASE WHEN MoTipoTransaccion = 'ANULA' THEN 'ANULADAS' ELSE 'VIGENTES' END 
			from	LNKOPC.CbMdbOpc.dbo.MoEncContrato Enc with(nolock)
					inner join LNKOPC.CbMdbOpc.dbo.MoDetContrato Det with(nolock) On Det.MoNumFolio = Enc.MoNumFolio
					inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = Enc.MoRutCliente and clcodigo = Enc.MoCodigo
					inner join LNKOPC.CbMdbOpc.dbo.OpcionEstructura with(nolock) On OpcEstCod = MoCodEstructura
			where	Enc.MoFechaContrato between @dFechaInicio and @dFechaTermino
			and	(	(MoEstado = '' and MoTipoTransaccion = 'CREACION' )
				or	(MoTipoTransaccion = 'ANULA' )
				)
			and	(	MoTipoTransaccion In('CREACION', 'ANULA') )
					union
			select	MoNumContrato	= Enc.MoNumContrato
			,		MoNumFolio		= Det.MoNumFolio
			,		morutcliente	= enc.morutcliente
			,		Estructura		= OpcEstDsc
			,		Monto			= det.momontomon1 
			,		Vencido			= case when det.mofechavcto <= @dFechaTermino then det.momontomon1 else 0.0 end
			,		Saldo			= case when det.mofechavcto <= @dFechaTermino then 0.0 else det.momontomon1 end
			,		Fecha			= Enc.MoFechaContrato
			,		Moneda			= Det.MoCodMon1
			,		ContraMoneda	= Det.MoCodMon2
			,		Conversion		= det.momontomon2
			,		Estado			= CASE WHEN MoTipoTransaccion = 'ANULA' THEN 'ANULADAS' ELSE 'VIGENTES' END
			from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato Enc with(nolock)
					inner join LNKOPC.CbMdbOpc.dbo.MoHisDetContrato	Det with(nolock) On Det.MoNumFolio = Enc.MoNumFolio
					inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = Enc.MoRutCliente and clcodigo = Enc.MoCodigo
					inner join LNKOPC.CbMdbOpc.dbo.OpcionEstructura with(nolock) On OpcEstCod = MoCodEstructura
			where	Enc.MoFechaContrato between @dFechaInicio and @dFechaTermino
			and	(	(	MoEstado = '' and MoTipoTransaccion = 'CREACION')
				or	(				      MoTipoTransaccion = 'ANULA')
				)
			and	(	MoTipoTransaccion in('CREACION','ANULA') )
		)	Opciones
			left join bacparamsuda.dbo.moneda mon with(nolock) on mon.mncodmon = Opciones.Moneda
			left join bacparamsuda.dbo.moneda cnv with(nolock) on cnv.mncodmon = Opciones.ContraMoneda

 	group 
 	by		year(Opciones.Fecha)
		,	month(Opciones.Fecha)
		,	Opciones.Estructura
		,	mon.mnnemo
		,	cnv.mnnemo
		,	Opciones.Estado
end

if (@omodulo = 'btr')
begin
	select 	Modulo		= 'Renta Fija Nacional'
		,	Periodo		= case	when month(Trader.mofecpro) <= 9 then '0' + ltrim(rtrim( month(Trader.mofecpro) )) 
								else ltrim(rtrim( month(Trader.mofecpro) ))
							end	+ '-' +  ltrim(rtrim( year(Trader.mofecpro) ))
		,	Producto	= case	when Trader.motipoper = 'CP' then 'Compra Definitiva '
								when Trader.motipoper = 'VP' then 'Venta Definitiva '
								when Trader.motipoper = 'CI' then 'Compra con Pacto '
								when Trader.motipoper = 'VI' then 'Venta con Pacto '
								when Trader.motipoper = 'IB' then 'Interbancario '
								else Trader.motipoper
							end + '-' + ltrim(rtrim( inserie ))
		,	Emision		= mon.mnnemo
		,	Nominal		= sum(Trader.monominal)
		,	Pesos		= sum(Trader.movpresen)
		,	Cantidad	= count(1)
		,	Año			= year(Trader.mofecpro)
		,	Mes			= month(Trader.mofecpro)
		,	Estado		= case when Trader.mostatreg = 'A' then 'ANULADAS' else 'VIGENTES' end
	from	
	(	select	mofecpro,monumoper, monumdocu, mocorrela, motipoper,momonemi,moinstser,monominal,movpresen, mocodigo, inserie, mostatreg
		from	BacTraderSuda.dbo.mdmo with(nolock)
				inner join BacParamSuda.dbo.Instrumento with(nolock) On incodigo = mocodigo
		where	mofecpro	between @dFechaInicio and @dFechaTermino
		and		motipoper	NOT IN('TM', 'RC','RV','RCA','RVA')
--		and		mostatreg	<> 'A' 
				union
		select	mofecpro,monumoper, monumdocu, mocorrela, motipoper,momonemi,moinstser,monominal,movpresen, mocodigo, inserie, mostatreg
		from	BacTraderSuda.dbo.mdmh with(nolock)
				inner join BacParamSuda.dbo.Instrumento with(nolock) On incodigo = mocodigo
		where	mofecpro	between @dFechaInicio and @dFechaTermino
		and		motipoper	NOT IN('TM', 'RC','RV','RCA','RVA') 	
		and		motipoper	<> 'TM'
--		and		mostatreg	<> 'A' 
	)	Trader
		left join bacparamsuda.dbo.moneda mon with(nolock) on mon.mncodmon = Trader.momonemi
	group  
	by	 
			year(Trader.mofecpro)
		,	month(Trader.mofecpro)		
		,	case	when Trader.motipoper = 'CP' then 'Compra Definitiva '
					when Trader.motipoper = 'VP' then 'Venta Definitiva '
					when Trader.motipoper = 'CI' then 'Compra con Pacto '
					when Trader.motipoper = 'VI' then 'Venta con Pacto '
					when Trader.motipoper = 'IB' then 'Interbancario '
					else Trader.motipoper
				end + '-' + ltrim(rtrim( inserie ))
		,	mon.mnnemo
		,	Trader.mostatreg
	order 
	by		year(Trader.mofecpro)
		,	month(Trader.mofecpro)		

end

if (@omodulo = 'bex')
begin
  
	SELECT  Modulo		= 'Renta Fija Extranjera'
		,	Periodo		= case	when month(Trader.mofecpro) <= 9 then '0' + ltrim(rtrim( month(Trader.mofecpro) )) 
								else ltrim(rtrim( month(Trader.mofecpro) ))
							end	+ '-' +  ltrim(rtrim( year(Trader.mofecpro) ))
		,	Producto	= case	when Trader.motipoper = 'CP' then 'Compra Definitiva '
								when Trader.motipoper = 'VP' then 'Venta Definitiva '
								when Trader.motipoper = 'CI' then 'Compra con Pacto '
								when Trader.motipoper = 'VI' then 'Venta con Pacto '
								when Trader.motipoper = 'IB' then 'Interbancario '
								else Trader.motipoper
							end + ltrim(rtrim( Trader.Nom_Familia ))
		,	Emision		= mon.mnnemo
		,	Nominal		= sum(Trader.monominal)
		,	Pesos		= sum(Trader.movpresen)
		,	Cantidad	= count(1)
		,	Año			= year(Trader.mofecpro)
		,	Mes			= month(Trader.mofecpro)
		,	Estado		= case when Trader.mostatreg = 'A' then 'ANULADAS' else 'VIGENTES' end
	FROM	
		(	select	dri.mofecpro,dri.monumoper,dri.monumdocu,dri.mocorrelativo,dri.motipoper,dri.cod_nemo,dri.momonemi,dri.monominal,dri.movpresen, dri.cod_familia
				,	fml.Nom_Familia
				,	mostatreg
		 	from	bacbonosextsuda.dbo.text_mvt_dri dri with(nolock)
					inner join bacbonosextsuda.dbo.text_fml_inm fml with(nolock) on fml.Cod_familia =dri.cod_familia  		 	
			where	dri.mofecpro between @dFechaInicio and @dFechaTermino
		--	and		dri.mostatreg <> 'A'	
		)	Trader	
			left join bacparamsuda.dbo.moneda mon on mon.mncodmon = Trader.momonemi
	GROUP  
	BY	 
			year(Trader.mofecpro)
		,	month(Trader.mofecpro)		
		,	case	when Trader.motipoper = 'CP' then 'Compra Definitiva '
					when Trader.motipoper = 'VP' then 'Venta Definitiva '
					when Trader.motipoper = 'CI' then 'Compra con Pacto '
					when Trader.motipoper = 'VI' then 'Venta con Pacto '
					when Trader.motipoper = 'IB' then 'Interbancario '
					else Trader.motipoper
				end + ltrim(rtrim( Trader.Nom_Familia ))
		,	mon.mnnemo
		,	Trader.mostatreg
	ORDER 
	BY		year(Trader.mofecpro)
		,	month(Trader.mofecpro)		

end

if (@omodulo = 'bcc')
begin

	SELECT  Modulo		= 'Spot'
		,	Periodo		= case	when month(Spot.mofech) <= 9 then '0' + ltrim(rtrim( month(Spot.mofech) )) 
								else ltrim(rtrim( month(Spot.mofech) ))
							end	+ '-' +  ltrim(rtrim( year(Spot.mofech) ))
		,	Producto	= case	when Spot.motipmer = 'ptas' then 'Interbancarios'
								when Spot.motipmer = 'empr' then 'Empresas'
								when Spot.motipmer = 'arbi'  then 'Arbitrajes'
								else Spot.motipmer
							end
		,	Tipo		= case	when Spot.motipope	= 'C' then 'Compra' else 'Venta' end
		,	Moneda		= Spot.mocodmon
		,	Nominal		= sum(Spot.momonmo)
		,	Pesos		= sum(Spot.momonpe)
		,	Cantidad	= count(1)
		,	Año			= year(Spot.mofech)
		,	Mes			= month(Spot.mofech)
		,	Estado		= case when Spot.moestatus = 'A' then 'ANULADAS' else 'VIGENTES' end
	FROM	
		(	Select	mofech, monumope,	motipope, motipmer, mocodmon, mocodcnv, momonmo, moussme, momonpe, moestatus
			from	BacCamSuda.dbo.Memo with(nolock)
			where	mofech		between @dFechaInicio and @dFechaTermino
--			and		moestatus	<> 'A' 
			and		motipmer	<> 'CCBB'
					union
			select	mofech, monumope,	motipope, motipmer, mocodmon, mocodcnv, momonmo, moussme, momonpe, moestatus
			from	BacCamSuda.dbo.Memoh with(nolock)
			where	mofech		between @dFechaInicio and @dFechaTermino
--			and		moestatus	<> 'A'
			and		motipmer	<> 'CCBB'	 
		)	Spot
	GROUP 
	BY
			year(Spot.mofech)
		,	month(Spot.mofech)
		,	Spot.motipmer
		,	Spot.motipope	
		,	Spot.mocodmon
		,	Spot.moestatus
	ORDER
	BY		
			year(Spot.mofech)
		,	month(Spot.mofech)
		,	Spot.motipmer
		,	Spot.motipope	
		,	Spot.mocodmon		
end

end
GO

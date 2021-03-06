USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS_VI_SERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS_VI_SERIADO]
as
begin
	
	set nocount on
	
	declare @dFechaMercado		datetime
	declare @dFechaCartera		datetime
	declare @dFechaProceso		datetime

	select	@dFechaMercado			= case	when month(ct.acfecproc) <> month(ct.acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(ct.acfecproc)*-1),ct.acfecproc))))
												else ct.acfecproc
	      									end
		,	@dFechaCartera			= case	when month(ct.acfecproc) <> month(ct.acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(ct.acfecproc)*-1),ct.acfecproc))))
												else ct.acfecprox
		 	              					end
		,	@dFechaProceso			= ct.acfecproc
	from	( select	acfecproc	--	= '20160728' --> '20160729'
				,		acfecprox	--	= '20160729' --> '20160801'		
	    	  from		BacTraderSuda.dbo.mdac with(nolock)
			)	ct

	select	transaction_deal_num						= TraderVi.Documento
		,	transaction_status_id						= 0
		,	transaction_trade_date						= convert(varchar(30), @dFechaProceso, 126)  
		,	transaction_start_date						= convert(varchar(30), TraderVi.FechaEmision, 126)
		,	transaction_end_date						= convert(varchar(30), TraderVi.FechaVencimiento, 126)
		,	transaction_ET								= '1900-01-01T00:00:00'
		,	transaction_modalidad_pago					= 0
		,	transaction_paymentconv_id					= 0
		,	transaction_nemo							= TraderVi.Mascara
		,	transaction_serie							= TraderVi.Serie
		,	transaction_TIR_compra						= case when isnull(TraderVi.TirCompra, 0.0) = 0 then '0' else TraderVi.TirCompra end  
		,	transaction_TIR_mercado						= TraderVi.TirMercado
		,	transaction_strike							= 0
		,	transaction_id_group						= TraderVi.Documento
		,	side_type									= 1
		,	side_fix_flt								= 2
		,	side_frec_p									= convert(varchar, datediff(day, TraderVi.FechaCompra, TraderVi.FechaVencimiento)) + 'd'
		,	side_reset_p								= '0d'
		,	side_notional								= TraderVi.Nominales
		
		,	side_notional_ccy_id						= dbo.Fx_Convalida_Pais_ODS('ODS', convert(varchar, TraderVi.MonedaEmision))
		,	side_payment_ccy_id							= dbo.Fx_Convalida_Pais_ODS('ODS', convert(varchar, TraderVi.MonedaEmision))

		,	side_rate									= 0
		,	side_rate_spread							= 0
		,	side_rate_type_id							= 0
		,	side_projection_index						= 0
		,	side_yield_basis_id							= 0
		,	interest_id									= 0
		,	interest_start_date							= case	when TraderVi.FechaEmision is null then '1900-01-01T00:00:00' 
																else convert(varchar(30), TraderVi.FechaEmision, 126)
															end 
		,	interest_end_date							= convert(varchar(30), TraderVi.FechaVencimiento , 126) 
		,	interest_payment_date						= convert(varchar(30), TraderVi.FechaVencimiento, 126)   
		,	interest_fixing_date						= '1900-01-01T00:00:00'
		,	interest_fixing_rate						= 0
		,	interest_accounting_date					= convert(varchar(30), @dFechaProceso, 126) 
		,	interest_rate								= TraderVi.TirEmision
		,	interest_payment							= isnull(TraderVi.Interes,0)
		,	interest_df									= 0
		,	interest_npv								= 0
		,	cashflow_id									= TraderVi.NumeroCupon
		,	cashflowtype_id								= 1
		,	cashflow_start_date							= convert(varchar(30), TraderVi.FechaEmision , 126)
		,	cashflow_end_date							= convert(varchar(30), TraderVi.FechaVencimiento, 126)
		,	cashflow_accounting_date					= convert(varchar(30), @dFechaProceso, 126)
		,	cashflow_fixing_date						= '1900-01-01T00:00:00'
		,	cashflow_fixing_rate						= isnull(TraderVi.TirCompra, 0)
		,	cashflow_amount								= isnull(TraderVi.Amortizacion, 0)
		,	cashflow_df									= 0
		,	cashflow_npv								= 0
		,	facility_id									= 10
		,	transaction_info_tc_costo					= 0
		,	transaction_info_tc_cliente					= 0
		,	transaction_info_paridad_costo				= 0 
		,	transaction_info_paridad_cliente			= 0
		,	transaction_info_spread_tc					= 0
		,	transaction_info_spread_paridad				= 0
		,	transaction_info_fx_spot_cliente			= 0
		,	transaction_info_fx_fwd_costo				= 0
		,	transaction_info_fx_fwd_cliente				= 0
		,	transaction_info_puntos_fwd					= 0
		,	transaction_info_fx_uf_spot					= 0
		,	transaction_info_fx_uf_tasa_costo			= 0
		,	transaction_info_fx_uf_tasa_margen			= 0
		,	transaction_info_fx_uf_tasa_cliente			= 0
		,	transaction_info_fx_spot_margen				= 0
		,	transaction_info_fx_fwd_margen				= 0
		,	transaction_info_fx_uf_tasa_sucia_costo		= 0
		,	transaction_info_fx_uf_tasa_sucia_cliente	= 0
		,	equivalente_credito_corporativo				= 0
		,	equivalente_credito_normativo				= 0
		,	equivalente_credito_factor					= 0
		,	equivalente_credito_factor_inter			= 0
		,	equivalente_credito_factor_normativo		= 0

		,	medio_transaccional_id						= dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(TraderVi.Usuario))
		
		,	canal_transaccional_id						= BacParamSuda.dbo.fx_mesa_operador_ID(TraderVi.Usuario)	
		,	profit_value								= isnull(TraderVi.Utilidad, 0)

		,	profit_ccy_id								= dbo.Fx_Convalida_Pais_ODS('ODS', '999')
		 
		,	profit_mesa_clientes_clp					= 0
		,	profit_mesa_trading_clp						= 0
		,	portfolio_id								= TraderVi.CarteraFinanciera
		,	instrument_id								= 1000004
		,	product_id									= 5
		,	party_id									= TraderVi.Rut
		,	party_rut									= TraderVi.RutDv

		,	party_secuencia								= dbo.Fx_Tipo_Contraparte_ODS (TraderVi.Rut, TraderVi.Codigo)
		
		,	pricing_mtm									= convert(varchar, format( TraderVi.ValorMercado, N'#0.########################'))

		,	pricing_mtm_ccy_id							= dbo.Fx_Convalida_Pais_ODS('ODS', '999')

		,	pricing_base_mtm							= convert(varchar, format( TraderVi.ValorMercado, N'#0.########################'))
		,	pricing_pnl									= 0
		,	pricing_pnl_fx_unrealized					= 0
		,	pricing_delta								= TraderVi.ValorPresente
		,	pricing_gamma								= 0
		,	pricing_vega								= 0
		,	pricing_beta								= 0
		,	pricing_rho_local							= 0
		,	pricing_rho_foranea							= 0
		,	pricing_theta								= 0
		,	pricing_volga								= 0
		,	side_id 									= 0
		,	call_put_id									= 0
		,	Orden										= 1 
		----------------------------------------------------------------------------
		,	[transaction_emisor_id]						= TraderVi.RutEmisor
		,	[transaction_plazo_pacto]					= TraderVi.PlazoPacto
		,	[transaction_tasa_costo_pacto]				= TraderVi.TasaCostoPacto
		,	[transaction_tasa_pacto]					= TraderVi.TasaPacto
		,	[transaction_tir_compra_origen]				= TraderVi.TirCompraOriginal
		,	[transaction_tir_compra_ppa]				= TraderVi.TirCompraPPA
		,	[transaction_dev_tir_compra]				= TraderVi.DevengoTirCompra
		,	[transaction_tipo_operacion_id]				= TraderVi.TipoOperacion
		,	[transaction_fecha_compra_ins]				= convert(varchar(30),TraderVi.FechaCompraInst   ,126)
		,	[transaction_fecha_cupon]					= convert(varchar(30),TraderVi.FechaCupon		,126)
		----------------------------------------------------------------------------
		,	[Cuenta_GL]									= convert(varchar(20), '0')
		,	[Cuenta_SBIF]								= convert(varchar(20), '0')
		,	[cashflow_amount_add]						= convert(varchar(20), '0')
		,	[portfolio_super]							= TraderVi.portfolio_super --> Descripcion de la Cartera Normativa
		,	[portfolio_scn]								= TraderVi.portfolio_scn
		,	[side_discount_index]						= ''
		,	[interest_rate_icp]							= '0'

		,	[TRANSACTION_OPTION_DESC]					= ''
		--,	[Valor_Nocional_pagado]						= '0'
		,	[TRANSACTION_OPTION_CV]						= '' --mgc.11.08.2017 Se agrega Columna
		/* Nuevos Campos */
		,	pricing_mtm_itau							= convert(varchar, format( TraderVi.ValorMercado, N'#0.########################'))
		,	pricing_base_mtm_itau						= convert(varchar, format( TraderVi.ValorMercado, N'#0.########################'))
		,	transaction_info_party_original				= TraderVi.Rut
	from
		(
			select	Documento			=	cartera.vinumdocu
				,	FechaEmision		=	cartera.vifecemi
				,	FechaVencimiento	=	cartera.vifecven
				,	FechaCompra			=	cartera.vifeccomp
				,	Mascara				=	cartera.vimascara
				,	Serie				=	cartera.viinstser
				,	TirCompra			=	cartera.vitircomp
				,	TirMercado			=	mercado.tasa_mercado
				,	TirEmision			=	series.setasemi
				,	Nominales			=	cartera.vinominal
				,	ValorPresente		=	cartera.vivptirc
				,	ValorMercado		=	mercado.valor_mercado
				,	MonedaEmision		=	mercado.moneda_emision
				,	Interes				=	resultado.rsinteres_acum
				,	NumeroCupon			=	cartera.vinumucupv
				,	Amortizacion		=	resultado.rscupamo
				,	Usuario				=	movimiento.mousuario
				,	Utilidad			=	movimiento.moutilidad
				,	CarteraFinanciera	=	cartera.Tipo_Cartera_Financiera
				,	Rut					=	cliente.clrut
				,	RutDv				=	ltrim(rtrim( cliente.clrut )) + '-' + ltrim(rtrim( cliente.cldv ))
				,	Codigo				=	cliente.clcodigo
				--------------------------------------------------------------
				, 	RutEmisor			= Emi.Rut
				,	NombreEmisor		= isnull(Emi.Nombre, 'sin nombre')
				,	PlazoPacto			= cartera.PlazoPacto
				,	TasaCostoPacto		= cartera.TasaCostoPacto
				,	TasaPacto			= cartera.TasaPacto
				,	TirCompraOriginal	= cartera.TirCompraOrig
				,	TirCompraPPA		= cartera.TirCompraPPA
				,	DevengoTirCompra	= resultado.rsinteres
				,	TipoOperacion		= 4 --> 'VI'
				,	FechaCompraInst		= cartera.FechaCompraInst
				,	FechaCupon			= cartera.FechaCorteCupon
				--------------------------------------------------------------
				,	portfolio_super		= isnull(cNorma.Descripcion, '')
				,	portfolio_scn		= ''

			from	
				(	select	vinumdocu,	vicorrela,	vinumoper
						,	virutcli,	vicodcli
						,	vinominal,	viseriado,	vimascara,	viinstser,	vicodigo 
						,	vifecemi,	vifecven,	vifeccomp,	vinumucupv,	vitircomp, vivptirc
						,	Tipo_Cartera_Financiera
						--------------------------------
						,	RutEmisor		= virutemi
						,	PlazoPacto		= datediff(day, vifecinip, vifecvenp)
						,	TasaCostoPacto	= 0.0
						,	TasaPacto		= vitaspact
						,	TirCompraOrig	= vitircomp
						,	TirCompraPPA	= case when vitipoper = 'CP' then vitircomp else 0.0 end 
						,	TirMercado		= 0.0
						,	FechaCompraInst	= vifeccomp
						,	FechaCorteCupon	= vifecucup
						--------------------------------
						,	CNormativa		= codigo_carterasuper
					from	BacTraderSuda.dbo.mdvi with(nolock)
					where	vinominal > 0 and viseriado = 'S'
				)	Cartera
				inner join 
				(	select  rmnumoper,rmnumdocu,rmcorrela, valor_nominal,tasa_compra,valor_presente,tasa_mercado,valor_mercado, diferencia_mercado, moneda_emision 
		 			from	BacTradersuda.dbo.Valorizacion_mercado with(nolock)
		 			where	fecha_valorizacion	= @dFechaMercado
		 			and		tipo_operacion		= 'VI' 
				)	Mercado		On	Mercado.rmnumoper	= cartera.vinumoper
								and	Mercado.rmnumdocu	= cartera.vinumdocu
								and Mercado.rmcorrela	= cartera.vicorrela
				inner join 
				(	select	rsfecha, rsnumoper, rsnumdocu, rscorrela, rsinteres_acum, rscupamo, rstipoper
						------------------
						,	rsinteres
						------------------ 
		 			from	BacTraderSuda.dbo.Mdrs with(nolock) 
					where	rsfecha					= @dFechaCartera
					and		rstipoper				= 'DEV'
					and		rscartera				= 114 
				)	Resultado	On	Resultado.rsnumoper	= Cartera.vinumoper
								and	Resultado.rsnumdocu	= Cartera.vinumdocu
								and	Resultado.rscorrela	= Cartera.vicorrela
				inner join
				(	select	secodigo, semascara, sefecemi, sefecven, setasemi, BacParamSuda.dbo.serie.seserie 
		 			from	BacParamSuda.dbo.serie with(nolock)
				)	Series		On	Series.secodigo		= Cartera.vicodigo
								and	Series.semascara	= Cartera.vimascara
								and Series.seserie		= case when Series.secodigo	= 20 then Cartera.vimascara else Cartera.viinstser end  

				inner join
				(	select	clrut, clcodigo, cldv, clnombre
		 			from	BacParamSuda.dbo.Cliente with(nolock)
				)	Cliente		On	cliente.clrut		= Cartera.virutcli
								and	cliente.clcodigo	= Cartera.vicodcli
						
				left join
				(	select	monumoper, monumdocu, mocorrela, mousuario, moutilidad, moperdida
		 			from	BacTraderSuda.dbo.mdmo with(nolock) 
		 			where	motipoper = 'VI' and not mostatreg in('R', 'P', 'A')
		 				union
		 			select	monumoper, monumdocu, mocorrela, mousuario, moutilidad, moperdida
		 			from	BacTraderSuda.dbo.mdmh with(nolock)
		 			where	motipoper = 'VI' and not mostatreg in('R', 'P', 'A')
				)	Movimiento	On	Movimiento.monumoper	= Cartera.vinumoper
								and	Movimiento.monumdocu	= Cartera.vinumdocu
								and	Movimiento.mocorrela	= Cartera.vicorrela
				
				---------------------------------------------------
				left join
				(	select	Rut		= emrut
						,	Nombre	= emnombre
						,	Generico= emgeneric  
				 	from	bacparamsuda.dbo.emisor with(nolock)
				)	emi		on emi.rut	= cartera.RutEmisor  
				---------------------------------------------------
				left join
				(	select	Id = tbcodigo1
						,	Descripcion	= tbglosa
					from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) 
					where	tbcateg = 1111
				)	cNorma	On cNorma.Id = cartera.CNormativa


		)	TraderVi

end
GO

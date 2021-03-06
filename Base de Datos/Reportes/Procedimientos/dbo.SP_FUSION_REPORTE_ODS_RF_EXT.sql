USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS_RF_EXT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS_RF_EXT]
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

	select	transaction_deal_num						= Trader.Documento
		,	transaction_status_id						= 1
		,	transaction_trade_date						= convert(varchar(30), Trader.FechaProceso, 126) 
		,	transaction_start_date						= convert(varchar(30), Trader.FechaEmision, 126)  
		,	transaction_end_date						= convert(varchar(30), Trader.FechaVencimiento, 126)   
		,	transaction_ET								= '1900-01-01T00:00:00'
		,	transaction_modalidad_pago					= 0
		,	transaction_paymentconv_id					= 0
		,	transaction_nemo							= Trader.Nemo
		,	transaction_serie							= Trader.Id
		,	transaction_TIR_compra						= case	when isnull(Trader.TirCompra,0) = 0 then '0' else Trader.TirCompra end
		,	transaction_TIR_mercado						= Trader.TirMercado
		,	transaction_strike							= 0
		,	transaction_id_group						= Trader.Documento
		,	side_type									= 1
		,	side_fix_flt								= 2
		,	side_frec_p									= convert(varchar, datediff(day, Trader.FechaCompra, Trader.FechaVencimiento) ) + 'd'
		,	side_reset_p								= '0d'
		,	side_notional								= Trader.Nominal
		,	side_notional_ccy_id						= dbo.Fx_Convalida_Pais_ODS('ODS', convert(varchar, Trader.MonedaEmision))
		,	side_payment_ccy_id							= dbo.Fx_Convalida_Pais_ODS('ODS', convert(varchar, Trader.MonedaEmision))
		,	side_rate									= 0
		,	side_rate_spread							= 0
		,	side_rate_type_id							= 0			
		,	side_projection_index						= 0			
		,	side_yield_basis_id							= 4
		,	interest_id									= isnull(Trader.Cupones, 0)
		,	interest_start_date							= case	when Trader.Familia <> 2000 then '1900-01-01T00:00:00'
																else convert(varchar(30), Trader.FechaEmision, 126)
															end 
		,	interest_end_date							= case	when Trader.Familia <> 2000 then '1900-01-01T00:00:00'
																else convert(varchar(30), Trader.FechaVencimiento, 126)
															end 
		,	interest_payment_date						= case	when Trader.Familia <> 2000 then '1900-01-01T00:00:00'
																else convert(varchar(30), Trader.FechaVencimiento, 126)
		 	                     							end
		,	interest_fixing_date						= '1900-01-01T00:00:00'
		,	interest_fixing_rate						= isnull(Trader.Pvp, 0.0)							-->> Revision de Valor
		,	interest_accounting_date					= convert(varchar(30), Trader.FechaProceso, 126)  	
		,	interest_rate								= 0 -->	Trader.TirEmision
		,	interest_payment							= isnull(Trader.Interes, 0)
		,	interest_df									= ISNULL(Trader.TirCompra, 0)
		,	interest_npv								= 0
		,	cashflow_id									= isnull(Trader.Cupon, 0)
		,	cashflowtype_id								= 1
		,	cashflow_start_date							= case	when Trader.Familia <> 2000 then '1900-01-01T00:00:00'
																else convert(char(30), Trader.FechaVencimiento, 126)
															end
		,	cashflow_end_date							= case	when Trader.Familia <> 2000 then '1900-01-01T00:00:00'
																else convert(char(30), Trader.FechaVencimiento, 126)
															end

		,	cashflow_accounting_date					= convert(varchar(30), Trader.FechaProceso, 126)  
		,	cashflow_fixing_date						= '1900-01-01T00:00:00'
		,	cashflow_fixing_rate						= isnull(Trader.TirCompra, 0)
		,	cashflow_amount								= isnull(Trader.Amortizacion, 0)
		,	cashflow_df									= 0
		,	cashflow_npv								= 0		
		,	facility_id									= 9			
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
		,	medio_transaccional_id						= dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(Trader.Usuario))
		,	canal_transaccional_id						= BacParamSuda.dbo.fx_mesa_operador_ID(Trader.Usuario)
		,	profit_value								= isnull(Trader.Utilidad, 0)		
		,	profit_ccy_id								= dbo.Fx_Convalida_Pais_ODS('ODS', '999') 
		,	profit_mesa_clientes_clp					= 0
		,	profit_mesa_trading_clp						= 0		
		,	portfolio_id								= Trader.TipoCartera
		,	instrument_id								= 1000004
		,	product_id									= 5
		,	party_id									= Trader.Rut
		,	party_rut									= Trader.RutDv
		
		,	party_secuencia								= dbo.Fx_Tipo_Contraparte_ODS(Trader.Rut, Trader.Codigo)
		,	pricing_mtm									= convert(varchar,format(ISNULL(Trader.ValorMercado, 0),N'#0.########################'))
		,	pricing_mtm_ccy_id							= dbo.Fx_Convalida_Pais_ODS('ODS', '13')
		,	pricing_base_mtm							= convert(varchar,format(ISNULL(Trader.ValorMercado, 0),N'#0.########################'))
		,	pricing_pnl									= 0
		,	pricing_pnl_fx_unrealized					= 0
		,	pricing_delta								= Trader.ValorPresente
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
		,	[transaction_emisor_id]						= Trader.RutEmisor
		,	[transaction_plazo_pacto]					= Trader.PlazoPacto
		,	[transaction_tasa_costo_pacto]				= Trader.TasaCostoPacto
		,	[transaction_tasa_pacto]					= Trader.TasaPacto
		,	[transaction_tir_compra_origen]				= Trader.TirCompraOriginal
		,	[transaction_tir_compra_ppa]				= Trader.TirCompraPPA
--		,	TirMercado									= Trader.TirMercado
		,	[transaction_dev_tir_compra]				= Trader.DevengoTirCompra
		,	[transaction_tipo_operacion_id]				= Trader.TipoOperacion
		,	[transaction_fecha_compra_ins]				= convert(varchar(30),Trader.FechaCompraInst   ,126)
		,	[transaction_fecha_cupon]					= convert(varchar(30),Trader.FechaCupon		,126)
		----------------------------------------------------------------------------
		,	[Cuenta_GL]									= convert(varchar(20), '0')
		,	[Cuenta_SBIF]								= convert(varchar(20), '0')
		,	[cashflow_amount_add]						= convert(varchar(20), '0')
		,	[portfolio_super]							= Trader.portfolio_super --> Descripcion de la Cartera Normativa
		,	[portfolio_scn]								= Trader.portfolio_scn
		,	[side_discount_index]						= ''
		,	[interest_rate_icp]							= '0'

		,	[TRANSACTION_OPTION_DESC]					= ''
		--,	[Valor_Nocional_pagado]						= '0'
		,	[TRANSACTION_OPTION_CV]						= '' --mgc.11.08.2017 Se agrega Columna
		/* Nuevos Campos */
		,	pricing_mtm_itau							= convert(varchar,format(ISNULL(Trader.ValorMercado, 0),N'#0.########################'))
		,	pricing_base_mtm_itau						= convert(varchar,format(ISNULL(Trader.ValorMercado, 0),N'#0.########################'))
		,   transaction_info_party_original				= Trader.Rut
	from
		(
			select	Documento			= cartera.cpnumdocu
				,	Correlativo			= cartera.cpcorrelativo
				,	FechaProceso		= @dFechaProceso
				,	FechaEmision		= cartera.cpfecemi
				,	FechaVencimiento	= cartera.cpfecven
				,	FechaCompra			= cartera.cpfeccomp
				,	Nemo				= cartera.cod_nemo
				,	Familia				= cartera.cod_familia
				,	Id					= cartera.id_instrum
				,	TirCompra			= cartera.cptircomp
				,	TirMercado			= resultado.rstirmerc
				,	TirEmision			= resultado.rstasemi
				,	Nominal				= cartera.cpnominal
				,	MonedaEmision		= resultado.rsmonemi
				,	Usuario				= movimiento.mousuario
				,	Utilidad			= movimiento.moutilidad
				,	TipoCartera			= cartera.tipo_cartera_financiera
				,	Rut					= cliente.clrut
				,	RutDv				= ltrim(rtrim( cliente.clrut )) + '-' + ltrim(rtrim( cliente.cldv ))
				,	Codigo				= cliente.clcodigo
				,	Cupones				= serie.per_cupones
				,	Cupon				= cartera.cpnumucup
				,	Pvp					= cartera.Cppvpcomp
				,	Interes				= resultado.rsinteres_acum
				,	Amortizacion		= resultado.rscupamo
				,	ValorPresente		= cartera.cpvptirc
				,	ValorMercado		= resultado.rsvalmerc
				--------------------------------------------------------------
				,	RutEmisor			= emi.Rut
				,	NombreEmisor		= isnull(Emi.Nombre, 'sin nombre')
				,	PlazoPacto			= 0
				,	TasaCostoPacto		= 0.0
				,	TasaPacto			= 0.0
				,	TirCompraOriginal	= cartera.cptircomp
				,	TirCompraPPA		= 0.0
				,	DevengoTirCompra	= resultado.rsinteres
				,	TipoOperacion		= 1 --> 'CP'
				,	FechaCompraInst		= cartera.cpfeccomp
				,	FechaCupon			= cartera.cpfecucup
				--------------------------------------------------------------
				,	portfolio_super		= isnull(cNorma.Descripcion, '')
				,	portfolio_scn		= ''

			from	
				(	select	cpnumdocu, cpcorrelativo
						,	cpfeccomp, cpfecemi, cpfecven, cod_nemo, cod_familia, id_instrum
						,	cptircomp, cpnominal,Cppvpcomp, cpnumucup, cpvptirc
						,	tipo_cartera_financiera, cprutcli, cpcodcli
						-------------------------------
						,	cprutemi
						,	cpfecucup
						-------------------------------
						,	CNormativa	= codigo_carterasuper
				 	from	BacBonosExtSuda.dbo.text_ctr_inv with(nolock)
					where	cpnominal > 0
					and		cpfecven  >= @dFechaCartera
				)	cartera
				
				inner join
				(	select	rsfecpro,rsnumdocu, rscorrelativo, rsinteres_acum,rscupamo, rstir, rstasemi, rstirmerc, rsvalmerc,rsvppresen, rsmonemi
						----------------------
						,	rsinteres
						----------------------
					from	BacBonosExtSuda.dbo.text_rsu with(nolock)
					where	rsfecpro	= @dFechaMercado
					and		rstipoper	= 'DEV'
				)	resultado	On	resultado.rsnumdocu		= cartera.cpnumdocu
								and	resultado.rscorrelativo = cartera.cpcorrelativo 

				inner join
				(	select	clrut, clcodigo, cldv, clnombre
		 			from	BacParamSuda.dbo.Cliente with(nolock)
				)	cliente		On	cliente.clrut		= Cartera.cprutcli
								and	cliente.clcodigo	= cartera.cpcodcli

				left join
				(	select	cod_nemo, per_cupones, fecha_emis, fecha_vcto, tasa_emis
					from	BacBonosExtSuda.dbo.text_ser with(nolock)
				)	Serie		On Serie.cod_nemo		= cartera.cod_nemo

				left join
				(	select	monumdocu, mocorrelativo, mousuario, moutilidad 
					from	BacBonosExtSuda.dbo.text_mvt_dri with(nolock)
					where	mofecpago = mofecpro
					and		motipoper = 'CP' 
					and	not mostatreg in('R', 'P', 'A')
				)	Movimiento	On	Movimiento.monumdocu		= cartera.cpnumdocu
								and	Movimiento.mocorrelativo	= cartera.cpcorrelativo
				
				-----------------------------------------------------------
				left join
				(	select	Rut		= rut_emi
						,	Nombre	= nom_emi
					from	bacbonosextsuda.dbo.text_emi_itl with(nolock)
				)	Emi		On emi.Rut	= cartera.cprutemi 
				-----------------------------------------------------------
				left join
				(	select	Id = tbcodigo1
						,	Descripcion	= tbglosa
					from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) 
					where	tbcateg = 1111
				)	cNorma	On cNorma.Id = cartera.CNormativa
					
		)	Trader
		
end
GO

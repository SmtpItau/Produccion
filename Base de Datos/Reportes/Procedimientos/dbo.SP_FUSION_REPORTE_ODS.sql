USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS]
		AS
		BEGIN

		DECLARE @Fecha_Proceso DATETIME = NULL
		DECLARE @Contraparte INT
		DECLARE @RutContraparte INT

		 IF(@Fecha_Proceso IS NULL)
			   BEGIN	 
				  SELECT @Fecha_Proceso = M.acfecproc	 
				  FROM Bacfwdsuda.dbo.mfac M
			   END     


		CREATE TABLE #Tmp_ODS
		(
		transaction_deal_num							varchar(250)
		,transaction_status_id							varchar(250)
		,transaction_trade_date							varchar(250)
		,transaction_start_date							varchar(250)
		,transaction_end_date							varchar(250)
		,transaction_ET									varchar(250)
		,transaction_modalidad_pago						varchar(250)
		,transaction_paymentconv_id						varchar(250)
		,transaction_nemo								varchar(250)
		,transaction_serie								varchar(250)
		,transaction_TIR_compra							varchar(250)
		,transaction_TIR_mercado						varchar(250)
		,transaction_strike								varchar(250)
		,transaction_id_group							varchar(250)
		,side_type										varchar(250)
		,side_fix_flt									varchar(250)
		,side_frec_p									varchar(250)
		,side_reset_p									varchar(250)
		,side_notional									varchar(250)
		,side_notional_ccy_id							varchar(250)

		,side_payment_ccy_id							varchar(250)
		,side_rate										varchar(250)
		,side_rate_spread								varchar(250)
		,side_rate_type_id								varchar(250)
		,side_projection_index							varchar(250)
		,side_yield_basis_id							varchar(250)
		,interest_id									varchar(250)
		,interest_start_date							varchar(250)

		,interest_end_date								varchar(250)
		,interest_payment_date							varchar(250)
		,interest_fixing_date							varchar(250)
		,interest_fixing_rate							varchar(250)

		,interest_accounting_date						varchar(250)
		,interest_rate									varchar(250)
		,interest_payment								varchar(250)
		,interest_df									varchar(250)
		,interest_npv									varchar(250)
		,cashflow_id									varchar(250)
		,cashflowtype_id								varchar(250)
		,cashflow_start_date							varchar(250)
		,cashflow_end_date								varchar(250)
		,cashflow_accounting_date						varchar(250)
		,cashflow_fixing_date							varchar(250)
		,cashflow_fixing_rate							varchar(250)
		,cashflow_amount								varchar(250)
		,cashflow_df									varchar(250)
		,cashflow_npv									varchar(250)
		,facility_id									varchar(250)
		,transaction_info_tc_costo						varchar(250)
		,transaction_info_tc_cliente					varchar(250)
		,transaction_info_paridad_costo					varchar(250)
		,transaction_info_paridad_cliente				varchar(250)
		,transaction_info_spread_tc						varchar(250)
		,transaction_info_spread_paridad				varchar(250)

		,transaction_info_fx_spot_cliente				varchar(250)
		,transaction_info_fx_fwd_costo					varchar(250)
		,transaction_info_fx_fwd_cliente				varchar(250)
		,transaction_info_puntos_fwd					varchar(250)
		,transaction_info_fx_uf_spot					varchar(250)
		,transaction_info_fx_uf_tasa_costo				varchar(250)
		,transaction_info_fx_uf_tasa_margen				varchar(250)
		,transaction_info_fx_uf_tasa_cliente			varchar(250)
		,transaction_info_fx_spot_margen				varchar(250)
		,transaction_info_fx_fwd_margen					varchar(250)
		,transaction_info_fx_uf_tasa_sucia_costo		varchar(250)
		,transaction_info_fx_uf_tasa_sucia_cliente		varchar(250)
		,equivalente_credito_corporativo				varchar(250)
		,equivalente_credito_normativo					varchar(250)
		,equivalente_credito_factor						varchar(250)
		,equivalente_credito_factor_inter				varchar(250)
		,equivalente_credito_factor_normativo			varchar(250)
		,medio_transaccional_id							varchar(250)
		,canal_transaccional_id							varchar(250)
		,profit_value									varchar(250)
		,profit_ccy_id									varchar(250)

		,profit_mesa_clientes_clp						varchar(250)
		,profit_mesa_trading_clp						varchar(250)

		,portfolio_id									varchar(250)
		,instrument_id									varchar(250)
		,product_id										varchar(250)

		,party_id										varchar(250)
		,party_rut										varchar(250)
		,party_secuencia								varchar(250)

		,pricing_mtm									varchar(250)
		,pricing_mtm_ccy_id								varchar(250)
		,pricing_base_mtm								varchar(250)

		,pricing_pnl									varchar(250)
		,pricing_pnl_fx_unrealized						varchar(250)

		,pricing_delta									varchar(250)
		,pricing_gamma									varchar(250)
		,pricing_vega									varchar(250)
		,pricing_beta									varchar(250)

		,pricing_rho_local								varchar(250)
		,pricing_rho_foranea							varchar(250)

		,pricing_theta									varchar(250)
		,pricing_volga									varchar(250)
		,side_id										varchar(250)
		,call_put_id									varchar(250)
		,Orden Int

		-- campos nuevos
		,transaction_emisor_id 							varchar(50)
		,transaction_plazo_pacto 						varchar(250)
		,transaction_tasa_costo_pacto 					varchar(250)
		,transaction_tasa_pacto							varchar(250)
		,transaction_tir_compra_origen					varchar(250)
		,transaction_tir_compra_ppa						varchar(250)
		,transaction_dev_tir_compra						varchar(250)
		,transaction_tipo_operacion_id					varchar(2)
		,transaction_fecha_compra_ins			 		varchar(250)
		,transaction_fecha_cupon 						varchar(250)

		----------------------------------------------------------------------------
		,Cuenta_GL										varchar(20)
		,Cuenta_SBIF									varchar(20)
		,cashflow_amount_add							varchar(250)
		,portfolio_super								varchar(250)
		,portfolio_scn									varchar(250)
		,side_discount_index							varchar(250)
		,interest_rate_icp								varchar(250)

		,TRANSACTION_OPTION_DESC						varchar(250)
		--,Valor_Nocional_pagado							varchar(250)
		,TRANSACTION_OPTION_CV                          Char(1) -->mgc.11.08.2017.Campo Nuevo.Informa Compra(c)/Venta(v).Interfaz de Opciones.Rqto.Victor Gonzalez
		/* Nuevos Campos */
		,pricing_mtm_itau								varchar(250) --> Milton Galarce 14.03.2018
		,pricing_base_mtm_itau							varchar(250) --> Milton Galarce 14.03.2018
		,transaction_info_party_original				varchar(250) --> Milton Galarce 22.01.2019
		)

		--/*
		-- FORWARD
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_FWD

		-- OPCIONES
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_OPC

		-- SWAP
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_PCS


		-- MDCP Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_CP_SERIADO

		-- MDCP No Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_CP_NSERIADO


		-- MDCI Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_CI_SERIADO

		-- MDCI No Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_CI_NSERIADO

		-- MDVI Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_VI_SERIADO

		-- MDVI No Seriados
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_VI_NSERIADO

		-- RF EXT
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_RF_EXT

		-- IB
		INSERT INTO #Tmp_ODS
		EXECUTE  SP_FUSION_REPORTE_ODS_IB

		-- ACTUALIZO CONTRAPARTE COMDER
		IF EXISTS(SELECT 1 FROM BDBOMESA.dbo.COMDER_RelacionMarcaComder a, #Tmp_ODS o WHERE a.nReNumOper = o.transaction_deal_num AND a.iReNovacion = 1 AND a.vReEstado = 'V' AND CONVERT(CHAR(8),a.dReFecha,112)= @Fecha_Proceso )
		BEGIN

			UPDATE #Tmp_ODS
			SET	transaction_info_party_original	= b.Clrut
		   FROM		BDBOMESA.dbo.COMDER_RelacionMarcaComder a, BacParamSuda.dbo.VIEW_CLIENTE b  
		   WHERE	a.nReNumOper = #Tmp_ODS.transaction_deal_num
		   AND		#Tmp_ODS.transaction_info_party_original = (select acRutComder from MFAC)
		   AND		(a.nReRutCliente = b.clrut and a.nReCodCliente = b.clcodigo )
		   AND		a.iReNovacion = 1 
		   AND		a.vReEstado = 'V' 
		   AND		CONVERT(CHAR(8),a.dReFecha,112)= @Fecha_Proceso
		      
		END
		-- FIN COMDER
		--*/


		SELECT 
		 transaction_deal_num						=  case when   transaction_deal_num = ''    then '0' WHEN  ISNULL(transaction_deal_num,0) = '0' THEN '0'    ELSE      transaction_deal_num    END
		,transaction_status_id						=  case when   transaction_status_id    = '' then '0' WHEN  ISNULL(transaction_status_id,0) = '0' THEN '0'     ELSE      transaction_status_id   END
		,transaction_trade_date
		,transaction_start_date
		,transaction_end_date
		,transaction_ET
		,transaction_modalidad_pago					=  case when   transaction_modalidad_pago = ''    then '0' WHEN  ISNULL(transaction_modalidad_pago,0) = '0' THEN '0'     ELSE  transaction_modalidad_pago   END
		,transaction_paymentconv_id					=  case when   transaction_paymentconv_id = ''    then '0' WHEN  ISNULL(transaction_paymentconv_id,0) = '0' THEN '0'     ELSE  transaction_paymentconv_id   END
		,transaction_nemo
		,transaction_serie
		,transaction_TIR_compra						=  case when   transaction_TIR_compra = ''  then '0' WHEN  ISNULL(transaction_TIR_compra,0) = '0' THEN '0'     ELSE      transaction_TIR_compra  END
		,transaction_TIR_mercado					=  case when   transaction_TIR_mercado = '' then '0' WHEN  ISNULL(transaction_TIR_mercado,0) = '0' THEN '0'    ELSE      transaction_TIR_mercado      END
		,transaction_strike							=  case when   transaction_strike  ='' then '0'  WHEN  ISNULL(transaction_strike,0) = '0' THEN '0'    ELSE      transaction_strike      END
		,transaction_id_group						=  case when   transaction_id_group  = ''   then '0'  WHEN  ISNULL(transaction_id_group,0) = '0' THEN '0'     ELSE      transaction_id_group    END
		,side_type									=  case when   side_type = ''    then '0'  WHEN  ISNULL(side_type,0) = '0' THEN '0'   ELSE  side_type   END
		,side_fix_flt								=  case when   side_fix_flt = '' then '0' WHEN  ISNULL(side_fix_flt,0) = '0' THEN '0'     ELSE  side_fix_flt      END
		,side_frec_p								
		,side_reset_p								
		,side_notional								=  case when   side_notional = ''      then '0' WHEN  ISNULL(side_notional,0) = '0' THEN '0'    ELSE  side_notional      END
		,side_notional_ccy_id						=  case when   side_notional_ccy_id = ''    then '0' WHEN  ISNULL(side_notional_ccy_id,0) = '0' THEN '0'    ELSE      side_notional_ccy_id    END
		,side_payment_ccy_id						=  case when   side_payment_ccy_id = ''     then '0' WHEN  ISNULL(side_payment_ccy_id,0) = '0' THEN '0'    ELSE      side_payment_ccy_id     END
		,side_rate									=  case when   side_rate = ''    then '0' WHEN  ISNULL(side_rate,0) = '0' THEN '0'    ELSE  side_rate   END
		,side_rate_spread							=  case when   side_rate_spread = ''   then '0' WHEN  ISNULL(side_rate_spread,0) = '0' THEN '0'    ELSE  side_rate_spread      END
		,side_rate_type_id							=  case when   side_rate_type_id = ''  then '0'  WHEN  ISNULL(side_rate_type_id,0) = '0' THEN '0'   ELSE      side_rate_type_id END
		,side_projection_index						=  case when   side_projection_index = ''   then '0' WHEN  ISNULL(side_projection_index,0) = '0' THEN '0'    ELSE      side_projection_index   END
		,side_yield_basis_id						=  case when   side_yield_basis_id = ''     then '0' WHEN  ISNULL(side_yield_basis_id,0) = '0' THEN '0'    ELSE      side_yield_basis_id     END
		,interest_id								=  case when   interest_id = ''  then '0' WHEN  ISNULL(interest_id,0) = '0' THEN '0'    ELSE  interest_id END
		,interest_start_date						
		,interest_end_date							
		,interest_payment_date						
		,interest_fixing_date						
		,interest_fixing_rate						=  case when   interest_fixing_rate = ''    then '0' WHEN  ISNULL(interest_fixing_rate,0) = '0' THEN '0'    ELSE      interest_fixing_rate    END
		,interest_accounting_date					
		,interest_rate								=  case when   interest_rate = ''      then '0'  WHEN  ISNULL(interest_rate,0) = '0' THEN '0'   ELSE  interest_rate      END
		,interest_payment							=  case when   interest_payment = ''   then '0'   WHEN  ISNULL(interest_payment,0) = '0' THEN '0'    ELSE  interest_payment      END
		,interest_df								=  case when   interest_df = ''  then '0'  WHEN  ISNULL(interest_df,0) = '0' THEN '0'     ELSE  interest_df END
		,interest_npv								=  case when   interest_npv = '' then '0'   WHEN  ISNULL(interest_npv,0) = '0' THEN '0'    ELSE  interest_npv      END
		,cashflow_id								=  case when   cashflow_id = ''  then '0'  WHEN  ISNULL(cashflow_id,0) = '0' THEN '0'   ELSE  cashflow_id END
		,cashflowtype_id							=  case when   cashflowtype_id = ''    then '0'  WHEN  ISNULL(cashflowtype_id,0) = '0' THEN '0'     ELSE  cashflowtype_id      END
		,cashflow_start_date						
		,cashflow_end_date							
		,cashflow_accounting_date					
		,cashflow_fixing_date						
		,cashflow_fixing_rate						=   case when   cashflow_fixing_rate = ''    then '0'  WHEN  ISNULL(cashflow_fixing_rate,0) = '0' THEN '0'     ELSE      cashflow_fixing_rate    END
		,cashflow_amount							=   case when   cashflow_amount = ''    then '0'  WHEN  ISNULL(cashflow_amount,0) = '0' THEN '0'    ELSE  cashflow_amount      END
		,cashflow_df								=   case when   cashflow_df = ''  then '0'  WHEN  ISNULL(cashflow_df,0) = '0' THEN '0'     ELSE  cashflow_df END
		,cashflow_npv								=   case when   cashflow_npv = '' then '0'  WHEN  ISNULL(cashflow_npv,0) = '0' THEN '0'   ELSE  cashflow_npv      END
		,facility_id								=   case when   facility_id = ''  then '0'   WHEN  ISNULL(facility_id,0) = '0' THEN '0'    ELSE  facility_id END
		,transaction_info_tc_costo					=   case when   transaction_info_tc_costo = ''     then '0' WHEN  ISNULL(transaction_info_tc_costo,0) = '0' THEN '0'   ELSE  transaction_info_tc_costo    END
		,transaction_info_tc_cliente				=   case when   transaction_info_tc_cliente = ''   then '0' WHEN  ISNULL(transaction_info_tc_cliente,0) = '0' THEN '0'     ELSE  transaction_info_tc_cliente  END
		,transaction_info_paridad_costo				=   case when   transaction_info_paridad_costo = '' then       '0'  WHEN  ISNULL(transaction_info_paridad_costo,0) = '0' THEN '0'    ELSE  transaction_info_paridad_costo     END
		,transaction_info_paridad_cliente			=   case when   transaction_info_paridad_cliente = ''      then '0'  WHEN  ISNULL(transaction_info_paridad_cliente,0) = '0' THEN '0'      ELSE  transaction_info_paridad_cliente   END
		,transaction_info_spread_tc					=   case when   transaction_info_spread_tc = ''    then '0'  WHEN  ISNULL(transaction_info_spread_tc,0) = '0' THEN '0'      ELSE  transaction_info_spread_tc   END
		,transaction_info_spread_paridad			=   case when   transaction_info_spread_paridad = ''      then '0'  WHEN  ISNULL(transaction_info_spread_paridad,0) = '0' THEN '0'    ELSE  transaction_info_spread_paridad    END
		,transaction_info_fx_spot_cliente			=   case when   transaction_info_fx_spot_cliente  = ''      then '0'  WHEN  ISNULL(transaction_info_fx_spot_cliente,0) = '0' THEN '0'     ELSE  transaction_info_fx_spot_cliente   END
		,transaction_info_fx_fwd_costo				=   case when   transaction_info_fx_fwd_costo = '' then       '0'  WHEN  ISNULL(transaction_info_fx_fwd_costo,0) = '0' THEN '0'   ELSE  transaction_info_fx_fwd_costo END
		,transaction_info_fx_fwd_cliente			=   case when   transaction_info_fx_fwd_cliente = ''      then '0'  WHEN  ISNULL(transaction_info_fx_fwd_cliente,0) = '0' THEN '0'    ELSE  transaction_info_fx_fwd_cliente    END
		,transaction_info_puntos_fwd				=	case when   transaction_info_puntos_fwd = ''   then '0'  WHEN  ISNULL(transaction_info_puntos_fwd,0) = '0' THEN '0'     ELSE  transaction_info_puntos_fwd  END
		,transaction_info_fx_uf_spot				=   case when   transaction_info_fx_uf_spot = ''   then '0'   WHEN  ISNULL(transaction_info_fx_uf_spot,0) = '0' THEN '0'     ELSE  transaction_info_fx_uf_spot  END
		,transaction_info_fx_uf_tasa_costo			=   case when   transaction_info_fx_uf_tasa_costo = ''      then '0'  WHEN  ISNULL(transaction_info_fx_uf_tasa_costo,0) = '0' THEN '0'      ELSE  transaction_info_fx_uf_tasa_costo  END
		,transaction_info_fx_uf_tasa_margen			=   case when   transaction_info_fx_uf_tasa_margen = ''      then '0' WHEN  ISNULL(transaction_info_fx_uf_tasa_margen,0) = '0' THEN '0'    ELSE  transaction_info_fx_uf_tasa_margen END
		,transaction_info_fx_uf_tasa_cliente		=   case when   transaction_info_fx_uf_tasa_cliente = '' then '0' WHEN  ISNULL(transaction_info_fx_uf_tasa_cliente,0) = '0' THEN '0'    ELSE      transaction_info_fx_uf_tasa_cliente END
		,transaction_info_fx_spot_margen			=   case when   transaction_info_fx_spot_margen = ''      then '0'  WHEN  ISNULL(transaction_info_fx_spot_margen,0) = '0' THEN '0'   ELSE  transaction_info_fx_spot_margen    END
		,transaction_info_fx_fwd_margen				=   case when   transaction_info_fx_fwd_margen = '' then       '0' WHEN  ISNULL(transaction_info_fx_fwd_margen,0) = '0' THEN '0'    ELSE  transaction_info_fx_fwd_margen     END
		,transaction_info_fx_uf_tasa_sucia_costo	=   case when   transaction_info_fx_uf_tasa_sucia_costo = ''   then '0' WHEN  ISNULL(transaction_info_fx_uf_tasa_sucia_costo,0) = '0' THEN '0'     ELSE      transaction_info_fx_uf_tasa_sucia_costo  END
		,transaction_info_fx_uf_tasa_sucia_cliente  =   case when   transaction_info_fx_uf_tasa_sucia_cliente = '' then '0' WHEN  ISNULL(transaction_info_fx_uf_tasa_sucia_cliente,0) = '0' THEN '0'     ELSE      transaction_info_fx_uf_tasa_sucia_cliente      END
		,equivalente_credito_corporativo			=   case when   equivalente_credito_corporativo = ''      then '0' WHEN  ISNULL(equivalente_credito_corporativo,0) = '0' THEN '0'    ELSE  equivalente_credito_corporativo    END
		,equivalente_credito_normativo				=   case when   equivalente_credito_normativo = '' then       '0'  WHEN  ISNULL(equivalente_credito_normativo,0) = '0' THEN '0'   ELSE  equivalente_credito_normativo END
		,equivalente_credito_factor					=   case when   equivalente_credito_factor = ''    then '0' WHEN  ISNULL(equivalente_credito_factor,0) = '0' THEN '0'      ELSE  equivalente_credito_factor   END
		,equivalente_credito_factor_inter			=   case when   equivalente_credito_factor_inter = ''      then '0'  WHEN  ISNULL(equivalente_credito_factor_inter,0) = '0' THEN '0'   ELSE  equivalente_credito_factor_inter   END
		,equivalente_credito_factor_normativo		=   case when   equivalente_credito_factor_normativo = ''      then '0'   WHEN  ISNULL(equivalente_credito_factor_normativo,0) = '0' THEN '0'   ELSE      equivalente_credito_factor_normativo     END
		,medio_transaccional_id						=   case when   medio_transaccional_id = ''  then '0' WHEN  ISNULL(medio_transaccional_id,0) = '0' THEN '0'    ELSE      medio_transaccional_id  END
		,canal_transaccional_id						=   case when   canal_transaccional_id = ''  then '0'  WHEN  ISNULL(canal_transaccional_id,0) = '0' THEN '0'      ELSE      canal_transaccional_id  END
		,profit_value								=   case when   profit_value = '' then '0' WHEN  ISNULL(profit_value,0) = '0' THEN '0'     ELSE  profit_value      END
		,profit_ccy_id								=   case when   profit_ccy_id = ''      then '0' WHEN  ISNULL(profit_ccy_id,0) = '0' THEN '0'     ELSE  profit_ccy_id      END
		,profit_mesa_clientes_clp					=   case when   profit_mesa_clientes_clp = '' then '0' WHEN  ISNULL(profit_mesa_clientes_clp,0) = '0' THEN '0'    ELSE      profit_mesa_clientes_clp     END
		,profit_mesa_trading_clp					=   case when   profit_mesa_trading_clp = '' then '0' WHEN  ISNULL(profit_mesa_trading_clp,0) = '0' THEN '0'    ELSE      profit_mesa_trading_clp END
		,portfolio_id								=   case when   portfolio_id = '' then '0' WHEN  ISNULL(portfolio_id,0) = '0' THEN '0'    ELSE  portfolio_id      END
		,instrument_id								=   case when   instrument_id = ''      then '0'  WHEN  ISNULL(instrument_id,0) = '0' THEN '0'    ELSE  instrument_id      END
		,product_id									=   case when   product_id = ''   then '0' WHEN  ISNULL(product_id,0) = '0' THEN '0'    ELSE  product_id  END
		,party_id									=   case when   party_id = ''     then '0' WHEN  ISNULL(party_id,0) = '0' THEN '0'    ELSE  party_id    END
		,party_rut									                                 
		,party_secuencia							=   case when   party_secuencia = ''    then '0'  WHEN  ISNULL(party_secuencia,0) = '0' THEN '0'   ELSE  party_secuencia      END
		,pricing_mtm								=   case when   pricing_mtm = ''  then '0'  WHEN  ISNULL(pricing_mtm,0) = '0' THEN '0'     ELSE  pricing_mtm END
		,pricing_mtm_ccy_id							=   case when   pricing_mtm_ccy_id = '' then '0'  WHEN  ISNULL(pricing_mtm_ccy_id,0) = '0' THEN '0'     ELSE      pricing_mtm_ccy_id      END
		,pricing_base_mtm							=   case when   pricing_base_mtm = ''   then '0'   WHEN  ISNULL(pricing_base_mtm,0) = '0' THEN '0'   ELSE  pricing_base_mtm      END
		,pricing_pnl								=   case when   pricing_pnl = ''  then '0' WHEN  ISNULL(pricing_pnl,0) = '0' THEN '0'     ELSE  pricing_pnl END
		,pricing_pnl_fx_unrealized					=   case when   pricing_pnl_fx_unrealized = ''     then '0'  WHEN  ISNULL(pricing_pnl_fx_unrealized,0) = '0' THEN '0'     ELSE  pricing_pnl_fx_unrealized    END
		,pricing_delta								=   case when   pricing_delta = ''      then '0'  WHEN  ISNULL(pricing_delta,0) = '0' THEN '0'    ELSE  pricing_delta      END
		,pricing_gamma								=   case when   pricing_gamma = ''      then '0'  WHEN  ISNULL(pricing_gamma,0) = '0' THEN '0'    ELSE  pricing_gamma      END
		,pricing_vega								=	case when   pricing_vega = '' then '0'  WHEN  ISNULL(pricing_vega,0) = '0' THEN '0'     ELSE  pricing_vega      END
		,pricing_beta								=	case when   pricing_beta = '' then '0'  WHEN  ISNULL(pricing_beta,0) = '0' THEN '0'   ELSE  pricing_beta      END
		,pricing_rho_local							=   case when   pricing_rho_local = ''  then '0' WHEN  ISNULL(pricing_rho_local,0) = '0' THEN '0'      ELSE      pricing_rho_local END
		,pricing_rho_foranea						=   case when   pricing_rho_foranea = ''     then '0' WHEN  ISNULL(pricing_rho_foranea,0) = '0' THEN '0'    ELSE      pricing_rho_foranea     END
		,pricing_theta								=   case when   pricing_theta = ''      then '0'   WHEN  ISNULL(pricing_theta,0) = '0' THEN '0'    ELSE  pricing_theta      END
		,pricing_volga								=   case when   pricing_volga = ''      then '0' WHEN  ISNULL(pricing_volga,0) = '0' THEN '0'    ELSE  pricing_volga      END
		,side_id									=   case when   side_id = ''      then '0' WHEN  ISNULL(side_id,0) = '0' THEN '0'    ELSE  side_id      END
		,call_put_id  								=   case when   call_put_id = ''      then '0' WHEN  ISNULL(call_put_id,0) = '0' THEN '0'    ELSE  call_put_id      END
		--campos nuevos
		,transaction_emisor_id 						=   case when   transaction_emisor_id 			=''      then '' 	WHEN  ISNULL(transaction_emisor_id				,0) = '0' THEN ''     ELSE  transaction_emisor_id 				END
		,transaction_plazo_pacto 					=   case when   transaction_plazo_pacto 		=''      then '0' 	WHEN  ISNULL(transaction_plazo_pacto 			,0) = '0' THEN '0'    ELSE  transaction_plazo_pacto 			END
		,transaction_tasa_costo_pacto 				=   case when   transaction_tasa_costo_pacto 	=''      then '0' 	WHEN  ISNULL(transaction_tasa_costo_pacto 		,0) = '0' THEN '0'    ELSE  transaction_tasa_costo_pacto 		END
		,transaction_tasa_pacto						=   case when   transaction_tasa_pacto			=''      then '0' 	WHEN  ISNULL(transaction_tasa_pacto				,0) = '0' THEN '0'    ELSE  transaction_tasa_pacto				END
		,transaction_tir_compra_origen				=   case when   transaction_tir_compra_origen	=''      then '0' 	WHEN  ISNULL(transaction_tir_compra_origen		,0) = '0' THEN '0'    ELSE  transaction_tir_compra_origen		END
		,transaction_tir_compra_ppa					=   case when   transaction_tir_compra_ppa		=''      then '0' 	WHEN  ISNULL(transaction_tir_compra_ppa			,0) = '0' THEN '0'    ELSE  transaction_tir_compra_ppa			END
		,transaction_dev_tir_compra					=   case when   transaction_dev_tir_compra		=''      then '0' 	WHEN  ISNULL(transaction_dev_tir_compra			,0) = '0' THEN '0'    ELSE  transaction_dev_tir_compra			END
		,transaction_tipo_operacion_id				=   case when   transaction_tipo_operacion_id	=''      then '' 	WHEN  ISNULL(transaction_tipo_operacion_id		,0) = '0' THEN ''     ELSE  transaction_tipo_operacion_id		END
		,transaction_fecha_compra_ins 	
		,transaction_fecha_cupon 				

		,transaction_info_cuenta_gl		= case when Cuenta_GL			= '' then '0' when isnull(Cuenta_GL,			0) = '0' then '0' else Cuenta_GL			end
		,transaction_info_cuenta_sbif	= case when Cuenta_SBIF			= '' then '0' when isnull(Cuenta_SBIF,			0) = '0' then '0' else Cuenta_SBIF			end
		,cashflow_amount_add			= case when cashflow_amount_add = '' then '0' when isnull(cashflow_amount_add,	0) = '0' then '0' else cashflow_amount_add	end
		,portfolio_super				= case when portfolio_super		= '' then '0' when isnull(portfolio_super,		0) = '0' then '0' else portfolio_super		end
		,portfolio_scn					= case when portfolio_scn		= '' then '0' when isnull(portfolio_scn,		0) = '0' then '0' else portfolio_scn		end
		,side_discount_index			= case when side_discount_index = '' then '0' when isnull(side_discount_index,	0) = '0' then '0' else side_discount_index	end
		,interest_rate_icp				= case when interest_rate_icp	= '' then '0' when isnull(interest_rate_icp,    0) = '0' then '0' else interest_rate_icp	end

		,TRANSACTION_OPTION_DESC		= case when TRANSACTION_OPTION_DESC = ''  then ''  when isnull(TRANSACTION_OPTION_DESC, 0) = ''  then ''  else TRANSACTION_OPTION_DESC end
		--,Valor_Nocional_pagado			= case when Valor_Nocional_pagado= '0' then '0' when isnull(Descripcion_Producto, 0) = '0' then '0' else Descripcion_Producto end
		,TRANSACTION_OPTION_CV          = TRANSACTION_OPTION_CV -->mgc.11.08.2017.Campo Nuevo.Informa Compra(c)/Venta(v).Interfaz de Opciones.Rqto.Victor Gonzalez

		,pricing_mtm_itau				=	CASE WHEN pricing_mtm_itau = '' THEN '0'  
												 WHEN ISNULL(pricing_mtm_itau,0) = '0' THEN '0' 
												 ELSE  pricing_mtm_itau 
											END
		,pricing_base_mtm_itau			=	CASE WHEN pricing_base_mtm_itau = '' THEN '0'
												 WHEN  ISNULL(pricing_base_mtm_itau,0) = '0' THEN '0'
												 ELSE  pricing_base_mtm_itau
											END

		,transaction_info_party_original = transaction_info_party_original
		 
		 FROM #Tmp_ODS

		END
GO

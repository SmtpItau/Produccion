USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OPERACION_SWAP_ORIGINAL]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_GRABA_OPERACION_SWAP_ORIGINAL] 
	( 	@NroOperacion numeric (7,0) 
	   ,@usuario      varchar(15)
	   ,@FechaProceso datetime)
AS
BEGIN
  



   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : MODIFICACION DE SWAP                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -21654 SWAP                                             */
   /* FECHA CRACION : 20/07/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* SE VERIFICA SI EXISTE LA OPERACION CARTERA PARA INSERTAR MODIFICACION HIS   */
   /*-----------------------------------------------------------------------------*/
	IF EXISTS(SELECT * FROM CARTERA WHERE [numero_operacion] = @NroOperacion)
	BEGIN 
		INSERT INTO [dbo].[CarteraModificadaHis]
		SELECT  numero_operacion, numero_flujo, tipo_flujo ,@FechaProceso , @usuario
		       ,tipo_swap, cartera_inversion,
			    tipo_operacion, codigo_cliente, rut_cliente,fecha_cierre, fecha_inicio,
			    [fecha_termino], [fecha_inicio_flujo], [fecha_vence_flujo], [fecha_fijacion_tasa],
			    [compra_moneda], [compra_capital], [compra_amortiza], [compra_saldo],
			    [compra_interes], [compra_spread], [compra_codigo_tasa], [compra_valor_tasa],
			    [compra_valor_tasa_hoy], [compra_codamo_capital], [compra_mesamo_capital],
			    [compra_codamo_interes], [compra_mesamo_interes], [compra_base], [venta_moneda],
				[venta_capital], [venta_amortiza], [venta_saldo], [venta_interes], [venta_spread],
				[venta_codigo_tasa], [venta_valor_tasa], [venta_valor_tasa_hoy], [venta_codamo_capital],
				[venta_mesamo_capital], [venta_codamo_interes], [venta_mesamo_interes], [venta_base],
				[operador], [operador_cliente], [estado_flujo], [modalidad_pago],
				[pagamos_moneda], [pagamos_documento],[pagamos_monto], [pagamos_monto_USD],
				[pagamos_monto_CLP], [recibimos_moneda], [recibimos_documento], [recibimos_monto],
				[recibimos_monto_USD], [recibimos_monto_CLP], [observaciones], [fecha_modifica],
				[devengo_dias], [devengo_monto], [devengo_monto_peso], [devengo_monto_acum],
				[devengo_monto_ayer], [devengo_compra], [devengo_compra_acum],[devengo_compra_acum_peso],
				[devengo_compra_ayer], [devengo_compra_ayer_peso], [devengo_venta], [devengo_venta_acum],
				[devengo_venta_acum_peso], [devengo_venta_ayer], [devengo_venta_ayer_peso], [fecha_valoriza],
				[compra_zcr], [compra_mercado_tasa], [compra_mercado],[compra_mercado_usd], compra_mercado_clp,
				[compra_duration_tasa], [compra_duration_monto], [compra_duration_monto_usd],[compra_duration_monto_clp],
				[compra_valor_presente],[venta_zcr], [venta_mercado_tasa], [venta_mercado], [venta_mercado_usd],
				[venta_mercado_clp], [venta_duration_tasa], [venta_duration_monto], [venta_duration_monto_usd],
				[venta_duration_monto_clp],[venta_valor_presente],[monto_mtm],[monto_mtm_usd],[monto_mtm_clp],
				[compra_valorizada],[compra_variacion],[venta_valorizada],[venta_variacion],[valorizacion_dia],
				[estado],[Estado_oper_lineas],[Observacion_Lineas],[Observacion_Limites],[Especial],[Capital_Pesos_Actual],
				[Capital_Pesos_Ayer],[Hora],[Tasa_Compra_Curva],[Tasa_Venta_Curva],[Activo_MO_C08],	[Pasivo_MO_C08],
				[Activo_USD_C08],[Pasivo_USD_C08],[Activo_CLP_C08],[Pasivo_CLP_C08],[Tasa_Compra_CurvaVR],[Tasa_Venta_CurvaVR],
				[Activo_FlujoMO],[Activo_FlujoUSD],[Activo_FlujoCLP],[Pasivo_FlujoMO],[Pasivo_FlujoUSD],[Pasivo_FlujoCLP],
				[Valor_RazonableMO],[Valor_RazonableUSD],[Valor_RazonableCLP],[Monto_Spread],[Monto_diferido_inicial],
				[Monto_diferido_diario],[Monto_diferido_acumulado],	[TC_MO_Inicial],[Monto_TC_Diario],[Monto_TC_Acumulado],
				[Monto_Reajuste_Diario],[Monto_Reajuste_Acumulado],	[Monto_Valorizacion],[Monto_Capital_TC_ini],
				[car_area_Responsable],[car_Cartera_Normativa],[car_SubCartera_Normativa], [car_Libro],
				[DevAntPromCam],[vRazAjustado_Mo],[vRazAjustado_Mn],[vRazAjustado_Do],[vRazActivoAjus_Mo],[vRazPasivoAjus_Mo],
				[vRazActivoAjus_Mn],[vRazPasivoAjus_Mn],[vRazActivoAjus_Do],[vRazPasivoAjus_Do],[vTasaActivaAjusta],
				[vTasaPasivaAjusta],[vDurMacaulActivo],	[vDurMacaulPasivo],	[vDurModifiActivo],	[vDurModifiPasivo],
				[vDurConvexActivo],[vDurConvexPasivo],	[FeriadoFlujoChile],[FeriadoFlujoEEUU],	[FeriadoFlujoEnglan],
				[FeriadoLiquiChile],[FeriadoLiquiEEUU],	[FeriadoLiquiEnglan],[Convencion],[DiasReset],[FechaEfectiva],
				[PrimerPago],[PenultimoPago],[Madurez],[Note],[IntercPrinc],[Tikker],[FechaLiquidacion],[FechaReset],
				[CompraTasaProyectada],	[VentaTasaProyectada],[estado_sinacofi] ,[fecha_sinacofi] ,[Moneda_Valorizacion],
				[Valor_Mercado_Activo_Mda_Val],[Devengo_Recibido_Mda_Val],[Valor_Mercado_Pasivo_Mda_Val],[Devengo_Pagar_Mda_Val],
				[Principal_Mda_Val],[Devengo_Neto_Mda_Val],	[Valor_Mercado_Mda_Val],[Porcentaje_Margen],[Monto_Margen],
				[Monto_Margen_CLP],[OrigenCurva],[ActivoTir],[PasivoTir],[ActivoTirCnv],[PasivoTirCnv],[FxRate],[Compra_amortiza_Prc],
				[Venta_amortiza_Prc],[Compra_Flujo_Adicional],[Venta_Flujo_Adicional],[FechaValuta],[CompraPerResetCod],
				[VentaPerResetCod],[CompraLiqDefault],[VentaLiqDefault],[CompraResetDefault],[VentaResetDefault],[Compra_DV01_Forward],
				[Venta_DV01_Forward],[Compra_DV01_Descuento],[Venta_DV01_Descuento],[Compra_curva_TIR],	[Venta_curva_TIR],
				[Compra_Curva_Descont],[Venta_Curva_Descont],[Compra_Curva_Forward],[Venta_Curva_Forward] ,[Monto_LCR_Matriz],
				[Monto_LCR_Ajuste_AVR],[Trader_Contraparte],[Especifica_Negocio],[Compra_Tasa_Forward_larga],[Compra_Tasa_Forward_corta],
				[PlazoFlujo],[PortaFolio],[Threshold] ,	[bEarlyTermination],[FechaInicio],[Periodicidad],[ReferenciaUSDCLP],[ReferenciaMEXUSD],
				[FechaUSDCLP],[FechaMEXUSD],[InterNocIni],[InterNocFin]
		FROM   Cartera
		WHERE  numero_operacion = @NroOperacion 	
		
		  IF @@ERROR != 0  BEGIN   
		     RAISERROR ('FALLO AL INSERTAR HISTORICO DE LA CARTERA',16,1);
		     RETURN 0
          END 
 
		
			
	END		
	ELSE BEGIN

	      RAISERROR ('NO EXISTE NUMERO DE OPERACION EN CARTERA',16,1);
		  RETURN 0
	END

   /*-----------------------------------------------------------------------------*/
   /* SE ELIMINARA LA CARTERA ACTUAL MODIFICADA ASIGNADA A LA MISMA OPERACION     */
   /*-----------------------------------------------------------------------------*/
    IF EXISTS(SELECT 1
	            FROM CarteraModificada
			   WHERE numero_operacion = @NroOperacion) BEGIN

	   DELETE 
	     FROM CarteraModificada 
		WHERE numero_operacion = @NroOperacion

		  IF @@ERROR != 0  BEGIN   
		     RAISERROR ('FALLO AL ELIMINAR CARTERA MODIFICADA ANTERIOR',16,1);
		     RETURN 0
          END 
    END


	
   /*-----------------------------------------------------------------------------*/
   /* SE INGRESAN REGISTROS                                                       */
   /*-----------------------------------------------------------------------------*/
		INSERT INTO [dbo].[CarteraModificada]
		SELECT  numero_operacion, numero_flujo, tipo_flujo ,tipo_swap, cartera_inversion,
			    tipo_operacion, codigo_cliente, rut_cliente,fecha_cierre, fecha_inicio,
			    [fecha_termino], [fecha_inicio_flujo], [fecha_vence_flujo], [fecha_fijacion_tasa],
			    [compra_moneda], [compra_capital], [compra_amortiza], [compra_saldo],
			    [compra_interes], [compra_spread], [compra_codigo_tasa], [compra_valor_tasa],
			    [compra_valor_tasa_hoy], [compra_codamo_capital], [compra_mesamo_capital],
			    [compra_codamo_interes], [compra_mesamo_interes], [compra_base], [venta_moneda],
				[venta_capital], [venta_amortiza], [venta_saldo], [venta_interes], [venta_spread],
				[venta_codigo_tasa], [venta_valor_tasa], [venta_valor_tasa_hoy], [venta_codamo_capital],
				[venta_mesamo_capital], [venta_codamo_interes], [venta_mesamo_interes], [venta_base],
				[operador], [operador_cliente], [estado_flujo], [modalidad_pago],
				[pagamos_moneda], [pagamos_documento],[pagamos_monto], [pagamos_monto_USD],
				[pagamos_monto_CLP], [recibimos_moneda], [recibimos_documento], [recibimos_monto],
				[recibimos_monto_USD], [recibimos_monto_CLP], [observaciones], [fecha_modifica],
				[devengo_dias], [devengo_monto], [devengo_monto_peso], [devengo_monto_acum],
				[devengo_monto_ayer], [devengo_compra], [devengo_compra_acum],[devengo_compra_acum_peso],
				[devengo_compra_ayer], [devengo_compra_ayer_peso], [devengo_venta], [devengo_venta_acum],
				[devengo_venta_acum_peso], [devengo_venta_ayer], [devengo_venta_ayer_peso], [fecha_valoriza],
				[compra_zcr], [compra_mercado_tasa], [compra_mercado],[compra_mercado_usd], compra_mercado_clp,
				[compra_duration_tasa], [compra_duration_monto], [compra_duration_monto_usd],[compra_duration_monto_clp],
				[compra_valor_presente],[venta_zcr], [venta_mercado_tasa], [venta_mercado], [venta_mercado_usd],
				[venta_mercado_clp], [venta_duration_tasa], [venta_duration_monto], [venta_duration_monto_usd],
				[venta_duration_monto_clp],[venta_valor_presente],[monto_mtm],[monto_mtm_usd],[monto_mtm_clp],
				[compra_valorizada],[compra_variacion],[venta_valorizada],[venta_variacion],[valorizacion_dia],
				[estado],[Estado_oper_lineas],[Observacion_Lineas],[Observacion_Limites],[Especial],[Capital_Pesos_Actual],
				[Capital_Pesos_Ayer],[Hora],[Tasa_Compra_Curva],[Tasa_Venta_Curva],[Activo_MO_C08],	[Pasivo_MO_C08],
				[Activo_USD_C08],[Pasivo_USD_C08],[Activo_CLP_C08],[Pasivo_CLP_C08],[Tasa_Compra_CurvaVR],[Tasa_Venta_CurvaVR],
				[Activo_FlujoMO],[Activo_FlujoUSD],[Activo_FlujoCLP],[Pasivo_FlujoMO],[Pasivo_FlujoUSD],[Pasivo_FlujoCLP],
				[Valor_RazonableMO],[Valor_RazonableUSD],[Valor_RazonableCLP],[Monto_Spread],[Monto_diferido_inicial],
				[Monto_diferido_diario],[Monto_diferido_acumulado],	[TC_MO_Inicial],[Monto_TC_Diario],[Monto_TC_Acumulado],
				[Monto_Reajuste_Diario],[Monto_Reajuste_Acumulado],	[Monto_Valorizacion],[Monto_Capital_TC_ini],
				[car_area_Responsable],[car_Cartera_Normativa],[car_SubCartera_Normativa], [car_Libro],
				[DevAntPromCam],[vRazAjustado_Mo],[vRazAjustado_Mn],[vRazAjustado_Do],[vRazActivoAjus_Mo],[vRazPasivoAjus_Mo],
				[vRazActivoAjus_Mn],[vRazPasivoAjus_Mn],[vRazActivoAjus_Do],[vRazPasivoAjus_Do],[vTasaActivaAjusta],
				[vTasaPasivaAjusta],[vDurMacaulActivo],	[vDurMacaulPasivo],	[vDurModifiActivo],	[vDurModifiPasivo],
				[vDurConvexActivo],[vDurConvexPasivo],	[FeriadoFlujoChile],[FeriadoFlujoEEUU],	[FeriadoFlujoEnglan],
				[FeriadoLiquiChile],[FeriadoLiquiEEUU],	[FeriadoLiquiEnglan],[Convencion],[DiasReset],[FechaEfectiva],
				[PrimerPago],[PenultimoPago],[Madurez],[Note],[IntercPrinc],[Tikker],[FechaLiquidacion],[FechaReset],
				[CompraTasaProyectada],	[VentaTasaProyectada],[estado_sinacofi] ,[fecha_sinacofi] ,[Moneda_Valorizacion],
				[Valor_Mercado_Activo_Mda_Val],[Devengo_Recibido_Mda_Val],[Valor_Mercado_Pasivo_Mda_Val],[Devengo_Pagar_Mda_Val],
				[Principal_Mda_Val],[Devengo_Neto_Mda_Val],	[Valor_Mercado_Mda_Val],[Porcentaje_Margen],[Monto_Margen],
				[Monto_Margen_CLP],[OrigenCurva],[ActivoTir],[PasivoTir],[ActivoTirCnv],[PasivoTirCnv],[FxRate],[Compra_amortiza_Prc],
				[Venta_amortiza_Prc],[Compra_Flujo_Adicional],[Venta_Flujo_Adicional],[FechaValuta],[CompraPerResetCod],
				[VentaPerResetCod],[CompraLiqDefault],[VentaLiqDefault],[CompraResetDefault],[VentaResetDefault],[Compra_DV01_Forward],
				[Venta_DV01_Forward],[Compra_DV01_Descuento],[Venta_DV01_Descuento],[Compra_curva_TIR],	[Venta_curva_TIR],
				[Compra_Curva_Descont],[Venta_Curva_Descont],[Compra_Curva_Forward],[Venta_Curva_Forward] ,[Monto_LCR_Matriz],
				[Monto_LCR_Ajuste_AVR],[Trader_Contraparte],[Especifica_Negocio],[Compra_Tasa_Forward_larga],[Compra_Tasa_Forward_corta],
				[PlazoFlujo],[PortaFolio],[Threshold] ,	[bEarlyTermination],[FechaInicio],[Periodicidad],[ReferenciaUSDCLP],[ReferenciaMEXUSD],
				[FechaUSDCLP],[FechaMEXUSD],[InterNocIni],[InterNocFin]
		FROM   Cartera
		WHERE  numero_operacion = @NroOperacion 	

		  IF @@ERROR != 0  BEGIN   
		     RAISERROR ('FALLO AL INGRESAR CARTERA MODIFICADA',16,1);
		     RETURN 0
          END 


   /*-----------------------------------------------------------------------------*/
   /* SE INSERTAN REGISTROS EN CARTERA LOG                                        */
   /*-----------------------------------------------------------------------------*/
		INSERT INTO CARTERALOG  
		 ( numero_operacion  
		 , numero_flujo  
		 , tipo_flujo  
		 , tipo_swap  
		 , cartera_inversion  
		 , tipo_operacion  
		 , codigo_cliente  
		 , rut_cliente  
		 , fecha_cierre  
		 , fecha_inicio  
		 , fecha_termino  
		 , fecha_inicio_flujo  
		 , fecha_vence_flujo  
		 , fecha_fijacion_tasa  
		 , compra_moneda  
		 , compra_capital  
		 , compra_amortiza  
		 , compra_saldo  
		 , compra_interes  
		 , compra_spread  
		 , compra_codigo_tasa  
		 , compra_valor_tasa  
		 , compra_valor_tasa_hoy  
		 , compra_codamo_capital  
		 , compra_mesamo_capital  
		 , compra_codamo_interes  
		 , compra_mesamo_interes  
		 , compra_base  
		 , venta_moneda  
		 , venta_capital  
		 , venta_amortiza  
		 , venta_saldo  
		 , venta_interes  
		 , venta_spread  
		 , venta_codigo_tasa  
		 , venta_valor_tasa  
		 , venta_valor_tasa_hoy  
		 , venta_codamo_capital  
		 , venta_mesamo_capital  
		 , venta_codamo_interes  
		 , venta_mesamo_interes  
		 , venta_base  
		 , operador  
		 , operador_cliente  
		 , estado_flujo  
		 , modalidad_pago  
		 , pagamos_moneda  
		 , pagamos_documento  
		 , pagamos_monto  
		 , pagamos_monto_USD  
		 , pagamos_monto_CLP  
		 , recibimos_moneda  
		 , recibimos_documento  
		 , recibimos_monto  
		 , recibimos_monto_USD  
		 , recibimos_monto_CLP  
		 , observaciones  
		 , fecha_modifica  
		 , devengo_dias  
		 , devengo_monto_peso  
		 , devengo_monto  
		 , devengo_monto_acum  
		 , devengo_monto_ayer  
		 , devengo_compra  
		 , devengo_compra_acum  
		 , devengo_compra_acum_peso  
		 , devengo_compra_ayer  
		 , devengo_compra_ayer_peso  
		 , devengo_venta  
		 , devengo_venta_acum  
		 , devengo_venta_acum_peso  
		 , devengo_venta_ayer  
		 , devengo_venta_ayer_peso  
		 , fecha_valoriza  
		 , compra_zcr  
		 , compra_mercado_tasa  
		 , compra_mercado  
		 , compra_mercado_usd  
		 , compra_mercado_clp  
		 , compra_duration_tasa  
		 , compra_duration_monto  
		 , compra_duration_monto_usd  
		 , compra_duration_monto_clp  
		 , compra_valor_presente  
		 , venta_zcr  
		 , venta_mercado_tasa  
		 , venta_mercado  
		 , venta_mercado_usd  
		 , venta_mercado_clp  
		 , venta_duration_tasa  
		 , venta_duration_monto  
		 , venta_duration_monto_usd  
		 , venta_duration_monto_clp  
		 , venta_valor_presente  
		 , monto_mtm  
		 , monto_mtm_usd  
		 , monto_mtm_clp  
		 , compra_valorizada  
		 , compra_variacion  
		 , venta_valorizada  
		 , venta_variacion  
		 , valorizacion_dia  
		 , estado  
		 , Estado_oper_lineas  
		 , Observacion_Lineas  
		 , Observacion_Limites  
		 , Especial  
		 , Capital_Pesos_Actual  
		 , Capital_Pesos_Ayer  
		 , Hora  
		 , Tasa_Compra_Curva  
		 , Tasa_Venta_Curva  
		 , Activo_MO_C08  
		 , Pasivo_MO_C08  
		 , Activo_USD_C08  
		 , Pasivo_USD_C08  
		 , Activo_CLP_C08  
		 , Pasivo_CLP_C08  
		 , Tasa_Compra_CurvaVR  
		 , Tasa_Venta_CurvaVR  
		 , Activo_FlujoMO  
		 , Activo_FlujoUSD  
		 , Activo_FlujoCLP  
		 , Pasivo_FlujoMO  
		 , Pasivo_FlujoUSD  
		 , Pasivo_FlujoCLP  
		 , Valor_RazonableMO  
		 , Valor_RazonableUSD  
		 , Valor_RazonableCLP  
		 , Monto_Spread  
		 , Monto_diferido_inicial  
		 , Monto_diferido_diario  
		 , Monto_diferido_acumulado  
		 , TC_MO_Inicial  
		 , Monto_TC_Diario  
		 , Monto_TC_Acumulado  
		 , Monto_Reajuste_Diario  
		 , Monto_Reajuste_Acumulado  
		 , Monto_Valorizacion  
		 , Monto_Capital_TC_ini  
		 , log_area_responsable  
		 , log_Cartera_normativa  
		 , log_subcartera_normativa  
		 , log_libro  
		 , FeriadoFlujoChile  
		 , FeriadoFlujoEEUU  
		 , FeriadoFlujoEnglan  
		 , FeriadoLiquiChile  
		 , FeriadoLiquiEEUU  
		 , FeriadoLiquiEnglan  
		 , Convencion  
		 , DiasReset  
		 , FechaEfectiva  
		 , PrimerPago  
		 , PenultimoPago  
		 , Madurez  
		 , Note  
		 , IntercPrinc  
		 , Tikker  
		 , FechaLiquidacion  
		 , FechaReset  
		 , CompraTasaProyectada  
		 , VentaTasaProyectada  
		 , OrigenCurva  
		 , FxRate  
		 , Compra_amortiza_Prc  
		 , Venta_amortiza_Prc  
		 , Compra_Flujo_Adicional  
		 , Venta_Flujo_Adicional  
		 , FechaValuta  
		 , CompraPerResetCod  
		 , VentaPerResetCod  
		 , CompraLiqDefault  
		 , VentaLiqDefault  
		 , CompraResetDefault  
		 , VentaResetDefault  
		 , Compra_DV01_Forward  
		 , Venta_DV01_Forward  
		 , Compra_DV01_Descuento  
		 , Venta_DV01_Descuento  
		 , Compra_curva_TIR  
		 , Venta_curva_TIR  
		 , Compra_Curva_Descont  
		 , Venta_Curva_Descont  
		 , Compra_Curva_Forward  
		 , Venta_Curva_Forward  
		 , Monto_LCR_Matriz  
		 , Monto_LCR_Ajuste_AVR  
		 , Trader_Contraparte  
		 , Especifica_Negocio  
		 , Compra_Tasa_Forward_larga  
		 , Compra_Tasa_Forward_corta  
		 , PlazoFlujo  
		 , PortaFolio  
		 , Threshold 
		   --> PRD 12712 - 21707
		 , bEarlyTermination
		 , FechaInicio
		 , Periodicidad
		 --PRD 21657
         , ReferenciaUSDCLP 
         , ReferenciaMEXUSD
         , FechaUSDCLP
         , FechaMEXUSD 
		 --PRD 12712 - 21707
		 , InterNocIni
		 , InterNocFin   
		 )  
		 SELECT numero_operacion  
		 , numero_flujo  
		 , tipo_flujo  
		 , tipo_swap  
		 , cartera_inversion  
		 , tipo_operacion  
		 , codigo_cliente  
		 , rut_cliente  
		 , fecha_cierre  
		 , fecha_inicio  
		 , fecha_termino  
		 , fecha_inicio_flujo  
		 , fecha_vence_flujo  
		 , fecha_fijacion_tasa  
		 , compra_moneda  
		 , compra_capital  
		 , compra_amortiza  
		 , compra_saldo  
		 , compra_interes  
		 , compra_spread  
		 , compra_codigo_tasa  
		 , compra_valor_tasa  
		 , compra_valor_tasa_hoy  
		 , compra_codamo_capital  
		 , compra_mesamo_capital  
		 , compra_codamo_interes  
		 , compra_mesamo_interes  
		 , compra_base  
		 , venta_moneda  
		 , venta_capital  
		 , venta_amortiza  
		 , venta_saldo  
		 , venta_interes  
		 , venta_spread  
		 , venta_codigo_tasa  
		 , venta_valor_tasa  
		 , venta_valor_tasa_hoy  
		 , venta_codamo_capital  
		 , venta_mesamo_capital  
		 , venta_codamo_interes  
		 , venta_mesamo_interes  
		 , venta_base  
		 , operador  
		 , operador_cliente  
		 , estado_flujo  
		 , modalidad_pago  
		 , pagamos_moneda  
		 , pagamos_documento  
		 , pagamos_monto  
		 , pagamos_monto_USD  
		 , pagamos_monto_CLP  
		 , recibimos_moneda  
		 , recibimos_documento  
		 , recibimos_monto  
		 , recibimos_monto_USD  
		 , recibimos_monto_CLP  
		 , observaciones  
		 , CONVERT(CHAR(10),@FechaProceso,121) -- fecha_modifica 
		 , devengo_dias  
		 , devengo_monto_peso  
		 , devengo_monto  
		 , devengo_monto_acum  
		 , devengo_monto_ayer  
		 , devengo_compra  
		 , devengo_compra_acum  
		 , devengo_compra_acum_peso  
		 , devengo_compra_ayer    
		 , devengo_compra_ayer_peso  
		 , devengo_venta  
		 , devengo_venta_acum  
		 , devengo_venta_acum_peso  
		 , devengo_venta_ayer  
		 , devengo_venta_ayer_peso  
		 , fecha_valoriza  
		 , compra_zcr  
		 , compra_mercado_tasa  
		 , compra_mercado  
		 , compra_mercado_usd  
		 , compra_mercado_clp  
		 , compra_duration_tasa  
		 , compra_duration_monto  
		 , compra_duration_monto_usd  
		 , compra_duration_monto_clp  
		 , compra_valor_presente  
		 , venta_zcr  
		 , venta_mercado_tasa  
		 , venta_mercado  
		 , venta_mercado_usd  
		 , venta_mercado_clp  
		 , venta_duration_tasa  
		 , venta_duration_monto  
		 , venta_duration_monto_usd  
		 , venta_duration_monto_clp  
		 , venta_valor_presente  
		 , monto_mtm  
		 , monto_mtm_usd  
		 , monto_mtm_clp  
		 , compra_valorizada  
		 , compra_variacion  
		 , venta_valorizada  
		 , venta_variacion  
		 , valorizacion_dia  
		 , 'M'  
		 , Estado_oper_lineas  
		 , Observacion_Lineas  
		 , Observacion_Limites  
		 , Especial  
		 , Capital_Pesos_Actual  
		 , Capital_Pesos_Ayer  
		 , CONVERT(varchar(30), getdate(),108)	 -- Hora  
		 , Tasa_Compra_Curva  
		 , Tasa_Venta_Curva  
		 , Activo_MO_C08  
		 , Pasivo_MO_C08  
		 , Activo_USD_C08  
		 , Pasivo_USD_C08  
		 , Activo_CLP_C08  
		 , Pasivo_CLP_C08  
		 , Tasa_Compra_CurvaVR  
		 , Tasa_Venta_CurvaVR  
		 , Activo_FlujoMO  
		 , Activo_FlujoUSD  
		 , Activo_FlujoCLP  
		 , Pasivo_FlujoMO  
		 , Pasivo_FlujoUSD  
		 , Pasivo_FlujoCLP  
		 , Valor_RazonableMO  
		 , Valor_RazonableUSD  
		 , Valor_RazonableCLP  
		 , Monto_Spread  
		 , Monto_diferido_inicial  
		 , Monto_diferido_diario  
		 , Monto_diferido_acumulado  
		 , TC_MO_Inicial  
		 , Monto_TC_Diario  
		 , Monto_TC_Acumulado  
		 , Monto_Reajuste_Diario  
		 , Monto_Reajuste_Acumulado  
		 , Monto_Valorizacion  
		 , Monto_Capital_TC_ini  
		 , car_area_Responsable  
		 , car_Cartera_Normativa  
		 , car_SubCartera_Normativa  
		 , car_Libro  
		 , FeriadoFlujoChile  
		 , FeriadoFlujoEEUU  
		 , FeriadoFlujoEnglan  
		 , FeriadoLiquiChile  
		 , FeriadoLiquiEEUU  
		 , FeriadoLiquiEnglan  
		 , Convencion  
		 , DiasReset  
		 , FechaEfectiva  
		 , PrimerPago  
		 , PenultimoPago  
		 , Madurez  
		 , Note  
		 , IntercPrinc  
		 , Tikker  
		 , FechaLiquidacion  
		 , FechaReset  
		 , CompraTasaProyectada  
		 , VentaTasaProyectada  
		 , OrigenCurva  
		 , FxRate  
		 , Compra_amortiza_Prc  
		 , Venta_amortiza_Prc  
		 , Compra_Flujo_Adicional  
		 , Venta_Flujo_Adicional  
		 , FechaValuta  
		 , CompraPerResetCod  
		 , VentaPerResetCod  
		 , CompraLiqDefault
		 , VentaLiqDefault
		 , CompraResetDefault  
		 , VentaResetDefault  
		 , Compra_DV01_Forward  
		 , Venta_DV01_Forward  
		 , Compra_DV01_Descuento  
		 , Venta_DV01_Descuento  
		 , Compra_curva_TIR  
		 , Venta_curva_TIR  
		 , Compra_Curva_Descont  
		 , Venta_Curva_Descont  
		 , Compra_Curva_Forward  
		 , Venta_Curva_Forward  
		 , Monto_LCR_Matriz  
		 , Monto_LCR_Ajuste_AVR  
		 , Trader_Contraparte  
		 , Especifica_Negocio  
		 , Compra_Tasa_Forward_larga  
		 , Compra_Tasa_Forward_corta  
		 , PlazoFlujo  
		 , PortaFolio  
		 , Threshold
		   --> PRD 12712 - 21707
		,  bEarlyTermination
		,  FechaInicio
		,  Periodicidad
		-- PRD 21657
        ,  ReferenciaUSDCLP 
        ,  ReferenciaMEXUSD
        ,  FechaUSDCLP
        ,  FechaMEXUSD 
		--> PRD 12712 - 21707
		,  InterNocIni
		,  InterNocFin  
	FROM Cartera  
    WHERE numero_operacion = @NroOperacion 
      and estado <> 'C'


   /*-----------------------------------------------------------------------------*/
   /* CAMBIA ESTADO DE OPERACION AL SER MODIFICADA                                */
   /*-----------------------------------------------------------------------------*/
     UPDATE BACPARAMSUDA.DBO.TBL_PREPARA_OPERACIONES
	    SET COD_OPERACION = 'X'
	  WHERE ID_SISTEMA    = 'PCS'
	    AND NRO_OPERACION = @NroOperacion

		

	RETURN 1

END

GO

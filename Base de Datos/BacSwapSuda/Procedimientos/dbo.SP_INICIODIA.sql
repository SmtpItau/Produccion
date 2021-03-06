USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INICIODIA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INICIODIA]  
   (   @FechaProc   CHAR(08)  
   ,   @FechaProx   CHAR(08)  
   )  
AS  
BEGIN   
  -- SP_INICIODIA '20150623' , '20150624'
 SET NOCOUNT ON  
  
        BEGIN TRANSACTION  
  
        DECLARE @Fecha  DATETIME  
  
        SELECT @Fecha = fechaproc   
        FROM   SWAPGENERAL with(nolock)  


 --Actualizacion de Tasas para contratos Actualizados  
 UPDATE CARTERA   
 SET compra_valor_tasa = compra_valor_tasa_hoy   
 , venta_valor_tasa = venta_valor_tasa_hoy  
 , Monto_diferido_inicial  = Monto_diferido_diario  
 WHERE tipo_swap IN (1,2)  
  
 IF @@ERROR <> 0  
 BEGIN  
  ROLLBACK TRANSACTION  
  RETURN -99  
 END   
  
 --Actualizaci=n de Estado de Flujos  
-- UPDATE CARTERA   
-- SET ESTADO_FLUJO = 0   
-- WHERE FECHA_VENCE_FLUJO < @FechaProc  -- Marca a todos en cero  
/*  
 UPDATE CARTERA   
 SET ESTADO_FLUJO = 2   
 WHERE FECHA_VENCE_FLUJO = @FechaProc  -- Marca los vencidos  
*/  
  
/*      MAP 20071227 Cambia definicion del flujo vigente  
 UPDATE CARTERA   
 SET ESTADO_FLUJO = 1   
 WHERE FECHA_VENCE_FLUJO > @FechaProc  
--      Esto lo reqilizará el recacálculo  
*/  
  
 IF @@ERROR <> 0   
        BEGIN  
  ROLLBACK TRANSACTION  
  RETURN -100  
 END  
  
 --*==============================================================*  
 -- Elimina en cartera Historica los registros que se insertaron venciendo en el fin de dia  
 -- los cuales se insertaran nuevamente pero con estado vencidos  
  
        -- 27/08/2008 - Se comenta delete, ya que vctos, no se insertaran en el fin de día  
/*  
  
 DELETE CARTERAHIS  
 WHERE ESTADO_FLUJO = 2   
        AND     fecha_vence_flujo = @Fecha  
*/  
  
       DELETE CARTERAHIS  
         FROM CARTERA CAR   
        WHERE CARTERAHIS.NUMERO_OPERACION = CAR.NUMERO_OPERACION  
          AND CARTERAHIS.numero_flujo     = CAR.numero_flujo  
          AND CARTERAHIS.tipo_flujo       = CAR.tipo_flujo  
          AND CAR.fechaLiquidacion        < @FechaProc  
  
 INSERT INTO dbo.CARTERAHIS  
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
 , chi_area_Responsable  
 , chi_Cartera_Normativa  
 , chi_SubCartera_Normativa  
 , chi_Libro  
  
        ,       FeriadoFlujoChile  
        ,       FeriadoFlujoEEUU  
        ,       FeriadoFlujoEnglan  
        ,       FeriadoLiquiChile  
        ,       FeriadoLiquiEEUU  
        ,       FeriadoLiquiEnglan  
        ,       Convencion  
        ,       DiasReset  
        ,       FechaEfectiva  
        ,       PrimerPago  
        ,       PenultimoPago  
        ,       Madurez  
  
        ,       Note  
        ,       IntercPrinc  
        ,       Tikker  
 , FechaLiquidacion  
 , FechaReset  
 , CompraTasaProyectada  
 , VentaTasaProyectada  
        ,       OrigenCurva  
        -- Mejoras Swap  
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
 , Threshold --- PRD-4858,   
		-- PRD 12712 - 21707
		, bEarlyTermination      
		, FechaInicio
		, Periodicidad
		-- PRD 21657
  ,ReferenciaUSDCLP 
  ,ReferenciaMEXUSD
  ,FechaUSDCLP
  ,FechaMEXUSD 
		--> PRD 12712 - 21707
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
 , car_area_Responsable  
 , car_Cartera_Normativa  
 , car_SubCartera_Normativa  
 , car_Libro  
  
        ,       FeriadoFlujoChile  
        ,       FeriadoFlujoEEUU  
        ,       FeriadoFlujoEnglan  
        ,       FeriadoLiquiChile  
        ,       FeriadoLiquiEEUU  
      ,       FeriadoLiquiEnglan  
        ,       Convencion  
        ,       DiasReset  
        ,       FechaEfectiva  
        ,       PrimerPago  
        ,       PenultimoPago  
        ,       Madurez  
        ,       Note  
        ,       IntercPrinc  
        ,       Tikker  
 , FechaLiquidacion  
 , FechaReset  
 , CompraTasaProyectada  
 , VentaTasaProyectada  
        ,       OrigenCurva  
        -- Mejoras Swap  
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
 , Threshold  --- PRD-4858  
		-- PRD 12712 - 21707
		, bEarlyTermination      
		, FechaInicio
		, Periodicidad
		-- PRD 21657
  ,ReferenciaUSDCLP 
  ,ReferenciaMEXUSD
  ,FechaUSDCLP
  ,FechaMEXUSD 
		--> PRD 12712 - 21707
		, InterNocIni
		, InterNocFin  

 FROM CARTERA  
-- WHERE fecha_vence_flujo < @FechaProc  
 WHERE  (fechaLiquidacion < @FechaProc )  
             --(fecha_vence_flujo < @FechaProc AND tipo_swap <> 3)  ANTES  
--         OR    (fechaLiquidacion  < @FechaProc AND tipo_swap  =  3)  
          
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -101  
 END   
  
 --*==============================================================*  
 --Envfa Vencimientos del Dfa a Archivo de Log  
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
  
        ,       FeriadoFlujoChile  
        ,       FeriadoFlujoEEUU  
        ,       FeriadoFlujoEnglan  
        ,       FeriadoLiquiChile  
      ,       FeriadoLiquiEEUU  
        ,       FeriadoLiquiEnglan  
        ,       Convencion  
        ,       DiasReset  
        ,       FechaEfectiva  
        ,       PrimerPago  
        ,       PenultimoPago  
        ,       Madurez  
        ,       Note  
        ,       IntercPrinc  
        ,       Tikker  
 , FechaLiquidacion  
 , FechaReset  
 , CompraTasaProyectada  
 , VentaTasaProyectada  
        ,       OrigenCurva  
        -- Mejoras Swap  
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
 , Threshold  --- PRD-4858  
		-- PRD 12712 - 21707
		, bEarlyTermination      
		, FechaInicio
		, Periodicidad
		-- PRD 21657
  ,ReferenciaUSDCLP 
  ,ReferenciaMEXUSD
  ,FechaUSDCLP
  ,FechaMEXUSD 
		--> PRD 12712 - 21707
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
 , car_area_Responsable  
 , car_Cartera_Normativa  
 , car_SubCartera_Normativa  
 , car_Libro  
  
        ,       FeriadoFlujoChile  
        ,       FeriadoFlujoEEUU  
        ,       FeriadoFlujoEnglan  
        ,       FeriadoLiquiChile  
        ,       FeriadoLiquiEEUU  
        ,       FeriadoLiquiEnglan  
        ,       Convencion  
        ,       DiasReset  
        ,       FechaEfectiva  
        ,       PrimerPago  
        ,       PenultimoPago  
        ,       Madurez  
        ,       Note  
        ,       IntercPrinc  
        ,       Tikker  
 , FechaLiquidacion  
 , FechaReset  
 , CompraTasaProyectada  
 , VentaTasaProyectada  
        ,       OrigenCurva  
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
 , Threshold  --- PRD-4858  
		-- PRD 12712
		, bEarlyTermination      
		, FechaInicio
		, Periodicidad
		-- PRD 21657
  ,ReferenciaUSDCLP 
  ,ReferenciaMEXUSD
  ,FechaUSDCLP
  ,FechaMEXUSD 
		--> PRD 12712 - 21707
		, InterNocIni
		, InterNocFin  
 FROM CARTERA  
 WHERE  (fecha_vence_flujo < @FechaProc AND tipo_swap <> 3)  
OR    (fechaLiquidacion  < @FechaProc AND tipo_swap  =  3)  
  
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -102  
 END   
  
 /* Antes de eliminar los movimientos de la Cartera, liberar las operaciones con Garantías  (PRD-5521)  */  
 IF EXISTS(SELECT Sistema, OperacionSistema FROM Bacparamsuda..tbl_Registro_Garantias  
  WHERE Sistema = 'PCS' AND OperacionSistema IN (SELECT numero_operacion FROM BacSwapsuda..CARTERA  
   WHERE FechaLiquidacion < @FechaProc ))  
 BEGIN  
  /* Ver si hay candidatos a eliminar en tbl_Garantias_Faltantes */  
  
  IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Garantias_Faltantes  
  WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias  
    WHERE Sistema = 'PCS' AND OperacionSistema IN (SELECT numero_operacion FROM BacSwapsuda..CARTERA  
    WHERE FechaLiquidacion < @FechaProc )))  
      
   DELETE Bacparamsuda..tbl_Garantias_Faltantes  
   WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias  
   WHERE Sistema = 'PCS' AND OperacionSistema IN (SELECT numero_operacion FROM BacSwapsuda..CARTERA  
    WHERE FechaLiquidacion < @FechaProc ))  
   
  /*  Continuar con el proceso de borrado de las garantías */   
  
  DELETE Bacparamsuda..tbl_Registro_Garantias  
   WHERE Sistema = 'PCS' AND OperacionSistema IN (SELECT numero_operacion FROM BacSwapsuda..CARTERA  
    WHERE FechaLiquidacion < @FechaProc )  
  
  IF @@ERROR <> 0  
  BEGIN  
   ROLLBACK TRANSACTION  
   RETURN -110  
  END  
 END  
 /* Fin liberación de Garantías PRD-5521 */  
 --*==============================================================*  
 --Rebaja flujos Vencidos de Cartera  
 DELETE  CARTERA   
 WHERE  /* (fecha_vence_flujo < @FechaProc AND tipo_swap <> 3)  
         OR    */ (fechaLiquidacion  < @FechaProc /*AND tipo_swap  =  3 */ )  
  
  
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -103  
 END   
  
 --*==============================================================*  
 --Limpia Archivo de Movimientos Diarios  
 DELETE MOVDIARIO   
  
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -104  
 END   
  
 --*==============================================================*  
 --Actualiza Archivo de Parametros del Dfa  
  
 UPDATE SWAPGENERAL  
 SET fechaant        = fechaproc   
 , fechaproc       = @fechaproc  
 , fechaprox       = @fechaprox  
 , iniciodia       = 1           
 , libor           = 0         
 , paridad         = 0           
 , tasamtm         = 0          
 , findia          = 0           
 , devengo         = 0         
 , contabilidad    = 0        
 , cierremesa      = '0'  
 , Vencimientos    = CASE WHEN ( SELECT COUNT(1) FROM CARTERA   
                                              WHERE Estado <> 'C'    
                                               and fecha_vence_flujo = @fechaproc AND tipo_swap = 4) > 0 THEN 0  
           ELSE 1   
                                  END  
         ,      ActTasaVarVcto  = 0  
  
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -105  
 END    
  
 --*==============================================================*  
 --Actualiza Archivo de Tasas MTM  
 DECLARE @FechaResp CHAR(8)  
   
 SELECT @FechaResp = CONVERT(CHAR(8),MAX(fecha),112)   
 FROM VIEW_TASA_MONEDA  
 WHERE fecha <= @FechaProc  
  
        IF @FechaResp IS NULL   
        BEGIN  
  SELECT *   
  INTO #Temp   
  FROM VIEW_TASA_MONEDA   
  WHERE fecha = @FechaResp  
  
  UPDATE #TEMP   
  SET fecha = @FechaProc  
  
  INSERT INTO VIEW_TASA_MONEDA   
  SELECT *   
  FROM #TEMP  
                       
  IF @@ERROR <> 0    
                BEGIN  
     ROLLBACK TRANSACTION  
     RETURN -106  
  END   
        END  
   
 --*==============================================================*  
 --Actualiza Archivo de Tasas por Moneda diarias  
 SELECT @FechaResp = CONVERT(CHAR(8),MAX(fecha),112)  
 FROM VIEW_MONEDA_TASA  
 WHERE fecha <= @FechaProc  
  
 IF @FechaResp IS NULL   
        BEGIN  
         SELECT *   
  INTO #TEMP2   
  FROM VIEW_MONEDA_TASA   
  WHERE fecha = @FechaResp  
  
  UPDATE #TEMP2   
  SET fecha = @FechaProc  
  
  INSERT INTO VIEW_MONEDA_TASA   
  SELECT *   
  FROM #Temp2  
                        
  IF @@ERROR <> 0   
                BEGIN  
     ROLLBACK TRANSACTION  
     RETURN -107  
  END   
        END  
  
 UPDATE CARTERA   
 SET DevAntPromCam = devengo_monto_acum  
 WHERE tipo_swap = 4  
  
 IF @@ERROR <> 0   
        BEGIN  
    ROLLBACK TRANSACTION  
    RETURN -107  
 END  
   
 --Actualizacion de Tasas para contratos Actualizados de ticket Intra Mesa  
   UPDATE  TBL_FLJTICKETSWAP  
   SET    compra_valor_tasa     = compra_valor_tasa_hoy  
   ,       venta_valor_tasa     = venta_valor_tasa_hoy  
   ,       Monto_diferido_inicial   = Monto_diferido_diario  
  
   IF @@ERROR <> 0  
   BEGIN  
      ROLLBACK TRANSACTION  
      RETURN -108  
   END  
  
   -->    Elimina los Flujos Vencidos, Insertados en la Flujos vencidos que aun se encuentren en Cartera  
   DELETE TBL_FLJTICKETSWAP_HIST  
     FROM TBL_FLJTICKETSWAP CAR   
    WHERE TBL_FLJTICKETSWAP_HIST.NUMERO_OPERACION = CAR.NUMERO_OPERACION  
      AND TBL_FLJTICKETSWAP_HIST.numero_flujo     = CAR.numero_flujo  
      AND TBL_FLJTICKETSWAP_HIST.tipo_flujo       = CAR.tipo_flujo  
      AND CAR.fechaLiquidacion                    < @FechaProc  
  
   IF @@ERROR <> 0  
   BEGIN  
      ROLLBACK TRANSACTION  
      RETURN -108  
   END   
  
   -->   Inserta los flujos los flujos vencidos en registro de vencimientos  
   INSERT INTO TBL_FLJTICKETSWAP_HIST  
      SELECT * FROM TBL_FLJTICKETSWAP WHERE fechaLiquidacion < @FechaProc  
  
   IF @@ERROR <> 0  
   BEGIN  
      ROLLBACK TRANSACTION  
      RETURN -108  
   END  
  
   -->    Elimina los Flujos Vencidos de la Cartera  
   DELETE TBL_FLJTICKETSWAP   
   WHERE (fechaLiquidacion  < @FechaProc )  
   
   IF @@ERROR <> 0   
   BEGIN  
      ROLLBACK TRANSACTION  
      RETURN -109  
   END  

   -->    Genera Caja 
   create table #RecibePrcCaja ( Codigo numeric(5), Msg Varchar(200) )
   insert into #RecibePrcCaja
   Exec SP_GRABA_LIQUIDACION @FechaProc
   if @@Error <> 0
   Begin
      ROLLBACK TRANSACTION  
      RETURN -115     
   end 

   -->    Genera Caja , proximo dia hábil
   -- create table #RecibePrcCaja ( Codigo numeric(5), Msg Varchar(200) )
   insert into #RecibePrcCaja
   Exec SP_GRABA_LIQUIDACION @FechaProx
   if @@Error <> 0
   Begin
      ROLLBACK TRANSACTION  
      RETURN -115     
   end 

   -->    Genera Caja , siguiente a proximo dia hábil
   -- create table #RecibePrcCaja ( Codigo numeric(5), Msg Varchar(200) )
   declare @fechaProxProx datetime
   select  @fechaProxProx = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES(  @FechaProx, 1, ';6;' )
   insert into #RecibePrcCaja
   Exec SP_GRABA_LIQUIDACION @fechaProxProx 
   if @@Error <> 0
   Begin
      ROLLBACK TRANSACTION  
      RETURN -115     
   end 


   update BacParamSuda.dbo.Tabla_general_detalle
     set Nemo = '1'  -- Bloqueo de anticipo
    where tbcateg = 33 
   if @@Error <> 0
   Begin
      ROLLBACK TRANSACTION  
      RETURN -115     
   end 

   
 COMMIT TRANSACTION  
 -- ROLLBACK TRANSACTION 
  
 RETURN 0  
END


GO

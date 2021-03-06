USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDIA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[SP_FINDIA]  
   (   @FechaProc    CHAR(08)  
   ,   @Proceso      NUMERIC(1)  
   )  
AS  
BEGIN   
  
   SET NOCOUNT ON  
  
   IF @Proceso = 0   
   BEGIN   
  
      DELETE CARTERARES WHERE Fecha_Proceso = @FechaProc  --select * from carterares  
  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -300  
         RETURN   
         SET NOCOUNT OFF  
      END     
  
      INSERT INTO CARTERARES  
      (      Fecha_Proceso  
      ,      numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
      ,      compra_spread  
      ,      compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,      venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
      ,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      devengo_dias  
      ,      devengo_monto  
      ,      devengo_monto_peso  
      ,      devengo_monto_acum  
      ,      devengo_monto_ayer  
      ,      devengo_compra  
      ,      devengo_compra_acum  
      ,      devengo_compra_acum_peso  
      ,      devengo_compra_ayer  
      ,      devengo_compra_ayer_peso  
      ,      devengo_venta  
      ,      devengo_venta_acum  
      ,      devengo_venta_acum_peso  
      ,      devengo_venta_ayer  
      ,      devengo_venta_ayer_peso  
      ,      fecha_valoriza  
      ,      compra_zcr  
      ,      compra_mercado_tasa  
      ,      compra_mercado  
      ,      compra_mercado_usd  
      ,      compra_mercado_clp  
      ,      compra_duration_tasa  
      ,      compra_duration_monto  
      ,      compra_duration_monto_usd  
      ,      compra_duration_monto_clp  
      ,      compra_valor_presente  
      ,      venta_zcr  
      ,      venta_mercado_tasa  
      ,      venta_mercado  
      ,      venta_mercado_usd  
      ,      venta_mercado_clp  
      ,      venta_duration_tasa  
      ,      venta_duration_monto  
      ,      venta_duration_monto_usd  
      ,      venta_duration_monto_clp  
      ,      venta_valor_presente  
      ,      monto_mtm  
      ,      monto_mtm_usd  
      ,      monto_mtm_clp  
      ,      compra_valorizada  
      ,      compra_variacion  
      ,      venta_valorizada  
      ,      venta_variacion  
      ,      valorizacion_dia  
      ,      estado  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      Capital_Pesos_Actual  
      ,      Capital_Pesos_Ayer  
      ,      Hora  
      ,      Tasa_Compra_Curva  
      ,      Tasa_Venta_Curva  
      ,      Activo_MO_C08  
      ,      Pasivo_MO_C08  
      ,      Activo_USD_C08  
      ,      Pasivo_USD_C08  
      ,      Activo_CLP_C08  
      ,      Pasivo_CLP_C08  
      ,      Tasa_Compra_CurvaVR  
      ,      Tasa_Venta_CurvaVR  
      ,      Activo_FlujoMO  
      ,      Activo_FlujoUSD  
      ,      Activo_FlujoCLP  
      ,      Pasivo_FlujoMO  
      ,      Pasivo_FlujoUSD  
      ,      Pasivo_FlujoCLP  
      ,      Valor_RazonableMO  
      ,      Valor_RazonableUSD  
      ,      Valor_RazonableCLP  
      ,      Monto_Spread                 
      ,      Monto_diferido_inicial        
      ,      Monto_diferido_diario        
      ,      Monto_diferido_acumulado       
      ,      TC_MO_Inicial     
      ,      Monto_TC_Diario    
      ,      Monto_TC_Acumulado        
      ,      Monto_Reajuste_Diario      
      ,      Monto_Reajuste_Acumulado      
      ,      Monto_Valorizacion       
      ,      Monto_Capital_TC_ini    
      ,      cre_area_responsable  
      ,      cre_cartera_normativa  
      ,      cre_subcartera_normativa  
      ,      cre_libro  
      ,      vRazAjustado_Mo  
      ,      vRazAjustado_Mn  
      ,      vRazAjustado_Do  
      ,      vRazActivoAjus_Mo  
      ,      vRazPasivoAjus_Mo  
      ,      vRazActivoAjus_Mn  
      ,      vRazPasivoAjus_Mn  
      ,      vRazActivoAjus_Do  
      ,      vRazPasivoAjus_Do  
      ,      vTasaActivaAjusta  
      ,      vTasaPasivaAjusta  
      ,      vDurMacaulActivo  
      ,      vDurMacaulPasivo  
  ,      vDurModifiActivo  
      ,      vDurModifiPasivo  
      ,      vDurConvexActivo  
      ,      vDurConvexPasivo  
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
      ,      OrigenCurva  
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
,       Threshold --- PRD-4858, 17-02-2010  
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
      SELECT @FechaProc  
      ,      numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
      ,      compra_spread  
      ,  compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,      venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
      ,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      devengo_dias  
      ,      devengo_monto  
      ,      devengo_monto_peso  
      ,      devengo_monto_acum  
      ,      devengo_monto_ayer  
      ,      devengo_compra  
      ,      devengo_compra_acum  
      ,      devengo_compra_acum_peso  
      ,      devengo_compra_ayer  
      ,      devengo_compra_ayer_peso  
      ,      devengo_venta  
      ,      devengo_venta_acum  
      ,      devengo_venta_acum_peso  
      ,      devengo_venta_ayer  
      ,      devengo_venta_ayer_peso  
      ,      fecha_valoriza  
      ,      compra_zcr  
      ,      compra_mercado_tasa  
      ,      compra_mercado  
      ,      compra_mercado_usd  
      ,      compra_mercado_clp  
      ,      compra_duration_tasa  
      ,      compra_duration_monto  
      ,      compra_duration_monto_usd  
      ,      compra_duration_monto_clp  
      ,      compra_valor_presente  
      ,      venta_zcr  
      ,      venta_mercado_tasa  
      ,      venta_mercado  
      ,      venta_mercado_usd  
      ,      venta_mercado_clp  
      ,      venta_duration_tasa  
      ,      venta_duration_monto  
      ,      venta_duration_monto_usd  
      ,      venta_duration_monto_clp  
      ,      venta_valor_presente  
      ,      monto_mtm  
      ,      monto_mtm_usd  
      ,      monto_mtm_clp  
      ,      compra_valorizada  
      ,      compra_variacion  
      ,      venta_valorizada  
      ,      venta_variacion  
      ,      valorizacion_dia  
      ,      estado  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      Capital_Pesos_Actual  
      ,      Capital_Pesos_Ayer  
      ,      Hora  
      ,      Tasa_Compra_Curva  
      ,      Tasa_Venta_Curva  
      ,      Activo_MO_C08  
      ,      Pasivo_MO_C08  
      ,      Activo_USD_C08  
      ,      Pasivo_USD_C08  
      ,      Activo_CLP_C08  
      ,      Pasivo_CLP_C08  
      ,      Tasa_Compra_CurvaVR  
      ,      Tasa_Venta_CurvaVR  
      ,      Activo_FlujoMO  
      ,      Activo_FlujoUSD  
      ,      Activo_FlujoCLP  
      ,      Pasivo_FlujoMO  
   ,      Pasivo_FlujoUSD  
      ,      Pasivo_FlujoCLP  
      ,      Valor_RazonableMO  
      ,      Valor_RazonableUSD  
      ,      Valor_RazonableCLP  
      ,      Monto_Spread                 
      ,      Monto_diferido_inicial        
      ,      Monto_diferido_diario        
      ,      Monto_diferido_acumulado       
      ,      TC_MO_Inicial     
      ,      Monto_TC_Diario    
      ,      Monto_TC_Acumulado        
      ,      Monto_Reajuste_Diario      
      ,      Monto_Reajuste_Acumulado      
      ,      Monto_Valorizacion       
      ,      Monto_Capital_TC_ini    
      ,      car_area_Responsable  
      ,      car_Cartera_Normativa  
      ,      car_SubCartera_Normativa  
      ,      car_Libro  
      ,      vRazAjustado_Mo  
      ,      vRazAjustado_Mn  
      ,      vRazAjustado_Do  
      ,      vRazActivoAjus_Mo  
      ,      vRazPasivoAjus_Mo  
      ,      vRazActivoAjus_Mn  
      ,      vRazPasivoAjus_Mn  
      ,      vRazActivoAjus_Do  
      ,      vRazPasivoAjus_Do  
      ,      vTasaActivaAjusta  
      ,      vTasaPasivaAjusta  
      ,      vDurMacaulActivo  
      ,      vDurMacaulPasivo  
      ,      vDurModifiActivo  
      ,      vDurModifiPasivo  
      ,      vDurConvexActivo  
      ,      vDurConvexPasivo  
-- MAP 20061124  
, FeriadoFlujoChile  
, FeriadoFlujoEEUU  , FeriadoFlujoEnglan  
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
,      OrigenCurva  
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
,       Threshold --- PRD-4858,  17-02-2010  
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
      FROM   CARTERA  
  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -310  
         RETURN  
         SET NOCOUNT OFF   
      END  
  
      /* Solo deja los ultimos 60 dias de respaldo VGS (14/07/2005)*/  
      /* Solo deja los ultimos 2 años de respaldo VGS (01/08/2005)*/  
      -- DELETE CARTERARES WHERE Fecha_Proceso < DATEADD(yy,-2,@FechaProc) Por mientras se hacen pruebas  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -320  
         RETURN  
         SET NOCOUNT OFF   
      END     
  
        
  
      /* Traspasar Threshold a histórico  PRD-4858,  25-02-2010   */   
      EXECUTE SP_RESPALDAHISTORICOTHRESHOLD @FechaProc  
      /* Traspasar Threshold a histórico  PRD-4858,  25-02-2010   */   
  
   END ELSE   
   IF @Proceso = 1   
   BEGIN   
      --Envfa Vencimientos del Dfa a Archivo de Log  
  
      DELETE CARTERALOG WHERE FECHA_VENCE_FLUJO = @FechaProc   
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -212  
         RETURN  
         SET NOCOUNT OFF  
      END  
  
      INSERT INTO CARTERALOG  
      (      numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
      ,      compra_spread  
      ,      compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,      venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
      ,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      devengo_dias  
      ,      devengo_monto_peso  
      ,      devengo_monto  
      ,      devengo_monto_acum  
      ,      devengo_monto_ayer  
      ,      devengo_compra  
      ,      devengo_compra_acum  
      ,      devengo_compra_acum_peso  
      ,      devengo_compra_ayer  
      ,      devengo_compra_ayer_peso  
      ,      devengo_venta  
      ,      devengo_venta_acum  
      ,      devengo_venta_acum_peso  
      ,      devengo_venta_ayer  
      ,      devengo_venta_ayer_peso  
      ,      fecha_valoriza  
      ,      compra_zcr  
      ,      compra_mercado_tasa  
      ,      compra_mercado  
      ,      compra_mercado_usd  
      ,      compra_mercado_clp  
      ,      compra_duration_tasa  
      ,      compra_duration_monto  
      ,      compra_duration_monto_usd  
      ,      compra_duration_monto_clp  
      ,      compra_valor_presente  
      ,      venta_zcr  
      ,      venta_mercado_tasa  
      ,      venta_mercado  
      ,      venta_mercado_usd  
      ,      venta_mercado_clp  
      ,      venta_duration_tasa  
      ,      venta_duration_monto  
      ,      venta_duration_monto_usd  
      ,      venta_duration_monto_clp  
      ,      venta_valor_presente  
      ,      monto_mtm  
      ,      monto_mtm_usd  
      ,      monto_mtm_clp  
      ,      compra_valorizada  
      ,      compra_variacion  
      ,      venta_valorizada  
      ,      venta_variacion  
      ,      valorizacion_dia  
      ,      estado  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      Capital_Pesos_Actual  
      ,      Capital_Pesos_Ayer  
      ,      Hora  
      ,      Tasa_Compra_Curva  
      ,      Tasa_Venta_Curva  
      ,      Activo_MO_C08  
      ,      Pasivo_MO_C08  
      ,      Activo_USD_C08  
      ,      Pasivo_USD_C08  
      ,      Activo_CLP_C08  
      ,      Pasivo_CLP_C08  
      ,      Tasa_Compra_CurvaVR  
      ,      Tasa_Venta_CurvaVR  
      ,      Activo_FlujoMO  
      ,      Activo_FlujoUSD  
      ,      Activo_FlujoCLP  
      ,      Pasivo_FlujoMO  
      ,      Pasivo_FlujoUSD  
      ,      Pasivo_FlujoCLP  
      ,      Valor_RazonableMO  
      ,      Valor_RazonableUSD  
      ,      Valor_RazonableCLP  
      ,      Monto_Spread  
      ,      Monto_diferido_inicial  
      ,      Monto_diferido_diario  
      ,      Monto_diferido_acumulado  
      ,      TC_MO_Inicial  
      ,      Monto_TC_Diario  
      ,      Monto_TC_Acumulado  
      ,      Monto_Reajuste_Diario  
      ,      Monto_Reajuste_Acumulado  
      ,      Monto_Valorizacion  
      ,      Monto_Capital_TC_ini  
      ,      log_area_responsable  
      ,      log_Cartera_normativa  
      ,      log_subcartera_normativa  
      ,      log_libro  
  
  
      ,      vRazAjustado_Mo  
      ,      vRazAjustado_Mn  
      ,      vRazAjustado_Do  
      ,      vRazActivoAjus_Mo  
      ,      vRazPasivoAjus_Mo  
      ,      vRazActivoAjus_Mn  
      ,      vRazPasivoAjus_Mn  
      ,      vRazActivoAjus_Do  
      ,      vRazPasivoAjus_Do  
      ,      vTasaActivaAjusta  
      ,      vTasaPasivaAjusta  
      ,      vDurMacaulActivo  
      ,      vDurMacaulPasivo  
      ,      vDurModifiActivo  
      ,      vDurModifiPasivo  
      ,      vDurConvexActivo  
      ,      vDurConvexPasivo  
-- MAP 20061124  
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
,       Threshold --- PRD-4858, 17-02-2010  
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
      )  
      SELECT numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
      ,      compra_spread  
      ,      compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,  venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
      ,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      devengo_dias  
      ,      devengo_monto_peso  
      ,      devengo_monto  
      ,      devengo_monto_acum  
      ,      devengo_monto_ayer  
      ,      devengo_compra  
      ,      devengo_compra_acum  
      ,      devengo_compra_acum_peso  
      ,      devengo_compra_ayer  
      ,      devengo_compra_ayer_peso  
      ,      devengo_venta  
      ,      devengo_venta_acum  
      ,      devengo_venta_acum_peso  
      ,      devengo_venta_ayer  
      ,      devengo_venta_ayer_peso  
      ,      fecha_valoriza  
      ,      compra_zcr  
      ,      compra_mercado_tasa  
      ,      compra_mercado  
      ,      compra_mercado_usd  
      ,      compra_mercado_clp  
      ,      compra_duration_tasa  
      ,      compra_duration_monto  
      ,      compra_duration_monto_usd  
      ,      compra_duration_monto_clp  
      ,      compra_valor_presente  
      ,      venta_zcr  
      ,      venta_mercado_tasa  
      ,      venta_mercado  
      ,      venta_mercado_usd  
      ,      venta_mercado_clp  
      ,      venta_duration_tasa  
      ,      venta_duration_monto  
      ,      venta_duration_monto_usd  
      ,      venta_duration_monto_clp  
      ,      venta_valor_presente  
      ,      monto_mtm  
      ,      monto_mtm_usd  
      ,      monto_mtm_clp  
      ,      compra_valorizada  
      ,      compra_variacion  
      ,      venta_valorizada  
      ,      venta_variacion  
      ,      valorizacion_dia  
      ,      estado  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      Capital_Pesos_Actual        ,      Capital_Pesos_Ayer  
      ,      Hora  
      ,      Tasa_Compra_Curva  
      ,      Tasa_Venta_Curva  
      ,      Activo_MO_C08  
      ,      Pasivo_MO_C08  
      ,      Activo_USD_C08  
      ,      Pasivo_USD_C08  
      ,      Activo_CLP_C08  
      ,      Pasivo_CLP_C08  
      ,      Tasa_Compra_CurvaVR  
      ,      Tasa_Venta_CurvaVR  
   ,      Activo_FlujoMO  
      ,      Activo_FlujoUSD  
      ,      Activo_FlujoCLP  
      ,      Pasivo_FlujoMO  
      ,      Pasivo_FlujoUSD  
      ,      Pasivo_FlujoCLP  
      ,      Valor_RazonableMO  
      ,      Valor_RazonableUSD  
      ,      Valor_RazonableCLP  
      ,      Monto_Spread  
      ,      Monto_diferido_inicial  
      ,      Monto_diferido_diario  
      ,      Monto_diferido_acumulado  
      ,      TC_MO_Inicial  
      ,      Monto_TC_Diario  
      ,      Monto_TC_Acumulado  
      ,      Monto_Reajuste_Diario  
      ,      Monto_Reajuste_Acumulado  
      ,      Monto_Valorizacion  
      ,      Monto_Capital_TC_ini    
      ,      car_area_Responsable  
      ,      car_Cartera_Normativa  
      ,      car_SubCartera_Normativa  
      ,      car_Libro  
  
      ,      vRazAjustado_Mo  
      ,      vRazAjustado_Mn  
      ,      vRazAjustado_Do  
      ,      vRazActivoAjus_Mo  
      ,      vRazPasivoAjus_Mo  
      ,      vRazActivoAjus_Mn  
      ,      vRazPasivoAjus_Mn  
      ,      vRazActivoAjus_Do  
      ,      vRazPasivoAjus_Do  
      ,      vTasaActivaAjusta  
      ,      vTasaPasivaAjusta  
      ,      vDurMacaulActivo  
      ,      vDurMacaulPasivo  
      ,      vDurModifiActivo  
      ,      vDurModifiPasivo  
      ,      vDurConvexActivo  
      ,      vDurConvexPasivo  
-- MAP 20061124  
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
,      OrigenCurva  
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
,       Threshold --- PRD-4858, 17-02-2010  
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
  
      FROM   CARTERA  
      WHERE  fecha_vence_flujo = @FechaProc  
  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -112  
         RETURN  
         SET NOCOUNT OFF  
      END  
   END ELSE  
   IF @Proceso = 2   
   BEGIN   
      --Envfa Movimientos del Dfa a Movimiento Historico  
      DELETE MOVHISTORICO WHERE fecha_cierre = @FechaProc   
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -213  
         RETURN   
         SET NOCOUNT OFF  
      END  
  
      INSERT INTO MOVHISTORICO  
      (      numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
   ,      compra_spread  
      ,      compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,      venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      SwImpresion  
      ,      Hora  
      ,      ParidadCompra  
      ,      ParidadVenta  
      ,      Monto_Spread  
      ,      mhi_area_responsable  
      ,      mhi_cartera_normativa  
      ,      mhi_subcartera_normativa  
      ,      mhi_libro  
      ,      Estado  
      ,      Tasa_Transfer  
      ,      Spread_Transfer  
      ,      Res_Mesa_Dist_CLP  
      ,      Res_Mesa_Dist_USD  
      ,      Threshold --- PRD-4858, 17-02-2010  
  -- PRD 12712 - 21707  
   ,  bEarlyTermination        
   ,  FechaInicio  
   ,  Periodicidad  
   -- PRD 21657  
  ,ReferenciaUSDCLP   
  ,ReferenciaMEXUSD  
  ,FechaUSDCLP  
  ,FechaMEXUSD   
   --> PRD 12712 - 21707  
   ,  InterNocIni  
   ,  InterNocFin      
      )  
      SELECT numero_operacion  
      ,      numero_flujo  
      ,      tipo_flujo  
      ,      tipo_swap  
      ,      cartera_inversion  
      ,      tipo_operacion  
      ,      codigo_cliente  
      ,      rut_cliente  
      ,      fecha_cierre  
      ,      fecha_inicio  
      ,      fecha_termino  
      ,      fecha_inicio_flujo  
      ,      fecha_vence_flujo  
      ,      fecha_fijacion_tasa  
      ,      compra_moneda  
      ,      compra_capital  
      ,      compra_amortiza  
      ,      compra_saldo  
      ,      compra_interes  
      ,      compra_spread  
      ,      compra_codigo_tasa  
      ,      compra_valor_tasa  
      ,      compra_valor_tasa_hoy  
      ,      compra_codamo_capital  
      ,      compra_mesamo_capital  
      ,      compra_codamo_interes  
      ,      compra_mesamo_interes  
      ,      compra_base  
      ,      venta_moneda  
      ,      venta_capital  
      ,      venta_amortiza  
      ,      venta_saldo  
      ,      venta_interes  
      ,      venta_spread  
      ,      venta_codigo_tasa  
      ,      venta_valor_tasa  
      ,      venta_valor_tasa_hoy  
      ,      venta_codamo_capital  
      ,      venta_mesamo_capital  
      ,      venta_codamo_interes  
      ,      venta_mesamo_interes  
      ,      venta_base  
      ,      operador  
      ,      operador_cliente  
      ,      estado_flujo  
      ,      modalidad_pago  
      ,      pagamos_moneda  
      ,      pagamos_documento  
      ,      pagamos_monto  
      ,      pagamos_monto_USD  
      ,      pagamos_monto_CLP  
      ,      recibimos_moneda  
      ,      recibimos_documento  
      ,      recibimos_monto  
      ,      recibimos_monto_USD  
      ,      recibimos_monto_CLP  
      ,      observaciones  
      ,      fecha_modifica  
      ,      Estado_oper_lineas  
      ,      Observacion_Lineas  
      ,      Observacion_Limites  
      ,      Especial  
      ,      SwImpresion  
      ,      Hora  
      ,      ParidadCompra  
,      ParidadVenta  
      ,      Monto_Spread  
      ,      mov_area_responsable  
      ,      mov_cartera_normativa  
      ,      mov_subcartera_normativa  
      ,      mov_libro  
      ,      Estado     -- Ahora puede ser cotizacion: 'C'  
      ,      Tasa_Transfer  
      ,      Spread_Transfer  
      ,      Res_Mesa_Dist_CLP  
      ,      Res_Mesa_Dist_USD  
      ,      Threshold     --- PRD-4858,  17-02-2010  
      -- PRD 12712 - 21707  
   ,  bEarlyTermination        
   ,  FechaInicio  
   ,  Periodicidad  
   -- PRD 21657  
  ,ReferenciaUSDCLP   
  ,ReferenciaMEXUSD  
  ,FechaUSDCLP  
  ,FechaMEXUSD   
   --> PRD 12712 - 21707  
   ,  InterNocIni  
   ,  InterNocFin   
      FROM   MOVDIARIO  
      WHERE  fecha_cierre = @FechaProc  
  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -113  
         RETURN   
         SET NOCOUNT OFF  
      END  
   END ELSE   
   IF @Proceso = 3   
   BEGIN   
      --Envfa Parámetros del Dfa a Parámetros Historico  
      DELETE SWAPGENERALHIS WHERE FECHAPROC = @FechaProc   
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -214  
         RETURN   
         SET NOCOUNT OFF  
      END  
  
      INSERT INTO SWAPGENERALHIS  
      (      entidad  
      ,      codigo  
      ,      nombre  
      ,      rut  
      ,      direccion  
      ,      comuna  
      ,      ciudad  
      ,      telefono  
      ,   fax  
      ,      fechaant  
      ,      fechaproc  
      ,      fechaprox  
      ,      numero_operacion  
      ,      rutbcch  
      ,    iniciodia  
      ,      libor  
      ,      paridad  
      ,      tasamtm  
      ,      tasas  
      ,      findia  
      ,      cierreMesa  
      ,      codigobanco  
      ,      devengo  
      ,      contabilidad  
      )  
      SELECT entidad  
      ,      codigo  
      ,      nombre  
      ,      rut  
      ,      direccion  
      ,      comuna  
      ,      ciudad  
      ,      telefono  
      ,      fax  
      ,      fechaant  
      ,      fechaproc  
      ,      fechaprox  
      ,      numero_operacion  
      ,      rutbcch  
      ,      iniciodia  
      ,      libor  
      ,      paridad  
      ,      tasamtm  
      ,      tasas  
      ,      findia  
      ,      cierreMesa  
      ,      codigobanco  
      ,      devengo  
      ,      contabilidad  
      FROM   SWAPGENERAL  
      WHERE  fechaproc = @FechaProc  
  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT  -114  
         RETURN   
         SET NOCOUNT OFF  
      END  
   END ELSE   
   IF @Proceso = 4   
   BEGIN   
      --Actualiza Archivo de Parametros del Dfa  
      UPDATE SWAPGENERAL  
      SET    findia     = 1  
      ,      iniciodia  = 0  
            
      IF @@ERROR <> 0  
      BEGIN  
         SELECT -115  
         RETURN   
         SET NOCOUNT OFF  
      END  
   END  
  
   -->>BAJADA OPCIONES INICIO DE DIA AUTOMATICO
   --VGS  
	 Update CbMdbOpc..OpcionesGeneral             
	 set  cierreMesa = 1--case when cierreMesa = 0 then 0 else 1 end             
	  , findia       = 1             
	  , devengo      = 1            
	  , contabilidad = 1            
	  , iniciodia    = 0    
	--<<BAJADA OPCIONES INICIO DE DIA AUTOMATICO	
  
   SELECT  0  
   SET NOCOUNT OFF  
END  
  
GO

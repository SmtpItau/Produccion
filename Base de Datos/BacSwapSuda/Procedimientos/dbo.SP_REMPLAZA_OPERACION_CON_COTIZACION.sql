USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REMPLAZA_OPERACION_CON_COTIZACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REMPLAZA_OPERACION_CON_COTIZACION]  
   (   @iNumero_Operacion   NUMERIC(9)  
   ,   @iNumero_Cotizacion  NUMERIC(9)  
   ,   @iSwFlujosActivos    INTEGER   = 1 --> Activa el control de consistencia de flujos por pata  
   )  
AS  
BEGIN   
  
   SET NOCOUNT ON  
   DECLARE @dFechaProc    DATETIME
   SELECT @dFechaProc  =  fechaproc FROM SWAPGENERAL   
  
  
   -->    Control de Existencia de la Operación  
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion)  
   BEGIN  
      SELECT -1, 'Operación No se encuentra en Cartera'  
   END  
  
   -->    Control de Existencia de la Cotización  
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion)  
   BEGIN  
      SELECT -1, 'Cotización No se encuentra en Ingresada'  
   END  
  
   -->    Control de Existencia de la Operación como Operación [Si es Cotización, Avisa]  
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion AND estado = 'C')  
   BEGIN  
      SELECT -1, 'Número de operacion correspone a una cotizacion.'  
      RETURN -1  
   END  
  
   -->    Control de Existencia de la Cotización como Cotización [Si NO es Cotización, Avisa]  
   IF NOT EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion AND estado = 'C')  
   BEGIN  
      SELECT -1, 'Número de cotizacion correspone a una operación.'  
      RETURN -1  
   END  
  
   -->    Siempre y cuando se mande la activación, validara consistencia en cantidad de flujos por Pata  
   DECLARE @xCantFlujosOp NUMERIC(9)  
   DECLARE @xCantFlujosCo NUMERIC(9)  
  
   IF @iSwFlujosActivos = 1  
   BEGIN  
      -->   Valida primero los flujos activos de la operacion v/s la cotizacion  
      SET @xCantFlujosOp = (SELECT COUNT(1) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion  and tipo_flujo = 1)  
      SET @xCantFlujosCo = (SELECT COUNT(1) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion and tipo_flujo = 1)  
  
      IF @xCantFlujosOp <> @xCantFlujosCo  
      BEGIN        
         SELECT -1, 'Cantidad de flujos Activos en Operación v/s Cotización no son iguales'  
         RETURN -1  
      END  
  
      -->   Chequea los flujos pasivos de la operacion v/s la cotizacion  
      SET @xCantFlujosOp = (SELECT COUNT(1) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion  and tipo_flujo = 2)  
      SET @xCantFlujosCo = (SELECT COUNT(1) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion and tipo_flujo = 2)  
  
      IF @xCantFlujosOp <> @xCantFlujosCo  
      BEGIN        
         SELECT -1, 'Cantidad de flujos Pasivos en Operación v/s Cotización no son iguales'  
         RETURN -1  
      END  
   END  
  
  
   --> ----------------------------------------------------------------------------  
   -->   T O D O    O K ...   C O N T I N U A    C O N    E L   R E E M P L A Z O  
   --> ----------------------------------------------------------------------------  
   --***************** CARTERA LOG DE SWAP *****************--

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
		,  bEarlyTermination
		,  FechaInicio
		,  Periodicidad
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
		 , @dFechaProc   -- fecha_modifica 
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
  ,ReferenciaUSDCLP 
  ,ReferenciaMEXUSD
  ,FechaUSDCLP
  ,FechaMEXUSD 
		--> PRD 12712 - 21707
		, InterNocIni
		, InterNocFin  

		 FROM CARTERA  
		 WHERE numero_operacion = @iNumero_Operacion 
		   and estado <> 'C'
   --***************** CARTERA LOG DE SWAP *****************--
  
  
   --***************** CARTER VIGENTE DE SWAP *****************--  
  
   -->     Obtiene la fecha de cierre de la operación Original  
   DECLARE @dFechaCierre    DATETIME  
       SET @dFechaCierre    = (SELECT TOP 1 fecha_cierre  FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion )  
  
   -->     Obtiene los menores flujos, Activo y Pasivo de la Operacion Original  
   DECLARE @iMenorFlujoAct  NUMERIC(9)  
       SET @iMenorFlujoAct  = (SELECT MIN( numero_flujo ) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion  AND tipo_flujo = 1)  
   DECLARE @iMenorFlujoPas  NUMERIC(9)  
       SET @iMenorFlujoPas  = (SELECT MIN( numero_flujo ) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Operacion  AND tipo_flujo = 2)  
  
   -->     Obtiene los menores flujos, Activo y Pasivo de la Operacion Cotizacion  
   DECLARE @xFlujoActMin    NUMERIC(9)  
       SET @xFlujoActMin    = (SELECT MIN( numero_flujo ) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion AND tipo_flujo = 1)  
   DECLARE @xFlujoPasMin    NUMERIC(9)  
       SET @xFlujoPasMin    = (SELECT MIN( numero_flujo ) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @iNumero_Cotizacion AND tipo_flujo = 2)  
  
   -->     Actualiza la numeración de cada uno de lo flujos, equiparando la numeracion con respecto a la cartera vigente.  
       SET @iMenorFlujoAct  = @iMenorFlujoAct - @xFlujoActMin  
       SET @iMenorFlujoPas  = @iMenorFlujoPas - @xFlujoPasMin  
  
   -->     Actualiza la numeracion de los Flujos Activos  
   UPDATE BacSwapSuda.dbo.CARTERA  
      SET numero_flujo     = @iMenorFlujoAct + numero_flujo  
    WHERE numero_operacion = @iNumero_Cotizacion   
      AND tipo_flujo       = 1  
  
   -->     Actualiza la numeracion de los Flujos Pasivos  
   UPDATE BacSwapSuda.dbo.CARTERA  
      SET numero_flujo     = @iMenorFlujoPas + numero_flujo  
    WHERE numero_operacion = @iNumero_Cotizacion   
      AND tipo_flujo       = 2  
  
   -->    Borra la Operacion de la Cartera   
   DELETE FROM BacSwapSuda.dbo.CARTERA   
         WHERE numero_operacion = @iNumero_Operacion  
  
   -->    Cambia la Cotizacion a Operacion  
   UPDATE BacSwapSuda.dbo.CARTERA   
      SET numero_operacion   = @iNumero_Operacion  
      ,   fecha_cierre       = @dFechaCierre  
      ,   estado             = ''  
      ,   Estado_oper_lineas = ''  
    WHERE numero_operacion   = @iNumero_Cotizacion  
  
  
  
   --***************** MOVIMIENTOS *****************--  
  
   -->    lee los movimientos diarios e historicos  
   SELECT * INTO #TMP_MOVIMIENTO_SWAP FROM BacSwapSuda.dbo.MOVDIARIO    WHERE numero_operacion = @iNumero_Cotizacion  
   UNION  
   SELECT *                           FROM BacSwapSuda.dbo.MOVHISTORICO WHERE numero_operacion = @iNumero_Cotizacion  
  
   -->    Actualiza la numeracion de los Flujos Activos  
   UPDATE #TMP_MOVIMIENTO_SWAP  
      SET numero_flujo     = @iMenorFlujoAct + numero_flujo  
    WHERE numero_operacion = @iNumero_Cotizacion   
      AND tipo_flujo       = 1  
  
   -->    Actualiza la numeracion de los Flujos Pasivos  
   UPDATE #TMP_MOVIMIENTO_SWAP  
      SET numero_flujo     = @iMenorFlujoPas + numero_flujo  
    WHERE numero_operacion = @iNumero_Cotizacion   
      AND tipo_flujo       = 2  
  
   -->    Cambia la Cotizacion a Operacion  
   UPDATE #TMP_MOVIMIENTO_SWAP  
      SET numero_operacion   = @iNumero_Operacion  
        , fecha_cierre       = @dFechaCierre  
        , estado             = ''  
        , Estado_oper_lineas = ''  
    WHERE numero_operacion   = @iNumero_Cotizacion  
  
   -->    Borra el Movimiento para Cotizacion  
   DELETE FROM BacSwapSuda.dbo.MOVDIARIO  
         WHERE numero_operacion = @iNumero_Cotizacion  
  
   -->    Borra el Movimiento historicos para Cotizacion (por si se ingreso antes de hoy)  
   DELETE FROM BacSwapSuda.dbo.MOVHISTORICO   
         WHERE numero_operacion = @iNumero_Cotizacion  
  
   -->    Determina donde hacer el reemplaz del movimiento  
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.MOVDIARIO WHERE numero_operacion = @iNumero_Operacion )  
   BEGIN  
      -->    Elimina el moviminto para la operacion   
      DELETE FROM BacSwapSuda.dbo.MOVDIARIO WHERE numero_operacion = @iNumero_Operacion  
  
      -->    Inserta el registro cotizacion como operacion a la tabla de movimientos diarios  
      INSERT INTO BacSwapSuda.dbo.MOVDIARIO SELECT * FROM #TMP_MOVIMIENTO_SWAP  
   END ELSE  
   BEGIN  
      -->    Elimina el moviminto para la operacion   
      DELETE FROM BacSwapSuda.dbo.MOVHISTORICO WHERE numero_operacion = @iNumero_Operacion  
  
      -->    Inserta el registro cotizacion como operacion a la tabla de movimientos historicos  
      INSERT INTO BacSwapSuda.dbo.MOVHISTORICO SELECT * FROM #TMP_MOVIMIENTO_SWAP  
   END  
  
   -->    reestablece la variabla con el valor de acurdo al menor flujo activo de la cartera  
   SET @iMenorFlujoAct = @iMenorFlujoAct + @xFlujoActMin  
  
   DECLARE @iMensaje   VARCHAR(100)  
  
   -->    genera un recalculo de flujos de interes, para la operación.  
   EXECUTE SP_REHACEFLUJOS_PAPA @iNumero_Operacion  
                              , @iMensaje  
                              , @iMenorFlujoAct  
                              , @dFechaCierre  
  
   -->    Solo como muestra, retona los registros de Operacion y Cotización...   
      --> 1. No debiese estar la cotizacion   
      --> 2. La operacion debe haber mantenido el numero de contrato y la fecha de cierre  
   SELECT * FROM BacSwapSuda.dbo.CARTERA with(nolock) WHERE numero_operacion = @iNumero_Operacion  
   UNION  
   SELECT * FROM BacSwapSuda.dbo.CARTERA with(nolock) WHERE numero_operacion = @iNumero_Cotizacion  
  
END  
  


GO

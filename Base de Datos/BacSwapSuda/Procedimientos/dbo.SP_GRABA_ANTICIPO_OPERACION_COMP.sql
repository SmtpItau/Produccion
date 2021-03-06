USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ANTICIPO_OPERACION_COMP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ANTICIPO_OPERACION_COMP]
       (
        @NumeroOperacion        NUMERIC(05),
        @FechaAnticipo          DATETIME,
        @AmortizacionRecibe     NUMERIC(19,4), 
        @AmortizacionEntrego    NUMERIC(19,4),
        @FechaValorizacion      DATETIME,
        @InteresDevRecibe       FLOAT,
        @InteresDevEntrego      FLOAT,
        @MonedaValorizacion     NUMERIC(5),  
        @ValorMcdoActivoMdaVal  NUMERIC(18,6),
        @DevengoRecMdaVal       NUMERIC(18,6),   
        @ValorMcdoPasivoMdaVal  NUMERIC(18,6),
        @DevengoEntMdaVal       NUMERIC(18,6),
        @PrincipalMdaVal        NUMERIC(18,6),--
        @DevengoNetoMdaVal      NUMERIC(18,6),
        @ValorMercadoMdaVal     NUMERIC(18,6),
        @PorcentajeMargen       NUMERIC(18,6),--
        @MontoMargen            NUMERIC(18,6),
        @MontoMargenCLP         NUMERIC(18,6),
        @MontoLiquidaMoneda     FLOAT,
        @CodFPagoLiquidacion    INTEGER
       )
AS
BEGIN

    SET NOCOUNT ON

    /*========================================================================================================================*/
    /*========================================================================================================================*/
    DECLARE @FechaProceso       DATETIME
    DECLARE @FechaAnterior      DATETIME
    DECLARE @CierreMesa         INTEGER   

    /*========================================================================================================================*/
    /* Pierna Recibimos                                                                                                       */
    /*========================================================================================================================*/
    DECLARE @RecFlujo           INTEGER
    DECLARE @RecMoneda          INTEGER
    DECLARE @RecSaldo           NUMERIC(19,4)
    DECLARE @RecAmortizaFlujo   NUMERIC(19,4)
    DECLARE @RecCapital         NUMERIC(19,4)
    DECLARE @RecSaldoFlujo      NUMERIC(19,4)
    DECLARE @RecDecimal         INTEGER       

    /*========================================================================================================================*/
    /* Pierna Entregamos                                                                                                      */
    /*========================================================================================================================*/
    DECLARE @EntFlujo           INTEGER
    DECLARE @EntMoneda          INTEGER
    DECLARE @EntSaldo           NUMERIC(19,4)
    DECLARE @EntAmortizaFlujo   NUMERIC(19,4)
    DECLARE @EntCapital         NUMERIC(19,4)
    DECLARE @EntSaldoFlujo      NUMERIC(19,4)
    DECLARE @EntDecimal         INTEGER   

    /*========================================================================================================================*/
    /*========================================================================================================================*/
    SELECT @FechaAnterior = fechaant,
           @FechaProceso  = fechaproc,
           @CierreMesa    = cierreMesa
      FROM SWAPGENERAL    

    /*========================================================================================================================*/
    /*========================================================================================================================*/
    IF @CierreMesa = 1
    BEGIN
        SELECT -1, 'Error: Cierre de Mesa realizado'
        SET NOCOUNT OFF
        RETURN

    END
        
    /*========================================================================================================================*/
    /*========================================================================================================================*/
    BEGIN TRANSACTION

    /*========================================================================================================================*/
    /* Rescata datos las piernas y flujos de la operación de SWAP.                                                            */
    /*========================================================================================================================*/
    SELECT *
      INTO #tmpCartera
      FROM dbo.CARTERA
     WHERE Numero_Operacion = @NumeroOperacion

    /*========================================================================================================================*/
    /* Rescata valores del primer flujo activo de la pierna recibimos                                                         */
    /*========================================================================================================================*/
    SELECT @RecFlujo             = numero_flujo,
           @RecMoneda            = compra_moneda,
           @RecSaldo             = compra_saldo,
           @RecAmortizaFlujo     = compra_amortiza,
           @RecSaldoFlujo        = compra_saldo + compra_amortiza
      FROM #tmpCartera
     WHERE tipo_flujo            = 1
       AND Estado_Flujo          = 1

    /*========================================================================================================================*/
    /* Rescata valores del primer flujo activo de la pierna entregamos                                                        */
    /*========================================================================================================================*/
    SELECT @EntFlujo             = numero_flujo,
           @EntMoneda            = venta_moneda,
           @EntSaldo             = venta_saldo,
           @EntAmortizaFlujo     = venta_amortiza,
           @EntSaldoFlujo        = venta_saldo + venta_amortiza
      FROM #tmpCartera
     WHERE tipo_flujo            = 2
       AND Estado_Flujo          = 1

    /*========================================================================================================================*/
    /* Rescata la cantidad de decimales que se debe aplicar a la pierna recibimos                                             */
    /*========================================================================================================================*/
    SELECT @RecDecimal = mndecimal
      FROM view_moneda
     WHERE mncodmon          = @RecMoneda

    /*========================================================================================================================*/
    /* Rescata la cantidad de decimales que se debe aplicar a la pierna entregamos                                            */
    /*========================================================================================================================*/
    SELECT @EntDecimal      = mndecimal
      FROM view_moneda
     WHERE mncodmon         = @EntMoneda

    IF @AmortizacionRecibe = @RecSaldoFlujo
    BEGIN
        /*====================================================================================================================*/
        /* Anticipo TOTAL                                                                                                     */
        /*====================================================================================================================*/
        DELETE #tmpCartera
         WHERE Tipo_Flujo   = 1
           AND numero_flujo > @RecFlujo

        DELETE #tmpCartera
         WHERE Tipo_Flujo   = 2
           AND numero_flujo > @EntFlujo 

        UPDATE #tmpCartera
           SET fecha_vence_flujo               = @FechaAnticipo,
               estado                          = 'N',
               FechaLiquidacion                = @FechaAnticipo,
               recibimos_documento             = @CodFPagoLiquidacion,
               pagamos_documento               = @CodFPagoLiquidacion,                
               modalidad_pago		       = 'C'		-- 20090211 - Pendiente implemetación Entrega Física Visual Basic 

        -- Actualizacion de Flujos Vigentes Recibimos
        UPDATE #tmpCartera
           SET compra_amortiza                 = compra_capital,
               compra_saldo                    = 0,
               compra_interes                  = compra_interes - @InteresDevRecibe,
               Moneda_Valorizacion             = @MonedaValorizacion,
               Valor_Mercado_Activo_Mda_Val    = @ValorMcDoActivoMdaVal,
               Devengo_Recibido_Mda_Val        = @DevengoRecMdaVal,
               Principal_Mda_Val               = @PrincipalMdaVal,
               Devengo_Neto_Mda_Val            = @DevengoNetoMdaVal,
               Valor_Mercado_Mda_Val           = @ValorMercadoMdaVal,
               Porcentaje_Margen               = @PorcentajeMargen,
               Monto_Margen                    = @MontoMargen,
               Monto_Margen_CLP                = @MontoMargenCLP,
               Recibimos_Monto                 = @MontoLiquidaMoneda,
               Fecha_Termino                   = @FechaAnticipo,   -- MAP 20081110 Correccion de Anticipos
               recibimos_moneda                = @MonedaValorizacion
         WHERE Tipo_Flujo                      = 1
           AND numero_flujo                    = @RecFlujo 

        -- Actualizacion de Flujos Vigentes Entregamos
        UPDATE #tmpCartera
           SET venta_amortiza                  = venta_capital,
               venta_saldo                     = 0,
               venta_interes                   = venta_interes - @InteresDevEntrego,
               Valor_Mercado_Pasivo_Mda_Val    = @ValorMcdoPasivoMdaVal,
               Devengo_Pagar_Mda_Val           = @DevengoEntMdaVal,
               Principal_Mda_Val               = @PrincipalMdaVal,
               Devengo_Neto_Mda_Val            = @DevengoNetoMdaVal,
               Valor_Mercado_Mda_Val           = @ValorMercadoMdaVal,
               Porcentaje_Margen               = @PorcentajeMargen,
               Monto_Margen                    = @MontoMargen,
               Monto_Margen_CLP                = @MontoMargenCLP,
               Fecha_Termino                   = @FechaAnticipo,   -- MAP 20081110 Correccion de Anticipos
               pagamos_moneda                  = @MonedaValorizacion
         WHERE Tipo_Flujo                      = 2
           AND numero_flujo                    = @EntFlujo 

    END ELSE
    BEGIN
        /*====================================================================================================================*/
        /* Anticipo PARCIAL                                                                                                   */
        /*====================================================================================================================*/
        SELECT *
          INTO #tmpNewFlow
          FROM #tmpCartera
         WHERE (Tipo_Flujo  = 1
           AND numero_flujo = @RecFlujo)
            OR (Tipo_Flujo  = 2
           AND numero_flujo = @EntFlujo)

        UPDATE #tmpNewFlow
           SET fecha_vence_flujo   = @FechaAnticipo,
               estado              = 'N',
               FechaLiquidacion    = @FechaAnticipo,
	       modalidad_pago      = 'C'		-- 20090211 - Pendiente implemetación Entrega Física Visual Basic  	

        SELECT @RecCapital         = compra_capital
          FROM #tmpNewFlow
         WHERE Tipo_Flujo          = 1

        SELECT @EntCapital         = venta_capital
          FROM #tmpNewFlow
         WHERE Tipo_Flujo          = 2

        UPDATE #tmpCartera
           SET compra_saldo        = compra_saldo   * (1.0 - (@AmortizacionRecibe / @RecSaldoFlujo) ),
               compra_interes      = compra_interes * (1.0 - (@AmortizacionRecibe / @RecSaldoFlujo) ) *
                                     CASE WHEN numero_flujo = @RecFlujo
                                          THEN CAST( DATEDIFF( DAY, @FechaAnticipo    , fecha_vence_flujo ) AS FLOAT ) / 
                                               CAST( DATEDIFF( DAY, fecha_inicio_flujo, fecha_vence_flujo ) AS FLOAT )
                                          ELSE 1.0
                                     END,
               compra_amortiza     = compra_amortiza * (1.0 - (@AmortizacionRecibe / @RecSaldoFlujo) ),
               fecha_inicio_flujo  = CASE WHEN numero_flujo = @RecFlujo THEN @FechaValorizacion ELSE fecha_inicio_flujo END,
               numero_flujo        = numero_flujo + 1,
               Estado_Flujo        = 0
         WHERE Tipo_Flujo          = 1
           AND numero_flujo       >= @RecFlujo

        UPDATE #tmpCartera
           SET venta_saldo         = venta_saldo   * (1.0 - (@AmortizacionEntrego / @EntSaldoFlujo) ),
               venta_interes       = venta_interes * (1.0 - (@AmortizacionEntrego / @EntSaldoFlujo) ) *
                                     CASE WHEN numero_flujo = @EntFlujo 
                                          THEN CAST( DATEDIFF( DAY, @FechaAnticipo,     fecha_vence_flujo ) AS FLOAT ) /
                                               CAST( DATEDIFF( DAY, fecha_inicio_flujo, fecha_vence_flujo ) AS FLOAT )
                                          ELSE 1.0
                                     END,
               venta_amortiza      = venta_amortiza * (1.0 - (@AmortizacionEntrego / @EntSaldoFlujo) ),
               fecha_inicio_flujo  = CASE WHEN numero_flujo = @EntFlujo THEN @FechaValorizacion ELSE fecha_inicio_flujo END,
               numero_flujo        = numero_flujo + 1,
               Estado_Flujo        = 0
         WHERE Tipo_Flujo          = 2
           AND numero_flujo       >= @EntFlujo

        -- Actualizacion de Flujos Vigentes Recibimos
        UPDATE #tmpNewFlow
           SET compra_amortiza                  = @AmortizacionRecibe,
               compra_saldo                     = (compra_saldo + compra_amortiza) - @AmortizacionRecibe, --compra_saldo - @AmortizacionRecibe,
               compra_interes                   = @InteresDevRecibe,                                      --compra_interes - @InteresDevRecibe,
               Moneda_Valorizacion              = @MonedaValorizacion,
               Valor_Mercado_Activo_Mda_Val     = @ValorMcDoActivoMdaVal,
               Devengo_Recibido_Mda_Val         = @DevengoRecMdaVal,
               Principal_Mda_Val                = @PrincipalMdaVal,
               Devengo_Neto_Mda_Val             = @DevengoNetoMdaVal,
               Valor_Mercado_Mda_Val            = @ValorMercadoMdaVal,
               Porcentaje_Margen                = @PorcentajeMargen,
               Monto_Margen                     = @MontoMargen,
               Monto_Margen_CLP                 = @MontoMargenCLP,
               Recibimos_Monto                  = @MontoLiquidaMoneda,
               recibimos_documento              = @CodFPagoLiquidacion,
               recibimos_moneda                 = @MonedaValorizacion
         WHERE Tipo_Flujo                       = 1
           AND numero_flujo                     = @RecFlujo 

        -- Actualizacion de Flujos Vigentes Entregamos
        UPDATE #tmpNewFlow
           SET venta_amortiza                  = @AmortizacionEntrego,
               venta_saldo                     = (venta_saldo + venta_amortiza) - @AmortizacionEntrego, -- venta_saldo - @AmortizacionEntrego,
               venta_interes                   = @InteresDevEntrego,                                    -- venta_interes - @InteresDevEntrego,
               Valor_Mercado_Pasivo_Mda_Val    = @ValorMcdoPasivoMdaVal,
               Devengo_Pagar_Mda_Val           = @DevengoEntMdaVal,
               Principal_Mda_Val               = @PrincipalMdaVal,
               Devengo_Neto_Mda_Val            = @DevengoNetoMdaVal,
               Valor_Mercado_Mda_Val           = @ValorMercadoMdaVal,
               Porcentaje_Margen               = @PorcentajeMargen,
               Monto_Margen                    = @MontoMargen,
               Monto_Margen_CLP                = @MontoMargenCLP,
               pagamos_documento               = @CodFPagoLiquidacion,
               pagamos_moneda                  = @MonedaValorizacion
         WHERE Tipo_Flujo                      = 2
           AND numero_flujo                    = @EntFlujo 

        INSERT INTO #tmpCartera
               SELECT *
                 FROM #tmpNewFlow

    END

    DELETE Cartera WHERE Numero_Operacion = @NumeroOperacion

    INSERT INTO Cartera 
           SELECT * FROM #tmpCartera

    COMMIT TRANSACTION

  SELECT @NumeroOperacion, 'OK'

    SET NOCOUNT OFF

END


GO

USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACION_DATOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACION_DATOS]
       (
        @NumeroOperacion        NUMERIC(05)
       )
AS
BEGIN

    SET NOCOUNT ON 

    DECLARE @FechaProceso       DATETIME 
    DECLARE @ValorDO            FLOAT

    -- VARIABLES DE LA PIERNA RECIBIMOS
    DECLARE @RecNumeroCupon     INTEGER
    DECLARE @RecCodMoneda       INTEGER
    DECLARE @RecCodigoBase      INTEGER
    DECLARE @RecCodValMoneda    INTEGER
    DECLARE @RecSaldo           NUMERIC(19, 4)
    DECLARE @RecCodigoTasa      INTEGER
    DECLARE @RecTasa            FLOAT
    DECLARE @RecFecInicioFlujo  CHAR(10)
    DECLARE @RecFecVctoFlujo    CHAR(10)
    DECLARE @RecInteres         NUMERIC(19, 4)
    DECLARE @RecFijacionTasa    CHAR(10)
    DECLARE @RecFechaLiquid     CHAR(10)
    DECLARE @RecAmortizacion    NUMERIC(19, 4)
    DECLARE @RecSaldoFlujo      NUMERIC(19, 4)
    DECLARE @RecModalidadPago   CHAR(01)
    DECLARE @RecNemoMda         VARCHAR(08)
    DECLARE @RecDecimales       INTEGER
    DECLARE @RecValMoneda       FLOAT
    DECLARE @RecTipoTasa        VARCHAR(50)
    DECLARE @RecDias            VARCHAR(25)

    -- VARIABLES DE LA PIERNA ENTREGAMOS
    DECLARE @EntNumeroCupon     INTEGER
    DECLARE @EntCodMoneda       INTEGER
    DECLARE @EntCodigoBase      INTEGER
    DECLARE @EntCodValMoneda    INTEGER
    DECLARE @EntSaldo           NUMERIC(19, 4)
    DECLARE @EntCodigoTasa      INTEGER
    DECLARE @EntTasa            FLOAT
    DECLARE @EntFecInicioFlujo  CHAR(10)
    DECLARE @EntFecVctoFlujo    CHAR(10)
    DECLARE @EntInteres         NUMERIC(19, 4)
    DECLARE @EntFijacionTasa    CHAR(10)
    DECLARE @EntFechaLiquid     CHAR(10)
    DECLARE @EntAmortizacion    NUMERIC(19, 4)
    DECLARE @EntSaldoFlujo      NUMERIC(19, 4)
    DECLARE @EntModalidadPago   CHAR(01)
    DECLARE @EntNemoMda         VARCHAR(08)
    DECLARE @EntDecimales       INTEGER
    DECLARE @EntValMoneda       FLOAT
    DECLARE @EntTipoTasa        VARCHAR(50)
    DECLARE @EntDias            VARCHAR(25)
    DECLARE @Madurez            CHAR(10)

    -- VARIABLES DE LA LIQUIDACION
    DECLARE @MdaLiquidacion     INTEGER
    DECLARE @MdaValorizacion    INTEGER


    -- Fecha de Proceso
    SELECT @FechaProceso      = fechaproc
      FROM SwapGeneral

    -- Dólar Observado
    SELECT @ValorDO      = vmvalor
      FROM View_Valor_Moneda
     WHERE vmcodigo      = 994
       AND vmFecha       = @FechaProceso

    -- Pierna Recibimos
    SELECT @RecNumeroCupon    = numero_Flujo,
           @RecCodMoneda      = Compra_Moneda,
           @RecCodigoBase     = Compra_Base,
           @RecCodValMoneda   = (CASE Compra_Moneda WHEN 13 THEN 994 ELSE Compra_Moneda END),
           @RecSaldo          = ISNULL( compra_saldo, 0 ) + ISNULL( compra_amortiza, 0 ),
           @RecCodigoTasa     = compra_codigo_tasa,
           @RecTasa           = compra_valor_tasa,
           @RecFecInicioFlujo = CONVERT( CHAR(10), fecha_inicio_flujo, 103 ),
           @RecFecVctoFlujo   = CONVERT( CHAR(10), fecha_vence_flujo, 103 ),
           @RecInteres        = Compra_Interes,
           @RecFijacionTasa   = CONVERT( CHAR(10), fecha_fijacion_tasa, 103 ),
           @RecFechaLiquid    = CONVERT( CHAR(10), fechaliquidacion, 103 ),
           @RecAmortizacion   = Compra_amortiza,
           @RecSaldoFlujo     = Compra_saldo,
           @RecModalidadPago  = modalidad_pago
      FROM dbo.CARTERA
     WHERE numero_operacion   = @NumeroOperacion
       AND estado_Flujo       = 1
       AND tipo_flujo         = 1           

    SELECT @RecNemoMda        = mnnemo,
           @RecDecimales      = mndecimal
      FROM dbo.VIEW_MONEDA
     WHERE mncodmon           = @RecCodMoneda

    IF @RecCodValMoneda = 999
    BEGIN
        SET @RecValMoneda = 1

    END ELSE
    BEGIN
        SELECT @RecValMoneda      = Vmvalor
          FROM View_Valor_Moneda             
         WHERE vmcodigo           = @RecCodValMoneda
           AND vmfecha            = @FechaProceso

    END

    SELECT @RecTipoTasa       = tbGlosa
      FROM dbo.VIEW_TASAS
     WHERE tbCodigo1          = @RecCodigoTasa

    SELECT @RecDias           = glosa
      FROM BASE
     WHERE Codigo             = @RecCodigoBase

    SET @RecTipoTasa = ISNULL( @RecTipoTasa, CAST( @RecCodigoTasa AS VARCHAR(10) ) )
    SET @RecDias     = ISNULL( @RecDias, CAST( @RecCodigoBase AS VARCHAR(10) ) )

    -- Pierna Entregamos
    SELECT @EntNumeroCupon    = numero_Flujo,
           @EntCodMoneda      = Venta_Moneda,
           @EntCodigoBase     = Venta_Base,
           @EntCodValMoneda   = (CASE Venta_Moneda WHEN 13 THEN 994 ELSE Venta_Moneda END),
           @EntSaldo          = ISNULL( Venta_saldo, 0 ) + ISNULL( Venta_amortiza, 0 ),
           @EntCodigoTasa     = compra_codigo_tasa,
           @EntTasa           = Venta_valor_tasa,
           @EntFecInicioFlujo = CONVERT( CHAR(10), fecha_inicio_flujo, 103 ),
           @EntFecVctoFlujo   = CONVERT( CHAR(10), fecha_vence_flujo, 103 ),
           @EntInteres        = venta_interes,
           @Madurez           = Convert( CHAR(10), Madurez, 103 ),
           @EntFijacionTasa   = CONVERT( CHAR(10), fecha_fijacion_tasa, 103 ),
           @EntFechaLiquid    = CONVERT( CHAR(10), fechaliquidacion, 103 ),
           @EntAmortizacion   = venta_amortiza,
           @EntSaldoFlujo     = venta_saldo,
           @EntModalidadPago  = modalidad_pago
      FROM dbo.CARTERA
     WHERE numero_operacion   = @NumeroOperacion
       AND tipo_flujo         = 2
       AND estado_Flujo       = 1         

    SELECT @EntNemoMda        = mnnemo,
           @EntDecimales      = mndecimal
      FROM dbo.VIEW_MONEDA
     WHERE mncodmon           = @EntCodMoneda

    IF @EntCodValMoneda = 999
    BEGIN
        SET @EntValMoneda = 1

    END ELSE
    BEGIN
        SELECT @EntValMoneda = Vmvalor
          FROM View_Valor_Moneda             
         WHERE vmcodigo      = @EntCodValMoneda
           AND vmfecha       = @FechaProceso

    END

    SELECT @EntTipoTasa       = tbGlosa
      FROM dbo.VIEW_TASAS
     WHERE tbCodigo1          = @EntCodigoTasa

    SELECT @EntDias           = glosa
      FROM BASE
     WHERE Codigo             = @EntCodigoBase

    SET @EntTipoTasa = ISNULL( @EntTipoTasa, CAST( @EntCodigoTasa AS VARCHAR(10) ) )
    SET @EntDias     = ISNULL( @EntDias, CAST( @EntCodigoBase AS VARCHAR(10) ) )

    -- Valores de Liquidacion
    SET @MdaLiquidacion       = @EntCodMoneda
    SET @MdaValorizacion      = @EntCodMoneda

    IF @MdaLiquidacion = 998
    BEGIN
        SET @MdaLiquidacion = 999

    END


    SELECT 'FechaProceso'      = @FechaProceso,        -- 01
           'ValorDO'           = @ValorDO,             -- 02
           'RecNumeroCupon'    = @RecNumeroCupon,      -- 03
           'RecCodMoneda'      = @RecCodMoneda,        -- 04
           'RecCodigoBase'     = @RecCodigoBase,       -- 05
           'RecCodValMoneda'   = @RecCodValMoneda,     -- 06
           'RecSaldo'          = @RecSaldo,            -- 07
           'RecCodigoTasa'     = @RecCodigoTasa,       -- 08 --
           'RecTasa'           = @RecTasa,             -- 09
           'RecFecInicioFlujo' = @RecFecInicioFlujo,   -- 10
           'RecFecVctoFlujo'   = @RecFecVctoFlujo,     -- 11
           'RecInteres'        = @RecInteres,          -- 12
           'RecFijacionTasa'   = @RecFijacionTasa,     -- 13
           'RecFechaLiquid'    = @RecFechaLiquid,      -- 14
           'RecAmortizacion'   = @RecAmortizacion,     -- 15
           'RecSaldoFlujo'     = @RecSaldoFlujo,       -- 16
           'RecModalidadPago'  = @RecModalidadPago,    -- 17
           'RecNemoMda'        = @RecNemoMda,          -- 18
           'RecDecimales'      = @RecDecimales,        -- 19
           'RecValMoneda'      = @RecValMoneda,        -- 20
           'RecTipoTasa'       = @RecTipoTasa,         -- 21
           'RecDias'           = @RecDias,             -- 22
           'EntNumeroCupon'    = @EntNumeroCupon,      -- 23
           'EntCodMoneda'      = @EntCodMoneda,        -- 24
           'EntCodigoBase'     = @EntCodigoBase,       -- 25
           'EntCodValMoneda'   = @EntCodValMoneda,     -- 26
           'EntSaldo'          = @EntSaldo,            -- 27
           'EntCodigoTasa'     = @EntCodigoTasa,       -- 28 --
           'EntTasa'           = @EntTasa,             -- 29
           'EntFecInicioFlujo' = @EntFecInicioFlujo,   -- 30
           'EntFecVctoFlujo'   = @EntFecVctoFlujo,     -- 31
           'EntInteres'        = @EntInteres,          -- 32
           'EntFijacionTasa'   = @EntFijacionTasa,     -- 33
           'EntFechaLiquid'    = @EntFechaLiquid,      -- 34
           'EntAmortizacion'   = @EntAmortizacion,     -- 35
           'EntSaldoFlujo'     = @EntSaldoFlujo,       -- 36
           'EntModalidadPago'  = @EntModalidadPago,    -- 37
           'EntNemoMda'        = @EntNemoMda,          -- 38
           'EntDecimales'      = @EntDecimales,        -- 39
           'EntValMoneda'      = @EntValMoneda,        -- 40
           'EntTipoTasa'       = @EntTipoTasa,         -- 41
           'EntDias'           = @EntDias,             -- 42
           'Madurez'           = @Madurez,             -- 43
           'MdaLiquidacion'    = @MdaLiquidacion,      -- 44
           'MdaValorizacion'   = @MdaValorizacion      -- 45

    SET NOCOUNT OFF

END
GO

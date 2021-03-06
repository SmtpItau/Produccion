USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_NEW_UNWIND]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  PROCEDURE [dbo].[SP_INFORME_NEW_UNWIND]
   (   @nContrato            NUMERIC(9)
   ,   @nPorcNominal         FLOAT
   ,   @nValorAnticipo       FLOAT
   ,   @nValorAnticipoTran   FLOAT
   ,   @nResultadoVenta      FLOAT
   ,   @nResultadoTradin     FLOAT
   ,   @iPagamosMoneda       INTEGER
   ,   @iPagamosDocumento    INTEGER
   ,   @cUsuario             VARCHAR(15)
   ,   @nValParTc            FLOAT = 0
   ,   @MonedaAnticipo       CHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON

   -->     1.0 Lee la fecha de hoy para el anticipo
   DECLARE @dFechaHoy         DATETIME
       SET @dFechaHoy         = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

   -->     2.0 Lee la fecha anterior de proceso por el TC Contable
   DECLARE @dFechaAyer        DATETIME
       SET @dFechaAyer        = (SELECT fechaant FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

   -->     3.0 Lee el TC Contable del Dolar
   DECLARE @nTCCambio         FLOAT
       SET @nTCCambio         = (SELECT tipo_cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) 
                                                   WHERE Fecha = @dFechaAyer and codigo_moneda = 994)

   -->     4.0 Define el Porcentaje para el Saldo en Cartera
   DECLARE @PorcentajeSaldo   FLOAT
       SET @PorcentajeSaldo   = (100.0 - @nPorcNominal)

   DECLARE @dFechaProceso     CHAR(10)
       SET @dFechaProceso     = CONVERT(CHAR(10), @dFechaHoy, 103)

   DECLARE @dFechaEmicion     CHAR(10)
       SET @dFechaEmicion     = CONVERT(CHAR(10), GETDATE(), 103)

   DECLARE @dHoraEmision      CHAR(10)
       SET @dHoraEmision      = CONVERT(CHAR(10), GETDATE(), 108)

   CREATE TABLE #MiTablaContrato
      (   FechaAnticipo       CHAR(10)
      ,   NumContrato         NUMERIC(10)
      ,   Producto            VARCHAR(40)
      ,   RutCliente          NUMERIC(10)
      ,   CodCliente          INTEGER
      ,   NomCliente          VARCHAR(100)
      ,   dvCliente           CHAR(1)
      ,   Modalidad           CHAR(25)
      ,   MonedaAvr           CHAR(10)
      ,   AvrContrato         FLOAT
      ,   AnticipoTotal       CHAR(10)
      ,   PorcNominal         FLOAT
      ,   NominalAnticipo     FLOAT
      ,   ValAnticipo         FLOAT
      ,   ValParTC            FLOAT
      ,   ValAnticipoTran     FLOAT
      ,   ResultadoVenta      FLOAT
      ,   ResultadoTradin     FLOAT
      ,   PagamosMoneda       CHAR(50)
      ,   PagamosDocumento    CHAR(50)
      )

   INSERT INTO #MiTablaContrato
   SELECT FechaAnticipo       = @dFechaProceso
      ,   NumContrato         = @nContrato
      ,   Producto            = CASE WHEN car.tipo_swap = 1 THEN 'SWAP DE TASAS'
                                     WHEN car.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
                                     WHEN car.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'
                                     WHEN car.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'
                                END
      ,   RutCliente          = cli.clrut
      ,   CodCliente          = cli.clcodigo
      ,   NomCliente          = SUBSTRING( cli.clnombre, 1, 50)
      ,   dvCliente           = cli.cldv
      ,   Modalidad           = 'COMPENSACION'
      ,   MonedaAvr           = 'CLP'
      ,   AvrContrato         = car.valor_razonableclp
      ,   AnticipoTotal       = CASE WHEN @PorcentajeSaldo = 0.0 THEN 'SI' ELSE 'NO' END
      ,   PorcNominal         = @nPorcNominal
      ,   NominalAnticipo     = ((car.compra_capital * @nPorcNominal) / 100)
      ,   ValAnticipo         = @nValorAnticipo
      ,   ValParTC            = @nValParTc
      ,   ValAnticipoTran     = @nValorAnticipoTran
      ,   ResultadoVenta      = @nResultadoVenta
      ,   ResultadoTradin     = @nResultadoTradin
      ,   PagamosMoneda       = ISNULL(mon.mnnemo, 'NO DEFINIDO')
      ,   PagamosDocumento    = ISNULL(fpa.glosa,  'NO DEFINIDO')
   FROM   BacSwapSuda.dbo.CARTERA car
          LEFT JOIN BacParamSuda.dbo.CLIENTE       cli ON cli.clrut    = car.rut_cliente and cli.clrut = car.rut_cliente
          LEFT JOIN BacParamSuda.dbo.MONEDA        mon ON mon.mncodmon = @iPagamosMoneda
          LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa ON fpa.codigo   = @iPagamosDocumento
   WHERE  car.numero_operacion = @nContrato
   AND    car.numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato AND tipo_flujo = 1)
   AND    car.tipo_flujo       = 1


   CREATE TABLE #TMP_RETORNO
   (   Ubicacion               INTEGER     NOT NULL DEFAULT (0)
   ,   Puntero                 INTEGER     NOT NULL DEFAULT (0)
   ,   Orden                   INTEGER     NOT NULL DEFAULT (0)
   ,   Columna_01              VARCHAR(25) NOT NULL DEFAULT ('')
   ,   Columna_02              VARCHAR(25) NOT NULL DEFAULT ('')
   ,   Columna_03              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Columna_04              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Columna_05              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Columna_06              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Columna_07              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Columna_08              FLOAT       NOT NULL DEFAULT (0.0)
   ,   Activos                 VARCHAR(20) NOT NULL DEFAULT ('')
   ,   Pasivos                 VARCHAR(20) NOT NULL DEFAULT ('')
   ,   NumActivo               FLOAT       NOT NULL DEFAULT (0.0)
   ,   NumPasivo               FLOAT       NOT NULL DEFAULT (0.0)
   ,   NumActivoAnt            FLOAT       NOT NULL DEFAULT (0.0)
   ,   NumPasivoAnt            FLOAT       NOT NULL DEFAULT (0.0)
   ,   NumActivoSal            FLOAT       NOT NULL DEFAULT (0.0)
   ,   NumPasivoSal            FLOAT       NOT NULL DEFAULT (0.0)
   ,   MonedaActiva            INTEGER     NOT NULL DEFAULT (0)
   ,   MonedaPasiva            INTEGER     NOT NULL DEFAULT (0)
   )
   CREATE INDEX #ix_TMP_RETORNO ON #TMP_RETORNO (Ubicacion, Puntero, Orden)

   INSERT INTO #TMP_RETORNO
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 1
      ,   'Columna_01'          = 'MONEDA'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 2
      ,   'Columna_01'          = 'MONTO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 3
      ,   'Columna_01'          = 'FRECUENCIA PAGO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 4
      ,   'Columna_01'          = 'FRECUENCIA CAPITAL'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 5
      ,   'Columna_01'          = 'INDICADOR'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 6
      ,   'Columna_01'          = 'VALOR INDICE'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 7
      ,   'Columna_01'          = 'SPREAD'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 8
      ,   'Columna_01'          = 'CONTEO DIAS'
      ,   'Columna_02'   = ''
 ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 9
      ,   'Columna_01'          = 'MONEDA PAGO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 10
      ,   'Columna_01'          = 'MEDIO PAGO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 11
      ,   'Columna_01'          = 'FECHA INICIO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'             = 1
      ,   'Orden'               = 12
      ,   'Columna_01'          = 'FECHA TERMINO'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0
   UNION
   SELECT 'Ubicacion'           = 0
      ,   'Puntero'  = 1
      ,   'Orden'               = 13
      ,   'Columna_01'          = 'VALOR MTM'
      ,   'Columna_02'          = ''
      ,   'Columna_03'          = 0.0
      ,   'Columna_04'          = 0.0
      ,   'Columna_05'          = 0.0
      ,   'Columna_06'          = 0.0
      ,   'Columna_07'          = 0.0
      ,   'Columna_08'          = 0.0
      ,   'Activos'             = ''
      ,   'Pasivos'             = ''
      ,   'NumActivo'           = 0.0
      ,   'NumPasivo'           = 0.0
      ,   'NumActivoAnt'        = 0.0
      ,   'NumPasivoAnt'        = 0.0
      ,   'NumActivoSal'        = 0.0
      ,   'NumPasivoSal'        = 0.0
      ,   'MonedaActiva'        = 0
      ,   'MonedaPasiva'        = 0

   SELECT  tipo         = tipo_flujo
      ,    moneda       = mon.mnnemo
      ,    capital      = CASE WHEN car.tipo_flujo = 1  THEN car.compra_capital ELSE car.venta_capital END 
      ,    frecpago     = pago.glosa
      ,    freccapital  = capt.glosa
      ,    indicador    = Indi.tbglosa
      ,    valorindice  = CASE WHEN car.tipo_flujo = 1  THEN car.compra_valor_tasa else car.venta_valor_tasa end
      ,    spread       = CASE WHEN car.tipo_flujo = 1  THEN car.compra_spread     else car.venta_spread end
      ,    conteodias   = baas.glosa
      ,    MonPago      = monpago.mnnemo
      ,    MedioPago    = docpago.glosa
      ,    fechainicio  = CONVERT(CHAR(10), car.fecha_inicio_flujo, 103)
      ,    fechatermino = CONVERT(CHAR(10), car.fecha_vence_flujo, 103)
      ,    avr          = CASE WHEN car.tipo_flujo = 1  THEN car.activo_flujoclp else car.pasivo_flujoclp end
      ,    MonFlujo     = mon.mncodmon
   INTO    #DETCARTERA
   FROM    BacSwapSuda.dbo.CARTERA car
           LEFT JOIN BacParamSuda.dbo.MONEDA                 mon ON mon.mncodmon     = CASE WHEN car.tipo_flujo = 1 THEN car.compra_moneda ELSE car.venta_moneda END
           LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  pago ON pago.Tabla       = 1044 AND pago.codigo    = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codamo_interes ELSE car.venta_codamo_interes end
           LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  capt ON capt.Tabla       = 1043 AND capt.codigo    = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codamo_capital ELSE car.venta_codamo_capital end
           LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Indi ON Indi.tbcateg     = 1042 AND Indi.tbcodigo1 = CASE WHEN car.tipo_flujo = 1 THEN car.compra_codigo_tasa    ELSE car.venta_codigo_tasa end
           LEFT JOIN BacSwapSuda.dbo.BASE                   baas ON baas.codigo      = CASE WHEN car.tipo_flujo = 1 THEN car.compra_base         ELSE car.venta_base        END
           LEFT JOIN BacParamSuda.dbo.MONEDA             monpago ON monpago.mncodmon = CASE WHEN car.tipo_flujo = 1 THEN car.recibimos_moneda    ELSE car.pagamos_moneda    END
           LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO      docpago ON docpago.codigo   = CASE WHEN car.tipo_flujo = 1 THEN car.recibimos_documento ELSE car.pagamos_documento END
   WHERE  car.numero_operacion = @nContrato
   AND    car.numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato AND tipo_flujo = car.tipo_flujo)

   DECLARE @GlosaMonPago     VARCHAR(50)
       SET @GlosaMonPago     = ( SELECT mnnemo FROM BacParamSuda.dbo.MONEDA        WHERE mncodmon = @iPagamosMoneda)

   DECLARE @GlosaDocPago     VARCHAR(50)
       SET @GlosaDocPago     = ( SELECT glosa  FROM BacParamSuda.dbo.FORMA_DE_PAGO WHERE codigo   = @iPagamosDocumento)

   update #TMP_RETORNO
      set MonedaActiva = MonFlujo
     from #DETCARTERA
    where tipo         = 1

   update #TMP_RETORNO
      set MonedaPasiva = MonFlujo
     from #DETCARTERA
    where tipo         = 2

   UPDATE #TMP_RETORNO
      SET Activos      = CASE WHEN Orden = 1  THEN moneda
                              WHEN Orden = 3  THEN frecpago
                  WHEN Orden = 4  THEN freccapital
                              WHEN Orden = 5  THEN indicador
                              WHEN Orden = 8  THEN conteodias
                              WHEN Orden = 9  THEN MonPago
                              WHEN Orden = 10 THEN MedioPago
                              WHEN Orden = 11 THEN fechainicio
                              WHEN Orden = 12 THEN fechatermino
                              ELSE ''
                         END
      ,   NumActivo    = CASE WHEN Orden = 2  THEN capital
                              WHEN Orden = 6  THEN valorindice
                              WHEN Orden = 7  THEN spread
                              WHEN Orden = 13 THEN avr
                              ELSE 0
                         END
     FROM #DETCARTERA
    WHERE Ubicacion    = 0
      AND Puntero      = 1
      AND Tipo         = 1

   UPDATE #TMP_RETORNO
      SET Pasivos      = CASE WHEN Orden = 1  THEN moneda
                              WHEN Orden = 3  THEN frecpago
                              WHEN Orden = 4  THEN freccapital
                              WHEN Orden = 5  THEN indicador
                              WHEN Orden = 8  THEN conteodias
                              WHEN Orden = 9  THEN MonPago
                              WHEN Orden = 10 THEN MedioPago
                              WHEN Orden = 11 THEN fechainicio
                              WHEN Orden = 12 THEN fechatermino
                              ELSE ''
                         END
      ,   NumPasivo    = CASE WHEN Orden = 2  THEN capital
                              WHEN Orden = 6  THEN valorindice
                              WHEN Orden = 7  THEN spread
                              WHEN Orden = 13 THEN avr
                              ELSE 0
                         END
     FROM #DETCARTERA
    WHERE Ubicacion    = 0
      AND Puntero      = 1
      AND Tipo         = 2

   UPDATE #TMP_RETORNO
      SET NumActivoAnt = NumActivo
      ,   NumPasivoAnt = NumPasivo
      ,   NumActivoSal = NumActivo
      ,   NumPasivoSal = NumPasivo
    WHERE Ubicacion    = 0

   UPDATE #TMP_RETORNO
      SET NumActivoAnt = (NumActivo * @nPorcNominal) / 100
      ,   NumPasivoAnt = (NumPasivo * @nPorcNominal) / 100
    WHERE Ubicacion    = 0
      AND Orden        IN(2, 13)

   UPDATE #TMP_RETORNO
      SET NumActivoSal = (NumActivo * @PorcentajeSaldo) / 100
      ,   NumPasivoSal = (NumPasivo * @PorcentajeSaldo) / 100
    WHERE Ubicacion    = 0
      AND Orden        IN(2, 13)

---------------------------------------------------------------------------------------------
   INSERT INTO #TMP_RETORNO
   SELECT 'TipoCartera'        = 1                      --> Cartera Vigente
      ,   'TipoFlujo'          = car.tipo_flujo
      ,   'NumeroFlujo'        = car.numero_flujo
      ,   'FechaInicio'        = CONVERT(CHAR(10), car.fecha_inicio_flujo, 103)
      ,   'FechaVcto'          = CONVERT(CHAR(10), car.fecha_vence_flujo , 103)
      ,   'CapitalFlujo'       = CASE WHEN car.tipo_flujo = 1 THEN car.compra_capital         ELSE car.venta_capital         END
      ,   'AmorizacionFlujo'   = CASE WHEN car.tipo_flujo = 1 THEN car.compra_amortiza        ELSE car.venta_amortiza        END
      ,   'SaldoFlujo'         = CASE WHEN car.tipo_flujo = 1 THEN car.compra_saldo           ELSE car.venta_saldo           END
      ,   'InteresFlujo'       = CASE WHEN car.tipo_flujo = 1 THEN car.compra_interes         ELSE car.venta_interes         END
      ,   'AdicionalFlujo'     = CASE WHEN car.tipo_flujo = 1 THEN car.compra_flujo_adicional ELSE car.venta_flujo_adicional END
      ,   'AVRFlujo'           = CASE WHEN car.tipo_flujo = 1 THEN car.activo_flujoclp        ELSE car.pasivo_flujoclp       END
      ,   'Activos'            = ''
      ,   'Pasivos'            = ''
      ,   'NumActivo'          = 0.0
      ,   'NumPasivo'          = 0.0
 ,   'NumActivoAnt'       = 0.0
      ,   'NumPasivoAnt'       = 0.0
      ,   'NumActivoSal'       = 0.0
      ,   'NumPasivoSal'       = 0.0
      ,   'MonedaActiva'       = 0
      ,   'MonedaPasiva'       = 0
   FROM   BacSwapSuda.dbo.CARTERA car
   WHERE  numero_operacion     = @nContrato

   INSERT INTO #TMP_RETORNO
   SELECT 'TipoCartera'        = 2                      --> Cartera Anticipada
      ,   'TipoFlujo'          = car.tipo_flujo
      ,   'NumeroFlujo'        = car.numero_flujo
      ,   'FechaInicio'        = CONVERT(CHAR(10), car.fecha_inicio_flujo, 103)
      ,   'FechaVcto'          = CONVERT(CHAR(10), car.fecha_vence_flujo , 103)
      ,   'CapitalFlujo'       = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_capital         ELSE car.venta_capital         END * @nPorcNominal) / 100
      ,   'AmorizacionFlujo'   = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_amortiza        ELSE car.venta_amortiza        END * @nPorcNominal) / 100
      ,   'SaldoFlujo'         = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_saldo           ELSE car.venta_saldo           END * @nPorcNominal) / 100
      ,   'InteresFlujo'       = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_interes         ELSE car.venta_interes         END * @nPorcNominal) / 100
      ,   'AdicionalFlujo'     = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_flujo_adicional ELSE car.venta_flujo_adicional END * @nPorcNominal) / 100
      ,   'AVRFlujo'           = (CASE WHEN car.tipo_flujo = 1 THEN car.activo_flujoclp        ELSE car.Pasivo_flujoclp       END * @nPorcNominal) / 100
      ,   'Activos'            = ''
      ,   'Pasivos'            = ''
      ,   'NumActivo'          = 0.0
      ,   'NumPasivo'          = 0.0
      ,   'NumActivoAnt'       = 0.0
      ,   'NumPasivoAnt'       = 0.0
      ,   'NumActivoSal'       = 0.0
      ,   'NumPasivoSal'       = 0.0
      ,   'MonedaActiva'       = 0
      ,   'MonedaPasiva'       = 0
   FROM   BacSwapSuda.dbo.CARTERA car
   WHERE  numero_operacion     = @nContrato

   INSERT INTO #TMP_RETORNO
   SELECT 'TipoCartera'        = 3                      --> Cartera Anticipada
      ,   'TipoFlujo'          = car.tipo_flujo
      ,   'NumeroFlujo'        = car.numero_flujo
      ,   'FechaInicio'        = CONVERT(CHAR(10), car.fecha_inicio_flujo, 103)
      ,   'FechaVcto'          = CONVERT(CHAR(10), car.fecha_vence_flujo , 103)
      ,   'CapitalFlujo'       = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_capital         ELSE car.venta_capital         END * @PorcentajeSaldo) / 100
      ,   'AmorizacionFlujo'   = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_amortiza        ELSE car.venta_amortiza        END * @PorcentajeSaldo) / 100
      ,   'SaldoFlujo'         = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_saldo           ELSE car.venta_saldo           END * @PorcentajeSaldo) / 100
      ,   'InteresFlujo'       = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_interes         ELSE car.venta_interes         END * @PorcentajeSaldo) / 100
      ,   'AdicionalFlujo'     = (CASE WHEN car.tipo_flujo = 1 THEN car.compra_flujo_adicional ELSE car.venta_flujo_adicional END * @PorcentajeSaldo) / 100
      ,   'AVRFlujo'           = (CASE WHEN car.tipo_flujo = 1 THEN car.activo_flujoclp        ELSE car.pasivo_flujoclp       END * @PorcentajeSaldo) / 100
      ,   'Activos'            = ''
      ,   'Pasivos'            = ''
      ,   'NumActivo'          = 0.0
      ,   'NumPasivo'          = 0.0
      ,   'NumActivoAnt'       = 0.0
      ,   'NumPasivoAnt'       = 0.0
      ,   'NumActivoSal'       = 0.0
      ,   'NumPasivoSal'       = 0.0
      ,   'MonedaActiva'       = 0
      ,   'MonedaPasiva'       = 0
   FROM   BacSwapSuda.dbo.CARTERA car
   WHERE  numero_operacion     = @nContrato

   SELECT 'Proceso' = @dFechaProceso
      ,   'Emision' = @dFechaEmicion
      ,   'Hora'    = @dHoraEmision
      ,   'Usuario' = @cUsuario 
      ,   FechaAnticipo
      ,   NumContrato
    ,   Producto
      ,   RutCliente
      ,   CodCliente
      ,   NomCliente
      ,   dvCliente
      ,   Modalidad
      ,   MonedaAvr
      ,   AvrContrato
      ,   AnticipoTotal
      ,   PorcNominal
      ,   NominalAnticipo
      ,   ValAnticipo
      ,   ValParTC
      ,   ValAnticipoTran
      ,   ResultadoVenta
      ,   ResultadoTradin
      ,   PagamosMoneda
      ,   PagamosDocumento 
      ,   #TMP_RETORNO.*
      ,   GlosaMonedaPago    = @GlosaMonPago
      ,   GlosaDocumentoPago = @GlosaDocPago
      ,   MonedaAnticipo     = @MonedaAnticipo
   FROM   #MiTablaContrato
   ,      #TMP_RETORNO
   ORDER BY Ubicacion, Puntero, Orden

END
GO

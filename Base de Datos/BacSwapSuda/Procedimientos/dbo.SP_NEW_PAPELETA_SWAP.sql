USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NEW_PAPELETA_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_NEW_PAPELETA_SWAP]
   (   @iContrato   NUMERIC(9)
   ,   @xUsuario    VARCHAR(15)
   ,   @xOrigen     CHAR(1)   = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   -->     Fecha de Proceso
   DECLARE @dFechaProceso      DATETIME
       SET @dFechaProceso      = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))
   -->     --------------------------------------------------------

   -->     Genera tabla temporal con estructura de tabla de cartera
   SELECT * INTO #TMP_CARTERA 
            FROM BacSwapSuda.dbo.CARTERA WHERE 1 = 2
   CREATE CLUSTERED INDEX #ix_tmp_cartera ON #TMP_CARTERA (numero_operacion, numero_flujo, tipo_flujo)
   -->     --------------------------------------------------------

   -->     Lee ca cartera para obtener los registros vigentes y completa c/ Cartera vencida, para mostrar todos los flujos
   INSERT INTO #TMP_CARTERA
         SELECT * FROM BacSwapSuda.dbo.CARTERA    WHERE Numero_Operacion = @iContrato UNION
         SELECT * FROM BacSwapSuda.dbo.CARTERAHIS WHERE Numero_Operacion = @iContrato

      -->    Determina el Flujo Activo de ambas patas... EL VIGENTE EN CARTERA 
      DECLARE @iFlujoActivo      NUMERIC(5)
          SET @iFlujoActivo      = ISNULL( (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                             WHERE Numero_Operacion = @iContrato AND Tipo_Flujo = 1), -1)
      DECLARE @iFlujoPasivo      NUMERIC(5)
          SET @iFlujoPasivo      = ISNULL( (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA with(nolock) 
                                             WHERE Numero_Operacion = @iContrato AND Tipo_Flujo = 2), -1)
      -->    --------------------------------------------------------

      -->    cuando la operaion esta vencida o anticipada 100%, Flujo vigente, sera el ultimo flujo del swap
      IF @iFlujoActivo = -1
         SET @iFlujoActivo = (SELECT MAX(numero_flujo) FROM #TMP_CARTERA WHERE Tipo_Flujo = 1)
      IF @iFlujopasivo = -1
         SET @iFlujoPasivo = (SELECT MAX(numero_flujo) FROM #TMP_CARTERA WHERE Tipo_Flujo = 2)
      -->    --------------------------------------------------------
   -->     ---------------------------------------------------------

   -->     Aprobaciones
   DECLARE @Supervisor1     VARCHAR(20)
   DECLARE @Supervisor2     VARCHAR(20)

   SELECT  @Supervisor1     = ISNULL(Firma1, '')
   ,       @Supervisor2     = ISNULL(Firma2, '')
   FROM    BacLineas.dbo.DETALLE_APROBACIONES
   WHERE   Id_Sistema       = 'PCS'
   AND     Numero_Operacion = @iContrato
   -->     ------------------------------------------------------------

   DECLARE @xMensajeThreshold   VARCHAR(100)
       SET @xMensajeThreshold   = ISNULL(( SELECT TOP 1 SUBSTRING(Mensaje, 1, 70) FROM BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD
                                            WHERE Id_Sistema   = 'PCS' AND Num_Contrato = @iContrato), '')

   -->    los valores de precios de Transferencia NO Estan en cartera
   CREATE TABLE #TMP_CARTERA_RESMESA
   (   NumeroContrato           NUMERIC(9)
   ,   TipoFlujo                NUMERIC(5)
   ,   ValorTransferencia       FLOAT
   ,   SpreadTransferencia      FLOAT
   ,   ValorResultadoPesos      FLOAT
   ,   VaorResultadoDolares     FLOAT
   )

   INSERT INTO #TMP_CARTERA_RESMESA
   SELECT DISTINCT Numero_Operacion, Tipo_Flujo, tasa_transfer, spread_transfer, res_mesa_dist_clp, res_mesa_dist_usd FROM MOVDIARIO    with(nolock) WHERE Numero_Operacion = @iContrato UNION
   SELECT DISTINCT Numero_Operacion, Tipo_Flujo, tasa_transfer, spread_transfer, res_mesa_dist_clp, res_mesa_dist_usd FROM MOVHISTORICO with(nolock) WHERE Numero_Operacion = @iContrato 
   -->     --------------------------------------------------------

   DECLARE @vMercadoUSD      FLOAT
       SET @vMercadoUSD      = (SELECT SUM(car.activo_usd_c08) - SUM(car.pasivo_usd_c08) FROM #TMP_CARTERA car WHERE tipo_Flujo = 1)
   DECLARE @vMercadoMx       FLOAT
       SET @vMercadoMx       = (SELECT SUM(car.activo_clp_c08) - SUM(car.pasivo_clp_c08)  FROM #TMP_CARTERA car WHERE tipo_Flujo = 2)
   DECLARE @vRazonableUSD    FLOAT 
       SET @vRazonableUSD    = (SELECT TOP 1 car.Valor_RazonableUSD FROM #TMP_CARTERA car WHERE car.numero_flujo = @iFlujoActivo)
   DECLARE @vRazonableCLP    FLOAT 
       SET @vRazonableCLP    = (SELECT TOP 1 car.Valor_RazonableCLP FROM #TMP_CARTERA car WHERE car.numero_flujo = @iFlujoActivo)
   DECLARE @ResMesaDistCLP   FLOAT
       SET @ResMesaDistCLP   = (SELECT TOP 1 ValorResultadoPesos  FROM #TMP_CARTERA_RESMESA)
   DECLARE @ResMesaDistUSD   FLOAT
       SET @ResMesaDistUSD   = (SELECT TOP 1 VaorResultadoDolares FROM #TMP_CARTERA_RESMESA)

   DECLARE @xObservaciones   VARCHAR(255)
   DECLARE @xObsrLineas      VARCHAR(255)
   DECLARE @xObsrLimites     VARCHAR(255)
   DECLARE @xObsrIntercambio VARCHAR(100)
   DECLARE @xEstado          VARCHAR(10)
    SELECT DISTINCT TOP 1
          @xObservaciones   = SUBSTRING( car.observaciones, 1, 255)
      ,   @xObsrLineas      = SUBSTRING( car.Observacion_Lineas, 1, 255)
      ,   @xObsrLimites     = SUBSTRING( car.Observacion_Limites, 1, 255)
      ,   @xObsrIntercambio = CASE WHEN car.IntercPrinc = 1 THEN 'Operación afecta a Intercambio de Capital' ELSE '' END
      ,   @xEstado          = car.Estado
   FROM   #TMP_CARTERA car
   WHERE  car.numero_flujo  = @iFlujoActivo

   -->    Determina los datos de cabecera
   SELECT DISTINCT
          NumeroContrato      = car.numero_operacion
      ,   RutCliente          = CONVERT(VARCHAR(14), REPLICATE(' ', 12 - LEN(cli.clrut) ) + LTRIM(RTRIM( cli.clrut )) + '-' + cli.cldv )
      ,   Nombrecliente       = cli.clnombre
      ,   vMercadoUSD         = @vMercadoUSD
      ,   vMercadoMx          = @vMercadoMx
      ,   vRazonableUSD       = @vRazonableUSD
      ,   vRazonableCLP       = @vRazonableCLP
      ,   vResMesaDistCLP     = @ResMesaDistCLP
      ,   vResMesaDistUSD     = @ResMesaDistUSD
      ,   CarteraFinanciera   = SUBSTRING( fin.tbglosa, 1, 20)
      ,   CarteraNormativa    = SUBSTRING( nor.tbglosa, 1, 20)
      ,   LibroNegociacion    = SUBSTRING( lib.tbglosa, 1, 20)
      ,   AreaResponsalble    = SUBSTRING( are.tbglosa, 1, 20)
      ,   SubCarteraNormativa = SUBSTRING( sub.tbglosa, 1, 20)
      ,   ModalidadPago       = CASE WHEN car.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,   Supervisor1         = @Supervisor1
      ,   Supervisor2         = @Supervisor2
      ,   Threshold           = @xMensajeThreshold
      ,   MensajeLineas       = @xObsrLineas
      ,   MensajeLimites      = @xObsrLimites
      ,   MensajeIntercambio  = @xObsrIntercambio
      ,   Observaciones       = @xObservaciones
      ,   Operador            = car.operador
      ,   tipo_operacion      = CASE WHEN car.tipo_swap  = 3 AND car.tipo_operacion = 'P' THEN 'PRESTAMISTA'
                                     WHEN car.tipo_swap  = 3 AND car.tipo_operacion = 'T' THEN 'TOMADOR'
                                     WHEN car.tipo_swap <> 3 AND car.tipo_operacion = 'C' THEN 'COMPRA'
                                     WHEN car.tipo_swap <> 3 AND car.tipo_operacion = 'V' THEN 'VENTA'
                                END
      ,   Dias                = DATEDIFF(DAY, car.FechaEfectiva, car.Madurez)
      ,   GuardadaComo        = @xEstado
      ,   FlujoAdicional      = CASE WHEN car.Tipo_Flujo = 1 THEN CONVERT(NUMERIC(21,4), car.compra_Flujo_Adicional ) 
                                     WHEN car.Tipo_Flujo = 2 THEN CONVERT(NUMERIC(21,4), car.venta_Flujo_Adicional )
                                END

   INTO   #TMP_CABECERA
   FROM   #TMP_CARTERA                                   car
          INNER JOIN BacParamSuda.dbo.CLIENTE            cli with(nolock) ON cli.clrut   = car.rut_cliente AND cli.clcodigo  = car.codigo_cliente
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE fin with(nolock) ON fin.tbcateg = 204             AND fin.tbcodigo1 = car.cartera_inversion
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE nor with(nolock) ON nor.tbcateg = 1111            AND nor.tbcodigo1 = car.car_Cartera_Normativa
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE Lib with(nolock) ON lib.tbcateg = 1552            AND lib.tbcodigo1 = car.car_Libro
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE Are with(nolock) ON are.tbcateg = 1553            AND are.tbcodigo1 = car.car_area_Responsable 
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE Sub with(nolock) ON sub.tbcateg = 1554            AND Sub.tbcodigo1 = car.car_SubCartera_Normativa 
   -->    ------------------------------------------------------------------------
   

   -->    Determina las caracteristicas del flujo de compra
   SELECT Compra_CodMoneda             = car.compra_moneda
      ,   Compra_DesMoneda             = SUBSTRING( Mon.mnglosa, 1, 20)
      ,   Compra_Nocional              = car.compra_capital
      ,   Compra_CodIndicador          = car.compra_codigo_tasa
      ,   Compra_DesIndicador          = SUBSTRING( ind.tbglosa, 1, 20)
      ,   Compra_IndicadorValor        = car.compra_valor_tasa
      ,   Compra_SpreadValor           = car.compra_spread
      ,   Compra_ValorTrasfeencia      = rme.ValorTransferencia
      ,   Compra_SpreadTrasferencia    = rme.SpreadTransferencia
      ,   Compra_CodDias               = car.compra_base
      ,   Compra_ConteoDias            = SUBSTRING( bas.glosa, 1, 20)
      ,   Compra_PeriodoInteres        = car.compra_codamo_interes
      ,   Compra_GlosaPeriodoInt       = SUBSTRING( pca.glosa, 1, 20)
      ,   Compra_PeriodoCapital        = car.compra_codamo_capital
      ,   Compra_GlosaPerCapital       = SUBSTRING( pin.glosa, 1, 20)
      ,   Compra_MonedaPago            = SUBSTRING( LTRIM(RTRIM(Pag.mnnemo)) 
                                       + ' - ' 
                                       + LTRIM(RTRIM(Pag.mnglosa)), 1, 20)
      ,   Compra_MedioPago             = SUBSTRING( LTRIM(RTRIM(fpa.glosa)) , 1, 20)
      ,   Compra_FecEfectivaVenta      = CONVERT(CHAR(10), car.FechaEfectiva, 103)
      ,   Compra_FecPrimerPagoVenta    = CONVERT(CHAR(10), car.PrimerPago, 103)
      ,   Compra_FecPenultimoPagoVenta = CONVERT(CHAR(10), car.PenultimoPago, 103)
      ,   Compra_FecMadurezVenta       = CONVERT(CHAR(10), car.Madurez, 103)
      ,   Compra_FeriadoVcto           = CASE WHEN car.FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END
                                       + CASE WHEN car.FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END
                                       + CASE WHEN car.FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END
      ,   Compra_FeriadoLiqu           = CASE WHEN car.FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END
                                       + CASE WHEN car.FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END
                                       + CASE WHEN car.FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END
      ,   Compra_AjustHabiles          = Convencion
      ,   Compra_Convencion            = 'Normal - Adelante'
      ,   Compra_DiasReset             = car.DiasReset
      ,   Compra_Macaulay              = car.vDurMacaulActivo
      ,   Compra_Modificada            = car.vDurModifiActivo
      ,   Compra_Convexidad            = car.vDurConvexActivo
     INTO #TMP_COMPRAS
     FROM #TMP_CARTERA                                      car
          INNER JOIN #TMP_CARTERA_RESMESA                   rme with(nolock) ON rme.NumeroContrato = car.Numero_Operacion AND rme.TipoFlujo = car.Tipo_Flujo
          INNER JOIN BacParamSuda.dbo.MONEDA                Mon with(nolock) ON Mon.mncodmon       = car.compra_moneda
          INNER JOIN BacParamSuda.dbo.MONEDA                Pag with(nolock) ON Pag.mncodmon       = car.recibimos_moneda
          INNER JOIN BacParamSuda..FORMA_DE_PAGO            fpa with(nolock) ON fpa.codigo         = car.recibimos_documento
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ind with(nolock) ON ind.tbcateg        = 1042 and ind.tbcodigo1 = car.compra_codigo_tasa
          INNER JOIN BacSwapSuda.dbo.BASE                   bas with(nolock) ON bas.codigo         = car.compra_base
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION     pca with(nolock) ON pca.sistema        = 'PCS' and pca.tabla = 1044 and pca.codigo = car.compra_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION     pin with(nolock) ON pin.sistema        = 'PCS' and pin.tabla = 1043 and pin.codigo = car.compra_codamo_capital
    WHERE car.Numero_Operacion        = @iContrato
      AND car.Tipo_Flujo              = 1
      AND car.numero_flujo            = @iFlujoActivo
   -->    ------------------------------------------------------------------------

   -->    Determina las caracteristicas del flujo de venta
   SELECT Compra_CodMoneda             = car.venta_moneda
      ,   Compra_DesMoneda             = SUBSTRING( Mon.mnglosa, 1, 20)
      ,   Compra_Nocional              = car.venta_capital
      ,   Compra_CodIndicador          = car.venta_codigo_tasa
      ,   Compra_DesIndicador          = SUBSTRING( ind.tbglosa, 1, 20)
      ,   Compra_IndicadorValor        = car.venta_valor_tasa
      ,   Compra_SpreadValor           = car.venta_spread
      ,   Compra_ValorTrasfeencia      = rme.ValorTransferencia
      ,   Compra_SpreadTrasferencia    = rme.SpreadTransferencia
      ,   Compra_CodDias               = car.venta_base
      ,   Compra_ConteoDias            = SUBSTRING( bas.glosa, 1, 20)
      ,   Compra_PeriodoInteres        = car.venta_codamo_interes
      ,   Compra_GlosaPeriodoInt       = SUBSTRING( pca.glosa, 1, 20)
      ,   Compra_PeriodoCapital        = car.venta_codamo_capital
      ,   Compra_GlosaPerCapital       = SUBSTRING( pin.glosa, 1, 20)
      ,   Compra_MonedaPago            = SUBSTRING( LTRIM(RTRIM(Pag.mnnemo)) 
                                       + ' - ' 
                                       + LTRIM(RTRIM(Pag.mnglosa)), 1, 20)
      ,   Compra_MedioPago             = SUBSTRING( LTRIM(RTRIM(fpa.glosa)) , 1, 20)
      ,   Compra_FecEfectivaVenta      = CONVERT(CHAR(10), car.FechaEfectiva, 103)
      ,   Compra_FecPrimerPagoVenta    = CONVERT(CHAR(10), car.PrimerPago, 103)
      ,   Compra_FecPenultimoPagoVenta = CONVERT(CHAR(10), car.PenultimoPago, 103)
      ,   Compra_FecMadurezVenta       = CONVERT(CHAR(10), car.Madurez, 103)
      ,   Compra_FeriadoVcto           = CASE WHEN car.FeriadoFlujoChile  = 1 THEN '- CHI ' ELSE '' END
                                       + CASE WHEN car.FeriadoFlujoEEUU   = 1 THEN '- USA ' ELSE '' END
                                       + CASE WHEN car.FeriadoFlujoEnglan = 1 THEN '- ING ' ELSE '' END
      ,   Compra_FeriadoLiqu           = CASE WHEN car.FeriadoLiquiChile  = 1 THEN '- CHI ' ELSE '' END
                                       + CASE WHEN car.FeriadoLiquiEEUU   = 1 THEN '- USA ' ELSE '' END
                                       + CASE WHEN car.FeriadoLiquiEnglan = 1 THEN '- ING ' ELSE '' END
      ,   Compra_AjustHabiles          = Convencion
      ,   Compra_Convencion            = 'Normal - Adelante'
      ,   Compra_DiasReset             = car.DiasReset
      ,   Compra_Macaulay              = car.vDurMacaulActivo
      ,   Compra_Modificada            = car.vDurModifiActivo
      ,   Compra_Convexidad            = car.vDurConvexActivo
     INTO #TMP_VENTAS
     FROM #TMP_CARTERA                                      car
          INNER JOIN #TMP_CARTERA_RESMESA                   rme with(nolock) ON rme.NumeroContrato = car.Numero_Operacion AND rme.TipoFlujo = car.Tipo_Flujo
          INNER JOIN BacParamSuda.dbo.MONEDA                Mon with(nolock) ON Mon.mncodmon       = car.venta_moneda
          INNER JOIN BacParamSuda.dbo.MONEDA                Pag with(nolock) ON Pag.mncodmon       = car.pagamos_moneda
          INNER JOIN BacParamSuda..FORMA_DE_PAGO            fpa with(nolock) ON fpa.codigo         = car.pagamos_documento
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ind with(nolock) ON ind.tbcateg        = 1042 and ind.tbcodigo1 = car.venta_codigo_tasa
          INNER JOIN BacSwapSuda.dbo.BASE                   bas with(nolock) ON bas.codigo         = car.venta_base
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION     pca with(nolock) ON pca.sistema        = 'PCS' and pca.tabla = 1044 and pca.codigo = car.venta_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION     pin with(nolock) ON pin.sistema        = 'PCS' and pin.tabla = 1043 and pin.codigo = car.venta_codamo_capital
    WHERE car.Numero_Operacion     = @iContrato
      AND car.Tipo_Flujo           = 2
      AND car.numero_flujo         = @iFlujoPasivo
   -->    ------------------------------------------------------------------------


   SELECT * FROM #TMP_CABECERA


END
GO

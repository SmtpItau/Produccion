USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES_SWAP_ANTICIPO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES_SWAP_ANTICIPO]
   (   @iNumeroSwap   NUMERIC(9)
   ,   @iTipFlujo     INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTipFlujo = 1
      SELECT /*001*/ 'Tikker'            = CONVERT(VARCHAR(50), cart.Tikker)
      ,      /*002*/ 'Modalidad'         = CASE WHEN cart.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      /*003*/ 'CompraMoneda'      = cart.Compra_Moneda
      ,      /*004*/ 'NemoCompraMoneda'  = mone.mnnemo
      ,      /*005*/ 'CompraCapital'     = cart.compra_capital
      ,      /*006*/ 'FrecuenciaPago'    = cart.compra_codamo_interes
      ,      /*007*/ 'FrecuenciaCapital' = cart.compra_codamo_capital
      ,      /*008*/ 'Indicador'         = cart.compra_codigo_tasa
      ,      /*009*/ 'UltimoIndice'      = cart.compra_valor_tasa
      ,      /*010*/ 'Spread'            = cart.compra_spread
      ,      /*011*/ 'ConteoDias'        = cart.compra_base
      ,      /*012*/ 'FechaEfectiva'     = CONVERT(CHAR(10), cart.FechaEfectiva,103)
      ,      /*013*/ 'PrimerPago'        = CONVERT(CHAR(10), cart.PrimerPago,103)
      ,      /*014*/ 'PenultimoPago'     = CONVERT(CHAR(10), cart.PenultimoPago,103)
      ,      /*015*/ 'Madurez'           = CONVERT(CHAR(10), cart.Madurez,103)
      ,      /*016*/ 'MonedaPagamos'     = cart.recibimos_moneda
      ,      /*017*/ 'DocumentoPagamos'  = cart.recibimos_documento
      ,      /*018*/ 'Note'              = CONVERT(CHAR(50), cart.Note)
      ,      /*019*/ 'FeriadoFlujoChile' = cart.FeriadoFlujoChile
      ,      /*020*/ 'FeriadoFlujoEEUU'  = cart.FeriadoFlujoEEUU
      ,      /*021*/ 'FeriadoFlujoEnglan'= cart.FeriadoFlujoEnglan
      ,      /*022*/ 'FeriadoLiquiChile' = cart.FeriadoLiquiChile
      ,      /*023*/ 'FeriadoLiquiEEUU'  = cart.FeriadoLiquiEEUU
      ,      /*024*/ 'FeriadoLiquiEnglan'= cart.FeriadoLiquiEnglan
      ,      /*025*/ 'Vencimiento'       = CONVERT(CHAR(10), cart.fecha_vence_flujo,103)
      ,      /*026*/ 'Amortizacion'      = cart.compra_amortiza
      ,      /*027*/ 'Tasa+Spread'       = cart.compra_valor_tasa + cart.compra_spread
      ,      /*028*/ 'Interes'           = cart.compra_Interes
      ,      /*029*/ 'Total'             = cart.compra_amortiza + cart.compra_Interes
      ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10), cart.FechaLiquidacion, 103)
      ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10), cart.FechaReset, 103)
      ,      /*032*/ 'recibimosmonto'    = cart.recibimos_monto
      ,      /*033*/ 'recibimosmontoUSD' = cart.recibimos_monto_USD
      ,      /*034*/ 'recibimosmontoCLP' = cart.recibimos_monto_CLP
      ,      /*035*/ 'FechaLiquidacion'  = cart.FechaLiquidacion
      ,      /*036*/ 'Convencion'        = cart.Convencion
      ,      /*037*/ 'DiasReset'         = cart.DiasReset
      ,      /*038*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10), cart.rut_cliente))) + '-' + clie.cldv
      ,      /*039*/ 'Nombre'            = clie.clnombre
      ,      /*040*/ 'CarteraFinanciera' = cart.cartera_inversion
      ,      /*041*/ 'AreaResponsable'   = cart.car_area_Responsable
      ,      /*042*/ 'LibroNegociacion'  = cart.car_Libro
      ,      /*043*/ 'CarteraNormativa'  = cart.car_Cartera_Normativa
      ,      /*044*/ 'SubCartera'        = cart.car_SubCartera_Normativa
      ,      /*045*/ 'CodigoCliente'     = cart.codigo_cliente
      ,      /*046*/ 'DiasAmortizacion'  = inte.dias
      ,      /*047*/ 'DiasBase'          = CASE WHEN bbas.base = 'A' THEN 365 ELSE bbas.base END
      ,      /*048*/ 'TipoSwap'          = tipo_swap
      ,      /*049*/ 'Indicador'         = tass.tbglosa
      FROM   CARTERA                     cart
             INNER JOIN BacParamSuda..MONEDA                mone with(nolock) ON mone.mncodmon = cart.Compra_Moneda
             INNER JOIN BacParamSuda..CLIENTE               clie with(nolock) ON clie.clrut    = rut_cliente and clie.clcodigo  = cart.codigo_cliente
             INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  inte with(nolock) ON inte.tabla    = 1044        and inte.codigo    = cart.compra_codamo_interes
             INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  capt with(nolock) ON capt.tabla    = 1043        and capt.codigo    = cart.compra_codamo_capital
             INNER JOIN BacSwapSuda.dbo.BASE                bbas with(nolock) ON bbas.codigo   = cart.compra_base
             INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE tass with(nolock) ON tass.tbcateg  = 1042        and tass.tbcodigo1 = cart.compra_codigo_tasa
      WHERE  cart.numero_operacion        = @iNumeroSwap
      AND    cart.tipo_flujo              = @iTipFlujo
      ORDER BY cart.numero_operacion, cart.tipo_flujo, cart.numero_flujo

   ELSE
      SELECT /*001*/ 'Tikker'            = CONVERT(VARCHAR(50), cart.Tikker)
      ,      /*002*/ 'Modalidad'         = CASE WHEN cart.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      /*003*/ 'CompraMoneda'      = cart.venta_Moneda
      ,      /*004*/ 'NemoCompraMoneda'  = mone.mnnemo
      ,      /*005*/ 'CompraCapital'     = cart.venta_capital
      ,      /*006*/ 'FrecuenciaPago'    = cart.venta_codamo_interes
      ,      /*007*/ 'FrecuenciaCapital' = cart.venta_codamo_capital
      ,      /*008*/ 'Indicador'         = cart.venta_codigo_tasa
      ,      /*009*/ 'UltimoIndice'      = cart.venta_valor_tasa
      ,      /*010*/ 'Spread'            = cart.venta_spread
      ,      /*011*/ 'ConteoDias'        = cart.venta_base
      ,      /*012*/ 'FechaEfectiva'     = CONVERT(CHAR(10), cart.FechaEfectiva,103)
      ,      /*013*/ 'PrimerPago'        = CONVERT(CHAR(10), cart.PrimerPago,103)
      ,      /*014*/ 'PenultimoPago'     = CONVERT(CHAR(10), cart.PenultimoPago,103)
      ,      /*015*/ 'Madurez'           = CONVERT(CHAR(10), cart.Madurez,103)
      ,      /*016*/ 'MonedaPagamos'     = cart.pagamos_moneda
      ,      /*017*/ 'DocumentoPagamos'  = cart.pagamos_documento
      ,      /*018*/ 'Note'              = CONVERT(CHAR(50), cart.Note)
      ,      /*019*/ 'FeriadoFlujoChile' = cart.FeriadoFlujoChile
      ,      /*020*/ 'FeriadoFlujoEEUU'  = cart.FeriadoFlujoEEUU
      ,      /*021*/ 'FeriadoFlujoEnglan'= cart.FeriadoFlujoEnglan
      ,      /*022*/ 'FeriadoLiquiChile' = cart.FeriadoLiquiChile
      ,      /*023*/ 'FeriadoLiquiEEUU'  = cart.FeriadoLiquiEEUU
      ,      /*024*/ 'FeriadoLiquiEnglan'= cart.FeriadoLiquiEnglan
      ,      /*025*/ 'Vencimiento'       = CONVERT(CHAR(10), cart.fecha_vence_flujo,103)
      ,      /*026*/ 'Amortizacion'      = cart.venta_amortiza
      ,      /*027*/ 'Tasa+Spread'       = cart.venta_valor_tasa + cart.venta_spread
      ,      /*028*/ 'Interes'           = cart.venta_Interes
      ,      /*029*/ 'Total'             = cart.venta_amortiza   + cart.venta_Interes
      ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10), cart.FechaLiquidacion, 103)
      ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10), cart.FechaReset, 103)
      ,      /*032*/ 'recibimosmonto'    = cart.pagamos_monto
      ,      /*033*/ 'recibimosmontoUSD' = cart.pagamos_monto_USD
      ,      /*034*/ 'recibimosmontoCLP' = cart.pagamos_monto_CLP
      ,      /*035*/ 'FechaLiquidacion'  = cart.FechaLiquidacion
      ,      /*036*/ 'Convencion'        = cart.Convencion
      ,      /*037*/ 'DiasReset'         = cart.DiasReset
      ,      /*038*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10), cart.rut_cliente))) + '-' + clie.cldv
      ,      /*039*/ 'Nombre'            = clie.clnombre
      ,      /*040*/ 'CarteraFinanciera' = cart.cartera_inversion
      ,      /*041*/ 'AreaResponsable'   = cart.car_area_Responsable
      ,      /*042*/ 'LibroNegociacion'  = cart.car_Libro
      ,      /*043*/ 'CarteraNormativa'  = cart.car_Cartera_Normativa
      ,      /*044*/ 'SubCartera'        = cart.car_SubCartera_Normativa
      ,  /*045*/ 'CodigoCliente'     = cart.codigo_cliente
      ,      /*046*/ 'DiasAmortizacion'  = inte.dias
      ,      /*047*/ 'DiasBase'          = CASE WHEN bbas.base = 'A' THEN 365 ELSE bbas.base END
      ,      /*048*/ 'TipoSwap'          = tipo_swap
      ,      /*049*/ 'Indicador'         = tass.tbglosa
      FROM   CARTERA                     cart
             INNER JOIN BacParamSuda..MONEDA                mone with(nolock) ON mone.mncodmon = cart.venta_Moneda
             INNER JOIN BacParamSuda..CLIENTE               clie with(nolock) ON clie.clrut    = rut_cliente and clie.clcodigo  = cart.codigo_cliente
             INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  inte with(nolock) ON inte.tabla    = 1044        and inte.codigo    = cart.venta_codamo_interes
             INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  capt with(nolock) ON capt.tabla    = 1043        and capt.codigo    = cart.venta_codamo_capital
             INNER JOIN BacSwapSuda.dbo.BASE                bbas with(nolock) ON bbas.codigo   = cart.venta_base
             INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE tass with(nolock) ON tass.tbcateg  = 1042        and tass.tbcodigo1 = cart.venta_codigo_tasa
      WHERE  cart.numero_operacion        = @iNumeroSwap
      AND    cart.tipo_flujo              = @iTipFlujo
      ORDER BY cart.numero_operacion, cart.tipo_flujo, cart.numero_flujo

END
GO

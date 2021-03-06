USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES_SWAP]



   (   @iNumeroSwap   NUMERIC(9)



   ,   @iTipFlujo     INTEGER



   )



AS



BEGIN







   SET NOCOUNT ON







IF @iTipFlujo = 1



   SELECT /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)



   ,      /*002*/ 'Modalidad'         = CASE WHEN ca.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END



   ,      /*003*/ 'CompraMoneda'      = ca.Compra_Moneda           -- mi.mnglosa



   ,      /*004*/ 'NemoCompraMoneda'  = mi.mnnemo



   ,      /*005*/ 'CompraCapital'     = ca.compra_capital



   ,      /*006*/ 'FrecuenciaPago'    = ca.compra_codamo_interes   -- i.glosa



   ,      /*007*/ 'FrecuenciaCapital' = ca.compra_codamo_capital   -- k.glosa



   ,      /*008*/ 'Indicador'         = ca.compra_codigo_tasa      -- ta.tbglosa



   ,      /*009*/ 'UltimoIndice'      = compra_valor_tasa



   ,      /*010*/ 'Spread'            = compra_spread



   ,      /*011*/ 'ConteoDias'        = compra_base



   ,      /*012*/ 'FechaEfectiva'     = CONVERT(CHAR(10),FechaEfectiva,103)



   ,      /*013*/ 'PrimerPago'        = CONVERT(CHAR(10),PrimerPago,103)



   ,      /*014*/ 'PenultimoPago'     = CONVERT(CHAR(10),PenultimoPago,103)



   ,      /*015*/ 'Madurez'           = CONVERT(CHAR(10),Madurez,103)



   ,      /*016*/ 'MonedaPagamos'     = recibimos_moneda



   ,      /*017*/ 'DocumentoPagamos'  = recibimos_documento



   ,      /*018*/ 'Note'              = CONVERT(CHAR(50),Note)



   ,      /*019*/ 'FeriadoFlujoChile' = FeriadoFlujoChile



   ,      /*020*/ 'FeriadoFlujoEEUU'  = FeriadoFlujoEEUU



   ,      /*021*/ 'FeriadoFlujoEnglan'= FeriadoFlujoEnglan



   ,      /*022*/ 'FeriadoLiquiChile' = FeriadoLiquiChile



   ,      /*023*/ 'FeriadoLiquiEEUU'  = FeriadoLiquiEEUU



   ,      /*024*/ 'FeriadoLiquiEnglan'= FeriadoLiquiEnglan



   ,      /*025*/ 'Vencimiento'       = CONVERT(CHAR(10),fecha_vence_flujo,103)



   ,      /*026*/ 'Amortizacion'      = compra_amortiza



   ,      /*027*/ 'Tasa+Spread'       = compra_valor_tasa + compra_spread



   ,      /*028*/ 'Interes'           = compra_Interes



   ,      /*029*/ 'Total'             = compra_amortiza + compra_Interes



   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),FechaLiquidacion,103)



   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),FechaReset,103)



   ,      /*032*/ 'recibimosmonto'    = recibimos_monto



   ,      /*033*/ 'recibimosmontoUSD' = recibimos_monto_USD



   ,      /*034*/ 'recibimosmontoCLP' = recibimos_monto_CLP



   ,      /*035*/ 'FechaLiquidacion'  = FechaLiquidacion



   ,      /*036*/ 'Convencion'        = Convencion



   ,      /*037*/ 'DiasReset'         = DiasReset



   ,      /*038*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv



   ,      /*039*/ 'Nombre'            = cl.clnombre



   ,      /*040*/ 'CarteraFinanciera' = cartera_inversion



   ,      /*041*/ 'AreaResponsable'   = car_area_Responsable



   ,      /*042*/ 'LibroNegociacion'  = car_Libro



   ,      /*043*/ 'CarteraNormativa'  = car_Cartera_Normativa



   ,      /*044*/ 'SubCartera'        = car_SubCartera_Normativa



   ,      /*045*/ 'CodigoCliente'     = codigo_cliente



   ,	  /*046*/ 'tipo_swap'		  = tipo_swap
   ,	  /*047*/ 'Numero_Flujo'      = numero_flujo 
   ,      /*048*/ 'rut_cliente'       = rut_cliente

   FROM   CARTERA ca



          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente



          INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Compra_Moneda



          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.compra_codamo_interes



          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.compra_codamo_capital



          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.compra_codigo_tasa



   WHERE  numero_operacion            = @iNumeroSwap



   AND    tipo_flujo                  = 1



   ORDER BY numero_operacion , tipo_flujo , numero_flujo







ELSE



   SELECT /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)




   ,      /*002*/ 'Modalidad'         = CASE WHEN ca.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END



   ,      /*003*/ 'CompraMoneda'      = ca.venta_Moneda           -- mi.mnglosa



   ,      /*004*/ 'NemoCompraMoneda'  = mi.mnnemo



   ,      /*005*/ 'CompraCapital'     = ca.venta_capital



   ,      /*006*/ 'FrecuenciaPago'    = ca.venta_codamo_interes   -- i.glosa



   ,      /*007*/ 'FrecuenciaCapital' = ca.venta_codamo_capital   -- k.glosa



   ,      /*008*/ 'Indicador'         = ca.venta_codigo_tasa      -- ta.tbglosa



   ,      /*009*/ 'UltimoIndice'      = ca.venta_valor_tasa



   ,      /*010*/ 'Spread'            = ca.venta_spread



   ,      /*011*/ 'ConteoDias'        = ca.venta_base



   ,      /*012*/ 'FechaEfectiva'     = CONVERT(CHAR(10),ca.FechaEfectiva,103)



   ,      /*013*/ 'PrimerPago'        = CONVERT(CHAR(10),ca.PrimerPago,103)



   ,      /*014*/ 'PenultimoPago'     = CONVERT(CHAR(10),ca.PenultimoPago,103)



   ,      /*015*/ 'Madurez'           = CONVERT(CHAR(10),ca.Madurez,103)



   ,      /*016*/ 'MonedaPagamos'     = ca.pagamos_moneda



   ,      /*017*/ 'DocumentoPagamos'  = ca.pagamos_documento



   ,      /*018*/ 'Note'              = CONVERT(CHAR(50),ca.Note)



   ,      /*019*/ 'FeriadoFlujoChile' = ca.FeriadoFlujoChile



   ,      /*020*/ 'FeriadoFlujoEEUU'  = ca.FeriadoFlujoEEUU



   ,      /*021*/ 'FeriadoFlujoEnglan'= ca.FeriadoFlujoEnglan



   ,      /*022*/ 'FeriadoLiquiChile' = ca.FeriadoLiquiChile



   ,      /*023*/ 'FeriadoLiquiEEUU'  = ca.FeriadoLiquiEEUU



   ,      /*024*/ 'FeriadoLiquiEnglan'= ca.FeriadoLiquiEnglan



   ,      /*025*/ 'Vencimiento'       = CONVERT(CHAR(10),ca.fecha_vence_flujo,103)



   ,      /*026*/ 'Amortizacion'      = ca.Venta_amortiza



   ,      /*027*/ 'Tasa+Spread'       = ca.Venta_valor_tasa + ca.Venta_spread



   ,      /*028*/ 'Interes'           = ca.Venta_Interes



   ,      /*029*/ 'Total'             = ca.Venta_amortiza   + ca.Venta_Interes



   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),ca.FechaLiquidacion,103)



   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),ca.FechaReset,103)



   ,      /*032*/ 'recibimosmonto'    = ca.recibimos_monto



   ,      /*033*/ 'recibimosmontoUSD' = ca.recibimos_monto_USD



   ,      /*034*/ 'recibimosmontoCLP' = ca.recibimos_monto_CLP



   ,      /*035*/ 'FechaLiquidacion'  = ca.FechaLiquidacion



   ,      /*036*/ 'Convencion'        = ca.Convencion



   ,      /*037*/ 'DiasReset'         = ca.DiasReset



   ,      /*038*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv



   ,      /*039*/ 'Nombre'            = cl.clnombre



   ,      /*040*/ 'CarteraFinanciera' = cartera_inversion



   ,      /*041*/ 'AreaResponsable'   = car_area_Responsable



   ,      /*042*/ 'LibroNegociacion'  = car_Libro



   ,      /*043*/ 'CarteraNormativa'  = car_Cartera_Normativa



   ,      /*044*/ 'SubCartera'        = car_SubCartera_Normativa



   ,      /*045*/ 'CodigoCliente'     = codigo_cliente



   ,	  /*046*/ 'tipo_swap'		  = tipo_swap

   ,	  /*047*/ 'Numero_Flujo'      = numero_flujo 
   ,      /*048*/ 'rut_cliente'       = rut_cliente
   FROM   CARTERA ca



          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente



		  INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Venta_Moneda



          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.Venta_codamo_interes



          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.Venta_codamo_capital



          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.Venta_codigo_tasa



   WHERE  numero_operacion            = @iNumeroSwap



   AND    tipo_flujo         = 2



   ORDER BY numero_operacion , tipo_flujo , numero_flujo

END
GO

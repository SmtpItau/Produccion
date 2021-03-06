USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES_FRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES_FRA]
   (   @iNumeroSwap   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT /*001*/'Tomador'        = CASE WHEN ca.tipo_operacion = 'P' THEN 'PRESTAMISTA'                          ELSE 'TOMADOR'                             END
   ,      /*002*/'Moneda'         = ca.compra_moneda
   ,      /*003*/'Nocionales'     = ca.compra_capital
   ,      /*004*/'Indicador'      = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_codigo_tasa                  ELSE cv.venta_codigo_tasa                  END
   ,      /*005*/'Tasa'           = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_valor_tasa                   ELSE cv.venta_valor_tasa                   END
   ,      /*006*/'ContraIndicador'= CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_codigo_tasa                   ELSE ca.compra_codigo_tasa                 END
   ,      /*007*/'ContraTasa'     = CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_valor_tasa                    ELSE ca.compra_valor_tasa                  END
   ,      /*008*/'ConteoDias'     = ca.compra_base
   ,      /*009*/'FechaEfectiva'  = ca.fecha_inicio
   ,      /*010*/'Dias'           = DATEDIFF(DAY,ca.fecha_inicio,ca.fecha_termino)
   ,      /*011*/'FechaMadurez'   = ca.fecha_termino
   ,      /*012*/'MonedaPago'     = ca.recibimos_moneda
   ,      /*013*/'DocumentoPago'  = ca.recibimos_documento
   ,      /*014*/'Modalidad'      = CASE WHEN ca.modalidad_pago = 'E' THEN 'ENTREGA FISICA'                       ELSE 'COMPENSACION'                         END

   ,      /*015*/'cVencimiento'   = CASE WHEN ca.tipo_operacion = 'P' THEN ca.fecha_vence_flujo                   ELSE cv.fecha_vence_flujo                   END
   ,      /*016*/'cAmortizacion'  = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_amortiza                     ELSE cv.venta_amortiza                      END
   ,      /*017*/'cTasaSpread'    = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_valor_tasa                   ELSE cv.venta_valor_tasa                    END
   ,      /*018*/'cInteres'       = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_interes                      ELSE cv.venta_interes                       END
   ,      /*019*/'cTotal'         = CASE WHEN ca.tipo_operacion = 'P' THEN ca.compra_amortiza + ca.compra_interes ELSE cv.venta_amortiza + cv.venta_interes   END
   ,      /*020*/'cLiquidacion'   = CASE WHEN ca.tipo_operacion = 'P' THEN ca.fecha_vence_flujo                   ELSE cv.fecha_vence_flujo                   END
   ,      /*021*/'cFechaReset'    = CASE WHEN ca.tipo_operacion = 'P' THEN ca.fecha_fijacion_tasa                 ELSE cv.fecha_fijacion_tasa                 END
   ,      /*022*/'cPagamosMonto'  = CASE WHEN ca.tipo_operacion = 'P' THEN ca.recibimos_monto                     ELSE cv.pagamos_monto                       END
   ,      /*023*/'cPagamosDolares'= CASE WHEN ca.tipo_operacion = 'P' THEN ca.recibimos_monto_USD                 ELSE cv.pagamos_monto_USD                   END
   ,      /*024*/'cPagamosPasos'  = CASE WHEN ca.tipo_operacion = 'P' THEN ca.recibimos_monto_CLP                 ELSE cv.pagamos_monto_CLP                   END
   ,      /*025*/'cFerFecResetCHI'= ca.FeriadoFlujoChile
   ,      /*026*/'cFerFecResetUSA'= ca.FeriadoFlujoEEUU
   ,      /*027*/'cFerFecResetENG'= ca.FeriadoFlujoEnglan
   ,      /*028*/'cFerFecLiquiCHI'= ca.FeriadoLiquiChile
   ,      /*029*/'cFerFecLiquiUSA'= ca.FeriadoLiquiEEUU   
   ,      /*030*/'cFerFecLiquiENG'= ca.FeriadoLiquiEnglan
   ,      /*031*/'cConvencion'    = ca.Convencion
   ,      /*032*/'cDiasReset'     = ca.DiasReset

   ,      /*033*/'vVencimiento'   = CASE WHEN ca.tipo_operacion = 'P' THEN cv.fecha_vence_flujo                   ELSE ca.fecha_vence_flujo                   END
   ,      /*034*/'vAmortizacion'  = CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_amortiza                      ELSE ca.compra_amortiza                     END
   ,      /*035*/'vTasaSpread'    = CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_valor_tasa                    ELSE ca.compra_valor_tasa                   END
   ,      /*036*/'vInteres'       = CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_interes                       ELSE ca.compra_interes                      END
   ,      /*037*/'vTotal'         = CASE WHEN ca.tipo_operacion = 'P' THEN cv.venta_amortiza + cv.venta_interes   ELSE ca.compra_amortiza + ca.compra_interes END
   ,      /*038*/'vLiquidacion'   = CASE WHEN ca.tipo_operacion = 'P' THEN cv.fecha_vence_flujo                   ELSE ca.fecha_vence_flujo                   END
   ,      /*039*/'vFechaReset'    = CASE WHEN ca.tipo_operacion = 'P' THEN cv.fecha_fijacion_tasa                 ELSE ca.fecha_fijacion_tasa                 END
   ,      /*040*/'vPagamosMonto'  = CASE WHEN ca.tipo_operacion = 'P' THEN cv.pagamos_monto                       ELSE ca.recibimos_monto                     END
   ,      /*041*/'vPagamosDolares'= CASE WHEN ca.tipo_operacion = 'P' THEN cv.pagamos_monto_USD                   ELSE ca.recibimos_monto_USD                 END
   ,      /*042*/'vPagamosPasos'  = CASE WHEN ca.tipo_operacion = 'P' THEN cv.pagamos_monto_CLP                   ELSE ca.recibimos_monto_CLP                 END
   ,      /*043*/'vFerFecResetCHI'= cv.FeriadoFlujoChile
   ,      /*044*/'vFerFecResetUSA'= cv.FeriadoFlujoEEUU
   ,      /*045*/'vFerFecResetENG'= cv.FeriadoFlujoEnglan
   ,      /*046*/'vFerFecLiquiCHI'= cv.FeriadoLiquiChile
   ,      /*047*/'vFerFecLiquiUSA'= cv.FeriadoLiquiEEUU
   ,      /*048*/'vFerFecLiquiENG'= cv.FeriadoLiquiEnglan
   ,      /*049*/'vConvencion'    = cv.Convencion
   ,      /*050*/'vDiasReset'     = cv.DiasReset

   ,      /*052*/'Liquidacion'    = cv.FechaLiquidacion
   ,      /*051*/'Liquidacion'    = ca.FechaLiquidacion

   ,      /*052*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),cl.clrut))) + '-' + cl.cldv
   ,      /*053*/ 'Nombre'            = cl.clnombre
   ,      /*054*/ 'CarteraFinanciera' = ca.cartera_inversion
   ,      /*055*/ 'AreaResponsable'   = ca.car_area_Responsable
   ,      /*056*/ 'LibroNegociacion'  = ca.car_Libro
   ,      /*057*/ 'CarteraNormativa'  = ca.car_Cartera_Normativa
   ,      /*058*/ 'SubCartera'        = ca.car_SubCartera_Normativa
   ,      /*059*/ 'CodigoCliente'     = ca.codigo_cliente
   FROM   CARTERA ca   
          INNER JOIN BacParamSuda..CLIENTE cl  ON cl.clrut            = ca.rut_cliente and cl.clcodigo = ca.codigo_cliente
          INNER JOIN CARTERA cv                ON cv.numero_operacion = ca.numero_operacion AND cv.Tipo_Flujo <> ca.Tipo_Flujo
   WHERE  ca.numero_operacion = @iNumeroSwap
   AND    ca.Tipo_Flujo       = 1
   ORDER BY ca.numero_operacion , ca.tipo_flujo , ca.numero_flujo

END
--GO
--EXECUTE dbo.SP_LEE_OPERACIONES_FRA 149

GO

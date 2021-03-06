USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES_MODIFICADAS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exec SP_LEE_OPERACIONES_MODIFICADAS_SWAP 10685, 1
CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES_MODIFICADAS_SWAP]
   (   @iNumeroSwap   NUMERIC(9)
   ,   @iTipFlujo     INTEGER
   )
AS

BEGIN
   SET NOCOUNT ON

/*-----------------------------------------------------------------------------*/
/* TABLA TEMPORAL DE COMPRAS                                                   */
/*-----------------------------------------------------------------------------*/

  CREATE TABLE #paso_flujos(
	    Origen					CHAR(1)			,
		Tikker 					CHAR(50)	    ,
		Modalidad				CHAR(15)	    ,
		CompraMoneda			NUMERIC(10)		,
		NemoCompraMoneda		CHAR(40)	    ,
		CompraCapital			NUMERIC(10)		,
		FrecuenciaPago			NUMERIC(10)		,
		FrecuenciaCapital 		NUMERIC(10)		,
		Indicador				NUMERIC(10)		,
		UltimoIndice            NUMERIC(10)		,
        Spread					NUMERIC(10)		,
		ConteoDias				NUMERIC(10)		,
		FechaEfectiva			CHAR(10)		,
		PrimerPago				CHAR(10)		,
		PenultimoPago			CHAR(10)		,
		Madurez					CHAR(10)		,
		MonedaPagamos			NUMERIC(10)		,
		DocumentoPagamos		NUMERIC(10)		,
		Note					CHAR(50)		,
		FeriadoFlujoChile		INT				,
		FeriadoFlujoEEUU		INT				,
		FeriadoFlujoEnglan		INT				,
		FeriadoLiquiChile		INT				,
		FeriadoLiquiEEUU		INT				,
		FeriadoLiquiEnglan		INT				,
		Vencimiento				CHAR(10)		,
		Amortizacion			NUMERIC(10,4)	,
		TasaSpread				NUMERIC(10,4)	,
		Interes					NUMERIC(10,4)	,
		Total					NUMERIC(10,4)	,
		FechaLiquidacion		CHAR(10)		,
		FechaReset				CHAR(10)		,
		recibimosmonto			NUMERIC(10,4)	,
		recibimosmontoUSD		NUMERIC(10,4)	,
		recibimosmontoCLP		NUMERIC(10,4)	,
		Convencion				VARCHAR(25)		,
		DiasReset				INT				,
		rut_cliente				CHAR(10)		,
		Nombre					CHAR(70)		,
		CarteraFinanciera		NUMERIC(2,0)	,
		AreaResponsable			CHAR(6)			,
		LibroNegociacion		char(6)			,
		CarteraNormativa		char(6)			,
		SubCartera				char(6)			,
		CodigoCliente			NUMERIC(9)		,
		tipo_swap				NUMERIC(1,0)	,
		Numero_Flujo			NUMERIC(3,0)	,
		Tipo_Flujo				NUMERIC(1,0)	,
		FechaFijacion			CHAR(10)		
	)	


IF @iTipFlujo = 1 BEGIN 
	/* RESCATO REGISTROS ORIGINALES */
   INSERT INTO #paso_flujos	
   SELECT /*000*/ 'Origen'			  = 'O'
   ,	  /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)
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
   ,      /*027*/ 'TasaSpread'       = compra_valor_tasa + compra_spread
   ,      /*028*/ 'Interes'           = compra_Interes
   ,      /*029*/ 'Total'             = compra_amortiza + compra_Interes
   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),FechaLiquidacion,103)
   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),FechaReset,103)
   ,      /*032*/ 'recibimosmonto'    = recibimos_monto
   ,      /*033*/ 'recibimosmontoUSD' = recibimos_monto_USD
   ,      /*034*/ 'recibimosmontoCLP' = recibimos_monto_CLP
   ,      /*035*/ 'Convencion'        = Convencion
   ,      /*036*/ 'DiasReset'         = DiasReset
   ,      /*037*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv
   ,      /*038*/ 'Nombre'            = cl.clnombre
   ,      /*039*/ 'CarteraFinanciera' = cartera_inversion
   ,      /*040*/ 'AreaResponsable'   = car_area_Responsable
   ,      /*041*/ 'LibroNegociacion'  = car_Libro
   ,      /*042*/ 'CarteraNormativa'  = car_Cartera_Normativa
   ,      /*043*/ 'SubCartera'        = car_SubCartera_Normativa
   ,      /*044*/ 'CodigoCliente'     = codigo_cliente
   ,	  /*045*/ 'tipo_swap'		  = tipo_swap
   ,	  /*046*/ 'Numero_Flujo'      = numero_flujo 
   ,	  /*047*/ 'Tipo_Flujo'		  = tipo_flujo	
   ,	  /*048*/ 'FechaFijacion'	  =  CONVERT(CHAR(10),fecha_fijacion_tasa,103)

   FROM   CarteraModificada ca
          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente
          INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Compra_Moneda
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.compra_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.compra_codamo_capital
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.compra_codigo_tasa
   WHERE  numero_operacion            = @iNumeroSwap
   AND    tipo_flujo                  = 1
   ORDER BY numero_operacion , tipo_flujo , numero_flujo
  

   /* RESCATO REGISTROS MODIFICADOS */
   INSERT INTO #paso_flujos	
   SELECT /*000*/ 'Origen'			  = 'M'
   ,	  /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)
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
   ,      /*027*/ 'TasaSpread'       = compra_valor_tasa + compra_spread
   ,      /*028*/ 'Interes'           = compra_Interes
   ,      /*029*/ 'Total'             = compra_amortiza + compra_Interes
   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),FechaLiquidacion,103)
   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),FechaReset,103)
   ,      /*032*/ 'recibimosmonto'    = recibimos_monto
   ,      /*033*/ 'recibimosmontoUSD' = recibimos_monto_USD
   ,      /*034*/ 'recibimosmontoCLP' = recibimos_monto_CLP
   ,      /*035*/ 'Convencion'        = Convencion
   ,      /*036*/ 'DiasReset'         = DiasReset
   ,      /*037*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv
   ,      /*038*/ 'Nombre'            = cl.clnombre
   ,      /*039*/ 'CarteraFinanciera' = cartera_inversion
   ,      /*040*/ 'AreaResponsable'   = car_area_Responsable
   ,      /*041*/ 'LibroNegociacion'  = car_Libro
   ,      /*042*/ 'CarteraNormativa'  = car_Cartera_Normativa
   ,      /*043*/ 'SubCartera'        = car_SubCartera_Normativa
   ,      /*044*/ 'CodigoCliente'     = codigo_cliente
   ,	  /*045*/ 'tipo_swap'		  = tipo_swap
   ,	  /*046*/ 'Numero_Flujo'      = numero_flujo 
   ,	  /*047*/ 'Tipo_Flujo'		  = tipo_flujo
   ,	  /*048*/ 'FechaFijacion'	  =  CONVERT(CHAR(10),fecha_fijacion_tasa,103)

   FROM   Cartera ca
          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente
          INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Compra_Moneda
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.compra_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.compra_codamo_capital
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.compra_codigo_tasa
   WHERE  numero_operacion            = @iNumeroSwap
   AND    tipo_flujo				= 1
   ORDER BY numero_operacion , tipo_flujo , numero_flujo

END
   
ELSE
	BEGIN 
	INSERT INTO #paso_flujos	
   SELECT /*000*/ 'Origen'			  = 'O'
   ,	  /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)
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
   ,      /*027*/ 'TasaSpread'       = ca.Venta_valor_tasa + ca.Venta_spread
   ,      /*028*/ 'Interes'           = ca.Venta_Interes
   ,      /*029*/ 'Total'             = ca.Venta_amortiza   + ca.Venta_Interes
   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),ca.FechaLiquidacion,103)
   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),ca.FechaReset,103)
   ,      /*032*/ 'recibimosmonto'    = ca.recibimos_monto
   ,      /*033*/ 'recibimosmontoUSD' = ca.recibimos_monto_USD
   ,      /*034*/ 'recibimosmontoCLP' = ca.recibimos_monto_CLP
   ,      /*035*/ 'Convencion'        = ca.Convencion
   ,      /*036*/ 'DiasReset'         = ca.DiasReset
   ,      /*037*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv
   ,      /*038*/ 'Nombre'            = cl.clnombre
   ,      /*039*/ 'CarteraFinanciera' = cartera_inversion
   ,      /*040*/ 'AreaResponsable'   = car_area_Responsable
   ,      /*041*/ 'LibroNegociacion'  = car_Libro
   ,      /*042*/ 'CarteraNormativa'  = car_Cartera_Normativa
   ,      /*043*/ 'SubCartera'        = car_SubCartera_Normativa
   ,      /*044*/ 'CodigoCliente'     = codigo_cliente
   ,	  /*045*/ 'tipo_swap'		  = tipo_swap
   ,	  /*046*/ 'Numero_Flujo'      = numero_flujo 
   ,	  /*047*/ 'Tipo_Flujo'		  = tipo_flujo	
   ,	  /*048*/ 'FechaFijacion'	  =  CONVERT(CHAR(10),fecha_fijacion_tasa,103)

   FROM   CarteraModificada ca
          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente
		  INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Venta_Moneda
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.Venta_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.Venta_codamo_capital
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.Venta_codigo_tasa
   WHERE  numero_operacion            = @iNumeroSwap
   AND    tipo_flujo         = 2
   ORDER BY numero_operacion , tipo_flujo , numero_flujo



   INSERT INTO #paso_flujos	
    SELECT /*000*/ 'Origen'			  = 'M'
   ,	  /*001*/ 'Tikker'            = CONVERT(VARCHAR(50),ca.Tikker)
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
   ,      /*027*/ 'TasaSpread'       = ca.Venta_valor_tasa + ca.Venta_spread
   ,      /*028*/ 'Interes'           = ca.Venta_Interes
   ,      /*029*/ 'Total'             = ca.Venta_amortiza   + ca.Venta_Interes
   ,      /*030*/ 'FechaLiquidacion'  = CONVERT(CHAR(10),ca.FechaLiquidacion,103)
   ,      /*031*/ 'FechaReset'        = CONVERT(CHAR(10),ca.FechaReset,103)
   ,      /*032*/ 'recibimosmonto'    = ca.recibimos_monto
   ,      /*033*/ 'recibimosmontoUSD' = ca.recibimos_monto_USD
   ,      /*034*/ 'recibimosmontoCLP' = ca.recibimos_monto_CLP
   ,      /*035*/ 'Convencion'        = ca.Convencion
   ,      /*036*/ 'DiasReset'         = ca.DiasReset
   ,      /*037*/ 'rut_cliente'       = LTRIM(RTRIM(CONVERT(CHAR(10),rut_cliente))) + '-' + cl.cldv
   ,      /*038*/ 'Nombre'            = cl.clnombre
   ,      /*039*/ 'CarteraFinanciera' = cartera_inversion
   ,      /*040*/ 'AreaResponsable'   = car_area_Responsable
   ,      /*041*/ 'LibroNegociacion'  = car_Libro
   ,      /*042*/ 'CarteraNormativa'  = car_Cartera_Normativa
   ,      /*043*/ 'SubCartera'        = car_SubCartera_Normativa
   ,      /*044*/ 'CodigoCliente'     = codigo_cliente
   ,	  /*045*/ 'tipo_swap'		  = tipo_swap
   ,	  /*046*/ 'Numero_Flujo'      = numero_flujo 
   ,	  /*047*/ 'Tipo_Flujo'		  = tipo_flujo	
   ,	  /*048*/ 'FechaFijacion'	  =  CONVERT(CHAR(10),fecha_fijacion_tasa,103)

   FROM   Cartera ca
          INNER JOIN BacParamSuda..CLIENTE              cl  ON cl.clrut    = rut_cliente and cl.clcodigo = codigo_cliente
		  INNER JOIN BacParamSuda..MONEDA               mi  ON mi.mncodmon = ca.Venta_Moneda
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  i  ON i.tabla     = 1044 and i.codigo     = ca.Venta_codamo_interes
          INNER JOIN BacParamSuda..PERIODO_AMORTIZACION  k  ON k.tabla     = 1043 and k.codigo     = ca.Venta_codamo_capital
          INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE ta ON ta.tbcateg  = 1042 and ta.tbcodigo1 = ca.Venta_codigo_tasa
   WHERE  numero_operacion            = @iNumeroSwap
   AND    tipo_flujo         = 2
   ORDER BY numero_operacion , tipo_flujo , numero_flujo

   END

   /*Origen,*/

	
	/* OBTENGO LOS REGISTROS DESDE TABLA TEMPORAL */
	SELECT   Numero_Flujo,Tipo_Flujo,
			CASE WHEN Origen = 'M' THEN 'Modificado' ELSE 'Original' END as Origen
		,Tikker,Modalidad,CompraMoneda,NemoCompraMoneda,CompraCapital,FrecuenciaPago,FrecuenciaCapital
		,Indicador,UltimoIndice,Spread,ConteoDias,FechaEfectiva,PrimerPago,PenultimoPago,Madurez,MonedaPagamos,DocumentoPagamos,Note
		,FeriadoFlujoChile,FeriadoFlujoEEUU,FeriadoFlujoEnglan,FeriadoLiquiChile,FeriadoLiquiEnglan,Vencimiento,Amortizacion
		,TasaSpread,Interes,Total,FechaLiquidacion,FechaReset,recibimosmonto,recibimosmontoUSD,recibimosmontoCLP,Convencion
		,DiasReset,rut_cliente,Nombre,CarteraFinanciera,AreaResponsable,LibroNegociacion,CarteraNormativa
		,SubCartera,CodigoCliente,tipo_swap,FechaFijacion
	
	FROM #paso_flujos  
	ORDER BY  numero_flujo ,Tipo_Flujo, Origen
	DROP TABLE #paso_flujos  

END
GO

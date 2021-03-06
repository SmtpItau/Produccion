USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACION_OPERACIONES_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABACION_OPERACIONES_SIM]
   (       @iModificacion             INTEGER = 1
   ,       @A01_NumeroOperacion       NUMERIC(9)
   ,       @A02_NumeroFlujo           INTEGER
   ,       @A03_TipoFlujo             INTEGER
   ,       @A04_TipoSwap              INTEGER
   ,       @A05_CarteraInversiones    INTEGER
   ,       @A06_TipoOperacion         CHAR(1)
   ,       @A07_RutCliente            NUMERIC(9)
   ,       @A08_CodCliente            INTEGER
   ,       @A09_Moneda                INTEGER
   ,       @A10_Nocionales            NUMERIC(21,5)
   ,       @A11_Amortizacion          NUMERIC(21,5)
   ,       @A12_Saldo                 NUMERIC(21,5)
   ,       @A13_Interes               NUMERIC(21,5)
   ,       @A14_Spread                NUMERIC(21,5)
   ,       @A15_Indicador             INTEGER
   ,       @A16_UltimoIndice          FLOAT
   ,       @A17_ConteoDias            INTEGER
   ,       @A18_FrecuenciaPago        INTEGER
   ,       @A19_FrecuenciaCapital     INTEGER
   ,       @A20_MonedaPago            INTEGER
   ,       @A21_MedioPago             INTEGER
   ,       @A22_MontoPago             NUMERIC(21,4)
   ,       @A23_MontoPagoCLP          NUMERIC(21,4)
   ,       @A24_MontoPagoUSD          NUMERIC(21,4)
   ,       @A25_ModalidadPago         CHAR(1)
   ,       @A26_FechaCierre           DATETIME
   ,       @A27_FechaEfectiva         DATETIME
   ,       @A28_FechaPrimerPago       DATETIME
   ,       @A29_FechaPenultimoPago    DATETIME
   ,       @A30_FechaMadurez          DATETIME
   ,       @A31_FechaInicioFlujo      DATETIME
   ,       @A32_FechaTerminoFlujo     DATETIME
   ,       @A33_Usuario               VARCHAR(15)
   ,       @A34_Observaciones         VARCHAR(50)
   ,       @A35_Lineas                VARCHAR(50)
   ,       @A36_Limites               VARCHAR(50)
   ,       @A37_AreaResponsable       VARCHAR(50)
   ,       @A38_CarteraNormativa      VARCHAR(50)
   ,       @A39_SubCarteraNormativa   VARCHAR(50)
   ,       @A40_LibroNegociacion      VARCHAR(50)
   ,       @A41_DiasReset             INTEGER
   ,       @A42_FechaFijaTasa         DATETIME

   ,       @A43_FeriadoFlujoChile     INTEGER
   ,       @A44_FeriadoFlujoEEUU      INTEGER
   ,       @A45_FeriadoFlujoEnglan    INTEGER
   ,       @A46_FeriadoLiquiChile     INTEGER
   ,       @A47_FeriadoLiquiEEUU      INTEGER
   ,       @A48_FeriadoLiquiEnglan    INTEGER
   ,       @A49_Convencion            CHAR(22)

   ,       @A50_Note                  VARCHAR(255)
   ,       @A51_IntercambioPrincipal  INTEGER
   ,       @A52_Tikker                VARCHAR(255)

   ,       @A53_FechaLiquidacion      DATETIME
   ,       @A54_FechaReset            DATETIME

   ,	   @A55_FxRate		      FLOAT
   ,	   @A56_PrcAmortiza           FLOAT
   ,	   @A57_FechaValuta           DATETIME	
   ,	   @A58_FlujoAdicional        FLOAT

  ,        @A65_Operador      VARCHAR(15)
  ,       @A99_Estado                CHAR(1)
  ,       @A59_Tasa_Transfer		NUMERIC(19,4) = 0
 ,       @A60_Spread_Transfer		NUMERIC(19,4) = 0
 ,       @A61_Res_Mesa_Dist_CLP	NUMERIC(21,0) = 0
 ,       @A62_Res_Mesa_Dist_USD	NUMERIC(21,4) = 0
,	   @A59_RefTipoCambio		INTEGER 	= 0
   ,	   @A60_RefParidad		INTEGER		= 0
   ,	   @A61_RefFchTipCambio		DATETIME	= ''
   ,	   @A62_RefFchParidad		DATETIME	= ''

   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @MesCapital   INTEGER
   ,       @MesInteres   INTEGER

  SELECT @MesCapital = 0,
	   @MesInteres = 0

   SELECT @MesCapital = ISNULL(meses,0)
   FROM   BacParamSuda..PERIODO_AMORTIZACION
   WHERE  sistema = 'PCS' AND tabla = 1043 AND codigo = @A19_FrecuenciaCapital

   SELECT @MesInteres = ISNULL(meses,0)
   FROM   BacParamSuda..PERIODO_AMORTIZACION
   WHERE  sistema = 'PCS' AND tabla = 1043 AND codigo = @A18_FrecuenciaPago

   IF @A99_Estado = '' and @iModificacion <> 1 AND @A03_TipoFlujo = 1 AND @A02_NumeroFlujo = 1
   BEGIN
      DELETE CARTERA_SIM   WHERE Numero_operacion = @A01_NumeroOperacion

      DELETE MOVDIARIO_SIM WHERE Numero_operacion = @A01_NumeroOperacion
   END


   INSERT INTO CARTERA_SIM
   (   /*001*/ numero_operacion
   ,   /*002*/ numero_flujo
   ,   /*003*/ tipo_flujo
   ,   /*004*/ tipo_swap
   ,   /*005*/ cartera_inversion
   ,   /*006*/ tipo_operacion
   ,   /*007*/ codigo_cliente
   ,   /*008*/ rut_cliente
   ,   /*009*/ fecha_cierre
   ,   /*010*/ fecha_inicio
   ,   /*011*/ fecha_termino
   ,   /*012*/ fecha_inicio_flujo
   ,   /*013*/ fecha_vence_flujo
   ,   /*014*/ fecha_fijacion_tasa
   ,   /*015*/ compra_moneda
   ,   /*016*/ compra_capital
   ,   /*017*/ compra_amortiza
   ,   /*018*/ compra_saldo
   ,   /*019*/ compra_interes
   ,   /*020*/ compra_spread
   ,   /*021*/ compra_codigo_tasa
   ,   /*022*/ compra_valor_tasa
   ,   /*023*/ compra_valor_tasa_hoy
   ,   /*024*/ compra_codamo_capital
   ,   /*025*/ compra_mesamo_capital
   ,   /*026*/ compra_codamo_interes
   ,   /*027*/ compra_mesamo_interes
   ,   /*028*/ compra_base
   ,   /*029*/ venta_moneda
   ,   /*030*/ venta_capital
   ,   /*031*/ venta_amortiza
   ,   /*032*/ venta_saldo
   ,   /*033*/ venta_interes
   ,   /*034*/ venta_spread
   ,   /*035*/ venta_codigo_tasa
   ,   /*036*/ venta_valor_tasa
   ,   /*037*/ venta_valor_tasa_hoy
   ,   /*038*/ venta_codamo_capital
   ,   /*039*/ venta_mesamo_capital
   ,   /*040*/ venta_codamo_interes
   ,   /*041*/ venta_mesamo_interes
   ,   /*042*/ venta_base
   ,   /*043*/ operador
   ,   /*044*/ operador_cliente
   ,   /*045*/ estado_flujo
   ,   /*046*/ modalidad_pago
   ,   /*047*/ pagamos_moneda
   ,   /*048*/ pagamos_documento
   ,   /*049*/ pagamos_monto
   ,   /*050*/ pagamos_monto_USD
   ,   /*051*/ pagamos_monto_CLP
   ,   /*052*/ recibimos_moneda
   ,   /*053*/ recibimos_documento
   ,   /*054*/ recibimos_monto
   ,   /*055*/ recibimos_monto_USD
   ,   /*056*/ recibimos_monto_CLP
   ,   /*057*/ observaciones
   ,   /*058*/ fecha_modifica
   ,   /*059*/ Estado_oper_lineas
   ,   /*060*/ Observacion_Lineas
   ,   /*061*/ Observacion_Limites
   ,   /*062*/ Especial
-- ,   /*063*/ SwImpresion
   ,   /*064*/ Hora
   ,   /*065*/ Tasa_Compra_Curva
   ,   /*066*/ Tasa_Venta_Curva
   ,   /*067*/ Monto_Spread
   ,   /*068*/ car_area_Responsable
   ,   /*069*/ car_Cartera_Normativa
   ,   /*070*/ car_SubCartera_Normativa
   ,   /*071*/ car_Libro
   ,   /*072*/ FeriadoFlujoChile
   ,   /*073*/ FeriadoFlujoEEUU
   ,   /*074*/ FeriadoFlujoEnglan
   ,   /*075*/ FeriadoLiquiChile
   ,   /*076*/ FeriadoLiquiEEUU
   ,   /*077*/ FeriadoLiquiEnglan
   ,   /*078*/ Convencion
   ,   /*079*/ DiasReset
   ,   /*080*/ FechaEfectiva
   ,   /*081*/ PrimerPago
   ,   /*082*/ PenultimoPago
   ,   /*083*/ Madurez
   ,   /*084*/ Note
   ,   /*085*/ IntercPrinc
   ,   /*086*/ Tikker
   ,   /*087*/ FechaLiquidacion
   ,   /*088*/ FechaReset
   ,   /*089*/ FxRate
   ,   /*090*/ Compra_Amortiza_Prc
   ,   /*091*/ Venta_Amortiza_Prc
   ,   /*092*/ FechaValuta
   ,   /*093*/ Compra_Flujo_Adicional
   ,   /*094*/ Venta_Flujo_Adicional
   ,   /*095*/ Compra_zcr
   ,   /*096*/ Venta_zcr
	--RQ3150 3ra Moneda
   ,   /*097*/ Ref_Tipo_Cambio
   ,   /*098*/ Ref_Paridad
   ,   /*099*/ Ref_Fecha_Fijacion_TC
   ,   /*100*/ Ref_Fecha_Fijacion_PAR
   )
   SELECT 
       /*001*/ 'numero_operacion'         = @A01_NumeroOperacion
   ,   /*002*/ 'numero_flujo'             = @A02_NumeroFlujo
   ,   /*003*/ 'tipo_flujo'               = @A03_TipoFlujo
   ,   /*004*/ 'tipo_swap'                = @A04_TipoSwap
   ,   /*005*/ 'cartera_inversion'        = @A05_CarteraInversiones
   ,   /*006*/ 'tipo_operacion'           = @A06_TipoOperacion
   ,   /*007*/ 'codigo_cliente'           = @A08_CodCliente
   ,   /*008*/ 'rut_cliente'              = @A07_RutCliente
   ,   /*009*/ 'fecha_cierre'             = @A26_FechaCierre
   ,   /*010*/ 'fecha_inicio'             = @A27_FechaEfectiva
   ,   /*011*/ 'fecha_termino'            = @A30_FechaMadurez
   ,   /*012*/ 'fecha_inicio_flujo'       = @A31_FechaInicioFlujo
   ,   /*013*/ 'fecha_vence_flujo'        = @A32_FechaTerminoFlujo
   ,   /*014*/ 'fecha_fijacion_tasa'      = @A42_FechaFijaTasa
   ,   /*015*/ 'compra_moneda'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A09_Moneda             ELSE 0   END
   ,   /*016*/ 'compra_capital'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*017*/ 'compra_amortiza'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*018*/ 'compra_saldo'             = CASE WHEN @A03_TipoFlujo = 1 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*019*/ 'compra_interes'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A13_Interes            ELSE 0.0 END
   ,   /*020*/ 'compra_spread'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A14_Spread             ELSE 0.0 END
   ,   /*021*/ 'compra_codigo_tasa'       = CASE WHEN @A03_TipoFlujo = 1 THEN @A15_Indicador          ELSE 0   END
   ,   /*022*/ 'compra_valor_tasa'        = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*023*/ 'compra_valor_tasa_hoy'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*024*/ 'compra_codamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*025*/ 'compra_mesamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesCapital             ELSE 0   END
   ,   /*026*/ 'compra_codamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*027*/ 'compra_mesamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesInteres             ELSE 0   END
   ,   /*028*/ 'compra_base'              = CASE WHEN @A03_TipoFlujo = 1 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*029*/ 'venta_moneda'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A09_Moneda             ELSE 0   END
   ,   /*030*/ 'venta_capital'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*031*/ 'venta_amortiza'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*032*/ 'venta_saldo'              = CASE WHEN @A03_TipoFlujo = 2 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*033*/ 'venta_interes'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A13_Interes            ELSE 0.0 END
   ,   /*034*/ 'venta_spread'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A14_Spread             ELSE 0.0 END
   ,   /*035*/ 'venta_codigo_tasa'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A15_Indicador          ELSE 0   END
   ,   /*036*/ 'venta_valor_tasa'         = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*037*/ 'venta_valor_tasa_hoy'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*038*/ 'venta_codamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*039*/ 'venta_mesamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*040*/ 'venta_codamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*041*/ 'venta_mesamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*042*/ 'venta_base'               = CASE WHEN @A03_TipoFlujo = 2 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*043*/ 'operador'                 = @A33_Usuario
   ,   /*044*/ 'operador_cliente'         = 0 --@A33_Usuario
   ,   /*045*/ 'estado_flujo'             = 0
   ,   /*046*/ 'modalidad_pago'           = @A25_ModalidadPago
   ,   /*047*/ 'pagamos_moneda'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*048*/ 'pagamos_documento'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A21_MedioPago          ELSE 0   END
   ,   /*049*/ 'pagamos_monto'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A22_MontoPago          ELSE 0.0 END
   ,   /*050*/ 'pagamos_monto_USD'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A24_MontoPagoUSD       ELSE 0.0 END
   ,   /*051*/ 'pagamos_monto_CLP'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*052*/ 'recibimos_moneda'         = CASE WHEN @A03_TipoFlujo = 1 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*053*/ 'recibimos_documento'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A21_MedioPago          ELSE 0   END
   ,   /*054*/ 'recibimos_monto'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A22_MontoPago          ELSE 0.0 END 
   ,   /*055*/ 'recibimos_monto_USD'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A24_MontoPagoUSD       ELSE 0.0 END 
   ,   /*056*/ 'recibimos_monto_CLP'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*057*/ 'observaciones'            = @A34_Observaciones
   ,   /*058*/ 'fecha_modifica'           = @A26_FechaCierre
   ,   /*059*/ 'Estado_oper_lineas'       = @A99_Estado --'P'
   ,   /*060*/ 'Observacion_Lineas'       = @A35_Lineas
   ,   /*061*/ 'Observacion_Limites'      = @A36_Limites
   ,   /*062*/ 'Especial'                 = 0
-- ,   /*063*/ 'SwImpresion'              = 0
   ,   /*064*/ 'Hora'                     = CONVERT(CHAR(10),GETDATE(),108)
   ,   /*065*/ 'ParidadCompra'            = 0.0
   ,   /*066*/ 'ParidadVenta'             = 0.0
   ,   /*067*/ 'Monto_Spread'             = 0.0
   ,   /*068*/ 'car_area_responsable'     = @A37_AreaResponsable
   ,   /*069*/ 'car_cartera_normativa'    = @A38_CarteraNormativa
   ,   /*070*/ 'car_subcartera_normativa' = @A39_SubCarteraNormativa
   ,   /*071*/ 'car_libro'                = @A40_LibroNegociacion
   ,   /*072*/ 'FeriadoFlujoChile'        = @A43_FeriadoFlujoChile
   ,   /*073*/ 'FeriadoFlujoEEUU'         = @A44_FeriadoFlujoEEUU
   ,   /*074*/ 'FeriadoFlujoEnglan'       = @A45_FeriadoFlujoEnglan
   ,   /*075*/ 'FeriadoLiquiChile'        = @A46_FeriadoLiquiChile
   ,   /*076*/ 'FeriadoLiquiEEUU'         = @A47_FeriadoLiquiEEUU
   ,   /*077*/ 'FeriadoLiquiEnglan'       = @A48_FeriadoLiquiEnglan
   ,   /*078*/ 'Convencion'               = @A49_Convencion
   ,   /*079*/ 'DiasReset'                = @A41_DiasReset
   ,   /*080*/ 'FechaEfectiva'            = @A27_FechaEfectiva
   ,   /*081*/ 'PrimerPago'               = @A28_FechaPrimerPago
   ,   /*082*/ 'PenultimoPago'            = @A29_FechaPenultimoPago
   ,   /*083*/ 'Madurez'                  = @A30_FechaMadurez
   ,   /*084*/ 'Note'                     = @A50_Note
   ,   /*085*/ 'IntercPrinc'              = @A51_IntercambioPrincipal
   ,   /*086*/ 'Tikker'                   = @A52_Tikker
   ,   /*087*/ 'FechaLiquidacion'         = @A53_FechaLiquidacion
   ,   /*088*/ 'FechaReset'               = @A54_FechaReset
   ,   /*089*/ 'FxRate'                   = @A55_FxRate
   ,   /*090*/ 'Compra_Amortiza_Prc'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A56_PrcAmortiza  ELSE 0.0 END
   ,   /*091*/ 'Venta_Amortiza_Prc'       = CASE WHEN @A03_TipoFlujo = 2 THEN @A56_PrcAmortiza  ELSE 0.0 END
   ,   /*092*/ 'FechaValuta'              = @A57_FechaValuta
   ,   /*093*/ 'Compra_Flujo_Adicional'   = CASE WHEN @A03_TipoFlujo = 1 THEN @A58_FlujoAdicional  ELSE 0.0 END
   ,   /*094*/ 'Venta_Flujo_Adicional'    = CASE WHEN @A03_TipoFlujo = 2 THEN @A58_FlujoAdicional  ELSE 0.0 END
   ,   /*095*/ 'Compra_zcr'               = CASE WHEN @A03_TipoFlujo = 1 THEN 
                                                                         Case when     @A26_FechaCierre >= @A42_FechaFijaTasa
                                                                                   and @A15_Indicador <> 0 then 1
                                                                              else 0 end
                                                                         ELSE 0 END 
   ,   /*096*/ 'Venta_zcr'    = CASE WHEN @A03_TipoFlujo = 2 THEN 
                                                                         Case when     @A26_FechaCierre >= @A42_FechaFijaTasa
                                                                                   and @A15_Indicador <> 0 then 1
                                                                              else 0 end
                                                                         ELSE 0 END
   ,   /*097*/ 'Ref_Tipo_Cambio'	  = @A59_RefTipoCambio
   ,   /*098*/ 'Ref_Paridad'		  = @A60_RefParidad
   ,   /*099*/ 'Ref_Fecha_Fijacion_TC'	  = @A61_RefFchTipCambio
   ,   /*100*/ 'Ref_Fecha_Fijacion_PAR'	  = @A62_RefFchParidad

   IF @@ERROR <> 0
   BEGIN
      SELECT -1 ,'Problemas en la Grabación del Registro en la Cartera Vigente.'
      RETURN
   END

   --> Inserta el registro en la Tabla de Movimientos del Día
   INSERT INTO MOVDIARIO_SIM
   (   /*001*/ numero_operacion
   ,   /*002*/ numero_flujo
   ,   /*003*/ tipo_flujo
   ,   /*004*/ tipo_swap
   ,   /*005*/ cartera_inversion
   ,   /*006*/ tipo_operacion
   ,   /*007*/ codigo_cliente
   ,   /*008*/ rut_cliente
   ,   /*009*/ fecha_cierre
   ,   /*010*/ fecha_inicio
   ,   /*011*/ fecha_termino
   ,   /*012*/ fecha_inicio_flujo
   ,   /*013*/ fecha_vence_flujo
   ,   /*014*/ fecha_fijacion_tasa
   ,   /*015*/ compra_moneda
   ,   /*016*/ compra_capital
   ,   /*017*/ compra_amortiza
   ,   /*018*/ compra_saldo
   ,   /*019*/ compra_interes
   ,   /*020*/ compra_spread
   ,   /*021*/ compra_codigo_tasa
   ,   /*022*/ compra_valor_tasa
   ,   /*023*/ compra_valor_tasa_hoy
   ,   /*024*/ compra_codamo_capital
   ,   /*025*/ compra_mesamo_capital
   ,   /*026*/ compra_codamo_interes
   ,   /*027*/ compra_mesamo_interes
   ,   /*028*/ compra_base
   ,   /*029*/ venta_moneda
   ,   /*030*/ venta_capital
   ,   /*031*/ venta_amortiza
   ,   /*032*/ venta_saldo
   ,   /*033*/ venta_interes
   ,   /*034*/ venta_spread
   ,   /*035*/ venta_codigo_tasa
   ,   /*036*/ venta_valor_tasa
   ,   /*037*/ venta_valor_tasa_hoy
   ,   /*038*/ venta_codamo_capital
   ,   /*039*/ venta_mesamo_capital
   ,   /*040*/ venta_codamo_interes
   ,   /*041*/ venta_mesamo_interes
   ,   /*042*/ venta_base
   ,   /*043*/ operador
   ,   /*044*/ operador_cliente
   ,   /*045*/ estado_flujo
   ,   /*046*/ modalidad_pago
   ,   /*047*/ pagamos_moneda
   ,   /*048*/ pagamos_documento
   ,   /*049*/ pagamos_monto
   ,   /*050*/ pagamos_monto_USD
   ,   /*051*/ pagamos_monto_CLP
   ,   /*052*/ recibimos_moneda
   ,   /*053*/ recibimos_documento
   ,   /*054*/ recibimos_monto
   ,   /*055*/ recibimos_monto_USD
   ,   /*056*/ recibimos_monto_CLP
   ,   /*057*/ observaciones
   ,   /*058*/ fecha_modifica
   ,   /*059*/ Estado_oper_lineas
   ,   /*060*/ Observacion_Lineas
   ,   /*061*/ Observacion_Limites
   ,   /*062*/ Especial
   ,   /*063*/ SwImpresion
   ,   /*064*/ Hora
   ,   /*065*/ ParidadCompra
   ,   /*066*/ ParidadVenta
   ,   /*067*/ Monto_Spread
   ,   /*068*/ mov_area_responsable
   ,   /*069*/ mov_cartera_normativa
   ,   /*070*/ mov_subcartera_normativa
   ,   /*071*/ mov_libro
   ,   /*072*/ FeriadoFlujoChile
   ,   /*073*/ FeriadoFlujoEEUU
   ,   /*074*/ FeriadoFlujoEnglan
   ,   /*075*/ FeriadoLiquiChile
   ,   /*076*/ FeriadoLiquiEEUU
   ,   /*077*/ FeriadoLiquiEnglan
   ,   /*078*/ Convencion
   ,   /*079*/ DiasReset
   ,   /*080*/ FechaEfectiva
   ,   /*081*/ PrimerPago
   ,   /*082*/ PenultimoPago
   ,   /*083*/ Madurez
   ,   /*084*/ Note
   ,   /*085*/ IntercPrinc
   ,   /*086*/ Tikker
   ,   /*087*/ FechaLiquidacion
   ,   /*088*/ FechaReset
   ,   /*089*/ Tasa_Transfer
   ,   /*090*/ Spread_Transfer
   ,   /*091*/ Res_Mesa_Dist_CLP
   ,   /*092*/ Res_Mesa_Dist_USD
  ,    /*093*/moDigitador	
   ,   /*094*/ Ref_Tipo_Cambio
   ,   /*095*/ Ref_Paridad
   ,   /*096*/ Ref_Fecha_Fijacion_TC
   ,   /*097*/ Ref_Fecha_Fijacion_PAR
   )
   SELECT 
       /*001*/ 'numero_operacion'         = @A01_NumeroOperacion
   ,   /*002*/ 'numero_flujo'             = @A02_NumeroFlujo
   ,   /*003*/ 'tipo_flujo'               = @A03_TipoFlujo
   ,   /*004*/ 'tipo_swap'                = @A04_TipoSwap
   ,   /*005*/ 'cartera_inversion'        = @A05_CarteraInversiones
   ,   /*006*/ 'tipo_operacion'           = @A06_TipoOperacion
   ,   /*007*/ 'codigo_cliente'           = @A08_CodCliente
   ,   /*008*/ 'rut_cliente'              = @A07_RutCliente
   ,   /*009*/ 'fecha_cierre'             = @A26_FechaCierre
   ,   /*010*/ 'fecha_inicio'             = @A27_FechaEfectiva
   ,   /*011*/ 'fecha_termino'            = @A30_FechaMadurez
   ,   /*012*/ 'fecha_inicio_flujo'       = @A31_FechaInicioFlujo
   ,   /*013*/ 'fecha_vence_flujo'        = @A32_FechaTerminoFlujo
   ,   /*014*/ 'fecha_fijacion_tasa'      = @A42_FechaFijaTasa
   ,   /*015*/ 'compra_moneda'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A09_Moneda             ELSE 0   END
   ,   /*016*/ 'compra_capital'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*017*/ 'compra_amortiza'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*018*/ 'compra_saldo'             = CASE WHEN @A03_TipoFlujo = 1 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*019*/ 'compra_interes'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A13_Interes            ELSE 0.0 END
   ,   /*020*/ 'compra_spread'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A14_Spread             ELSE 0.0 END
   ,   /*021*/ 'compra_codigo_tasa'       = CASE WHEN @A03_TipoFlujo = 1 THEN @A15_Indicador          ELSE 0   END
   ,   /*022*/ 'compra_valor_tasa'        = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*023*/ 'compra_valor_tasa_hoy'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*024*/ 'compra_codamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*025*/ 'compra_mesamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesCapital             ELSE 0   END
   ,   /*026*/ 'compra_codamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*027*/ 'compra_mesamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesInteres             ELSE 0   END
   ,   /*028*/ 'compra_base'              = CASE WHEN @A03_TipoFlujo = 1 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*029*/ 'venta_moneda'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A09_Moneda             ELSE 0   END
   ,   /*030*/ 'venta_capital'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*031*/ 'venta_amortiza'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*032*/ 'venta_saldo'              = CASE WHEN @A03_TipoFlujo = 2 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*033*/ 'venta_interes'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A13_Interes            ELSE 0.0 END
   ,   /*034*/ 'venta_spread'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A14_Spread             ELSE 0.0 END
   ,   /*035*/ 'venta_codigo_tasa'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A15_Indicador          ELSE 0   END
   ,   /*036*/ 'venta_valor_tasa'         = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*037*/ 'venta_valor_tasa_hoy'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*038*/ 'venta_codamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*039*/ 'venta_mesamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*040*/ 'venta_codamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*041*/ 'venta_mesamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*042*/ 'venta_base'               = CASE WHEN @A03_TipoFlujo = 2 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*043*/ 'operador'                 = @A33_Usuario
   ,   /*044*/ 'operador_cliente'         = 0
   ,   /*045*/ 'estado_flujo'             = 0
   ,   /*046*/ 'modalidad_pago'           = @A25_ModalidadPago
   ,   /*047*/ 'pagamos_moneda'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*048*/ 'pagamos_documento'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A21_MedioPago          ELSE 0   END
   ,   /*049*/ 'pagamos_monto'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A22_MontoPago          ELSE 0.0 END
   ,   /*050*/ 'pagamos_monto_USD'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A24_MontoPagoUSD       ELSE 0.0 END
   ,   /*051*/ 'pagamos_monto_CLP'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*052*/ 'recibimos_moneda'         = CASE WHEN @A03_TipoFlujo = 1 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*053*/ 'recibimos_documento'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A21_MedioPago          ELSE 0   END
   ,   /*054*/ 'recibimos_monto'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A22_MontoPago          ELSE 0.0 END 
   ,   /*055*/ 'recibimos_monto_USD'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A24_MontoPagoUSD       ELSE 0.0 END 
   ,   /*056*/ 'recibimos_monto_CLP'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*057*/ 'observaciones'            = @A34_Observaciones
   ,   /*058*/ 'fecha_modifica'           = @A26_FechaCierre
   ,   /*059*/ 'Estado_oper_lineas'       = @A99_Estado -- 'P'
   ,   /*060*/ 'Observacion_Lineas'       = @A35_Lineas
   ,   /*061*/ 'Observacion_Limites'      = @A36_Limites
   ,   /*062*/ 'Especial'                 = 0
   ,   /*063*/ 'SwImpresion'              = 0
   ,   /*064*/ 'Hora'                     = CONVERT(CHAR(10),GETDATE(),108)
   ,   /*065*/ 'ParidadCompra'            = 0.0
   ,   /*066*/ 'ParidadVenta'             = 0.0
   ,   /*067*/ 'Monto_Spread'             = 0.0
   ,   /*068*/ 'car_area_responsable'     = @A37_AreaResponsable
   ,   /*069*/ 'car_cartera_normativa'    = @A38_CarteraNormativa
   ,   /*070*/ 'car_subcartera_normativa' = @A39_SubCarteraNormativa
   ,   /*071*/ 'car_libro'                = @A40_LibroNegociacion
   ,   /*072*/ 'FeriadoFlujoChile'        = @A43_FeriadoFlujoChile
   ,   /*073*/ 'FeriadoFlujoEEUU'         = @A44_FeriadoFlujoEEUU
   ,   /*074*/ 'FeriadoFlujoEnglan'       = @A45_FeriadoFlujoEnglan
   ,   /*075*/ 'FeriadoLiquiChile'        = @A46_FeriadoLiquiChile
   ,   /*076*/ 'FeriadoLiquiEEUU'         = @A47_FeriadoLiquiEEUU
   ,   /*077*/ 'FeriadoLiquiEnglan'       = @A48_FeriadoLiquiEnglan
   ,   /*078*/ 'Convencion'               = @A49_Convencion
   ,   /*079*/ 'DiasReset'                = @A41_DiasReset
   ,   /*080*/ 'FechaEfectiva'            = @A27_FechaEfectiva
   ,   /*081*/ 'PrimerPago'               = @A28_FechaPrimerPago
   ,   /*082*/ 'PenultimoPago'            = @A29_FechaPenultimoPago
   ,   /*083*/ 'Madurez'                  = @A30_FechaMadurez
   ,   /*084*/ 'Note'                     = @A50_Note
   ,   /*085*/ 'IntercPrinc'              = @A51_IntercambioPrincipal
   ,   /*086*/ 'Tikker'                   = @A52_Tikker
   ,   /*087*/ 'FechaLiquidacion'         = @A53_FechaLiquidacion
   ,   /*088*/ 'FechaReset'               = @A54_FechaReset
   ,   /*089*/ 'Tasa_Transferencia'	  = @A59_Tasa_Transfer
   ,   /*090*/ 'Spread_Tranferencia'	  = @A60_Spread_Transfer
   ,   /*091*/ 'Res_Mesa_Dist_CLP'	  = @A61_Res_Mesa_Dist_CLP
   ,   /*092*/ 'Res_Mesa_Dist_USD'	  = @A62_Res_Mesa_Dist_USD
  ,    /*093*/ 'moDigitador' = @A65_Operador	---JBH, 22-12-2009
   ,   /*094*/ 'Ref_Tipo_Cambio'	  = @A59_RefTipoCambio
   ,   /*095*/ 'Ref_Paridad'		  = @A60_RefParidad
   ,   /*096*/ 'Ref_Fecha_Fijacion_TC'	  = @A61_RefFchTipCambio
   ,   /*097*/ 'Ref_Fecha_Fijacion_PAR'	  = @A62_RefFchParidad

   IF @@ERROR <> 0
   BEGIN
      SELECT -1 ,'Problemas en la Grabación del Registro en los Movimientos Diarios.'
      RETURN
   END

   IF @iModificacion <> 1
   BEGIN
      SELECT 0 , 'Registro Insertado Correctamente.'
      RETURN
   END

   --> Inserta el registro en la Tabla de Cartera Modificada
   INSERT INTO CARTERALOG_SIM
   (   /*001*/ numero_operacion
   ,   /*002*/ numero_flujo
   ,   /*003*/ tipo_flujo
   ,   /*004*/ tipo_swap
   ,   /*005*/ cartera_inversion
   ,   /*006*/ tipo_operacion
   ,   /*007*/ codigo_cliente
   ,   /*008*/ rut_cliente
   ,   /*009*/ fecha_cierre
   ,   /*010*/ fecha_inicio
   ,   /*011*/ fecha_termino
   ,   /*012*/ fecha_inicio_flujo
   ,   /*013*/ fecha_vence_flujo
-- ,   /*014*/ 
   ,   /*015*/ compra_moneda
   ,   /*016*/ compra_capital
   ,   /*017*/ compra_amortiza
   ,   /*018*/ compra_saldo
   ,   /*019*/ compra_interes
   ,   /*020*/ compra_spread
   ,   /*021*/ compra_codigo_tasa
   ,   /*022*/ compra_valor_tasa
   ,   /*023*/ compra_valor_tasa_hoy
   ,   /*024*/ compra_codamo_capital
   ,   /*025*/ compra_mesamo_capital
   ,   /*026*/ compra_codamo_interes
   ,   /*027*/ compra_mesamo_interes
   ,   /*028*/ compra_base
   ,   /*029*/ venta_moneda
   ,   /*030*/ venta_capital
   ,   /*031*/ venta_amortiza
   ,   /*032*/ venta_saldo
   ,   /*033*/ venta_interes
   ,   /*034*/ venta_spread
   ,   /*035*/ venta_codigo_tasa
   ,   /*036*/ venta_valor_tasa
   ,   /*037*/ venta_valor_tasa_hoy
   ,   /*038*/ venta_codamo_capital
   ,   /*039*/ venta_mesamo_capital
   ,   /*040*/ venta_codamo_interes
   ,   /*041*/ venta_mesamo_interes
   ,   /*042*/ venta_base
   ,   /*043*/ operador
   ,   /*044*/ operador_cliente
   ,   /*045*/ estado_flujo
   ,   /*046*/ modalidad_pago
   ,   /*047*/ pagamos_moneda
   ,   /*048*/ pagamos_documento
   ,   /*049*/ pagamos_monto
   ,   /*050*/ pagamos_monto_USD
   ,   /*051*/ pagamos_monto_CLP
   ,   /*052*/ recibimos_moneda
   ,   /*053*/ recibimos_documento
   ,   /*054*/ recibimos_monto
   ,   /*055*/ recibimos_monto_USD
   ,   /*056*/ recibimos_monto_CLP
   ,   /*057*/ observaciones
   ,   /*058*/ fecha_modifica
   ,   /*059*/ estado
-- ,   /*060*/ 
-- ,   /*061*/ 
-- ,   /*062*/ 
-- ,   /*063*/ 
   ,   /*064*/ Hora
-- ,   /*065*/ 
-- ,   /*066*/ 
-- ,   /*067*/ 
   ,   /*068*/ log_area_responsable
   ,   /*069*/ log_Cartera_Normativa
   ,   /*070*/ log_SubCartera_Normativa
   ,   /*071*/ log_Libro
   ,   /*072*/ FeriadoFlujoChile
   ,   /*073*/ FeriadoFlujoEEUU
   ,   /*074*/ FeriadoFlujoEnglan
   ,   /*075*/ FeriadoLiquiChile
   ,   /*076*/ FeriadoLiquiEEUU
   ,   /*077*/ FeriadoLiquiEnglan
   ,   /*078*/ Convencion
   ,   /*079*/ DiasReset
   ,   /*080*/ FechaEfectiva
   ,   /*081*/ PrimerPago
   ,   /*082*/ PenultimoPago
   ,   /*083*/ Madurez
   ,   /*084*/ Note
   ,   /*085*/ IntercPrinc
   ,   /*086*/ Tikker
   ,   /*087*/ FechaLiquidacion
   ,   /*088*/ FechaReset
   ,   /*089*/ FxRate
   ,   /*090*/ Compra_Amortiza_Prc
   ,   /*091*/ Venta_Amortiza_Prc
   ,   /*092*/ FechaValuta
   ,   /*093*/ Compra_Flujo_Adicional
   ,   /*094*/ Venta_Flujo_Adicional
   ,   /*095*/ Ref_Tipo_Cambio
   ,   /*096*/ Ref_Paridad
   ,   /*097*/ Ref_Fecha_Fijacion_TC
   ,   /*098*/ Ref_Fecha_Fijacion_PAR
   )
   SELECT 
       /*001*/ 'numero_operacion'         = @A01_NumeroOperacion
   ,   /*002*/ 'numero_flujo'             = @A02_NumeroFlujo
   ,   /*003*/ 'tipo_flujo'               = @A03_TipoFlujo
   ,   /*004*/ 'tipo_swap'                = @A04_TipoSwap
   ,   /*005*/ 'cartera_inversion'        = @A05_CarteraInversiones
   ,   /*006*/ 'tipo_operacion'           = @A06_TipoOperacion
   ,   /*007*/ 'codigo_cliente'           = @A08_CodCliente
   ,   /*008*/ 'rut_cliente'              = @A07_RutCliente
   ,   /*009*/ 'fecha_cierre'             = @A26_FechaCierre
   ,   /*010*/ 'fecha_inicio'             = @A27_FechaEfectiva
   ,   /*011*/ 'fecha_termino'            = @A30_FechaMadurez
   ,   /*012*/ 'fecha_inicio_flujo'       = @A31_FechaInicioFlujo
   ,   /*013*/ 'fecha_vence_flujo'        = @A32_FechaTerminoFlujo
-- ,   /*014*/ 'fecha_fijacion_tasa'      = @A42_FechaFijaTasa
   ,   /*015*/ 'compra_moneda'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A09_Moneda             ELSE 0   END
   ,   /*016*/ 'compra_capital'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*017*/ 'compra_amortiza'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*018*/ 'compra_saldo'             = CASE WHEN @A03_TipoFlujo = 1 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*019*/ 'compra_interes'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A13_Interes            ELSE 0.0 END
   ,   /*020*/ 'compra_spread'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A14_Spread             ELSE 0.0 END
   ,   /*021*/ 'compra_codigo_tasa'       = CASE WHEN @A03_TipoFlujo = 1 THEN @A15_Indicador          ELSE 0   END
   ,   /*022*/ 'compra_valor_tasa'        = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*023*/ 'compra_valor_tasa_hoy'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*024*/ 'compra_codamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*025*/ 'compra_mesamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesCapital             ELSE 0   END
   ,   /*026*/ 'compra_codamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*027*/ 'compra_mesamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesInteres             ELSE 0   END
   ,   /*028*/ 'compra_base'              = CASE WHEN @A03_TipoFlujo = 1 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*029*/ 'venta_moneda'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A09_Moneda             ELSE 0   END
   ,   /*030*/ 'venta_capital'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A10_Nocionales         ELSE 0.0 END
   ,   /*031*/ 'venta_amortiza'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A11_Amortizacion       ELSE 0.0 END
   ,   /*032*/ 'venta_saldo'              = CASE WHEN @A03_TipoFlujo = 2 THEN @A12_Saldo              ELSE 0.0 END
   ,   /*033*/ 'venta_interes'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A13_Interes            ELSE 0.0 END
   ,   /*034*/ 'venta_spread'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A14_Spread             ELSE 0.0 END
   ,   /*035*/ 'venta_codigo_tasa'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A15_Indicador          ELSE 0   END
   ,   /*036*/ 'venta_valor_tasa'         = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*037*/ 'venta_valor_tasa_hoy'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
   ,   /*038*/ 'venta_codamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A19_FrecuenciaCapital  ELSE 0   END
   ,   /*039*/ 'venta_mesamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*040*/ 'venta_codamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A18_FrecuenciaPago     ELSE 0   END
   ,   /*041*/ 'venta_mesamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
   ,   /*042*/ 'venta_base'               = CASE WHEN @A03_TipoFlujo = 2 THEN @A17_ConteoDias         ELSE 0   END
   ,   /*043*/ 'operador'                 = @A33_Usuario
   ,   /*044*/ 'operador_cliente'         = 0
   ,   /*045*/ 'estado_flujo'             = 0
   ,   /*046*/ 'modalidad_pago'           = @A25_ModalidadPago
   ,   /*047*/ 'pagamos_moneda'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*048*/ 'pagamos_documento'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A21_MedioPago          ELSE 0   END
   ,   /*049*/ 'pagamos_monto'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A22_MontoPago          ELSE 0.0 END
   ,  /*050*/ 'pagamos_monto_USD'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A24_MontoPagoUSD       ELSE 0.0 END
   ,   /*051*/ 'pagamos_monto_CLP'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*052*/ 'recibimos_moneda'         = CASE WHEN @A03_TipoFlujo = 1 THEN @A20_MonedaPago         ELSE 0   END
   ,   /*053*/ 'recibimos_documento'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A21_MedioPago          ELSE 0   END
   ,   /*054*/ 'recibimos_monto'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A22_MontoPago          ELSE 0.0 END 
   ,   /*055*/ 'recibimos_monto_USD'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A24_MontoPagoUSD       ELSE 0.0 END 
   ,   /*056*/ 'recibimos_monto_CLP'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A23_MontoPagoCLP       ELSE 0.0 END
   ,   /*057*/ 'observaciones'            = @A34_Observaciones
   ,   /*058*/ 'fecha_modifica'           = @A26_FechaCierre
   ,   /*059*/ 'Estado_oper_lineas'       = @A99_Estado -- 'P'
-- ,   /*060*/ 'Observacion_Lineas'       = @A35_Lineas
-- ,   /*061*/ 'Observacion_Limites'      = @A36_Limites
-- ,   /*062*/ 'Especial'                 = 0
-- ,   /*063*/ 'SwImpresion'              = 0
   ,   /*064*/ 'Hora'                     = CONVERT(CHAR(10),GETDATE(),108)
-- ,   /*065*/ 'ParidadCompra'            = 0.0
-- ,   /*066*/ 'ParidadVenta'             = 0.0
-- ,   /*067*/ 'Monto_Spread'             = 0.0
   ,   /*068*/ 'car_area_responsable'     = @A37_AreaResponsable
   ,   /*069*/ 'car_cartera_normativa'    = @A38_CarteraNormativa
   ,   /*070*/ 'car_subcartera_normativa' = @A39_SubCarteraNormativa
   ,   /*071*/ 'car_libro'                = @A40_LibroNegociacion
   ,   /*072*/ 'FeriadoFlujoChile'        = @A43_FeriadoFlujoChile
   ,   /*073*/ 'FeriadoFlujoEEUU'         = @A44_FeriadoFlujoEEUU
   ,   /*074*/ 'FeriadoFlujoEnglan'       = @A45_FeriadoFlujoEnglan
   ,   /*075*/ 'FeriadoLiquiChile'        = @A46_FeriadoLiquiChile
   ,   /*076*/ 'FeriadoLiquiEEUU'         = @A47_FeriadoLiquiEEUU
   ,   /*077*/ 'FeriadoLiquiEnglan'       = @A48_FeriadoLiquiEnglan
   ,   /*078*/ 'Convencion'               = @A49_Convencion
   ,   /*079*/ 'DiasReset'                = @A41_DiasReset
   ,   /*080*/ 'FechaEfectiva'            = @A27_FechaEfectiva
   ,   /*081*/ 'PrimerPago'               = @A28_FechaPrimerPago
   ,   /*082*/ 'PenultimoPago'            = @A29_FechaPenultimoPago
   ,   /*083*/ 'Madurez'                  = @A30_FechaMadurez
   ,   /*084*/ 'Note'                     = @A50_Note
   ,   /*085*/ 'IntercPrinc'              = @A51_IntercambioPrincipal
   ,   /*086*/ 'Tikker'                   = @A52_Tikker
   ,   /*087*/ 'FechaLiquidacion'         = @A53_FechaLiquidacion
   ,   /*088*/ 'FechaReset'               = @A54_FechaReset
   ,   /*089*/ 'FxRate'                   = @A55_FxRate
   ,   /*090*/ 'Compra_Amortiza_Prc'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A56_PrcAmortiza  ELSE 0.0 END
   ,   /*091*/ 'Venta_Amortiza_Prc'       = CASE WHEN @A03_TipoFlujo = 2 THEN @A56_PrcAmortiza  ELSE 0.0 END
   ,   /*092*/ 'FechaValuta'              = @A57_FechaValuta
   ,   /*093*/ 'Compra_Flujo_Adicional'   = CASE WHEN @A03_TipoFlujo = 1 THEN @A58_FlujoAdicional  ELSE 0.0 END
   ,   /*094*/ 'Venta_Flujo_Adicional'    = CASE WHEN @A03_TipoFlujo = 2 THEN @A58_FlujoAdicional  ELSE 0.0 END
   ,   /*095*/ 'Ref_Tipo_Cambio'	  = @A59_RefTipoCambio
   ,   /*096*/ 'Ref_Paridad'		  = @A60_RefParidad
   ,   /*097*/ 'Ref_Fecha_Fijacion_TC'	  = @A61_RefFchTipCambio
   ,   /*098*/ 'Ref_Fecha_Fijacion_PAR'	  = @A62_RefFchParidad

   IF @@ERROR <> 0
   BEGIN
      SELECT -1 ,'Problemas en la Grabación del Registro en la Cartera Modificada.'
      RETURN
   END

   SELECT 0 , 'Grabación del Registro Ha Finalizado en Forma Correcta.'

END

GO

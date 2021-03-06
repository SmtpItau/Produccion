USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACION_TICKET_FLUJOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABACION_TICKET_FLUJOS]
        ( @A01_NumeroOperacion       NUMERIC(9)	
	, @A02_NumeroFlujo           INTEGER
	, @A03_TipoFlujo             INTEGER
	, @A04_TipoSwap              INTEGER
	, @A06_TipoOperacion         CHAR(1)
	, @A09_Moneda                INTEGER
	, @A10_Nocionales            NUMERIC(21,5)
	, @A11_Amortizacion          NUMERIC(21,5)
	, @A12_Saldo                 NUMERIC(21,5)
	, @A13_Interes               NUMERIC(21,5)
	, @A14_Spread                NUMERIC(21,5)
	, @A15_Indicador             INTEGER
	, @A16_UltimoIndice          FLOAT
	, @A17_ConteoDias            INTEGER
	, @A18_FrecuenciaPago        INTEGER
	, @A19_FrecuenciaCapital     INTEGER
	, @A20_MonedaPago            INTEGER
	, @A21_MedioPago             INTEGER
	, @A22_MontoPago             NUMERIC(21,4)
	, @A23_MontoPagoCLP          NUMERIC(21,4)
	, @A24_MontoPagoUSD          NUMERIC(21,4)
	, @A25_ModalidadPago         CHAR(1)			
	, @A26_FechaCierre           DATETIME			
	, @A27_FechaEfectiva         DATETIME			
	, @A28_FechaPrimerPago       DATETIME			
	, @A29_FechaPenultimoPago    DATETIME			
	, @A30_FechaMadurez          DATETIME			
	, @A31_FechaInicioFlujo      DATETIME			
	, @A32_FechaTerminoFlujo     DATETIME			
	, @A33_Usuario               VARCHAR(15)			
	, @A34_Observaciones         VARCHAR(50)			
	, @A41_DiasReset             INTEGER			
	, @A42_FechaFijaTasa         DATETIME			
	, @A43_FeriadoFlujoChile     INTEGER			
	, @A44_FeriadoFlujoEEUU      INTEGER			
	, @A45_FeriadoFlujoEnglan    INTEGER			
	, @A46_FeriadoLiquiChile     INTEGER			
	, @A47_FeriadoLiquiEEUU      INTEGER			
	, @A48_FeriadoLiquiEnglan    INTEGER			
	, @A49_Convencion            CHAR(22)			
	, @A50_Note                  VARCHAR(255)			
	, @A51_IntercambioPrincipal  INTEGER			
	, @A52_Tikker                VARCHAR(255)			
	, @A53_FechaLiquidacion      DATETIME
	, @A54_FechaReset            DATETIME
	, @A55_FxRate		     FLOAT
	, @A56_PrcAmortiza           FLOAT
	, @A57_FechaValuta           DATETIME
	, @A58_FlujoAdicional        FLOAT
	, @A99_Estado                CHAR(1)
        )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	  @MesCapital   INTEGER
		, @MesInteres   INTEGER
		, @numOpRela	numeric(9,0)

	SELECT	@MesCapital = ISNULL(meses,0)
	FROM	BacParamSuda..PERIODO_AMORTIZACION
	WHERE	sistema = 'PCS' AND tabla = 1043 AND codigo = @A19_FrecuenciaCapital

	SELECT @MesInteres = ISNULL(meses,0)
	FROM   BacParamSuda..PERIODO_AMORTIZACION
	WHERE  sistema = 'PCS' AND tabla = 1043 AND codigo = @A18_FrecuenciaPago

	select	@numOpRela = AcTicketMesa
	from	SwapGeneral



	INSERT INTO TBL_FLJTICKETSWAP(
			 numero_operacion
			,numero_operacion_relacional
			, numero_flujo
			, tipo_flujo
			, tipo_swap
			, tipo_operacion
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
			, observaciones
			, Hora
			, Tasa_Compra_Curva
			, Tasa_Venta_Curva
			, Monto_Spread
			, FeriadoFlujoChile
			, FeriadoFlujoEEUU
			, FeriadoFlujoEnglan
			, FeriadoLiquiChile
			, FeriadoLiquiEEUU
			, FeriadoLiquiEnglan
			, DiasReset
			, FechaEfectiva
			, FechaPrimerPago
			, FechaPenultimoPago
			, FechaMadurez
			, FechaLiquidacion
			, FechaReset
			, FxRate
			, Compra_amortiza_Prc
			, Venta_amortiza_Prc
			, FechaValuta
			, Compra_Flujo_Adicional
			, Venta_Flujo_Adicional
			, compra_zcr
			, venta_zcr   )


		SELECT	  'numero_operacion'         = @A01_NumeroOperacion
		     , 'numero_operacion_relacional' = 0
			, 'numero_flujo'             = @A02_NumeroFlujo
			, 'tipo_flujo'               = @A03_TipoFlujo
			, 'tipo_swap'                = @A04_TipoSwap
			, 'tipo_operacion'           = @A06_TipoOperacion
			, 'fecha_cierre'             = @A26_FechaCierre
			, 'fecha_inicio'             = @A27_FechaEfectiva
			, 'fecha_termino'            = @A30_FechaMadurez
			, 'fecha_inicio_flujo'       = @A31_FechaInicioFlujo
			, 'fecha_vence_flujo'        = @A32_FechaTerminoFlujo
			, 'fecha_fijacion_tasa'      = @A42_FechaFijaTasa

			, 'compra_moneda'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A09_Moneda             ELSE 0   END
			, 'compra_capital'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A10_Nocionales         ELSE 0.0 END
			, 'compra_amortiza'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A11_Amortizacion       ELSE 0.0 END
			, 'compra_saldo'             = CASE WHEN @A03_TipoFlujo = 1 THEN @A12_Saldo              ELSE 0.0 END
			, 'compra_interes'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A13_Interes            ELSE 0.0 END
			, 'compra_spread'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A14_Spread             ELSE 0.0 END
			, 'compra_codigo_tasa'       = CASE WHEN @A03_TipoFlujo = 1 THEN @A15_Indicador          ELSE 0   END
			, 'compra_valor_tasa'        = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'compra_valor_tasa_hoy'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'compra_codamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A19_FrecuenciaCapital  ELSE 0   END
			, 'compra_mesamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesCapital             ELSE 0   END
			, 'compra_codamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A18_FrecuenciaPago     ELSE 0   END
			, 'compra_mesamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesInteres             ELSE 0   END
			, 'compra_base'              = CASE WHEN @A03_TipoFlujo = 1 THEN @A17_ConteoDias         ELSE 0   END

			, 'venta_moneda'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A09_Moneda             ELSE 0   END
			, 'venta_capital'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A10_Nocionales         ELSE 0.0 END
			, 'venta_amortiza'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A11_Amortizacion       ELSE 0.0 END
			, 'venta_saldo'              = CASE WHEN @A03_TipoFlujo = 2 THEN @A12_Saldo              ELSE 0.0 END
			, 'venta_interes'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A13_Interes            ELSE 0.0 END
			, 'venta_spread'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A14_Spread             ELSE 0.0 END
			, 'venta_codigo_tasa'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A15_Indicador          ELSE 0   END
			, 'venta_valor_tasa'         = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'venta_valor_tasa_hoy'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'venta_codamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A19_FrecuenciaCapital  ELSE 0   END
			, 'venta_mesamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
			, 'venta_codamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A18_FrecuenciaPago     ELSE 0   END
			, 'venta_mesamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
			, 'venta_base'               = CASE WHEN @A03_TipoFlujo = 2 THEN @A17_ConteoDias         ELSE 0   END

			, 'operador'                 = @A33_Usuario
			, 'operador_cliente'         = 0 --@A33_Usuario
			, 'estado_flujo'             = 0
			, 'modalidad_pago'           = @A25_ModalidadPago
			, 'observaciones'            = @A34_Observaciones
			, 'Hora'                     = CONVERT(CHAR(10),GETDATE(),108)
			, 0.00
			, 0.00
			, 'Monto_Spread'             = 0.0
			, 'FeriadoFlujoChile'        = @A43_FeriadoFlujoChile
			, /*073*/ 'FeriadoFlujoEEUU'         = @A44_FeriadoFlujoEEUU
			, /*074*/ 'FeriadoFlujoEnglan'       = @A45_FeriadoFlujoEnglan
			, /*075*/ 'FeriadoLiquiChile'        = @A46_FeriadoLiquiChile
			, /*076*/ 'FeriadoLiquiEEUU'         = @A47_FeriadoLiquiEEUU
			, /*077*/ 'FeriadoLiquiEnglan'       = @A48_FeriadoLiquiEnglan
			, /*079*/ 'DiasReset'                = @A41_DiasReset
			, /*080*/ 'FechaEfectiva'            = @A27_FechaEfectiva
			, /*081*/ 'PrimerPago'               = @A28_FechaPrimerPago
			, /*082*/ 'PenultimoPago'            = @A29_FechaPenultimoPago
			, /*083*/ 'Madurez'                  = @A30_FechaMadurez
			, /*087*/ 'FechaLiquidacion'         = @A53_FechaLiquidacion
			, /*088*/ 'FechaReset'               = @A54_FechaReset
			, /*089*/ 'FxRate'                   = @A55_FxRate
			, /*090*/ 'Compra_Amortiza_Prc'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A56_PrcAmortiza  ELSE 0.0 END
			, /*091*/ 'Venta_Amortiza_Prc'       = CASE WHEN @A03_TipoFlujo = 2 THEN @A56_PrcAmortiza  ELSE 0.0 END
			, /*092*/ 'FechaValuta'              = @A57_FechaValuta
			, /*093*/ 'Compra_Flujo_Adicional'   = CASE WHEN @A03_TipoFlujo = 1 THEN @A58_FlujoAdicional  ELSE 0.0 END
			, /*094*/ 'Venta_Flujo_Adicional'    = CASE WHEN @A03_TipoFlujo = 2 THEN @A58_FlujoAdicional  ELSE 0.0 END
			, /*095*/ 'Compra_zcr'               = CASE WHEN @A03_TipoFlujo = 1 THEN 
									CASE WHEN @A26_FechaCierre >= @A42_FechaFijaTasa
										AND @A15_Indicador <> 0 then 1
                                                                        ELSE 0 END
                                                               ELSE 0 END 
			, /*096*/ 'Venta_zcr'                = CASE WHEN @A03_TipoFlujo = 2 THEN 
									CASE WHEN @A26_FechaCierre >= @A42_FechaFijaTasa
                                                                        	AND  @A15_Indicador <> 0 then 1
                                                                         ELSE 0 END
                                                               ELSE 0 END
--operacion espejo

      SET @A03_TipoFlujo = CASE WHEN @A03_TipoFlujo = 1 THEN 2 ELSE 1 END

	INSERT INTO TBL_FLJTICKETSWAP(
				 numero_operacion
				,numero_operacion_relacional
				, numero_flujo
				, tipo_flujo
				, tipo_swap
				, tipo_operacion
				, fecha_cierre
				, fecha_inicio
				, fecha_termino
				, fecha_inicio_flujo
				, fecha_vence_flujo
				, fecha_fijacion_tasa

                                --> ...cuack... estaban cambiados los campos.
				, compra_moneda
				, compra_capital
				, compra_amortiza
				, compra_saldo				, compra_interes
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
				, observaciones
				, Hora
				, Tasa_Compra_Curva
				, Tasa_Venta_Curva
				, Monto_Spread
				, FeriadoFlujoChile
				, FeriadoFlujoEEUU
				, FeriadoFlujoEnglan
				, FeriadoLiquiChile
				, FeriadoLiquiEEUU
				, FeriadoLiquiEnglan
				, DiasReset
				, FechaEfectiva
				, FechaPrimerPago
				, FechaPenultimoPago
				, FechaMadurez
				, FechaLiquidacion
				, FechaReset
				, FxRate
				, Compra_amortiza_Prc
				, Venta_amortiza_Prc
				, FechaValuta
				, Compra_Flujo_Adicional
				, Venta_Flujo_Adicional
				, venta_zcr
				, compra_zcr)
		SELECT	  'numero_operacion'         = @numOpRela
			, 'numero_operacion_relacional' = @A01_NumeroOperacion
			, 'numero_flujo'             = @A02_NumeroFlujo
			, 'tipo_flujo'               = @A03_TipoFlujo
			, 'tipo_swap'                = @A04_TipoSwap
			, 'tipo_operacion'           = @A06_TipoOperacion
			, 'fecha_cierre'             = @A26_FechaCierre
			, 'fecha_inicio'             = @A27_FechaEfectiva
			, 'fecha_termino'            = @A30_FechaMadurez
			, 'fecha_inicio_flujo'       = @A31_FechaInicioFlujo
			, 'fecha_vence_flujo'        = @A32_FechaTerminoFlujo
			, 'fecha_fijacion_tasa'      = @A42_FechaFijaTasa

			, 'compra_moneda'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A09_Moneda             ELSE 0   END
			, 'compra_capital'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A10_Nocionales         ELSE 0.0 END
			, 'compra_amortiza'          = CASE WHEN @A03_TipoFlujo = 1 THEN @A11_Amortizacion       ELSE 0.0 END
			, 'compra_saldo'             = CASE WHEN @A03_TipoFlujo = 1 THEN @A12_Saldo              ELSE 0.0 END
			, 'compra_interes'           = CASE WHEN @A03_TipoFlujo = 1 THEN @A13_Interes            ELSE 0.0 END
			, 'compra_spread'            = CASE WHEN @A03_TipoFlujo = 1 THEN @A14_Spread             ELSE 0.0 END
			, 'compra_codigo_tasa'       = CASE WHEN @A03_TipoFlujo = 1 THEN @A15_Indicador          ELSE 0   END
			, 'compra_valor_tasa'        = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'compra_valor_tasa_hoy'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'compra_codamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A19_FrecuenciaCapital  ELSE 0   END
			, 'compra_mesamo_capital'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesCapital             ELSE 0   END
			, 'compra_codamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @A18_FrecuenciaPago     ELSE 0   END
			, 'compra_mesamo_interes'    = CASE WHEN @A03_TipoFlujo = 1 THEN @MesInteres             ELSE 0   END
			, 'compra_base'              = CASE WHEN @A03_TipoFlujo = 1 THEN @A17_ConteoDias         ELSE 0   END

			, 'venta_moneda'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A09_Moneda             ELSE 0   END
			, 'venta_capital'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A10_Nocionales         ELSE 0.0 END
			, 'venta_amortiza'           = CASE WHEN @A03_TipoFlujo = 2 THEN @A11_Amortizacion       ELSE 0.0 END
			, 'venta_saldo'              = CASE WHEN @A03_TipoFlujo = 2 THEN @A12_Saldo              ELSE 0.0 END
			, 'venta_interes'            = CASE WHEN @A03_TipoFlujo = 2 THEN @A13_Interes            ELSE 0.0 END
			, 'venta_spread'             = CASE WHEN @A03_TipoFlujo = 2 THEN @A14_Spread             ELSE 0.0 END
			, 'venta_codigo_tasa'        = CASE WHEN @A03_TipoFlujo = 2 THEN @A15_Indicador          ELSE 0   END
			, 'venta_valor_tasa'         = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'venta_valor_tasa_hoy'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A16_UltimoIndice       ELSE 0.0 END
			, 'venta_codamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A19_FrecuenciaCapital  ELSE 0   END
			, 'venta_mesamo_capital'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
			, 'venta_codamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN @A18_FrecuenciaPago     ELSE 0   END
			, 'venta_mesamo_interes'     = CASE WHEN @A03_TipoFlujo = 2 THEN 0                       ELSE 0   END
			, 'venta_base'               = CASE WHEN @A03_TipoFlujo = 2 THEN @A17_ConteoDias         ELSE 0   END
			, 'operador'                 = @A33_Usuario
			, 'operador_cliente'         = 0 --@A33_Usuario
			, 'estado_flujo'             = 0
			, 'modalidad_pago'           = @A25_ModalidadPago
			, 'observaciones'            = @A34_Observaciones
			, 'Hora'                     = CONVERT(CHAR(10),GETDATE(),108)
			, 0.00
			, 0.00
			, 'Monto_Spread'             = 0.0
			, 'FeriadoFlujoChile'        = @A43_FeriadoFlujoChile
			, /*073*/ 'FeriadoFlujoEEUU'         = @A44_FeriadoFlujoEEUU
			, /*074*/ 'FeriadoFlujoEnglan'       = @A45_FeriadoFlujoEnglan
			, /*075*/ 'FeriadoLiquiChile'        = @A46_FeriadoLiquiChile
			, /*076*/ 'FeriadoLiquiEEUU'         = @A47_FeriadoLiquiEEUU
			, /*077*/ 'FeriadoLiquiEnglan'       = @A48_FeriadoLiquiEnglan
			, /*079*/ 'DiasReset'                = @A41_DiasReset
			, /*080*/ 'FechaEfectiva'            = @A27_FechaEfectiva
			, /*081*/ 'PrimerPago'               = @A28_FechaPrimerPago
			, /*082*/ 'PenultimoPago'            = @A29_FechaPenultimoPago
			, /*083*/ 'Madurez'                  = @A30_FechaMadurez
			, /*087*/ 'FechaLiquidacion'         = @A53_FechaLiquidacion
			, /*088*/ 'FechaReset'               = @A54_FechaReset
			, /*089*/ 'FxRate'                   = @A55_FxRate
			, /*090*/ 'Compra_Amortiza_Prc'      = CASE WHEN @A03_TipoFlujo = 1 THEN @A56_PrcAmortiza  ELSE 0.0 END
			, /*091*/ 'Venta_Amortiza_Prc'       = CASE WHEN @A03_TipoFlujo = 2 THEN @A56_PrcAmortiza  ELSE 0.0 END
			, /*092*/ 'FechaValuta'              = @A57_FechaValuta
			, /*093*/ 'Compra_Flujo_Adicional'   = CASE WHEN @A03_TipoFlujo = 1 THEN @A58_FlujoAdicional  ELSE 0.0 END
			, /*094*/ 'Venta_Flujo_Adicional'    = CASE WHEN @A03_TipoFlujo = 2 THEN @A58_FlujoAdicional  ELSE 0.0 END
			, /*095*/ 'Compra_zcr'               = CASE WHEN @A03_TipoFlujo = 1 THEN 
									CASE WHEN @A26_FechaCierre >= @A42_FechaFijaTasa
										AND @A15_Indicador <> 0 then 1
                                                                        ELSE 0 END
                                                               ELSE 0 END 
			, /*096*/ 'Venta_zcr'                = CASE WHEN @A03_TipoFlujo = 2 THEN 
									CASE WHEN @A26_FechaCierre >= @A42_FechaFijaTasa
                                                                        	AND  @A15_Indicador <> 0 then 1
                                                                         ELSE 0 END
                                                               ELSE 0 END

   IF @@ERROR <> 0
   BEGIN
      SELECT -1 ,'Problemas en la Grabación del Registro de Flujos Intra Mesa.'
      RETURN
   END
	SELECT 0 , 'Grabación del Registro Ticket Intra Mesa ha Finalizado en Forma Correcta.'

END
GO

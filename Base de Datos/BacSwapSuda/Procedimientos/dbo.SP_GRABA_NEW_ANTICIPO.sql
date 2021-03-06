USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_NEW_ANTICIPO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_NEW_ANTICIPO]



	(   @nContrato				NUMERIC(9)



	,   @nPorcNominal			FLOAT



	,   @nValorAnticipo			FLOAT



	,   @nValorAnticipoTran		FLOAT



	,   @nResultadoVenta		FLOAT



	,   @nResultadoTrading		FLOAT



	,   @iPagamosMoneda			INT			= 0



	,   @iPagamosDocumento		INT			= 0



	,   @nModalidad				CHAR(1)		= 'C' 



	,	@cUsuario				VARCHAR(15)	= ''



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

	   	



   DECLARE @nCorrelaUnwind    INT



      SET  @nCorrelaUnwind    = 0



      SET  @nCorrelaUnwind    = isnull((SELECT MAX(isnull(Especial, 0)) FROM BacSwapSuda.dbo.CARTERA_UNWIND



                                                                       WHERE numero_operacion = @nContrato), 0)



      SET  @nCorrelaUnwind    = (@nCorrelaUnwind + 1)

	  

   -->     5.0 Crea la estructura final para generar la cartera (Cartera Anticipada + Cartera Saldo)



   SELECT * INTO #tmp_cartera_Antic FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato



   SELECT * INTO #tmp_cartera_Saldo FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato







   -->     6.0 Si esta anticipando el 100% (Anticipo Total), no debe insertar registros de Saldo de Cartera



   IF @PorcentajeSaldo = 0



   BEGIN



      -->  6.1 Se borran la cartera de saldo, pero se mantiene estructura. para no afectar el insert



      DELETE FROM #tmp_cartera_Saldo



   END







   -->     7.0 Se generan los registro de cartera a anticipar, a partir del % de capital a Anticipar



   UPDATE  #tmp_cartera_Antic



      SET  fecha_vence_flujo      = @dFechaHoy



      ,    FechaLiquidacion       = @dFechaHoy



      ,    FechaValuta            = @dFechaHoy



      ,    fecha_termino          = CASE WHEN @PorcentajeSaldo = 0 THEN @dFechaHoy ELSE fecha_termino END



      ,    compra_capital         = ((compra_capital     * @nPorcNominal) / 100.0)



      ,    compra_amortiza        = ((compra_amortiza    * @nPorcNominal) / 100.0)



      ,    compra_saldo           = ((compra_saldo       * @nPorcNominal) / 100.0)



      ,    compra_interes         = ((compra_interes     * @nPorcNominal) / 100.0)



      ,    venta_capital          = ((venta_capital      * @nPorcNominal) / 100.0)



      ,    venta_amortiza         = ((venta_amortiza     * @nPorcNominal) / 100.0)



      ,    venta_saldo            = ((venta_saldo        * @nPorcNominal) / 100.0)



      ,    venta_interes          = ((venta_interes      * @nPorcNominal) / 100.0)



      ,    Activo_MO_C08          = ((Activo_MO_C08      * @nPorcNominal) / 100.0)



      ,    Activo_USD_C08         = ((Activo_USD_C08     * @nPorcNominal) / 100.0)



      ,    Activo_CLP_C08         = ((Activo_CLP_C08     * @nPorcNominal) / 100.0)



      ,    Pasivo_MO_C08          = ((Pasivo_MO_C08      * @nPorcNominal) / 100.0)



      ,    Pasivo_USD_C08         = ((Pasivo_USD_C08     * @nPorcNominal) / 100.0)



      ,    Pasivo_CLP_C08         = ((Pasivo_CLP_C08     * @nPorcNominal) / 100.0)



      ,    Activo_FlujoMO         = ((Activo_FlujoMO     * @nPorcNominal) / 100.0)



      ,    Activo_FlujoUSD        = ((Activo_FlujoUSD    * @nPorcNominal) / 100.0)



      ,    Activo_FlujoCLP        = ((Activo_FlujoCLP    * @nPorcNominal) / 100.0)



      ,    Pasivo_FlujoMO         = ((Pasivo_FlujoMO     * @nPorcNominal) / 100.0)



      ,    Pasivo_FlujoUSD        = ((Pasivo_FlujoUSD    * @nPorcNominal) / 100.0)



      ,    Pasivo_FlujoCLP        = ((Pasivo_FlujoCLP    * @nPorcNominal) / 100.0)



      ,    Valor_RazonableMO      = ((Valor_RazonableMO  * @nPorcNominal) / 100.0)



      ,    Valor_RazonableUSD     = ((Valor_RazonableUSD * @nPorcNominal) / 100.0)



      ,    Valor_RazonableCLP     = ((Valor_RazonableCLP * @nPorcNominal) / 100.0)



      ,    vRazAjustado_Mo        = ((vRazAjustado_Mo    * @nPorcNominal) / 100.0)



      ,    vRazAjustado_Mn        = ((vRazAjustado_Mn    * @nPorcNominal) / 100.0)



      ,    vRazAjustado_Do        = ((vRazAjustado_Do    * @nPorcNominal) / 100.0)



      ,    vRazActivoAjus_Mo      = ((vRazActivoAjus_Mo  * @nPorcNominal) / 100.0)



      ,    vRazActivoAjus_Mn      = ((vRazActivoAjus_Mn  * @nPorcNominal) / 100.0)



      ,    vRazActivoAjus_Do      = ((vRazActivoAjus_Do  * @nPorcNominal) / 100.0)



      ,    vRazPasivoAjus_Mo      = ((vRazPasivoAjus_Mo  * @nPorcNominal) / 100.0)



      ,    vRazPasivoAjus_Mn      = ((vRazPasivoAjus_Mn  * @nPorcNominal) / 100.0)



      ,    vRazPasivoAjus_Do      = ((vRazPasivoAjus_Do  * @nPorcNominal) / 100.0)



      ,    Compra_Flujo_Adicional = ((Compra_Flujo_Adicional * @nPorcNominal) / 100.0)



      ,    Venta_Flujo_Adicional  = ((Venta_Flujo_Adicional  * @nPorcNominal) / 100.0)



      ,    Especial               = @nCorrelaUnwind



	  ,	   operador				  = CASE WHEN @cUsuario = '' THEN operador ELSE @cUsuario END







   -->     8.0 Se generan los registro de cartera Saldo, a partir del % de capital Restante



   --      Si la operacion fuese anticipo total, no afecta esta actualizacion dado que no la haría por falta de registros.



   UPDATE  #tmp_cartera_Saldo



      SET  compra_capital         = ((compra_capital     * @PorcentajeSaldo ) / 100.0)



      ,    compra_amortiza        = ((compra_amortiza    * @PorcentajeSaldo ) / 100.0)



      ,    compra_saldo           = ((compra_saldo       * @PorcentajeSaldo ) / 100.0)



      ,    compra_interes         = ((compra_interes     * @PorcentajeSaldo ) / 100.0)



      ,    venta_capital          = ((venta_capital      * @PorcentajeSaldo ) / 100.0)



      ,    venta_amortiza         = ((venta_amortiza     * @PorcentajeSaldo ) / 100.0)



      ,    venta_saldo            = ((venta_saldo        * @PorcentajeSaldo ) / 100.0)



      ,    venta_interes          = ((venta_interes      * @PorcentajeSaldo ) / 100.0)



      ,    Activo_MO_C08          = ((Activo_MO_C08      * @PorcentajeSaldo ) / 100.0)



      ,    Activo_USD_C08         = ((Activo_USD_C08     * @PorcentajeSaldo ) / 100.0)



      ,    Activo_CLP_C08         = ((Activo_CLP_C08     * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_MO_C08          = ((Pasivo_MO_C08      * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_USD_C08         = ((Pasivo_USD_C08     * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_CLP_C08         = ((Pasivo_CLP_C08     * @PorcentajeSaldo ) / 100.0)



      ,    Activo_FlujoMO         = ((Activo_FlujoMO     * @PorcentajeSaldo ) / 100.0)



      ,    Activo_FlujoUSD        = ((Activo_FlujoUSD    * @PorcentajeSaldo ) / 100.0)



      ,    Activo_FlujoCLP        = ((Activo_FlujoCLP    * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_FlujoMO         = ((Pasivo_FlujoMO     * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_FlujoUSD        = ((Pasivo_FlujoUSD    * @PorcentajeSaldo ) / 100.0)



      ,    Pasivo_FlujoCLP        = ((Pasivo_FlujoCLP    * @PorcentajeSaldo ) / 100.0)



      ,    Valor_RazonableMO      = ((Valor_RazonableMO  * @PorcentajeSaldo ) / 100.0)



      ,    Valor_RazonableUSD     = ((Valor_RazonableUSD * @PorcentajeSaldo ) / 100.0)



      ,    Valor_RazonableCLP     = ((Valor_RazonableCLP * @PorcentajeSaldo ) / 100.0)



      ,    vRazAjustado_Mo        = ((vRazAjustado_Mo    * @PorcentajeSaldo ) / 100.0)



      ,    vRazAjustado_Mn  = ((vRazAjustado_Mn    * @PorcentajeSaldo ) / 100.0)



      ,    vRazAjustado_Do        = ((vRazAjustado_Do    * @PorcentajeSaldo ) / 100.0)



      ,    vRazActivoAjus_Mo      = ((vRazActivoAjus_Mo  * @PorcentajeSaldo ) / 100.0)



      ,    vRazActivoAjus_Mn      = ((vRazActivoAjus_Mn  * @PorcentajeSaldo ) / 100.0)



      ,    vRazActivoAjus_Do      = ((vRazActivoAjus_Do  * @PorcentajeSaldo ) / 100.0)



      ,    vRazPasivoAjus_Mo      = ((vRazPasivoAjus_Mo  * @PorcentajeSaldo ) / 100.0)



      ,    vRazPasivoAjus_Mn      = ((vRazPasivoAjus_Mn  * @PorcentajeSaldo ) / 100.0)



      ,    vRazPasivoAjus_Do      = ((vRazPasivoAjus_Do  * @PorcentajeSaldo ) / 100.0)



      ,    Compra_Flujo_Adicional = ((Compra_Flujo_Adicional * @nPorcNominal) / 100.0)



      ,    Venta_Flujo_Adicional  = ((Venta_Flujo_Adicional  * @nPorcNominal) / 100.0)







   -->    Antes de Traspasar los Flujos, se Mueven los numeros incrementando en uno cada uno de ellos



   UPDATE #tmp_cartera_Saldo



      SET Numero_Flujo           = Numero_Flujo + 2







   UPDATE #tmp_cartera_Antic



      SET Numero_Flujo           = Numero_Flujo + 2







   UPDATE #tmp_cartera_Antic



      SET fecha_vence_flujo      = @dFechaHoy



      ,   estado                 = 'N'



      ,   FechaLiquidacion       = @dFechaHoy



      ,   modalidad_pago         = @nModalidad



      --> Documento Pago



      ,   recibimos_documento    = @iPagamosDocumento



      ,   recibimos_moneda       = @iPagamosMoneda



      --> Monto Recibimos



      ,   recibimos_monto        = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END)



      ,   recibimos_monto_USD    = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END) 



      ,   recibimos_monto_CLP    = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END) --> 



    WHERE tipo_flujo             = 1







   UPDATE #tmp_cartera_Antic



      SET fecha_vence_flujo      = @dFechaHoy



      ,   estado                 = 'N'



      ,   FechaLiquidacion       = @dFechaHoy



      ,   modalidad_pago         = @nModalidad



      --> Moneda Pago



      ,   pagamos_documento      = @iPagamosDocumento



      ,   pagamos_moneda         = @iPagamosMoneda



      --> Monto Pagamos



      ,   pagamos_monto          = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END)



      ,   pagamos_monto_USD      = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END)



      ,   pagamos_monto_CLP      = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END) --> 



    WHERE tipo_flujo             = 2







   -->    Se corrige a partir del error en Liquidaciones 1521 & 1522



   UPDATE #tmp_cartera_Antic



      SET pagamos_monto_USD       = CASE WHEN pagamos_moneda <> 999 THEN pagamos_monto



                                         WHEN pagamos_moneda  = 999 THEN pagamos_monto / @nTCCambio



                                    END



      ,   pagamos_monto_CLP       = CASE WHEN pagamos_moneda <> 999 THEN round(pagamos_monto * @nTCCambio, 0)



                                         WHEN pagamos_moneda  = 999 THEN round(pagamos_monto, 0)



                                    END



      ,   Devengo_Recibido_Mda_Val= @nResultadoVenta



      ,   Devengo_Pagar_Mda_Val   = @nResultadoTrading



      ,   Principal_Mda_Val       = @nValorAnticipoTran



    WHERE tipo_flujo              = 2







   UPDATE #tmp_cartera_Antic   



      SET recibimos_monto_USD     = CASE WHEN recibimos_moneda <> 999 THEN recibimos_monto



                                         WHEN recibimos_moneda  = 999 THEN recibimos_monto / @nTCCambio



                                    END



      ,   recibimos_monto_CLP     = CASE WHEN recibimos_moneda <> 999 THEN round(recibimos_monto * @nTCCambio, 0)



                                         WHEN recibimos_moneda  = 999 THEN round(recibimos_monto, 0)



                                    END



      ,   Devengo_Recibido_Mda_Val= @nResultadoVenta



      ,   Devengo_Pagar_Mda_Val   = @nResultadoTrading



      ,   Principal_Mda_Val       = @nValorAnticipoTran



   WHERE  tipo_flujo              = 1





   -->    Se corrige a partir del error en Liquidaciones 1521 & 1522







   DECLARE @capital   NUMERIC(21,4)



   DECLARE @amortiza  NUMERIC(21,4)



   DECLARE @saldo     NUMERIC(21,4)



   DECLARE @interes   NUMERIC(21,4)



   DECLARE @numflujo  INT



   -->    19.0 Insertar los anticipos en cartera unwind historica





   INSERT INTO BacSwapSuda.dbo.CARTERA_UNWIND 

			   (FechaAnticipo,					numero_operacion,			numero_flujo,					tipo_flujo,

			    tipo_swap,						cartera_inversion,			tipo_operacion,					codigo_cliente,

				rut_cliente,					fecha_cierre,				fecha_inicio,					fecha_termino,

				fecha_inicio_flujo,				fecha_vence_flujo,			fecha_fijacion_tasa,			compra_moneda,

				compra_capital,					compra_amortiza,			compra_saldo,					compra_interes,

				compra_spread,					compra_codigo_tasa,			compra_valor_tasa,				compra_valor_tasa_hoy,

				compra_codamo_capital,			compra_mesamo_capital,		compra_codamo_interes,			compra_mesamo_interes,

				compra_base,					venta_moneda,				venta_capital,					venta_amortiza,

				venta_saldo,					venta_interes,				venta_spread,					venta_codigo_tasa,

				venta_valor_tasa,				venta_valor_tasa_hoy,		venta_codamo_capital,			venta_mesamo_capital,

				venta_codamo_interes,			venta_mesamo_interes,		venta_base,						operador,

				operador_cliente,				estado_flujo,				modalidad_pago,					pagamos_moneda,

				pagamos_documento,				pagamos_monto,				pagamos_monto_usd,				pagamos_monto_clp,

				recibimos_moneda,				recibimos_documento,		recibimos_monto,				recibimos_monto_usd,

				recibimos_monto_clp,			observaciones,				fecha_modifica,					devengo_dias, devengo_monto,	

				devengo_monto_peso,				devengo_monto_acum,			devengo_monto_ayer,				devengo_compra,

				devengo_compra_acum,			devengo_compra_acum_peso,	devengo_compra_ayer,			devengo_compra_ayer_peso,

				devengo_venta,					devengo_venta_acum,			devengo_venta_acum_peso,		devengo_venta_ayer,

				devengo_venta_ayer_peso,		fecha_valoriza,				compra_zcr,						compra_mercado_tasa,

				compra_mercado,					compra_mercado_usd,			compra_mercado_clp,				compra_duration_tasa,

				compra_duration_monto,			compra_duration_monto_usd,	compra_duration_monto_clp,		compra_valor_presente,

				venta_zcr,						venta_mercado_tasa,			venta_mercado,					venta_mercado_usd,

				venta_mercado_clp,				venta_duration_tasa,		venta_duration_monto,			venta_duration_monto_usd,

				venta_duration_monto_clp,		venta_valor_presente,		monto_mtm,						monto_mtm_usd,

				monto_mtm_clp,					compra_valorizada,			compra_variacion,				venta_valorizada,

				venta_variacion,				valorizacion_dia,			estado,							estado_oper_lineas,

				Observacion_Lineas,				Observacion_Limites,		Especial,						Capital_Pesos_Actual,			

				Capital_Pesos_Ayer,				Hora,						Tasa_Compra_Curva,				Tasa_Venta_Curva,

				Activo_MO_C08,

				Pasivo_MO_C08,					Activo_USD_C08,				Pasivo_USD_C08,					Activo_CLP_C08,

				Pasivo_CLP_C08,					Tasa_Compra_CurvaVR,		Tasa_Venta_CurvaVR,				Activo_FlujoMO,	

				Activo_FlujoUSD,				Activo_FlujoCLP,			Pasivo_FlujoMO,					Pasivo_FlujoUSD,

				Pasivo_FlujoCLP,				Valor_RazonableMO,			Valor_RazonableUSD,				Valor_RazonableCLP,

				Monto_Spread,					Monto_diferido_inicial,		Monto_diferido_diario,			Monto_diferido_acumulado,

				TC_MO_Inicial,					Monto_TC_Diario,			Monto_TC_Acumulado,				Monto_Reajuste_Diario,						

				Monto_Reajuste_Acumulado,		Monto_Valorizacion,			Monto_Capital_TC_ini,			car_area_Responsable,

				car_Cartera_Normativa,			car_SubCartera_Normativa,	car_Libro,						DevAntPromCam,

				vRazAjustado_Mo,				vRazAjustado_Mn,			vRazAjustado_Do,				vRazActivoAjus_Mo,

				vRazPasivoAjus_Mo,				vRazActivoAjus_Mn,			vRazPasivoAjus_Mn,				vRazActivoAjus_Do,

				vRazPasivoAjus_Do,				vTasaActivaAjusta,			vTasaPasivaAjusta,				vDurMacaulActivo,

				vDurMacaulPasivo,				vDurModifiActivo,			vDurModifiPasivo,				vDurConvexActivo,

				vDurConvexPasivo,				FeriadoFlujoChile,			FeriadoFlujoEEUU,				FeriadoFlujoEnglan,

				FeriadoLiquiChile,				FeriadoLiquiEEUU,			FeriadoLiquiEnglan,				Convencion,

				DiasReset,						FechaEfectiva,				PrimerPago,						PenultimoPago,

				Madurez,						Note,						IntercPrinc,					Tikker,

				FechaLiquidacion,				fechareset,					CompraTasaProyectada,			estado_sinacofi,

				fecha_sinacofi,					Moneda_Valorizacion,		Valor_Mercado_Activo_Mda_Val,	Devengo_Recibido_Mda_Val,

				Valor_Mercado_Pasivo_Mda_Val,	Devengo_Pagar_Mda_Val,		Principal_Mda_Val,				Devengo_Neto_Mda_Val,

				Valor_Mercado_Mda_Val,			Porcentaje_Margen,			Monto_Margen,					Monto_Margen_CLP,

				OrigenCurva,					ActivoTir,					PasivoTir,						ActivoTirCnv,

				PasivoTirCnv,					FxRate,						Compra_amortiza_Prc,			Venta_amortiza_Prc,

				Compra_Flujo_Adicional,			Venta_Flujo_Adicional,		FechaValuta,					CompraPerResetCod,

				VentaPerResetCod,				CompraLiqDefault,			VentaLiqDefault,				CompraResetDefault,

				VentaResetDefault,				Compra_DV01_Forward,		Venta_DV01_Forward,				Compra_DV01_Descuento,

				Venta_DV01_Descuento,			Compra_curva_TIR,			Venta_curva_TIR,				Compra_Curva_Descont,

				Venta_Curva_Descont,			Compra_Curva_Forward,		Venta_Curva_Forward,			Monto_LCR_Matriz,

				Monto_LCR_Ajuste_AVR,			Trader_Contraparte,			Especifica_Negocio,				Compra_Tasa_Forward_larga,

				Compra_Tasa_Forward_corta,		PlazoFlujo,					PortaFolio,						Threshold,

				ReferenciaUSDCLP,				ReferenciaMEXUSD,			FechaUSDCLP,					FechaMEXUSD							

				)

		 select @dFechaHoy,						numero_operacion,			numero_flujo,					tipo_flujo,

			    tipo_swap,						cartera_inversion,			tipo_operacion,					codigo_cliente,

				rut_cliente,					fecha_cierre,				fecha_inicio,					fecha_termino,

				fecha_inicio_flujo,				fecha_vence_flujo,			fecha_fijacion_tasa,			compra_moneda,

				compra_capital,					compra_amortiza,			compra_saldo,					compra_interes,

				compra_spread,					compra_codigo_tasa,			compra_valor_tasa,				compra_valor_tasa_hoy,

				compra_codamo_capital,			compra_mesamo_capital,		compra_codamo_interes,			compra_mesamo_interes,

				compra_base,					venta_moneda,				venta_capital,					venta_amortiza,

				venta_saldo,					venta_interes,				venta_spread,					venta_codigo_tasa,

				venta_valor_tasa,				venta_valor_tasa_hoy,		venta_codamo_capital,			venta_mesamo_capital,

				venta_codamo_interes,			venta_mesamo_interes,		venta_base,						operador,

				operador_cliente,				estado_flujo,				modalidad_pago,					pagamos_moneda,

				pagamos_documento,				pagamos_monto,				pagamos_monto_USD,				pagamos_monto_CLP,

				recibimos_moneda,				recibimos_documento,		recibimos_monto,				recibimos_monto_USD,

				recibimos_monto_CLP,			observaciones,				fecha_modifica,					devengo_dias,	devengo_monto,	

				devengo_monto_peso,				devengo_monto_acum,			devengo_monto_ayer,				devengo_compra,

				devengo_compra_acum,			devengo_compra_acum_peso,	devengo_compra_ayer,			devengo_compra_ayer_peso,

				devengo_venta,					devengo_venta_acum,			devengo_venta_acum_peso,		devengo_venta_ayer,

				devengo_venta_ayer_peso,		fecha_valoriza,				compra_zcr,						compra_mercado_tasa,

				compra_mercado,					compra_mercado_usd,			compra_mercado_clp,				compra_duration_tasa,

				compra_duration_monto,			compra_duration_monto_usd,	compra_duration_monto_clp,		compra_valor_presente,

				venta_zcr,						venta_mercado_tasa,			venta_mercado,					venta_mercado_usd,

				venta_mercado_clp,				venta_duration_tasa,		venta_duration_monto,			venta_duration_monto_usd,

				venta_duration_monto_clp,		venta_valor_presente,		monto_mtm,						monto_mtm_usd,

				monto_mtm_clp,					compra_valorizada,			compra_variacion,				venta_valorizada,

				venta_variacion,				valorizacion_dia,			estado,							Estado_oper_lineas,

				Observacion_Lineas,				Observacion_Limites,		Especial,						Capital_Pesos_Actual,			

				Capital_Pesos_Ayer,

				Hora,							Tasa_Compra_Curva,			Tasa_Venta_Curva,				Activo_MO_C08,

				Pasivo_MO_C08,					Activo_USD_C08,				Pasivo_USD_C08,					Activo_CLP_C08,

				Pasivo_CLP_C08,					Tasa_Compra_CurvaVR,		Tasa_Venta_CurvaVR,				Activo_FlujoMO,	

				Activo_FlujoUSD,				Activo_FlujoCLP,			Pasivo_FlujoMO,					Pasivo_FlujoUSD,

				Pasivo_FlujoCLP,				Valor_RazonableMO,			Valor_RazonableUSD,				Valor_RazonableCLP,

				Monto_Spread,					Monto_diferido_inicial,		Monto_diferido_diario,			Monto_diferido_acumulado,

				TC_MO_Inicial,					Monto_TC_Diario,			Monto_TC_Acumulado,				Monto_Reajuste_Diario,						

				Monto_Reajuste_Acumulado,		Monto_Valorizacion,			Monto_Capital_TC_ini,			car_area_Responsable,

				car_Cartera_Normativa,			car_SubCartera_Normativa,	car_Libro,						DevAntPromCam,

				vRazAjustado_Mo,				vRazAjustado_Mn,			vRazAjustado_Do,				vRazActivoAjus_Mo,

				vRazPasivoAjus_Mo,				vRazActivoAjus_Mn,			vRazPasivoAjus_Mn,				vRazActivoAjus_Do,

				vRazPasivoAjus_Do,				vTasaActivaAjusta,			vTasaPasivaAjusta,				vDurMacaulActivo,

				vDurMacaulPasivo,				vDurModifiActivo,			vDurModifiPasivo,				vDurConvexActivo,

				vDurConvexPasivo,				FeriadoFlujoChile,			FeriadoFlujoEEUU,				FeriadoFlujoEnglan,

				FeriadoLiquiChile,				FeriadoLiquiEEUU,			FeriadoLiquiEnglan,				Convencion,

				DiasReset,						FechaEfectiva,				PrimerPago,						PenultimoPago,

				Madurez,						Note,						IntercPrinc,					Tikker,

				FechaLiquidacion,				fechareset,					CompraTasaProyectada,			estado_sinacofi,

				fecha_sinacofi,					Moneda_Valorizacion,		Valor_Mercado_Activo_Mda_Val,	Devengo_Recibido_Mda_Val,

				Valor_Mercado_Pasivo_Mda_Val,	Devengo_Pagar_Mda_Val,		Principal_Mda_Val,				Devengo_Neto_Mda_Val,

				Valor_Mercado_Mda_Val,			Porcentaje_Margen,			Monto_Margen,					Monto_Margen_CLP,

				OrigenCurva,					ActivoTir,					PasivoTir,						ActivoTirCnv,

				PasivoTirCnv,					FxRate,						Compra_amortiza_Prc,			Venta_amortiza_Prc,

				Compra_Flujo_Adicional,			Venta_Flujo_Adicional,		FechaValuta,					CompraPerResetCod,

				VentaPerResetCod,				CompraLiqDefault,			VentaLiqDefault,				CompraResetDefault,

				VentaResetDefault,				Compra_DV01_Forward,		Venta_DV01_Forward,				Compra_DV01_Descuento,

				Venta_DV01_Descuento,			Compra_curva_TIR,			Venta_curva_TIR,				Compra_Curva_Descont,

				Venta_Curva_Descont,			Compra_Curva_Forward,		Venta_Curva_Forward,			Monto_LCR_Matriz,

				Monto_LCR_Ajuste_AVR,			Trader_Contraparte,			Especifica_Negocio,				Compra_Tasa_Forward_larga,

				Compra_Tasa_Forward_corta,		PlazoFlujo,					PortaFolio,						Threshold,

				ReferenciaUSDCLP,				ReferenciaMEXUSD,			FechaUSDCLP,					FechaMEXUSD			

				from #tmp_cartera_Antic

		









   ---->    20.0 Elimina la cartera vigente, para poder insertar el anticipo y saldos segun corresponda



   DELETE FROM BacSwapSuda.dbo.CARTERA



         WHERE numero_operacion = @nContrato







   ---->    21.0 Insertar los saldos en cartera



   INSERT INTO BacSwapSuda.dbo.CARTERA



        SELECT * FROM #tmp_cartera_Saldo







   -->    22.0 Se crea un nuevo registro como flujo para el Anticipo de la operaciòn



      SELECT   @capital        = MIN( compra_capital )



         ,     @amortiza       = SUM( compra_amortiza)



         ,     @saldo          = SUM( compra_saldo   )



         ,     @interes        = SUM( compra_interes )



         ,     @numflujo       = MIN( numero_flujo   )



      FROM     #tmp_cartera_antic



      WHERE    tipo_flujo      = 1



      GROUP BY tipo_flujo







      DELETE FROM #tmp_cartera_antic



            WHERE numero_flujo > @numflujo



              and tipo_flujo   = 1







      -->    Se modifica para Anticipo 100%



      UPDATE #tmp_cartera_antic



         SET numero_flujo     = (@numflujo - 1)



         ,   compra_capital   = @capital



         ,   compra_amortiza  = CASE WHEN @PorcentajeSaldo = 0 THEN @capital ELSE @amortiza END



         ,   compra_saldo     = CASE WHEN @PorcentajeSaldo = 0 THEN 0.0      ELSE @saldo    END



         ,   compra_interes   = @interes



       WHERE tipo_flujo       = 1







      SELECT   @capital        = MIN( venta_capital )



         ,     @amortiza       = SUM( venta_amortiza)



         ,     @saldo          = SUM( venta_saldo   )



         ,     @interes        = SUM( venta_interes )



         ,     @numflujo       = MIN( numero_flujo  )



      FROM     #tmp_cartera_antic



      WHERE    tipo_flujo      = 2



      GROUP BY tipo_flujo







      DELETE FROM #tmp_cartera_antic



            WHERE numero_flujo > @numflujo



              and tipo_flujo   = 2







      -->    Se modifica para Anticipo 100%



      UPDATE #tmp_cartera_antic



         SET numero_flujo     = (@numflujo - 1)



         ,   venta_capital    = @capital



         ,   venta_amortiza   = CASE WHEN @PorcentajeSaldo = 0 THEN @capital ELSE @amortiza END



         ,   venta_saldo      = CASE WHEN @PorcentajeSaldo = 0 THEN 0.0      ELSE @saldo    END



         ,   venta_interes    = @interes



       WHERE tipo_flujo       = 2







   INSERT INTO BacSwapSuda.dbo.CARTERA



        SELECT * FROM #tmp_cartera_Antic

   DECLARE @FechaProc  DATETIME  
  
   SELECT @FechaProc = fechaproc   
        FROM   SWAPGENERAL with(nolock)  
   
   
   -->    Genera Caja 
   create table #RecibePrcCaja ( Codigo numeric(5), Msg Varchar(200) )
   insert into #RecibePrcCaja
   Exec SP_GRABA_LIQUIDACION @FechaProc, @nContrato
   if @@Error <> 0
   Begin
      ROLLBACK TRANSACTION  
      RETURN -115     
   end 




   -->    23.0 Retorna la cartera completa del Swap con todos sus flujos.



   SELECT * FROM BacSwapSuda.dbo.CARTERA



           WHERE numero_operacion = @nContrato 



        ORDER BY numero_flujo, tipo_flujo









END

GO

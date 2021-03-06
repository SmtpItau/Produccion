USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_NEW_ANTICIPO_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_NEW_ANTICIPO_TICKET]
	(   @nContrato				NUMERIC(9)
	,   @nPorcNominal			FLOAT
	,   @nValorAnticipo			FLOAT
	,   @nValorAnticipoTran		FLOAT
	,   @nResultadoVenta		FLOAT
	,   @nResultadoTradin		FLOAT
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
       SET @dFechaAyer        = (SELECT fechaant  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

   -->     3.0 Lee el TC Contable del Dolar
   DECLARE @nTCCambio         FLOAT
       SET @nTCCambio         = (SELECT tipo_cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock) 
                                                   WHERE Fecha = @dFechaAyer and codigo_moneda = 994)

   -->     4.0 Define el Porcentaje para el Saldo en Cartera
   DECLARE @PorcentajeSaldo   FLOAT
       SET @PorcentajeSaldo   = (100.0 - @nPorcNominal)

   -->    5.0 Crea la estructura final para generar la cartera (Cartera Anticipada + Cartera Saldo)
   SELECT * INTO #Tmp_Flujos_Anticipo FROM BacSwapSuda.dbo.TBL_FLJTICKETSWAP WHERE numero_operacion = @nContrato
   SELECT * INTO #Tmp_Flujos_Saldo    FROM BacSwapSuda.dbo.TBL_FLJTICKETSWAP WHERE numero_operacion = @nContrato

   -->    6.0 Si esta anticipando el 100% (Anticipo Total), no debe insertar registros de Saldo de Cartera
   IF @PorcentajeSaldo = 0.0
   BEGIN
      DELETE FROM #Tmp_Flujos_Saldo
   END

   -->     7.0 Se generan los registro de cartera a anticipar, a partir del % de capital a Anticipar
   UPDATE #Tmp_Flujos_Anticipo
      SET compra_capital                 = (compra_capital               * @PorcentajeSaldo)
      ,   compra_amortiza                = (compra_amortiza              * @PorcentajeSaldo)
      ,   compra_saldo                   = (compra_saldo                 * @PorcentajeSaldo)
      ,   compra_interes                 = (compra_interes               * @PorcentajeSaldo)
      ,   venta_capital                  = (venta_capital                * @PorcentajeSaldo)
      ,   venta_amortiza                 = (venta_amortiza               * @PorcentajeSaldo)
      ,   venta_saldo                    = (venta_saldo                  * @PorcentajeSaldo)
      ,   venta_interes                  = (venta_interes                * @PorcentajeSaldo)
      ,   devengo_monto                  = (devengo_monto                * @PorcentajeSaldo)
      ,   devengo_monto_peso             = (devengo_monto_peso           * @PorcentajeSaldo)
      ,   devengo_monto_acum             = (devengo_monto_acum           * @PorcentajeSaldo)
      ,   devengo_monto_ayer             = (devengo_monto_ayer           * @PorcentajeSaldo)
      ,   devengo_compra                 = (devengo_compra               * @PorcentajeSaldo)
      ,   devengo_compra_acum            = (devengo_compra_acum          * @PorcentajeSaldo)
      ,   devengo_compra_acum_peso       = (devengo_compra_acum_peso     * @PorcentajeSaldo)
      ,   devengo_compra_ayer            = (devengo_compra_ayer          * @PorcentajeSaldo)
      ,   devengo_compra_ayer_peso       = (devengo_compra_ayer_peso     * @PorcentajeSaldo)
      ,   devengo_venta                  = (devengo_venta                * @PorcentajeSaldo)
      ,   devengo_venta_acum             = (devengo_venta_acum           * @PorcentajeSaldo)
      ,   devengo_venta_acum_peso        = (devengo_venta_acum_peso      * @PorcentajeSaldo)
      ,   devengo_venta_ayer             = (devengo_venta_ayer           * @PorcentajeSaldo)
      ,   devengo_venta_ayer_peso        = (devengo_venta_ayer_peso      * @PorcentajeSaldo)
      ,   compra_mercado                 = (compra_mercado               * @PorcentajeSaldo)
      ,   compra_mercado_usd             = (compra_mercado_usd           * @PorcentajeSaldo)
      ,   compra_mercado_clp             = (compra_mercado_clp           * @PorcentajeSaldo)
      ,   compra_duration_monto          = (compra_duration_monto        * @PorcentajeSaldo)
      ,   compra_duration_monto_usd      = (compra_duration_monto_usd    * @PorcentajeSaldo)
      ,   ompra_duration_monto_clp       = (ompra_duration_monto_clp     * @PorcentajeSaldo)
      ,   compra_valor_presente          = (compra_valor_presente        * @PorcentajeSaldo)
      ,   venta_mercado                  = (venta_mercado                * @PorcentajeSaldo)
      ,   venta_mercado_usd              = (venta_mercado_usd            * @PorcentajeSaldo)
      ,   venta_mercado_clp              = (venta_mercado_clp            * @PorcentajeSaldo)
      ,   venta_duration_monto           = (venta_duration_monto         * @PorcentajeSaldo)
      ,   venta_duration_monto_usd       = (venta_duration_monto_usd     * @PorcentajeSaldo)
      ,   venta_duration_monto_clp       = (venta_duration_monto_clp     * @PorcentajeSaldo)
      ,   venta_valor_presente           = (venta_valor_presente         * @PorcentajeSaldo)
      ,   compra_valorizada              = (compra_valorizada            * @PorcentajeSaldo)
      ,   compra_variacion               = (compra_variacion             * @PorcentajeSaldo)
      ,   venta_valorizada               = (venta_valorizada             * @PorcentajeSaldo)
      ,   venta_variacion                = (venta_variacion              * @PorcentajeSaldo)
      ,   valorizacion_dia               = (valorizacion_dia             * @PorcentajeSaldo)
      ,   Capital_Pesos_Actual           = (Capital_Pesos_Actual         * @PorcentajeSaldo)
      ,   Capital_Pesos_Ayer             = (Capital_Pesos_Ayer           * @PorcentajeSaldo)
      ,   Monto_diferido_inicial         = (Monto_diferido_inicial       * @PorcentajeSaldo)
      ,   Monto_diferido_diario          = (Monto_diferido_diario        * @PorcentajeSaldo)
      ,   Monto_diferido_acumulado       = (Monto_diferido_acumulado     * @PorcentajeSaldo)
      ,   Monto_TC_Diario                = (Monto_TC_Diario              * @PorcentajeSaldo)
      ,   Valor_Mercado_Activo_Mda_Val   = (Valor_Mercado_Activo_Mda_Val * @PorcentajeSaldo)
      ,   Devengo_Recibido_Mda_Val       = (Devengo_Recibido_Mda_Val     * @PorcentajeSaldo)
      ,   Valor_Mercado_Pasivo_Mda_Val   = (Valor_Mercado_Pasivo_Mda_Val * @PorcentajeSaldo)
      ,   Devengo_Pagar_Mda_Val          = (Devengo_Pagar_Mda_Val        * @PorcentajeSaldo)
      ,   Principal_Mda_Val              = (Principal_Mda_Val            * @PorcentajeSaldo)
      ,   Devengo_Neto_Mda_Val           = (Devengo_Neto_Mda_Val         * @PorcentajeSaldo)
      ,   Valor_Mercado_Mda_Val          = (Valor_Mercado_Mda_Val        * @PorcentajeSaldo)
      ,   Monto_Margen                   = (Monto_Margen                 * @PorcentajeSaldo)
      ,   Monto_Margen_CLP               = (Monto_Margen_CLP             * @PorcentajeSaldo)
      ,   Compra_Flujo_Adicional         = (Compra_Flujo_Adicional       * @PorcentajeSaldo)
      ,   Venta_Flujo_Adicional          = (Venta_Flujo_Adicional        * @PorcentajeSaldo)
      ,   FechaMadurez                   = CASE WHEN @PorcentajeSaldo = 0.0 THEN @dFechaHoy ELSE FechaMadurez     END
      ,   FechaLiquidacion               = CASE WHEN @PorcentajeSaldo = 0.0 THEN @dFechaHoy ELSE FechaLiquidacion END
      ,   FechaValuta                    = CASE WHEN @PorcentajeSaldo = 0.0 THEN @dFechaHoy ELSE FechaValuta      END
	  ,   operador						 = case when @cUsuario = '' then operador else @cUsuario end

   -->     8.0 Se generan los registro de cartera a anticipar, a partir del % de capital a Anticipar
   UPDATE #Tmp_Flujos_Saldo
      SET compra_capital                 = (compra_capital               * @PorcentajeSaldo)
	  ,	  compra_amortiza                = (compra_amortiza              * @PorcentajeSaldo)
      ,   compra_saldo                   = (compra_saldo                 * @PorcentajeSaldo)
      ,   compra_interes                 = (compra_interes               * @PorcentajeSaldo)
      ,   venta_capital                  = (venta_capital                * @PorcentajeSaldo)
      ,   venta_amortiza                 = (venta_amortiza               * @PorcentajeSaldo)
      ,   venta_saldo                    = (venta_saldo                  * @PorcentajeSaldo)
      ,   venta_interes                  = (venta_interes                * @PorcentajeSaldo)
      ,   devengo_monto                  = (devengo_monto                * @PorcentajeSaldo)
      ,   devengo_monto_peso             = (devengo_monto_peso           * @PorcentajeSaldo)
      ,   devengo_monto_acum             = (devengo_monto_acum           * @PorcentajeSaldo)
      ,   devengo_monto_ayer             = (devengo_monto_ayer           * @PorcentajeSaldo)
      ,   devengo_compra                 = (devengo_compra               * @PorcentajeSaldo)
      ,   devengo_compra_acum            = (devengo_compra_acum          * @PorcentajeSaldo)
      ,   devengo_compra_acum_peso       = (devengo_compra_acum_peso     * @PorcentajeSaldo)
      ,   devengo_compra_ayer            = (devengo_compra_ayer          * @PorcentajeSaldo)
      ,   devengo_compra_ayer_peso       = (devengo_compra_ayer_peso     * @PorcentajeSaldo)
      ,   devengo_venta                  = (devengo_venta                * @PorcentajeSaldo)
      ,   devengo_venta_acum             = (devengo_venta_acum           * @PorcentajeSaldo)
      ,   devengo_venta_acum_peso        = (devengo_venta_acum_peso      * @PorcentajeSaldo)
      ,   devengo_venta_ayer             = (devengo_venta_ayer           * @PorcentajeSaldo)
      ,   devengo_venta_ayer_peso        = (devengo_venta_ayer_peso      * @PorcentajeSaldo)
      ,   compra_mercado                 = (compra_mercado               * @PorcentajeSaldo)
      ,   compra_mercado_usd             = (compra_mercado_usd           * @PorcentajeSaldo)
      ,   compra_mercado_clp             = (compra_mercado_clp           * @PorcentajeSaldo)
      ,   compra_duration_monto          = (compra_duration_monto        * @PorcentajeSaldo)
      ,   compra_duration_monto_usd      = (compra_duration_monto_usd    * @PorcentajeSaldo)
      ,   ompra_duration_monto_clp       = (ompra_duration_monto_clp     * @PorcentajeSaldo)
      ,   compra_valor_presente          = (compra_valor_presente        * @PorcentajeSaldo)
      ,   venta_mercado                  = (venta_mercado                * @PorcentajeSaldo)
      ,   venta_mercado_usd              = (venta_mercado_usd            * @PorcentajeSaldo)
      ,   venta_mercado_clp              = (venta_mercado_clp            * @PorcentajeSaldo)
      ,   venta_duration_monto           = (venta_duration_monto         * @PorcentajeSaldo)
      ,   venta_duration_monto_usd       = (venta_duration_monto_usd     * @PorcentajeSaldo)
      ,   venta_duration_monto_clp       = (venta_duration_monto_clp     * @PorcentajeSaldo)
      ,   venta_valor_presente           = (venta_valor_presente         * @PorcentajeSaldo)
      ,   compra_valorizada              = (compra_valorizada            * @PorcentajeSaldo)
      ,   compra_variacion               = (compra_variacion             * @PorcentajeSaldo)
      ,   venta_valorizada               = (venta_valorizada             * @PorcentajeSaldo)
      ,   venta_variacion                = (venta_variacion              * @PorcentajeSaldo)
      ,   valorizacion_dia               = (valorizacion_dia             * @PorcentajeSaldo)
      ,   Capital_Pesos_Actual           = (Capital_Pesos_Actual         * @PorcentajeSaldo)
      ,   Capital_Pesos_Ayer             = (Capital_Pesos_Ayer           * @PorcentajeSaldo)
      ,   Monto_diferido_inicial         = (Monto_diferido_inicial       * @PorcentajeSaldo)
      ,   Monto_diferido_diario          = (Monto_diferido_diario        * @PorcentajeSaldo)
      ,   Monto_diferido_acumulado       = (Monto_diferido_acumulado     * @PorcentajeSaldo)
      ,   Monto_TC_Diario                = (Monto_TC_Diario              * @PorcentajeSaldo)
      ,   Valor_Mercado_Activo_Mda_Val   = (Valor_Mercado_Activo_Mda_Val * @PorcentajeSaldo)
      ,   Devengo_Recibido_Mda_Val       = (Devengo_Recibido_Mda_Val     * @PorcentajeSaldo)
      ,   Valor_Mercado_Pasivo_Mda_Val   = (Valor_Mercado_Pasivo_Mda_Val * @PorcentajeSaldo)
      ,   Devengo_Pagar_Mda_Val          = (Devengo_Pagar_Mda_Val        * @PorcentajeSaldo)
      ,   Principal_Mda_Val              = (Principal_Mda_Val            * @PorcentajeSaldo)
      ,   Devengo_Neto_Mda_Val           = (Devengo_Neto_Mda_Val         * @PorcentajeSaldo)
      ,   Valor_Mercado_Mda_Val          = (Valor_Mercado_Mda_Val        * @PorcentajeSaldo)
      ,   Monto_Margen                   = (Monto_Margen                 * @PorcentajeSaldo)
      ,   Monto_Margen_CLP               = (Monto_Margen_CLP             * @PorcentajeSaldo)
      ,   Compra_Flujo_Adicional         = (Compra_Flujo_Adicional       * @PorcentajeSaldo)
      ,   Venta_Flujo_Adicional          = (Venta_Flujo_Adicional        * @PorcentajeSaldo)

      -->    Antes de Traspasar los Flujos, se Mueven los numeros incrementando en uno cada uno de ellos
   UPDATE #Tmp_Flujos_Saldo
      SET Numero_Flujo     = Numero_Flujo + 1

   UPDATE #Tmp_Flujos_Anticipo
      SET Numero_Flujo     = Numero_Flujo + 1

   UPDATE #Tmp_Flujos_Anticipo
      SET fecha_vence_flujo      = @dFechaHoy
      ,   estado                 = 'N'
      ,   FechaLiquidacion       = @dFechaHoy
      ,   modalidad_pago         = @nModalidad
      /*
      --> Documento Pago
      ,   recibimos_documento    = @iPagamosDocumento
      ,   recibimos_moneda       = @iPagamosMoneda
      --> Monto Recibimos
      ,   recibimos_monto        = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END)
      ,   recibimos_monto_USD    = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END) 
      ,   recibimos_monto_CLP    = ABS(CASE WHEN @nValorAnticipo >= 0 THEN @nValorAnticipo   ELSE 0 END)
      */
    WHERE tipo_flujo             = 1


   UPDATE #Tmp_Flujos_Anticipo
      SET fecha_vence_flujo      = @dFechaHoy
      ,   estado                 = 'N'
      ,   FechaLiquidacion       = @dFechaHoy
      ,   modalidad_pago         = @nModalidad
      /*
      --> Moneda Pago
      ,   pagamos_documento      = @iPagamosDocumento
      ,   pagamos_moneda         = @iPagamosMoneda
      --> Monto Pagamos
      ,   pagamos_monto          = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END)
      ,   pagamos_monto_USD      = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END)
      ,   pagamos_monto_CLP      = ABS(CASE WHEN @nValorAnticipo <  0 THEN @nValorAnticipo ELSE 0 END)
      */
    WHERE tipo_flujo             = 2

   /*
   IF @iPagamosMoneda <> 999
      UPDATE #Tmp_Flujos_Anticipo 
         SET pagamos_monto        = ROUND(pagamos_monto_USD   * @nTCCambio, 0)
         ,   pagamos_monto_CLP    = ROUND(pagamos_monto_USD   * @nTCCambio, 0)
         ,   pagamos_monto_USD    = pagamos_monto_CLP
         ,   recibimos_monto      = ROUND(recibimos_monto_USD * @nTCCambio, 0)
         ,   recibimos_monto_CLP  = ROUND(recibimos_monto_USD * @nTCCambio, 0)
         ,   recibimos_monto_USD  = recibimos_monto_USD

   IF @iPagamosMoneda = 999
      UPDATE #Tmp_Flujos_Anticipo
         SET pagamos_monto        = pagamos_monto_CLP
         ,   pagamos_monto_CLP    = pagamos_monto_CLP
         ,   pagamos_monto_USD    = pagamos_monto_CLP   / @nTCCambio

         ,   recibimos_monto      = recibimos_monto_CLP
         ,   recibimos_monto_CLP  = recibimos_monto_CLP
,   recibimos_monto_USD  = recibimos_monto_CLP / @nTCCambio
   */

   DECLARE @capital   NUMERIC(21,4)
   DECLARE @amortiza  NUMERIC(21,4)
   DECLARE @saldo     NUMERIC(21,4)
   DECLARE @interes   NUMERIC(21,4)
   DECLARE @numflujo  INT

   -->    19.0 Elimina la cartera vigente, para poder insertar los anticipos y saldos segun corresponda
   DELETE FROM BacSwapSuda.dbo.TBL_FLJTICKETSWAP
         WHERE numero_operacion = @nContrato

   -->    20.0 Insertar los anticipos y saldos segun corresponda
   INSERT INTO BacSwapSuda.dbo.TBL_FLJTICKETSWAP
      SELECT * FROM #Tmp_Flujos_Saldo

   -->    22.0 Se crea un nuevo registro como flujo para el Anticipo de la operaciòn
   SELECT  @capital         = SUM( compra_capital )
      ,    @amortiza        = SUM( compra_amortiza)
      ,    @saldo           = SUM( compra_saldo   )
      ,    @interes         = SUM( compra_interes )
      ,    @numflujo        = MIN( numero_flujo   )
   FROM    #Tmp_Flujos_Anticipo
   WHERE   tipo_flujo       = 1
   GROUP BY tipo_flujo

   DELETE FROM #Tmp_Flujos_Anticipo
         WHERE numero_flujo > @numflujo
           AND tipo_flujo   = 1

   UPDATE #Tmp_Flujos_Anticipo
      SET numero_flujo      = (@numflujo - 1)
      ,   compra_capital    = @capital
      ,   compra_amortiza   = @amortiza
      ,   compra_saldo      = @saldo
      ,   compra_interes    = @interes
   WHERE  tipo_flujo        = 1

   SELECT @capital          = SUM( venta_capital )
      ,   @amortiza         = SUM( venta_amortiza)
      ,   @saldo            = SUM( venta_saldo   )
      ,   @interes          = SUM( venta_interes )
      ,   @numflujo         = MIN( numero_flujo  )
   FROM   #Tmp_Flujos_Anticipo
   WHERE  tipo_flujo        = 2
   GROUP BY tipo_flujo

   DELETE FROM #Tmp_Flujos_Anticipo
         WHERE numero_flujo > @numflujo
           AND tipo_flujo   = 2

   UPDATE #Tmp_Flujos_Anticipo
      SET numero_flujo     = (@numflujo - 1)
      ,   venta_capital    = @capital
      ,   venta_amortiza   = @amortiza
      ,   venta_saldo      = @saldo
      ,   venta_interes    = @interes
   WHERE  tipo_flujo       = 2

END
GO

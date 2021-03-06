USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZA]
   (   @nNumOpe    NUMERIC(9) 
   ,   @cFecha     CHAR(8) = 'YYYYMMDD'
   )
AS
BEGIN

   SET NOCOUNT ON
   
   DECLARE @dFechaHoy   DATETIME
   ,       @dFechaVcto  DATETIME
   ,       @iProducto   INTEGER

   SELECT  @dFechaHoy       = fechaproc
   FROM    SWAPGENERAL

   SELECT  @dFechaVcto      = fecha_termino
   ,       @iProducto       = Tipo_Swap
   FROM    CARTERA 
   WHERE   numero_operacion = @nNumOpe

   IF @dFechaVcto = @dFechaHoy
   BEGIN
      SET NOCOUNT OFF
      RETURN 
   END

   --> Valorizacion MTM en base a ajuste de Tasas.
   IF @iProducto <> 3
      EXECUTE dbo.SP_AJUSTA_TASAS @nNumOpe

   --> Desconexión de la ejecución de este proceso
   -- Será realizado x el sp_Calculo_ActPas_C08
   --IF @iProducto  = 3
   -- EXECUTE dbo.CALCULO_TASA_PROYECTADA_FRA @nNumOpe --> InternaMente Execute "dbo.SP_AJUSTA_TASAS_FRA"
     
   IF @@ERROR <> 0
   BEGIN
      RAISERROR('Error al Calcular Valores Razonables Ajustados.',16,1,'Error al Calcular Valores Razonables Ajustados.')
      RETURN -1
   END

   ------<< Fechas
   --<< Fecha para Valorizar no viene definida
   IF @cFecha = 'YYYYMMDD' OR @cFecha = ''
      SELECT @cFecha = CONVERT(CHAR(8),fechaproc,112) FROM SwapGeneral

   ------<< Carga Operacion
   SELECT * INTO #Flujos FROM Cartera WHERE numero_operacion = @nNumOpe 
						and estado <> 'N' -- MAP 20071029
					ORDER BY numero_flujo

   IF NOT EXISTS (SELECT 1 FROM #Flujos)
   BEGIN
      SELECT -1, 'No hay flujos para realizar Valorizacion de Mercado'
      SET NOCOUNT OFF
      RETURN 
   END

   ------<< Flujo venciendo
   DECLARE @liqFlow     INTEGER
   SELECT  @liqFlow     = numero_flujo FROM #Flujos    WHERE fecha_vence_flujo = @cFecha
   SELECT  @liqFlow     = ISNULL(@liqFlow,0)

   ------<< Flujos operacion
   DECLARE @maxFlow     INTEGER    -- Total de Flujos
   DECLARE @actFlow     INTEGER    -- Flujo Vigente

   SELECT  @maxFlow     = MAX(numero_flujo)
   ,       @actFlow     = MIN(numero_flujo)
   FROM    #Flujos
   WHERE   numero_flujo > @liqFlow

------<< Datos Generales de Operacion
DECLARE @Producto  INTEGER  -- producto
DECLARE @cMoneda   INTEGER  -- compra
DECLARE @cCodTasa  INTEGER
DECLARE @cMesTasa  INTEGER
DECLARE @cBase     INTEGER
DECLARE @cFactor   INTEGER
DECLARE @vMoneda   INTEGER  -- venta
DECLARE @vCodTasa  INTEGER
DECLARE @vMesTasa  INTEGER
DECLARE @vBase     INTEGER
DECLARE @vFactor   INTEGER
DECLARE @cTipOpe   CHAR(1)
DECLARE @fecInicio CHAR(8)

SELECT  @Producto  = tipo_swap,
        @cMoneda   = compra_moneda,
        @cCodTasa  = compra_codigo_tasa,
        @cMesTasa  = compra_codamo_interes,
        @cBase     = compra_base,
        @cFactor   = CASE WHEN tipo_operacion = 'C' THEN 1 ELSE -1 END,
        @vMoneda   = venta_moneda,
        @vCodTasa  = venta_codigo_tasa,
        @vMesTasa  = venta_codamo_interes,
        @vBase     = venta_base,
        @vFactor   = CASE WHEN tipo_operacion = 'V' THEN 1 ELSE -1 END,
        @cTipOpe   = tipo_operacion,
        @fecInicio = CONVERT(CHAR(8), (CASE WHEN tipo_swap = 3 THEN fecha_inicio ELSE fecha_inicio_flujo END) ,112)
  FROM #Flujos
 WHERE  numero_flujo = @actFlow

------<< Valores de Monedas
DECLARE @cValMon_Ini  FLOAT
DECLARE @cValMon_Hoy  FLOAT
DECLARE @vValMon_Ini  FLOAT
DECLARE @vValMon_Hoy  FLOAT

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )
                               END
      FROM BacSwapSuda..SWAPGENERAL
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos


SELECT @cValMon_Ini = vmvalor FROM View_Valor_Moneda
                             WHERE vmcodigo = @cMoneda
                               AND vmfecha  = @fecInicio

SELECT @cValMon_Hoy = vmvalor FROM View_Valor_Moneda
                             WHERE vmcodigo = @cMoneda
                               AND vmfecha  = CASE WHEN @cMoneda = 998 THEN @FechaCalculos ELSE @cFecha END
                                              --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

SELECT @vValMon_Ini = vmvalor FROM View_Valor_Moneda
                             WHERE vmcodigo = @vMoneda
                               AND vmfecha  = @fecInicio

SELECT @vValMon_Hoy = vmvalor FROM View_Valor_Moneda
                             WHERE vmcodigo = @vMoneda
                               AND vmfecha  = CASE WHEN @vMoneda = 998 THEN @FechaCalculos ELSE @cFecha END
                                              --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

IF @cValMon_Ini IS NULL OR @cValMon_Ini = 0      BEGIN
   SELECT -1, 'No hay Valor de Moneda ' + CONVERT(CHAR(3),@cMoneda) +
              ' para el ' + CONVERT(CHAR(10),Convert(datetime,@fecInicio),103)
   SET NOCOUNT OFF
   RETURN 
END

IF @cValMon_Hoy IS NULL OR @cValMon_Hoy = 0      BEGIN
   SELECT -1, 'No hay Valor de Moneda ' + CONVERT(CHAR(3),@cMoneda) +
              ' para el ' + CONVERT(CHAR(10),Convert(datetime,@cFecha),103)
   SET NOCOUNT OFF
   RETURN 
END

IF @vValMon_Ini IS NULL OR @vValMon_Ini = 0      BEGIN
   SELECT -1, 'No hay Valor de Moneda ' + CONVERT(CHAR(3),@vMoneda) +
              ' para el ' + CONVERT(CHAR(10),Convert(datetime,@fecInicio),103)
   SET NOCOUNT OFF
   RETURN 
END

IF @vValMon_Hoy IS NULL OR @vValMon_Hoy = 0      BEGIN
   SELECT -1, 'No hay Valor de Moneda ' + CONVERT(CHAR(3),@vMoneda) +
              ' para el ' + CONVERT(CHAR(10),Convert(datetime,@cFecha),103)
   SET NOCOUNT OFF
   RETURN 
END

------<< Calculo de Duration
DECLARE @Duration     FLOAT
DECLARE @DurationDias INTEGER

SELECT  @Duration = 0.0

IF @cCodTasa = 0 OR (@Producto = 1 AND @cMoneda IN (13,994))
   EXECUTE dbo.SP_DURATION @nNumOpe, 'C', @cFecha, @Duration OUTPUT  

IF @vCodTasa = 0 OR (@Producto = 1 AND @vMoneda IN (13,994))
   EXECUTE dbo.SP_DURATION @nNumOpe, 'V', @cFecha, @Duration OUTPUT  

--<< Duration en dias
SELECT @DurationDias = @Duration * 360

------<< Variables para Valorizacion
DECLARE @IniFlow        CHAR(8)
DECLARE @FinFlow        CHAR(8)
DECLARE @Dias           INTEGER  -- Dias para Calculos
DECLARE @TenorFlow      INTEGER  -- Dias para el termino del Flujo desde Hoy

DECLARE @cCapital       FLOAT    -- Capital Vigente
DECLARE @cAmortiza      FLOAT    -- Amortizacion
DECLARE @cCodMRK        INTEGER  -- Codigo Tasa Mercado a Utilizar
DECLARE @cValTasa       FLOAT    -- Valor de Tasa Flujo
DECLARE @cHoyTasa       FLOAT    -- Valor de Tasa Flujo Actual
DECLARE @cDUR           FLOAT    -- Tasa de Duration
DECLARE @cCNT           FLOAT    -- Tasa de Contrato
DECLARE @cMRK           FLOAT    -- Tasa de Mercado
DECLARE @cZCR           FLOAT    -- Tasa ZCR para Descuesto de Intereses
DECLARE @cVPteCNT       FLOAT
DECLARE @cVPteMRK       FLOAT
DECLARE @cDifMRK        FLOAT    -- Diferencia (CNT - MRK)
DECLARE @cValorMTM      FLOAT
DECLARE @cDevAcu        FLOAT    -- Devengo Acumulado en $$
DECLARE @cVarTC         FLOAT    -- Variacion T/C (hoy - inicio)

DECLARE @vCapital       FLOAT    -- Capital Vigente
DECLARE @vAmortiza      FLOAT    -- Amortizacion
DECLARE @vCodMRK        INTEGER  -- Codigo Tasa Mercado a Utilizar
DECLARE @vValTasa       FLOAT    -- Valor de Tasa Flujo
DECLARE @vHoyTasa       FLOAT    -- Valor de Tasa Flujo Actual
DECLARE @vDUR           FLOAT    -- Tasa de Duration
DECLARE @vCNT           FLOAT    -- Tasa de Contrato
DECLARE @vMRK           FLOAT    -- Tasa de Mercado
DECLARE @vZCR           FLOAT    -- Tasa ZCR para Descuesto de Intereses
DECLARE @vVPteCNT       FLOAT
DECLARE @vVPteMRK       FLOAT
DECLARE @vDifMRK        FLOAT    -- Diferencia (MRK - CNT)
DECLARE @vValorMTM      FLOAT
DECLARE @vDevAcu        FLOAT    -- Devengo Acumulado en $$
DECLARE @vVarTC         FLOAT    -- Variacion T/C (inicio - hoy)

------------<< Valorizacion Mercado
DECLARE @iFlow INTEGER

SELECT  @iFlow = @actFlow

WHILE (@iFlow <= @maxFlow)   BEGIN

--      PRINT 'Calculando MTM de Flujos'

      ----<< Datos del Flujo
      SELECT @cCapital  = compra_saldo + compra_amortiza,
             @cAmortiza = compra_amortiza,
             @cCodMRK   = CASE WHEN @cMoneda = 999 THEN 1 		-- Tasa $$
                               WHEN @cMoneda = 998 THEN 2 ELSE 3 END,	-- Tasa UF o Libor
             @cValTasa  = compra_valor_tasa,
             @cHoyTasa  = compra_valor_tasa_hoy,
             @cDevAcu   = devengo_compra_acum,
             @vCapital  = venta_saldo +  venta_amortiza,
       @vAmortiza = venta_amortiza,
             @vCodMRK   = CASE WHEN @vMoneda = 999 THEN 1  -- Tasa $$
                               WHEN @vMoneda = 998 THEN 2 ELSE 3 END,    -- Tasa UF o Libor
             @vValTasa  = venta_valor_tasa,
             @vHoyTasa  = venta_valor_tasa_hoy,
             @vDevAcu   = devengo_venta_acum,
             @IniFlow   = CONVERT(CHAR(8),fecha_inicio_flujo,112),
             @FinFlow   = CONVERT(CHAR(8),fecha_vence_flujo,112),
             @TenorFlow = DATEDIFF(day, @cFecha, fecha_vence_flujo)
        FROM #Flujos
       WHERE numero_flujo = @iFlow

      IF @iFlow = @actFlow
           SELECT @IniFlow = @cFecha

      ----<< Tasas de Mercado
--      PRINT 'Calculando Tasas de Mercado'

      SELECT @cMRK = @cHoyTasa
      SELECT @vMRK = @vHoyTasa

      --<< Compra
      IF @cCodTasa = 0 OR @iFlow <> @actFlow
         SET @Dias = @DurationDias
      ELSE
         SET @Dias = DATEDIFF(DAY, @FechaCalculos, @FinFlow) --> DATEDIFF(day, @cFecha, @FinFlow)
                     --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

      EXECUTE dbo.SP_LEER_TASA @cCodMRK, @cMoneda, @Dias, @cMRK OUTPUT, @cFecha  

      --<< Venta
      IF @vCodTasa = 0 OR @iFlow <> @actFlow
         SET @Dias = @DurationDias
      ELSE
         SET @Dias = DATEDIFF(DAY, @FechaCalculos, @FinFlow) -->  DATEDIFF(dd, @cFecha, @FinFlow)
                     --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos --> @FechaCalculos

      EXECUTE dbo.SP_LEER_TASA @vCodMRK, @vMoneda, @Dias, @vMRK OUTPUT, @cFecha  

      ----<< Tasas en base a Operaci¢n
      EXECUTE dbo.SP_BASE_X 365, @cBase, @cMRK OUTPUT  
      EXECUTE dbo.SP_BASE_X 365, @vBase, @vMRK OUTPUT  

      -- SELECT 'Tasas Mercado 365',@cMRK,@cBase,@vMRK,@vBase  -- PENDIENTE quitar

      ----<< Tasa de Contrato
--      PRINT 'Calculando Tasas Contrato'

      IF @cCodTasa <> 0 AND @iFlow > @actFlow
         SELECT @cCNT = @cMRK
      ELSE
         SELECT @cCNT = @cHoyTasa

      IF @vCodTasa <> 0 AND @iFlow > @actFlow
         SELECT @vCNT = @vMRK
      ELSE
         SELECT @vCNT = @vHoyTasa

      ----<< Intereses segun Tasas Contrato/Mercado
--      PRINT 'Calculando Intereses segun Tasas Contrato/Mercado'

      --<< Contrato
      EXECUTE dbo.SP_BASEINTERES @cBase, @IniFlow, @FinFlow, @cCNT, @cVPteCNT OUTPUT  
      EXECUTE dbo.SP_BASEINTERES @vBase, @IniFlow, @FinFlow, @vCNT, @vVPteCNT OUTPUT  

      SELECT @cVPteCNT = (@cCapital * @cVpteCNT) + CASE WHEN @Producto = 3 THEN 0 ELSE @cAmortiza END
      SELECT @vVPteCNT = (@vCapital * @vVpteCNT) + CASE WHEN @Producto = 3 THEN 0 ELSE @vAmortiza END

      -- SELECT 'CNT.Compra' = @cVpteCNT , 'CNT.Venta ' = @vVpteCNT  -- PENDIENTE quitar

      --<< Mercado
      EXECUTE dbo.SP_BASEINTERES @cBase, @IniFlow, @FinFlow, @cMRK, @cVPteMRK OUTPUT  
      EXECUTE dbo.SP_BASEINTERES @vBase, @IniFlow, @FinFlow, @vMRK, @vVPteMRK OUTPUT  

      SELECT @cVPteMRK = (@cCapital * @cVpteMRK) + CASE WHEN @Producto = 3 THEN 0 ELSE @cAmortiza END
      SELECT @vVPteMRK = (@vCapital * @vVpteMRK) + CASE WHEN @Producto = 3 THEN 0 ELSE @vAmortiza END

      -- SELECT 'MRK.Compra' = @cVpteMRK , 'MRK.Venta ' = @vVpteMRK -- PENDIENTE quitar

      ----<< Diferencias
--      PRINT 'Diferencia de Intereses entre Contrato y Mercado'

      SELECT @cDifMRK = (@cVPteCNT - @cVPteMRK) --* @cFactor
      SELECT @vDifMRK = (@vVPteMRK - @vVPteCNT) --* @vFactor
     
      -- SELECT 'Dif.C' = @cDifMRK , @cVPteCNT , @cVPteMRK, @cFactor  -- PENDIENTE quitar 
      -- SELECT 'Dif.V' = @vDifMRK , @vVPteCNT , @vVPteMRK, @vFactor  -- PENDIENTE quitar

      ----<< Tasas Zero Coupon Rate
--      PRINT 'Calculo de Tasas ZCR'
      SELECT @cZCR = 0
      SELECT @vZCR = 0

      EXECUTE dbo.SP_ZCR @cCodMRK, @cMoneda, @TenorFlow, @cZCR  OUTPUT  
      EXECUTE dbo.SP_ZCR @vCodMRK, @vMoneda, @TenorFlow, @vZCR  OUTPUT  

      -- SELECT 'Compra',@cCodMRK, @cMoneda, @TenorFlow, @cZCR      -- PENDIENTE quitar
      -- SELECT 'Venta' ,@vCodMRK, @vMoneda, @TenorFlow, @vZCR      -- PENDIENTE quitar  

      IF @cZCR IS NULL OR @vZCR IS NULL     BEGIN
         IF @cZCR IS NULL 
	    BEGIN
            	SELECT -1, 'Tasa ZCR para Flujo #' + CONVERT(VARCHAR(3),@iFlow) + ' No puede ser calculada para Compra'
		SET NOCOUNT OFF
        	RETURN 

	    END 	
         ELSE
	    BEGIN	
	        SELECT -1, 'Tasa ZCR para Flujo #' + CONVERT(VARCHAR(3),@iFlow) + ' No puede ser calculada para Venta'
		SET NOCOUNT OFF
	        RETURN 
         END
      END

      ----<< Valor MTM
      EXECUTE dbo.SP_VPTEDESCUENTO @cDifMRK, @cZCR, @TenorFlow, @cDifMRK OUTPUT  
      EXECUTE dbo.SP_VPTEDESCUENTO @vDifMRK, @vZCR, @TenorFlow, @vDifMRK OUTPUT  

      SELECT @cValorMTM = ROUND( @cDifMRK * @cValMon_Hoy , 0 )
      SELECT @vValorMTM = ROUND( @vDifMRK * @vValMon_Hoy , 0 )

      -- SELECT 'VPte C' = @cValorMTM , @cDifMRK, @cZCR, @TenorFlow   -- PENDIENTE quitar
      -- SELECT 'VPte V' = @vValorMTM , @vDifMRK, @vZCR, @TenorFlow   -- PENDIENTE quitar

      ----<< Solo Swaps de Monedas para Flujo Vigente
      IF @iFlow = @actFlow AND @Producto = 2 BEGIN
         SELECT @cVarTC  = ROUND( @cCapital * (@cValMon_Hoy - @cValMon_Ini) , 0 )
         SELECT @vVarTC  = ROUND( @vCapital * (@vValMon_Hoy - @vValMon_Ini) , 0 )

         SELECT @cDevAcu = ROUND( @cDevAcu * @cValMon_Hoy , 0 )
         SELECT @vDevAcu = ROUND( @vDevAcu * @vValMon_Hoy , 0 )

         SELECT @cValorMTM = @cValorMTM + @cDevAcu + (@cVarTC * @cFactor)
         SELECT @vValorMTM = @vValorMTM + @vDevAcu + (@cVarTC * @cFactor)
      END

      ----<< Actualiza Cartera
      UPDATE Cartera
         SET fecha_valoriza             = @cFecha,
             compra_zcr                 = @cZCR,
             compra_mercado_tasa        = @cMRK,
             compra_mercado             = @cVPteMRK,
             compra_mercado_clp         = @cVPteMRK,
             compra_duration_tasa       = @cCNT,
             compra_duration_monto      = @cVPteCNT,
             compra_duration_monto_clp  = @cVPteCNT,
             compra_valor_presente      = @cDifMRK,
             venta_zcr                  = @vZCR,
             venta_mercado_tasa         = @vMRK,
             venta_mercado              = @vVPteMRK,
             venta_mercado_clp          = @vVPteMRK,
             venta_duration_tasa        = @vCNT,
             venta_duration_monto       = @vVPteCNT,
             venta_duration_monto_clp   = @vVPteCNT,
             venta_valor_presente       = @vDifMRK,
             monto_mtm                  = @cDifMRK   - @vDifMRK,
             monto_mtm_clp              = @cValorMTM - @vValorMTM
       WHERE numero_operacion = @nNumOpe
         AND numero_flujo     = @iFlow

      IF @@error <> 0   BEGIN
         SELECT -1, 'No se puede Actualizar Datos MTM de Flujo #' + CONVERT(VARCHAR(3),@iFlow)
	 SET NOCOUNT OFF
         RETURN 
      END

      SELECT @iFlow = @iFlow + 1

END -- WHILE

   SELECT 1
   SET NOCOUNT OFF

END
GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_MAXIMO_M2M]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIEFIN_MAXIMO_M2M] 
(  @Fecha  DATETIME
 , @Rut    numeric(13)= 0
 , @Codigo numeric(3) = 0)

AS
BEGIN
-- SP_RIEFIN_MAXIMO_M2M '20110311'
-- SP_RIEFIN_MAXIMO_M2M '20110329', 76624380, 1


	-- SET NOCOUNT ON added to prevent extra result sets from  -- select * from with no-lock bacLineas..linea_general
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if @Rut = 0 -- Recálulo
    BEGIN
	
		-- La Tabla THreshold cumple indicando los clientes
		-- a los cuales se aplica la metodogía Threshold y Netting
		-- Por ahora se simulara los mismo con el valor threshol 
		-- mayor que 1 en linea_general
		-- No perder de vista que esto debe quedar recibiendo un rut 
		-- como parámetro.

		-- =============================================
		-- Importante:	
		-- Duplicación de código y cambio a modelo 
		-- cartera vigente. Orientado a la imputación
		-- de cliente On-Line
		-- =============================================

		-- Flujos Swaps
		SELECT
			[Rut] = TRESHOLD.Rut_Cliente
		,   [Codigo] = TRESHOLD.Codigo_Cliente
		,	[Fecha Liquidacion] = CARTERA.fechaliquidacion
		,	[Flujo Neto] = SUM(CARTERA.Activo_FlujoCLP - CARTERA.Pasivo_FlujoCLP)
		INTO #TEMPORAL
		FROM
			BACSWAPSUDA.dbo.CARTERARES CARTERA
		,	BacLineas..linea_general TRESHOLD
		WHERE
			CARTERA.fecha_proceso= @Fecha
		AND	CARTERA.estado = ''
		AND	CARTERA.Rut_Cliente = TRESHOLD.Rut_Cliente
		AND CARTERA.Codigo_cliente = TRESHOLD.Codigo_cliente
		-- Verifica condicion de Early Termination. Cuando el derivado tiene valor positivo
		-- para el cliente, tiene incentivo a anticipar, por lo que el vencimiento sale del analisis
		AND (
				CARTERA.Valor_RazonableCLP >= 0
			OR
				(
					CARTERA.Valor_RazonableCLP < 0
				AND
					CARTERA.Numero_Operacion Not In
					(
						SELECT
							Numero_Operacion
						FROM
							TBL_RieFinListado_Operaciones_Early_Termination
						WHERE
						Tipo_Operacion = 'Swap'
					)
				)
			)
		GROUP BY
			CARTERA.fechaliquidacion
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente

		
		-- Flujos Forwards
		INSERT #TEMPORAL
		SELECT
			TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente
		,	CARTERA.cafecvcto
		,	SUM(CARTERA.ValorRazonableActivo - CARTERA.ValorRazonablePasivo)
		FROM
			Bacfwdsuda.dbo.MFCARES CARTERA
		LEFT JOIN
			TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX
			ON
				FIX.Rut = CARTERA.cacodigo
			AND	FIX.Codigo = CARTERA.cacodcli
		,	BacLineas..linea_general TRESHOLD
		WHERE
			CARTERA.cafechaproceso = @Fecha
		AND CARTERA.CaAntici = ''
		AND CARTERA.cacodigo = TRESHOLD.rut_Cliente
		AND CARTERA.CaCodCli = TRESHOLD.Codigo_cliente
		-- Verifica condicion de Early Termination. Cuando el derivado tiene valor positivo
		-- para el cliente, tiene incentivo a anticipar, por lo que el vencimiento sale del analisis
		AND (
				CARTERA.ValorRazonableActivo >= CARTERA.ValorRazonablePasivo
			OR
				(
					CARTERA.ValorRazonableActivo < CARTERA.ValorRazonablePasivo
				AND
					CARTERA.CaNumOper Not In
					(
						SELECT
							Numero_Operacion
						FROM
							TBL_RieFinListado_Operaciones_Early_Termination
						WHERE
						Tipo_Operacion = 'Forward'
					)
				)
			)
		GROUP BY
			CARTERA.cafecvcto
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente

		
		-- Flujo opciones
		-- Evaluar otorgar permiso directo al BacUser
		-- a opciones select * from lnkOpc.CbMdbopc.dbo.caencContrato
		INSERT #TEMPORAL
		SELECT
			TRESHOLD.Rut_CLiente
		,   TRESHOLD.Codigo_Cliente
		,	Detalle.CaFechaVcto
		,	SUM(Detalle.CaVrDetML)
		FROM
			LNKOpc.CbMdbOpc.dbo.CaResEncContrato Contrato
		,	LNKOpc.CbMdbOpc.dbo.CaResDetContrato	Detalle -- select * from LNKOpc.CbMdbOpc.dbo.CaResEncContrato
		,	BacLineas..linea_general TRESHOLD
		WHERE
			Contrato.CaEncFechaRespaldo = @Fecha
		AND Contrato.CaRutCliente = TRESHOLD.Rut_Cliente
		AND Contrato.CaCodigo     =  TRESHOLD.Codigo_Cliente
		AND Contrato.CaEstado = ''
		AND	Contrato.CaEncFechaRespaldo = Detalle.CaDetFechaRespaldo
		AND	Contrato.CaNumContrato = Detalle.CaNumContrato	
		GROUP BY
			Detalle.CaFechaVcto
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente
		

		-- Suma los flujos acumulados a cada fecha de vencimiento
		SELECT
			X.Rut
		,   X.Codigo
		,	Y.[Fecha Liquidacion]
		,	Y.[Flujo Neto]
		,	[ACUMULADO] = SUM(X.[Flujo Neto])
		INTO #TEMPORAL_2
		FROM
			#TEMPORAL AS X
			INNER JOIN #TEMPORAL AS Y
			  ON X.RUT = Y.RUT
		WHERE
			X.[Fecha Liquidacion] >= Y.[Fecha Liquidacion]
		GROUP BY
			Y.[Fecha Liquidacion]
		,	X.Rut , X.Codigo
		,	Y.[Flujo Neto]
		
		-- Esta operacion se hace para no permitir que se dupliquen valores
		DELETE
			TBL_RieFinTabla_Max_Exp
		WHERE
			Fecha = @Fecha
		
		
		INSERT INTO TBL_RieFinTabla_Max_Exp
		SELECT
			@Fecha
		,	RESUMEN.Rut, RESUMEN.Codigo
		,	SUM(RESUMEN.[Flujo Neto])
		,	MAX(RESUMEN.ACUMULADO)
		FROM
			#TEMPORAL_2 RESUMEN
		GROUP BY
			RESUMEN.Rut, RESUMEN.Codigo
		ORDER BY
			RESUMEN.Rut, RESUMEN.Codigo
	END -- @Rut = 0
ELSE 
	-- =============================================
	-- Importante:	
	-- Duplicación de código y cambio a modelo 
    -- cartera vigente. Orientado a la imputación
    -- de cliente On-Line
	-- =============================================

	-- Se duplica codigo por prefomance
	-- Se recomienda, en caso de mantensión 
    -- VOlver a copiar lo de arriba y
    -- Aplicar nuevamente los parámetros
    -- Trabajar sobre cartera directamente
    BEGIN
		-- La Tabla THreshold cumple indicando los clientes
		-- a los cuales se aplica la metodogía Threshold y Netting
		-- Por ahora se simulara los mismo con el valor threshol 
		-- mayor que 1 en linea_general
		-- No perder de vista que esto debe quedar recibiendo un rut 
		-- como parámetro.

        -- Flujos Swaps
		SELECT
			[Rut] = TRESHOLD.Rut_Cliente
		,   [Codigo] = TRESHOLD.Codigo_Cliente
		,	[Fecha Liquidacion] = CARTERA.fechaliquidacion
		,	[Flujo Neto] = SUM(CARTERA.Activo_FlujoCLP - CARTERA.Pasivo_FlujoCLP)
		INTO #TEMPORAL_Rut
		FROM
			BACSWAPSUDA.dbo.CARTERA CARTERA
		,	BacLineas..linea_general TRESHOLD
		WHERE
			CARTERA.estado = ''
        AND CARTERA.Rut_Cliente = @Rut
        AND CARTERA.Codigo_Cliente = @Codigo
		AND	CARTERA.Rut_Cliente = TRESHOLD.Rut_Cliente
		AND CARTERA.Codigo_cliente = TRESHOLD.Codigo_cliente
		-- Verifica condicion de Early Termination. Cuando el derivado tiene valor positivo
		-- para el cliente, tiene incentivo a anticipar, por lo que el vencimiento sale del analisis
		AND (
				CARTERA.Valor_RazonableCLP >= 0
			OR
				(
					CARTERA.Valor_RazonableCLP < 0
				AND
					CARTERA.Numero_Operacion Not In
					(
						SELECT
							Numero_Operacion
						FROM
							TBL_RieFinListado_Operaciones_Early_Termination
						WHERE
						Tipo_Operacion = 'Swap'
					)
				)
			)
		GROUP BY
			CARTERA.fechaliquidacion
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente

		
		-- Flujos Forwards
		INSERT #TEMPORAL_Rut
		SELECT
			TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente
		,	CARTERA.cafecvcto
		,	SUM(CARTERA.ValorRazonableActivo - CARTERA.ValorRazonablePasivo)
		FROM
			Bacfwdsuda.dbo.MFCA CARTERA
		LEFT JOIN
			TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX
			ON
				FIX.Rut = CARTERA.cacodigo
			AND	FIX.Codigo = CARTERA.cacodcli
		,	BacLineas..linea_general TRESHOLD
		WHERE
            CARTERA.CaAntici = ''
		AND CARTERA.cacodigo = @Rut
		AND CARTERA.CaCodCli = @Codigo
		AND CARTERA.cacodigo = TRESHOLD.rut_Cliente
		AND CARTERA.CaCodCli = TRESHOLD.Codigo_cliente
		-- Verifica condicion de Early Termination. Cuando el derivado tiene valor positivo
		-- para el cliente, tiene incentivo a anticipar, por lo que el vencimiento sale del analisis
		AND (
				CARTERA.ValorRazonableActivo >= CARTERA.ValorRazonablePasivo
			OR
				(
					CARTERA.ValorRazonableActivo < CARTERA.ValorRazonablePasivo
				AND
					CARTERA.CaNumOper Not In
					(
						SELECT
							Numero_Operacion
						FROM
							TBL_RieFinListado_Operaciones_Early_Termination
						WHERE
						Tipo_Operacion = 'Forward'
					)
				)
			)
		GROUP BY
			CARTERA.cafecvcto
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente

		
		-- Flujo opciones
		-- Evaluar otorgar permiso directo al BacUser
		-- a opciones select * from lnkOpc.CbMdbopc.dbo.caencContrato
		INSERT #TEMPORAL_Rut
		SELECT
			TRESHOLD.Rut_CLiente
		,   TRESHOLD.Codigo_Cliente
		,	Detalle.CaFechaVcto
		,	SUM(Detalle.CaVrDetML)
		FROM
			LNKOpc.CbMdbOpc.dbo.CaEncContrato Contrato
		,	LNKOpc.CbMdbOpc.dbo.CaDetContrato	Detalle -- select * from LNKOpc.CbMdbOpc.dbo.CaResEncContrato
		,	BacLineas..linea_general TRESHOLD
		WHERE
            Contrato.CaRutCliente = @Rut
		AND Contrato.CaCodigo     = @Codigo
		AND	Contrato.CaRutCliente = TRESHOLD.Rut_Cliente
		AND Contrato.CaCodigo     =  TRESHOLD.Codigo_Cliente
		AND Contrato.CaEstado = ''
		AND	Contrato.CaNumContrato = Detalle.CaNumContrato	
		GROUP BY
			Detalle.CaFechaVcto
		,	TRESHOLD.Rut_Cliente
		,   TRESHOLD.Codigo_Cliente
		

		-- Suma los flujos acumulados a cada fecha de vencimiento
		SELECT
			X.Rut
		,   X.Codigo
		,	Y.[Fecha Liquidacion]
		,	Y.[Flujo Neto]
		,	[ACUMULADO] = SUM(X.[Flujo Neto])
		INTO #TEMPORAL_2_Rut
		FROM
			#TEMPORAL_Rut AS X
			INNER JOIN #TEMPORAL_Rut AS Y
			  ON X.RUT = Y.RUT
		WHERE
			X.[Fecha Liquidacion] >= Y.[Fecha Liquidacion]
		GROUP BY
			Y.[Fecha Liquidacion]
		,	X.Rut , X.Codigo
		,	Y.[Flujo Neto]
		
		-- Esta operacion se hace para no permitir que se dupliquen valores
		DELETE
			TBL_RieFinTabla_Max_Exp  -- select * from TBL_RieFinTabla_Max_Exp
		WHERE
			Fecha = @Fecha
		and Rut   = @Rut
        and Codigo = @Codigo 
		
		INSERT INTO TBL_RieFinTabla_Max_Exp
		SELECT
			@Fecha
		,	RESUMEN.Rut, RESUMEN.Codigo
		,	SUM(RESUMEN.[Flujo Neto])
		,	MAX(RESUMEN.ACUMULADO)
		FROM
			#TEMPORAL_2_Rut RESUMEN
		GROUP BY
			RESUMEN.Rut, RESUMEN.Codigo
		ORDER BY
			RESUMEN.Rut, RESUMEN.Codigo
	END -- @Rut <> 0
END
GO

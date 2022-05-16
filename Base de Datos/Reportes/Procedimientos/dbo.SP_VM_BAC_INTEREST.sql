USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_INTEREST]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz INTEREST: (swap fowd, opciones y spot)
-- ================================================
--INT_FLOW	          ID del Flujo de Intereses. Indicar el flujo desde 0 a n.
--INS_ID	          ID del Instrumento.
--SD_ID	int	          ID de la Pata.
--CFT_ID	          ID del tipo de Flujo de Efectivo que se generará una vez vencido el flujo o cupón. Ver catálogo tabla : CFLOW_TYPE, se informa el ID.
--INT_START_DATE	  Fecha de Inicio de cada Flujo o Cupón de Intereses.
--INT_END_DATE	      Fecha de Término de cada Flujo o Cupón de Intereses.
--INT_PAYMENT_DATE	  Fecha de Pago de cada Flujo o Cupón de Intereses.
--INT_ACCOUNTING_DATE Fecha de Contabilización de cada Flujo o Cupón de Intereses.
--INT_DCF	          Day Count Factor e cada Flujo o Cupón de Intereses.
--INT_AMOUNT          Monto de intereses de cada Flujo o Cupón de Intereses.
--INT_RATE	          Tasa de intereses de cada Flujo o Cupón de Intereses.
--INT_SPREAD          Spread aplicado sobre la tasa de intereses de cada Flujo o Cupón de Intereses.
--INT_NOTIONAL        Valor del Nocional o Residual de cada Flujo o Cupón de Intereses.

-- ================================================

--IF OBJECT_ID('SP_VM_BAC_INTEREST')>0
--	DROP PROCEDURE DBO.SP_VM_BAC_INTEREST
--GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX INTEREST
-- =============================================

--EXEC SP_VM_BAC_INTEREST
CREATE PROCEDURE [dbo].[SP_VM_BAC_INTEREST]
AS BEGIN 

--BEGIN TRAN

SET NOCOUNT ON 
SET DATEFORMAT DMY
 
DECLARE @SEP  VARCHAR(1) 
    SET @SEP  = ','


	CREATE TABLE #VM_BAC_INTEREST
		 ( INT_FLOW             INT
			, INS_ID               INT
			, SD_ID                INT
			, CFT_ID               INT
			, INT_START_DATE       VARCHAR(20)
			, INT_END_DATE         VARCHAR(20)
			, INT_PAYMENT_DATE     VARCHAR(20)
			, INT_ACCOUNTING_DATE  VARCHAR(20)
			, INT_DCF              float--NUMERIC(19,4)
			, INT_AMOUNT           NUMERIC(25,10)
			, INT_RATE             NUMERIC(14,10)
			, INT_SPREAD           NUMERIC(14,10)
			, INT_NOTIONAL         NUMERIC(20,5)
         )
         
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	DECLARE @Con_Linea_Encabezado VARCHAR(1)	-- PLL-20200512
	SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512
	
	DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

	--AQUI
	/*
	SELECT *
	INTO #PASO
	FROM BacSwapSuda..CARTERARES
	WHERE Fecha_Proceso =  @FECHA_SWP
	*/
	--SELECT '#PASO' AS TABLA,Fecha_Proceso,* FROM #PASO
	--AQUI

	CREATE TABLE #VM_BAC_INTEREST_SALIDA
	(
	SD_ID		Int,		--PARA COMPATIBILIDAD DE SALIDA
	INS_ID	Int,		--PARA COMPATIBILIDAD DE SALIDA
	INT_FLOW	Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

         
	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================
	INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT INT_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --	0		-- RECIEVE
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  =LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.COMPRA_INTERES AS NUMERIC(25,10))	--CAB.COMPRA_INTERES
			, INT_RATE             =  CAST(CAB.COMPRA_VALOR_TASA AS NUMERIC(14,10))	--CAB.COMPRA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.COMPRA_SPREAD AS NUMERIC(14,10))	--CAB.COMPRA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))		--CAB.COMPRA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         = CAST(CASE WHEN CAB.COMPRA_SALDO = 0 THEN CAB.COMPRA_AMORTIZA ELSE CAB.COMPRA_SALDO END AS NUMERIC(20,5))-- CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))--CAST(CASE WHEN CAB.COMPRA_AMORTIZA = 0 THEN CAB.COMPRA_SALDO ELSE CAB.COMPRA_AMORTIZA END AS NUMERIC(20,5))	
		FROM BACSWAPSUDA..CARTERA AS CAB 
		WHERE CAB.TIPO_FLUJO   = 1 
			AND CAB.ESTADO_FLUJO IN (0,1) 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and estado<>'N'--anticipado
--			AND NOT CAB.COMPRA_SALDO = 0
			--AND numero_operacion = 2413--AQUI

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	SELECT	 U.numero_operacion
			,U.numero_flujo										
			,U.tipo_flujo
			,ISNULL(R.fecha_inicio_flujo	,U.fecha_inicio_flujo)	AS fecha_inicio_flujo
			,ISNULL(R.fecha_vence_flujo		,U.fecha_vence_flujo)	AS fecha_vence_flujo 
			,ISNULL(R.FechaLiquidacion		,U.FechaLiquidacion)	AS FechaLiquidacion
	INTO #CARTRESUNW
	FROM	BacSwapSuda..CARTERA_UNWIND		U 
	INNER JOIN BacSwapSuda..SwapGeneral		G ON	1=1
	LEFT JOIN BacSwapSuda..CARTERARES		R ON	R.Fecha_Proceso		= G.fechaant
											AND		R.numero_operacion	= U.numero_operacion
											AND		R.numero_flujo		= U.numero_flujo-2
											AND		R.tipo_flujo		= U.tipo_flujo
	WHERE	U.FechaAnticipo		= @FECHA_SWP
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT INT_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --	0		-- RECIEVE
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  =LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.COMPRA_INTERES AS NUMERIC(25,10))	--CAB.COMPRA_INTERES
			, INT_RATE             =  CAST(CAB.COMPRA_VALOR_TASA AS NUMERIC(14,10))	--CAB.COMPRA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.COMPRA_SPREAD AS NUMERIC(14,10))	--CAB.COMPRA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))		--CAB.COMPRA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         =  CAST(CASE WHEN CAB.COMPRA_SALDO = 0 THEN CAB.COMPRA_AMORTIZA ELSE CAB.COMPRA_SALDO END AS NUMERIC(20,5))--CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))--CAST(CASE WHEN CAB.COMPRA_AMORTIZA = 0 THEN CAB.COMPRA_SALDO ELSE CAB.COMPRA_AMORTIZA END AS NUMERIC(20,5))		
		FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB
		INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
									AND CABR.numero_flujo		= CAB.numero_flujo
									AND CABR.tipo_flujo			= CAB.tipo_flujo
		WHERE CAB.TIPO_FLUJO   = 1 
			AND CAB.FECHAANTICIPO	= @FECHA_SWP  
			AND CAB.fecha_termino	= CAB.fecha_vence_flujo
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT INT_FLOW	= CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --	0		-- RECIEVE
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  =LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.COMPRA_INTERES AS NUMERIC(25,10))	--CAB.COMPRA_INTERES
			, INT_RATE             =  CAST(CAB.COMPRA_VALOR_TASA AS NUMERIC(14,10))	--CAB.COMPRA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.COMPRA_SPREAD AS NUMERIC(14,10))	--CAB.COMPRA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))		--CAB.COMPRA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.COMPRA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         =  CAST(CASE WHEN CAB.COMPRA_SALDO = 0 THEN CAB.COMPRA_AMORTIZA ELSE CAB.COMPRA_SALDO END AS NUMERIC(20,5))--CAST(CAB.COMPRA_SALDO AS NUMERIC(20,5))----CAST(CASE WHEN CAB.COMPRA_AMORTIZA = 0 THEN CAB.COMPRA_SALDO ELSE CAB.COMPRA_AMORTIZA END AS NUMERIC(20,5))		
		FROM BACSWAPSUDA..CARTERAHIS AS CAB 
		INNER JOIN #VM_BAC_INTEREST CABI ON CABI.INS_ID = CAB.numero_operacion
		LEFT JOIN #VM_BAC_INTEREST I ON		I.INS_ID	= CAB.NUMERO_OPERACION-->>REFERENCIA CARTERA VENCIDA
										AND I.INT_FLOW	= CAB.NUMERO_FLUJO
										AND I.SD_ID		= CAB.tipo_flujo
		WHERE CAB.TIPO_FLUJO   = 1 
			AND CAB.ESTADO_FLUJO IN (2)-->>ESTADO VENCIDO
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and CAB.estado			<>'N'
			--AND CAB.NUMERO_OPERACION = 81
			AND I.INS_ID IS NULL
		ORDER BY 1
	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC

	
    -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT INT_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1    -- PAY
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  = LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))  
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.VENTA_INTERES AS NUMERIC(25,10))	--CAB.VENTA_INTERES
			, INT_RATE             =  CAST(CAB.VENTA_VALOR_TASA AS NUMERIC(14,10))	--CAB.VENTA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.VENTA_SPREAD AS NUMERIC(14,10))	--CAB.VENTA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))		--CAB.VENTA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         =  CAST(CASE WHEN CAB.VENTA_SALDO = 0 THEN CAB.VENTA_AMORTIZA ELSE CAB.VENTA_SALDO END AS NUMERIC(20,5))--CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))--CAST(CASE WHEN CAB.VENTA_AMORTIZA = 0 THEN CAB.VENTA_SALDO ELSE CAB.VENTA_AMORTIZA END AS NUMERIC(20,5))					
		FROM BACSWAPSUDA..CARTERA AS CAB 
		WHERE CAB.TIPO_FLUJO   = 2 
			AND CAB.ESTADO_FLUJO IN (0,1) 
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and estado<>'N'--anticipado
--			AND NOT CAB.VENTA_SALDO = 0
			--AND numero_operacion = 2413--AQUI

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
		INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT INT_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1    -- PAY
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       = LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         = LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     = LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  = LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))  
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.VENTA_INTERES AS NUMERIC(25,10))	--CAB.VENTA_INTERES
			, INT_RATE             =  CAST(CAB.VENTA_VALOR_TASA AS NUMERIC(14,10))	--CAB.VENTA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.VENTA_SPREAD AS NUMERIC(14,10))	--CAB.VENTA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))		--CAB.VENTA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         =  CAST(CASE WHEN CAB.VENTA_SALDO = 0 THEN CAB.VENTA_AMORTIZA ELSE CAB.VENTA_SALDO END AS NUMERIC(20,5))--CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))--CAST(CASE WHEN CAB.VENTA_AMORTIZA = 0 THEN CAB.VENTA_SALDO ELSE CAB.VENTA_AMORTIZA END AS NUMERIC(20,5))					
		FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
							AND CABR.numero_flujo		= CAB.numero_flujo
							AND CABR.tipo_flujo			= CAB.tipo_flujo
		WHERE CAB.TIPO_FLUJO   = 2
			AND CAB.FECHAANTICIPO	= @FECHA_SWP  
			AND CAB.fecha_termino	= CAB.fecha_vence_flujo
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_INTEREST
		SELECT DISTINCT  INT_FLOW	= CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
			, INS_ID               =  CAB.NUMERO_OPERACION
			, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1    -- PAY
			, CFT_ID               =  7                        -- INTEREST (CFLOW_TYPE)
			--, INT_START_DATE       =  CONVERT(CHAR(10),CAB.FECHA_INICIO_FLUJO,120)
			, INT_START_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_INICIO_FLUJO,108))
			--, INT_END_DATE         =  CONVERT(CHAR(10),CAB.FECHA_VENCE_FLUJO,120)
			, INT_END_DATE         = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHA_VENCE_FLUJO,108))
			--, INT_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_PAYMENT_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, INT_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, INT_ACCOUNTING_DATE  = LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) --+ ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))  
			, INT_DCF              =  CAB.PLAZOFLUJO
			, INT_AMOUNT           =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(25,10))--CAST(CAB.VENTA_INTERES AS NUMERIC(25,10))	--CAB.VENTA_INTERES
			, INT_RATE             =  CAST(CAB.VENTA_VALOR_TASA AS NUMERIC(14,10))	--CAB.VENTA_VALOR_TASA
			, INT_SPREAD           =  CAST(CAB.VENTA_SPREAD AS NUMERIC(14,10))	--CAB.VENTA_SPREAD
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))		--CAB.VENTA_SALDO
			--, INT_NOTIONAL         =  CAST(CAB.VENTA_AMORTIZA AS NUMERIC(20,5))		
			, INT_NOTIONAL         =  CAST(CASE WHEN CAB.VENTA_SALDO = 0 THEN CAB.VENTA_AMORTIZA ELSE CAB.VENTA_SALDO END AS NUMERIC(20,5))--CAST(CAB.VENTA_SALDO AS NUMERIC(20,5))--CAST(CASE WHEN CAB.VENTA_AMORTIZA = 0 THEN CAB.VENTA_SALDO ELSE CAB.VENTA_AMORTIZA END AS NUMERIC(20,5))					
		FROM BACSWAPSUDA..CARTERAHIS AS CAB 
		INNER JOIN #VM_BAC_INTEREST CABI ON CABI.INS_ID =  CAB.NUMERO_OPERACION
		LEFT JOIN #VM_BAC_INTEREST I ON		I.INS_ID	= CAB.NUMERO_OPERACION-->>REFERENCIA CARTERA VENCIDA
										AND I.INT_FLOW	= CAB.NUMERO_FLUJO
										AND I.SD_ID		= CAB.TIPO_FLUJO
		WHERE CAB.TIPO_FLUJO   = 2 
			AND CAB.ESTADO_FLUJO IN (2) -->>ESTADO VENCIDO
			and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
			and CAB.estado			<>'N'
			--AND CAB.NUMERO_OPERACION = 81
			AND I.INS_ID IS NULL
		ORDER BY 1
	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC

	--SELECT * FROM #VM_BAC_INTEREST WHERE INS_ID = 10470 ORDER BY 1

	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_INTEREST_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT DISTINCT
			"SD_ID" = SD_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"INS_ID" = INS_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"INT_FLOW" = INT_FLOW,	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			LTRIM(INT_FLOW)             + @SEP 
		+ LTRIM(INS_ID)               + @SEP 
		+ LTRIM(SD_ID)                + @SEP 
		+ LTRIM(CFT_ID)           + @SEP 
		+ LTRIM(INT_START_DATE)       + @SEP 
		+ LTRIM(INT_END_DATE)         + @SEP 
		+ LTRIM(INT_PAYMENT_DATE)     + @SEP 
		+ LTRIM(INT_ACCOUNTING_DATE)  + @SEP 
		+ LTRIM(INT_DCF)              + @SEP 
		+ LTRIM(INT_AMOUNT)           + @SEP 
		+ LTRIM(INT_RATE)             + @SEP 
		+ LTRIM(INT_SPREAD)           + @SEP 
		+ LTRIM(INT_NOTIONAL)        AS REG_SALIDA 
      FROM #VM_BAC_INTEREST
    --ORDER BY SD_ID, INS_ID, INT_FLOW		-- se comenta porque no es necesario a este nivel-- PLL-20200512
	
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      
	INSERT INTO #VM_BAC_INTEREST_SALIDA
		SELECT 
			SD_ID = 0,
			"INS_ID" = 0, 
			"INT_FLOW" = 0, 
			"REG_SALIDA" = 'INT_FLOW'	+ @SEP 
								+ 'INS_ID'	+ @SEP 
								+ 'SD_ID'	+ @SEP 
								+ 'CFT_ID'	+ @SEP 
								+ 'INT_START_DATE'	+ @SEP 
								+ 'INT_END_DATE'		+ @SEP 
								+ 'INT_PAYMENT_DATE'	+ @SEP 
								+ 'INT_ACCOUNTING_DATE' + @SEP 
								+ 'INT_DCF'		+ @SEP 
								+ 'INT_AMOUNT'	+ @SEP 
								+ 'INT_RATE'	+ @SEP 
								+ 'INT_SPREAD'	+ @SEP 
								+ 'INT_NOTIONAL' 
			WHERE 
				@Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_INTEREST_SALIDA 
	ORDER BY INS_ID, INT_FLOW, SD_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

	DROP TABLE #VM_BAC_INTEREST
	DROP TABLE #VM_BAC_INTEREST_SALIDA
END 
GO

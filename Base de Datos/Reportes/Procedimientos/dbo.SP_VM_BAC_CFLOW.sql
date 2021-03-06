USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_CFLOW]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--IF OBJECT_ID('SP_VM_BAC_CFLOW')>0 
--	DROP PROCEDURE DBO.SP_VM_BAC_CFLOW
--GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX AMORTIZACIONES SWAPS
-- =============================================
-- 20200916 - AJUSTE DE VALOR "CFT_ID"

--EXEC SP_VM_BAC_CFLOW
CREATE PROCEDURE [dbo].[SP_VM_BAC_CFLOW]
AS BEGIN 
SET NOCOUNT ON 
SET DATEFORMAT DMY
 
DECLARE @SEP  VARCHAR(1) 
    SET @SEP  = ','

	CREATE TABLE #VM_BAC_CFLOW
		 ( CF_FLOW             INT
			, CFT_ID              INT
			, INS_ID              INT
			, SD_ID               INT
			, CF_PAYMENT_DATE     VARCHAR(20)
			, CF_ACCOUNTING_DATE  VARCHAR(20)
			, CF_AMOUNT	       NUMERIC(21,4)
         )
      
	DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS


	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	CREATE TABLE #VM_BAC_CFLOW_SALIDA
	(
	SD_ID			Int,		--PARA COMPATIBILIDAD DE SALIDA
	INS_ID		Int,		--PARA COMPATIBILIDAD DE SALIDA
	CF_FLOW		Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA	Varchar(100))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

         
	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================
	INSERT INTO #VM_BAC_CFLOW
    SELECT DISTINCT CF_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE COMPRA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
         , CFT_ID              =  3 --siempre se envia constante 3  
         , INS_ID              =  CAB.NUMERO_OPERACION
			, SD_ID               =  CAB.TIPO_FLUJO		--MODIF. 20201006-solicitado x CAMILO P. -- 0 = RECIEVE
			--, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
         , CF_AMOUNT           =  CAB.COMPRA_AMORTIZA
      FROM BACSWAPSUDA..CARTERA AS CAB 
     WHERE CAB.TIPO_FLUJO   = 1 
       AND CAB.ESTADO_FLUJO IN (0,1) 
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and estado<>'N'--anticipado
	ORDER BY CAB.numero_operacion

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
		INSERT INTO #VM_BAC_CFLOW
		SELECT DISTINCT CF_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE COMPRA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
         , CFT_ID              =  3 --siempre se envia constante 3  
         , INS_ID              =  CAB.NUMERO_OPERACION
			, SD_ID               =  CAB.TIPO_FLUJO		--MODIF. 20201006-solicitado x CAMILO P. -- 0 = RECIEVE
			--, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CABR.FECHALIQUIDACION,108))
			--, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CABR.FECHALIQUIDACION,108))
         , CF_AMOUNT           =  CAB.COMPRA_AMORTIZA
      FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	  INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
									AND CABR.numero_flujo		= CAB.numero_flujo
									AND CABR.tipo_flujo			= CAB.tipo_flujo
     WHERE	CAB.TIPO_FLUJO		= 1 
		AND CAB.FECHAANTICIPO	= @FECHA_SWP  
		AND CAB.fecha_termino	= CAB.fecha_vence_flujo
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_CFLOW
	SELECT DISTINCT CF_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE COMPRA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
         , CFT_ID              =  3 --siempre se envia constante 3  
         , INS_ID              =  CAB.NUMERO_OPERACION
			, SD_ID               =  CAB.TIPO_FLUJO		--MODIF. 20201006-solicitado x CAMILO P. -- 0 = RECIEVE
			--, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
			--, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))
         , CF_AMOUNT           =  CAB.COMPRA_AMORTIZA
     FROM BACSWAPSUDA..CARTERAHIS AS CAB 
	 INNER JOIN #VM_BAC_CFLOW	CABF ON CABF.INS_ID = CAB.numero_operacion
	 LEFT JOIN #VM_BAC_CFLOW I ON	I.INS_ID	= CAB.numero_operacion
								AND I.CF_FLOW	= CAB.numero_flujo
								AND I.SD_ID		= CAB.tipo_flujo
     WHERE CAB.TIPO_FLUJO   = 1 
       AND CAB.ESTADO_FLUJO IN (2) -->>ESTADO VENCIDO
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO <>'N'
		AND I.INS_ID IS NULL
		--AND CAB.NUMERO_OPERACION = 10470--aqui
	ORDER BY 3

	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC


    -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_CFLOW
    SELECT DISTINCT  CF_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE VENTA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
		 , CFT_ID              =  3 --siempre se envia constante 3           
		 , INS_ID              =  CAB.NUMERO_OPERACION
		 , SD_ID               =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
		 --, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
		 , CF_PAYMENT_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))         
         --, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))         
         , CF_AMOUNT           =  CAB.VENTA_AMORTIZA
      FROM BACSWAPSUDA..CARTERA AS CAB 
     WHERE CAB.TIPO_FLUJO   = 2 
       AND CAB.ESTADO_FLUJO IN (0,1) 
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and estado<>'N'--anticipado

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
		INSERT INTO #VM_BAC_CFLOW
		SELECT DISTINCT CF_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE COMPRA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
         , CFT_ID              =  3 --siempre se envia constante 3  
         , INS_ID              =  CAB.NUMERO_OPERACION
			, SD_ID               =  CAB.TIPO_FLUJO		--MODIF. 20201006-solicitado x CAMILO P. -- 0 = RECIEVE
			--, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_PAYMENT_DATE     =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CABR.FECHALIQUIDACION,108))
			--, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CABR.FECHALIQUIDACION,108))
         , CF_AMOUNT           =  CAB.VENTA_AMORTIZA
      FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
									AND CABR.numero_flujo		= CAB.numero_flujo
									AND CABR.tipo_flujo			= CAB.tipo_flujo
     WHERE	CAB.TIPO_FLUJO		= 2 
		AND CAB.FECHAANTICIPO	= @FECHA_SWP  
		AND CAB.fecha_termino	= CAB.fecha_vence_flujo
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_CFLOW
    SELECT DISTINCT CF_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
         --, CFT_ID              =  CASE VENTA_CODAMO_CAPITAL 
         --                              WHEN 6  THEN  3 -- BULLET // NOTIONAL FINAL
         --                              ELSE -1 END -- BONOS, SEM. TRI, MEN.  // NONE
		 , CFT_ID              =  3 --siempre se envia constante 3           
		 , INS_ID              =  CAB.NUMERO_OPERACION
		 , SD_ID               =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
		 --, CF_PAYMENT_DATE     =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
		 , CF_PAYMENT_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))         
         --, CF_ACCOUNTING_DATE  =  CONVERT(CHAR(10),CAB.FECHALIQUIDACION,120)
			, CF_ACCOUNTING_DATE	 =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHALIQUIDACION,103)) + ' ' + LTRIM(CONVERT(VARCHAR(5),CAB.FECHALIQUIDACION,108))         
         , CF_AMOUNT           =  CAB.VENTA_AMORTIZA
     FROM BACSWAPSUDA..CARTERAHIS AS CAB 
	 INNER JOIN #VM_BAC_CFLOW CABF ON CABF.INS_ID = CAB.numero_operacion
	 LEFT JOIN #VM_BAC_CFLOW I ON	I.INS_ID	= CAB.numero_operacion
								AND I.CF_FLOW	= CAB.numero_flujo
								AND I.SD_ID		= CAB.tipo_flujo
     WHERE CAB.TIPO_FLUJO   = 2 
       AND CAB.ESTADO_FLUJO IN (2) -->>ESTADO VENCIDO
		AND CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO <>'N'
		AND I.INS_ID IS NULL
		--AND CAB.NUMERO_OPERACION = 81
	ORDER BY 1
	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	
	
	--select '#VM_BAC_CFLOW' as tabla,* from #VM_BAC_CFLOW where ins_id = 5457 ORDER BY 2--aqui
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	 INSERT INTO #VM_BAC_CFLOW_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512         
    SELECT DISTINCT 
    "SD_ID" = SD_ID,		--PARA COMPATIBILIDAD DE SALIDA
	 "INS_ID" = INS_ID,		--PARA COMPATIBILIDAD DE SALIDA
	 "CF_FLOW" = CF_FLOW,		--PARA COMPATIBILIDAD DE SALIDA
		LTRIM(CF_FLOW)             + @SEP 
		+ LTRIM(CFT_ID)              + @SEP 
		+ LTRIM(INS_ID)              + @SEP 
		+ LTRIM(SD_ID)               + @SEP 
		+ LTRIM(CF_PAYMENT_DATE)     + @SEP 
		+ LTRIM(CF_ACCOUNTING_DATE)  + @SEP 
		+ LTRIM(CF_AMOUNT)          AS REG_SALIDA 
      FROM #VM_BAC_CFLOW
      --ORDER BY SD_ID, INS_ID, CF_FLOW		-- PLL-20200512- NO ES NECESARIO EN ESTE INSERT

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_CFLOW_SALIDA
		SELECT  
			SD_ID = 0,		--PARA COMPATIBILIDAD DE SALIDA
			INS_ID = 0,		--PARA COMPATIBILIDAD DE SALIDA
			CF_FLOW = 0,		--PARA COMPATIBILIDAD DE SALIDA
			"REG_SALIDA" = 'CF_FLOW' + @SEP + 
										'CFT_ID' + @SEP  + 
										'INS_ID' + @SEP  + 
										'SD_ID' + @SEP  + 
										'CF_PAYMENT_DATE' + @SEP  + 
										'CF_ACCOUNTING_DATE' + @SEP  + 
										'CF_AMOUNT'

	SELECT REG_SALIDA FROM #VM_BAC_CFLOW_SALIDA 
	ORDER BY INS_ID, SD_ID, CF_FLOW	
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      

	DROP TABLE #VM_BAC_CFLOW
	DROP TABLE #VM_BAC_CFLOW_SALIDA
END 
GO

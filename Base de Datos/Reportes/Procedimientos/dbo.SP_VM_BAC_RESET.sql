USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_RESET]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--IF OBJECT_ID('SP_VM_BAC_RESET')>0
--	DROP PROCEDURE DBO.SP_VM_BAC_RESET
--GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX RESET (FIJACIONES)
-- =============================================

--EXEC SP_VM_BAC_RESET
CREATE PROCEDURE [dbo].[SP_VM_BAC_RESET]
AS BEGIN 

--BEGIN TRAN

SET NOCOUNT ON 
SET DATEFORMAT DMY
 
DECLARE @SEP  VARCHAR(1); SET @SEP  = ','
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512

DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

	CREATE TABLE #VM_BAC_RESET
         ( RST_FLOW             INT
			, INS_ID               INT
			, SD_ID                INT
			, RST_RESET_DATE       VARCHAR(20)
			, RST_ACC_START_DATE   VARCHAR(20)
			, RST_ACC_END_DATE     VARCHAR(20)
			, RST_ACC_DCF          NUMERIC(21,4)
			, RST_VALUE            NUMERIC(21,4)
         )
         	
	CREATE TABLE #VM_BAC_RESET_SALIDA
	(
	SD_ID             Int,		--PARA COMPATIBILIDAD DE SALIDA
	INS_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	RST_FLOW				Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

         
	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)    -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0			-- RECIEVE
		, RST_RESET_DATE       =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHARESET,103)) 
		, RST_ACC_START_DATE   =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     =  	LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CAB.PLAZOFLUJO
		, RST_VALUE            =  CAB.COMPRA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 1 
       AND CAB.ESTADO_FLUJO IN (0,1) 
       and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	   and estado<>'N'--anticipado
	

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	SELECT	 U.numero_operacion
			,U.numero_flujo										
			,U.tipo_flujo
			,ISNULL(R.fecha_inicio_flujo	,U.fecha_inicio_flujo)	AS fecha_inicio_flujo
			,ISNULL(R.fecha_vence_flujo		,U.fecha_vence_flujo)	AS fecha_vence_flujo 
			,ISNULL(R.FechaLiquidacion		,U.FechaLiquidacion)	AS FechaLiquidacion
			,ISNULL(r.fechareset			,u.fechareset)			AS FechaReset
			,ISNULL(r.plazoflujo			,u.plazoflujo)			AS plazoflujo
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
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)    -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0			-- RECIEVE
		, RST_RESET_DATE       =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHARESET,103)) 
		, RST_ACC_START_DATE   =  LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     =  	LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CABR.PLAZOFLUJO
		, RST_VALUE            =  CAB.COMPRA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB
	INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
									AND CABR.numero_flujo	= CAB.numero_flujo
									AND CABR.tipo_flujo		= CAB.tipo_flujo
	WHERE CAB.TIPO_FLUJO   = 1 
		AND CAB.FECHAANTICIPO	= @FECHA_SWP  
		AND CAB.fecha_termino	= CAB.fecha_vence_flujo
        and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW	= CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)    -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0			-- RECIEVE
		, RST_RESET_DATE       =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHARESET,103)) 
		, RST_ACC_START_DATE   =  LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     =  	LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CAB.PLAZOFLUJO
		, RST_VALUE            =  CAB.COMPRA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERAHIS AS CAB 
	INNER JOIN #VM_BAC_RESET CABR ON CABR.INS_ID = CAB.NUMERO_OPERACION
	LEFT JOIN #VM_BAC_RESET I ON	I.INS_ID	= CAB.NUMERO_OPERACION-->>REFERENCIA CARTERA VENCIDA
							AND		I.RST_FLOW	= CAB.NUMERO_FLUJO
							AND		I.SD_ID		= CAB.TIPO_FLUJO
	WHERE CAB.TIPO_FLUJO   = 1 
       AND CAB.ESTADO_FLUJO IN (2)-->>ESTADO VENCIDO 
       and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	   and CAB.estado			<>'N'
	   --AND CAB.numero_operacion = 5457
	   AND I.INS_ID IS NULL
	ORDER BY 1

	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC


   -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW             = CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1          -- PAY
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.FECHARESET,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CAB.PLAZOFLUJO
		, RST_VALUE            =  CAB.VENTA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 2 
		AND CAB.ESTADO_FLUJO IN (0,1) 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and estado<>'N'--anticipado

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW             = CAB.NUMERO_FLUJO-2--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1          -- PAY
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CABR.FECHARESET,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CABR.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CABR.PLAZOFLUJO
		, RST_VALUE            =  CAB.VENTA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	INNER JOIN #CARTRESUNW CABR ON	CABR.numero_operacion	= CAB.numero_operacion
									AND CABR.numero_flujo	= CAB.numero_flujo
									AND CABR.tipo_flujo		= CAB.tipo_flujo
	WHERE CAB.TIPO_FLUJO   = 2
		AND CAB.FECHAANTICIPO	= @FECHA_SWP  
		AND CAB.fecha_termino	= CAB.fecha_vence_flujo
        and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	-->>CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	INSERT INTO #VM_BAC_RESET
	SELECT DISTINCT RST_FLOW	= CAB.NUMERO_FLUJO--(CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N)
			/*
			RST_FLOW =	(SELECT MAX(TEM.NUMERO_FLUJO) FROM BACSWAPSUDA..CARTERA TEM 
							WHERE TEM.NUMERO_OPERACION = CAB.NUMERO_OPERACION
							AND TEM.TIPO_FLUJO = CAB.TIPO_FLUJO)
			*/				
		, INS_ID               =  CAB.NUMERO_OPERACION
		, SD_ID                =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1          -- PAY
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.FECHARESET,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_INICIO_FLUJO,103)) 
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.FECHA_VENCE_FLUJO,103)) 
		, RST_ACC_DCF          =  CAB.PLAZOFLUJO
		, RST_VALUE            =  CAB.VENTA_VALOR_TASA
	FROM BACSWAPSUDA..CARTERAHIS AS CAB 
	INNER JOIN #VM_BAC_RESET CABR ON CABR.INS_ID = CAB.NUMERO_OPERACION
	LEFT JOIN #VM_BAC_RESET I ON	I.INS_ID	= CAB.NUMERO_OPERACION-->>REFERENCIA CARTERA VENCIDA
								AND I.RST_FLOW	= CAB.NUMERO_FLUJO
								AND I.SD_ID		= CAB.TIPO_FLUJO
	WHERE CAB.TIPO_FLUJO   = 2 
		AND CAB.ESTADO_FLUJO IN (2)-->>ESTADO VENCIDO
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		and CAB.estado			<>'N'
		--AND CAB.NUMERO_OPERACION = 5457
		AND I.INS_ID IS NULL
	ORDER BY 1
	--<<CVM.20211019 SIID - Flujos Vencidos Operaciones de BAC
	   	 


   -- ================================================
	-- FORWARD
	-- ================================================
	INSERT INTO #VM_BAC_RESET
	SELECT RST_FLOW           = 1--0   -- (SE INFORMA A PARTIR DE 0 A N) 
		, INS_ID               = CAB.canumoper
		, SD_ID                = 1							-->> 1=PATA 1 - 2 = PATA 2
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103))		--0
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103))		--0
		, RST_ACC_DCF          = 0
		, RST_VALUE            = CAB.capremon1	--CAB.catipcam
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	INSERT INTO #VM_BAC_RESET
	SELECT RST_FLOW           = 1--0   -- (SE INFORMA A PARTIR DE 0 A N) 
		, INS_ID               = CAB.canumoper
		, SD_ID                = 2							-->> 1=PATA 1 - 2 = PATA 2
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103))		--0
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.cafecEfectiva,103))		--0
		, RST_ACC_DCF          = 0
		, RST_VALUE            = CAB.capremon2
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P') 
		--and		CAB.capremon2 <> 0
		
	-- ================================================
	-- OPCIONES
	-- ================================================
	INSERT INTO #VM_BAC_RESET
	SELECT RST_FLOW           = CAB.CaFixNumero--(CAB.CaFixNumero - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
	      /*
	      RST_FLOW	= (SELECT MAX(TEM.CAFIXNUMERO) FROM CBMDBOPC..CAFIXING TEM 
							WHERE TEM.CANUMCONTRATO = CAB.CANUMCONTRATO)
			*/				
		--, INS_ID               = CAB.CaNumContrato
		, INS_ID               = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(CAB.CaNumEstructura AS VARCHAR(10))
		, SD_ID                = CAB.CaNumEstructura
		, RST_RESET_DATE       = LTRIM(CONVERT(VARCHAR(20),CAB.CaFixFecha,103)) 
		, RST_ACC_START_DATE   = LTRIM(CONVERT(VARCHAR(20),CAB.CaFixFecha,103)) 
		, RST_ACC_END_DATE     = LTRIM(CONVERT(VARCHAR(20),CAB.CaFixFecha,103)) 
		, RST_ACC_DCF          = 0
		, RST_VALUE            = CAB.CaFijacion
	FROM CbMdbOpc..CaFixing AS CAB INNER JOIN	CbMdbOpc..CaEncContrato AS EC ON
			CAB.CanumContrato = EC.CanumContrato
	WHERE 
		EC.CaEstado <> 'C' --AND --Se excluyen las Cotizaciones  --PLL-20201113
--		CAB.CaFijacion <> 0
		
	--SELECT * FROM #VM_BAC_RESET 	WHERE INS_ID IN(10470) 	ORDER BY SD_ID, RST_FLOW
	
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_RESET_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"SD_ID" = SD_ID,			--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"INS_ID" = INS_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"RST_FLOW" = RST_FLOW,	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
				LTRIM(RST_FLOW)             + @SEP
         + LTRIM(INS_ID)               + @SEP
		 + LTRIM(SD_ID)                + @SEP
         + LTRIM(RST_RESET_DATE)       + @SEP
         + LTRIM(RST_ACC_START_DATE)   + @SEP
         + LTRIM(RST_ACC_END_DATE)     + @SEP
		 + LTRIM(RST_ACC_DCF)          + @SEP
         + LTRIM(RST_VALUE)		        AS REG_SALIDA 
       FROM #VM_BAC_RESET
      --ORDER BY SD_ID, INS_ID, RST_FLOW	-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_RESET_SALIDA
		SELECT 
			"SD_ID" = 0,
			"INS_ID" = 0, 
			"RST_FLOW" = 0, 
			"REG_SALIDA" = 'RST_FLOW'	+ @SEP
							+ 'INS_ID'		+ @SEP
							+ 'SD_ID'		+ @SEP
							+ 'RST_RESET_DATE'		+ @SEP
							+ 'RST_ACC_START_DATE'	+ @SEP
							+ 'RST_ACC_END_DATE'	+ @SEP
							+ 'RST_ACC_DCF'		+ @SEP
							+ 'RST_VALUE' 
		WHERE 
			@Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_RESET_SALIDA 
	ORDER BY INS_ID, SD_ID, RST_FLOW
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512


	DROP TABLE #VM_BAC_RESET
	DROP TABLE #VM_BAC_RESET_SALIDA 
END 
GO

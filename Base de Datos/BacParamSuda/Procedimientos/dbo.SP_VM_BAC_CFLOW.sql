USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_CFLOW]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
    SELECT CF_FLOW             = (CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
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

    -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_CFLOW
    SELECT CF_FLOW             = (CAB.NUMERO_FLUJO - 1)   -- (SE INFORMA A PARTIR DE 0 A N) 
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

	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	 INSERT INTO #VM_BAC_CFLOW_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512         
    SELECT 
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

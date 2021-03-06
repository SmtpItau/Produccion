USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_INSTRUMENT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz INSTRUMENT: (swap fowd, opciones y spot)
-- ================================================
--	INS_ID            Indica el ID del Instrumento generado.
--	INS_UNDERLYING_ID Indica el ID de un Instrumento Subyacente. Esto aplica solo para instrumentos que subyacen de otro. Aplica para productos como FX Spot, Bonos, Futuros, FX Options.
--	INSC_ID           Indica el ID de la categoría del Instrumento. Ver catálogo tabla: INS_CATEGORY, se informa el ID.
--	INSG_ID           Indica el ID del grupo del Instrumento. Ver catálogo tabla: INS_GROUP se informa el ID.
--	INSS_ID           Indica el ID del estado del Instrumento. Ver catálogo tabla: INS_STATUS, se informa el ID.
--	INST_ID           Indica el ID del tipo de Instrumento. Ver catálogo tabla: INS_TYPE, se informa el ID.
--	BASE_CCY_ID       Indica el ID de la moneda base en que emitió o dio de alta el Instrumento. Ver catálogo tabla: CURRENCY, se informa el ID.
--	INSAT_ID          Indica el ID de la clase de activo asociada a cada Instrumento. Ver catálogo tabla: INS_ASSET_TYPE, se informa el ID.
--	INS_NAME          Indica una Etiqueta para identificar el Instrumento. Opcional.
-- ================================================
--IF OBJECT_ID('SP_VM_BAC_INSTRUMENT')>0
--	DROP PROCEDURE DBO.SP_VM_BAC_INSTRUMENT
--GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX INSTRUMENT
-- =============================================

--EXEC SP_VM_BAC_INSTRUMENT
CREATE PROCEDURE [dbo].[SP_VM_BAC_INSTRUMENT]
AS BEGIN 

SET NOCOUNT ON 
 
DECLARE @SEP  VARCHAR(1); SET @SEP  = ','
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'	-- PLL-20200512

DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

--	De/Para	BASE_CCY_ID
SELECT "mu_BASE_CCY_ID" = 0, Cod_BAC = 'CLP' INTO #PasoBASE_CCY UNION
SELECT "mu_BASE_CCY_ID" = 51, Cod_BAC = 'JPY' UNION
SELECT "mu_BASE_CCY_ID" = 52, Cod_BAC = 'GBP' UNION
SELECT "mu_BASE_CCY_ID" = 53, Cod_BAC = 'CHF' UNION
SELECT "mu_BASE_CCY_ID" = 54, Cod_BAC = 'CAD' UNION
SELECT "mu_BASE_CCY_ID" = 55, Cod_BAC = 'AUD' UNION
SELECT "mu_BASE_CCY_ID" = 56, Cod_BAC = 'SEK' UNION
SELECT "mu_BASE_CCY_ID" = 57, Cod_BAC = 'DKK' UNION
SELECT "mu_BASE_CCY_ID" = 58, Cod_BAC = 'NOK' UNION
SELECT "mu_BASE_CCY_ID" = 59, Cod_BAC = 'NZD' UNION
SELECT "mu_BASE_CCY_ID" = 60, Cod_BAC = 'EUR' UNION
SELECT "mu_BASE_CCY_ID" = 61, Cod_BAC = 'USD' UNION
SELECT "mu_BASE_CCY_ID" = 62, Cod_BAC = 'CLF' UNION
SELECT "mu_BASE_CCY_ID" = 63, Cod_BAC = 'BRL' UNION
SELECT "mu_BASE_CCY_ID" = 64, Cod_BAC = 'ZAR' UNION
SELECT "mu_BASE_CCY_ID" = 65, Cod_BAC = 'CNY' UNION
SELECT "mu_BASE_CCY_ID" = 66, Cod_BAC = 'MXN' UNION
SELECT "mu_BASE_CCY_ID" = 67, Cod_BAC = 'COP' UNION
SELECT "mu_BASE_CCY_ID" = 68, Cod_BAC = 'HKD' UNION
SELECT "mu_BASE_CCY_ID" = 69, Cod_BAC = 'PEN' 
--SELECT * FROM #PasoBASE_CCY

    
CREATE TABLE #VM_BAC_INSTRUMENT
	( INS_ID            Int	 	
	, INS_UNDERLYING_ID Int	 	
	, INSC_ID           Int	 	
	, INSG_ID           Int	 	
	, INSS_ID           Int	 	
	, INST_ID           Int	 	
	, BASE_CCY_ID       int	 	
	, INSAT_ID          int	 	
	, INS_NAME          Varchar(40))


--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
CREATE TABLE #VM_BAC_INSTRUMENT_SALIDA
	(
	INS_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
	INST_ID           Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(1000))
--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

	-- ================================================
	-- SWAPS
	-- ================================================
	INSERT INTO #VM_BAC_INSTRUMENT
	SELECT DISTINCT 
		  INS_ID            = NUMERO_OPERACION
		, INS_UNDERLYING_ID = NUMERO_OPERACION
		, INSC_ID           = 0
		, INSG_ID           = 0
		, INSS_ID           = 1
		, INST_ID           = CASE TIPO_SWAP WHEN 1 THEN 1005 -- TASA / IRS-ML
										  WHEN 2 THEN 1001 -- MONEDA / CCS-ML
										  WHEN 3 THEN 1005 -- FRA / IRS-ML
										  WHEN 4 THEN 1005 -- CAMARA / IRS-ML
								END
		, BASE_CCY_ID       = 0
		, INSAT_ID          = 0
		, INS_NAME          = ''
      FROM BACSWAPSUDA..CARTERA
      WHERE ESTADO_FLUJO IN (0,1)
      and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	  and estado			<>'N'-->20211117 no se considera anticipo
--      AND NOT (TIPO_SWAP = 2)		--TIPO_SWAP=2="MONEDA / CCS-ML"-PLL20200514-version 11=No se identifica el uso de esta extraccion para operaciones de Moneda.	 

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_INSTRUMENT
	SELECT DISTINCT 
		  INS_ID            = NUMERO_OPERACION
		, INS_UNDERLYING_ID = NUMERO_OPERACION
		, INSC_ID           = 0
		, INSG_ID           = 0
		, INSS_ID           = 1
		, INST_ID           = CASE TIPO_SWAP WHEN 1 THEN 1005 -- TASA / IRS-ML
										  WHEN 2 THEN 1001 -- MONEDA / CCS-ML
										  WHEN 3 THEN 1005 -- FRA / IRS-ML
										  WHEN 4 THEN 1005 -- CAMARA / IRS-ML
								END
		, BASE_CCY_ID       = 0
		, INSAT_ID          = 0
		, INS_NAME          = ''
      FROM BACSWAPSUDA..CARTERA_UNWIND CAB
      WHERE CAB.FECHAANTICIPO	= @FECHA_SWP  
		AND CAB.fecha_termino	= CAB.fecha_vence_flujo
		and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS

	-- ================================================
	-- FORWARD
	-- ================================================
	INSERT INTO #VM_BAC_INSTRUMENT
	SELECT DISTINCT 
	       INS_ID           = FWD.CANUMOPER
       , INS_UNDERLYING_ID = 0
       , INSC_ID           = 0
		 , INSG_ID           = 0
		 , INSS_ID           = 1		--1 = Authorized
		 , INST_ID           = 1004	-- FX-FORWARD-CCS
		 , BASE_CCY_ID       = ISNULL(BC.mu_BASE_CCY_ID, 0)
		 , INSAT_ID          = 0
		 , INS_NAME          = 'FX FWD'
	FROM BACFWDSUDA..MFCA AS FWD LEFT JOIN BacParamSuda.dbo.MONEDA AS MN ON 
			mn.mncodmon = FWD.CaCodMon1	
		LEFT JOIN #PasoBASE_CCY AS BC ON
			BC.Cod_BAC = MN.mnnemo
	
      

	---- ================================================
	---- OPCIONES
	---- ================================================
	INSERT INTO #VM_BAC_INSTRUMENT
	SELECT DISTINCT --TOP 0 
			INS_ID           = CAST(EC.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
		, INS_UNDERLYING_ID = 0
		, INSC_ID           = 0		--0=unique
		, INSG_ID           = 0	
		, INSS_ID           = 1		--1 = Authorized
		, INST_ID           = 1007	--FX OPTIONS
		, BASE_CCY_ID       = ISNULL(BC.mu_BASE_CCY_ID, 0)
		, INSAT_ID          = 0
		, INS_NAME          = RTRIM('FX OPT ' + UPPER(DC.CaCallPut) + ' ' + MN.mnnemo)
	FROM CbMdbOpc..CaEncContrato AS EC INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = EC.CanumContrato
		LEFT JOIN BacParamSuda.dbo.MONEDA AS MN ON 
			mn.mncodmon = DC.CaCodMon1	
		INNER JOIN #PasoBASE_CCY AS BC ON
			BC.Cod_BAC = MN.mnnemo
	WHERE 
		--CaDet.caFechaVcto <> @Fecha_Proceso and 
		EC.CaEstado <> 'C' --Se excluiyen las Cotizaciones  	

	--SELECT '#VM_BAC_INSTRUMENT' AS TABLA,* FROM #VM_BAC_INSTRUMENT WHERE INS_ID=756--AQUI

	INSERT INTO #VM_BAC_INSTRUMENT_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT DISTINCT 
			"INS_ID" = INS_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
			"INST_ID" = INST_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
				LTRIM(INS_ID)      + @SEP 
         + LTRIM(INS_UNDERLYING_ID)  + @SEP 
         + LTRIM(INSC_ID)            + @SEP 
         + LTRIM(INSG_ID)            + @SEP 
         + LTRIM(INSS_ID)            + @SEP 
         + LTRIM(INST_ID)            + @SEP 
         + LTRIM(BASE_CCY_ID)        + @SEP 
         + LTRIM(INSAT_ID)           + @SEP 
         + LTRIM(INS_NAME)			 AS REG_SALIDA
      FROM #VM_BAC_INSTRUMENT
	  --WHERE INS_ID=756--AQUI
      --ORDER BY INST_ID, INS_ID		-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_INSTRUMENT_SALIDA
		SELECT 
			"INS_ID" = 0,
			"INST_ID" = 0, 
			"REG_SALIDA" = 'INS_ID' + @SEP + 
										'INS_UNDERLYING_ID' + @SEP  + 
										'INSC_ID' + @SEP  + 
										'INSG_ID' + @SEP  + 
										'INSS_ID' + @SEP  + 
										'INST_ID' + @SEP  + 
										'BASE_CCY_ID' + @SEP +  
										'INSAT_ID' + @SEP  + 
										'INS_NAME' 
		WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_INSTRUMENT_SALIDA 
	ORDER BY INST_ID, INS_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
      
	DROP TABLE #VM_BAC_INSTRUMENT
	DROP TABLE #VM_BAC_INSTRUMENT_SALIDA

END
GO

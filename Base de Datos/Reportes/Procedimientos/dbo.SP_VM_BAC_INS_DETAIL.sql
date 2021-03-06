USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_INS_DETAIL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz INS_DETAIL: (swap fowd, opciones y spot)
-- ================================================
--ISSUER_PTY_ID    Indica el ID del Emisor del Instrumento. Aplica solo para Bonos y Futuros.
--YLDCMP_ID        Indica el ID del Yield Compounding del Instrumento. Aplica solo para Bonos y Futuros.
--IPF_ID           Indica el Price Format del Instrumento. Aplica solo para Bonos y Futuros.
--INS_ID           Indica el ID del Instrumento. Aplica solo para Bonos y Futuros.
--INSD_TICKER      Indica el Ticker del Instrumento. Aplica para Bonos, FX Spot, Futuros.
--INSD_REFERENCE   Indica un valor de referencia/etiqueta del Instrumento. Aplica para Bonos, FX Spot, Futuros.
--INSD_CUSIP       Indica el Valor del CUSIP del Instrumento.  Aplica solo para Bonos y Futuros.
--INSD_ISIN	       Indica el valor del ISIN.  Aplica solo para Bonos y Futuros.
--INSD_TICKER_BBG  Indica el valor del Ticker de Bloomberg.  Aplica solo para Bonos y Futuros.
--INSD_TOTAL_ISSUE Indica el valor total emitido de cada instrumento.  Aplica solo para Bonos y Futuros.
--INSD_ROUND_PRICE Indica el redondeo del precio sucio para cada instrumento.  Aplica solo para Bonos.
--INSD_ROUND_YIELD Indica el redondeo de la Yield para cada instrumento.  Aplica solo para Bonos y Futuros.

-- ================================================
--IF OBJECT_ID('SP_VM_BAC_INS_DETAIL')>0
--	DROP PROC SP_VM_BAC_INS_DETAIL
--GO
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX INSTRUMENT
-- =============================================
-- 17-02-2021 SE INCORPORA INSD_TICKER PARA OPCIONES PARA CONFORMAR REGISTRO 2 Y 3 PARA SIID EN SAT.

--EXEC SP_VM_BAC_INS_DETAIL
CREATE PROCEDURE [dbo].[SP_VM_BAC_INS_DETAIL]
AS BEGIN 

SET NOCOUNT ON 
 
DECLARE @SEP  VARCHAR(1) 
    SET @SEP  = ','


	DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS


	CREATE TABLE #VM_BAC_INS_DETAIL
		( ISSUER_PTY_ID    INT
		, YLDCMP_ID        INT
		, IPF_ID           INT
		, INS_ID           INT
		, INSD_TICKER      VARCHAR(40)
		, INSD_REFERENCE   VARCHAR(40)
		, INSD_CUSIP       VARCHAR(40)
		, INSD_ISIN	       VARCHAR(40)
		, INSD_TICKER_BBG  VARCHAR(40)
		, INSD_TOTAL_ISSUE INT
		, INSD_ROUND_PRICE INT
		, INSD_ROUND_YIELD INT )


	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	CREATE TABLE #VM_BAC_INS_DETAIL_SALIDA
	(
	ISSUER_PTY_ID     Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA			Varchar(500))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512


	-- ================================================
	-- SWAPS
	-- ================================================
	INSERT INTO #VM_BAC_INS_DETAIL
	SELECT DISTINCT 
		  ISSUER_PTY_ID    = 0
		, YLDCMP_ID        = 0
		, IPF_ID           = 0
		, INS_ID           = CAB.NUMERO_OPERACION
		, INSD_TICKER      = RTRIM(MNA.mniso_coddes)+'/'+RTRIM(MNP.mniso_coddes)
		, INSD_REFERENCE   = ''
		, INSD_CUSIP       = ''
		, INSD_ISIN	       = ''
		, INSD_TICKER_BBG  = ''
		, INSD_TOTAL_ISSUE = 0
		, INSD_ROUND_PRICE = 0
		, INSD_ROUND_YIELD = 0
     FROM BACSWAPSUDA..CARTERA AS CAB 
    INNER JOIN BACSWAPSUDA..CARTERA AS ACT ON ACT.TIPO_FLUJO =1 AND ACT.ESTADO_FLUJO = 1
	INNER JOIN BACSWAPSUDA..CARTERA AS PAS ON PAS.TIPO_FLUJO =2 AND PAS.ESTADO_FLUJO = 1
	INNER JOIN BACPARAMSUDA..MONEDA AS MNA ON MNA.MNCODMON = ACT.COMPRA_MONEDA
	INNER JOIN BACPARAMSUDA..MONEDA AS MNP ON MNP.MNCODMON = PAS.VENTA_MONEDA
    WHERE CAB.NUMERO_OPERACION = ACT.NUMERO_OPERACION 
      AND CAB.NUMERO_OPERACION = PAS.NUMERO_OPERACION 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.ESTADO			<>'N'-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
		--and cab.numero_operacion = 756 

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_INS_DETAIL
	SELECT DISTINCT 
		  ISSUER_PTY_ID    = 0
		, YLDCMP_ID        = 0
		, IPF_ID           = 0
		, INS_ID           = CAB.NUMERO_OPERACION
		, INSD_TICKER      = RTRIM(MNA.mniso_coddes)+'/'+RTRIM(MNP.mniso_coddes)
		, INSD_REFERENCE   = ''
		, INSD_CUSIP       = ''
		, INSD_ISIN	       = ''
		, INSD_TICKER_BBG  = ''
		, INSD_TOTAL_ISSUE = 0
		, INSD_ROUND_PRICE = 0
		, INSD_ROUND_YIELD = 0
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
	INNER JOIN BACSWAPSUDA..CARTERA_UNWIND AS ACT ON ACT.TIPO_FLUJO =1 AND ACT.ESTADO_FLUJO = 1
	INNER JOIN BACSWAPSUDA..CARTERA_UNWIND AS PAS ON PAS.TIPO_FLUJO =2 AND PAS.ESTADO_FLUJO = 1
	INNER JOIN BACPARAMSUDA..MONEDA AS MNA ON MNA.MNCODMON = ACT.COMPRA_MONEDA
	INNER JOIN BACPARAMSUDA..MONEDA AS MNP ON MNP.MNCODMON = PAS.VENTA_MONEDA
    WHERE CAB.NUMERO_OPERACION = ACT.NUMERO_OPERACION 
      AND CAB.NUMERO_OPERACION = PAS.NUMERO_OPERACION 
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
		AND CAB.FECHAANTICIPO = @FECHA_SWP
		--and cab.numero_operacion = 756 
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	---- ================================================
	---- FORWARD
	---- ================================================
	INSERT INTO #VM_BAC_INS_DETAIL
	SELECT DISTINCT 
		  ISSUER_PTY_ID    = 0
		, YLDCMP_ID        = 0
		, IPF_ID           = 0
		, INS_ID           = CAB.CANUMOPER
		, INSD_TICKER      = RTRIM(MNA.mniso_coddes)+'/'+RTRIM(MNP.mniso_coddes)
		, INSD_REFERENCE   = ''
		, INSD_CUSIP       = ''
		, INSD_ISIN	       = ''
		, INSD_TICKER_BBG  = ''
		, INSD_TOTAL_ISSUE = 0
		, INSD_ROUND_PRICE = 0
		, INSD_ROUND_YIELD = 0
     FROM BACFWDSUDA..MFCA AS CAB 
	INNER JOIN BACPARAMSUDA..MONEDA AS MNA ON MNA.MNCODMON = CAB.CACODMON1
	INNER JOIN BACPARAMSUDA..MONEDA AS MNP ON MNP.MNCODMON = CAB.CACODMON2
    WHERE 1=1  AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	---**** PLL-20200514-se omiten los spot, por V11 - INI
    
	---- ================================================
	---- SPOT
	---- ================================================
	--INSERT INTO #VM_BAC_INS_DETAIL
	--SELECT DISTINCT 
	--	  ISSUER_PTY_ID    = 0
	--	, YLDCMP_ID        = 0
	--	, IPF_ID           = 0
	--	, INS_ID           = MONUMOPE	
	--	, INSD_TICKER      = RTRIM(MOCODMON)+'/'+RTRIM(MOCODCNV)
	--	, INSD_REFERENCE   = ''
	--	, INSD_CUSIP       = ''
	--	, INSD_ISIN	       = ''
	--	, INSD_TICKER_BBG  = ''
	--	, INSD_TOTAL_ISSUE = 0
	--	, INSD_ROUND_PRICE = 0
	--	, INSD_ROUND_YIELD = 0
 --    FROM BACCAMSUDA..MEMO
 --   WHERE MOESTATUS <> 'A'
---**** PLL-20200514-se omiten los spot, por V11 - FIN


	---- ==================================================================================================================
	---- OPCIONES		(17-02-2021 SE INCORPORA INSD_TICKER PARA OPCIONES PARA CONFORMAR REGISTRO 2 Y 3 PARA SIID EN SAT.)
	---- ==================================================================================================================
	INSERT INTO #VM_BAC_INS_DETAIL
	SELECT DISTINCT 
		  ISSUER_PTY_ID    = 0
		, YLDCMP_ID        = 0
		, IPF_ID           = 0
		, INS_ID           = CAST(CAB.CanumContrato AS VARCHAR(10)) + CAST(DET.CaNumEstructura AS VARCHAR(10))  
		, INSD_TICKER      = RTRIM(M.mniso_coddes)+'/'+RTRIM(M1.mniso_coddes)
		, INSD_REFERENCE   = ''
		, INSD_CUSIP       = ''
		, INSD_ISIN	       = ''
		, INSD_TICKER_BBG  = ''
		, INSD_TOTAL_ISSUE = 0
		, INSD_ROUND_PRICE = 0
		, INSD_ROUND_YIELD = 0
FROM 
		CbMdbOpc..CaEncContrato AS CAB LEFT JOIN CbMdbOpc..caDetContrato AS DET ON	DET.CaNumContrato = CAB.CanumContrato
		INNER JOIN bacparamsuda.dbo.Moneda	M			ON M.mncodmon		= Det.caCodMon1
	INNER JOIN bacparamsuda.dbo.Moneda	M1			ON M1.mncodmon		= Det.caCodMon2-->>20210707 Det.CaMdaCompensacion
	WHERE
--			DET.caFechaVcto >= @Fecha AND 
			CAB.CaEstado != 'C'	
    
	INSERT INTO #VM_BAC_INS_DETAIL_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		SELECT 
			"ISSUER_PTY_ID" = ISSUER_PTY_ID, 
			LTRIM(ISSUER_PTY_ID)    + @SEP  
			+ LTRIM(YLDCMP_ID)		  + @SEP  
			+ LTRIM(IPF_ID)			  + @SEP  
			+ LTRIM(INS_ID)			  + @SEP  
			+ LTRIM(INSD_TICKER)	  + @SEP  
			+ LTRIM(INSD_REFERENCE)	  + @SEP  
			+ LTRIM(INSD_CUSIP)		  + @SEP  
			+ LTRIM(INSD_ISIN)		  + @SEP  
			+ LTRIM(INSD_TICKER_BBG)  + @SEP  
			+ LTRIM(INSD_TOTAL_ISSUE) + @SEP  
			+ LTRIM(INSD_ROUND_PRICE) + @SEP  
			+ LTRIM(INSD_ROUND_YIELD)	AS REG_SALIDA
		  FROM #VM_BAC_INS_DETAIL
 --ORDER BY 1 

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512      
	INSERT INTO #VM_BAC_INS_DETAIL_SALIDA
		SELECT 
			"ISSUER_PTY_ID" = -999, 
			"REG_SALIDA" = 'ISSUER_PTY_ID'    + @SEP  
							+ 'YLDCMP_ID'		  + @SEP  
							+ 'IPF_ID'			  + @SEP  
							+ 'INS_ID'			  + @SEP  
							+ 'INSD_TICKER'	  + @SEP  
							+ 'INSD_REFERENCE'	  + @SEP  
							+ 'INSD_CUSIP'		  + @SEP  
							+ 'INSD_ISIN'		  + @SEP  
							+ 'INSD_TICKER_BBG'  + @SEP  
							+ 'INSD_TOTAL_ISSUE' + @SEP  
							+ 'INSD_ROUND_PRICE' + @SEP  
							+ 'INSD_ROUND_YIELD' 

	SELECT REG_SALIDA FROM #VM_BAC_INS_DETAIL_SALIDA 
	ORDER BY ISSUER_PTY_ID	--1
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
      
      
	DROP TABLE #VM_BAC_INS_DETAIL
	DROP TABLE #VM_BAC_INS_DETAIL_SALIDA
END
GO

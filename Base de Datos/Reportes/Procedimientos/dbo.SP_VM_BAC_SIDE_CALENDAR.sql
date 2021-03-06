USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_SIDE_CALENDAR]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz SIDE CALENDAR: (swap fowd, opciones y spot)
-- ================================================
-- CAL_ID   Calendario para cada una de las patas del instrumento. Ver catálogo tabla : CALENDAR, se informa el ID.
-- SD_ID    ID  de la pata que tiene asignado cada calendario.
-- INS_ID   ID del Instrumento.

-- ================================================
-- =============================================
-- Author:		SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX SIDE CALENDAR
-- =============================================

--EXEC SP_VM_BAC_SIDE_CALENDAR
CREATE PROCEDURE [dbo].[SP_VM_BAC_SIDE_CALENDAR]
AS BEGIN 

SET NOCOUNT ON 
 
DECLARE @SEP  VARCHAR(1); SET @SEP  = ','
DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512

CREATE TABLE #VM_BAC_SIDE_CALENDAR
	( CAL_ID   Int
	, SD_ID    Int
	, INS_ID   Int
	)

CREATE TABLE #VM_BAC_SIDE_CALENDAR_SALIDA
(
SD_ID            Int,		--PARA COMPATIBILIDAD DE SALIDA
INS_ID           Int,		--PARA COMPATIBILIDAD DE SALIDA
REG_SALIDA			Varchar(1000))

DECLARE @CAL_ID_NYC AS INT; SET @CAL_ID_NYC = 0;   --NYC: Usa  New York
DECLARE @CAL_ID_MEL AS INT; SET @CAL_ID_MEL = 1;   --MEL: Feriados Australia  Melburne
DECLARE @CAL_ID_SYD AS INT; SET @CAL_ID_SYD = 2;   --SYD: Feriados Australia  Sydnei
DECLARE @CAL_ID_TOR AS INT; SET @CAL_ID_TOR = 3;   --TOR: Feriados Canada  Toronto
DECLARE @CAL_ID_ZUR AS INT; SET @CAL_ID_ZUR = 4;   --ZUR: Feriados Suiza  Zurich
DECLARE @CAL_ID_COP AS INT; SET @CAL_ID_COP = 5;   --COP: Feriados Dinamarca  Copenague
DECLARE @CAL_ID_OSL AS INT; SET @CAL_ID_OSL = 6;   --OSL: Noruega  Oslo
DECLARE @CAL_ID_STK AS INT; SET @CAL_ID_STK = 7;   --STK: Feriados Suecia  Estocolmo
DECLARE @CAL_ID_LDN AS INT; SET @CAL_ID_LDN = 8;   --LDN: Gran Bretaña  Londres
DECLARE @CAL_ID_NBR AS INT; SET @CAL_ID_NBR = 9;   --NBR: Feriados Brasil
DECLARE @CAL_ID_CHL AS INT; SET @CAL_ID_CHL = 10;   --CHL: Chile
DECLARE @CAL_ID_NO_APPLY AS INT; SET @CAL_ID_NO_APPLY = 11;   --NO APPLY: No Apply
DECLARE @CAL_ID_ZAR AS INT; SET @CAL_ID_ZAR = 12;   --ZAR: Feriados Sudafrica
DECLARE @CAL_ID_CNY AS INT; SET @CAL_ID_CNY = 13;   --CNY: Feriados China
DECLARE @CAL_ID_WEL AS INT; SET @CAL_ID_WEL = 14;   --WEL: Feriandos Nueva Zelandia  Auckland
DECLARE @CAL_ID_TKY AS INT; SET @CAL_ID_TKY = 15;   --TKY: Feriados Japon  Tokyo
DECLARE @CAL_ID_FRK AS INT; SET @CAL_ID_FRK = 16;   --FRK: Frankfurt - Alemania
DECLARE @CAL_ID_EUR AS INT; SET @CAL_ID_EUR = 17;   --EUR: ZONA EURO
DECLARE @CAL_ID_MEX AS INT; SET @CAL_ID_MEX = 18;   --MEX: Feriados Mexico
DECLARE @CAL_ID_COL AS INT; SET @CAL_ID_COL = 19;   --COL: Feriados Colombia
DECLARE @CAL_ID_PEN AS INT; SET @CAL_ID_PEN = 20;   --PEN: FERIADOS PERU
DECLARE @CAL_ID_HKD AS INT; SET @CAL_ID_HKD = 21;   --HKD: FERIADO HONG KONG
DECLARE @CAL_ID_BAR AS INT; SET @CAL_ID_BAR = 22;   --BAR: CALENDARIO BARCELONA  21072017
DECLARE @CAL_ID_CHF AS INT; SET @CAL_ID_CHF = 23;   --CHF: Feriados Suiza  Zurich.


	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  @CAL_ID_NO_APPLY
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0  - RECIEVE
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 1 
       AND CAB.ESTADO_FLUJO = 1 
       AND (FERIADOFLUJOCHILE = 0 AND FERIADOFLUJOEEUU = 0 AND FERIADOFLUJOENGLAN = 0)
       and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION        
	SELECT CAL_ID        =  @CAL_ID_NYC
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0	-- RECIEVE
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 1 
		AND CAB.ESTADO_FLUJO = 1 
		AND FERIADOFLUJOEEUU = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION 
	SELECT CAL_ID        =  @CAL_ID_CHL
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0	-- RECIEVE
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO    = 1 
		AND CAB.ESTADO_FLUJO  = 1 
		AND FERIADOFLUJOCHILE = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION 
	SELECT CAL_ID        =  @CAL_ID_LDN
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --0		-- RECIEVE
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO     = 1 
		AND CAB.ESTADO_FLUJO   = 1 
		AND FERIADOFLUJOENGLAN = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones

    -- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  @CAL_ID_NO_APPLY					-- NO APPLY
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --	1		-- PAY
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 2 
		AND CAB.ESTADO_FLUJO = 1 
		AND (FERIADOFLUJOCHILE = 0 AND FERIADOFLUJOEEUU = 0 AND FERIADOFLUJOENGLAN = 0)
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION        
	SELECT CAL_ID        =  @CAL_ID_NYC
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. 
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO   = 2 
		AND CAB.ESTADO_FLUJO = 1 
		AND FERIADOFLUJOEEUU = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION        
	SELECT CAL_ID        =  @CAL_ID_CHL
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1			-- PAY
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO    = 2 
		AND CAB.ESTADO_FLUJO  = 1 
		AND FERIADOFLUJOCHILE = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION 
	SELECT CAL_ID        =  @CAL_ID_LDN
		, SD_ID           =  CAB.TIPO_FLUJO          --MODIF. 20201006-solicitado x CAMILO P. --1			-- PAY
		, INS_ID          =  CAB.NUMERO_OPERACION
	FROM BACSWAPSUDA..CARTERA AS CAB 
	WHERE CAB.TIPO_FLUJO     = 2 
		AND CAB.ESTADO_FLUJO   = 1 
		AND FERIADOFLUJOENGLAN = 1
		and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones


	---- ================================================
	---- FORWARD - (COMPRAS/VENTAS)
	---- ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  CASE WHEN CAB.cacodmon1 = 48 OR CAB.cacodmon2 = 48 THEN @CAL_ID_CNY ELSE @CAL_ID_CHL END
		, SD_ID           =  1	--PATA 1
		, INS_ID          =  CAB.CANUMOPER
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  CASE WHEN CAB.cacodmon1 = 48 OR CAB.cacodmon2 = 48 THEN @CAL_ID_CNY ELSE @CAL_ID_CHL END
		, SD_ID           =  2	--PATA 2
		, INS_ID          =  CAB.CANUMOPER
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		CATIPOPER = 'C' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')
		
	---- ================================================
	---- FORWARD - PAGAMOS (COMPRAS/VENTAS)
	---- ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  CASE WHEN CAB.cacodmon1 = 48 OR CAB.cacodmon2 = 48 THEN @CAL_ID_CNY ELSE @CAL_ID_CHL END
		, SD_ID           =  1	--PATA 1
		, INS_ID          =  CAB.CANUMOPER
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID        =  CASE WHEN cacodmon1 = 48 OR cacodmon2 = 48 THEN @CAL_ID_CNY ELSE @CAL_ID_CHL END
		, SD_ID           =  2   --PATA 2
		, INS_ID          =  CAB.CANUMOPER
	FROM BACFWDSUDA..MFCA AS CAB 
	WHERE
		CATIPOPER = 'V' AND
		NOT LTRIM(RTRIM(caestado)) IN('A', 'P')

	------ ================================================
	------ OPCIONES
	------ ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR
	SELECT CAL_ID	=  @CAL_ID_CHL
		--, SD_ID     =  CASE WHEN DC.CaNumEstructura > 1 THEN DC.CaNumEstructura - 1 ELSE 0 END
		, SD_ID     =  DC.CaNumEstructura 
		, INS_ID    =  CAST(EC.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))
	FROM CbMdbOpc..CaEncContrato AS EC INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
		DC.CanumContrato = EC.CanumContrato 	 
	WHERE
		EC.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113



	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_SIDE_CALENDAR_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	SELECT 
		"SD_ID" = SD_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		"INS_ID" = INS_ID,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
		LTRIM(CAL_ID)   + @SEP 
		+ LTRIM(SD_ID)    + @SEP 
		+ LTRIM(INS_ID)   AS REG_SALIDA
	FROM #VM_BAC_SIDE_CALENDAR
--      ORDER BY SD_ID, INS_ID-- se comenta porque no es necesario a este nivel-- PLL-20200512

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_SIDE_CALENDAR_SALIDA
	SELECT 
		"SD_ID" = 0,
		"INS_ID" = 0, 
		"REG_SALIDA" = 'CAL_ID'	+ @SEP 
						+ 'SD_ID'	+ @SEP 
						+ 'INS_ID' 
	WHERE @Con_Linea_Encabezado = 'Y'

	SELECT REG_SALIDA FROM #VM_BAC_SIDE_CALENDAR_SALIDA 
	ORDER BY INS_ID, SD_ID
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512


	DROP TABLE #VM_BAC_SIDE_CALENDAR
	DROP TABLE #VM_BAC_SIDE_CALENDAR_SALIDA
END
GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_VM_BAC_SIDE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Interfaz SIDE: (swap fowd, opciones y spot)
-- ================================================
--SD_ID            ID de cada pata del Instrumento. Este puede tomar valores desde 0 a n. Donde n es la última pata del instrumento.
--FF_ID            ID del identificador Fixed/Float de cada pata del Instrumento. Ver catálogo tabla : FIXED_FLOAT , se informa el ID.
--PR_ID            ID del identificador Pay/Receive de cada pata del Instrumento. Ver catálogo tabla : PAY_REC , se informa el ID.
--DRC_ID           ID del identificador de la Convención Date Rolling de cada pata del Instrumento. Ver catálogo tabla : DATE_ROLLING_CONV , se informa el ID.
--PYMT_CCY_ID      ID de la moneda de pago de la pata del Instrumento. Ver catálogo tabla : CURRENCY , se informa el ID.
--DCC_ID           ID del identificador de la convención Day Count de la pata del instrumento. Ver catálogo tabla : DAY_COUNT_CONV , se informa el ID.
--NOT_CCY_ID       ID de la moneda de nocional de la pata del Instrumento. Ver catálogo tabla : CURRENCY , se informa el ID.
--PROJ_CRV_ID      ID de la curva de Proyección de la pata del Instrumento. Ver catálogo tabla : CURVE , se informa el ID.
--INS_ID           ID del Instrumento.
--SCON_ID          Stub Convention para la composición del Schedule. No aplica , indicar valor 0.
--DISC_CRV_ID      ID de la curva de Descuento de la pata del Instrumento. Ver catálogo tabla : CURVE , se informa el ID.
--RS_ID            Reset Source de cada Pata. Ver catálogo tabla : RESET_SOURCE , se informa el ID.
--SD_START_DATE    Fecha de Inicio de cada pata del Instrumento.
--SD_END_DATE      Fecha de Término de cada pata del Instrumento.
--SD_NOTNL         Valor Nocional del Instrumento.
--SD_RATE          Valor de la tasa en caso de que la pata sea Fija. En caso contrario (Flotante) indica el valor de la tasa de fijación del primer flujo o cupón. 
--SD_SPREAD        Spread en BPS ( Basis Points)  que se aplicará a cada uno de los flujos o cupones de Interés ( Aplica para IRS , CCS).
--SD_FROLL_DATE    Fecha de Inicio de pata de cada Instrumento si esta es Forward Starting.
--SD_BROLL_DATE    Fecha de Termino de pata de cada Instrumento si esta es Back Starting.
--SD_PYMT_PERIOD   Periodo de Pago de cada una de las patas para cada Instrumento. Se debe informar en Symbolic Date ( Ej: 1y , 5m , 1d).
--SD_RESET_PERIOD  Periodo de Fixing de cada una de las patas para cada Instrumento. Se debe informar en Symbolic Date ( Ej: 1y , 5m , 1d).
--SD_RESET_SHIFT   Diferencial en Symbolic Date que se aplicará sobre el periodo de Fixing de cada una de las patas para cada Instrumento. Se debe informar en Symbolic Date ( Ej: 1y , 5m , 1d).
--SD_ROUND_INT     Redondeo que se aplicará a cada uno de los flujos de Intereses por cada para pata. No aplica . Indicar 0.
--SD_ROUND_CFLOW   Redondeo que se aplicará a cada uno de los flujos de efectivo por cada para pata. No aplica . Indicar 0.
--SD_OFFSET_DATE   Diferencial de días expresados en Symbolic Dates que se aplicará sobre la fecha de Término de cada Flujo o Cupón de cada pata para cada Instrumento. Se debe informar en Symbolic Date ( Ej: 1y , 5m , 1d).

--BEGIN TRAN


-- ================================================
--IF OBJECT_ID('SP_VM_BAC_SIDE')>0	
--	DROP PROCEDURE DBO.SP_VM_BAC_SIDE
--GO
-- =============================================
-- Author:          SONDA S.A.
-- Create date: 13-02.2020
-- Description:	INTERFAZ VMETRIX SIDE
-- =============================================
-- 15-02-2021.RCH -- Cambiar fechas informadas para las columnas SD_START_DATE, SD_END_DATE, 
--				     donde se estaba informando fechas de inicio y final de los flujos y no las del contrato.

--EXEC SP_VM_BAC_SIDE


CREATE PROCEDURE [dbo].[SP_VM_BAC_SIDE]
AS BEGIN 

SET NOCOUNT ON 
 
	DECLARE @SEP VARCHAR(1); SET @SEP = ','
	DECLARE @SEP_PARMON VARCHAR(1); SET @SEP_PARMON = '/'
	DECLARE @Con_Linea_Encabezado VARCHAR(1); SET @Con_Linea_Encabezado = 'Y'			-- PLL-20200512

	DECLARE @FECHA_SWP  DATETIME; SET @FECHA_SWP  = ISNULL((SELECT fechaproc FROM BACSwapSUDA..SWAPGENERAL), '')-->>CVM.20211105 SIID FLUJOS ANTICIPADOS

	--	De/Para	BASE_CCY_ID (CURRENCY)
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

	CREATE TABLE #VM_BAC_SIDE
          ( SD_ID            int
          , FF_ID            int
          , PR_ID            int
          , DRC_ID           int
          , PYMT_CCY_ID      int
          , DCC_ID           int
          , NOT_CCY_ID       int
          --, PROJ_CRV_ID      int
          , PROJ_CRV_ID      VARCHAR(40)
          , INS_ID           int
          , SCON_ID          int
          , DISC_CRV_ID      int
          , RS_ID            int
          , SD_START_DATE    DATETIME
          , SD_END_DATE      DATETIME
          , SD_NOTNL         NUMERIC(19,4)
          , SD_RATE          NUMERIC(19,4)
          , SD_SPREAD        NUMERIC(19,4)
          , SD_FROLL_DATE    DATETIME
          , SD_BROLL_DATE    DATETIME
          , SD_PYMT_PERIOD   varchar(5)
          , SD_RESET_PERIOD  varchar(5)
          , SD_RESET_SHIFT   varchar(5)
          , SD_ROUND_INT     int
          , SD_ROUND_CFLOW   int
          , SD_OFFSET_DATE   varchar(5))

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	CREATE TABLE #VM_BAC_SIDE_SALIDA
	(
	ORDEN				Int,		--PARA COMPATIBILIDAD DE SALIDA
	REG_SALIDA		Varchar(1000))
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

	-- ================================================
	-- SWAPS - FLUJOS HISTORICOS (N°1)
	-- ================================================
	SELECT DISTINCT NUMERO_OPERACION, TIPO_FLUJO, FECHA_INICIO_FLUJO, FECHA_VENCE_FLUJO
	INTO #HISTORICO
	FROM BACSWAPSUDA..CARTERAHIS
	WHERE NUMERO_FLUJO = 1 
		AND FECHA_CIERRE <> FECHA_INICIO_FLUJO
  and estado			<>'C'-->cvm20210115 exclusion cotizaciones
	UNION 
	SELECT DISTINCT NUMERO_OPERACION, TIPO_FLUJO, FECHA_INICIO_FLUJO, FECHA_VENCE_FLUJO
	FROM BACSWAPSUDA..CARTERA
	WHERE NUMERO_FLUJO = 1 
		AND FECHA_CIERRE <> FECHA_INICIO_FLUJO
  and estado			<>'C'-->cvm20210115 exclusion cotizaciones

	
	-- ================================================
	-- SWAPS - RECIBIMOS
	-- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT DISTINCT SD_ID           =  CAB.TIPO_FLUJO	--0	--MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
		, FF_ID           =  CASE CAB.COMPRA_CODIGO_TASA WHEN 0 THEN 0 ELSE 1 END -- 0-FIXED/1-FLOAT
		, PR_ID           =  0 -- RECIEVE
		, DRC_ID          =  1 -- FOLLOW
		, PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
		, DCC_ID          =  B.TBTASA  -- DAY_COUNT_CONV
		, NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
  , PROJ_CRV_ID			=  LTRIM(RTRIM(ISNULL(TmpCurva.CURVA_SAT,'')))/*CASE WHEN TIPOTASA = 'F' THEN '-1'-->>CVM20210114
									ELSE 
										CASE WHEN TmpCurva.CodCurvaAlter IS NULL then   
											CASE WHEN NOT CAB.Compra_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN  
											 CAB.Compra_Curva_Descont  
											ELSE  
											 '' --NO APLICA'   
											END  
										ELSE CodCurvaFwd--TmpCurva.CodCurvaAlter 
										END   
								END*/
		, INS_ID          =  CAB.NUMERO_OPERACION
		, SCON_ID         =  0 -- *** PENDIENTE ***
		, DISC_CRV_ID     =  0 -- *** PENDIENTE ***
		, RS_ID           =  5 -- MERCADO *** PENDIENTE ***
		, SD_START_DATE   =  CAB.fecha_inicio	--20210215.RCH CAB.fecha_inicio_flujo
		, SD_END_DATE     =	 CAB.fecha_termino	--20210215.RCH	CAB.fecha_vence_flujo
		, SD_NOTNL        =  CAB.COMPRA_CAPITAL
		, SD_RATE         =  CAB.compra_valor_tasa--CAB.COMPRA_INTERES
		, SD_SPREAD       =  CAB.COMPRA_SPREAD
		, SD_FROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE < HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_INICIO_FLUJO ELSE '' END 
		, SD_BROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE > HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_VENCE_FLUJO ELSE '' END 
		, SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		, SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		, SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		, SD_ROUND_INT    =  0
		, SD_ROUND_CFLOW  =  0
		, SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,PLAZOFLUJO / 365 ) > 0
										  THEN LTRIM(CONVERT(INT,PLAZOFLUJO / 360) ) + 'Y'
								WHEN CONVERT(INT,PLAZOFLUJO /30) = 0
								THEN LTRIM(CONVERT(INT,PLAZOFLUJO) )  + 'D' 
								ELSE LTRIM(CONVERT(INT,PLAZOFLUJO / 30) )  + 'M' END 
	FROM BACSWAPSUDA..CARTERA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN COMPRA_MONEDA ELSE RECIBIMOS_MONEDA END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE B ON B.TBCATEG = 74 AND B.TBCODIGO1 = COMPRA_BASE 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON C.TBCATEG = 75 AND C.TBCODIGO1 = COMPRA_MONEDA 
		LEFT JOIN #HISTORICO HIS ON HIS.NUMERO_OPERACION = CAB.NUMERO_OPERACION AND CAB.TIPO_FLUJO = HIS.TIPO_FLUJO
  LEFT JOIN (SELECT   
      CP.Modulo ,   
      CP.Moneda,   
      CP.INDICADOR,  
      CP.PRODUCTO,  
      "CodCurvaFwd" = CASE CP.CurAlter   
             WHEN  NULL THEN '' --'NO APLICA'  
             WHEN '' THEN CP.CODIGOCURVA  
             ELSE CP.CurAlter END,  
      "CodCurvaAlter" = CP.CODIGOCURVA 
      ,tipotasa -->>CVM20210114
      ,CP.CURVA_SAT
     FROM BacParamSuda..CURVAS_PRODUCTO  CP   with (nolock)      
     WHERE CP.Modulo = 'PCS') AS TmpCurva ON  
      TmpCurva.Moneda = CAB.compra_moneda  
      AND TmpCurva.INDICADOR = CAB.compra_codigo_tasa  
      AND TmpCurva.CodCurvaAlter = CASE WHEN CAB.Compra_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN TmpCurva.CodCurvaAlter ELSE CAB.Compra_Curva_Descont END   
      AND TmpCurva.PRODUCTO = CASE CAB.tipo_swap WHEN 1 THEN 'ST' WHEN 2 THEN 'SM' WHEN 3 THEN 'FRA' WHEN 4 THEN 'SP' END  
 WHERE CAB.TIPO_FLUJO =1   
  AND CAB.ESTADO_FLUJO = 1  
  and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
  AND CAB.ESTADO<>'N'-->>20211116.CVM.NO SE CONSIDERA ANTIPO
--  AND CAB.NUMERO_OPERACION IN(756, 1082, 1354)  

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_SIDE
	SELECT DISTINCT SD_ID           =  CAB.TIPO_FLUJO	--0	--MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
		, FF_ID           =  CASE CAB.COMPRA_CODIGO_TASA WHEN 0 THEN 0 ELSE 1 END -- 0-FIXED/1-FLOAT
		, PR_ID           =  0 -- RECIEVE
		, DRC_ID          =  1 -- FOLLOW
		, PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
		, DCC_ID          =  B.TBTASA  -- DAY_COUNT_CONV
		, NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
		, PROJ_CRV_ID			=  LTRIM(RTRIM(ISNULL(TmpCurva.CURVA_SAT,'')))/*CASE WHEN TIPOTASA = 'F' THEN '-1'-->>CVM20210114
									ELSE 
										CASE WHEN TmpCurva.CodCurvaAlter IS NULL then   
											CASE WHEN NOT CAB.Compra_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN  
											 CAB.Compra_Curva_Descont  
											ELSE  
											 '' --NO APLICA'   
											END  
										ELSE CodCurvaFwd--TmpCurva.CodCurvaAlter 
										END   
								END*/
		, INS_ID          =  CAB.NUMERO_OPERACION
		, SCON_ID         =  0 -- *** PENDIENTE ***
		, DISC_CRV_ID     =  0 -- *** PENDIENTE ***
		, RS_ID           =  5 -- MERCADO *** PENDIENTE ***
		, SD_START_DATE   =  CAB.fecha_inicio	--20210215.RCH CAB.fecha_inicio_flujo
		, SD_END_DATE     =	 CAB.fecha_termino	--20210215.RCH	CAB.fecha_vence_flujo
		, SD_NOTNL        =  CAB.COMPRA_CAPITAL

		-->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_RATE         =  (SELECT TOP 1 U.COMPRA_VALOR_TASA 
								FROM BACSWAPSUDA..CARTERA_UNWIND U 
								WHERE	U.FECHAANTICIPO		= CAB.FECHAANTICIPO 
								AND		U.NUMERO_OPERACION	= CAB.NUMERO_OPERACION
								AND		U.TIPO_FLUJO		= CAB.TIPO_FLUJO
								ORDER BY U.NUMERO_FLUJO DESC)  -->>CAB.compra_valor_tasa--CAB.COMPRA_INTERES
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		-- SD_RATE         =  CAB.compra_valor_tasa--CAB.COMPRA_INTERES

		, SD_SPREAD       =  CAB.COMPRA_SPREAD
		, SD_FROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE < HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_INICIO_FLUJO ELSE '' END 
		, SD_BROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE > HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_VENCE_FLUJO ELSE '' END 
		
		
		-->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 

		, SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 
		, SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		/*
		 SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		*/
		, SD_ROUND_INT    =  0
		, SD_ROUND_CFLOW  =  0

		-->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 365 ) > 0
										  THEN LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 360) ) + 'Y'
								WHEN CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) /30) = 0
								THEN LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360)) )  + 'D' 
								ELSE LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 30) )  + 'M' END 
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		/*
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,PLAZOFLUJO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,PLAZOFLUJO / 360) ) + 'Y'
								   WHEN CONVERT(INT,PLAZOFLUJO /30) = 0
								   THEN LTRIM(CONVERT(INT,PLAZOFLUJO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,PLAZOFLUJO / 30) )  + 'M' END 
		*/
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN COMPRA_MONEDA ELSE RECIBIMOS_MONEDA END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE B ON B.TBCATEG = 74 AND B.TBCODIGO1 = COMPRA_BASE 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON C.TBCATEG = 75 AND C.TBCODIGO1 = COMPRA_MONEDA 
		LEFT JOIN #HISTORICO HIS ON HIS.NUMERO_OPERACION = CAB.NUMERO_OPERACION AND CAB.TIPO_FLUJO = HIS.TIPO_FLUJO
  LEFT JOIN (SELECT   
      CP.Modulo ,   
      CP.Moneda,   
      CP.INDICADOR,  
      CP.PRODUCTO,  
      "CodCurvaFwd" = CASE CP.CurAlter   
             WHEN  NULL THEN '' --'NO APLICA'  
             WHEN '' THEN CP.CODIGOCURVA  
             ELSE CP.CurAlter END,  
      "CodCurvaAlter" = CP.CODIGOCURVA 
      ,tipotasa -->>CVM20210114
      ,CP.CURVA_SAT
     FROM BacParamSuda..CURVAS_PRODUCTO  CP   with (nolock)      
     WHERE CP.Modulo = 'PCS') AS TmpCurva ON  
      TmpCurva.Moneda = CAB.compra_moneda  
      AND TmpCurva.INDICADOR = CAB.compra_codigo_tasa  
      AND TmpCurva.CodCurvaAlter = CASE WHEN CAB.Compra_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN TmpCurva.CodCurvaAlter ELSE CAB.Compra_Curva_Descont END   
      AND TmpCurva.PRODUCTO = CASE CAB.tipo_swap WHEN 1 THEN 'ST' WHEN 2 THEN 'SM' WHEN 3 THEN 'FRA' WHEN 4 THEN 'SP' END  
 WHERE CAB.TIPO_FLUJO =1   
	AND CAB.FECHAANTICIPO	= @FECHA_SWP  
	AND CAB.fecha_termino	= CAB.fecha_vence_flujo 
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	-- ================================================
	-- SWAPS - PAGAMOS
	-- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT DISTINCT SD_ID           =  CAB.TIPO_FLUJO	--1 --MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
         , FF_ID           =  CASE CAB.VENTA_CODIGO_TASA WHEN 0 THEN 0 ELSE 1 END -- 0-FIXED/1-FLOAT
         , PR_ID           =  1 -- PAY
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  B.TBTASA  -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
			, PROJ_CRV_ID     =  RTRIM(LTRIM(ISNULL(TmpCurvaP.CURVA_SAT,'')))/*CASE WHEN TIPOTASA = 'F' THEN '-1'-->>CVM20210114
									ELSE 
										CASE WHEN TmpCurvaP.CodCurvaAlter IS NULL then   
											CASE WHEN NOT CAB.Venta_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN  
											 CAB.Venta_Curva_Descont  
											ELSE  
											 '' --'NO APLICA'   
											END  
										 ELSE CodCurvaFwd--TmpCurvaP.CodCurvaAlter 
										 END  
								END*/
         , INS_ID          =  CAB.NUMERO_OPERACION
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  5 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  CAB.fecha_inicio	--20210215.RCH CAB.fecha_inicio_flujo
         , SD_END_DATE     =  CAB.fecha_termino	--20210215.RCH CAB.fecha_vence_flujo
         , SD_NOTNL        =  CAB.VENTA_CAPITAL
         , SD_RATE         =  CAB.venta_valor_tasa--CAB.VENTA_INTERES
         , SD_SPREAD       =  CAB.VENTA_SPREAD
         , SD_FROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE < HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_INICIO_FLUJO ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE > HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_VENCE_FLUJO ELSE '' END 
         , SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
                                   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								   WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								   THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								   ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,PLAZOFLUJO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,PLAZOFLUJO / 360) ) + 'Y'
								   WHEN CONVERT(INT,PLAZOFLUJO /30) = 0
								   THEN LTRIM(CONVERT(INT,PLAZOFLUJO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,PLAZOFLUJO / 30) )  + 'M' END 
	FROM BACSWAPSUDA..CARTERA AS CAB 
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN VENTA_MONEDA ELSE PAGAMOS_MONEDA END )
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE B ON B.TBCATEG = 74 AND B.TBCODIGO1 = VENTA_BASE 
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON C.TBCATEG = 75 AND C.TBCODIGO1 = VENTA_MONEDA 
		  LEFT JOIN #HISTORICO HIS ON HIS.NUMERO_OPERACION = CAB.NUMERO_OPERACION AND CAB.TIPO_FLUJO = HIS.TIPO_FLUJO
  LEFT JOIN (SELECT   
      CP.Modulo ,   
      CP.Moneda,   
      CP.INDICADOR,  
      CP.CODIGOCURVA,   
      CP.PRODUCTO,  
      "CodCurvaFwd" = CASE CP.CurAlter   
           WHEN  NULL THEN '' --'NO APLICA'  
           WHEN '' THEN CP.CODIGOCURVA  
           ELSE CP.CurAlter END,  
      "CodCurvaAlter" = CP.CODIGOCURVA  
      ,tipotasa -->>CVM20210114
      ,CP.CURVA_SAT
     FROM BacParamSuda..CURVAS_PRODUCTO  CP   with (nolock)      
     WHERE CP.Modulo = 'PCS') AS TmpCurvaP ON  
      TmpCurvaP.Moneda = CAB.venta_moneda  
      AND TmpCurvaP.INDICADOR = CAB.venta_codigo_tasa  
      AND TmpCurvaP.CodCurvaAlter = CASE WHEN ltrim(CAB.venta_Curva_Descont) IN('No Hay Curva', 'NO APLICA') THEN TmpCurvaP.CodCurvaAlter ELSE CAB.venta_Curva_Descont END   
      AND TmpCurvaP.PRODUCTO = CASE CAB.tipo_swap WHEN 1 THEN 'ST' WHEN 2 THEN 'SM' WHEN 3 THEN 'FRA' WHEN 4 THEN 'SP' END  
 WHERE   
  CAB.TIPO_FLUJO =2   
  AND CAB.ESTADO_FLUJO = 1   
  and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
--  AND CAB.NUMERO_OPERACION IN(756, 1082, 1354)  
	AND CAB.ESTADO<>'N'-->>20211116.CVM.NO SE CONSIDERA ANTIPO

	-->>CVM.20211105 SIID FLUJOS ANTICIPADOS
	INSERT INTO #VM_BAC_SIDE
	SELECT DISTINCT SD_ID           =  CAB.TIPO_FLUJO	--1 --MODIF. 20201006-solicitado x CAMILO P. -- 1 PAY	
         , FF_ID           =  CASE CAB.VENTA_CODIGO_TASA WHEN 0 THEN 0 ELSE 1 END -- 0-FIXED/1-FLOAT
         , PR_ID           =  1 -- PAY
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  B.TBTASA  -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
			, PROJ_CRV_ID     =  RTRIM(LTRIM(ISNULL(TmpCurvaP.CURVA_SAT,'')))/*CASE WHEN TIPOTASA = 'F' THEN '-1'-->>CVM20210114
									ELSE 
										CASE WHEN TmpCurvaP.CodCurvaAlter IS NULL then   
											CASE WHEN NOT CAB.Venta_Curva_Descont IN('No Hay Curva', 'NO APLICA') THEN  
											 CAB.Venta_Curva_Descont  
											ELSE  
											 '' --'NO APLICA'   
											END  
										 ELSE CodCurvaFwd--TmpCurvaP.CodCurvaAlter 
										 END  
								END*/
         , INS_ID          =  CAB.NUMERO_OPERACION
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  5 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  CAB.fecha_inicio	--20210215.RCH CAB.fecha_inicio_flujo
         , SD_END_DATE     =  CAB.fecha_termino	--20210215.RCH CAB.fecha_vence_flujo
         , SD_NOTNL        =  CAB.VENTA_CAPITAL

		 -->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_RATE         =  (SELECT TOP 1 U.VENTA_VALOR_TASA
								FROM BACSWAPSUDA..CARTERA_UNWIND U 
								WHERE	U.FECHAANTICIPO		= CAB.FECHAANTICIPO 
								AND		U.NUMERO_OPERACION	= CAB.NUMERO_OPERACION
								AND		U.TIPO_FLUJO		= CAB.TIPO_FLUJO
								ORDER BY U.NUMERO_FLUJO DESC)  -->>CAB.compra_valor_tasa--CAB.COMPRA_INTERES
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		--, SD_RATE         =  CAB.venta_valor_tasa--CAB.VENTA_INTERES

         , SD_SPREAD       =  CAB.VENTA_SPREAD
         , SD_FROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE < HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_INICIO_FLUJO ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAB.NUMERO_FLUJO = 1 AND CAB.FECHA_CIERRE > HIS.FECHA_INICIO_FLUJO THEN HIS.FECHA_VENCE_FLUJO ELSE '' END 


		 -->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 
		, SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 
		, SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /30) + 'M' END 
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		/*
		, SD_PYMT_PERIOD  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		, SD_RESET_PERIOD =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		, SD_RESET_SHIFT  =  CASE WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO )/ 360 > 0
										  THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /360) + 'Y'
								WHEN DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30 = 0
								THEN LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO)) + 'D' 
								ELSE LTRIM(DATEDIFF(dd,CAB.FECHA_INICIO_FLUJO ,CAB.FECHA_VENCE_FLUJO ) /30) + 'M' END 
		*/
          
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0

		 -->>20111116.CVM.CORRECCION POR DUPLICIDAD
		, SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 365 ) > 0
										  THEN LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 360) ) + 'Y'
								WHEN CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) /30) = 0
								THEN LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360)) )  + 'D' 
								ELSE LTRIM(CONVERT(INT,(DATEDIFF(dd,CAB.fecha_inicio ,CAB.fecha_termino ) /360) / 30) )  + 'M' END 
		--<<20111116.CVM.CORRECCION POR DUPLICIDAD
		/*
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,PLAZOFLUJO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,PLAZOFLUJO / 360) ) + 'Y'
								   WHEN CONVERT(INT,PLAZOFLUJO /30) = 0
								   THEN LTRIM(CONVERT(INT,PLAZOFLUJO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,PLAZOFLUJO / 30) )  + 'M' END 
		*/
	FROM BACSWAPSUDA..CARTERA_UNWIND AS CAB 
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON A.TBCATEG = 75 AND A.TBCODIGO1 = (CASE WHEN modalidad_pago = 'E' THEN VENTA_MONEDA ELSE PAGAMOS_MONEDA END )
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE B ON B.TBCATEG = 74 AND B.TBCODIGO1 = VENTA_BASE 
		  INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON C.TBCATEG = 75 AND C.TBCODIGO1 = VENTA_MONEDA 
		  LEFT JOIN #HISTORICO HIS ON HIS.NUMERO_OPERACION = CAB.NUMERO_OPERACION AND CAB.TIPO_FLUJO = HIS.TIPO_FLUJO
  LEFT JOIN (SELECT   
      CP.Modulo ,   
      CP.Moneda,   
      CP.INDICADOR,  
      CP.CODIGOCURVA,   
      CP.PRODUCTO,  
      "CodCurvaFwd" = CASE CP.CurAlter   
           WHEN  NULL THEN '' --'NO APLICA'  
           WHEN '' THEN CP.CODIGOCURVA  
           ELSE CP.CurAlter END,  
      "CodCurvaAlter" = CP.CODIGOCURVA  
      ,tipotasa -->>CVM20210114
      ,CP.CURVA_SAT
     FROM BacParamSuda..CURVAS_PRODUCTO  CP   with (nolock)      
     WHERE CP.Modulo = 'PCS') AS TmpCurvaP ON  
      TmpCurvaP.Moneda = CAB.venta_moneda  
      AND TmpCurvaP.INDICADOR = CAB.venta_codigo_tasa  
      AND TmpCurvaP.CodCurvaAlter = CASE WHEN ltrim(CAB.venta_Curva_Descont) IN('No Hay Curva', 'NO APLICA') THEN TmpCurvaP.CodCurvaAlter ELSE CAB.venta_Curva_Descont END   
      AND TmpCurvaP.PRODUCTO = CASE CAB.tipo_swap WHEN 1 THEN 'ST' WHEN 2 THEN 'SM' WHEN 3 THEN 'FRA' WHEN 4 THEN 'SP' END  
 WHERE	CAB.TIPO_FLUJO =2   
	AND CAB.FECHAANTICIPO	= @FECHA_SWP  
	AND CAB.fecha_termino	= CAB.fecha_vence_flujo
	and CAB.estado			<>'C'-->cvm20210115 exclusion cotizaciones
	--<<CVM.20211105 SIID FLUJOS ANTICIPADOS


	-- ================================================
	-- SWAPS - FLUJOS HISTORICOS (N°1)
	-- ================================================
	DROP TABLE #HISTORICO


	-- ================================================
	-- FORWARD - RECIBIMOS (COMPRAS)
	-- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT SD_ID           =  1	--0
         , FF_ID           =  0 -- 0-FIXED/1-FLOAT
         , PR_ID           =  0 -- RECIEVE
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  0 -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
         --, PROJ_CRV_ID     = 0	--PENDIENTE DE CAMBIO POR CONFIRMACIÓN --PLL20201022
         --, PROJ_CRV_ID     =  'FW_' + 
									--	CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
         --                          THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								 --  WHEN CONVERT(INT,CAPLAZO /30) = 0
								 --  THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								 --  ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END + '_' + 
									--	(CAST(C.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(d.tbglosa AS VARCHAR(3))) -- + '- RECIBIMOS (COMPRAS)' )
			--, PROJ_CRV_ID     = CAST(C.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(d.tbglosa AS VARCHAR(3))
			, PROJ_CRV_ID     = 'FX_3M_' + CAST(C.tbglosa AS VARCHAR(3)) + '.' + CAST(d.tbglosa AS VARCHAR(3))	-->>20210611
         , INS_ID          =  CAB.CANUMOPER
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  0 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  ISNULL((SELECT TOP 1 L.CAFECHA FROM BACFWDSUDA..MFCA_LOG L WHERE L.CANUMOPER = CAB.CANUMOPER ORDER BY L.CAFECMOD DESC),CAB.CAFECHA)-->>20210802 CAB.CAFECHA
         , SD_END_DATE     =  CAB.CAFECVCTO
         , SD_NOTNL        =  CAB.CAMTOMON1
         , SD_RATE         =  CAB.CAPARMON1
         , SD_SPREAD       =  0
         , SD_FROLL_DATE   =  CASE WHEN CAFECHA < CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAFECHA > CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_PYMT_PERIOD  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON 
			A.TBCATEG = 75 AND 
			A.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON1 ELSE moneda_compensacion END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON 
			C.TBCATEG = 75 AND 
			C.TBCODIGO1 = CACODMON1 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE D ON 
			D.TBCATEG = 75 AND 
			D.TBCODIGO1 = CACODMON2
	WHERE 
		CATIPOPER = 'C'

	
	---- ================================================
	---- FORWARD - RECIBIMOS (VENTAS)
	---- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT SD_ID           =  1	--0
         , FF_ID           =  0 -- 0-FIXED/1-FLOAT
         , PR_ID           =  0 -- 0=RECIEVE 1=PAGAMOS
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  0 -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
--         , PROJ_CRV_ID     =  0 -- *** PENDIENTE ***
         --, PROJ_CRV_ID     =  'FW_' + 
									--	CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
         --                          THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								 --  WHEN CONVERT(INT,CAPLAZO /30) = 0
								 --  THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								 --  ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END + '_' + 
									--	(CAST(D.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(C.tbglosa AS VARCHAR(3))) -- + '- RECIBIMOS (VENTAS)')
         --, PROJ_CRV_ID     = (CAST(D.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(C.tbglosa AS VARCHAR(3))) -- + '- RECIBIMOS (VENTAS)')
			, PROJ_CRV_ID     = 'FX_3M_' + CAST(d.tbglosa AS VARCHAR(3)) + '.' + CAST(c.tbglosa AS VARCHAR(3))	-->>20210611							
         , INS_ID          =  CAB.CANUMOPER
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  0 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  ISNULL((SELECT TOP 1 L.CAFECHA FROM BACFWDSUDA..MFCA_LOG L WHERE L.CANUMOPER = CAB.CANUMOPER ORDER BY L.CAFECMOD DESC),CAB.CAFECHA)-->>20210802 CAB.CAFECHA
         , SD_END_DATE     =  CAB.CAFECVCTO
         , SD_NOTNL        =  CAB.CAMTOMON2
         , SD_RATE         =  CAB.CAPARMON2
         , SD_SPREAD       =  0
         , SD_FROLL_DATE   =  CASE WHEN CAFECHA < CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAFECHA > CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_PYMT_PERIOD  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
	FROM BACFWDSUDA..MFCA AS CAB INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON 
			A.TBCATEG = 75 AND 
			A.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON2 ELSE moneda_compensacion END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON 
			C.TBCATEG = 75 AND 
			C.TBCODIGO1 = CACODMON2 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE D ON 
			D.TBCATEG = 75 AND 
			D.TBCODIGO1 = CACODMON1
	WHERE 
		CATIPOPER = 'V'      

	---- ================================================
	---- FORWARD - PAGAMOS (COMPRAS)
	---- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT SD_ID           =  2	--1
         , FF_ID           =  0 -- 0-FIXED/1-FLOAT
         , PR_ID           =  1 -- PAY
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  0 -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
         --, PROJ_CRV_ID     =  0 -- *** PENDIENTE ***
         --, PROJ_CRV_ID     =  'FW_' + 
									--	CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
         --                          THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								 --  WHEN CONVERT(INT,CAPLAZO /30) = 0
								 --  THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								 --  ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END + '_' + 
									--	(CAST(D.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(C.tbglosa AS VARCHAR(3)))	-- + '- PAGAMOS (VENTAS)')
         --, PROJ_CRV_ID     = (CAST(D.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(C.tbglosa AS VARCHAR(3)))	-- + '- PAGAMOS (VENTAS)')
         , PROJ_CRV_ID     = 'FX_3M_' + CAST(d.tbglosa AS VARCHAR(3)) + '.' + CAST(c.tbglosa AS VARCHAR(3))	-->>20210611
         , INS_ID          =  CAB.CANUMOPER
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  0 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  ISNULL((SELECT TOP 1 L.CAFECHA FROM BACFWDSUDA..MFCA_LOG L WHERE L.CANUMOPER = CAB.CANUMOPER ORDER BY L.CAFECMOD DESC),CAB.CAFECHA)-->>20210802 CAB.CAFECHA
         , SD_END_DATE     =  CAB.CAFECVCTO
         , SD_NOTNL        =  CAB.CAMTOMON2
         , SD_RATE         =  CAB.CAPARMON2
       , SD_SPREAD       =  0
         , SD_FROLL_DATE   =  CASE WHEN CAFECHA < CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAFECHA > CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_PYMT_PERIOD  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON 
			A.TBCATEG = 75 AND 
			A.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON2 ELSE moneda_compensacion END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON 
			C.TBCATEG = 75 AND 
			C.TBCODIGO1 = CACODMON2 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE D ON 
			D.TBCATEG = 75 AND 
			D.TBCODIGO1 = CACODMON1
	WHERE CATIPOPER = 'C'      


	---- ================================================
	---- FORWARD - PAGAMOS (VENTAS)
	---- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT SD_ID           =  2	--1
         , FF_ID           =  0 -- 0-FIXED/1-FLOAT
         , PR_ID           =  1 -- PAY	
         , DRC_ID          =  1 -- FOLLOW
         , PYMT_CCY_ID     =  A.TBTASA  -- CURRENCU
         , DCC_ID          =  0 -- DAY_COUNT_CONV
         , NOT_CCY_ID      =  C.TBTASA  -- CURRENCY
         --, PROJ_CRV_ID     =  0 -- *** PENDIENTE ***
         --, PROJ_CRV_ID     =  'FW_' + 
									--	CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
         --                          THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
									--		WHEN CONVERT(INT,CAPLAZO /30) = 0
									--			THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
									--		ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END + '_' + 
									--	(CAST(C.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(d.tbglosa AS VARCHAR(3)))	-- + '- PAGAMOS (COMPRAS)')
         --, PROJ_CRV_ID     =  (CAST(C.tbglosa AS VARCHAR(3)) + @SEP_PARMON + CAST(d.tbglosa AS VARCHAR(3)))	-- + '- PAGAMOS (COMPRAS)')
         , PROJ_CRV_ID     = 'FX_3M_' + CAST(C.tbglosa AS VARCHAR(3)) + '.' + CAST(d.tbglosa AS VARCHAR(3))	-->>20210611
         , INS_ID          =  CAB.CANUMOPER
         , SCON_ID         =  0 -- *** PENDIENTE ***
         , DISC_CRV_ID     =  0 -- *** PENDIENTE ***
         , RS_ID           =  0 -- MERCADO *** PENDIENTE ***
         , SD_START_DATE   =  ISNULL((SELECT TOP 1 L.CAFECHA FROM BACFWDSUDA..MFCA_LOG L WHERE L.CANUMOPER = CAB.CANUMOPER ORDER BY L.CAFECMOD DESC),CAB.CAFECHA)-->>20210802 CAB.CAFECHA
         , SD_END_DATE     =  CAB.CAFECVCTO
         , SD_NOTNL        =  CAB.CAMTOMON1
         , SD_RATE         =  CAB.CAPARMON1
         , SD_SPREAD       =  0
         , SD_FROLL_DATE   =  CASE WHEN CAFECHA < CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_BROLL_DATE   =  CASE WHEN CAFECHA > CAFECHASTARTING THEN CAFECHASTARTING  ELSE '' END 
         , SD_PYMT_PERIOD  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_PERIOD =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_RESET_SHIFT  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  CASE WHEN CONVERT(INT,CAPLAZO / 365 ) > 0
                                   THEN LTRIM(CONVERT(INT,CAPLAZO/ 360) ) + 'Y'
								   WHEN CONVERT(INT,CAPLAZO /30) = 0
								   THEN LTRIM(CONVERT(INT,CAPLAZO) )  + 'D' 
								   ELSE LTRIM(CONVERT(INT,CAPLAZO / 30) )  + 'M' END 
	FROM BACFWDSUDA..MFCA AS CAB 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE A ON 
			A.TBCATEG = 75 AND 
			A.TBCODIGO1 = (CASE WHEN moneda_compensacion = 0 THEN CACODMON1 ELSE moneda_compensacion END )
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE C ON 
			C.TBCATEG = 75 AND 
			C.TBCODIGO1 = CACODMON1 
		INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE D ON 
			D.TBCATEG = 75 AND 
			D.TBCODIGO1 = CACODMON2
	WHERE 
		CATIPOPER = 'V'

	
	---- ================================================
	---- OPCIONES 
	---- ================================================
	INSERT INTO #VM_BAC_SIDE
	SELECT SD_ID           =  CAST(DC.CaNumEstructura AS VARCHAR(10))	--0
         , FF_ID           =  0	--
         , PR_ID           =  CASE WHEN CaCVOpc = 'V' THEN 0 ELSE 1 END -- RECIEVE
         , DRC_ID          =  0
         , PYMT_CCY_ID     =  CASE WHEN DC.CaModalidad = 'C' THEN PC.mu_BASE_CCY_ID  ELSE NC.mu_BASE_CCY_ID END
         , DCC_ID          =  0
         , NOT_CCY_ID      =  NC.mu_BASE_CCY_ID 
         , PROJ_CRV_ID     =  0
         , INS_ID          =  CAST(EC.CanumContrato AS VARCHAR(10)) + CAST(DC.CaNumEstructura AS VARCHAR(10))-->>20210611-->>20210802
         , SCON_ID         =  0
         , DISC_CRV_ID     =  0
         , RS_ID           =  0
         , SD_START_DATE   =  DC.CaFechaInicioOpc
         , SD_END_DATE     =  DC.CaFechaVcto
         , SD_NOTNL        =  DC.CaMontoMon1
         , SD_RATE         =  0
         , SD_SPREAD       =  0
         , SD_FROLL_DATE   =  0
         , SD_BROLL_DATE   =  0
         , SD_PYMT_PERIOD  =  0
         , SD_RESET_PERIOD =  0
         , SD_RESET_SHIFT  =  0
         , SD_ROUND_INT    =  0
         , SD_ROUND_CFLOW  =  0
         , SD_OFFSET_DATE  =  0
	FROM CbMdbOpc..CaEncContrato AS EC INNER JOIN CbMdbOpc..CaDetContrato AS DC ON
			DC.CanumContrato = EC.CanumContrato 	
		LEFT JOIN BacParamSuda.dbo.MONEDA AS MN ON 
			MN.mncodmon = DC.CaCodMon1	
		LEFT JOIN #PasoBASE_CCY AS NC ON
			NC.Cod_BAC = MN.mnnemo								   
		LEFT JOIN BacParamSuda.dbo.MONEDA AS MCOMP ON 
			MCOMP.mncodmon = DC.CaMdaCompensacion
		LEFT JOIN #PasoBASE_CCY AS PC ON
			PC.Cod_BAC = MCOMP.mnnemo								   
--     WHERE 		EC.CaNumContrato in(4883, 6341)
	WHERE
		EC.CaEstado <> 'C' --Se excluyen las Cotizaciones  --PLL-20201113
	
	---SELECT '#VM_BAC_SIDE' AS TABLA,* FROM #VM_BAC_SIDE WHERE INS_ID=756--
	---- ================================================
	---- SALIDA INTERFAZ
	---- ================================================
	INSERT INTO #VM_BAC_SIDE_SALIDA	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	SELECT 
		"ORDEN" = 1,		--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
					LTRIM(SD_ID)            + @SEP
					+ LTRIM(FF_ID)            + @SEP
					+ LTRIM(PR_ID)            + @SEP
					+ LTRIM(DRC_ID)           + @SEP
					+ LTRIM(PYMT_CCY_ID)      + @SEP
					+ LTRIM(DCC_ID)           + @SEP
					+ LTRIM(NOT_CCY_ID)       + @SEP
					+ LTRIM(PROJ_CRV_ID)      + @SEP
					+ LTRIM(INS_ID)           + @SEP
					+ LTRIM(SCON_ID)          + @SEP
					+ LTRIM(DISC_CRV_ID)      + @SEP
					+ LTRIM(RS_ID)            + @SEP
					--+ LTRIM(CONVERT(CHAR(10),SD_START_DATE,120))    + @SEP
					+ LTRIM(CONVERT(CHAR(10),SD_START_DATE,103))    + @SEP
					--+ LTRIM(CONVERT(CHAR(10),SD_END_DATE,120))      + @SEP
					+ LTRIM(CONVERT(CHAR(10),SD_END_DATE,103))      + @SEP
					+ LTRIM(SD_NOTNL)         + @SEP
					+ LTRIM(SD_RATE)          + @SEP
					+ LTRIM(SD_SPREAD)        + @SEP
					--+ LTRIM(CONVERT(CHAR(10),SD_FROLL_DATE,120))    + @SEP
					+ LTRIM(CONVERT(CHAR(10),SD_FROLL_DATE,103))    + @SEP
					--+ LTRIM(CONVERT(CHAR(10),SD_BROLL_DATE,120))    + @SEP
					+ LTRIM(CONVERT(CHAR(10),SD_BROLL_DATE,103))    + @SEP
					+ LTRIM(SD_PYMT_PERIOD)   + @SEP
					+ LTRIM(SD_RESET_PERIOD)  + @SEP
					+ LTRIM(SD_RESET_SHIFT)   + @SEP
					+ LTRIM(SD_ROUND_INT)     + @SEP
					+ LTRIM(SD_ROUND_CFLOW)   + @SEP
					+ LTRIM(SD_OFFSET_DATE)   AS REG_SALIDA
	FROM #VM_BAC_SIDE
	--ORDER BY 1 -- se comenta porque no es necesario a este nivel-- PLL-20200512
	--select '#VM_BAC_SIDE' as tabla,* from #VM_BAC_SIDE where INS_ID = 756--aqui

	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512
	INSERT INTO #VM_BAC_SIDE_SALIDA 
	SELECT 
		"ORDEN" = -1,
		"REG_SALIDA" = 'SD_ID'    + @SEP
						 + 'FF_ID'            + @SEP
						 + 'PR_ID'            + @SEP
						 + 'DRC_ID'           + @SEP
						 + 'PYMT_CCY_ID'      + @SEP
						 + 'DCC_ID'           + @SEP
						 + 'NOT_CCY_ID'       + @SEP
						 + 'PROJ_CRV_ID'      + @SEP
						 + 'INS_ID'           + @SEP
						 + 'SCON_ID'          + @SEP
						 + 'DISC_CRV_ID'      + @SEP
						 + 'RS_ID'            + @SEP
						 + 'SD_START_DATE'    + @SEP
						 + 'SD_END_DATE'      + @SEP
						 + 'SD_NOTNL'         + @SEP
						 + 'SD_RATE'          + @SEP
						 + 'SD_SPREAD'        + @SEP
						 + 'SD_FROLL_DATE'    + @SEP
						 + 'SD_BROLL_DATE'    + @SEP
						 + 'SD_PYMT_PERIOD'   + @SEP
						 + 'SD_RESET_PERIOD'  + @SEP
						 + 'SD_RESET_SHIFT'   + @SEP
						 + 'SD_ROUND_INT'     + @SEP
						 + 'SD_ROUND_CFLOW'   + @SEP
						 + 'SD_OFFSET_DATE' 
	WHERE 
		@Con_Linea_Encabezado = 'Y'
	

	SELECT REG_SALIDA FROM #VM_BAC_SIDE_SALIDA 
	WHERE LEN(LTRIM(RTRIM(REG_SALIDA)))>0-->>CONTROL ESPACIOS EN BLANCO 20210810
	ORDER BY ORDEN, 1
	--SE AGREGA PARA INCORPORAR LINEA DE ENCABEZADO A SALIDA -- PLL-20200512

	DROP TABLE #VM_BAC_SIDE
	DROP TABLE #VM_BAC_SIDE_SALIDA 

END 
--ROLLBACK TRAN
GO

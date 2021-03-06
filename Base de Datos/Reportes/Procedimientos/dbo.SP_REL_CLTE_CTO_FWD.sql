USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CLTE_CTO_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_REL_CLTE_CTO_FWD]
(
	@FECHA	DATE = NULL	
)
AS 
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ RELACION CLIENTE CONTRATO, FORWARD
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 17-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	--DECLARE @FECHA DATE
	--SET @FECHA='2017-07-18'

	IF @FECHA IS NULL BEGIN
		SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM Bacfwdsuda.dbo.mfac WITH(NOLOCK)) 
	END ELSE
	BEGIN
		SET @FECHA_PROC_FILTRO = @FECHA --(SELECT TOP 1 acfecproc FROM Bacfwdsuda.dbo.mfac WITH(NOLOCK)) 
	END		
	SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

/*******************************************************
		EXTRACCION DE DATOS
********************************************************/
SELECT 
	 T2.NUMERO_FOLIO
	,T2.NUMERO_OPERACION
	,T2.CORRELATIVO
	,T2.ID_SISTEMA
	,T2.COD_SUBPRODU_1
	,T2.MONEDA_OPERACION_1
	,T2.RUT_CLIENTE
	,T2.CODIGO_CLIENTE
	,@FECHA_PROC_FILTRO			 AS FECHA_PROCESO
	,T2.FECHA_INICIO
	,T2.FECHA_VENCIMIENTO
	,T2.STATUS_V
	,1							 AS T_FLUJO
FROM (
/*CARTERA VIGENTE */
SELECT DISTINCT 
CANUMOPER										AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
,(case 
    when caAntCorrela = 0 then 1
    when caAntCorrela is null then 1
    else caAntCorrela    
  end)											AS CORRELATIVO--CAANTCORRELA		
,'BFW'											AS ID_SISTEMA	
,CACODPOS1										AS COD_SUBPRODU_1
,CACODPOS2										AS COD_SUBPRODU_2
,CATIPOPER										AS TIPO_FWD
,CACODIGO										AS RUT_CLIENTE
,CACODCLI										AS CODIGO_CLIENTE
,CACODMON1										AS MONEDA_OPERACION_1
,CACODMON2										AS MONEDA_OPERACION_2
,CAFECHAPROCESO									AS FECHA_PROCESO
,CAFECHA										AS FECHA_INICIO -- ??
,CAFECVCTO										AS FECHA_VENCIMIENTO
,CAESTADO										AS ESTADO_OPE
,'VIGENTE'										AS STATUS_V
FROM BACFWDSUDA.DBO.MFCARES
WHERE 
	CAFECHAPROCESO = @FECHA_PROC_FILTRO
AND CAFECVCTO > @FECHA_INI_FILTRO  
AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') --> A:anulado, P:pendiente

UNION 
-- CARTERA VENCIDA /CANCELADA
SELECT T1.* 
FROM (
SELECT DISTINCT 
CANUMOPER										AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
,(case 
    when caAntCorrela = 0 then 1
    when caAntCorrela is null then 1
    else caAntCorrela    
  end)											AS CORRELATIVO--CAANTCORRELA		
,'BFW'											AS ID_SISTEMA	
,CACODPOS1										AS COD_SUBPRODU_1
,CACODPOS2										AS COD_SUBPRODU_2
,CATIPOPER										AS TIPO_FWD
,CACODIGO										AS RUT_CLIENTE
,CACODCLI										AS CODIGO_CLIENTE
,CACODMON1										AS MONEDA_OPERACION_1
,CACODMON2										AS MONEDA_OPERACION_2
,CAFECHAPROCESO									AS FECHA_PROCESO
,CAFECHA										AS FECHA_INICIO -- ??
,CAFECVCTO										AS FECHA_VENCIMIENTO
,CAESTADO										AS ESTADO_OPE
,'VENCIDA'										AS STATUS_V
FROM BACFWDSUDA.DBO.MFCARES
WHERE 
    CaFechaProceso = @FECHA_PROC_FILTRO
AND cafecvcto BETWEEN @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') 

UNION
SELECT DISTINCT 
 ch.CANUMOPER									AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
, 1												AS CORRELATIVO			--ch.CAANTCORRELA	
,'BFW'											AS ID_SISTEMA	
,ch.CACODPOS1									AS COD_SUBPRODU_1
,ch.CACODPOS2									AS COD_SUBPRODU_2
,ch.CATIPOPER									AS TIPO_FWD
,ch.CACODIGO									AS RUT_CLIENTE
,ch.CACODCLI									AS CODIGO_CLIENTE
,ch.CACODMON1									AS MONEDA_OPERACION_1
,ch.CACODMON2									AS MONEDA_OPERACION_2
,ch.cafecproc									AS FECHA_PROCESO
,ch.CAFECHA										AS FECHA_INICIO -- ??
,ch.CAFECVCTO									AS FECHA_VENCIMIENTO
,ch.CAESTADO									AS ESTADO_OPE
,'CANCELADA'									AS STATUS_V
FROM bacfwdsuda.dbo.mfcah ch with(nolock)
	inner join (
		SELECT DISTINCT CANUMOPER
		FROM BACFWDSUDA.DBO.mfcah with(nolock)
		where 
			Cafecvcto >=@FECHA_INI_FILTRO
		AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') 
		
		) cv on cv.canumoper = ch.canumoper
WHERE 
	CH.cafecvcto >=@FECHA_INI_FILTRO
AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') 
) AS T1
) AS T2





--WHERE T2.NUMERO_OPERACION=610089

/*
	-- FILTROS DE ODS...
	AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') --> ???	
	AND CACODPOS1<>10
	SELECT @FECHA_PROC_FILTRO
*/

--SELECT caAntCorrela,* FROM Bacfwdsuda.dbo.mfca
--where canumoper=610089

--SELECT caAntCorrela,* FROM Bacfwdsuda.dbo.mfca
--where canumoper=610094



--SELECT caAntCorrela,* FROM Bacfwdsuda.dbo.mfcares
--where caAntCorrela >1

--where canumoper=610089
--and CaFechaProceso='2017-06-08'


END
GO

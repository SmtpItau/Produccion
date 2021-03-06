USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CLTE_CTO_PSV]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REL_CLTE_CTO_PSV]
(
	@FECHA	DATE = NULL	
)
AS 
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD
--	PROYECTO	: RENTABILIDAD
--	DESCRIPCION	: INTERFAZ RELACION CLIENTE CONTRATO, PASIVO
--	AUTOR		: SONDA
--	FECHA		: 10-10-2018

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE

	IF @FECHA IS NULL BEGIN
		SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
	END ELSE
	BEGIN
		SET @FECHA_PROC_FILTRO = @FECHA 
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
numero_operacion								AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
,numero_correlativo								as correlativo	
,'PSV'											AS ID_SISTEMA	
,codigo_instrumento								AS COD_SUBPRODU_1
,codigo_instrumento								AS COD_SUBPRODU_2
,'C'											AS TIPO_PSV
,rut_cliente									AS RUT_CLIENTE
,codigo_cliente 								AS CODIGO_CLIENTE
,moneda_emision									AS MONEDA_OPERACION_1
,moneda_emision									AS MONEDA_OPERACION_2
,@FECHA_PROC_FILTRO								AS FECHA_PROCESO
,@FECHA_INI_FILTRO								AS FECHA_INICIO -- ??
,fecha_vencimiento								AS FECHA_VENCIMIENTO
,'A'											AS ESTADO_OPE
,'VIGENTE'										AS STATUS_V
FROM MDPasivo..CARTERA_PASIVO
WHERE fecha_vencimiento > @FECHA_INI_FILTRO  

UNION 
-- CARTERA VENCIDA /CANCELADA
SELECT T1.* 
FROM (
SELECT DISTINCT 
numero_operacion								AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
,numero_correlativo								AS CORRELATIVO
,'PSV'											AS ID_SISTEMA	
,codigo_instrumento								AS COD_SUBPRODU_1
,codigo_instrumento								AS COD_SUBPRODU_2
,'C'											AS TIPO_PSV
,rut_cliente									AS RUT_CLIENTE
,codigo_cliente 								AS CODIGO_CLIENTE
,moneda_emision									AS MONEDA_OPERACION_1
,moneda_emision									AS MONEDA_OPERACION_2
,@FECHA_PROC_FILTRO								AS FECHA_PROCESO
,@FECHA_INI_FILTRO								AS FECHA_INICIO -- ??
,fecha_vencimiento								AS FECHA_VENCIMIENTO
,'V'											AS ESTADO_OPE
,'VENCIDA'										AS STATUS_V
FROM MDPasivo..CARTERA_PASIVO
WHERE fecha_vencimiento BETWEEN @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO

UNION
SELECT DISTINCT 
 ch.numero_operacion							AS NUMERO_OPERACION
,-1												AS NUMERO_FOLIO
, 1												AS CORRELATIVO			
,'PSV'											AS ID_SISTEMA	
,ch.codigo_instrumento							AS COD_SUBPRODU_1
,ch.codigo_instrumento							AS COD_SUBPRODU_2
,'C'											AS TIPO_PSV
,ch.rut_cliente									AS RUT_CLIENTE
,ch.codigo_cliente 								AS CODIGO_CLIENTE
,ch.moneda_emision								AS MONEDA_OPERACION_1
,ch.moneda_emision								AS MONEDA_OPERACION_2
,@FECHA_PROC_FILTRO								AS FECHA_PROCESO
,@FECHA_INI_FILTRO								AS FECHA_INICIO -- ??
,ch.fecha_vencimiento							AS FECHA_VENCIMIENTO
,'C'											AS ESTADO_OPE
,'CANCELADA'									AS STATUS_V
FROM MDPasivo..CARTERA_PASIVO_HISTORICA ch with(nolock)
inner join (SELECT DISTINCT numero_operacion FROM MDPasivo..CARTERA_PASIVO_HISTORICA with(nolock) where fecha_vencimiento >=@FECHA_INI_FILTRO ) cv on cv.numero_operacion = ch.numero_operacion
WHERE CH.fecha_vencimiento >=@FECHA_INI_FILTRO
) AS T1
) AS T2


END
GO

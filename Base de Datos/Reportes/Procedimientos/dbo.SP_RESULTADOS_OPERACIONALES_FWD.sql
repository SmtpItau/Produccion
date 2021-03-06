USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_OPERACIONALES_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_RESULTADOS_OPERACIONALES_FWD
CREATE PROCEDURE [dbo].[SP_RESULTADOS_OPERACIONALES_FWD]
(
	@FECHA DATE = NULL
)
AS
BEGIN
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ RESULTADO OPERACIONES
--MODIFICACION	: 27-08-2018 operaciones duplicadas

SET NOCOUNT ON 
SET DATEFORMAT YMD

DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE
--DECLARE @FECHA DATE
--SET @FECHA = '2017-12-15'

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (select top 1 acfecproc from Bacfwdsuda.dbo.mfac with(nolock))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

/*************************************************************/
/* CUENTAS PERTENECIENTES AL ARCHIVO.						 */
/*************************************************************/
DECLARE @CUENTAS_RESULTADO TABLE
(
	CUENTA VARCHAR(20)
)
INSERT INTO @CUENTAS_RESULTADO
SELECT CUENTA FROM RNT_INT_MTX_CONTABLE
WHERE INTERFAZ = 'RESULTADO'

/*************************************************************/
/* LIMPIEZA Y GENERACION DE TMP'S							 */
/*************************************************************/
IF OBJECT_ID('TEMPDB..#TMP_RESULTADO_FWD') IS NOT NULL BEGIN
	DROP TABLE #TMP_RESULTADO_FWD
END

IF OBJECT_ID('TEMPDB..#TMP_DATOS_FWD') IS NOT NULL BEGIN
	DROP TABLE #TMP_DATOS_FWD
END

CREATE TABLE #TMP_RESULTADO_FWD
(
 NRO_OPERACION			NUMERIC(20)		DEFAULT(0)
,NRO_DOCUMENTO			NUMERIC(20)		DEFAULT(0)
,NRO_CORRELATIVO		NUMERIC(20)		DEFAULT(0)
,COD_CTA_CONT			VARCHAR(20)
,TIP_IE					CHAR(2)
,COD_DIVISA				VARCHAR(4)
,FEC_DATA				DATE --NUMBER(8)
,COD_ENTIDAD			VARCHAR(4)		DEFAULT('1769')
,COD_PRODUCTO			VARCHAR(4)		DEFAULT('BFW')
,COD_SUBPRODU			VARCHAR(4)
,IMP_IE_MO				NUMERIC(20,4)	DEFAULT(0) 
,IMP_IE_ML				NUMERIC(20,4)	DEFAULT(0)
,COD_CENTRO_CONT		VARCHAR(4)		DEFAULT('2230')
,IMP_SDO_IE_MO			NUMERIC(20,4)	DEFAULT(0)
,IMP_SDO_IE_ML			NUMERIC(20,4)	DEFAULT(0)
,T_FLUJO				NUMERIC			DEFAULT(1)
)

/********************************************************************/
/*	VALOR REPRESENTACION CONTABLE									*/
/********************************************************************/
DECLARE @VALOR_TC_CONTABLE TABLE
(
	CODIGO	INT,
	VALOR	FLOAT,
	NEMO	VARCHAR(3) NULL,	
	FECHA	DATE
)

INSERT INTO @VALOR_TC_CONTABLE
SELECT 
	 CODIGO_MONEDA = CASE CODIGO_MONEDA WHEN 994 THEN 13 ELSE CODIGO_MONEDA END
	,TIPO_CAMBIO
	,NEMO_MONEDA = CASE NEMO_MONEDA WHEN 'DO' THEN 'USD' ELSE NEMO_MONEDA END
	,FECHA
FROM BACPARAMSUDA.DBO.VALOR_MONEDA_CONTABLE
WHERE FECHA BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO

INSERT INTO @VALOR_TC_CONTABLE
SELECT 
	 VMCODIGO
	,VMVALOR
	,'UF'
	,VMFECHA
FROM BACPARAMSUDA.DBO.VALOR_MONEDA
WHERE 
		VMCODIGO = 998 
AND		VMFECHA BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO

INSERT INTO @VALOR_TC_CONTABLE
SELECT 
	999,1.0,'CLP',VMFECHA
FROM BACPARAMSUDA.DBO.VALOR_MONEDA
WHERE 
	VMCODIGO=998 
AND		VMFECHA BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO

UPDATE @VALOR_TC_CONTABLE
SET VALOR = 1
WHERE CODIGO=998
--INSERT INTO @VALOR_TC_CONTABLE 
--SELECT VMCODIGO,VMVALOR,
--(case VMCODIGO
--	when 994 then 'DO'
--	when 995 then 'DA'
--	when 997 then 'IVP'
--	when 998 then 'UF'
--	when 999 then 'CLP'
--end)
--,vmfecha FROM BACPARAMSUDA.DBO.VALOR_MONEDA 
--WHERE 
--VMFECHA BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO 
--AND VMCODIGO IN(994,995,998,997,999)

--INSERT INTO @VALOR_TC_CONTABLE 
--SELECT 999,1.0,'CLP',FECHA
--FROM @VALOR_TC_CONTABLE WHERE CODIGO=998

--INSERT INTO @VALOR_TC_CONTABLE 
--SELECT 
--	(CASE 
--		WHEN CODIGO_MONEDA = 994 THEN 13  
--		ELSE CODIGO_MONEDA  
--	END) 
--	,TIPO_CAMBIO 
--	,LTRIM(RTRIM(NEMO_MONEDA))
--	,Fecha
--FROM BACPARAMSUDA.DBO.VALOR_MONEDA_CONTABLE
--WHERE FECHA  between @fecha_ini_filtro and @FECHA_PROC_FILTRO
--AND CODIGO_MONEDA NOT IN (13,995,998,997,999)


/* data */
SELECT 
 NRO_OPERACION
,NRO_DOCUMENTO = NULL
,CORRELATIVO
,FECHA_CONTABLE
,CODIGO_DIVISA
,DESC_DIVISA
,TIPO_CAMBIO
,CUENTA
,TIPO_CUENTA
,DEBE = [D] 		
,HABER = [H] 
,COD_SUBPRODU =  NULL 
INTO #TMP_DATOS_FWD
from
(
select 
 nro_operacion				=	vh.Operacion
,correlativo				=	1
,fecha_contable				=	convert(date,vh.fecha_ingreso)
,codigo_divisa				=	vd.Moneda
,desc_divisa				=	mn.nemo
,tipo_cambio				=	mn.valor
,cuenta						=	vd.Cuenta
,tipo_cuenta				=	pc.tipo_cuenta
,monto						=	(case when mn.codigo = 999 then round(vd.monto,0) else round(vd.monto,4) end) 
,tipo_monto					=	vd.Tipo_Monto

from 
			Bacfwdsuda.dbo.voucher_cnt			as vh with(nolock)
inner join	Bacfwdsuda.dbo.detalle_voucher_cnt	as vd with(nolock) on vh.Numero_Voucher = vd.Numero_Voucher
inner join	BacParamSuda.dbo.PLAN_DE_CUENTA		as pc with(nolock) on vd.Cuenta			= pc.cuenta
--+++fmo 20180827 resultado contable
INNER JOIN  Bacfwdsuda..mfcares as car with(nolock) ON car.canumoper=vh.Operacion and car.CaFechaProceso between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
-----fmo 20180827 resultado contable
inner join  @VALOR_TC_CONTABLE					as mn			   on mn.codigo			= vd.Moneda and vh.fecha_ingreso=mn.fecha
where 
	vh.Fecha_Ingreso between @fecha_ini_filtro and @fecha_proc_filtro
and pc.cuenta in (select cuenta from @CUENTAS_RESULTADO)
)AS T1
PIVOT
(
	SUM(MONTO)
	FOR TIPO_MONTO IN ([D],[H])
) AS PVT
ORDER BY PVT.NRO_OPERACION

CREATE NONCLUSTERED INDEX IDX_TMP_DATOS_OPT_001 ON #TMP_DATOS_FWD (NRO_OPERACION,FECHA_CONTABLE,TIPO_CUENTA,CUENTA,CODIGO_DIVISA)


UPDATE #TMP_DATOS_FWD
SET 
 DEBE = (CASE WHEN ISNULL(DEBE,-1)=-1 THEN 0 ELSE DEBE END)
,HABER = (CASE WHEN ISNULL(HABER,-1)=-1 THEN 0 ELSE HABER END)


/****************************************************************/
/*	BASE REPORTE FINAL  										*/
/****************************************************************/
INSERT INTO #TMP_RESULTADO_FWD(NRO_OPERACION,NRO_CORRELATIVO,COD_CTA_CONT,COD_DIVISA,FEC_DATA,IMP_SDO_IE_MO,IMP_SDO_IE_ML,IMP_IE_ML,IMP_IE_MO)
SELECT DISTINCT
NRO_OPERACION
,CORRELATIVO
,CUENTA
,DESC_DIVISA
,FEC_DATA						= @FECHA_PROC_FILTRO
,IMP_SDO_IE_MO					= NULL
,IMP_SDO_IE_ML					= NULL
,IMP_IE_MO						= NULL
,IMP_IE_ML						= NULL
FROM	
	#TMP_DATOS_FWD


/****************************************************************/
/*	ACUMULADO DEL DIA   										*/
/****************************************************************/
UPDATE #TMP_RESULTADO_FWD
SET
	IMP_IE_MO  = T1.ACUM_DIA
	,IMP_IE_ML = T1.ACUM_DIA
FROM
		  #TMP_RESULTADO_FWD T2
LEFT JOIN (
SELECT 
	CUENTA,
	NRO_OPERACION,
	CORRELATIVO,
	DESC_DIVISA,
	ACUM_DIA = SUM(HABER-DEBE)
FROM #TMP_DATOS_FWD
WHERE FECHA_CONTABLE = @FECHA_PROC_FILTRO
GROUP BY CUENTA,NRO_OPERACION,CORRELATIVO,DESC_DIVISA
) AS T1
ON
	T2.COD_CTA_CONT = T1.CUENTA
AND T2.NRO_OPERACION = T1.NRO_OPERACION
AND T2.NRO_CORRELATIVO = T1.CORRELATIVO
AND T2.COD_DIVISA = T1.DESC_DIVISA

UPDATE #TMP_RESULTADO_FWD
SET
	 IMP_IE_MO = 0
	,IMP_IE_ML = 0
	,IMP_SDO_IE_ML = 0
	,IMP_SDO_IE_MO = 0
WHERE
	IMP_IE_MO IS NULL



/****************************************************************/
/*	ACUMULADO DEL MES   										*/
/****************************************************************/
UPDATE #TMP_RESULTADO_FWD
SET
	 IMP_SDO_IE_MO  = T1.ACUM_MES
	,IMP_SDO_IE_ML = T1.ACUM_MES
FROM
		  #TMP_RESULTADO_FWD T2
LEFT JOIN (
SELECT 
	CUENTA,
	NRO_OPERACION,
	CORRELATIVO,
	DESC_DIVISA,
	ACUM_MES = SUM(HABER-DEBE)
FROM #TMP_DATOS_FWD
WHERE FECHA_CONTABLE BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
GROUP BY CUENTA,NRO_OPERACION,CORRELATIVO,DESC_DIVISA
) AS T1
ON
	T2.COD_CTA_CONT = T1.CUENTA
AND T2.NRO_OPERACION = T1.NRO_OPERACION
AND T2.NRO_CORRELATIVO = T1.CORRELATIVO
AND T2.COD_DIVISA = T1.DESC_DIVISA



/**************************************************************************/


-- OTROS (ACTUALIZACION DATOS FALTANTES DESDE LA CARTERA)
UPDATE #TMP_RESULTADO_FWD
SET 
	COD_SUBPRODU = convert(varchar,T1.cacodpos1)
FROM
	#TMP_RESULTADO_FWD
LEFT JOIN 
(
select distinct canumoper,cacodpos1
from Bacfwdsuda.dbo.mfcah with(nolock)
union
select distinct canumoper,cacodpos1
from Bacfwdsuda.dbo.mfcares with(nolock)
where CaFechaProceso between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
) as t1
on nro_operacion = t1.canumoper


update #TMP_RESULTADO_FWD
set 
	COD_SUBPRODU = convert(varchar,t1.cacodestructura)
from 
			#TMP_RESULTADO_FWD t2
left join	(
	select distinct canumcontrato,cacodestructura
	from CbMdbOpc.dbo.CaResEncContrato
	where CaEncFechaRespaldo between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
	and CaCodEstructura in (13,4,5,6,8)
) as t1
on t1.canumcontrato = t2.NRO_OPERACION
where COD_SUBPRODU is null


-- LIMPIEZA

DELETE FROM #TMP_RESULTADO_FWD
WHERE 
	IMP_IE_MO = 0
AND	IMP_SDO_IE_MO  = 0


DELETE FROM #TMP_RESULTADO_FWD
WHERE LTRIM(RTRIM(COD_CTA_CONT)) NOT IN (
SELECT DISTINCT LTRIM(RTRIM(CUENTA)) FROM Reportes.dbo.RNT_INT_MTX_CONTABLE
where INTERFAZ = 'RESULTADO'
)

SELECT 
 NRO_OPERACION		
,NRO_DOCUMENTO		
,NRO_CORRELATIVO	
,COD_CTA_CONT		
,TIP_IE				
,COD_DIVISA			
,FEC_DATA			
,COD_ENTIDAD		
,COD_PRODUCTO		
,COD_SUBPRODU		
,IMP_IE_MO			
,IMP_IE_ML			
,COD_CENTRO_CONT	
,IMP_SDO_IE_MO		
,IMP_SDO_IE_ML		
,T_FLUJO			
FROM #TMP_RESULTADO_FWD


/* VALIDACION DE CUENTAS*/
/*
SELECT  
 COD_CTA_CONT
,SUM(IMP_IE_MO)		[RESULTADO DIA]
,SUM(IMP_SDO_IE_MO) [RESULTADO ACUM. MES]
FROM #TMP_RESULTADO_FWD
GROUP BY COD_CTA_CONT
ORDER BY COD_CTA_CONT
*/

DROP TABLE #TMP_RESULTADO_FWD
DROP TABLE #TMP_DATOS_FWD
END
GO

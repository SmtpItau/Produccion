USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_OPERACIONALES_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_RESULTADOS_OPERACIONALES_SWAP '20181031'
CREATE PROCEDURE [dbo].[SP_RESULTADOS_OPERACIONALES_SWAP]
 (
 	@FECHA		 DATE = NULL
  )
 AS
BEGIN
--	SONDA		: RENTABILIDAD
--	DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--	MODIFICACION: 27-06-2018	CAMPOS TASA, IND_CAN_ANT
--	MODIFICACION: 01-10-2018	agregar PSV
--	MODIFICACION: 04-12-2018	modificar filtro tabla temporal

SET NOCOUNT ON 
SET DATEFORMAT YMD

DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE
-- DECLARE @FECHA DATE
-- SET @FECHA = '2017-12-15'

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BacSwapSuda.dbo.SwapGeneral WITH(NOLOCK))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


SELECT DISTINCT numero_operacion,numero_flujo,tipo_flujo
INTO #CARTERA_SWAP
--FROM BacSwapSuda..CARTERARES
FROM BacSwapSuda..CarteraHis
--WHERE Fecha_Proceso BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
WHERE fecha_vence_flujo BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO


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
IF OBJECT_ID('TEMPDB..#TMP_RESULTADO_PCS') IS NOT NULL BEGIN
	DROP TABLE #TMP_RESULTADO_PCS	
END 

IF OBJECT_ID('TEMPDB..#TMP_DATOS_PCS') IS NOT NULL BEGIN
	DROP TABLE #TMP_DATOS_PCS	
END 

CREATE TABLE #TMP_RESULTADO_PCS
(
 NRO_OPERACION			NUMERIC(20)		DEFAULT(0)
,NRO_DOCUMENTO			NUMERIC(20)		DEFAULT(0)
,NRO_CORRELATIVO		NUMERIC(20)		DEFAULT(0)
,COD_CTA_CONT			VARCHAR(20)
,TIP_IE					CHAR(2)
,COD_DIVISA				VARCHAR(4)
,FEC_DATA				DATE			--NUMBER(8)
,COD_ENTIDAD			VARCHAR(4)		DEFAULT('1769')
,COD_PRODUCTO			VARCHAR(4)		DEFAULT('PCS')
,COD_SUBPRODU			VARCHAR(4)
,IMP_IE_MO				NUMERIC(20,4)	DEFAULT(0) 
,IMP_IE_ML				NUMERIC(20,4)	DEFAULT(0)
,COD_CENTRO_CONT		VARCHAR(4)		DEFAULT('2230')
,IMP_SDO_IE_MO			NUMERIC(20,4)	DEFAULT(0)
,IMP_SDO_IE_ML			NUMERIC(20,4)	DEFAULT(0)
,T_FLUJO				NUMERIC
)


/********************************************************************/
/*	VALOR REPRESENTACION CONTABLE									*/
/********************************************************************/
DECLARE @VALOR_TC_CONTABLE TABLE
(
	codigo int,
	valor float,
	nemo varchar(3) null,	
	fecha date
)
INSERT INTO @VALOR_TC_CONTABLE 
SELECT VMCODIGO,VMVALOR,
(case VMCODIGO
	when 994 then 'DO'
	when 995 then 'DA'
	when 997 then 'IVP'
	when 998 then 'UF'
	when 999 then 'CLP'
end)
,vmfecha FROM BACPARAMSUDA.DBO.VALOR_MONEDA 
WHERE 
VMFECHA BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO 
AND VMCODIGO IN(994,995,998,997,999)

INSERT INTO @VALOR_TC_CONTABLE 
SELECT 999,1.0,'CLP',FECHA
FROM @VALOR_TC_CONTABLE WHERE CODIGO=998

INSERT INTO @VALOR_TC_CONTABLE 
SELECT 
	(CASE 
		WHEN CODIGO_MONEDA = 994 THEN 13  
		ELSE CODIGO_MONEDA  
	END) 
	,TIPO_CAMBIO 
	,LTRIM(RTRIM(NEMO_MONEDA))
	,Fecha
FROM BACPARAMSUDA.DBO.VALOR_MONEDA_CONTABLE
WHERE FECHA  between @fecha_ini_filtro and @FECHA_PROC_FILTRO
AND CODIGO_MONEDA NOT IN (13,995,998,997,999)


/********************************************************************/
/*	EXTRACCION DE DATA												*/
/********************************************************************/
SELECT	NRO_OPERACION
,		NRO_DOCUMENTO = NULL
,		CORRELATIVO
,		FECHA_CONTABLE
,		CODIGO_DIVISA
,		DESC_DIVISA
,		TIPO_CAMBIO
,		CUENTA
,		TIPO_CUENTA
,		DEBE = ISNULL([D],0)
,		HABER = ISNULL([H],0)
,		COD_PRODUCTO = 'PCS' 
,		COD_SUBPRODU =  NULL 
,		TIPO_FLUJO
INTO #TMP_DATOS_PCS
FROM
(
SELECT  
 c.numero_operacion																						as nro_operacion
,c.numero_flujo																							as correlativo
,convert(date,vh.fecha_ingreso)																			as fecha_contable
,vd.Moneda																								as codigo_divisa
,mn.nemo																								as desc_divisa
,mn.valor																								as tipo_cambio
,vd.Cuenta																								as cuenta
,pc.tipo_cuenta																							as tipo_cuenta
,(case when mn.codigo = 999 then round(vd.monto,0) else round(vd.monto,4) end)							as monto
,vd.Tipo_Monto																							as tipo_monto
,c.tipo_flujo as tipo_flujo
FROM BACSWAPSUDA.DBO.BAC_CNT_VOUCHER			AS VH WITH(NOLOCK) 
INNER JOIN	BACSWAPSUDA.DBO.BAC_CNT_DETALLE_VOUCHER	AS VD WITH(NOLOCK)	ON VH.NUMERO_VOUCHER = VD.NUMERO_VOUCHER      		
INNER JOIN	BACPARAMSUDA.DBO.PLAN_DE_CUENTA			AS PC WITH(NOLOCK)	ON VD.CUENTA         = PC.CUENTA
INNER JOIN	@VALOR_TC_CONTABLE						AS MN				ON MN.CODIGO		 = VD.MONEDA AND VH.FECHA_INGRESO = MN.FECHA
LEFT  JOIN #CARTERA_SWAP c ON c.numero_operacion=cast(substring((replicate('0',10-len(rtrim(ltrim(convert(varchar(10),Vh.Operacion)))))+rtrim(convert(varchar(10),Vh.Operacion))),1,7) as numeric(9)) AND c.numero_flujo=( select MAX(c1.numero_flujo) from #CARTERA_SWAP c1 where c1.numero_operacion=cast(substring((replicate('0',10-len(rtrim(ltrim(convert(varchar(10),Vh.Operacion)))))+rtrim(convert(varchar(10),Vh.Operacion))),1,7) as numeric(9)))
WHERE VH.FECHA_INGRESO BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
AND PC.CUENTA IN (SELECT CUENTA FROM @CUENTAS_RESULTADO)
) AS T1
PIVOT
(
	SUM(MONTO)
	FOR TIPO_MONTO IN ([D],[H])
) AS PVT
ORDER BY PVT.NRO_OPERACION

DELETE from #TMP_DATOS_PCS where nro_operacion is null

CREATE NONCLUSTERED INDEX IDX_TMP_DATOS_PCS_001 ON #TMP_DATOS_PCS (NRO_OPERACION,FECHA_CONTABLE,TIPO_CUENTA,CUENTA,CODIGO_DIVISA)


UPDATE #TMP_DATOS_PCS
SET 
DEBE = (CASE WHEN ISNULL(DEBE,-1)=-1 THEN 0 ELSE DEBE END)
,HABER = (CASE WHEN ISNULL(HABER,-1)=-1 THEN 0 ELSE HABER END)

/****************************************************************/
/*	BASE REPORTE FINAL  										*/
/****************************************************************/
INSERT INTO #TMP_RESULTADO_PCS
(	NRO_OPERACION
,	NRO_CORRELATIVO
,	COD_CTA_CONT
,	COD_DIVISA
,	FEC_DATA
,	IMP_SDO_IE_MO
,	IMP_SDO_IE_ML
,	IMP_IE_MO
,	IMP_IE_ML		
,	T_FLUJO )
SELECT DISTINCT
	NRO_OPERACION
,	CORRELATIVO
,	CUENTA
,	DESC_DIVISA
,	FEC_DATA							= @FECHA_PROC_FILTRO 
,	IMP_IE_MO							= NULL
,	IMP_IE_ML							= NULL
,	IMP_SDO_IE_MO						= NULL
,	IMP_SDO_IE_ML						= NULL
,	TIPO_FLUJO
FROM #TMP_DATOS_PCS

/****************************************************************/
/*	ACUMULADO DEL DIA   										*/
/****************************************************************/
UPDATE #TMP_RESULTADO_PCS
	SET		IMP_IE_MO  = T1.ACUM_DIA
	,		IMP_IE_ML = T1.ACUM_DIA
FROM	#TMP_RESULTADO_PCS T2
LEFT JOIN ( SELECT CUENTA,NRO_OPERACION,CORRELATIVO,ACUM_DIA = SUM(HABER-DEBE) FROM #TMP_DATOS_PCS WHERE FECHA_CONTABLE = @FECHA_PROC_FILTRO GROUP BY CUENTA,NRO_OPERACION,CORRELATIVO ) AS T1
			ON	T2.COD_CTA_CONT = T1.CUENTA AND T2.NRO_OPERACION = T1.NRO_OPERACION AND T2.NRO_CORRELATIVO = T1.CORRELATIVO

UPDATE #TMP_RESULTADO_PCS
	SET		IMP_IE_MO = 0
	,		IMP_IE_ML = 0
	,		IMP_SDO_IE_ML = 0
	,		IMP_SDO_IE_MO = 0
WHERE	IMP_IE_MO IS NULL

/****************************************************************/
/*	ACUMULADO DEL MES   										*/
/****************************************************************/
UPDATE #TMP_RESULTADO_PCS
	SET		IMP_SDO_IE_MO  = T1.ACUM_MES
	,		IMP_SDO_IE_ML = T1.ACUM_MES
FROM  #TMP_RESULTADO_PCS T2
LEFT JOIN (SELECT CUENTA,NRO_OPERACION,CORRELATIVO,ACUM_MES = SUM(HABER-DEBE) FROM #TMP_DATOS_PCS WHERE FECHA_CONTABLE BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO GROUP BY CUENTA,NRO_OPERACION,CORRELATIVO) AS T1
		ON	T2.COD_CTA_CONT = T1.CUENTA AND T2.NRO_OPERACION = T1.NRO_OPERACION AND T2.NRO_CORRELATIVO = T1.CORRELATIVO

/**************************************************************************/

-- OTROS DATOS (ACTUALIZACION DATOS FALTANTES DESDE LA CARTERA)
UPDATE #TMP_RESULTADO_PCS
	SET COD_SUBPRODU = 	(CASE T1.tipo_swap when 1 then 'ST'	when 2 then 'SM'when 3 then 'FR' when 4 then 'SP' end)	
FROM #TMP_RESULTADO_PCS 
LEFT JOIN (SELECT DISTINCT NUMERO_OPERACION,TIPO_SWAP FROM BACSWAPSUDA.DBO.CARTERARES with(nolock) WHERE FECHA_PROCESO BETWEEN @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO ) AS T1
		ON NRO_OPERACION = T1.numero_operacion


-- LIMPIEZA
DELETE FROM #TMP_RESULTADO_PCS
WHERE	IMP_IE_MO = 0
AND		IMP_SDO_IE_MO  = 0

DELETE FROM #TMP_RESULTADO_PCS
WHERE LTRIM(RTRIM(COD_CTA_CONT)) NOT IN ( SELECT DISTINCT LTRIM(RTRIM(CUENTA)) FROM Reportes.dbo.RNT_INT_MTX_CONTABLE where INTERFAZ = 'RESULTADO')


--UPDATE p
--	set p.NRO_CORRELATIVO   = (SELECT Max(g.numero_flujo) FROM BacSwapSuda..carterares g where g.numero_operacion=p.NRO_OPERACION and c.Fecha_Proceso between @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO and tipo_flujo=1)
--FROM #TMP_RESULTADO_PCS p
--left JOIN BacSwapSuda..carterares c ON c.numero_operacion=p.NRO_OPERACION and c.Fecha_Proceso between @FECHA_INI_FILTRO AND @FECHA_PROC_FILTRO
--WHERE NRO_CORRELATIVO IS NULL


SELECT distinct
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
FROM #TMP_RESULTADO_PCS



/* VALIDACION DE CUENTAS*/
/*
SELECT  
 COD_CTA_CONT
,SUM(IMP_IE_MO)		[ACUMULADO DIA]
,SUM(IMP_SDO_IE_MO) [ACUMULADO MENSUAL]
FROM #TMP_RESULTADO_PCS
GROUP BY COD_CTA_CONT
ORDER BY COD_CTA_CONT
*/

DROP TABLE #TMP_DATOS_PCS
DROP TABLE #TMP_RESULTADO_PCS
END
GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_OPERACIONALES_RF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_RESULTADOS_OPERACIONALES_RF '20181031'
CREATE PROCEDURE [dbo].[SP_RESULTADOS_OPERACIONALES_RF]
(
	@FECHA DATE = NULL
)
AS
BEGIN
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ RESULTADO OPERACIONES
--MODIFICACION	: 27-08-2018 operaciones duplicadas
--MODIFICACION	: 22-10-2018 dejar afuera cartera 159(Garantias)
--MODIFICACION	: 05-12-2018 dejar afuera cartera 121

SET NOCOUNT ON
SET DATEFORMAT YMD
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE

-- DECLARE @FECHA DATE
-- SET @FECHA = '2017-12-15'


IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (select top 1 acfecproc from Bacfwdsuda.dbo.mfac with(nolock))
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END

SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


SELECT	rsnumdocu
,		min(rscorrela) as rscorrela
,		rsnumoper
,		rscartera
,		rstipoper
--,		rsinstser
into #TMP_MDRS
FROM BacTraderSuda..mdrs
WHERE rsfecha between @fecha_ini_filtro and @fecha_proc_filtro
AND rscartera NOT IN (159,121)
group by rsnumdocu,rsnumoper,rscartera,rstipoper--,rsinstser


/*************************************************************/
/* CUENTAS PERTENECIENTES AL ARCHIVO.						 */
/*************************************************************/
DECLARE @CUENTAS_RESULTADO TABLE
(
	CUENTA VARCHAR(20)
)
INSERT INTO @CUENTAS_RESULTADO
SELECT CUENTA FROM REPORTES.DBO.RNT_INT_MTX_CONTABLE
WHERE INTERFAZ = 'RESULTADO'

/*************************************************************/
/* LIMPIEZA Y GENERACION DE TMP'S							 */
/*************************************************************/
IF OBJECT_ID('TEMPDB..#TMP_RESULTADO_BTR') IS NOT NULL BEGIN
	DROP TABLE #TMP_RESULTADO_BTR
END

IF OBJECT_ID('TEMPDB..#TMP_DATOS_BTR') IS NOT NULL BEGIN
	DROP TABLE #TMP_DATOS_BTR
END


CREATE TABLE #TMP_RESULTADO_BTR
(
 NRO_OPERACION			NUMERIC(20)		DEFAULT(0)
,NRO_DOCUMENTO			NUMERIC(20)		DEFAULT(0)
,NRO_CORRELATIVO		NUMERIC(20)		DEFAULT(0)
,COD_CTA_CONT			VARCHAR(20)
,TIP_IE					CHAR(2)
,COD_DIVISA				VARCHAR(4)
,FEC_DATA				DATE --NUMBER(8)
,COD_ENTIDAD			VARCHAR(4)		DEFAULT('1769')
,COD_PRODUCTO			VARCHAR(4)		DEFAULT('BTR')
,COD_SUBPRODU			VARCHAR(4)
,IMP_IE_MO				NUMERIC(20,4)	DEFAULT(0) 
,IMP_IE_ML				NUMERIC(20,4)	DEFAULT(0)
,COD_CENTRO_CONT		VARCHAR(4)		DEFAULT('2230')
,IMP_SDO_IE_MO			NUMERIC(20,4)	DEFAULT(0)
,IMP_SDO_IE_ML			NUMERIC(20,4)	DEFAULT(0)
,T_FLUJO				NUMERIC			DEFAULT(1)
,SERIE_INST				VARCHAR(20)		DEFAULT NULL
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

--UPDATE @VALOR_TC_CONTABLE 
--SET VALOR = 1
--WHERE CODIGO in(998,13)


/********************************************************************/
/*	EXTRACCION DE DATA												*/
/********************************************************************/

 SELECT 
  NRO_OPERACION				
 ,NRO_DOCUMENTO 
 ,CORRELATIVO
 ,SERIE_INST
 ,COD_SUBPRODU				
 ,TIPO_OPERACION
 ,FECHA_CONTABLE
 ,CODIGO_DIVISA
 ,DESC_DIVISA
 ,TIPO_CAMBIO
 ,CUENTA
 ,TIPO_CUENTA
 ,DEBE						= coalesce([D],0) 		
 ,HABER						= coalesce([H],0)  
 INTO #TMP_DATOS_BTR
 from
 (
select 
 nro_operacion				=	vh.Operacion
,nro_documento				=	(select max(rsnumdocu) from #TMP_MDRS where rsnumoper=vh.Operacion ) 
,correlativo				=	(select min(rscorrela) from #TMP_MDRS where rsnumoper=vh.Operacion ) 
,serie_inst					=	vh.instser

,cod_subprodu				=	--vh.Tipo_Operacion		-- para contabilidad agrupada
								-- para contabilidad desagrupada
								case 
									when vh.Tipo_Operacion_Original =  'IB' then vh.codigo_producto					 -- icap/icol				
									when vh.Tipo_Operacion_Original =  'CG' and vh.Tipo_Operacion = 'TMCP' then 'CP' -- cartera en garantia
									else vh.Tipo_Operacion_Original
								end
,fecha_contable				=	convert(date,vh.fecha_ingreso)
,codigo_divisa				=	vd.Moneda
,desc_divisa				=	mn.nemo
,tipo_cambio				=	mn.valor
,cuenta						=	vd.Cuenta
,tipo_cuenta				=	pc.tipo_cuenta
,monto						=	(case when mn.codigo = 999 then round(vd.monto,0) else round(vd.monto,4) end) 
,tipo_monto					=	vd.Tipo_Monto
,tipo_operacion				=	vh.Tipo_Operacion
from		Reportes.dbo.cnt_aux_rentabilidad_rf	as vh with(nolock)
inner join	Reportes.dbo.cnt_aux_det_rentabilidad_rf	as vd with(nolock) on vh.numero_voucher = vd.numero_voucher
-- comentar arriba para deshabilitar la contabilizacion desagrupada.
--				BactraderSuda.dbo.BAC_CNT_VOUCHER as vh with(nolock) 
--inner join	BacTraderSuda.dbo.BAC_CNT_DETALLE_VOUCHER as vd with(nolock) on vh.numero_voucher = vd.numero_voucher
inner join	bacparamsuda.dbo.plan_de_cuenta				as pc with(nolock) on vd.cuenta			= pc.cuenta
inner join  @valor_tc_contable							as mn			   on mn.codigo			= vd.moneda and vh.Fecha_Ingreso = mn.fecha
inner join #TMP_MDRS on rsnumoper=vh.Operacion
where vh.Fecha_Ingreso between @fecha_ini_filtro and @fecha_proc_filtro
and pc.cuenta in (select cuenta from @CUENTAS_RESULTADO)
--	order by vd.Cuenta,vh.Operacion
)AS T1
PIVOT
(
	SUM(MONTO)
	FOR TIPO_MONTO IN ([D],[H])
) AS PVT
ORDER BY PVT.NRO_OPERACION

CREATE NONCLUSTERED INDEX IDX_TMP_DATOS_BTR_001 ON #TMP_DATOS_BTR (NRO_DOCUMENTO,FECHA_CONTABLE,TIPO_CUENTA,CUENTA,CODIGO_DIVISA,TIPO_OPERACION,SERIE_INST)


UPDATE #TMP_DATOS_BTR
SET
DEBE = (CASE WHEN ISNULL(DEBE,-1)=-1 THEN 0 ELSE DEBE END)
,HABER = (CASE WHEN ISNULL(HABER,-1)=-1 THEN 0 ELSE HABER END)

	UPDATE p
		SET p.NRO_OPERACION = vinumoper
	FROM #TMP_DATOS_BTR p
	inner join BacTraderSuda..mdvi on vinumdocu=p.NRO_DOCUMENTO

	UPDATE p
		SET p.correlativo = (select min(cpcorrela) from BacTraderSuda..mdcp where cpnumdocu=NRO_DOCUMENTO and cpnominal>0) 
	FROM #TMP_DATOS_BTR p
	inner join BacTraderSuda..mdcp on cpnumdocu=p.NRO_DOCUMENTO and cpnominal>0

	UPDATE p
		SET p.nro_documento	= (select max(monumdocu) from BacTraderSuda..mdmh where monumoper=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro) 
	,		p.correlativo	= (select min(mocorrela) from BacTraderSuda..mdmh where monumoper=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro) 	
	FROM #TMP_DATOS_BTR p
	inner join BacTraderSuda..mdmh on mofecpro between @fecha_ini_filtro and @fecha_proc_filtro AND monumoper=p.nro_operacion and p.nro_documento is null


	UPDATE p
		SET p.nro_operacion	= (select max(monumoper) from BacTraderSuda..mdmh where monumdocu=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro and motipoper='VP') 
	,		p.correlativo	= (select min(mocorrela) from BacTraderSuda..mdmh where monumdocu=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro and motipoper='VP') 	
	FROM #TMP_DATOS_BTR p
	inner join BacTraderSuda..mdmh on mofecpro between @fecha_ini_filtro and @fecha_proc_filtro AND monumdocu=p.nro_operacion and motipoper='VP'


	UPDATE p
		SET p.nro_documento	= (select max(monumdocu) from BacTraderSuda..mdmh where monumoper=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro and motipopero='VI') 
	,		p.correlativo	= (select min(mocorrela) from BacTraderSuda..mdmh where monumoper=p.nro_operacion and mofecpro between @fecha_ini_filtro and @fecha_proc_filtro and motipopero='VI') 	
	FROM #TMP_DATOS_BTR p
	inner join BacTraderSuda..mdmh on mofecpro between @fecha_ini_filtro and @fecha_proc_filtro AND monumoper=p.nro_operacion and motipopero='VI'


/****************************************************************/
/*	BASE REPORTE FINAL  										*/
/****************************************************************/
INSERT INTO #TMP_RESULTADO_BTR(NRO_OPERACION,NRO_DOCUMENTO,NRO_CORRELATIVO,COD_CTA_CONT,COD_DIVISA,FEC_DATA
,IMP_IE_MO
,IMP_IE_ML
,IMP_SDO_IE_MO
,IMP_SDO_IE_ML
,COD_SUBPRODU
,SERIE_INST)
SELECT DISTINCT
 nro_operacion
,nro_documento
,correlativo
,cuenta
,desc_divisa			= (case when desc_divisa in ('DO','USD','UF') then 'CLP' else desc_divisa end)
,fec_data				= @FECHA_PROC_FILTRO
,IMP_SDO_IE_MO			= null	
,IMP_SDO_IE_ML			= null 	
,IMP_IE_MO				= null					
,IMP_IE_ML				= null
,COD_SUBPRODU
,SERIE_INST
FROM	#TMP_DATOS_BTR


/****************************************************************/
/*	ACUMULADO DEL DIA   										*/
/****************************************************************/
UPDATE #TMP_RESULTADO_BTR
SET
	IMP_IE_MO = T1.ACUM_DIA
	,IMP_IE_ML = T1.ACUM_DIA
FROM
	#TMP_RESULTADO_BTR T2
LEFT JOIN (
SELECT 
NRO_OPERACION
,NRO_DOCUMENTO
,CORRELATIVO
,CUENTA
,DESC_DIVISA			= (CASE WHEN DESC_DIVISA IN ('DO','USD','UF') THEN 'CLP' ELSE DESC_DIVISA END)
,FEC_DATA				= @FECHA_PROC_FILTRO
,ACUM_DIA				= ROUND((SUM(HABER-DEBE)*TIPO_CAMBIO),0)				
,COD_SUBPRODU
,SERIE_INST
FROM	#TMP_DATOS_BTR
WHERE		
		FECHA_CONTABLE = @FECHA_PROC_FILTRO
GROUP BY
	NRO_OPERACION,NRO_DOCUMENTO,CORRELATIVO,CUENTA,DESC_DIVISA,TIPO_CAMBIO
	,COD_SUBPRODU	
	,SERIE_INST
) T1
ON 
	T2.COD_CTA_CONT = T1.CUENTA
AND T2.NRO_OPERACION = T1.NRO_OPERACION
AND T2.NRO_DOCUMENTO = T1.NRO_DOCUMENTO
AND T2.NRO_CORRELATIVO = T1.CORRELATIVO
AND T2.COD_CTA_CONT	 = T1.CUENTA


UPDATE #TMP_RESULTADO_BTR
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
UPDATE #TMP_RESULTADO_BTR
SET
	IMP_SDO_IE_MO = T1.ACUM_MES
	,IMP_SDO_IE_ML = T1.ACUM_MES
FROM
	#TMP_RESULTADO_BTR T2
LEFT JOIN (
SELECT 
NRO_OPERACION
,NRO_DOCUMENTO
,CORRELATIVO
,CUENTA
,DESC_DIVISA			= (CASE WHEN DESC_DIVISA IN ('DO','USD','UF') THEN 'CLP' ELSE DESC_DIVISA END)
,FEC_DATA				= @FECHA_PROC_FILTRO
,ACUM_MES				= ROUND((SUM(HABER-DEBE)*TIPO_CAMBIO),0)				
,COD_SUBPRODU
,SERIE_INST
FROM	#TMP_DATOS_BTR
WHERE		
		FECHA_CONTABLE BETWEEN @FECHA_INI_FILTRO  AND @FECHA_PROC_FILTRO 
GROUP BY
	NRO_OPERACION,NRO_DOCUMENTO,CORRELATIVO,CUENTA,DESC_DIVISA,TIPO_CAMBIO
	,COD_SUBPRODU	
	,SERIE_INST
) T1
ON 
	T2.COD_CTA_CONT = T1.CUENTA
AND T2.NRO_OPERACION = T1.NRO_OPERACION
AND T2.NRO_DOCUMENTO = T1.NRO_DOCUMENTO
AND T2.NRO_CORRELATIVO = T1.CORRELATIVO
AND T2.COD_CTA_CONT	 = T1.CUENTA



/**************************************************************************/
/* para version con contabilizacion agrupada */
/**************************************************************************/
/*
update #TMP_RESULTADO_BTR
set COD_SUBPRODU = 
	case cod_subprodu		
		when 'TMCP' then 'CP'		--tasa mercado
		when 'DICO' then 'ICOL'		--devengo interfanfarrio colocacion
		when 'DICA' then 'ICAP'	    --devengo interfanfarrio captacion
		when 'RVPM' then 'VP'
		when 'RCPM' then 'CP'
		when 'DVCP' then 'CP'
		when 'DVCI' then 'CI'
		when 'DVVI' then 'VI'		
		
		--- REVISAR...
		when 'GLIQ' then 'CP'
		when 'REVO' then 'CP'
		when 'GNPV' then 'CP'
		when 'VICO' then 'VI'
		WHEN 'RV'	then 'VP'
		when 'RC'	then 'CP'
		else cod_subprodu --'N#A'
end	
*/
-- LIMPIEZA
DELETE FROM #TMP_RESULTADO_BTR
WHERE (IMP_IE_MO = 0.0 AND IMP_SDO_IE_MO  = 0.0)
or (IMP_IE_MO = 0.0 AND IMP_SDO_IE_MO  is null)
or (IMP_IE_MO is null AND IMP_SDO_IE_MO  is null)

DELETE FROM #TMP_RESULTADO_BTR
WHERE LTRIM(RTRIM(COD_CTA_CONT)) NOT IN (
SELECT DISTINCT LTRIM(RTRIM(CUENTA)) FROM Reportes.dbo.RNT_INT_MTX_CONTABLE
where INTERFAZ = 'RESULTADO'
)


/**************************************************************************/
/*			DESPLIEGUE DE RESULTADOS									  */
/**************************************************************************/
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
from #TMP_RESULTADO_BTR



/* VALIDACION DE CUENTAS*/
/*
SELECT  
 COD_CTA_CONT
,SUM(IMP_IE_MO)		[ACUMULADO DIA]
,SUM(IMP_SDO_IE_MO) [ACUMULADO MENSUAL]
FROM #TMP_RESULTADO_BTR
GROUP BY COD_CTA_CONT
ORDER BY COD_CTA_CONT
*/





DROP TABLE #TMP_DATOS_BTR
DROP TABLE #TMP_RESULTADO_BTR

END
GO

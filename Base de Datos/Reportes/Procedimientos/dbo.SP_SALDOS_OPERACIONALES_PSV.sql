USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_PSV]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_SALDOS_OPERACIONALES_PSV '20190401'
CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_PSV]
(
		@FECHA	DATE=NULL
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES PASIVO
	RSILVA
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDOS OPERACIONES PSV
--MODIFICACION	: 27-06-2018	
--MODIFICACION	: 01-10-2018	
--MODIFICACION	: 17-01-2019
--MODIFICACION	: 17-01-2019
--MODIFICACION	: 13-05-2019 SE REVISO CUADRATURA

SET NOCOUNT ON
SET DATEFORMAT YMD

declare @fecha_proceso date

set @fecha_proceso=@FECHA
	
IF @fecha_proceso IS NULL BEGIN		 
    SET @fecha_proceso = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
END		

   	DECLARE   @fecha_proximo_proceso		 DATETIME
	,         @registros			         NUMERIC(06)
	,         @contador						 NUMERIC(06)
	,         @registros_d					 NUMERIC(06)
	,         @contador_d					 NUMERIC(06)
	,         @numero_operacion				 NUMERIC(10)
	,         @numero_correlativo			 NUMERIC(10)
	,         @Cuenta						 CHAR(20)
	,         @Indica_D_H					 CHAR(01)
	,         @Monto_Mda_Origen			     NUMERIC(19,4)
	,         @Monto_Mda_Pesos				 NUMERIC(19,4)
	,         @tipo_operacion				 CHAR(10)
	,         @tipo_movimiento				 CHAR(05)
	,         @mda_emision					 NUMERIC(03)
	,         @folio_perfil					 NUMERIC(09)
	,         @codigo_campo					 NUMERIC(09)
	,         @correlativo_perfil			 NUMERIC(09)
	,         @valor_UF						 NUMERIC(19,4)
	,         @valor_USD		             NUMERIC(19,4)
	,         @Cod_Moneda_Cta				 CHAR(01)
	,         @VALOR_EMISION_PESOS			 NUMERIC(19,4)
	,         @INTERES_EMISION				 NUMERIC(19,4)
	,         @REAJUSTE_EMISION				 NUMERIC(19,4)
	,         @DESCUENTO		             NUMERIC(19,4)
	,         @Fech							 DATETIME


	CREATE TABLE #TMP_RESULTADO_PSV
	(   NRO_OPERACION		NUMERIC(9)
	,   NRO_DOCUMENTO		NUMERIC(9)
	,   NRO_CORRELATIVO		NUMERIC(4)
	,   COD_CTA_CONT		VARCHAR(20)
	,	TIP_SDO				VARCHAR(03)
	,   COD_EST_SDO			NUMERIC(4)
	,   COD_DIVISA			VARCHAR(10)
	,   FEC_DATA			DATETIME
	,   CLS_SDO				VARCHAR(01)
	,   COD_ENTIDAD			VARCHAR(04)
	,   COD_PRODUCTO		VARCHAR(04)
	,   COD_SUBPRODU		VARCHAR(04)
	,   IMP_SDO_CONT_MO		NUMERIC(19,4)
	,   IMP_SDO_CONT_ML		NUMERIC(19,2)
	,   COD_CENTRO_CONT		VARCHAR(04)
	,   T_FLUJO				NUMERIC(01)
	,	ccy					CHAR(2)
	)

	DECLARE @nValorDolarDia		FLOAT
		SET @nValorDolarDia		= (	SELECT	TOP 1 vmptacmp 
									FROM	BACPARAMSUDA..VALOR_MONEDA 
									WHERE	vmfecha		= @fecha_proceso 
									and		vmcodigo	= 994
									and		vmvalor		<> 0
									)
  
	SET @Fech = @fecha_proceso



	IF (SELECT Fecha_Proceso FROM MDPasivo..VIEW_DATOS_GENERALES) = @fecha_proceso 
	BEGIN 
		SELECT   @fecha_proximo_proceso  =  Fecha_Proxima
		FROM     MDPasivo..VIEW_DATOS_GENERALES

--************************************************************************************************************
--************************************************************************************************************
--********************************************** B O N O S ***************************************************
--************************************************************************************************************
--************************************************************************************************************
		INSERT INTO #TMP_RESULTADO_PSV
		SELECT	DISTINCT
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech 
		,	isnull(T2.COD_CLS_SALDO,'') 
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN h. valor_emision_um --D.valor_colocacion_um
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((h.interes_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END),4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((h.reajuste_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END),4) 
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN h.valor_emision_pesos -- D.valor_colocacion	
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN h.interes_emision--(D.interes_acum_colocacion + D.interesdiacolocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN h.reajuste_emision --(D.reajuste_acum_colocacion + D.reajustediacolocacion) 
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
--FROM MDPasivo..RESULTADO_PASIVO	D
--INNER JOIN MDPasivo..CARTERA_PASIVO	H ON H.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
--INNER join MDPARPASIVO..PERFIL_CNT A on a.tipo_movimiento IN ('ING','DEV')
--INNER JOIN MDPARPASIVO..PERFIL_DETALLE_CNT	B ON B.folio_perfil=A.folio_perfil 
--INNER JOIN MDPARPASIVO..PERFIL_VARIABLE_CNT F ON F.folio_perfil=A.folio_perfil AND F.correlativo_perfil=B.correlativo_perfil AND B.perfil_fijo='N'
--INNER JOIN MDPARPASIVO..CAMPO_CNT C ON C.id_sistema=A.id_sistema AND C.tipo_movimiento=A.tipo_movimiento AND C.tipo_operacion=A.tipo_operacion AND C.codigo_campo=B.codigo_campo
--INNER JOIN REPORTES.DBO.RNT_INT_MTX_CONTABLE T2 ON CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END)
--INNER JOIN (SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = '20190401' union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = '20190401' and vmcodigo = 994)	I ON I.vmfecha= '20190401' AND I.vmcodigo= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
--INNER JOIN Bacfwdsuda..VIEW_MONEDA	ON mncodmon=D.moneda_emision
	FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B 
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT F 
		,	MDPasivo..SERIE_PASIVO				G
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994) I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND B.codigo_campo		= C.codigo_campo
		AND c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @fecha_proceso --fmo
		AND	G.nombre_serie		= D.nombre_serie
		AND	LTRIM(RTRIM(G.bono_subordinado))+'-'+LTRIM(RTRIM(G.Tipo_Bono))	= F.valor_dato_campo
		AND H.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		= @fecha_proceso
	  	AND D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision

--************************************************************************************************************
--************************************************************************************************************
--********************************************* C O R F O S **************************************************
--************************************************************************************************************
--************************************************************************************************************
		INSERT INTO #TMP_RESULTADO_PSV
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech 
		,	isnull(T2.COD_CLS_SALDO,'')
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN h.valor_emision_um --D.valor_emision_um 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((h.interes_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END),4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((h.reajuste_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END),4)
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN h.valor_emision_pesos --D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN h.interes_emision --(D.interes_acumulado + D.interesdiaemision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN h.reajuste_emision --D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT F
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994)I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15)
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @fecha_proceso --fmo
--		AND	D.fecha_calculo		= @fecha_proceso
		AND h.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		=  @fecha_proceso
	 	AND   D.tipo_operacion = 'DEV'
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision
		UNION
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech 
		,	isnull(T2.COD_CLS_SALDO,'') 
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta ='H' THEN h.valor_emision_um --D.valor_emision_um 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta ='H' THEN ROUND((h.interes_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END) ,4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta ='H' THEN ROUND((h.reajuste_emision)/(CASE WHEN d.moneda_emision = 999 THEN 1 ELSE i.vmvalor END),4)
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta ='H' THEN h.valor_emision_pesos --D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta ='H' THEN h.interes_emision--(D.interes_acumulado + D.interesdiaemision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta ='H' THEN h.reajuste_emision--D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994) I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15) 
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @fecha_proceso --fmo
		AND h.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		=  @fecha_proceso
		AND 	D.tipo_operacion = 'DEV'
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision
	END
	ELSE BEGIN 

		DECLARE @fechaCartera DATETIME
		
		SELECT   @fecha_proximo_proceso  =  Fecha_Proxima, @fechaCartera =Fecha_Proceso
		FROM     MDPasivo..VIEW_DATOS_GENERALES_HISTORICA		
		WHERE    Fecha_Proceso = @fecha_proceso

		INSERT INTO #TMP_RESULTADO_PSV
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech 
		,	isnull(T2.COD_CLS_SALDO,'') 
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_um
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.interes_colocacion) / (CASE WHEN H.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.reajuste_colocacion) / (CASE WHEN H.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4) 
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN  H.valor_colocacion_clp	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(H.valor_colocacion_clp * @nValorDolarDia, 0) ELSE H.valor_colocacion_clp END --> H.valor_colocacion_clp 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B 
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT 	F 
		,	MDPasivo..SERIE_PASIVO				G
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994)	I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @fecha_proceso --fmo
--		AND	D.fecha_calculo		= @fecha_proceso
		AND	G.nombre_serie		= D.nombre_serie
		AND	LTRIM(RTRIM(G.bono_subordinado))+'-'+LTRIM(RTRIM(G.Tipo_Bono))	= F.valor_dato_campo
		AND h.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		= @fecha_proceso
	  	AND 	D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
		AND	H.fecha_cartera = @fechaCartera --@fecha_proceso
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision
		UNION   
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech
		,	isnull(T2.COD_CLS_SALDO,'')
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_um
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.interes_colocacion) / (CASE WHEN H.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.reajuste_colocacion) / (CASE WHEN H.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4) 
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(H.valor_colocacion_clp * @nValorDolarDia, 0) ELSE H.valor_colocacion_clp END --> H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		,	MDPasivo..SERIE_PASIVO				G
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994) I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @fecha_proceso --fmo
--		AND	D.fecha_calculo		= @fecha_proceso
		AND	G.nombre_serie		= D.nombre_serie
		AND h.numero_operacion=d.numero_operacion and h.numero_correlativo=d.numero_correlativo
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		=  @fecha_proceso
	 	AND 	D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
		AND	H.fecha_cartera = @fechaCartera --@fecha_proceso
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision

		INSERT INTO #TMP_RESULTADO_PSV
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
 		,	1
		,	mnnemo
		,	@Fech
		,	isnull(T2.COD_CLS_SALDO,'')
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_um 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.interes_emision )/(CASE WHEN D.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.reajuste_emision)/(CASE WHEN D.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4)
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT 	F
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994) I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15)
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @fecha_proceso --fmo
--		AND	D.fecha_calculo		= @fecha_proceso
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		=  @fecha_proceso
	 	AND   	D.tipo_operacion 	= 'DEV'
		AND	H.fecha_cartera = @fechaCartera -- @fecha_proceso
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision
		UNION
		SELECT	
			D.numero_operacion
		,	0
		,	D.numero_correlativo
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	T2.COD_T_SALDO
		,	1
		,	mnnemo
		,	@Fech 
		,	isnull(T2.COD_CLS_SALDO,'') 
		,	'1769'
		,	'PSV'
		,   D.codigo_instrumento
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_um 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.interes_emision)/(CASE WHEN D.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND((H.reajuste_emision)/(CASE WHEN D.moneda_emision = 999 THEN 1 ELSE I.vmvalor END),4)
			     ELSE 0.0
			END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'2230'
		,	1
		,	ccy = CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		,	(SELECT vmfecha, vmcodigo, vmvalor	from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso union SELECT vmfecha, 13, 1.0 from BACPARAMSUDA..VALOR_MONEDA where vmfecha = @fecha_proceso and vmcodigo = 994)	I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,	REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
		,	Bacfwdsuda..VIEW_MONEDA	
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15) 
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @fecha_proceso --fmo
--		AND	D.fecha_calculo		= @fecha_proceso
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		=  @fecha_proceso
		AND 	D.tipo_operacion 	= 'DEV'
		AND	H.fecha_cartera =@fechaCartera -- @fecha_proceso
		and CONVERT(NUMERIC,T2.CUENTA) = (CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END)
		AND mncodmon=D.moneda_emision
	END

	UPDATE	#TMP_RESULTADO_PSV 
	SET		IMP_SDO_CONT_ML		= IMP_SDO_CONT_ML * @nValorDolarDia
	WHERE	ccy			= '11'


-- SALIDA 
SELECT 
/*1*/ NRO_OPERACION		
/*2*/,NRO_DOCUMENTO		
/*3*/,NRO_CORRELATIVO	
/*4*/,COD_CTA_CONT       
/*5*/,TIP_SDO            
/*6*/,COD_EST_SDO        
/*7*/,COD_DIVISA         
/*8*/,FEC_DATA           
/*9*/,CLS_SDO            
/*10*/,COD_ENTIDAD        
/*11*/,COD_PRODUCTO       
/*12*/,COD_SUBPRODU       
/*13*/,IMP_SDO_CONT_MO    
/*14*/,IMP_SDO_CONT_ML    
/*15*/,COD_CENTRO_CONT    
/*16*/,T_FLUJO			
FROM #TMP_RESULTADO_PSV
WHERE	IMP_SDO_CONT_MO <> 0
ORDER BY NRO_OPERACION

DROP TABLE #TMP_RESULTADO_PSV

END
GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[BO50]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BO50] (	@dFechaProceso DATETIME	)
AS 
BEGIN

--declare @dFechaProceso DATETIME
--set @dFechaProceso ='20220329'

	SET NOCOUNT ON
	

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
	,         @Dia							 INT
	,		  @CntReg						 INT
	,		  @actg_evnt_cod				 VARCHAR(3)


	CREATE TABLE #INT_SALIDA ( REG_SALIDA	 VARCHAR(178) 	,	ORDEN		 INT 	  )

	CREATE TABLE #INTERFAZ_SIGIR
	(	ctry				CHAR(03)
	,   intf_dt				varchar(08)
	,   src_id				CHAR(14)
	,   cem					CHAR(03)
	,   prod		        CHAR(16)
	,   con_no				CHAR(20)
	,   book_dt				char(08)
	,   ain					CHAR(20)
	,   dr_cr_ind			CHAR(01)
	,   actg_evnt_cod		CHAR(03)
	,   ocy_bal_sign		CHAR(01)
	,   ocy_bal				NUMERIC(19,4)
	,   lcy_bal_sign		CHAR(01)
	,   lcy_bal				NUMERIC(19,2)
	,   lcy_agg_bal_sign	CHAR(01)
	,   lcy_agg_bal			NUMERIC(19,2)
	,   br					CHAR(04)
	,   cc					CHAR(10)
	,   tipo_evento			CHAR(03)
	,	ccy					CHAR(2)
	,   valor_moneda        NUMERIC(19,4)
	,   reajustable         Char(1)
	)

	DECLARE @nValorDolarDia		FLOAT
		SET @nValorDolarDia		= (	SELECT	TOP 1 vmvalor 
									FROM	MdParPasivo.dbo.Valor_Moneda 

									WHERE	vmfecha		= @dFechaProceso 
									and		vmcodigo	= 994
									and		vmvalor		<> 0
									)
  
	SET @Fech = @dFechaProceso
 	SET @Dia  = DATEPART(dw,@dFechaProceso)	

	select vmcodigo, vmvalor, vmfecha 
	  into #Valor_MOneda
	from MDPasivo..VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso

	insert into #Valor_MOneda
		select 999, 1.0, @dFechaProceso
		union
		select 13, vmvalor, vmfecha from #VALOR_MONEDA where vmcodigo = 994

	--+ JPL
	IF (SELECT Fecha_Proceso FROM MDPasivo..VIEW_DATOS_GENERALES) = @dFechaProceso 
	BEGIN 
		SELECT   @fecha_proximo_proceso  =  Fecha_Proxima
		FROM      MDPasivo..VIEW_DATOS_GENERALES


--************************************************************************************************************
--************************************************************************************************************
--********************************************** B O N O S ***************************************************
--************************************************************************************************************
--************************************************************************************************************
		INSERT INTO #INTERFAZ_SIGIR
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.interes_acum_colocacion + D.interesdiacolocacion) ,4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.reajuste_acum_colocacion + D.reajustediacolocacion) ,4) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(D.valor_colocacion * @nValorDolarDia, 0) ELSE D.valor_colocacion END 
--> D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acum_colocacion + D.interesdiacolocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.reajuste_acum_colocacion + D.reajustediacolocacion) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acum_colocacion + D.interesdiacolocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.reajuste_acum_colocacion + D.reajustediacolocacion) 
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 
	FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B 
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT F 
		,	MDPasivo..SERIE_PASIVO				G
		,	#Valor_MOneda			I
/*		,	(SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)							I */
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND B.codigo_campo		= C.codigo_campo
		AND c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @dFechaProceso
		AND	G.nombre_serie		= D.nombre_serie
		AND	LTRIM(RTRIM(G.bono_subordinado))+'-'+LTRIM(RTRIM(G.Tipo_Bono))	= F.valor_dato_campo
		AND	D.numero_operacion	= H.numero_operacion
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END
		AND	I.vmfecha		= @dFechaProceso
	  	AND D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
			UNION   
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.interes_acum_colocacion + D.interesdiacolocacion) ,4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.reajuste_acum_colocacion + D.reajustediacolocacion),4)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(D.valor_colocacion * @nValorDolarDia, 0) ELSE D.valor_colocacion END 
--> D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acum_colocacion + D.interesdiacolocacion)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.reajuste_acum_colocacion + D.reajustediacolocacion)
			     ELSE 0.0
			END
		,
	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_colocacion
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acum_colocacion + D.interesdiacolocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.reajuste_acum_colocacion + D.reajustediacolocacion)
			     ELSE 0.0

			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 
		FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		
		,	MDPasivo..CARTERA_PASIVO				H
		,	MDPasivo..SERIE_PASIVO				G
		,	#Valor_MOneda			I
/*        ,  (SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)							I	*/					
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @dFechaProceso
		AND	G.nombre_serie		= D.nombre_serie
		AND	D.numero_operacion	= H.numero_operacion
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
	 	AND 	D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
	  	
	  	


--************************************************************************************************************
--************************************************************************************************************
--********************************************* C O R F O S **************************************************
--************************************************************************************************************
--************************************************************************************************************
	
		INSERT INTO #INTERFAZ_SIGIR
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD'
 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 					
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_emision 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.interes_acumulado + D.interesdiaemision ) ,4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.reajuste_acumulado + D.reajustediaemision) ,4)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acumulado + D.interesdiaemision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acumulado + D.interesdiaemision)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304  
		FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT F
		,	#VALOR_MONEDA			I
  /*      ,  (SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)						I		*/				
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15)
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @dFechaProceso
		AND	D.numero_operacion	= H.numero_operacion
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
	 	AND   D.tipo_operacion = 'DEV'
		UNION
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta = 'H' THEN D.valor_emision 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.interes_acumulado + D.interesdiaemision)  ,4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (D.reajuste_acumulado + D.reajustediaemision) ,4)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta ='H' THEN D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acumulado + D.interesdiaemision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta ='H' THEN D.valor_emision
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (D.interes_acumulado + D.interesdiaemision)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN D.reajuste_acumulado + D.reajustediaemision
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 

		FROM 	MDPARPASIVO..PERFIL_CNT		A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT	B
		, 	MDPARPASIVO..CAMPO_CNT		C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO				H
		,	#Valor_MOneda			I
/*        ,  (SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)						I			*/			
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15) 
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @dFechaProceso
		AND	D.numero_operacion	= H.numero_operacion
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
		AND 	D.tipo_operacion = 'DEV'
		
	END
	ELSE BEGIN 

		DECLARE @fechaCartera DATETIME
		
		SELECT   @fecha_proximo_proceso  =  Fecha_Proxima, @fechaCartera =Fecha_Proceso
		FROM     MDPasivo..VIEW_DATOS_GENERALES_HISTORICA		
		WHERE    Fecha_Proceso = @dFechaProceso

		INSERT INTO #INTERFAZ_SIGIR
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.interes_colocacion) ,4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.reajuste_colocacion) ,4) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN  H.valor_colocacion_clp	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(H.valor_colocacion_clp * @nValorDolarDia, 0) ELSE H.valor_colocacion_clp END --> H.valor_colocacion_clp 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B 
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT 	F 
		,	MDPasivo..SERIE_PASIVO				G
		,	#Valor_MOneda			I
    /*    ,  (SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)						I */						
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @dFechaProceso
		AND	G.nombre_serie		= D.nombre_serie
		AND	LTRIM(RTRIM(G.bono_subordinado))+'-'+LTRIM(RTRIM(G.Tipo_Bono))	= F.valor_dato_campo
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		= @dFechaProceso
	  	AND 	D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
		AND	H.fecha_cartera = @fechaCartera --@dFechaProceso
		UNION   
		SELECT 	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.interes_colocacion) ,4) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.reajuste_colocacion) ,4) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp	-->	CASE WHEN D.moneda_emision = 13 THEN ROUND(H.valor_colocacion_clp * @nValorDolarDia, 0) ELSE H.valor_colocacion_clp END --> H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_colocacion_clp
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_colocacion) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_colocacion) 
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 
		FROM 	MDPARPASIVO..PERFIL_CNT			A

		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		,	MDPasivo..SERIE_PASIVO				G
		,	#Valor_MOneda			I
  /*      ,  (SELECT vmfecha, vmcodigo, VmValor = case when vmcodigo in( 994, 998 ) then  vmvalor else 1.0 end	from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
				union
			 SELECT vmfecha, 13, 1.0			from VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso and vmcodigo = 994
			)						I	*/					
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')

		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	= 15
		AND	J.codigo_contable	= A.tipo_operacion
		AND	D.fecha_proxima		= @dFechaProceso
		AND	G.nombre_serie		= D.nombre_serie
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
	 	AND 	D.tipo_operacion = 'DEV'
	  	AND	D.nombre_serie NOT LIKE ('%GAST%')
		AND	H.fecha_cartera = @fechaCartera --@dFechaProceso

		INSERT INTO #INTERFAZ_SIGIR
		SELECT distinct	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
 		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112)) 
		,	CASE WHEN B.perfil_fijo = 'N' THEN F.codigo_cuenta ELSE B.codigo_cuenta END
		,	(CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END)
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.interes_emision ) ,4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.reajuste_emision) ,4)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304 
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		, 	MDPARPASIVO..PERFIL_VARIABLE_CNT 	F
		,	#Valor_MOneda			I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND	F.folio_perfil		= B.folio_perfil 
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND 	B.codigo_campo		= C.codigo_campo
		AND 	c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15)
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @dFechaProceso
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.correlativo_perfil	= F.correlativo_perfil

		AND	I.vmcodigo		= D.Moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
	 	AND   	D.tipo_operacion 	= 'DEV'
		AND	H.fecha_cartera = @fechaCartera -- @dFechaProceso
		UNION
		SELECT	'CL'
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	'BOC3'
		,	'001'
		,	CASE    WHEN  D.codigo_instrumento = 15  	THEN 'BONSUB' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 998	THEN 'B11_UF' 
						  WHEN D.codigo_instrumento = 111 AND D.moneda_emision = 994 	THEN 'B11_USD' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 998	THEN 'B14_UF' 
						  WHEN D.codigo_instrumento = 135 AND D.moneda_emision = 994 	THEN 'B14_USD' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 998	THEN 'B15_UF' 
						  WHEN D.codigo_instrumento = 134 AND D.moneda_emision = 994 	THEN 'B15_USD' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 998	THEN 'B41_UF' 
						  WHEN D.codigo_instrumento = 110 AND D.moneda_emision = 994 	THEN 'B41_USD' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 998	THEN 'PRE_UF' 
						  WHEN D.codigo_instrumento = 117 AND D.moneda_emision = 994 	THEN 'PRE_USD' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 998	THEN 'FOG_UF' 
						  WHEN D.codigo_instrumento = 137 AND D.moneda_emision = 994 	THEN 'FOG_USD' 
						  ELSE 'N/A'
			END
		,	LTRIM(RTRIM(STR(D.numero_operacion)))+LTRIM(RTRIM(STR(D.numero_correlativo)))
		,	LTRIM(CONVERT(CHAR(08),@Fech,112))  
		,	CASE WHEN B.perfil_fijo = 'N' THEN B.codigo_cuenta ELSE B.codigo_cuenta END
		,	CASE WHEN B.tipo_movimiento_cuenta ='H' THEN 'C' ELSE 'D' END
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' THEN '000'
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' THEN '002'
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' THEN '001'
			     ELSE '000'
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos 
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.interes_emision ),4)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN ROUND( (H.reajuste_emision),4)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	  AND A.tipo_movimiento = 'ING' AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision) 
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'+'
		,	CASE WHEN nombre_campo_tabla = 'valor_compra'	AND A.tipo_movimiento = 'ING'   AND B.tipo_movimiento_cuenta = 'H' THEN H.valor_emision_pesos
			     WHEN nombre_campo_tabla = 'interes_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.interes_emision)
			     WHEN nombre_campo_tabla = 'reajuste_papel'	AND A.tipo_movimiento = 'DEV' AND B.tipo_movimiento_cuenta = 'H' THEN (H.reajuste_emision)
			     ELSE 0.0
			END
		,	'0011'
		,	replicate ('0',10)
		,	A.tipo_movimiento
		,	ccy = -- CASE WHEN D.moneda_emision = 13 THEN '11' ELSE '00' END 
		          CASE WHEN M.mncodmon IN (999,998,994) THEN '00' ELSE M.mncodfox END   -- MNAVARRO 20190304 
		,   valor_moneda = isnull( I.vmvalor  , 1 )                                     -- MNAVARRO 20190304 
		,   reajustable  = CASE WHEN M.mncodmon IN (998,994) THEN 'S' ELSE 'N' END      -- MNAVARRO 20190304  
		FROM 	MDPARPASIVO..PERFIL_CNT			A
		, 	MDPARPASIVO..PERFIL_DETALLE_CNT		B
		, 	MDPARPASIVO..CAMPO_CNT			C
		,	MDPasivo..RESULTADO_PASIVO			D
		,	MDPasivo..CARTERA_PASIVO_HISTORICA		H
		,	#VALOR_MONEDA			I
		,	MDPasivo..INSTRUMENTO_PASIVO			J
		,   MDParPasivo.dbo.MONEDA      M
		WHERE 	A.folio_perfil		= B.folio_perfil
		AND 	A.tipo_movimiento	IN ('ING','DEV')
		AND	A.moneda_instrumento	= D.moneda_emision
		AND M.mncodmon = D.moneda_emision -- MNAVARRO 20190304
		AND B.codigo_campo		= C.codigo_campo
		AND c.tipo_movimiento	IN ('ING','DEV')
		AND A.tipo_movimiento = c.tipo_movimiento  -- MNAVARRO 20190304
		AND	c.tipo_operacion = A.tipo_operacion    -- MNAVARRO 20190304
		AND	D.Codigo_Instrumento	= J.codigo_instrumento
		AND	D.Codigo_Instrumento	NOT IN (15) 
		AND	J.codigo_contable	= A.codigo_instrumento
		AND	D.fecha_proxima		= @dFechaProceso
		AND	D.numero_operacion	= H.numero_operacion
		AND D.numero_correlativo = H.numero_correlativo
		AND	B.codigo_cuenta		<> 0
		AND	I.vmcodigo		= D.moneda_emision -- CASE WHEN D.moneda_emision = 999 THEN 998 ELSE D.moneda_emision END -- MNAVARRO 20190304
		AND	I.vmfecha		=  @dFechaProceso
		AND D.tipo_operacion 	= 'DEV'
		AND	H.fecha_cartera =@fechaCartera -- @dFechaProceso
	END
--- JPL

	UPDATE #INTERFAZ_SIGIR 
	SET	ocy_bal_sign		= '-' 
	,	lcy_bal_sign		= '-' 
	,	lcy_agg_bal_sign	= '-' 
	WHERE ocy_bal < 0

	UPDATE #INTERFAZ_SIGIR 
	SET	ocy_bal		= ABS(ocy_bal)
	,	lcy_bal		= ABS(lcy_bal)
	,	lcy_agg_bal	= ABS(lcy_agg_bal)

	UPDATE	#INTERFAZ_SIGIR 
	SET		lcy_bal		= lcy_bal * valor_moneda  -- MNAVARRO 20190304 Homologar comporatamiento
	WHERE	-- ccy			= '11'
		reajustable = 'N'                         -- MNAVARRO 20190304 Homologar comporatamiento

	-- MNAVARRO 20190304
	update #INTERFAZ_SIGIR
	   set ccy = case when ccy = '00' then ccy 
	                  when convert( numeric(5), ccy ) <= 9 then '0' + ltrim(rtrim(ccy)) 
	                  when convert( numeric(5), ccy ) between 10 and 99 then ltrim(rtrim(ccy))
					  else substring( ccy, 1, 2 ) end


declare @TipoSalida bit = 0
if @TipoSalida != 0
	SELECT  distinct
				  ctry																																						--		1					
			    , intf_dt																																					--		2	
				, src_id																																					--		3	
				, cem																																						--		4	
				, 'MD01' + SPACE(12)	--prod																																						--		5	
				, left(con_no+space(20), 20) as con_no																																					--		6	
				, book_dt																																					--		7
				, ain																																						--		8	
				, dr_cr_ind																																					--		9	
				, REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod))) as actg_evnt_cod														--		10
				, ocy_bal_sign																																				--		11	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19) as ocy_bal
				, lcy_bal_sign																																				--		13
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19) as lcy_bal
				, lcy_agg_bal_sign																																			--		15
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19) as lcy_agg_bal
				, br																																						--		17
				, cc																																						--		18
				, 0
	FROM #INTERFAZ_SIGIR
		WHERE	ocy_bal <> 0
	 --order by cem, prod, con_no
else
	begin
	INSERT INTO #INT_SALIDA
		select 
				  ctry																																						--		1					
			    + intf_dt																																					--		2	
				+ src_id																																					--		3	
				+ cem																																						--		4	
				+ 'MD01' + SPACE(12)	--prod																																						--		5	
				+ left(con_no+space(20), 20)																																						--		6	
				+ book_dt																																					--		7
				+ ain																																						--		8	
				+ dr_cr_ind																																					--		9	
				+ REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				+ ocy_bal_sign																																				--		11	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				+ lcy_bal_sign																																				--		13
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				+ lcy_agg_bal_sign																																			--		15
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				+ br																																						--		17
				+ cc																																						--		18
				,0
	FROM	#INTERFAZ_SIGIR
	WHERE	ocy_bal <> 0


--	SELECT @CntReg	=(SELECT COUNT(*) FROM #INTERFAZ_SIGIR WHERE ocy_bal <> 0 ) + 1

--	INSERT INTO #INT_SALIDA 
--	SELECT '99' + CONVERT(CHAR(8),@dFechaProceso,112) + RTRIM(REPLICATE('0',10 - LEN (@CntReg))+ CONVERT(CHAR,CONVERT(NUMERIC,@CntReg))) + SPACE(158)
--		,	1
	--SELECT len(REG_SALIDA) FROM #INT_SALIDA  ORDER BY ORDEN 

	SELECT REG_SALIDA FROM #INT_SALIDA ORDER BY ORDEN


	END
	

drop table #INT_SALIDA
drop table #INTERFAZ_SIGIR
drop table #Valor_MOneda
	
END
GO

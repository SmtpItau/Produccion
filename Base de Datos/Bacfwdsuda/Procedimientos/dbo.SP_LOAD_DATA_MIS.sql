USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOAD_DATA_MIS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOAD_DATA_MIS]
	(	@iDiario	INT	= 0	)	--> 0 = Indica Proceso Diario
								--> 1 = Indica Proceso Mensual
								--> 2 = Indica Proceso Agrupado	Resumen
AS
BEGIN

	set nocount on

	declare @dFecha				datetime
		set @dFecha				= CONVERT(DATETIME, CONVERT(CHAR(10), GETDATE(), 112) )
	
	declare	@PrimerDiaMes		datetime
		set @PrimerDiaMes		= DATEADD(DAY, 1, DATEADD(DAY, (DATEPART(DAY, @dFecha ))*-1, @dFecha))

	declare	@UltimoDiaMes		datetime
		set @UltimoDiaMes		= CONVERT(DATETIME, CONVERT(CHAR(10), @dFecha, 112))

	if @iDiario > 0
	begin
		set @PrimerDiaMes		= DATEADD(DAY, 1, DATEADD(DAY, DAY( DATEADD(MONTH, -1, @dFecha ) ) * -1, DATEADD(MONTH, -1, @dFecha )))
		set	@UltimoDiaMes		= DATEADD(DAY, -1, DATEADD(MONTH, 1, @PrimerDiaMes))
	end

	/*
	set @PrimerDiaMes		= '20141021'
	set	@UltimoDiaMes		= '20141021'
	*/

	TRUNCATE TABLE dbo.MIS_CON_BAC_DET

	/***************************************************FORWARD*************************************************/
    /***********************************************************************************************************/

    INSERT	INTO dbo.MIS_CON_BAC_DET

	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.mofecha,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.monumoper))
	,		PRODUCT_ID                  = 'MD10'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = clie.ID		--> LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))  
	,		FULL_NAME                   = clie.FNAME	--> LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'FWD'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.mofecha,	112) 
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.mofecha,	112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.mofecvcto,	112)
	,		FECHA_RENOVACION            = SPACE(0) 
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8),mvto.moFecEfectiva,112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 =  CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'        
												WHEN mon1.mnnemo = 'UF'		THEN '2'        
												ELSE							 '3'        
											END
	,		TIPO_OPERACION              = mvto.motipoper
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN mvto.mocodpos1 = 2  THEN	ISNULL(mvto.moparmon1, 0.0)
												WHEN mvto.mocodpos1 = 14 THEN	ISNULL(mvto.mopremon1, 0.0)
												ELSE							ISNULL(mvto.motipcam,  0.0)
											END
	,		CAP_MONE_ORIGEN             = mvto.momtomon1
	,		CAP_MONE_LOCAL              = mvto.moequmon1
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP' THEN	isnull(mvto.Resultado_Mesa,0)
												WHEN mon1.mnnemo = 'UF'  THEN   isNull(mvto.Resultado_Mesa /mvto.motipcam,0)
												WHEN mon1.mnnemo = 'USD' THEN   CASE	WHEN mvto.mocodpos1 = 14 THEN	isNull(mvto.Resultado_Mesa / mvto.mopremon1,0)
																						ELSE							isNull(mvto.Resultado_Mesa / mvto.motipcam,0)
																					END
												ELSE							isNull((mvto.Resultado_Mesa / vvm.vmvalor) * mvto.moparmon1, 0)
											END
	,		MONTO_UTIL_LOCAL			= CASE	WHEN mvto.mocodpos1 = 2	 THEN	ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)
												ELSE							mvto.Resultado_Mesa
											END
	,		OPERADOR					= mvto.mooperador
--	FROM	BacFwdSuda.dbo.MFMOH		mvto with(nolock)
	FROM	(	select	mofecha,		moestado,	monumoper,	mofecvcto,	moFecEfectiva,	motipoper, mocodpos1
					,	moparmon1,		moparmon2,	mopremon1,	mopremon2,	motipcam,		momtomon1, moequmon1
					,	Resultado_Mesa, mooperador,	mocodigo,	mocodcli,	mocodmon1,		mocodmon2
				from	BacFwdSuda.dbo.MFMOH									with(nolock)
				where	mofecha			between @PrimerDiaMes and @UltimoDiaMes
				and		moestado		<> 'A'
				union
				select	mofecha,		moestado,	monumoper,	mofecvcto,	moFecEfectiva,	motipoper, mocodpos1
					,	moparmon1,		moparmon2,	mopremon1,	mopremon2,	motipcam,		momtomon1, moequmon1
					,	Resultado_Mesa, mooperador,	mocodigo,	mocodcli,	mocodmon1,		mocodmon2
				from	BacFwdSuda.dbo.MFMO										with(nolock)
				where	mofecha			between @PrimerDiaMes and @UltimoDiaMes
				and		moestado		<> 'A'
			)	mvto

			INNER JOIN ( SELECT acfecante, acfecproc, acfecprox
						 FROM	BacFwdSuda.dbo.MFACH							with(nolock)
						)		ctro						ON ctro.acfecproc	= mvto.mofecha

			INNER JOIN ( SELECT id_sistema, Codigo = codigo_producto, descripcion
						 FROM	BacParamSuda.dbo.PRODUCTO						with(nolock)
						 WHERE	id_sistema	= 'BFW'
						)		prod						ON	prod.id_sistema	= 'BFW'
															AND prod.Codigo		= mvto.mocodpos1

			INNER JOIN ( SELECT clrut, clcodigo, cldv, clnombre
							,	ID	  = LTRIM(RTRIM(CONVERT(CHAR(10), Clrut)))+ LTRIM(RTRIM(Cldv))
							,	FNAME = LTRIM(RTRIM(Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(Clnombre))))
						 FROM	BacParamSuda.dbo.CLIENTE						with(nolock)
						)		clie						ON	clie.clrut      = mvto.mocodigo 
															AND clie.clcodigo	= mvto.mocodcli        
			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA							with(nolock)
						)		mon1						ON	mon1.mncodmon	= mvto.mocodmon1

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA							with(nolock)
						)		mon2						ON	mon2.mncodmon	= mvto.mocodmon2

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE			with(nolock)
						)		vcont						ON	vcont.fecha		= mvto.mofecha --> ctro.acfecante  
															AND vcont.codigo_moneda = 994

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.VALOR_MONEDA					with(nolock)
						)		vvm							ON	vvm.vmfecha		= mvto.mofecha 
															AND vvm.vmcodigo	= 998


	/*****************************************ANTICIPOS FORWARD ******************************************************/
	/*****************************************************************************************************************/
    
	SELECT	canumoper, cacodpos1,  catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2      
    ,		camtomon1, catipcam, caparmon1, caequmon1, caequusd1, caequmon2, capremon1, capremon2, capreant, caspread,   camtomon2      
	,		cafecha,   cafecvcto, cafecEfectiva, caestado,  caantici,  caoperador      
	,		precio_spot, caantptosfwd, caantptoscos      
	INTO	#TMP_CARTERA_ANTICIPO_FORWARD
	FROM	BacFwdsuda.dbo.MFCA   unw with(nolock)
	WHERE	unw.cafecvcto BETWEEN @PrimerDiaMes and @UltimoDiaMes
    and		unw.caestado  <> 'A'
    and		unw.caantici   = 'A'

	INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD  
	SELECT  unw.canumoper,	unw.cacodpos1, unw.catipoper, unw.catipmoda, unw.cacodigo,  unw.cacodcli, unw.cacodmon1, unw.cacodmon2  
	,		unw.camtomon1,	unw.catipcam, unw.caparmon1, unw.caequmon1, unw.caequusd1, unw.caequmon2, unw.capremon1, unw.capremon2
	,		unw.capreant,	unw.caspread,  unw.camtomon2  
	,		unw.cafecha,	unw.cafecvcto, unw.cafecEfectiva, unw.caestado,  unw.caantici,  unw.caoperador  
	,		res.precio_spot, caantptosfwd = res.caantptosfwd, caantptoscos=res.caantptoscos
	FROM	BacFwdsuda.dbo.MFCAh  unw with(nolock)  
			inner join BacFwdsuda.dbo.MFCARES res ON res.CaFechaProceso = unw.cafecvcto and res.canumoper = unw.canumoper
	WHERE	unw.cafecvcto	BETWEEN @PrimerDiaMes and @UltimoDiaMes  
	and		unw.caestado	<> 'A'
	and		unw.caantici	= 'A'  
	and		unw.canumoper	NOT IN(SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD) 

	UPDATE	#TMP_CARTERA_ANTICIPO_FORWARD
    SET		caspread			= caspread + mis.MONTO_UTIL_LOCAL
	,		precio_spot			= catipcam
	FROM	dbo.MIS_CON_BAC_DET	  mis
    WHERE	mis.PRODUCT_TYPE_CD	= 'FWD'
    AND		mis.OPERACION		= canumoper

	DELETE
	FROM	dbo.MIS_CON_BAC_DET
	WHERE	OPERACION			IN (SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)
	AND		PRODUCT_TYPE_CD		= 'FWD'

	INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),unw.cafecvcto,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(unw.canumoper))
	,		PRODUCT_ID                  = 'MD10'
	,		ISO_COUNTRY					= 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), cli.clrut)))+ LTRIM(RTRIM(cli.cldv)) 
	,		FULL_NAME                   = LTRIM(RTRIM(cli.clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(cli.clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'FWD' 
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), unw.cafecha,	  112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), unw.cafecvcto, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8),unw.cafecEfectiva,112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mn1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mn1.mnnemo = 'CLP' THEN '1'    
												WHEN mn1.mnnemo = 'UF'	THEN '2'    
												ELSE						 '3'
											END
	,		TIPO_OPERACION              = unw.catipoper
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0' 
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN unw.cacodpos1 = 2  or unw.cacodpos1 = 13	THEN	ISNULL(unw.capremon1, 0.0)                                           -- TASA_TIPO_PARIDAD    
												WHEN unw.cacodpos1 = 14							THEN	unw.precio_spot  + unw.caantptosfwd    
												ELSE													unw.precio_spot  + unw.caantptosfwd    
											END
	,		CAP_MONE_ORIGEN             = unw.camtomon1
	,		CAP_MONE_LOCAL              = unw.caequmon1
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mn1.mnnemo = 'CLP' THEN isnull(unw.caspread,0)
												WHEN mn1.mnnemo = 'UF'	THEN isNull(unw.caspread /unw.catipcam,0)
												WHEN mn1.mnnemo = 'USD' THEN CASE	WHEN unw.cacodpos1 = 14 THEN isNull(unw.caspread / unw.capremon1,0)
																					ELSE						 isNull(unw.caspread / unw.catipcam, 0)
																				END
												ELSE						 isNull((unw.caspread / vvm.vmvalor) * unw.caparmon1, 0)
											END
	,		MONTO_UTIL_LOCAL			= unw.caspread
	,		OPERADOR					= unw.caoperador
	FROM	#TMP_CARTERA_ANTICIPO_FORWARD unw

			INNER JOIN ( SELECT Id_Sistema, codigo = codigo_producto, descripcion
						 FROM	BacParamSuda.dbo.PRODUCTO		with(nolock)
						 WHERE	id_sistema	= 'BFW'
						)		pro			ON	pro.codigo		= unw.cacodpos1
			LEFT  JOIN ( SELECT clrut, clcodigo, cldv, clnombre
						 FROM	BacParamSuda.dbo.CLIENTE		with(nolock)
						)		cli			ON	cli.clrut		= unw.cacodigo
										and cli.clcodigo		= unw.cacodcli
			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA			with(nolock)
						)		mn1			ON	mn1.mncodmon	= unw.cacodmon1

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA			with(nolock)
						)		mn2			ON	mn2.mncodmon	= unw.cacodmon2

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.VALOR_MONEDA	with(nolock)
						)		vvm			ON	vvm.vmfecha		= unw.cafecha 
											AND	vvm.vmcodigo	= 998

	DROP TABLE #TMP_CARTERA_ANTICIPO_FORWARD


   /****************************************************SWAP**********************************************************/        
   /*****************************************************************************************************************/        


	INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.fecha_cierre,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.numero_operacion))
	,		PRODUCT_ID                  = 'MD11'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))+ LTRIM(RTRIM(clie.Cldv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'PCS'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.fecha_cierre, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.fecha_inicio, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.fecha_termino, 112) 
	,		FECHA_RENOVACION            = CONVERT(CHAR(8), mvto.fecha_vence_flujo, 112)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8), mvto.fecha_fijacion_tasa, 112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = 'C' 
	,		PERIODICIDAD_DE_FLUJOS      = LTRIM(RTRIM(mvto.compra_codamo_interes ))
	,		IND_TASA_TRANSFERENCIA      = LTRIM(RTRIM(mvto.compra_codigo_tasa))
	,		NRO_CUOTAS_FLUJO_SWAP       = LTRIM(RTRIM(( mvto.nMaxFlujo )))

	,		TASA_INTERES                = isNull(mvto.compra_valor_tasa,0)
	,		TASA_TIPO_PARIDAD           = isNUll(mvto.compra_valor_tasa,0)
	,		CAP_MONE_ORIGEN             = isNull(mvto.compra_capital,0) 
	,		CAP_MONE_LOCAL              = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isNull(mvto.compra_capital,0)
												WHEN mon1.mnnemo = 'UF'		THEN isnull(mvto.compra_capital * vvm.vmvalor,0)        
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.compra_capital * vmon.Tipo_Cambio,0)             
												ELSE							 isnull(vmc.Tipo_Cambio * mvto.compra_capital,0)
											END

	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isnull(mvto.Res_Mesa_Dist_CLP,0)
												WHEN mon1.mnnemo = 'UF'		THEN isNull(mvto.Res_Mesa_Dist_CLP / vvm.vmvalor,0)
												WHEN mon1.mnnemo = 'COP'	THEN isnull(mvto.Res_Mesa_Dist_CLP / vmon.Tipo_Cambio,0)
											    ELSE							 isNull(mvto.Res_Mesa_Dist_USD,0)
											END
	,		MONTO_UTIL_LOCAL			= mvto.Res_Mesa_Dist_CLP
	,		OPERADOR					= mvto.operador
	FROM(	select	fecha_cierre			= Mvto.fecha_cierre
			,		numero_operacion		= Mvto.numero_operacion
			,		fecha_inicio			= Mvto.fecha_inicio
			,		fecha_termino			= Mvto.fecha_termino
			,		fecha_inicio_flujo		= Mvto.fecha_inicio_flujo
			,		fecha_vence_flujo		= Mvto.fecha_vence_flujo
			,		fecha_fijacion_tasa		= Mvto.fecha_fijacion_tasa
			,		compra_codamo_interes	= Mvto.compra_codamo_interes
			,		compra_codigo_tasa		= Mvto.compra_codigo_tasa
			,		compra_valor_tasa		= Mvto.compra_valor_tasa
			,		compra_capital			= Mvto.compra_capital
			,		compra_moneda			= Mvto.compra_moneda
			,		rut_cliente				= Mvto.rut_cliente
			,		codigo_cliente			= Mvto.codigo_cliente
			,		Res_Mesa_Dist_CLP		= Mvto.Res_Mesa_Dist_CLP
			,		Res_Mesa_Dist_USD		= Mvto.Res_Mesa_Dist_USD
			,		operador				= Mvto.operador
			,		nMaxFlujo				= Grp.nMaxFlujo
			from	BacSwapSuda.dbo.MOVHISTORICO			Mvto	with(nolock)
					inner join (	select	nContrato		= numero_operacion
										,	nFlujo			= Min( numero_flujo )
										,	nMaxFlujo		= Max( numero_flujo )
									from	BacSwapSuda.dbo.MOVHISTORICO with(nolock)
									where	fecha_cierre	BETWEEN @PrimerDiaMes AND @UltimoDiaMes
									and		estado			<> 'C'
									and		tipo_flujo		= 1	
									group 
									by		numero_operacion

								)	Grp		On	Grp.nContrato	= Mvto.numero_operacion
											and	Grp.nFlujo		= Mvto.numero_flujo
			where	Mvto.fecha_cierre		BETWEEN @PrimerDiaMes AND @UltimoDiaMes
			and		Mvto.estado				<> 'C'
			and		Mvto.tipo_flujo			= 1	
					UNION
			select	fecha_cierre			= Mvto.fecha_cierre
			,		numero_operacion		= Mvto.numero_operacion
			,		fecha_inicio			= Mvto.fecha_inicio
			,		fecha_termino			= Mvto.fecha_termino
			,		fecha_inicio_flujo		= Mvto.fecha_inicio_flujo
			,		fecha_vence_flujo		= Mvto.fecha_vence_flujo
			,		fecha_fijacion_tasa		= Mvto.fecha_fijacion_tasa
			,		compra_codamo_interes	= Mvto.compra_codamo_interes
			,		compra_codigo_tasa		= Mvto.compra_codigo_tasa
			,		compra_valor_tasa		= Mvto.compra_valor_tasa
			,		compra_capital			= Mvto.compra_capital
			,		compra_moneda			= Mvto.compra_moneda
			,		rut_cliente				= Mvto.rut_cliente
			,		codigo_cliente			= Mvto.codigo_cliente
			,		Res_Mesa_Dist_CLP		= Mvto.Res_Mesa_Dist_CLP
			,		Res_Mesa_Dist_USD		= Mvto.Res_Mesa_Dist_USD
			,		operador				= Mvto.operador
			,		nMaxFlujo				= Grp.nMaxFlujo
			from	BacSwapSuda.dbo.MOVDIARIO				Mvto	with(nolock)
					inner join (	select	nContrato		= numero_operacion
										,	nFlujo			= Min( numero_flujo )
										,	nMaxFlujo		= Max( numero_flujo )
									from	BacSwapSuda.dbo.MOVDIARIO with(nolock)
									where	fecha_cierre	BETWEEN @PrimerDiaMes AND @UltimoDiaMes
									and		estado			<> 'C'
									and		tipo_flujo		= 1	
									group 
									by		numero_operacion

								)	Grp		On	Grp.nContrato	= Mvto.numero_operacion
											and	Grp.nFlujo		= Mvto.numero_flujo
			where	Mvto.fecha_cierre		BETWEEN @PrimerDiaMes AND @UltimoDiaMes
			and		Mvto.estado				<> 'C'
			and		Mvto.tipo_flujo			= 1	
		)	mvto

			INNER JOIN ( SELECT clrut, clcodigo, cldv, clnombre
						 FROM	BacParamSuda.dbo.CLIENTE					with(nolock)
						)		clie			ON	clie.clrut				= mvto.rut_cliente
												AND clie.clcodigo			= mvto.codigo_cliente

			LEFT  JOIN ( SELECT mncodmon, mnnemo, mnglosa
						 FROM	BacParamSuda.dbo.MONEDA						with(nolock)
						)		mon1			ON	mon1.mncodmon			= mvto.compra_moneda

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 994
						)		vmc				ON	vmc.Fecha				= mvto.fecha_inicio

			LEFT  JOIN ( SELECT vmfecha, vmcodigo, vmvalor
						 FROM	BacParamSuda.dbo.valor_moneda				with(nolock)
						 WHERE	vmcodigo		= 998
						)		vvm				ON	vvm.vmfecha				= mvto.fecha_inicio

			LEFT  JOIN ( SELECT fecha, codigo_moneda, tipo_cambio
						 FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE		with(nolock)
						 WHERE	Codigo_Moneda	= 129
						)		vmon			ON	vmon.Fecha				= mvto.fecha_inicio
	order 
	by		mvto.numero_operacion


        
        
	/**************************************************  SWAP  **********************************************************/  
	/************************************************  ANTICIPOS  *******************************************************/  

	SELECT	DISTINCT 
			MES_CONTABLE                = CONVERT(CHAR(6),his.fecha_vence_flujo,112) --> his.fecha_termino,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(his.numero_operacion))
	,		PRODUCT_ID                  = 'MD11'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Rut)))+ LTRIM(RTRIM(clie.Dv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Nombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Nombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'PCS'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_RENOVACION            = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		FECHA_PROX_CAMBIO_TASA      = CONVERT(CHAR(8), his.fecha_vence_flujo, 112) --> CONVERT(CHAR(8), his.fecha_termino, 112)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3'
											END
	,		TIPO_OPERACION              = 'C'
	,		PERIODICIDAD_DE_FLUJOS      = LTRIM(RTRIM(his.compra_codamo_interes ))
	,		IND_TASA_TRANSFERENCIA      = LTRIM(RTRIM(his.compra_codigo_tasa))
	,		NRO_CUOTAS_FLUJO_SWAP       = LTRIM(RTRIM((	SELECT	MAX(mvth.numero_flujo)
														FROM	BacSwapSuda.dbo.CARTERAHIS mvth
														WHERE	mvth.NUMERO_OPERACION = his.NUMERO_OPERACION)))
	,		TASA_INTERES                = isNull(his.compra_valor_tasa,0)
	,		TASA_TIPO_PARIDAD           = isNUll(his.compra_valor_tasa,0)
	,		CAP_MONE_ORIGEN             = isNull(his.compra_capital,0)
	,		CAP_MONE_LOCAL              = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isNull(his.compra_capital,0)
												WHEN mon1.mnnemo = 'UF'		THEN isnull(his.compra_capital	* vvm.vmvalor,0)
												WHEN mon1.mnnemo = 'COP'	THEN isnull(his.compra_capital	* vmon.Tipo_Cambio,0)
												ELSE							 isnull(vmc.Tipo_Cambio		* his.compra_capital,0)
											END
	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mon1.mnnemo = 'CLP'	THEN isnull(Anticipo.Monto,0)					--> unw.ResMesa
												WHEN mon1.mnnemo = 'UF'		THEN isNull(Anticipo.Monto / vvm.vmvalor,0)		--> unw.ResMesa
												WHEN mon1.mnnemo = 'COP'	THEN isnull(Anticipo.Monto / vmon.Tipo_Cambio,0)--> unw.ResMesa
												ELSE							 isNull(Anticipo.Monto / vmc.Tipo_Cambio,0)	--> unw.ResMesa
											END
	,		MONTO_UTIL_LOCAL			= Anticipo.Monto			--> unw.ResMesa
	,		OPERADOR					= Anticipo.operador			-->	his.operador
	INTO	#TMP_CARTERA_ANTICIPO_SWAP
	from	BacSwapSuda.dbo.Cartera_Unwind	His	with(nolock)
--	from	BacSwapSuda.dbo.CarteraHis		His	with(nolock)
			left join	(	select	numero_operacion, numero_flujo, tipo_flujo, venta_capital, venta_valor_tasa, venta_moneda
						--	from	BacSwapSuda.dbo.CarteraHis		with(nolock)
							from	BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
						)	Venta	On	Venta.numero_operacion = His.numero_operacion
									and	Venta.numero_flujo     = His.numero_flujo
									and	Venta.tipo_flujo       = 2

			inner join (	select		Contrato			= Numero_Operacion
							,			Flujo				= Min( Numero_Flujo )
							,			Tipo				= Tipo_Flujo
							,			Monto				= Min( Devengo_Recibido_Mda_Val )
							,			operador			= Min( operador )
							,			FechaAnticipo		= FechaAnticipo
							from		BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
							where		FechaAnticipo		BETWEEN @PrimerDiaMes AND @UltimoDiaMes
							and			Tipo_Flujo			= 1
							and			Estado				<> ''
							group by	Numero_Operacion, Tipo_Flujo, FechaAnticipo
						)	Anticipo	On	Anticipo.Contrato	= His.Numero_Operacion
										and	Anticipo.Flujo		= His.Numero_Flujo
										and	Anticipo.Tipo		= His.Tipo_Flujo

			inner join	(	select Producto		= Case	when codigo_producto = 'ST' then 1
												 		when codigo_producto = 'SM' then 2
														when codigo_producto = 'FR' then 3
														when codigo_producto = 'SP' then 4
													end
							,		Glosa		= Descripcion
							from	BacParamSuda.dbo.Producto	with(nolock)
							where	Id_Sistema	= 'PCS'
						)	Prod	On Prod.Producto = His.tipo_swap

			inner join  (	select	Rut			= clrut
								,	Codigo		= clcodigo
								,	Dv			= cldv
								,	Nombre		= clnombre
							from	BacParamSuda.dbo.Cliente	with(nolock)
						)	Clie	On 	Clie.Rut = His.Rut_Cliente and Clie.codigo = His.Codigo_Cliente

			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = his.compra_moneda
			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = Venta.venta_moneda

			LEFT JOIN ( SELECT	fecha, codigo_moneda, tipo_cambio
						FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
						)		vmc						ON	vmc.Fecha			= his.fecha_inicio 
														AND vmc.Codigo_Moneda	= 994

			LEFT JOIN (	SELECT	vmfecha, vmcodigo, vmvalor
						FROM	BacParamSuda.dbo.VALOR_MONEDA 
						)		vvm						ON	vvm.vmfecha			= his.fecha_inicio 
														AND vvm.vmcodigo		= 998

			LEFT JOIN (	SELECT	fecha, codigo_moneda, tipo_cambio
						FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE 
						)		vmon					ON	vmon.Fecha			= his.fecha_inicio 
														AND vmon.Codigo_Moneda	= 129 -- COP
	where	His.FechaAnticipo		BETWEEN @PrimerDiaMes AND @UltimoDiaMes
	and		His.Tipo_Flujo			= 1
	and		His.Estado				<> ''

	UPDATE	#TMP_CARTERA_ANTICIPO_SWAP
	SET		MONTO_UTIL_LOCAL	= #TMP_CARTERA_ANTICIPO_SWAP.MONTO_UTIL_LOCAL	+ mis.MONTO_UTIL_LOCAL
	,		MONTO_UTIL_ORIGEN	= #TMP_CARTERA_ANTICIPO_SWAP.MONTO_UTIL_ORIGEN	+ mis.MONTO_UTIL_ORIGEN
	FROM	dbo.MIS_CON_BAC_DET	mis
	WHERE	mis.PRODUCT_TYPE_CD	= 'PCS'
	AND		mis.OPERACION		= #TMP_CARTERA_ANTICIPO_SWAP.OPERACION

	DELETE	
	FROM	dbo.MIS_CON_BAC_DET
	WHERE	OPERACION		IN (SELECT OPERACION FROM #TMP_CARTERA_ANTICIPO_SWAP)  
	AND		PRODUCT_TYPE_CD = 'PCS'  

	INSERT INTO dbo.MIS_CON_BAC_DET
	SELECT * FROM #TMP_CARTERA_ANTICIPO_SWAP

	DROP TABLE #TMP_CARTERA_ANTICIPO_SWAP
    
   /***************************************SPOT/CAMBIOS***************************************/        
   /******************************************************************************************/        

    INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = CONVERT(CHAR(6),mvto.mofech,112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = LTRIM(RTRIM(mvto.monumope))
	,		PRODUCT_ID                  = 'MD14'
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), clie.Clrut)))+ LTRIM(RTRIM(clie. Cldv))
	,		FULL_NAME                   = LTRIM(RTRIM(clie.Clnombre)) + SPACE(80 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'BCC'
	,		FECHA_CONTABLE              = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_INTERFAZ              = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_APERTURA_OPERAC       = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_INICIO                = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_VCMTO                 = CONVERT(CHAR(8), mvto.mofech, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM( mvto.mocodmon ))
	,		TIPO_MONEDA                 = CASE	WHEN mvto.mocodmon = 'CLP'	THEN '1'
												WHEN mvto.mocodmon = 'UF'	THEN '2'
												ELSE							 '3'
											END
	,		TIPO_OPERACION              = mvto.motipope
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN mvto.motipmer IN('ARBI', 'EMPR') and mvto.mocodcnv <> 'CLP' THEN  ISNULL(mvto.moparme, 0.0) 
												ELSE ISNULL(mvto.moticam,0.0)
											END
	,		CAP_MONE_ORIGEN             = mvto.momonmo
	,		CAP_MONE_LOCAL              = mvto.momonpe

	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mvto.mocodmon = 'CLP'	THEN	isnull( CASE WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX' THEN mvto.moDifTran_Clp ELSE mvto.moResultado_Comercial_Clp END, 0)
												WHEN mvto.mocodmon = 'UF'	THEN	isnull( CASE WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX' THEN mvto.moDifTran_Clp	ELSE mvto.moResultado_Comercial_Clp END / mvto.moticam, 0)
												WHEN mvto.mocodmon = 'USD'	THEN	isnull( CASE WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX' THEN mvto.moDifTran_Clp ELSE mvto.moResultado_Comercial_Clp END / mvto.moticam, 0)
												ELSE								isnull((CASE WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX' THEN mvto.moDifTran_Clp ELSE mvto.moResultado_Comercial_Clp END / mvto.moticam) * mvto.moparme,0)
											END
/*	,		MONTO_UTIL_ORIGEN           = CASE	WHEN mvto.mocodmon = 'CLP'	THEN	isnull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END,0)
												WHEN mvto.mocodmon = 'UF'	THEN	isNull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)
												WHEN mvto.mocodmon = 'USD'	THEN	isNull( CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam,0)
												ELSE								isNull((CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END / mvto.moticam) * mvto.moparme, 0)
										   END	*/

	,		MONTO_UTIL_LOCAL			= CASE WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX' THEN mvto.moDifTran_Clp ELSE mvto.moResultado_Comercial_Clp END
--	,		MONTO_UTIL_LOCAL			= CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END
	,		OPERADOR					= mvto.mooper

	FROM	(	select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
				,		cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
				,		morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memoh	with(nolock)
				where	mofech		BETWEEN @PrimerDiaMes and @UltimoDiaMes
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
					UNION
				select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
				,		cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
				,		morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memo		with(nolock)
				where	mofech		BETWEEN @PrimerDiaMes and @UltimoDiaMes
				and		moestatus	<> 'A'
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
			)	mvto

			inner join
			(	SELECT	clrut, cldv, clcodigo, clnombre
				FROM	BacParamSuda.dbo.CLIENTE with(nolock)
			)	clie	ON	clie.clrut		= mvto.morutcli 
						AND clie.clcodigo	= mvto.mocodcli
			left join
			(	select	Id		= ltrim(rtrim( nemo ))
				from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
				where	tbcateg = 8602 
			)	comex	On	comex.id =  mvto.moterm

	WHERE	mvto.monumope	NOT IN (SELECT monumope FROM BacCamSuda.dbo.MEMOH WHERE mooper		= 'CAVENDANO' AND moDifTran_Clp = 0 )
	AND		mvto.monumope	NOT IN (SELECT monumope FROM BacCamSuda.dbo.MEMOH WHERE morutcli	= '96665450'  AND moDifTran_Clp = 0 )

	ORDER 
	BY		mvto.monumope


	-- ************************************************************************** --
	-- *********************   O P C I O N E S    ******************************* --
	-- ************************************************************************** --

    INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE			=	CONVERT(CHAR(6),Retorno.MoFechaContrato,112)
	,		SOURCE_ID				=	'MI59'
	,		OPERACION				=	LTRIM(RTRIM(Retorno.MoNumContrato))
	,		PRODUCT_ID				=	case when Retorno.PAE = 'S' then 'MD17' else 'MD15' end
	,		ISO_COUNTRY				=	'CL'
	,		EMPRESA_ID				=	'001'
	,		BRANCH_CD				=	'001'
	,		CLIENTE_ID				=	Retorno.Rut
	,		FULL_NAME				=	Retorno.Nombre
	,		FAMILIA					=	'MDIR'
	,		PRODUCT_TYPE_CD			=	'OPC'
	,		FECHA_CONTABLE			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_INTERFAZ			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_APERTURA_OPERAC	=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_INICIO			=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_VCMTO				=	CONVERT(CHAR(8),Retorno.MoFechaContrato,112)
	,		FECHA_RENOVACION		=	SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA	=	SPACE(0)
	,		ISO_CURRENCY_CD			=	Retorno.MonTransada
	,		TIPO_MONEDA				=	CASE	WHEN Retorno.MonTransada	= 'CLP'			THEN '1'
												WHEN Retorno.MonTransada	= 'UF'			THEN '2'
												ELSE											 '3'
											END
	,		TIPO_OPERACION			=	CASE	WHEN Retorno.MoVinculacion	= 'Individual'	THEN Retorno.MoCvOpc
												ELSE											 ''
											END
	,		PERIODICIDAD_DE_FLUJOS	=	'00000'
	,		IND_TASA_TRANSFERENCIA	=	SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP	=	'0'
	,		TASA_INTERES			=	0.0
	,		TASA_TIPO_PARIDAD		=	Retorno.Strike
	,		CAP_MONE_ORIGEN			=	Retorno.MoMontoMon1
	,		CAP_MONE_LOCAL			=	Retorno.MoMontoMon2
	,		MONTO_UTIL_ORIGEN		=	Retorno.ResultadoMo
	,		MONTO_UTIL_LOCAL		=	Retorno.ResultadoMl
	,		OPERADOR				=	Retorno.mooperador
	FROM	(	select	MoNumContrato		= mov.monumcontrato
				,		mooperador			= mov.mooperador
				,		MoResultadoVentasML	= mov.moresultadoventasml
				,		MoFechaContrato		= case	when mov.motipotransaccion = 'ANTICIPA' then mov.mofechaunwind
													else mov.mofechacontrato
												end
				,		MoRutCliente		= mov.morutcliente
				,		MoCodigo			= mov.mocodigo
				,		MoCallPut			= Detalle.mocallput
				,		MoStrike			= Detalle.mostrike
				,		MoVinculacion		= Detalle.movinculacion
				,		MoCVOpc				= Detalle.mocvopc
				,		MoMontoMon1			= Detalle.momontomon1
				,		MoMontoMon2			= Detalle.momontomon2
				,		MonTransada			= mon1.mnnemo
				,		MonConversion		= mon2.mnnemo
				,		MoRelacionaPAE		= mov.morelacionapae
				,		mocodestructura		= mov.mocodestructura
				,		MoFechaInicioOpc	= Detalle.mofechainicioopc
				,		MoNumFolio			= mov.monumfolio
				,		ResultadoMl			= grupo.ResultadoMl
				,		ResultadoMo			= grupo.ResultadoDo
				,		Strike				= grupo.Strike
				,		Rut					= convert(char(10), clie.cRut	 )
				,		Nombre				= convert(char(60), clie.cNombre )
				,		PAE					= case when mov.MoRelacionaPAE = 1 then 'S' else 'N' end
				FROM	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato		mov	with(nolock)

						INNER JOIN (	select	monumcontrato			= Grp.monumcontrato
											,	monumfolio				= MAX( Grp.MoNumFolio )
										from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp with(nolock)
										where	Grp.mofechacontrato	BETWEEN @PrimerDiaMes and @UltimoDiaMes
										and		Grp.moestado			<> 'C'
									--	and		Grp.motipotransaccion	NOT IN('ANULA' , 'EJERCE')
										group 
										by		Grp.monumcontrato

												union

										select	monumcontrato			= Grp.monumcontrato
										,		monumfolio				= MAX( Grp.MoNumFolio )
										from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp	with(nolock)
										where	Grp.MoFechaUnwind		BETWEEN @PrimerDiaMes and @UltimoDiaMes
										and		Grp.moestado			<> 'C'
									--	and		Grp.motipotransaccion	NOT IN('ANULA' , 'EJERCE')
										group 
										by		Grp.monumcontrato
									)	Flujo	On	Flujo.monumcontrato	= mov.monumcontrato
												and	Flujo.monumfolio	= mov.monumfolio

						INNER JOIN	(	select	monumcontrato		= Grp.monumcontrato
											,	monumfolio			= Grp.MoNumFolio
											,	ResultadoMl			= SUM( Grp.moresultadoventasml )
											,	ResultadoDo			= SUM( Grp.moresultadoventasml / DetInt.mostrike )
											,	Strike				= AVG( DetInt.mostrike )
										from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp with(nolock)

												inner join (	select	monumfolio, mostrike
																from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato with(nolock)
																where	monumestructura		 = 1
															)	DetInt	On DetInt.monumfolio = Grp.monumfolio

										where	Grp.mofechacontrato	BETWEEN @PrimerDiaMes and @UltimoDiaMes
									--	and		Grp.motipotransaccion	NOT IN('ANULA' , 'EJERCE')
										group
										by		Grp.monumcontrato
											,	Grp.MoNumFolio

											union

										select	monumcontrato		= Grp.monumcontrato
											,	monumfolio			= Grp.MoNumFolio
											,	ResultadoMl			= SUM( Grp.moresultadoventasml )
											,	ResultadoDo			= SUM( Grp.moresultadoventasml / DetInt.mostrike )
											,	Strike				= AVG( DetInt.mostrike )
										from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp

												inner join (	select	monumfolio, mostrike
																from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato with(nolock)
																where	monumestructura	= 1
															)	DetInt	On DetInt.monumfolio = Grp.monumfolio

										where	Grp.MoFechaUnwind	BETWEEN @PrimerDiaMes and @UltimoDiaMes
									--	and		Grp.motipotransaccion	 NOT IN('ANULA' , 'EJERCE')
										group
										by		Grp.monumcontrato
											,	Grp.MoNumFolio

									)	Grupo	On	Grupo.monumcontrato	= Flujo.monumcontrato
												and	Grupo.monumfolio	= Flujo.monumfolio

						inner join	(	select	monumfolio			= monumfolio
										,		mostrike			= mostrike
										,		mocallput			= mocallput
										,		movinculacion		= movinculacion
										,		mocvopc				= mocvopc
										,		momontomon1			= momontomon1
										,		momontomon2			= momontomon2
										,		mocodmon1			= mocodmon1
										,		mocodmon2			= mocodmon2
										,		mofechainicioopc	= mofechainicioopc
										from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato with(nolock)
										where	monumestructura		= 1
									)			Detalle			On Detalle.monumfolio = mov.monumfolio

						left  join	(	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)			mon1			On	mon1.mncodmon	 = Detalle.mocodmon1

						left join	(	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)			mon2			On	mon2.mncodmon	 = Detalle.mocodmon2

						left  join (	select	clrut		= clrut
											,	clcodigo	= clcodigo
											,	cRut		= ltrim(rtrim( convert(char(10), clrut) )) + ltrim(rtrim( cldv ))
											,	cNombre		= ltrim(rtrim( clnombre )) + space( 60 - len( ltrim(rtrim( clnombre )) ) )
										from	BacParamSuda.dbo.cliente with(nolock)
									)			clie			On	clie.clrut		= mov.MoRutCliente
																and clie.clcodigo	= mov.MoCodigo
				WHERE	grupo.ResultadoMl <> 0
				and		mov.motipotransaccion	NOT IN('ANULA' , 'EJERCE')
			)	Retorno
	order 
	by		Retorno.monumcontrato



	/**************************************************************************************/
	/****************************** S P O T     W E B *************************************/
	/**************************************************************************************/

	-->		SPOT WEB	<--
	INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = convert( char(6), opx.Fecha, 112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = ltrim(rtrim( opx.FolioContrato ))
	,		PRODUCT_ID                  = 'MD14'	--> Mantiene el Codigo de Producto de los Spot.
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), opx.RutCliente ))) 
										+ CONVERT(CHAR(1), BacParamSuda.dbo.Fn_GeneraDvRut(opx.RutCliente)) 						--> cli.clienteid
	,		FULL_NAME                   = LTRIM(RTRIM( opx.NombreCliente )) + SPACE(60 - LEN(LTRIM(RTRIM( opx.NombreCliente ))))	-->	cli.fullname
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'SPW'		--> 'BCC'	
	,		FECHA_CONTABLE              = convert( char(8), opx.Fecha, 112)
	,		FECHA_INTERFAZ              = convert( char(8), opx.Fecha, 112)
	,		FECHA_APERTURA_OPERAC       = convert( char(8), opx.Fecha, 112)
	,		FECHA_INICIO                = convert( char(8), opx.Fecha, 112)
	,		FECHA_VCMTO                 = convert( char(8), opx.Fecha, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = opx.TipoTransaccion
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = opx.TipoCambio
	,		CAP_MONE_ORIGEN             = opx.MtoDolares
	,		CAP_MONE_LOCAL				= opx.MtoPesos
	,		MONTO_UTIL_ORIGEN           = (ROUND(opx.SpreadComercial * opx.MtoDolares, 0) / opx.TipoCambio)
	,		MONTO_UTIL_LOCAL			=  ROUND(opx.SpreadComercial * opx.MtoDolares, 0)
	,		OPERADOR					= 'E-Bank'
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
			/*
			inner join 	(	select	clrut		= clie.clrut
								,	clienteid	= LTRIM(RTRIM(CONVERT(CHAR(10), clie.clrut )))+ LTRIM(RTRIM( clie.cldv ))  
								,	fullname    = LTRIM(RTRIM( clie.clnombre )) + SPACE(60 - LEN(LTRIM(RTRIM( clie.clnombre ))))
								,	clcodigo	= clie.clcodigo
							from	BacParamSuda.dbo.CLIENTE	clie	with(nolock)
									inner join (	select	clrut	 = clrut
														,	cldv	 = MIN( cldv )
														,	clcodigo = MIN(clcodigo)
													from	BacParamSuda.dbo.Cliente	with(nolock)
													group 
													by		clrut 
												)	grpcli		On	grpcli.clrut	= clie.clrut 
															and		grpcli.cldv		= clie.cldv
															and		grpcli.clcodigo	= clie.clcodigo
						)	cli		On	cli.clrut		=	opx.RutCliente
			*/
			left join	(	select	mncodmon, mnnemo
							from	BacParamSuda.dbo.MONEDA	with(nolock)
						)	mon1	On	mon1.mncodmon	=	13
	WHERE	opx.Fecha	BETWEEN @PrimerDiaMes AND @UltimoDiaMes
	and		opx.Origen	= 'TEFUSDWEB'


	/**************************************************************************************/
	/************************* S P O T     N E W   Y O R K ********************************/
	/**************************************************************************************/

	-->		SPOT NY	<--
	INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = convert( char(6), opx.Fecha, 112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = ltrim(rtrim( opx.FolioContrato ))
	,		PRODUCT_ID                  = 'MD18'	--> codigo MIS
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = LTRIM(RTRIM(CONVERT(CHAR(10), opx.RutCliente ))) 
										+ BacParamSuda.dbo.Fn_GeneraDvRut( opx.RutCliente )
	,		FULL_NAME                   = opx.NombreCliente
	,		FAMILIA                     = 'MDIR'
	,		PRODUCT_TYPE_CD             = 'SPW'		--> 'BCC'	
	,		FECHA_CONTABLE              = convert( char(8), opx.Fecha, 112)
	,		FECHA_INTERFAZ              = convert( char(8), opx.Fecha, 112)
	,		FECHA_APERTURA_OPERAC       = convert( char(8), opx.Fecha, 112)
	,		FECHA_INICIO                = convert( char(8), opx.Fecha, 112)
	,		FECHA_VCMTO                 = convert( char(8), opx.Fecha, 112)
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = LTRIM(RTRIM(mon1.mnnemo))
	,		TIPO_MONEDA                 = CASE	WHEN mon1.mnnemo = 'CLP'	THEN '1'
												WHEN mon1.mnnemo = 'UF'		THEN '2'
												ELSE							 '3' END
	,		TIPO_OPERACION              = opx.TipoTransaccion
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = '0'
	,		TASA_INTERES                = 0.0
	,		TASA_TIPO_PARIDAD           = opx.TipoCambio
	,		CAP_MONE_ORIGEN             = opx.MtoDolares
	,		CAP_MONE_LOCAL              = opx.MtoPesos
	,		MONTO_UTIL_ORIGEN           = (ROUND(opx.SpreadComercial * opx.MtoDolares, 0) / opx.TipoCambio)
	,		MONTO_UTIL_LOCAL			=  ROUND(opx.SpreadComercial * opx.MtoDolares, 0)
	,		OPERADOR					= 'E-Bank'
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
			left join	(	select	mncodmon, mnnemo
							from	BacParamSuda.dbo.MONEDA	with(nolock)
						)	mon1	On	mon1.mncodmon	=	13
	WHERE	opx.Fecha	BETWEEN @PrimerDiaMes AND @UltimoDiaMes
	and		opx.Origen	= 'TEFCBNY'

	/**************************************************************************************/
	/******************** R E N T A   F I J A   N A C I O N A L ***************************/
	/**************************************************************************************/

	INSERT	INTO dbo.MIS_CON_BAC_DET
	SELECT	MES_CONTABLE                = convert(char(6), Movto.mofecpro, 112)
	,		SOURCE_ID                   = 'MI59'
	,		OPERACION                   = ltrim(rtrim( Movto.monumoper ))	-->	Deberia ser compuesto (Operacion + Correla + Documento)
	,		PRODUCT_ID                  = 'MD16'							--> Se debe definir el Codigo del Producto
	,		ISO_COUNTRY                 = 'CL'
	,		EMPRESA_ID                  = '001'
	,		BRANCH_CD                   = '001'
	,		CLIENTE_ID                  = Clie.clienteid
	,		FULL_NAME                   = Clie.fullname
	,		FAMILIA						= 'MDIR'
	,		PRODUCT_TYPE_CD             = 'BTR'								--> Indicador de Renta Fija
	,		FECHA_CONTABLE				= convert(char(8), Movto.mofecpro, 112)
	,		FECHA_INTERFAZ              = convert(char(8), Movto.mofecpro, 112)
	,		FECHA_APERTURA_OPERAC       = convert(char(8), Movto.mofecpro, 112)
	,		FECHA_INICIO                = isnull(CASE	WHEN Movto.motipoper IN('CP',' VP') THEN convert(char(8), Movto.mofecpro,	112)
														WHEN Movto.motipoper IN('CI', 'VI') THEN convert(char(8), Movto.mofecinip,	112)
													END, convert(char(8), Movto.mofecpro,	112))
	,		FECHA_VCMTO                 = case	when Movto.motipoper = 'CP' then SPACE(0)
												else							 convert(char(8), FechaVcto, 112)
											end
	,		FECHA_RENOVACION            = SPACE(0)
	,		FECHA_PROX_CAMBIO_TASA      = SPACE(0)
	,		ISO_CURRENCY_CD             = substring(Mone.mnnemo, 1,3)
	,		TIPO_MONEDA                 = Mone.tipmon
	,		TIPO_OPERACION              = substring(Movto.motipoper, 1, 1)
	,		PERIODICIDAD_DE_FLUJOS      = '0'
	,		IND_TASA_TRANSFERENCIA      = SPACE(0)
	,		NRO_CUOTAS_FLUJO_SWAP       = 0
	,		TASA_INTERES                = 0
	,		TASA_TIPO_PARIDAD           = CASE	WHEN Movto.motipoper IN('CP', 'VP') THEN	Movto.motir
												WHEN Movto.motipoper IN('CI', 'VI') THEN	Movto.motaspact
											END
	,		CAP_MONE_ORIGEN             = CASE	WHEN Movto.motipoper IN('VI', 'VP')	THEN	Movto.movalven 
												ELSE										Movto.movpresen 
											END
	,		CAP_MONE_LOCAL              = CASE	WHEN Movto.motipoper IN('VI', 'VP')	THEN	Movto.movalven 
												ELSE										Movto.movpresen 
											END
	,		MONTO_UTIL_ORIGEN           = case	when Movto.moDifTran_CLP = 0 then 0 
												else isnull(Movto.moDifTran_CLP / vmvalor,0.0)
											end
	,		MONTO_UTIL_LOCAL			= Movto.moDifTran_CLP
	,		OPERADOR					= ltrim(rtrim( Movto.mousuario ))
	FROM	(	select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motir	 * movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact * movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	moDifTran_CLP	= MAX( moDifTran_CLP )
					,	Moneda			= momonpact
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecvenp )
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CI', 'VI')
				and		mostatreg  <> 'A'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonpact
					,	mofecinip

				union all

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen	 )
					,	motir			= SUM( motir	* movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact* movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran* movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven		 )
					,	moDifTran_CLP	= SUM( moDifTran_CLP )
					,	Moneda			= momonemi
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecven  )
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CP', 'VP', 'IB' )
				and		mostatreg  <> 'A'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonemi
					,	mofecinip

						union

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motir	 * movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact * movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	moDifTran_CLP	= MAX( moDifTran_CLP )
					,	Moneda			= momonpact
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecvenp )
				from	BacTraderSuda.dbo.MDMO	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CI', 'VI')
				and		mostatreg  <> 'A'
				and		PagoMañana  = 'N'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonpact
					,	mofecinip

				union all

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	mousuario		= mousuario
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	movpresen		= SUM( movpresen	 )
					,	motir			= SUM( motir	* movpresen )	/ SUM( movpresen )
					,	motaspact		= SUM( motaspact* movpresen )	/ SUM( movpresen )
					,	moTirTran		= SUM( moTirTran* movpresen )	/ SUM( movpresen )
					,	movalven		= SUM( movalven		 )
					,	moDifTran_CLP	= SUM( moDifTran_CLP )
					,	Moneda			= momonemi
					,	mofecinip		= mofecinip
					,	FechaVcto		= MAX( mofecven  )
				from	BacTraderSuda.dbo.MDMO	with(nolock)
				where	mofecpro   BETWEEN @PrimerDiaMes AND @UltimoDiaMes
				and		motipoper  IN('CP', 'VP', 'IB' )
				and		mostatreg  <> 'A'
				and		PagoMañana  = 'N'
				group 
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonemi
					,	mofecinip
			)	Movto
			inner join  (	select	clrut
							,		clcodigo
							,		cldv
							,		clienteid	= LTRIM(RTRIM(CONVERT(CHAR(10), clrut )))+ LTRIM(RTRIM( cldv ))
							,		fullname    = LTRIM(RTRIM( clnombre )) + SPACE(60 - LEN(LTRIM(RTRIM( clnombre ))))
							from	BacParamSuda.dbo.CLIENTE with(nolock)
						)	Clie	On		Clie.clrut		= Movto.morutcli 
									and		Clie.clcodigo	= Movto.mocodcli      

			inner join	(	select	mncodmon
							,		mnnemo	= ltrim(rtrim( mnnemo ))
							,		tipmon	= CASE	WHEN mnnemo = 'CLP'	THEN '1'
													WHEN mnnemo = 'UF'	THEN '2'
													ELSE					 '3' END
							from	BacParamSuda.dbo.MONEDA	with(nolock)
						)	Mone	On	Mone.mncodmon = Movto.Moneda 

			inner join	(	select	vmfecha,	vmcodigo,	vmvalor
							from	BacParamSuda.dbo.Valor_Moneda
							union	
							select	vmfecha,	999,		1.0
							from	BacParamSuda.dbo.Valor_Moneda
							where	vmcodigo	= 994
							union
							select	vmfecha,	13,			vmvalor
							from	BacParamSuda.dbo.Valor_Moneda
							where	vmcodigo	= 994
						)	nvalmon	On	nvalmon.vmfecha	 =	CASE	WHEN Movto.motipoper IN('CP', 'VP')	THEN Movto.mofecpro
																	WHEN Movto.motipoper IN('CI', 'VI')	THEN Movto.mofecinip
																END	
									and	nvalmon.vmcodigo =	Mone.mncodmon
	/************************************************************************************************************************/        
	/*INTERFAZ BAC*/

	IF @iDiario = 0	--> Proceso Diario
	BEGIN

		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
			,	OPERADOR
		FROM	dbo.MIS_CON_BAC_DET mis
				inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
								from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
								where	tbcateg					= 9000
							)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = mis.OPERADOR
		WHERE	LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD16'
		and		LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD15'

		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
			,	OPERADOR
		FROM	dbo.MIS_CON_BAC_DET mis
				inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
								from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
								where	tbcateg					= 9000
							)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = OPERADOR
		WHERE	LTRIM(RTRIM( PRODUCT_ID	))  =	'MD16'	--> Fltro de Usuarios, aplica para todo a excepción de Renta Fija


		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC_DIARIA
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
			,	OPERADOR
		FROM	dbo.MIS_CON_BAC_DET mis
		WHERE	PRODUCT_ID		=	'MD15'	--> Fltro de Usuarios, No aplica para Opciones (Se informan Todas las Operaciones)
	END --> Fin Proceso Diario

	IF @iDiario > 0	-->  Proceso Mensual Y Resumen
	BEGIN

		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
		FROM	dbo.MIS_CON_BAC_DET mis
				inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
								from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
								where	tbcateg					= 9000
							)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = mis.OPERADOR
		WHERE	LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD16'
		and		LTRIM(RTRIM( mis.PRODUCT_ID	))  <>	'MD15'

		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
		FROM	dbo.MIS_CON_BAC_DET mis
				inner join (	select	distinct OPERADOR_MDISTRIBUCION	= tbglosa 
								from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE	with(nolock)
								where	tbcateg					= 9000
							)			Operadores				On Operadores.OPERADOR_MDISTRIBUCION = OPERADOR
		WHERE	LTRIM(RTRIM( PRODUCT_ID	))  =	'MD16'	--> Fltro de Usuarios, aplica para todo a excepción de Renta Fija


		INSERT INTO dbo.MIS_CON_BAC_UTIL_TC
		SELECT	MES_CONTABLE
			,	SOURCE_ID
			,	OPERACION
			,	PRODUCT_ID
			,	ISO_COUNTRY
			,	EMPRESA_ID
			,	BRANCH_CD
			,	CLIENTE_ID
			,	FULL_NAME
			,	FAMILIA
			,	PRODUCT_TYPE_CD
			,	FECHA_CONTABLE
			,	FECHA_INTERFAZ
			,	FECHA_APERTURA_OPERAC
			,	FECHA_INICIO
 			,	FECHA_VCMTO
			,	FECHA_RENOVACION
			,	FECHA_PROX_CAMBIO_TASA
			,	ISO_CURRENCY_CD
			,	TIPO_MONEDA
			,	TIPO_OPERACION
			,	PERIODICIDAD_DE_FLUJOS
			,	IND_TASA_TRANSFERENCIA
			,	NRO_CUOTAS_FLUJO_SWAP
			,	TASA_INTERES
			,	TASA_TIPO_PARIDAD
			,	CAP_MONE_ORIGEN
			,	CAP_MONE_LOCAL
			,	MONTO_UTIL_ORIGEN
			,	MONTO_UTIL_LOCAL
		FROM	dbo.MIS_CON_BAC_DET mis
		WHERE	PRODUCT_ID		=	'MD15'	--> Fltro de Usuarios, No aplica para Opciones (Se informan Todas las Operaciones)
	END --> Fin Proceso Mensual

END

GO

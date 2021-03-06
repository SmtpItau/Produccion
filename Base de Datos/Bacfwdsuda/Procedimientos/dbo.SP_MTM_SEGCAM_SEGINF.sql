USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MTM_SEGCAM_SEGINF]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_MTM_SEGCAM_SEGINF](	@FechaProceso	DATETIME
					)
AS
BEGIN
--  SP_MTM_SegCam_SegInf '20140408'  
	SET NOCOUNT ON

	DECLARE @UF		FLOAT
	,	@DOC		FLOAT
	,	@DO		FLOAT
	,	@EURO		FLOAT
	,	@Base		FLOAT

	SET	@Base = 360.0

	SELECT	@UF           = vmvalor
	FROM	BACPARAMSUDA.DBO.VALOR_MONEDA WITH(NOLOCK)
	WHERE	vmcodigo      = 998
	AND	vmfecha       = @fechaproceso

	SELECT	@DO           = vmvalor
	FROM	BACPARAMSUDA.DBO.VALOR_MONEDA WITH(NOLOCK)
	WHERE	vmcodigo      = 994
	AND	vmfecha       = @fechaproceso

	SELECT	@DOC          = Tipo_Cambio
	FROM	BACPARAMSUDA.DBO.VALOR_MONEDA_CONTABLE WITH(NOLOCK)
	WHERE	Codigo_Moneda = 994
	AND	Fecha         = @fechaproceso

	SELECT	@EURO		= vmvalor
	FROM	BACPARAMSUDA.DBO.VALOR_MONEDA WITH(NOLOCK)
	WHERE	vmcodigo      = 142
	AND	vmfecha       = @fechaproceso

	SELECT  CP.CodigoCurva
	,		CP.Producto
	,		CP.Moneda
	,		CP.CurAlter
	,		IsValid    = 0
	,		DF.CurvaLocal
	INTO    #TMPCURVASFORWARD
	FROM    BACPARAMSUDA.DBO.CURVAS_PRODUCTO  CP 
	LEFT join BacParamSuda.dbo.Definicion_Curvas  DF on DF.CodigoCurva = CP.CodigoCurva
	WHERE   modulo     = 'BFW'
	AND     TipoTasa   = 'N'
	AND      producto in ( 1, 3 )                                     


	CREATE NONCLUSTERED INDEX TMPCURVASFORWARD_001 ON #TMPCURVASFORWARD
	(	CodigoCurva
	,	Producto
	,	Moneda
	)

	SELECT	DISTINCT 
		CodigoCurva
	INTO    #TMPLISTCURVA
	FROM    #TMPCURVASFORWARD

	/**************************************************************************************************************/
	/******************************************** CARTERA A VALORIZAR *********************************************/
	/**************************************************************************************************************/

	SELECT	'NumeroOperacion'      = canumoper
	,	'ID'                   = 0
	,	'CodigoPosicion'       = cacodpos1
	,	'TipoOperacion'        = catipoper
	,	'FechaVencimiento'     = cafecvcto
	,	'FechaEfectiva'        = cafecEfectiva
	,	'MonedaPrincipal'      = cacodmon1
	,	'MonedaSecundaria'     = cacodmon2
	,	'MontoPrincipal'       = camtomon1
	,	'PrecioForward'        = catipcam
	,	'PrecioTeorico'        = CONVERT( FLOAT, 0 )
	,	'PTeorico'             = fVal_Obtenido
	,	'MontoSecundario'      = camtomon2
	,	'Term'                 = DATEDIFF( DAY, @fechaproceso,cafecEfectiva )
	,	'Term2'                = CAST( DATEDIFF( DAY, @fechaproceso,cafecEfectiva ) AS FLOAT)
	,	'CurvaPrincipal'       = C1.CodigoCurva
	,	'TasaCurvaPrincipal'   = CONVERT( FLOAT, 0 )
	,	'wfPrincipal'          = CONVERT( FLOAT, 0 )
	,	'CurvaSecundaria'      = C2.CodigoCurva
	,	'TasaCurvaSecundaria'  = CONVERT( FLOAT, 0 )
	,	'wfSecundaria'         = CONVERT( FLOAT, 0 )
	,	'ValorMoneda'          = CASE	WHEN cacodmon1 =  13 AND cacodmon2 = 999 THEN @DOC
						WHEN cacodmon1 =  13 AND cacodmon2 = 998 THEN @DOC / @UF
						WHEN cacodmon1 = 998 AND cacodmon2 = 999 THEN @UF
						WHEN cacodmon1 = 142 AND cacodmon2 = 999 THEN @EURO	--GLCF
					 END
	,	'wf'                   = CONVERT( FLOAT, 0 )
	,	'MTM'                  = CONVERT( FLOAT, 0 )
	,	'ValorRazonableNet'    = round(ValorRazonableActivo - ValorRazonablePasivo, 0)
	,	ValorRazonableActivo
	,	ValorRazonablePasivo
	,	CaTasaSinteticaM1
	,	CaTasaSinteticaM2
        -- 5522 Inicio Bloque Forward a Observado
	,	'PrecioForwardDelta'            = caTipCam
	,	'PrecioTeoricoDelta'            = CONVERT( FLOAT, 0 )
	,	'FijTipCam'                     = DATEDIFF( DAY, @fechaproceso,CaFechaFijacionStarting )  -- select * from mfca
	,	'FijTipCam2'                    = CAST( DATEDIFF( DAY, @fechaproceso,CaFechaFijacionStarting ) AS FLOAT)
        ,       'TasaCurvaPrincipalFijTipCam'   = CONVERT( FLOAT, 0 )
	,	'wfPrincipalFijTipCam'          = CONVERT( FLOAT, 0 )  
	,	'TasaCurvaSecundariaFijTipCam'  = CONVERT( FLOAT, 0 )
	,	'wfSecundariaFijTipCam'         = CONVERT( FLOAT, 0 )
        ,       'MTMDelta'                = CONVERT( FLOAT, 0 )
        ,       'Delta'                         = CONVERT( FLOAT, 0 )
        ,       'Puntos'                        = CONVERT( FLOAT, CaPuntosFwdCierre )
        -- 5522 Fin Bloque Forward a Observado
		,       'FechaStarting'					= CaFechaStarting  -- PRD20732

		-- Marca de debe salir de la cartera, mientras se simula 
		,       'Marca_Colateral'               = case when isnull(o.cod_colateral,'')='' then 'N' else 'S' end
		,       'Moneda_Colateral'              = case when isnull(o.cod_colateral,'')='USD' then o.cod_colateral else 'CLP' end
		,       'CurvaColPric'                  = C1_Col.CodigoCurva
		,       'CurvaColSec'                   = C2_Col.CodigoCurva 
		,       'TasaCurvaPrincipal_Col'        = CONVERT( FLOAT, 0 )
		,       'TasaCurvaSecundaria_Col'       = CONVERT(FLOAT,0)
		,       'wfPrincipalCol'                = COnvert(Float,0)
		,       'wfSecundariaCol'               = Convert(Float,0)
		,        'ValorRazonableActivoCol'        = convert( float,0)
		,        'ValorRazonablePasivoCol'        = convert( float,0)
		,        'MTM_Col'                        = convert( float,0 )

	INTO	#tmpCartera
	FROM	DBO.MFCA c WITH(NOLOCK)	
	LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='FWD' and o.rut_cliente=c.cacodigo and o.cod_cliente=c.cacodcli and o.numero_operacion=c.canumoper
	LEFT JOIN #tmpCurvasForward C1 ON  CASE WHEN cacodpos1 = 13 THEN 3 
                                                 -- 5522 Forward a Observado, aprobado x JPFreire
											 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = c1.Producto AND cacodmon1 = c1.moneda and C1.CurvaLocal = 'S'

	LEFT JOIN #tmpCurvasForward C2 ON  CASE WHEN cacodpos1 = 13 THEN 3 
                                                 -- 5522 Forward a Observado, aprobado x JPFreire
											 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = c2.Producto AND cacodmon2 = c2.moneda  and C2.CurvaLocal = 'S'

	LEFT JOIN #tmpCurvasForward C1_Col	ON  CASE WHEN cacodpos1 = 13 THEN 3 
                                                 -- 5522 Forward a Observado, aprobado x JPFreire
                                                 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = c1_Col.Producto AND cacodmon1 = c1_Col.moneda and C1_Col.CurvaLocal = 'N'

	LEFT JOIN #tmpCurvasForward C2_Col ON  CASE WHEN cacodpos1 = 13 THEN 3 
                                                 -- 5522 Forward a Observado, aprobado x JPFreire
                                                 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = C2_Col.Producto AND cacodmon2 = C2_Col.moneda  and C2_Col.CurvaLocal = 'N'					

	WHERE	cacodpos1	NOT IN  (2,10,11,12) 






	INSERT INTO #tmpCartera
	SELECT	'NumeroOperacion'      = canumoper
	,	'ID'                   = ctf_correlativo
	,	'CodigoPosicion'       = cacodpos1
	,	'TipoOperacion'        = catipoper
	,	'FechaVencimiento'     = ctf_fecha_vencimiento
	,	'FechaEfectiva'        = ctf_fecha_fijacion
	,	'MonedaPrincipal'      = cacodmon1
	,	'MonedaSecundaria'     = cacodmon2
	,	'MontoPrincipal'       = ctf_monto_principal
	,	'PrecioForward'        = ctf_precio_contrato
	,	'PrecioTeorico'        = CONVERT( FLOAT, 0 )
	,	'PTeorico'             = ctf_precio_proyectado
	,	'MontoSecundario'      = ctf_monto_secundario
	,	'Term'                 = DATEDIFF( DAY, @fechaproceso,ctf_fecha_fijacion )
	,	'Term2'                = CAST( DATEDIFF( DAY,@fechaproceso, ctf_fecha_fijacion ) AS FLOAT)
	,	'CurvaPrincipal'       = C1.CodigoCurva
	,	'TasaCurvaPrincipal'   = CONVERT( FLOAT, 0 )
	,	'wfPrincipal'          = CONVERT( FLOAT, 0 )
	,	'CurvaSecundaria'      = C2.CodigoCurva
	,	'TasaCurvaSecundaria'  = CONVERT( FLOAT, 0 )
	,	'wfSecundaria'         = CONVERT( FLOAT, 0 )
	,	'ValorMoneda'          = CASE	WHEN cacodmon1 =  13 AND cacodmon2 = 999 THEN @DOC
						WHEN cacodmon1 =  13 AND cacodmon2 = 998 THEN @DOC / @UF
						WHEN cacodmon1 = 998 AND cacodmon2 = 999 THEN @UF
						WHEN cacodmon1 = 142 AND cacodmon2 = 999 THEN @EURO	--GLCF
					  END
	,	'wf'                   = CONVERT( FLOAT, 0 )
	,	'MTM'                  = CONVERT( FLOAT, 0 )
	,	'ValorRazonableNet'    = ROUND(Ctf_Valor_Razonable,0)
	,	Ctf_Valor_Razonable_Activo
	,	Ctf_Valor_Razonable_Pasivo
	,	Ctf_Tasa_Moneda_Principal
	,	Ctf_Tasa_Moneda_Secundaria
        -- 5522 Inicio Bloque Forward a Observado
	,	'PrecioForwardDelta'   = ctf_precio_contrato
	,	'PrecioTeoricoDelta'   = CONVERT( FLOAT, 0 )
	,	'FijTipCam'            = DATEDIFF( DAY, @fechaproceso,ctf_fecha_fijacion )  -- select * from mfca
	,	'FijTipCam2'           = CAST( DATEDIFF( DAY, @fechaproceso,ctf_fecha_fijacion ) AS FLOAT)
        ,       'TasaCurvaPrincipalFijTipCam'   = CONVERT( FLOAT, 0 )
	,	'wfPrincipalFijTipCam'          = CONVERT( FLOAT, 0 )  
	,	'TasaCurvaSecundariaFijTipCam'  = CONVERT( FLOAT, 0 )
	,	'wfSecundariaFijTipCam'         = CONVERT( FLOAT, 0 )
        ,       'MTMDelta'                      = CONVERT( FLOAT, 0 )
        ,       'Delta'                         = CONVERT( FLOAT, 0 )
        ,       'Puntos'                        = CONVERT( FLOAT, 0 )		
        -- 5522 Fin Bloque Forward a Observado
		,       'FechaStarting'					= CaFecha -- PRD20732

		-- Macar de debe salir de la cartera, mientras se simula 
		,       'Marca_Colateral'               = case when isnull(o.cod_colateral,'')='' then 'N' else 'S' end
		,       'Moneda_Colateral'              = case when isnull(o.cod_colateral,'')='USD' then o.cod_colateral else 'CLP' end
		,       'CurvaColPric'                  = C1_Col.CodigoCurva
		,       'CurvaColSec'                   = C2_Col.CodigoCurva 
		,       'TasaCurvaPrincipal_Col'        = CONVERT( FLOAT, 0 )
		,       'TasaCurvaSecundaria_Col'       = CONVERT(FLOAT,0)
		,       'wfPrincipalCol'                = COnvert(Float,0)
		,       'wfSecundariaCol'               = Convert(Float,0)
		,        'ValorRazonableActivoCol'        = convert( float,0)
		,        'ValorRazonablePasivoCol'        = convert( float,0)
		,        'MTM_Col'                        = convert( float,0)

	FROM	DBO.TBL_CARTERA_FLUJOS WITH(NOLOCK)	
	INNER JOIN DBO.MFCA c WITH(NOLOCK) ON  cacodpos1		= 13	-- SEG. INF. HIPOTECARIO 
										AND ctf_Numero_Operacion= canumoper
	LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='FWD' and o.rut_cliente=c.cacodigo and o.cod_cliente=c.cacodcli and o.numero_operacion=c.canumoper
							
	LEFT JOIN #tmpCurvasForward C1 ON  c1.Producto		= 3	-- SEGURO DE INFLACION -- S0LO PARA OBTENCION DE CURVAS
										AND cacodmon1		= c1.moneda  and C1.CurvaLocal = 'S'
							
	LEFT JOIN #tmpCurvasForward C2 ON  c2.Producto		=  3	-- SEGURO DE INFLACION -- S0LO PARA OBTENCION DE CURVAS
										AND cacodmon2		= c2.moneda   and C2.CurvaLocal = 'S'

	LEFT JOIN #tmpCurvasForward C1_Col ON  CASE WHEN cacodpos1 = 13 THEN 3 
														 -- 5522 Forward a Observado, aprobado x JPFreire
												 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = c1_Col.Producto AND cacodmon1 = c1_Col.moneda and C1_Col.CurvaLocal = 'N'

	LEFT JOIN #tmpCurvasForward C2_Col ON  CASE WHEN cacodpos1 = 13 THEN 3 
														 -- 5522 Forward a Observado, aprobado x JPFreire
												 WHEN cacodpos1 = 14 THEN 1 ELSE cacodpos1 END = C2_Col.Producto AND cacodmon2 = C2_Col.moneda  and C2_Col.CurvaLocal = 'N'		



	SELECT  'Curva'  = B.CodigoCurva
	,	'Plazo'  = B.Dias
	,	'Tasa'   = B.ValorBid
	INTO	#tmpCurvas
	FROM	BACPARAMSUDA.DBO.CURVAS B with(nolock)
	,	#tmpListCurva A
	WHERE	B.FechaGeneracion  = @fechaproceso
	AND	B.CodigoCurva      = A.CodigoCurva


	--******************************************************************************************************************************--
	--******************************************************************************************************************************--
	--******************************************************************************************************************************--

	DECLARE @dFechaRevision 	DATETIME	

	SET @dFechaRevision = @fechaproceso 

     --> Creo Tabla temporal con informacion 
	SELECT DISTINCT 
		A.CodigoCurva 			   	   AS cCurva
	,	cacodmon1	      			   AS cMoneda	
	,	CONVERT(FLOAT,0 )      			   AS vTasa
	,	CONVERT(FLOAT,0 )      			   AS vTasaMenor
	,	CONVERT(FLOAT,0 )      			   AS vTasaMayor
	,	CONVERT(INT,0 )      		   AS iPlazoMenor
	,	CONVERT(INT,0 )      		   AS iPlazoMayor
	,	DATEDIFF(DAY,@dFechaRevision,cafecEfectiva) AS iPlazo
	,	'N'					   AS sDirection
	INTO	#tmpCurvas2
	FROM	BACFWDSUDA.DBO.MFCA	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
					ON	modulo		= 'BFW'
					AND	TipoTasa	= 'N'
					AND	producto	= case when cacodpos1 = 14 then 1 else cacodpos1 end 
					AND	moneda		= cacodmon1
	WHERE	cacodpos1	NOT IN (2,10,11,12)

	UNION 

	SELECT	A.CodigoCurva
	,	cacodmon2
	,	0
	,	0
	,	0
	,	0
	,	0
	,	DATEDIFF(DAY, @dFechaRevision, cafecEfectiva) , 'N'
	FROM	BACFWDSUDA.DBO.MFCA	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
					ON	modulo		= 'BFW'
					AND	TipoTasa	= 'N'
					AND	producto	= case when cacodpos1 = 14 then 1 else cacodpos1 end  
					AND	moneda		= cacodmon2
	WHERE	cacodpos1	NOT IN (2,10,11,12)

	UNION 

	SELECT  A.CodigoCurva 			   	   AS cCurva
	,	cacodmon1	      			   AS cMoneda	
	,	CONVERT(FLOAT,0 )      			   AS vTasa
	,	CONVERT(FLOAT,0 )      			   AS vTasaMenor
	,	CONVERT(FLOAT,0 )      			   AS vTasaMayor
	,	CONVERT(INT,0 )      		   AS iPlazoMenor
	,	CONVERT(INT,0 )      		   AS iPlazoMayor
	,	DATEDIFF(DAY, @dFechaRevision, Ctf_Fecha_Vencimiento) AS iPlazo
	,	'N'					   AS sDirection
	FROM	TBL_CARTERA_FLUJOS	WITH (NOLOCK)
	,	BACFWDSUDA.DBO.MFCA	WITH (NOLOCK)	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
							ON	modulo		= 'BFW'
							AND	TipoTasa	= 'N'
							AND	producto	= CASE WHEN cacodpos1 = 13 THEN 3 ELSE cacodpos1 END
							AND	moneda		= cacodmon1
	WHERE	cacodpos1	= 13
	AND	canumoper	= Ctf_Numero_OPeracion

	UNION 

	SELECT	A.CodigoCurva
	,	cacodmon2
	,	0
	,	0
	,	0
	,	0
	,	0
	,	DATEDIFF(DAY, @dFechaRevision, Ctf_Fecha_Vencimiento) 
	,	'N'
	FROM	TBL_CARTERA_FLUJOS	WITH (NOLOCK)
	,	BACFWDSUDA.DBO.MFCA	WITH (NOLOCK)  
					INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
					ON	modulo		= 'BFW'
					AND	TipoTasa	= 'N'
					AND	producto	= CASE WHEN cacodpos1 = 13 THEN 3 ELSE cacodpos1 END 
					AND	moneda		= cacodmon2
	WHERE	cacodpos1	= 13
	AND	canumoper	= Ctf_Numero_OPeracion

        -- 5522 Forward a Observado, se agrega para los plazos de la fecha starting
	UNION 

	SELECT	A.CodigoCurva
        ,       CaCodMon1                   --	,	cacodmon2    MAP Contingencia        
	,	0
	,	0
	,	0
	,	0
	,	0
	,	DATEDIFF(DAY, @dFechaRevision, CaFechaFijacionStarting ) , 'N'  
	FROM	BACFWDSUDA.DBO.MFCA	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
					ON	modulo		= 'BFW'
					AND	TipoTasa	= 'N'
					AND	producto	= case when cacodpos1 = 14 then 1 else cacodpos1 end      
					AND	moneda		= cacodmon1
	WHERE	cacodpos1	 = (14)

        UNION

	SELECT	A.CodigoCurva
	,	cacodmon2
	,	0
	,	0
	,	0
	,	0
	,	0
	,	DATEDIFF(DAY, @dFechaRevision, CaFechaFijacionStarting ) , 'N'  
	FROM	BACFWDSUDA.DBO.MFCA	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
					ON	modulo		= 'BFW'
					AND	TipoTasa	= 'N'
					AND	producto	= case when cacodpos1 = 14 then 1 else cacodpos1 end 
					AND	moneda		= cacodmon2
	WHERE	cacodpos1	 = (14)
        -- 5522 Forward a Observado, se agrega para los plazos de la fecha starting

	CREATE NONCLUSTERED INDEX TMPCURVAS2_001 ON #TMPCURVAS2 
	(	cCurva
	,	iPlazo
	)

    --> Actualizo Datos 
	UPDATE	#tmpCurvas2 
	SET	vTasa		= ISNULL(valorbid,0)
	,	vTasaMenor	= ISNULL(valorbid,0)
	,	vTasaMayor	= ISNULL(valorbid,0)
	,	iPlazoMenor	= iPlazo
	,	iPlazoMayor	= iPlazo
	FROM #tmpCurvas2	LEFT JOIN BACPARAMSUDA.DBO.CURVAS B with(nolock)
				ON	B.FechaGeneracion  = @dFechaRevision
				AND	B.CodigoCurva      = cCurva
				AND	dias		   = iplazo

	UPDATE  #tmpCurvas2 
	SET	iPlazoMenor	= ISNULL((SELECT MAX(dias) 	
					FROM	BacParamSuda.dbo.CURVAS B WITH(NOLOCK)
					WHERE	B.FechaGeneracion	= @dFechaRevision
					AND	CodigoCurva		= cCurva
					AND	dias			< iplazo),0)
	,	iPlazoMayor	= ISNULL((SELECT MIN(dias) 
					FROM	 BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
					WHERE	B.FechaGeneracion	= @dFechaRevision
					AND	CodigoCurva		= cCurva
					AND	dias			> iplazo),0)
	FROM	#tmpCurvas2 
	WHERE	vTasa	= 0

	UPDATE	#tmpCurvas2 
	SET	iPlazoMenor	= #tmpCurvas2.iPlazoMayor
	,	iPlazoMayor	= (SELECT MIN(dias) 
				FROM	BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
				WHERE	B.FechaGeneracion	= @dFechaRevision 
				AND	CodigoCurva		= cCurva
				AND	Dias			> #tmpCurvas2.iPlazoMayor)
	,	sDirection	= 'I'
	FROM	#tmpCurvas2	
	WHERE	vTasa		= 0
	AND	iPlazoMenor	= 0

	UPDATE #tmpCurvas2 
	SET	iPlazoMayor = #tmpCurvas2.iPlazoMenor
	,	iPlazoMenor	= (SELECT MAX(dias) 
				FROM BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
				WHERE B.FechaGeneracion	= @dFechaRevision
				AND CodigoCurva		= cCurva
				AND Dias		< #tmpCurvas2.iPlazoMenor)
	,       sDirection	= 'S'
	FROM	#tmpCurvas2	
	WHERE	vTasa		= 0
	AND	iPlazoMayor	= 0 
	
	UPDATE	#tmpCurvas2 
	SET	vTasaMayor	= ISNULL(x.valorbid,0)
	,	vTasaMenor	= ISNULL(b.valorbid,0)
	,	sDirection	= 'N'
	FROM #tmpCurvas2	INNER JOIN BacParamSuda.dbo.CURVAS B WITH(NOLOCK)
					ON b.fechageneracion  = @dFechaRevision
					AND b.codigocurva      = cCurva
					AND dias=iplazomenor
				INNER JOIN BacParamSuda.dbo.CURVAS x WITH(NOLOCK)
					ON x.fechageneracion  = @dFechaRevision
					AND x.codigocurva      = cCurva
					AND x.dias=iplazomayor
	WHERE	vTasa	= 0 
		
	UPDATE	#tmpCurvas2 
	SET	vTasa	= vTasaMenor + CASE	WHEN sDirection ='N' THEN ((iPlazo-iplazoMenor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
						WHEN sDirection ='I' THEN ((iPlazoMenor-iPlazo) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) * - 1 
						WHEN sDirection ='S' THEN ((iPlazo-iPlazoMayor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
				       END
    	 WHERE	vTasa	= 0

	--******************************************************************************************************************************--
	--******************************************************************************************************************************--
	--******************************************************************************************************************************--

	UPDATE	#tmpCartera
	SET	TasaCurvaPrincipal  = vTasa
	FROM	#tmpCartera
	,	#tmpCurvas2
	WHERE	CurvaPrincipal		= cCurva
	AND	Term			= iPlazo
		
	UPDATE	#tmpCartera
	SET	TasaCurvaSecundaria = vTasa
	FROM	#tmpCartera
	,	#tmpCurvas2
	WHERE	CurvaSecundaria		= cCurva
	AND	Term			= iPlazo

	--
	UPDATE	#tmpCartera
	SET	TasaCurvaPrincipal_Col  = vTasa
	FROM	#tmpCartera
	,	    #tmpCurvas2
	WHERE	CurvaColPric		= cCurva
	AND	    Term			= iPlazo
		
	UPDATE	#tmpCartera
	SET	TasaCurvaSecundaria_Col = vTasa
	FROM	#tmpCartera
	,	#tmpCurvas2
	WHERE	CurvaColSec		= cCurva
	AND	Term			= iPlazo
	--
        -- 5522 Inicio Bloque Forward a Observado
	UPDATE	#tmpCartera
	SET	TasaCurvaPrincipalFijTipCam  = vTasa
	FROM	#tmpCartera
	,	#tmpCurvas2
	WHERE	CurvaPrincipal		= cCurva
	AND	FijTipCam               = iPlazo	

	UPDATE	#tmpCartera
	SET	TasaCurvaSecundariaFijTipCam  = vTasa
	FROM	#tmpCartera
	,	#tmpCurvas2
	WHERE	CurvaSecundaria 	= cCurva
	AND	FijTipCam               = iPlazo
        -- 5522 Fin Bloque Forward a Observado

	UPDATE	#tmpCartera
	SET	wfPrincipal	= CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaPrincipal * 0.01, Term2 / @Base )
                                          ELSE (1.0 + TasaCurvaPrincipal * 0.01 * Term / @Base )
				  END
	,	wfSecundaria	= CASE WHEN MonedaPrincipal = 998 THEN POWER(1.0 + TasaCurvaSecundaria * 0.01, Term2 / @Base )
                                                                  ELSE (1.0 + TasaCurvaSecundaria * 0.01 * Term / @Base )
                                  END
        ,	wf		= (1.0 + TasaCurvaSecundaria * 0.01 * Term / @Base)

        -- 5522 Inicio Bloque Forward a Observado
	,	wfPrincipalFijTipCam          = CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaPrincipalFijTipCam * 0.01, FijTipCam2 / @Base )
                                                                   ELSE (1.0 + TasaCurvaPrincipalFijTipCam  * 0.01 * FijTipCam / @Base )
				                END  
	,	wfSecundariaFijTipCam         = CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaSecundariaFijTipCam * 0.01, FijTipCam2 / @Base )
                                                                   ELSE (1.0 + TasaCurvaSecundariaFijTipCam  * 0.01 * FijTipCam / @Base )
				                END
        -- 5522 Fin Bloque Forward a Observado
    , wfPrincipalCol = CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaPrincipal_Col * 0.01, Term2 / @Base )
                                          ELSE (1.0 + TasaCurvaPrincipal_Col * 0.01 * Term / @Base )
				      END

   , wfSecundariaCol = CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaSecundaria_Col * 0.01, Term2 / @Base )
                                          ELSE (1.0 + TasaCurvaSecundaria_Col * 0.01 * Term / @Base )
				      END

	--*************************************************
	--********** Calculo del Precio Teorico **********  CVILLEGAS: Modificar comentario por favor aunque
	--************************************************* se comentario
		
	UPDATE	#tmpCartera
	SET	PrecioTeorico = ValorMoneda * (wfSecundaria / wfPrincipal)

        -- 5522 Inicio Bloque Forward a Observado 
        --**********************************************************
        --********** Calculo del Precio Teorico          **********
        --********** Calculo del Precio de Contrato      **********
        --********** Calculo del Precio de Contrato Delta **********
        --**********************************************************
	UPDATE	#tmpCartera   
        SET     PrecioTeoricoDelta   = ( ValorMoneda + 0.01 ) * (wfSecundaria / wfPrincipal)     
              , PrecioForwardDelta   = case when FijTipCam >= 0 then -- Condicion de 'Aún no Fija a Observado'
                                          ( ValorMoneda + 0.01 ) * wfSecundariaFijTipCam / wfPrincipalFijTipCam + Puntos  
                                       else PrecioForwardDelta end
              , PrecioForward        = case when FijTipCam >= 0 and fechaStarting > @FechaProceso -- PRD20732 -- Forward a Observado sin fijar CaTipCam
			                            then -- Condicion de 'Aún no Fija a Observado'
                                          ( ValorMoneda ) * wfSecundariaFijTipCam / wfPrincipalFijTipCam + Puntos
                                       else PrecioForward end 
           where CodigoPosicion = 14 
        -- 5522 Fin Bloque Forward a Observado 



	UPDATE	#tmpCartera
	SET	MTM = (CASE WHEN TipoOperacion = 'C' THEN 1.0 ELSE -1.0 END) * (PrecioTeorico - PrecioForward) * MontoPrincipal / wf 
			* (CASE WHEN MonedaPrincipal = 13 AND MonedaSecundaria = 998 THEN @UF ELSE 1.0 END)
        -- 5522 Inicio Bloque Forward a Observado
        ,       MTMDelta = (CASE WHEN TipoOperacion = 'C' THEN 1.0 ELSE -1.0 END) * (PrecioTeoricoDelta - PrecioForwardDelta) * MontoPrincipal / wf 
			* (CASE WHEN MonedaPrincipal = 13 AND MonedaSecundaria = 998 THEN @UF ELSE 1.0 END)          
        ,       MontoSecundario = case when CodigoPosicion = 14 and FijTipCam >= 0 -- Forward a Observado sin fijar CaTipCam
                                       then round( PrecioForward * MontoPrincipal , 0 )  
                                       else MontoSecundario end
        -- 5522 Fin    Bloque Forward a Observado
	,	ValorRazonableActivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioTeorico ELSE PrecioForward END) * MontoPrincipal / wf 
			* (CASE WHEN MonedaPrincipal = 13 AND MonedaSecundaria = 998 THEN @UF ELSE 1.0 END)
	,	ValorRazonablePasivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioForward ELSE PrecioTeorico END) * MontoPrincipal / wf 	
			* (CASE WHEN MonedaPrincipal = 13 AND MonedaSecundaria = 998 THEN @UF ELSE 1.0 END)
    ,   ValorRazonableActivoCol = ( Case when TipoOperacion = 'C' then MontoPrincipal / wfPrincipalCol 
	                                                            * ( case when MonedaPrincipal = 13 then @DOC
																         when MonedaPrincipal = 998 then @UF
																		 else 1.0 end )
	                                 else MontoSecundario / wfSecundariaCol 
										                        * ( case when MonedaSecundaria = 998 then @UF
																		 else 1.0 end )
									 end )
									 
    ,   ValorRazonablePasivoCol = ( Case when TipoOperacion = 'V' then MontoPrincipal / wfPrincipalCol 
	                                                            * ( case when MonedaPrincipal = 13 then @DOC
																         when MonedaPrincipal = 998 then @UF
																		 else 1.0 end )
	                                 else MontoSecundario / wfSecundariaCol 
										                        * ( case when MonedaSecundaria = 998 then @UF
																		 else 1.0 end )
									 end )                           


	UPDATE	#tmpCartera


	SET	MTM = ROUND( MTM, 0 )
       , Delta = ( MTMDelta - MTM ) / 0.01  -- 5522 Forward a Observado
	   , MTM_Col = ValorRazonableActivoCol - ValorRazonablePasivoCol

	--***********************************************
	--***********************************************
	--***********************************************

	UPDATE dbo.MFCA  	
	SET	fVal_Obtenido 			= TMP.PrecioTeorico
	,	fRes_Obtenido			= Case when TMP.Moneda_Colateral = 'USD' then TMP.MTM_Col else  TMP.MTM end

	-- Campo usado solo por los BFT
	-- Se usará para registrar la tasa
	-- utilizada.
	,	CaTasaSinteticaM1		= TMP.TasaCurvaPrincipal_Col
	,	CaTasaSinteticaM2		= TMP.TasaCurvaSecundaria_Col

--	,	CaTasaSinteticaM1		= @CaTasaSinteticaM1
--	,	CaTasaSinteticaM2		= @CaTasaSinteticaM2
--	,	CaPrecioSpotVentaM1		= @CaPrecioSpotVentaM1
--	,	CaPrecioSpotVentaM2		= @CaPrecioSpotVentaM2
--	,	CaPrecioSpotCompraM1		= @CaPrecioSpotCompraM1
--	,	CaPrecioSpotCompraM2		= @CaPrecioSpotCompraM2
--	,	CaFecEfectiva			= @dFecEfectiva		-- SE ACTUALIZA EN EL NUEVO PROCESO DE DEVENGAMIENTO
	,	ValorRazonableActivo            = Case when TMP.Moneda_Colateral = 'USD' then TMP.ValorRazonableActivoCol else TMP.ValorRazonableActivo end
	,	ValorRazonablePasivo            = Case when TMP.Moneda_Colateral = 'USD' then TMP.ValorRazonablePasivoCol else TMP.ValorRazonablePasivo end 
	,	catasadolar			= TMP.TasaCurvaPrincipal	-- @nTasa1
	,	catasaufclp			= TMP.TasaCurvaSecundaria	-- @nTasa2
	,	caOrgCurvaMon			= 'MC'
	,	caOrgCurvaCnv			= 'MC'
        -- 5522 Inicio Bloque Forward a Observado
        , CatasaPriPzoFijObs                    = TMP.TasaCurvaPrincipalFijTipCam  -- select CatasaPriPzoFijObs, cadelta, CatasaSecPzoFijObs , * from dbo.mfca
        , CatasaSecPzoFijObs                    = TMP.TasaCurvaSecundariaFijTipCam
        , cadelta                               = case when CaFechaStarting <= @fechaproceso then 0 else  TMP.Delta end
        , CaTipCam                              = TMP.PrecioForward             -- con decimales para 'ver' que fue calculado
        , CaMtoMon2                             = case when CodigoPosicion = 14 and FijTipCam >= 0 and fechaStarting > @FechaProceso -- PRD20732 -- Forward a Observado sin fijar CaTipCam
                                                       then MontoSecundario   
                                                       else CaMtoMon2 end
        , CaEquMon2                   = case when CodigoPosicion = 14 and FijTipCam >= 0 and fechaStarting > @FechaProceso -- PRD20732 -- Forward a Observado sin fijar CaTipCam
                                                       then MontoSecundario   
                                                       else CaMtoMon2 end
		-- POR HACER: buscar campos donde guardar las curvas colateral
        -- 5522 Fin Bloque Forward a Observado
	FROM	#tmpCartera	TMP
	WHERE	canumoper               	= NumeroOperacion
	AND	ID				= 0

--	SELECT * FROM #tmpCartera WHERE CodigoPosicion = 13 and ID > 0
	

	UPDATE	TBL_CARTERA_FLUJOS						
	SET	Ctf_Valor_Razonable_Activo	= TMP.ValorRazonableActivo
	,	Ctf_Valor_Razonable_Pasivo	= TMP.ValorRazonablePasivo
	,	Ctf_Valor_Razonable		= TMP.ValorRazonableActivo - TMP.ValorRazonablePasivo
--	,	Ctf_Articulo84			= @nmtodif
	,	Ctf_Precio_Proyectado		= TMP.PrecioTeorico
	FROM	#tmpCartera	TMP
	WHERE	TMP.CodigoPosicion		= 13
	AND	Ctf_Numero_OPeracion		= TMP.NumeroOperacion
	AND	Ctf_Correlativo			= ID


	-- CALCULO PARA LOS VENCIMIENTOS.
	UPDATE	dbo.MFCA			
	SET	camtomon2	= ISNULL((SELECT SUM(Ctf_Monto_Principal) FROM TBL_CARTERA_FLUJOS WHERE	Ctf_Numero_OPeracion = caNumOper AND Ctf_Fecha_Vencimiento > @FechaProceso),0) * caprecal
	,	caequmon2	= ISNULL((SELECT SUM(Ctf_Monto_Principal) FROM TBL_CARTERA_FLUJOS WHERE	Ctf_Numero_OPeracion = caNumOper AND Ctf_Fecha_Vencimiento > @FechaProceso),0) * caprecal
	,	camtomon2fin	= ISNULL((SELECT SUM(Ctf_Monto_Principal) FROM TBL_CARTERA_FLUJOS WHERE	Ctf_Numero_OPeracion = caNumOper AND Ctf_Fecha_Vencimiento > @FechaProceso),0) * caprecal
	,	camtomon1	= ISNULL((SELECT SUM(Ctf_Monto_Principal) FROM TBL_CARTERA_FLUJOS WHERE	Ctf_Numero_OPeracion = caNumOper AND Ctf_Fecha_Vencimiento > @FechaProceso),0)
	WHERE	cacodpos1	= 13
	AND	cafecvcto	= @FechaProceso

	UPDATE	dbo.MFCA
	SET	fRes_Obtenido		= (SELECT SUM(Ctf_Valor_Razonable_Activo) - SUM(Ctf_Valor_Razonable_Pasivo) FROM TBL_CARTERA_FLUJOS WHERE Ctf_Numero_Operacion = canumoper AND Ctf_Fecha_Vencimiento > @FechaProceso)
	,	ValorRazonableActivo	= (SELECT SUM(Ctf_Valor_Razonable_Activo) FROM TBL_CARTERA_FLUJOS WHERE Ctf_Numero_OPeracion = canumoper AND Ctf_Fecha_Vencimiento > @FechaProceso)
	,	ValorRazonablePasivo	= (SELECT SUM(Ctf_Valor_Razonable_Pasivo) FROM TBL_CARTERA_FLUJOS WHERE Ctf_Numero_OPeracion = canumoper AND Ctf_Fecha_Vencimiento > @FechaProceso)
	FROM	dbo.MFCA		
	WHERE	cacodpos1	= 13

/*
	SELECT	CodigoPosicion
	,	NumeroOperacion
	,	ValorRazonableNet 
	,	mtm
	,	* 
	FROM #tmpCartera
--	WHERE (ValorRazonableNet - mtm) <> 0
	ORDER 
	BY    CodigoPosicion
	,     NumeroOperacion

	DROP TABLE #tmpCartera
	DROP TABLE #tmpCurvas
	DROP TABLE #tmpCurvasForward
	DROP TABLE #tmpListCurva
	DROP TABLE #tmpCurvas2
*/
	SET NOCOUNT OFF

END
GO

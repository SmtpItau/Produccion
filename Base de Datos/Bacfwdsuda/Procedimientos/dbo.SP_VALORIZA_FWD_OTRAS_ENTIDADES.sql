USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_FWD_OTRAS_ENTIDADES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_VALORIZA_FWD_OTRAS_ENTIDADES]
	(	@Entidad	CHAR(10)
	,	@FechaProceso	DATETIME	
	)
AS
BEGIN
--  SP_VALORIZA_FWD_OTRAS_ENTIDADES 'FFMM', '20101115'

	SET NOCOUNT ON

	DECLARE @UF		FLOAT
	,	@DOC		FLOAT
	,	@DO		FLOAT
	,	@EURO		FLOAT
	,	@Base		FLOAT
	,	@UsaCurvas	CHAR(1)

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

	SELECT  CodigoCurva
	,	Producto
	,	Moneda
	,	CurAlter
	,	IsValid    = 0
	INTO    #TMPCURVASFORWARD_OTROS
	FROM    BACPARAMSUDA.DBO.CURVAS_PRODUCTO WITH(NOLOCK)
	WHERE   modulo     = 'BFW'
	AND     TipoTasa   = 'N'

	CREATE NONCLUSTERED INDEX TMPCURVASFORWARD_OTROS_001 ON #TMPCURVASFORWARD_OTROS
	(	CodigoCurva
	,	Producto
	,	Moneda
	)

	SELECT	DISTINCT 
		CodigoCurva
	INTO    #TMPLISTCURVA_OTROS
	FROM    #TMPCURVASFORWARD_OTROS

	/**************************************************************************************************************/
	/******************************************** CARTERA A VALORIZAR *********************************************/
	/**************************************************************************************************************/

	SELECT	'Entidad'		= Vfo_Entidad
	,	'NumeroOperacion'	= Vfo_Id
	,	'ID'			= 0
	,	'CodigoPosicion'	= Vfo_Producto		--cacodpos1
	,	'TipoOperacion'		= Vfo_Tipo_Operacion	--catipoper
	,	'FechaVencimiento'	= Vfo_Fecha_Vcto	--cafecvcto
	,	'FechaEfectiva'		= Vfo_Fecha_Efectiva	--cafecEfectiva		
	,	'MonedaPrincipal'	= CONVERT(FLOAT,Vfo_Moneda_Nocional)	--cacodmon1
	,	'MonedaSecundaria'	= Vfo_Moneda_Subyacente	--cacodmon2
	,	'MontoPrincipal'	= Vfo_Monto_Nocional	--camtomon1
	,	'PrecioForward'		= Vfo_Precio_Fwd	--catipcam		
	,	'PrecioTeorico'		= Vfo_PrecioTeorico	-- CONVERT( FLOAT, 0 )
	,	'MontoSecundario'	= Vfo_Monto_Subyacente	--camtomon2
	,	'Term'			= DATEDIFF( DAY, @fechaproceso, Vfo_Fecha_Efectiva )			--     DATEDIFF(DAY, @fechaproceso, cafecEfectiva )
	,	'Term2'			= CAST(DATEDIFF(DAY, @fechaproceso,Vfo_Fecha_Efectiva ) AS FLOAT)	--CAST(DATEDIFF(DAY, @fechaproceso, cafecEfectiva ) AS FLOAT)
	,	'CurvaPrincipal'	= C1.CodigoCurva
	,	'TasaCurvaPrincipal'	= CONVERT( FLOAT, 0. )
	,	'wfPrincipal'		= CONVERT( FLOAT, 0. )
	,	'CurvaSecundaria'	= C2.CodigoCurva
	,	'TasaCurvaSecundaria'	= CONVERT( FLOAT, 0. )
	,	'wfSecundaria'		= CONVERT( FLOAT, 0. )
	,	'ValorMoneda'		= CASE	WHEN Vfo_Moneda_Nocional =  13 AND Vfo_Moneda_Subyacente = 999 THEN @DOC
						WHEN Vfo_Moneda_Nocional =  13 AND Vfo_Moneda_Subyacente = 998 THEN @DOC / @UF
						WHEN Vfo_Moneda_Nocional = 998 AND Vfo_Moneda_Subyacente = 999 THEN @UF
						WHEN Vfo_Moneda_Nocional = 142 AND Vfo_Moneda_Subyacente = 999 THEN @EURO   END
	,	'wf'			= CONVERT( FLOAT, 0. )
	,	'MTM'			= Vfo_MarkToMarket	--CONVERT( FLOAT, 0 )
	,	'ValorRazonableActivo'	= CONVERT(FLOAT,0.)	--ValorRazonableActivo
	,	'ValorRazonablePasivo'	= CONVERT(FLOAT,0.)	--ValorRazonablePasivo
	,	'CaTasaSinteticaM1'	= CONVERT(FLOAT,0.)	--CaTasaSinteticaM1
	,	'CaTasaSinteticaM2'	= CONVERT(FLOAT,0.)	--CaTasaSinteticaM2
	INTO	#TMPValorizaCartera_Otros
	FROM	TBL_VALORIZA_FWD_OTRAS_ENTIDADES	INNER JOIN #TMPCURVASFORWARD_OTROS C1 
							ON  Vfo_Producto	= c1.Producto 
							AND Vfo_Moneda_Nocional	= c1.moneda

							INNER JOIN #TMPCURVASFORWARD_OTROS C2 
							ON  Vfo_Producto		= c2.Producto 
							AND Vfo_Moneda_Subyacente	= c2.moneda
	WHERE	Vfo_Entidad	= @Entidad


	SELECT	@UsaCurvas	= CASE WHEN (SELECT COUNT(1) FROM TBL_VALORIZA_FWD_OTRAS_ENTIDADES 
								WHERE	Vfo_Entidad = @Entidad 
								AND	Vfo_PrecioTeorico <> 0) > 0 THEN 'N' ELSE 'S' END

	IF @UsaCurvas = 'S' BEGIN	-- SI NO FUERON CARGADOS LOS PRECIOS DESDE RISK AMERICA

		SELECT  'Curva'  = B.CodigoCurva
		,	'Plazo'  = B.Dias
		,	'Tasa'   = B.ValorBid
		INTO	#tmpCurvas
		FROM	BACPARAMSUDA.DBO.CURVAS B with(nolock)
		,	#TMPLISTCURVA_OTROS A
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
		,	Vfo_Moneda_Nocional	/*cacodmon1*/	   AS cMoneda	
		,	CONVERT(FLOAT,0 )      			   AS vTasa
		,	CONVERT(FLOAT,0 )      			   AS vTasaMenor
		,	CONVERT(FLOAT,0 )      			   AS vTasaMayor
		,	CONVERT(INT,0 )      		   AS iPlazoMenor
		,	CONVERT(INT,0 )      		   AS iPlazoMayor
		,	DATEDIFF(DAY,@dFechaRevision,Vfo_Fecha_Efectiva /*cafecEfectiva*/) AS iPlazo
		,	'N'					   AS sDirection
		INTO	#tmpCurvas2_OTROS
		FROM	TBL_VALORIZA_FWD_OTRAS_ENTIDADES	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
							ON	modulo		= 'BFW'
							AND	TipoTasa	= 'N'
							AND	producto	= Vfo_Producto		--cacodpos1 
							AND	moneda		= Vfo_Moneda_Nocional	--cacodmon1
		WHERE	Vfo_Entidad	= @Entidad

		UNION 

		SELECT	A.CodigoCurva
		,	Vfo_Moneda_Subyacente	--cacodmon2 
		,	0
		,	0
		,	0
		,	0
		,	0
		,	DATEDIFF(DAY, @dFechaRevision, Vfo_Fecha_Efectiva /*cafecEfectiva*/) 
		,	'N'
		FROM	TBL_VALORIZA_FWD_OTRAS_ENTIDADES	INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK)
							ON	modulo		= 'BFW'
							AND	TipoTasa	= 'N'
							AND	producto	= Vfo_Producto		--cacodpos1  
							AND	moneda		= Vfo_Moneda_Subyacente	--cacodmon2
		WHERE	Vfo_Entidad	= @Entidad


		CREATE NONCLUSTERED INDEX TMPCURVAS2_OTROS_001 ON #tmpCurvas2_OTROS 
		(	cCurva
		,	iPlazo
		)

	    --> Actualizo Datos 
		UPDATE	#tmpCurvas2_OTROS 
		SET	vTasa		= ISNULL(valorbid,0)
		,	vTasaMenor	= ISNULL(valorbid,0)
		,	vTasaMayor	= ISNULL(valorbid,0)
		,	iPlazoMenor	= iPlazo
		,	iPlazoMayor	= iPlazo
		FROM #tmpCurvas2_OTROS	LEFT JOIN BACPARAMSUDA.DBO.CURVAS B with(nolock)
						ON	B.FechaGeneracion  = @dFechaRevision
						AND	B.CodigoCurva      = cCurva
						AND	dias		   = iplazo


		UPDATE  #tmpCurvas2_OTROS 
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
		FROM	#tmpCurvas2_OTROS 
		WHERE	vTasa	= 0	

		UPDATE	#tmpCurvas2_OTROS 
		SET	iPlazoMenor	= #tmpCurvas2_OTROS.iPlazoMayor
		,	iPlazoMayor	= (SELECT MIN(dias) 
					FROM	BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
					WHERE	B.FechaGeneracion	= @dFechaRevision 
					AND	CodigoCurva		= cCurva
					AND	Dias			> #tmpCurvas2_OTROS.iPlazoMayor)
		,	sDirection	= 'I'
		FROM	#tmpCurvas2_OTROS	
		WHERE	vTasa		= 0
		AND	iPlazoMenor	= 0	

		UPDATE #tmpCurvas2_OTROS 
		SET	iPlazoMayor = #tmpCurvas2_OTROS.iPlazoMenor
		,	iPlazoMenor	= (SELECT MAX(dias) 
						FROM BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
						WHERE B.FechaGeneracion	= @dFechaRevision
						AND CodigoCurva		= cCurva
						AND Dias		< #tmpCurvas2_OTROS.iPlazoMenor)
		,       sDirection	= 'S'
		FROM	#tmpCurvas2_OTROS	
		WHERE	vTasa		= 0
		AND	iPlazoMayor	= 0 
		
		UPDATE	#tmpCurvas2_OTROS 	
		SET	vTasaMayor	= ISNULL(x.valorbid,0)
		,	vTasaMenor	= ISNULL(b.valorbid,0)
		,	sDirection	= 'N'
		FROM #tmpCurvas2_OTROS	INNER JOIN BacParamSuda.dbo.CURVAS B WITH(NOLOCK)
						ON b.fechageneracion  = @dFechaRevision
						AND b.codigocurva      = cCurva
						AND dias=iplazomenor
					INNER JOIN BacParamSuda.dbo.CURVAS x WITH(NOLOCK)
						ON x.fechageneracion  = @dFechaRevision
						AND x.codigocurva      = cCurva
						AND x.dias=iplazomayor
		WHERE	vTasa	= 0 

	
		UPDATE	#tmpCurvas2_OTROS 
		SET	vTasa	= vTasaMenor + CASE	WHEN sDirection ='N' THEN ((iPlazo-iplazoMenor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
							WHEN sDirection ='I' THEN ((iPlazoMenor-iPlazo) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) * - 1 
							WHEN sDirection ='S' THEN ((iPlazo-iPlazoMayor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
					       END
		WHERE	vTasa	= 0

		--******************************************************************************************************************************--
		--******************************************************************************************************************************--
		--******************************************************************************************************************************--	

		UPDATE	#TMPValorizaCartera_Otros
		SET	TasaCurvaPrincipal  = vTasa
		FROM	#TMPValorizaCartera_Otros
		,	#tmpCurvas2_OTROS
		WHERE	CurvaPrincipal		= cCurva
		AND	Term			= iPlazo

	
		UPDATE	#TMPValorizaCartera_Otros
		SET	TasaCurvaSecundaria = vTasa
		FROM	#TMPValorizaCartera_Otros
		,	#tmpCurvas2_OTROS
		WHERE	CurvaSecundaria		= cCurva
		AND	Term			= iPlazo

		UPDATE	#TMPValorizaCartera_Otros
		SET	wfPrincipal	= CASE WHEN MonedaPrincipal  = 998 THEN POWER(1.0 + TasaCurvaPrincipal * 0.01, Term2 / @Base )
						ELSE (1.0 + TasaCurvaPrincipal * 0.01 * Term / @Base )
					  END
		,	wfSecundaria	= CASE WHEN MonedaPrincipal = 998 THEN POWER(1.0 + TasaCurvaSecundaria * 0.01, Term2 / @Base )
						ELSE (1.0 + TasaCurvaSecundaria * 0.01 * Term / @Base )
					  END
		,	wf		= (1.0 + TasaCurvaSecundaria * 0.01 * Term / @Base)

		--*************************************************
		--********** Calculo del Precio Teorico **********  
		--************************************************* 

		UPDATE	#TMPValorizaCartera_Otros
		SET	PrecioTeorico = ValorMoneda * (wfSecundaria / wfPrincipal)

		--*************************************************
		--*********** Calculo de MARK TO MARKET ***********  
		--************************************************* 

		UPDATE	#TMPValorizaCartera_Otros
		SET	MTM = (CASE WHEN TipoOperacion = 'C' THEN 1.0 ELSE -1.0 END) * (PrecioTeorico - PrecioForward)      * MontoPrincipal / wf * 1.0
		,	ValorRazonableActivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioTeorico ELSE PrecioForward END) * MontoPrincipal / wf * 1.0
		,	ValorRazonablePasivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioForward ELSE PrecioTeorico END) * MontoPrincipal / wf * 1.0

	END 	-- USA CURVAS
	ELSE BEGIN

/*
		UPDATE	#TMPValorizaCartera_Otros
		SET	wfSecundaria	= ( MontoPrincipal * CASE WHEN TipoOperacion = 'C'	THEN (PrecioForward - PrecioTeorico)*  1.
																				ELSE (PrecioTeorico - PrecioForward)* -1. END) 
								/ CONVERT(FLOAT,(MTM * MontoPrincipal))
*/

		UPDATE	#TMPValorizaCartera_Otros
		SET	wfSecundaria	= ( MontoPrincipal	* CASE WHEN (PrecioTeorico - PrecioForward) = 0 THEN 1 ELSE (PrecioTeorico - PrecioForward) END 
												* CASE WHEN TipoOperacion = 'C'	THEN 1. ELSE -1. END) 
							/ CONVERT(FLOAT,(CASE WHEN MTM = 0 THEN 1 ELSE MTM END * MontoPrincipal))
	
		UPDATE	#TMPValorizaCartera_Otros
		SET	wf		= ((wfSecundaria - 1 ) * @Base / Term) * 100

		UPDATE	#TMPValorizaCartera_Otros
		SET	ValorRazonableActivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioTeorico ELSE PrecioForward END) * MontoPrincipal / ( 1. + wf * 0.01 * Term / @Base)
		,	ValorRazonablePasivo	= (CASE WHEN TipoOperacion = 'C' THEN PrecioForward ELSE PrecioTeorico END) * MontoPrincipal / ( 1. + wf * 0.01 * Term / @Base)
	END

--	UPDATE	#TMPValorizaCartera_Otros
--	SET	MTM = ROUND( MTM, 0 )

	--***********************************************
	--***********************************************
	--***********************************************

	UPDATE	TBL_VALORIZA_FWD_OTRAS_ENTIDADES
	SET	Vfo_PrecioTeorico		= PrecioTeorico
	,	Vfo_MarkToMarket		= MTM
	,	Vfo_ValorRazonableActivo	= ValorRazonableActivo
	,	Vfo_ValorRazonablePasivo	= ValorRazonablePasivo
	FROM	#TMPValorizaCartera_Otros	
	WHERE	Vfo_Entidad	= Entidad
	AND	Vfo_Id		= NumeroOperacion

	SET NOCOUNT OFF

END
GO

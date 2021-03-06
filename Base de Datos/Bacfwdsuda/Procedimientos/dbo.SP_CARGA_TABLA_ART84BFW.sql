USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_ART84BFW]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_ART84BFW]
AS  
BEGIN
	SET NOCOUNT ON

	DECLARE  @fecpro              DATETIME       

	SELECT	@fecpro           = acfecproc 
	FROM	MFAC

   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)
   SELECT vmfecha, vmcodigo, vmvalor
     INTO #TMP_VALOR_MONEDA_ART84
     FROM BacParamSuda..VALOR_MONEDA
    WHERE vmFecha    = @fecpro
      and vmcodigo   IN(995,997,998)

   INSERT INTO #TMP_VALOR_MONEDA_ART84
      SELECT @fecpro, 999, 1.0

   INSERT INTO #TMP_VALOR_MONEDA_ART84
      SELECT @fecpro, codigo_moneda , tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
      WHERE  fecha          = @fecpro
      AND    codigo_moneda  NOT IN(13,994,995,997,998,999)
      AND    tipo_cambio   <> 0.0

   INSERT INTO #TMP_VALOR_MONEDA_ART84
      SELECT @fecpro, 13, tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
      WHERE  fecha         = @fecpro
      AND    codigo_moneda = 994
   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)

   
	CREATE TABLE #ART84
	(	Numdocu       NUMERIC (10,0)                            -- 1
	,	Numoper       NUMERIC (10,0)                            -- 2
	,	Correla       NUMERIC (03,0)                            -- 3
	,	Modulo        CHAR    (03)                              -- 4 
	,	Fec_Proc      DATETIME                                  -- 5 
	,	RutDeudor     NUMERIC (09)                              -- 6
	,	Instrumento   CHAR    (20)                              -- 7
	,	Mascara       CHAR    (20)                              -- 8
	,	Nominal       NUMERIC (19,4)                            -- 9
	,	Fecha_compra  DATETIME                                  -- 10    
	,	Fecha_emi     DATETIME                                  -- 11
	,	Seriado       CHAR    (01)                              -- 12
	,	Codigo        NUMERIC (05)                              -- 13
	,	Tir           NUMERIC (19,4)                            -- 14
	,	Moneda        NUMERIC (05)                              -- 15
	,	Tipoper       CHAR    (03)                              -- 16
	,	Monto         NUMERIC (19,4) NULL DEFAULT (0)           -- 17 
	)

	INSERT	#ART84
	(	Numdocu       		-- 1
	,	Numoper       		-- 2
	,	Correla       		-- 3
	,	Modulo        		-- 4 
	,	Fec_Proc      		-- 5 
	,	RutDeudor     		-- 6
	,	Instrumento   		-- 7
	,	Mascara       		-- 8
	,	Nominal       		-- 9
	,	Fecha_compra  		-- 10    
	,	Fecha_emi     		-- 11
	,	Seriado       		-- 12
	,	Codigo        		-- 13
	,	Tir           		-- 14
	,	Moneda        		-- 15
	,	Tipoper       		-- 16
	,	Monto         		-- 17
	)
	SELECT	canumoper		-- 1
	,	canumoper		-- 2
	,	1			-- 3
	,	'BFW'			-- 4
	,	@fecpro			-- 5
	,	cacodigo		-- 6
	,	''			-- 7
	,	''			-- 8
	,	camtomon1		-- 9
	,	cafecha			-- 10
	,	fechaemision		-- 11
	,	''			-- 12
	,	0			-- 13
	,	catasaufclp		-- 14
	,	cacodmon1		-- 15
	,	catipoper		-- 16
	,	(fRes_Obtenido + ((camtomon1 * vmvalor) * ((CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Fvr_Factor1,0) ELSE Fvr_Factor2 END) / 100))) -- 17	
	FROM	MFCA
	,	#TMP_VALOR_MONEDA_ART84 --> VIEW_VALOR_MONEDA
	,	BACPAramSuda..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
	,	BACPARAMSUDA..TBL_FACTOR_VENCIMIENTO_RESIDUAL
	WHERE	cacodpos1		NOT IN (2,4,10)
	AND	fRes_Obtenido		>  0
	AND	vmcodigo			= cacodmon1 --CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
	AND	vmfecha				= @fecpro 
	AND	mncodmon			= cacodmon1
	AND	Acrp_CodigoClasificacion	= mnClasificaRiesgoPais
	AND	Fvr_IdSistema			= 'BFW'
	AND	Fvr_Producto			= cacodpos1
	AND	DATEDIFF(DAY, @fecpro, cafecvcto) BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta
	
	INSERT	#ART84
	(	Numdocu       		-- 1
	,	Numoper       		-- 2
	,	Correla       		-- 3
	,	Modulo        		-- 4 
	,	Fec_Proc      		-- 5 
	,	RutDeudor     		-- 6
	,	Instrumento   		-- 7
	,	Mascara       		-- 8
	,	Nominal       		-- 9
	,	Fecha_compra  		-- 10    
	,	Fecha_emi     		-- 11
	,	Seriado       		-- 12
	,	Codigo        		-- 13
	,	Tir           		-- 14
	,	Moneda        		-- 15
	,	Tipoper       		-- 16
	,	Monto         		-- 17
	)
	SELECT	canumoper		-- 1
	,	canumoper		-- 2
	,	1			-- 3
	,	'BFW'			-- 4
	,	@fecpro			-- 5
	,	cacodigo		-- 6
	,	''			-- 7
	,	''			-- 8
	,	camtomon1		-- 9
	,	cafecha			-- 10
	,	fechaemision		-- 11
	,	''			-- 12
	,	0			-- 13
	,	catasaufclp		-- 14
	,	cacodmon1		-- 15
	,	catipoper		-- 16
	,	(fRes_Obtenido + ((camtomon1 * vmvalor) * (ISNULL(Fvr_Factor1, 0) / 100))) -- 17	
	FROM	MFCA	LEFT JOIN #TMP_VALOR_MONEDA_ART84 --> VIEW_VALOR_MONEDA	
					ON	vmcodigo = cacodmon1 
					AND	vmfecha  = @fecpro 
			LEFT JOIN BACPARAMSUDA..TBL_FACTOR_VENCIMIENTO_RESIDUAL	
					ON	Fvr_IdSistema = 'BFW' 
					AND	Fvr_Producto  = cacodpos1 
					AND	DATEDIFF(DAY, @fecpro, cafecvcto) BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta
	WHERE	cacodpos1	= 10
	AND	fRes_Obtenido	>  0


        INSERT INTO BACTRADERSUDA..MARGEN_ARTICULO84
	SELECT * FROM	#ART84

END





GO

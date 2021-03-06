USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_ART84PCS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_ART84PCS]  
AS  
BEGIN
	SET NOCOUNT ON
        -- Por mientras ya que la valorizacion nueva no esta buena aún 
        -- Swap: Guardar Como
	DECLARE  @fecpro              DATETIME       

	SELECT	@fecpro           = fechaproc 
	FROM	SWAPGENERAL


   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)
   SELECT vmfecha, vmcodigo, vmvalor
     INTO #TMP_VALOR_MONEDA_ART84_SWAP
     FROM BacParamSuda..VALOR_MONEDA
    WHERE vmFecha    = @fecpro
      and vmcodigo   IN(995,997,998)

   INSERT INTO #TMP_VALOR_MONEDA_ART84_SWAP
      SELECT @fecpro, 999, 1.0

   INSERT INTO #TMP_VALOR_MONEDA_ART84_SWAP
      SELECT @fecpro, codigo_moneda , tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
      WHERE  fecha          = @fecpro
      AND    codigo_moneda  NOT IN(13,994,995,997,998,999)
      AND    tipo_cambio   <> 0.0

   INSERT INTO #TMP_VALOR_MONEDA_ART84_SWAP
      SELECT @fecpro, 13, tipo_cambio
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
      WHERE  fecha         = @fecpro
      AND    codigo_moneda = 994
   --> 06 Junio 2008 (Solicitado por Carlos Basterrica)

	CREATE TABLE #Art84
	(	Numdocu       NUMERIC (10,0)                            -- 1
	,	Numoper       NUMERIC (10,0)                            -- 2
	,	Correla       NUMERIC (03,0)                            -- 3
	,	Modulo        CHAR    (03)                              -- 4 
	,	Fec_Proc      DATETIME                                  -- 5 
	,	RutDeudor     NUMERIC (9)                               -- 6
	,	Instrumento   CHAR (20)                                 -- 7
	,	Mascara       CHAR (20)                                 -- 8
	,	Nominal       NUMERIC (19,4)                            -- 9
	,	Fecha_compra  DATETIME                                  -- 10    
	,	Fecha_emi     DATETIME                                  -- 11
	,	Seriado       CHAR (1)                                  -- 12
	,	Codigo        NUMERIC (5)                               -- 13
	,	Tir           NUMERIC (19,4)                            -- 14
	,	Moneda        NUMERIC (5)                               -- 15
	,	Tipoper       CHAR (3)                                  -- 16
	,	Monto         NUMERIC (19,4) NULL DEFAULT(0)            -- 17  
	)

	SELECT	DISTINCT 'Numope'	= numero_operacion		-- 1
	,	'Correla'		= 0				-- 2
	,	'Modulo'		= 'PCS'				-- 3
	,	'Fec_Proc'		= @fecpro			-- 4
	,	'rut_cliente'		= rut_cliente			-- 5
	,	'Instrumento'		= ' '				-- 6
	,	'Mascara'		= ' '				-- 7
	,	'Nominal'		= CASE tipo_flujo WHEN 1 THEN compra_capital ELSE venta_capital END	-- 8
	,	'fecha_Cierre'		= fecha_Cierre			-- 9
	,	'fecha_inicio'		= fecha_inicio			-- 10
	,	'Seriado'		= ' '				-- 11
	,	'Codigo'		= 0				-- 12
	,	'Tir'			= 0				-- 13
	,	'Moneda'		= CASE tipo_flujo WHEN 1 THEN Compra_moneda ELSE venta_moneda END	-- 14
	,	'tipo_operacion'	= Tipo_Swap			-- 15
	,	'Monto1'		= Valor_RazonableCLP		-- 16  
	,	'VIGENCIA_DIAS'		= DATEDIFF(DAY, @fecpro, fecha_termino)
	INTO	#TEMPCART_TMP
	FROM	CARTERA
	WHERE	Valor_RazonableCLP	> 0  -- Valor_RazonableCLP
            and Estado                 <> 'C'
   AND   Tipo_Flujo         = 1  --> Se informara Solamente la Pata Activa

        select          NumOpe
                  ,	Correla
                  ,	Modulo
                  ,	Fec_Proc
                  ,	rut_cliente
                  ,	Instrumento
                  ,	Mascara
                  ,	Nominal
                  ,	fecha_Cierre
                  ,	fecha_inicio
                  ,	Seriado
                  ,	Codigo
                  ,	Tir
                  ,	Moneda
                  ,	tipo_operacion
                  ,	Monto1
                  ,     'VIGENCIA_DIAS' = Max( VIGENCIA_DIAS )
         INTO  #TEMPCART
         FROM  #TEMPCART_TMP
         group by       NumOpe
                  ,	Correla
                  ,	Modulo
                  ,	Fec_Proc
     ,	rut_cliente
                  ,	Instrumento
                  ,	Mascara
                  ,	Nominal
                  ,	fecha_Cierre
                  ,	fecha_inicio
                  ,	Seriado
                  ,	Codigo
                  ,	Tir
                  ,	Moneda
                  ,	tipo_operacion
                  ,	Monto1

	UPDATE	#TEMPCART 
	SET	Monto1	= (Monto1 + ((Nominal * vmvalor) * (ISNULL(Fvr_Factor1,0) / 100))) 
--   	SET     Monto1  = (Monto1 + ( Nominal            * ( ISNULL(Fvr_Factor1,0) / 100)) ) 
	FROM	#TMP_VALOR_MONEDA_ART84_SWAP   --> VIEW_VALOR_MONEDA
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
	,	BACPARAMSUDA..TBL_FACTOR_VENCIMIENTO_RESIDUAL
	WHERE	Tipo_Operacion			NOT IN (2)		-- SWAP DE MONEDAS 
	AND	vmfecha				=  @fecpro
	AND	vmcodigo			=  moneda --> CASE WHEN moneda = 13 THEN 994 ELSE MONEDA END
	AND	mncodmon			=  moneda
	AND	Acrp_CodigoClasificacion	=  mnClasificaRiesgoPais
	AND	Fvr_IdSistema 			=  'PCS'
	AND	Fvr_Producto			=  Tipo_Operacion
	AND	Vigencia_Dias BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta


	UPDATE	#TEMPCART 
	SET	Monto1	= (Monto1 + ((Nominal * vmvalor) * ((CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Fvr_Factor1,0) ELSE Fvr_Factor2 END) / 100)))
--   	SET	Monto1	= (Monto1 + ((Nominal)           * ((CASE WHEN Acrp_CodigoGrupo = 1 THEN ISNULL(Fvr_Factor1,0) ELSE Fvr_Factor2 END) / 100)))
	FROM	#TMP_VALOR_MONEDA_ART84_SWAP   --> VIEW_VALOR_MONEDA
	,	BACPARAMSUDA..MONEDA
	,	BACPARAMSUDA..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS
	,	BACPARAMSUDA..TBL_FACTOR_VENCIMIENTO_RESIDUAL
	WHERE	Tipo_Operacion			= 2		-- SWAP DE MONEDAS 
	AND	vmfecha				=  @fecpro
	AND	vmcodigo			=  MONEDA --CASE WHEN MONEDA = 13 THEN 994 ELSE MONEDA END
	AND	mncodmon			=  moneda
	AND	Acrp_CodigoClasificacion	=  mnClasificaRiesgoPais
	AND	Fvr_IdSistema 			=  'PCS'
	AND	Fvr_Producto			=  Tipo_Operacion
	AND	Vigencia_Dias BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta

	INSERT	#ART84
	(	Numdocu				-- 1
	,	Numoper				-- 2
	,	Correla				-- 3
	,	Modulo				-- 4
	,	Fec_Proc			-- 5
	,	RutDeudor			-- 6
	,	Instrumento			-- 7
	,	Mascara				-- 8
	,	Nominal				-- 9
	,	Fecha_compra			-- 10
	,	Fecha_emi			-- 11
	,	Seriado				-- 12
	,	Codigo				-- 13
	,	Tir				-- 14
	,	Moneda				-- 15
	,	Tipoper				-- 16
	,	Monto				-- 17
	)
	SELECT	Numope				-- 1
	,	Numope				-- 2
	,	Correla				-- 3
	,	Modulo				-- 4
	,	Fec_Proc			-- 5
	,	rut_cliente			-- 6
	,	Instrumento			-- 7
	,	Mascara				-- 8
	,	Nominal				-- 9
	,	fecha_Cierre			-- 10
	,	fecha_inicio			-- 11
	,	Seriado				-- 12
	,	Codigo				-- 13
	,	Tir				-- 14
	,	Moneda				-- 15
	,	tipo_operacion			-- 16
	,	Monto1				-- 17
	FROM	#TEMPCART


	INSERT INTO BACTRADERSUDA..MARGEN_ARTICULO84  
	SELECT * FROM #ART84   

	SET NOCOUNT OFF
END

GO

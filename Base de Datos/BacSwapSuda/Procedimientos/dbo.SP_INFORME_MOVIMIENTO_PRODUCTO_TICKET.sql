USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MOVIMIENTO_PRODUCTO_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[SP_INFORME_MOVIMIENTO_PRODUCTO_TICKET] -- _MAP '20080528' , 'KKK'  
   (   @dFechaProceso DATETIME
   ,   @iUsuario      VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON
-- Swap: Guardar Como
   DECLARE @dFechaHoy     DATETIME
   ,	 @dFecProceso   CHAR(10)
   ,	 @dFecEmision   CHAR(10)
   ,	 @dHorEmision   CHAR(10)

   SELECT  @dFechaHoy     = fechaproc
   ,	 @dFecProceso   = CONVERT(CHAR(10),fechaproc,103)
   ,	 @dFecEmision   = CONVERT(CHAR(10),GETDATE(),103)
   ,	 @dHorEmision   = CONVERT(CHAR(10),GETDATE(),108)
   FROM    SWAPGENERAL

   CREATE TABLE #CarteraProducto
   (   Numero         NUMERIC(9)
   ,   Marca          CHAR(1)
   ,   Tipo           INTEGER
   ,   Flujo          NUMERIC(9)
   ,   Cartera        VARCHAR(30)
   ,   FecInicio      DATETIME
   ,   FecTermino     DATETIME
   ,   Convexidad     NUMERIC(21,4)
   ,   Macaulay       NUMERIC(21,4)
   ,   Modificada     NUMERIC(21,4)
   ,   Moneda         INTEGER
   ,   Capital        NUMERIC(21,4)
   ,   Saldo          NUMERIC(21,4)
   ,   TipoTasa       INTEGER
   ,   Tasa           NUMERIC(21,4)
   ,   vRazonableMn   NUMERIC(21,4)
   ,   vRazonableMx   NUMERIC(21,4)
   ,   vRazNetoMn     NUMERIC(21,4)
   ,   vRazNetoMx     NUMERIC(21,4)
   ,   SubCartera     INTEGER
   ,   TasaAjustada   NUMERIC(21,4)
   ,   Estado         CHAR(10) 
   ,   Operador       CHAR(20)
   )

   CREATE TABLE #CarteraSwap
   (   MiOperacion   NUMERIC(9)
   ,   MiFlujo       NUMERIC(9)
   ,   MiTipo        INTEGER
   )

	INSERT INTO #CarteraSwap SELECT Numero_Operacion , MIN(numero_flujo) , Tipo_Flujo
	FROM	TBL_FLJTICKETSWAP 
	WHERE	( tipo_swap <> 3 or ( tipo_swap = 3 AND fechaliquidacion >= @dFechaHoy ) )
		AND fecha_cierre           = @dFechaProceso
	GROUP BY numero_operacion , Tipo_Flujo
	ORDER BY numero_operacion , Tipo_Flujo

	INSERT INTO #CarteraProducto
	SELECT	'Numero'            = TBL_FLJTICKETSWAP.Numero_Operacion
		,	'Marca'             = 'A'
		,	'Tipo'              = Tipo_Swap
		,	'Flujo'             = Numero_Flujo
		,	'Cartera'           = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
					WHERE 	rcsistema		= 'PCS'
					AND	RCCODPRO		= 'FR'
					AND	rcrut			= TBL_CARTICKETSWAP.CodCarteraOrigen),'No Especificado'))
		,	'FecInicio'         = fecha_inicio
		,	'FecTermino'        = fecha_termino
		,	'Convexidad'        = 0--CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))
		,	'Macaulay'          = 0--CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))
		,	'Modificada'        = 0--CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))
		,	'Moneda'            = compra_moneda
		,	'Capital'           = compra_capital
		,	'Saldo'             = /*compra_amortiza + */ compra_saldo
		,	'TipoTasa'          = compra_codigo_tasa 
		,	'Tasa'              = compra_valor_tasa + compra_spread
		,	'vRazonableMn'      = compra_mercado_clp   
		,	'vRazonableMx'      = compra_mercado_usd
		,	'vRazNetoMn'        = 0--Valor_RazonableCLP
		,	'vRazNetoMx'        = 0--Valor_RazonableUSD
		,	'SubCartera'        = 0--car_SubCartera_Normativa
		,	'TasaAjustada'      = 0--vTasaActivaAjusta
		,	'Estado'            = case when Estado = 'C' then 'COTIZACION' else 'DEFINITIVA' end
		,	'Operador'          = Operador
	FROM	BacSwapSuda..TBL_FLJTICKETSWAP
		INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
		INNER JOIN TBL_CARTICKETSWAP   ON TBL_CARTICKETSWAP.Numero_Operacion  = TBL_FLJTICKETSWAP.Numero_Operacion
	WHERE	Tipo_Flujo          = 1 
	AND	fecha_cierre           = @dFechaProceso

	INSERT INTO #CarteraProducto
	SELECT 'Numero'            = TBL_FLJTICKETSWAP.Numero_Operacion
	,	'Marca'             = 'P'
	,	'Tipo'              = Tipo_Swap
	,	'Flujo'             = Numero_Flujo
	,	'Cartera'           = RTRIM(ISNULL((SELECT rcnombre FROM VIEW_TIPO_CARTERA
					WHERE 	rcsistema		= 'PCS'
					AND	RCCODPRO		= 'FR'
					AND	rcrut			=TBL_CARTICKETSWAP.CodCarteraOrigen),'No Especificado'))
	,	'FecInicio'         = fecha_inicio
	,	'FecTermino'        = fecha_termino
	,	'Convexidad'        = 0--CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))
	,	'Macaulay'          = 0--CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))
	,	'Modificada'        = 0--CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))
	,	'Moneda'            = Venta_moneda
	,	'Capital'           = Venta_capital
	,	'Saldo'             = /*compra_amortiza + */ compra_saldo
	,	'TipoTasa'          = compra_codigo_tasa 
	,	'Tasa'              = compra_valor_tasa + compra_spread
	,	'vRazonableMn'      = compra_mercado_clp   
	,	'vRazonableMx'      = compra_mercado_usd
	,	'vRazNetoMn'        = 0--Valor_RazonableCLP
	,	'vRazNetoMx'        = 0--Valor_RazonableUSD
	,	'SubCartera'        = 0--car_SubCartera_Normativa
	,	'TasaAjustada'      = 0--vTasaActivaAjusta
	,	'Estado'            = case when Estado = 'C' then 'COTIZACION' else 'DEFINITIVA' end
	,	'Operador'          = Operador
	FROM	BacSwapSuda..TBL_FLJTICKETSWAP
		INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
		INNER JOIN TBL_CARTICKETSWAP   ON TBL_CARTICKETSWAP.Numero_Operacion  = TBL_FLJTICKETSWAP.Numero_Operacion
	WHERE	tipo_flujo          = 2 
	AND	fecha_cierre           = @dFechaProceso

	SELECT	'Relacion' = Numero
	   ,	'CorrRela' = Marca 
	   ,	'NetoMonMn'= vRazNetoMn
	   ,	'NetoMonMx'= vRazNetoMx
	INTO	#nRelNeteo
	FROM	#CarteraProducto
	ORDER BY Numero

	UPDATE #nRelNeteo 
	SET	NetoMonMn = 0.0 
	,	NetoMonMx = 0.0 
	WHERE	CorrRela  = 'P'


	SELECT	CONVERT(CHAR(10),@dFechaProceso,103) as FecProceso  
	,	Numero                          as Numero
	,	CASE WHEN Marca = 'A' THEN 'ACTIVO'
		ELSE 'PASIVO'
		END					AS Marca
	,	CASE WHEN Tipo  = 1   THEN 'IRS'
		WHEN Tipo  = 2   THEN 'CCS'
		WHEN Tipo  = 3   THEN 'FRA'
		WHEN Tipo  = 4   THEN 'SPC'
		END 					AS Tipo
	,	Flujo                            	as Flujo
	,	Cartera					as Cartera
	,	CONVERT(CHAR(10),FecInicio,103)		as FecInicio
	,	CONVERT(CHAR(10),FecTermino,103)	as FecTermino
	,	Convexidad				as Convexidad
	,	Macaulay				as Macaulay
	,	Modificada				as Modificada
	,	iM.mnnemo				as Moneda
	,	Capital					as Capita
	,	Saldo					as Saldo
	,	CONVERT(VARCHAR(15),iT.tbglosa)		as TipoTasa-- TipoTasa
	,	Tasa                             as Tasa
	,	vRazonableMn                     as vRazonableMn
	,	vRazonableMx                     as vRazonableMx
	,	@dFecProceso                     as InformeProceso
	,	@dFecEmision                     as InformeEmision
	,	@dHorEmision                     as InformeHora
	,	@iUsuario                        as Usuario
	,	vRazNetoMn                       as vRazNetoMn
	,	vRazNetoMx                       as vRazNetoMx
	,	TasaAjustada                     as tasaajustada
	,	NetoMonMn                        as DifNetoMonMn
	,	NetoMonMx                        as DifNetoMonMx
	,	Estado                           as Estado
	,	Operador                         as Operador
	FROM	#CarteraProducto
        	LEFT JOIN BacParamSuda..MONEDA                iM ON iM.mncodmon = Moneda
		LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE iT ON iT.tbcateg  = 1042 AND iT.tbcodigo1 = TipoTasa
		LEFT JOIN #nRelNeteo                             ON Numero      = Relacion AND Marca = CorrRela
	ORDER BY Tipo , Numero , Marca
END
GO

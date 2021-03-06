USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_AVR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_AVR]( @Fecha_Desde			CHAR(10),
											@Fecha_Hasta			CHAR(10),
											@iCartera_inversion		NUMERIC(1,0),
											@iCartera_Normativa		CHAR(6),
											@iLibro					CHAR(6),
											@iArea_Responsable		CHAR(6),
											@iOperador				CHAR(10),
											@iRut_cliente			NUMERIC(9, 0),
											@iTitulo				varCHAR(200),
									   		@iUsuario     			VARCHAR(15)
   )
 /*****************************************************************
	CREADO POR
	AUTOR : Carolina Villegas Godoy
	FECHA : 23/09/2008
	MOTIVO: Para la creacion de carteras con Resultados Reconocidos o A.V.R.
	CODIGO ARGUS
      *****************************************************************/
AS
BEGIN

   SET NOCOUNT ON
-- Swap: Guardar Como
   DECLARE	@dFechaHoy     DATETIME
			,@dFecProceso   CHAR(10)
			,@dFecEmision   CHAR(10)
			,@dHorEmision   CHAR(10)
			,@sCartera_Inv	CHAR(50)
			,@sCartera_Nor	CHAR(50)
			,@sLibro		CHAR(50)
			,@sArea_Respo	CHAR(50)
			,@sOperador		CHAR(50)
			,@sRut_cliente	CHAR(50)

   SELECT  @dFechaHoy     = fechaproc
   ,       @dFecProceso   = CONVERT(CHAR(10),fechaproc,103)
   ,       @dFecEmision   = CONVERT(CHAR(10),GETDATE(),103)
   ,       @dHorEmision   = CONVERT(CHAR(10),GETDATE(),108)
   FROM    SWAPGENERAL

   CREATE TABLE #CarteraProducto
	(	Numero			NUMERIC(9)
		,Marca			CHAR(1)
		,Tipo			INTEGER
		,Flujo			NUMERIC(9)
		,Cartera		VARCHAR(5)
		,FecInicio		DATETIME
		,FecTermino  	DATETIME
		,Convexidad		NUMERIC(21,4)
		,Macaulay		NUMERIC(21,4)
		,Modificada		NUMERIC(21,4)
		,Moneda			INTEGER
		,Capital		NUMERIC(21,4)
		,Saldo			NUMERIC(21,4)
		,TipoTasa		INTEGER
		,Tasa			NUMERIC(21,4)
		,vRazonableMn	NUMERIC(21,4)
		,vRazonableMx	NUMERIC(21,4)
		,vRazNetoMn		NUMERIC(21,4)
		,vRazNetoMx		NUMERIC(21,4)
		,SubCartera		INTEGER
		,TasaAjustada	NUMERIC(21,4)
		,Fecha_Desde	CHAR(10)
		,Fecha_Hasta	CHAR(10)
		,Cartera_Inv	CHAR(50)
		,Cartera_Nor	CHAR(50)
		,Libro			CHAR(50)
		,Area_Respo		CHAR(50)
		,Operador		CHAR(50)
		,Rut_cliente	CHAR(50)
		,Titulo			varCHAR(200)
   )

	CREATE TABLE #CarteraSwap
	(   MiOperacion		NUMERIC(9)
		,MiFlujo		NUMERIC(9)
		,MiTipo			INTEGER
	)
--											@iRut_cliente			NUMERIC(9, 0),
	set 	@sArea_Respo = '< TODOS [AS] >'
	--obtiene descripcion AREA DE NEGOCIO
	select 	@sArea_Respo = tbglosa
	from	VIEW_TABLA_GENERAL_DETALLE 
	where	tbcateg=1553
	AND 	tbcodigo1 = @iArea_Responsable

	set 	@sOperador = '< TODOS [AS] >'
	--obtiene descripcion del Operador
	select	@sOperador= nombre
	from 	VIEW_USUARIO
	where 	tipo_usuario='TRADER'
	and	usuario = @iOperador

	SET 	@sCartera_Nor = '< TODOS [AS] >'
	--obtiene descripcion de la cartera normativa
	SELECT 	@sCartera_Nor = tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE	A
	WHERE	A.tbcateg	= 1111
	and		A.tbcodigo1 	= @iCartera_Normativa

	SET 	@sCartera_Inv = '< TODOS [AS] >'
	--obtiene descripcion de la cartera financiera
	SELECT 	@sCartera_Inv = tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE	A
	WHERE	A.tbcateg	= 204
	and	A.tbcodigo1 	= @iCartera_inversion

	SET 	@sLibro = '< TODOS [AS] >'
	--obtiene descripcion Libro
	SELECT 	@sLibro = tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE	A
	WHERE	A.tbcateg	= 1552
	and	A.tbcodigo1 	= @iLibro

	SET		@sRut_cliente = '< TODOS [AS] >'
	--obtiene Nombre de Cliente
	SELECT	@sRut_cliente = clnombre
	FROM	VIEW_CLIENTE
	WHERE	clrut	= @iRut_cliente

--	IF @dFechaHoy = @dFechaProceso
	IF (@Fecha_Desde = CONVERT(CHAR(10),@dFechaHoy,103) AND @Fecha_Hasta = CONVERT(CHAR(10),@dFechaHoy,103))
	BEGIN
		INSERT INTO #CarteraSwap
		SELECT	Numero_Operacion ,
				MIN(numero_flujo),
				Tipo_Flujo
		FROM	CARTERA 
	--	where 	(tipo_swap <> 3 or ( tipo_swap = 3 and fechaliquidacion >= @dFechaHoy ) )
		where 	(tipo_swap <> 3 or ( tipo_swap = 3 and fechaliquidacion between @Fecha_Desde and @Fecha_Hasta ) )
		AND		(car_area_Responsable	= @iArea_Responsable	OR	@iArea_Responsable	= '')
		AND		(car_Cartera_Normativa	= @iCartera_Normativa	OR	@iCartera_Normativa = '')
		AND		(cartera_inversion		= @iCartera_inversion	OR	@iCartera_inversion =  0)
 		AND		(car_Libro				= @iLibro				OR	@iLibro				= '')
		AND		(operador				= @iOperador			OR	@iOperador			= '')
		AND		(rut_cliente			= @iRut_cliente			OR	@iRut_cliente 		= 0)
		AND		Estado 				<> 'C'   
		GROUP BY	numero_operacion ,
					Tipo_Flujo 
		ORDER BY	numero_operacion ,
					Tipo_Flujo

      INSERT INTO #CarteraProducto
      SELECT 'Numero'            = Numero_Operacion
      ,      'Marca'             = 'A'
      ,      'Tipo'              = Tipo_Swap
      ,      'Flujo'             = Numero_Flujo
      ,      'Cartera'           = car_Cartera_Normativa
      ,      'FecInicio'         = fecha_inicio
      ,      'FecTermino'        = fecha_termino
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))
      ,      'Moneda'            = compra_moneda
      ,      'Capital'           = compra_capital
      ,      'Saldo'             = /*compra_amortiza + */ compra_saldo
      ,      'TipoTasa'          = compra_codigo_tasa 
      ,      'Tasa'              = compra_valor_tasa + compra_spread
      ,      'vRazonableMn'      = compra_mercado_clp   
      ,      'vRazonableMx'      = compra_mercado_usd
      ,      'vRazNetoMn'        = Valor_RazonableCLP
      ,      'vRazNetoMx'        = Valor_RazonableUSD
      ,      'SubCartera'        = car_SubCartera_Normativa
      ,      'TasaAjustada'      = vTasaActivaAjusta
		,'Fecha_Desde'		= @Fecha_Desde
		,'Fecha_Hasta'		= @Fecha_Hasta
		,'Cartera_Inv'		= @sCartera_Inv
		,'Cartera_Nor'		= @sCartera_Nor
		,'Libro'			= @sLibro
		,'Area_Respo'		= @sArea_Respo
		,'Operador'			= @sOperador
		,'Rut_cliente'		= @sRut_cliente
		,'Titulo'			= @iTitulo

		FROM   BacSwapSuda..CARTERA
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
      WHERE  Tipo_Flujo          = 1 and estado <> 'C'

      INSERT INTO #CarteraProducto
      SELECT 'Numero'            = Numero_Operacion
      ,      'Marca'             = 'P'
      ,      'Tipo'              = Tipo_Swap
      ,      'Flujo'             = Numero_Flujo
      ,      'Cartera'           = car_Cartera_Normativa
      ,      'FecInicio'         = fecha_inicio
      ,      'FecTermino'        = fecha_termino
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexPasivo,4))
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulPasivo,4))
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiPasivo,4))
      ,      'Moneda'     = venta_moneda
      ,      'Capital'           = venta_capital
      ,      'Saldo' = /*venta_amortiza +*/ venta_saldo
      ,      'TipoTasa'          = venta_codigo_tasa
      ,      'Tasa'              = venta_valor_tasa + venta_spread
      ,      'vRazonableMn'      = venta_mercado_clp
      ,      'vRazonableMx'      = venta_mercado_usd
      ,      'vRazNetoMn'        = Valor_RazonableCLP
      ,      'vRazNetoMx'        = Valor_RazonableUSD
      ,      'SubCartera'        = car_SubCartera_Normativa
      ,      'TasaAjustada'      = vTasaPasivaAjusta
		,'Fecha_Desde'		= @Fecha_Desde
		,'Fecha_Hasta'		= @Fecha_Hasta
		,'Cartera_Inv'		= @sCartera_Inv
		,'Cartera_Nor'		= @sCartera_Nor
		,'Libro'			= @sLibro
		,'Area_Respo'		= @sArea_Respo
		,'Operador'			= @sOperador
		,'Rut_cliente'		= @sRut_cliente
		,'Titulo'			= @iTitulo

      FROM   BacSwapSuda..CARTERA
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
      WHERE  Tipo_Flujo          = 2
             and Estado <> 'C'
	end
	ELSE
	BEGIN
		INSERT INTO #CarteraSwap
		SELECT	Numero_Operacion,
				MIN(numero_flujo),
				Tipo_Flujo
		FROM	BacSwapSuda..CARTERARES 
--		WHERE	Fecha_Proceso = @dFechaProceso 
		WHERE	(Fecha_Proceso  between @Fecha_Desde and @Fecha_Hasta)
--		And		tipo_swap <> 3 or ( tipo_swap = 3 and fechaliquidacion >= @dFechaHoy )
		And		tipo_swap <> 3 or ( tipo_swap = 3 and (fechaliquidacion between @Fecha_Desde and @Fecha_Hasta ))
		AND		(cre_area_Responsable	= @iArea_Responsable	OR	@iArea_Responsable	= '')
		AND		(cartera_inversion		= @iCartera_inversion	OR	@iCartera_inversion =  0)
		AND		(cre_Cartera_Normativa	= @iCartera_Normativa	OR	@iCartera_Normativa = '')
 		AND		(cre_Libro				= @iLibro				OR	@iLibro				= '')
		AND		(operador				= @iOperador			OR	@iOperador			= '')
		AND		(rut_cliente			= @iRut_cliente			OR	@iRut_cliente 		= 0)
		GROUP BY	numero_operacion,
					Tipo_Flujo
		ORDER BY	numero_operacion,
					Tipo_Flujo
      INSERT INTO #CarteraProducto
      SELECT 'Numero'            = Numero_Operacion
      ,      'Marca'             = 'A'
      ,      'Tipo'              = Tipo_Swap
      ,      'Flujo'             = Numero_Flujo
      ,      'Cartera'           = cre_cartera_normativa
      ,      'FecInicio'         = fecha_inicio
      ,      'FecTermino'        = fecha_termino
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))
      ,      'Moneda'            = compra_moneda
      ,      'Capital'           = compra_capital
      ,      'Saldo'             = compra_saldo
      ,      'TipoTasa'          = compra_codigo_tasa
      ,      'Tasa'              = compra_valor_tasa + compra_spread
      ,      'vRazonableMn'      = compra_mercado_clp         ,      'vRazonableMx'      = compra_mercado_usd
      ,      'vRazNetoMn'        = Valor_RazonableCLP
      ,      'vRazNetoMx'        = Valor_RazonableUSD
      ,      'SubCartera'        = cre_subcartera_normativa
      ,      'TasaAjustada'      = vTasaActivaAjusta
		,'Fecha_Desde'		= @Fecha_Desde
		,'Fecha_Hasta'		= @Fecha_Hasta
		,'Cartera_Inv'		= @sCartera_Inv
		,'Cartera_Nor'		= @sCartera_Nor
		,'Libro'			= @sLibro
		,'Area_Respo'		= @sArea_Respo
		,'Operador'			= @sOperador
		,'Rut_cliente'		= @sRut_cliente
		,'Titulo'			= @iTitulo
      FROM   BacSwapSuda..CARTERARES
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
      WHERE  Fecha_Proceso       between @Fecha_Desde and @Fecha_Hasta
      AND    Tipo_Flujo          = 1
      And    Estado              <> 'C'

      INSERT INTO #CarteraProducto
      SELECT 'Numero'            = Numero_Operacion
      ,      'Marca'             = 'P'
      ,      'Tipo'              = Tipo_Swap
      ,      'Flujo'             = Numero_Flujo
      ,      'Cartera'           = cre_cartera_normativa
      ,      'FecInicio'         = fecha_inicio
      ,      'FecTermino'        = fecha_termino
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexPasivo,4))
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulPasivo,4))
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiPasivo,4))
      ,      'Moneda'            = venta_moneda
      ,      'Capital'           = venta_capital
      ,      'Saldo'             = venta_saldo
      ,      'TipoTasa'          = venta_codigo_tasa
      ,      'Tasa'              = venta_valor_tasa + venta_spread
      ,      'vRazonableMn'      = venta_mercado_clp
      ,      'vRazonableMx'      = venta_mercado_usd
      ,      'vRazNetoMn'        = Valor_RazonableCLP
      ,      'vRazNetoMx'        = Valor_RazonableUSD
      ,      'SubCartera'        = cre_subcartera_normativa
      ,      'TasaAjustada'      = vTasaPasivaAjusta
		,'Fecha_Desde'		= @Fecha_Desde
		,'Fecha_Hasta'		= @Fecha_Hasta
		,'Cartera_Inv'		= @sCartera_Inv
		,'Cartera_Nor'		= @sCartera_Nor
		,'Libro'			= @sLibro
		,'Area_Respo'		= @sArea_Respo
		,'Operador'			= @sOperador
		,'Rut_cliente'		= @sRut_cliente
		,'Titulo'			= @iTitulo
      FROM   BacSwapSuda..CARTERARES
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo
      WHERE  Fecha_Proceso       between @Fecha_Desde and @Fecha_Hasta
      AND  Tipo_Flujo          = 2
      and  Estado              <> 'C'

   END-- FIN DEL ELSE 

   SELECT 'Relacion'	= Numero
		   ,'CorrRela' 	= Marca 
		   ,'NetoMonMn'	= vRazNetoMn
		   ,'NetoMonMx'	= vRazNetoMx
		   INTO   #nRelNeteo
		   FROM   #CarteraProducto
		   ORDER BY Numero

	UPDATE #nRelNeteo 
	SET NetoMonMn = 0.0 
		,NetoMonMx = 0.0 
	WHERE CorrRela  = 'P'

   SELECT	CONVERT(CHAR(10),@dFechaHoy,103) as FecProceso  
			,Numero  as Numero
			,CASE	WHEN	Marca = 'A' THEN 'ACTIVO'
					ELSE	'PASIVO'
					END as Marca
			,CASE	WHEN Tipo  = 1   THEN 'IRS'
					WHEN Tipo  = 2   THEN 'CCS'
					WHEN Tipo  = 3   THEN 'FRA'
					WHEN Tipo  = 4   THEN 'SPC'
					END as Tipo
			,      Flujo                            as Flujo
			,      CONVERT(VARCHAR(25),cA.tbglosa)  as Cartera
			,      CONVERT(CHAR(10),FecInicio,103)  as FecInicio
			,      CONVERT(CHAR(10),FecTermino,103) as FecTermino
			,      Convexidad                       as Convexidad
			,      Macaulay                         as Macaulay
			,      Modificada                       as Modificada
			,      iM.mnnemo                        as Moneda
			,      Capital                          as Capita
			,      Saldo                            as Saldo
			,      CONVERT(VARCHAR(15),iT.tbglosa)  as TipoTasa-- TipoTasa
			,      Tasa                             as Tasa
			,      vRazonableMn                     as vRazonableMn
			,      vRazonableMx                     as vRazonableMx
			,      @dFecProceso                     as InformeProceso
			,      @dFecEmision                     as InformeEmision
			,      @dHorEmision                     as InformeHora
			,      @iUsuario                        as Usuario
			,      CONVERT(VARCHAR(25),sC.tbglosa)  as SubCartera
			,      vRazNetoMn                       as vRazNetoMn
			,      vRazNetoMx                       as vRazNetoMx
			,      TasaAjustada                     as tasaajustada
			,      NetoMonMn                        as DifNetoMonMn
			,      NetoMonMx                        as DifNetoMonMx
			,Fecha_Desde
			,Fecha_Hasta
			,Cartera_Inv
			,Cartera_Nor
			,Libro
			,Area_Respo
			,Operador
			,Rut_cliente
			,Titulo
		FROM   #CarteraProducto
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE iT ON iT.tbcateg  = 1042 AND iT.tbcodigo1 = TipoTasa
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE cA ON cA.tbcateg  = 1111 AND cA.tbcodigo1 = Cartera
          LEFT JOIN BacParamSuda..MONEDA                iM ON iM.mncodmon = Moneda
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE sC ON sC.tbcateg  = 1554 AND sC.tbcodigo1 = SubCartera
          LEFT JOIN #nRelNeteo                             ON Numero      = Relacion AND Marca = CorrRela
   ORDER BY Tipo , Numero , Marca
-- SP_INFORME_CARTERA_PRODUCTO '20080403', 'PP'
--	SELECT * FROM #CarteraProductoF
 --  	ORDER BY Tipo , Numero , Marca
END
GO

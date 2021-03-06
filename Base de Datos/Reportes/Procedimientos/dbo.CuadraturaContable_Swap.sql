USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Swap]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaContable_Swap]
AS
BEGIN 

 DECLARE @FechaProcesoAnt AS CHAR(8)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT
 SELECT @FechaProcesoAnt =  CONVERT(CHAR(8),acfecante,112) FROM Bacfwdsuda..mfac

 
 --EXEC('IF EXISTS(SELECT * FROM ##tmpParamWhereSwap) DROP TABLE ##tmpParamWhereSwap')
  
 -- VALOR UF 
 SELECT @ValorUF = vmvalor
 FROM BACPARAMSUDA..MONEDA m INNER JOIN BACPARAMSUDA..VALOR_MONEDA vm ON m.mncodmon = vm.vmcodigo
 WHERE mncodmon = 998 and vmfecha = @FechaProcesoAnt



 CREATE TABLE #tmpParametros
	(
		CodIBS      int,
		ParamWhere	nvarchar(max),
		ParamSelect	varchar(50),
		ParamMoneda varchar(10),
	)

-- QUERY COMPILADO DE DATOS


SELECT 'Fecha'	     = CARTERARES.Fecha_Proceso
	 , 'N_Operacion' = CARTERARES.numero_operacion
	 , 'Flujo'       = CARTERARES.numero_flujo
	 , 'TipoFlujo'   = CARTERARES.tipo_flujo
	 , 'TipoSwap'    = CARTERARES.tipo_swap
	 , 'Producto'    = VIEW_PRODUCTO.descripcion
	 , 'Cartera_Inv'   = CARTERARES.cartera_inversion
	 , 'TipoOperacion' = CARTERARES.tipo_operacion
	 , 'RutCliente'  = CARTERARES.rut_cliente
	 , 'Cliente'     = view_Cliente.Clnombre
	 , 'FechaCierre' = CARTERARES.fecha_cierre
	 , 'FechaIni'    = CARTERARES.fecha_inicio
	 , 'FechaFin'	 = CARTERARES.fecha_termino
	 , 'FechaIniFlujo' = CARTERARES.fecha_inicio_flujo
	 , 'FechaFinFlujo' = CARTERARES.fecha_vence_flujo
	 , 'FechaFijaTasa' = CARTERARES.fecha_fijacion_tasa
	 , 'MonedaActiva'  = CARTERARES.compra_moneda
	 , 'CapitalCompra' = CARTERARES.compra_capital
	 , 'AmortizaActiva'= CARTERARES.compra_amortiza
	 , 'SaldoActivo'   = CARTERARES.compra_saldo
	 , 'ValortasaActiva' = CARTERARES.compra_valor_tasa
	 , 'MonedaPasiva'    = CARTERARES.venta_moneda
	 , 'CapitalPasiva'   = CARTERARES.venta_capital
	 , 'AmortizaPasiva'  = CARTERARES.venta_amortiza
	 , 'Saldopasivo'     = CARTERARES.venta_saldo
	 , 'CodTasaPasiva'   = CARTERARES.venta_codigo_tasa
	 , 'ValorTasaPasiva' = CARTERARES.venta_valor_tasa
	 , 'Modalidad'		 = CARTERARES.modalidad_pago
	 , 'TasaActivaAjustada' = CARTERARES.vTasaActivaAjusta
	 , 'TasaPasivaAjustada' = CARTERARES.vTasaPasivaAjusta
	 , 'FlujoVigenteMercado_Activo_MO'  = CARTERARES.compra_mercado
	 , 'FlujoVigenteMercado_Pasivo_MO'  = CARTERARES.venta_mercado
	 , 'FlujoVigenteMercado_Activo_USD' = CARTERARES.compra_mercado_usd
	 , 'FlujoVigenteMercado_Pasivo_USD' = CARTERARES.venta_mercado_usd
	 , 'FlujoVigenteMercado_Activo_CLP' = CARTERARES.compra_mercado_clp
	 , 'FlujoVigenteMercado_Pasivo_CLP' = CARTERARES.venta_mercado_clp
	 , 'FlujoActivo_CLP'	= CARTERARES.Activo_FlujoCLP
	 , 'FlujoPasivoCLP'		= CARTERARES.Pasivo_FlujoCLP
	 , 'ValorRazonableNeto' = CARTERARES.Valor_RazonableCLP
	 , 'Operador'		    = CARTERARES.operador
	 , 'CarteraNormativa'   = CARTERARES.cre_cartera_normativa
INTO #tmpCarteraRES
FROM  BacSwapSuda.dbo.CARTERARES CARTERARES	
	, BacSwapSuda.dbo.view_Cliente view_Cliente
	, BacSwapSuda.dbo.VIEW_PRODUCTO VIEW_PRODUCTO
WHERE CARTERARES.rut_cliente = view_Cliente.Clrut AND CARTERARES.codigo_cliente = view_Cliente.Clcodigo 
	AND CARTERARES.tipo_swap = VIEW_PRODUCTO.codigo_producto 
	AND ((CARTERARES.Fecha_Proceso= @FechaProcesoAnt ) AND (CARTERARES.estado_flujo = 1) 
	AND (CARTERARES.estado<>'c'))
ORDER BY CARTERARES.numero_operacion, CARTERARES.tipo_flujo


SELECT 'Fecha'		 = cr.Fecha
	 , 'N_Operacion' = cr.N_Operacion
	 , 'Flujo'	     = cr.Flujo
	 , 'TipoSwap'    = cr.TipoSwap
	 , 'Producto'    = cr.Producto
	 , 'Cartera_Inv'   = cr.Cartera_Inv
	 , 'TipoOperacion' = cr.TipoOperacion
	 , 'RutCliente'    = cr.RutCliente
	 , 'Cliente'	   = cr.Cliente
	 , 'FechaCierre'   = cr.FechaCierre
	 , 'FechaIni'	   = cr.FechaIni
	 , 'FechaFin'	   = cr.FechaFin
	 , 'FechaIniFlujo' = cr.FechaIniFlujo
	 , 'FechaFinFlujo' = cr.FechaFinFlujo
	 , 'FechaFijaTasa' = cr.FechaFijaTasa
	 , 'MonedaActiva'  = cr.MonedaActiva
	 , 'CapitalCompra' = cr.CapitalCompra
	 , 'AmortizaActiva'  = cr.AmortizaActiva
	 , 'SaldoActivo'     = cr.SaldoActivo
	 , 'ValortasaActiva' = cr.ValortasaActiva
	 , 'MonedaPasiva'    = cr.MonedaPasiva
	 , 'CapitalPasiva'   = cr.CapitalPasiva
	 , 'AmortizaPasiva'  = cr.AmortizaPasiva
	 , 'Saldopasivo'     = cr.Saldopasivo
	 , 'CodTasaPasiva'   = cr.CodTasaPasiva
	 , 'ValorTasaPasiva' = cr.ValorTasaPasiva
	 , 'Modalidad'       = cr.Modalidad
	 , 'TasaActivaAjustada' = cr.TasaActivaAjustada
	 , 'TasaPasivaAjustada' = cr.TasaPasivaAjustada
	 , 'FlujoVigenteMercado_Activo_MO'  = cr.FlujoVigenteMercado_Activo_MO
	 , 'FlujoVigenteMercado_Pasivo_MO'  = cr.FlujoVigenteMercado_Pasivo_MO
	 , 'FlujoVigenteMercado_Activo_USD' = cr.FlujoVigenteMercado_Activo_USD
	 , 'FlujoVigenteMercado_Pasivo_USD' = cr.FlujoVigenteMercado_Pasivo_USD
	 , 'FlujoVigenteMercado_Activo_CLP' = cr.FlujoVigenteMercado_Activo_CLP
	 , 'FlujoVigenteMercado_Pasivo_CLP' = cr.FlujoVigenteMercado_Pasivo_CLP
	 , 'FlujoActivo_CLP'    = cr.FlujoActivo_CLP
	 , 'FlujoPasivoCLP'     = cr.FlujoPasivoCLP
	 , 'ValorRazonableNeto' = cr.ValorRazonableNeto
	 , 'Operador'		    = cr.Operador
	 , 'CarteraNormativa'   = cr.CarteraNormativa
	 , 'KPASIVO'	=ISNULL(#tmpPas.CapitalPasiva,0) 
INTO #tmpCarteraSwap
FROM     #tmpCarteraRES AS cr LEFT OUTER JOIN
        (SELECT        N_Operacion, '1' AS TipoFlujoPasivo, CapitalPasiva
         FROM           #tmpCarteraRES
         WHERE        (TipoFlujo = 2)) AS #tmpPas ON cr.N_Operacion = #tmpPas.N_Operacion AND cr.TipoFlujo = #tmpPas.TipoFlujoPasivo



SELECT ps.IDDetalleParametros, ps.Sistema, ps.CodIBS, ps.TipoSwap, ISNULL(ma.mncodmon,0) AS MonedaActiva, ISNULL(mp.mncodmon,0) AS MonedaPasiva, 
       ps.CarteraNormativa, ps.TipoCriterio, ps.MonedaActiva AS MonedaActivaGlosa, ps.MonedaPasiva AS MonedaPasivaGlosa
INTO #Parametros_Detalle_Swap
FROM   dbo.Parametros_Detalle_Swap AS ps LEFT JOIN
       BacParamSuda.dbo.MONEDA AS ma ON ps.MonedaActiva = ma.mnnemo LEFT JOIN
       BacParamSuda.dbo.MONEDA AS mp ON ps.MonedaPasiva = mp.mnnemo

-- select * from #Parametros_Detalle_Swap

----------------------------------------------------------------------------------------------------------
-------------------------------- SELECT CAMPOS DINAMICOS -------------------------------------------------

------ Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros
		, c.Parametros
		, r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  		dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  		dbo.Parametros_Detalle_Swap AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
			dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'PCS') AND (r.IdTipoCriterio IS NOT NULL)

 -- select * from #tmpParamSelect


---------------------------------- WHERE CAMPOS DINAMICOS ---------------------------------------------------

---- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'PCS')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhereSwap     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''PCS'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
  -- EXEC('select * from ##tmpParamWhereSwap ')
  -- print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
   INSERT INTO #tmpParametros 
   SELECT    pf.CodIBS ,  pw.CarteraNormativa + ' = '''+  pf.CarteraNormativa 
	      +  ''' AND ' + pw.tipoSwap+ ' = '''+ RTRIM(pf.TipoSwap) + ''' AND ' 
	      +  pw.MonedaActiva+ ' = '+ RTRIM(pf.MonedaActiva) + ' AND ' 
	      +  pw.MonedaPasiva + ' = '+ RTRIM(pf.MonedaPasiva) + ' AND ' 
	      +   pw.ValorRazonableNeto + CASE WHEN  pw.IdTipoCriterio = 5 THEN  '> 0' WHEN  pw.IdTipoCriterio = 6 THEN  '< 0' ELSE    ' = '+ pw.ValorRazonableNeto END   AS paramWhere 
	      ,  CASE WHEN ps.IdTipoCriterio = 12 OR
				      ps.IdTipoCriterio  = 13 OR
					  ps.IdTipoCriterio  = 14 THEN '('+ps.Parametros +'/'+  RTRIM(@ValorUF)  +')' ELSE ps.Parametros END  AS ParamSelect 
		  ,+ CASE WHEN ps.IdParametros   = 16 THEN 'CLP' 
				  ELSE CASE WHEN pf.MonedaActivaGlosa  = '0' THEN  pf.MonedaPasivaGlosa 
							ELSE  pf.MonedaActivaGlosa END 
			 END AS ParamMoneda
   FROM ##tmpParamWhereSwap AS pw INNER JOIN #tmpParamSelect AS ps ON pw.IdTipoCriterio = ps.IdTipoCriterio
        AND pw.Sistema = ps.Sistema INNER JOIN #Parametros_Detalle_Swap AS pf ON pw.Sistema = pf.Sistema 
		AND pw.IdTipoCriterio = pf.TipoCriterio AND ps.CodIBS = pf.CodIBS

 --  SELECT * FROM  #tmpParametros order by CodIBS


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
Declare @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @Sistema AS VARCHAR(10), @ParamMoneda as varchar(10) 
SET @Sistema = 'PCS'

	DELETE CuadraturaContableDerivados WHERE Sistema = 'PCS'

	DECLARE cur CURSOR LOCAL READ_ONLY FAST_FORWARD FOR   
	SELECT DISTINCT CodIBS, ParamWhere, ParamSelect , ParamMoneda
	FROM #tmpParametros

	OPEN cur
	fetch next from cur into @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda		  
	while @@FETCH_STATUS = 0
	Begin
			
			
			INSERT INTO CuadraturaContableDerivados --#tmpResult  			
		    EXEC(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
							+ ''''+ @FechaProcesoAnt +''' ,
						   '+       @CodIBS + ' , 
						     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
						  ' + ' 0 AS saldoIBS ,' +
					    ''''+ @ParamMoneda  +''',' +
				        ''''+ @Sistema      +''',' +
						 '' + ' 0' +
			     ' FROM #tmpCarteraSwap'+ 
				 ' WHERE  ' + @ParamWhere)



-- **********************************************************************************
				 --   print(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
					--		+ ''''+ @FechaProcesoAnt +''' ,
					--	   '+       RTRIM(@CodIBS) + ' , 
					--	      ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
					--	   ' + ' 0 AS saldoIBS ,' +
					--	  ''''+ @ParamMoneda  +''',' +
					--	  ''''+ @Sistema  +''',' +
					--     '' + ' 0' +
			  --   ' FROM #tmpCarteraSwap'+ 
				 --' WHERE  ' + @ParamWhere)

    		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect , @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  



	 EXEC('DROP TABLE ##tmpParamWhereSwap')
	-- SELECT * FROM CuadraturaContableDerivados


  END

GO

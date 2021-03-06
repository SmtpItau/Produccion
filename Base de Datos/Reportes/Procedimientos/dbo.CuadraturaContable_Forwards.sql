USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Forwards]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   


CREATE PROCEDURE [dbo].[CuadraturaContable_Forwards]
AS
BEGIN 

 DECLARE @Sistema AS VARCHAR(10)
 DECLARE @FechaProcesoAnt AS CHAR(8)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT
 SELECT @FechaProcesoAnt =  CONVERT(CHAR(8),acfecante,112) FROM Bacfwdsuda..mfac
-- SET @FechaProcesoAnt = '20140110'
 SET @Sistema = 'BFW'

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
SELECT  'canumoper'            = MFCARES.canumoper
	  , 'caestado'             = MFCARES.caestado
	  , 'cacodcart'            = MFCARES.cacodcart
	  , 'descripcion'          = VIEW_PRODUCTO.descripcion
	  , 'catipoper'	           = MFCARES.catipoper
	  , 'catipmoda'	           = MFCARES.catipmoda
	  , 'cafecha'	           = MFCARES.cafecha
	  , 'cafecvcto'            = MFCARES.cafecvcto
	  , 'caplazo'	           = MFCARES.caplazo
	  , 'mnnemo'	           =  VIEW_MONEDA.mnnemo
	  , 'camtomon1'            = MFCARES.camtomon1
	  , 'mnnemo2'              = VIEW_MONEDA_1.mnnemo
	  , 'camtomon2'            = MFCARES.camtomon2
	  , 'cacodigo'             = MFCARES.cacodigo
	  , 'ValorRazonableActivo' = MFCARES.ValorRazonableActivo
	  , 'ValorRazonablePasivo' = MFCARES.ValorRazonablePasivo	 
	  , 'camtomon1ini'         = MFCARES.camtomon1ini
	  , 'camtomon1fin'         = MFCARES.camtomon1fin
	  , 'camtomon2ini'         = MFCARES.camtomon2ini
	  , 'camtomon2fin'         = MFCARES.camtomon2fin
	  , 'carevuf'              = MFCARES.carevuf
	  , 'cacartera_normativa'  = MFCARES.cacartera_normativa
      , 'AVR'		           = ROUND(MFCARES.ValorRazonableActivo,0) - ROUND(ValorRazonablePasivo,0) 
INTO #tmpCartForwards
FROM  Bacfwdsuda.dbo.MFCARES MFCARES, Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA
	, Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA_1, Bacfwdsuda.dbo.VIEW_PRODUCTO VIEW_PRODUCTO
WHERE MFCARES.cacodmon1 = VIEW_MONEDA.mncodmon AND MFCARES.cacodmon2 = VIEW_MONEDA_1.mncodmon 
	 AND MFCARES.cacodpos1 = VIEW_PRODUCTO.codigo_producto AND ((MFCARES.CaFechaProceso= @FechaProcesoAnt) 
	 AND (VIEW_PRODUCTO.id_sistema='BFW') AND (MFCARES.cafecvcto> @FechaProcesoAnt ))
ORDER BY MFCARES.canumoper

--------------------------------------------------------------------------------------------------------
------------------------------ SELECT CAMPOS DINAMICOS -------------------------------------------------

---- Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros
	, c.Parametros 
	, r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  		dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  		dbo.Parametros_Detalle_Forwards AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
			dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'BFW') AND (r.IdTipoCriterio IS NOT NULL)
	

--	select * from #tmpParamSelect
--	select * from Parametros_CriterioContable_TipoCriterio

------------------------------ WHERE CAMPOS DINAMICOS ---------------------------------------------------

-- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'BFW')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhere     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''BFW'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
  -- EXEC('select * from ##tmpParamWhere ')
  -- print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
	 INSERT INTO #tmpParametros 
	 SELECT   pf.CodIBS,  pw.descripcion + ' = '''+  pf.Producto
		 + ''' AND ' + pw.catipoper  + ' = '+ CASE WHEN pf.TipoOperacion = 'M' THEN pw.catipoper ELSE '''' + pf.TipoOperacion + '''' END 
		 + ' AND ' + pw.[mnnemo]+ ' = '''+ pf.MonedaActiva 
		 + ''' AND ' + pw.[mnnemo2]+ ' = '''+ pf.MonedaPasiva
		 + ''' AND ' + pw.cacartera_normativa + ' = '''+ pf.CarteraNormativa 
		 + ''' AND ' + pw.[AVR]+  CASE WHEN  pw.IdTipoCriterio = 5 THEN  '> 0' WHEN  pw.IdTipoCriterio = 6 THEN  '< 0' ELSE    ' = '+ pw.[AVR] END   AS paramWhere
		 ,  + ps.Parametros AS ParamSelect 
		 ,  +      CASE WHEN ps.IdParametros = 1 THEN  pf.MonedaActiva 
		      ELSE CASE WHEN ps.IdParametros = 2 THEN  pf.MonedaPasiva 
			  ELSE CASE WHEN ps.IdParametros = 3 THEN 'CLP' 	
		 END END END AS ParamMoneda
	 FROM ##tmpParamWhere AS pw INNER JOIN #tmpParamSelect AS ps ON 
	      pw.IdTipoCriterio = ps.IdTipoCriterio AND pw.Sistema = ps.Sistema INNER JOIN 
		  dbo.Parametros_Detalle_Forwards AS pf ON pw.Sistema = pf.Sistema AND pw.IdTipoCriterio = pf.TipoCriterio AND ps.CodIBS = pf.CodIBS

--  EXEC ('INSERT INTO #tmpParametros ' + @strSQLParamWHERE)

-- PRINT @strSQLParamWHERE
-- SELECT * FROM  #tmpParametros order by CodIBS



----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
Declare @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @ParamMoneda as varchar(10) 

	DELETE CuadraturaContableDerivados WHERE Sistema = @Sistema

	DECLARE cur CURSOR LOCAL READ_ONLY FAST_FORWARD FOR   
	SELECT DISTINCT CodIBS, ParamWhere, ParamSelect, ParamMoneda
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
						  ''''+ @Sistema  +''',' +
						  '' + ' 0' +
			     ' FROM #tmpCartForwards'+ 
				 ' WHERE  ' + @ParamWhere)

----- **********************************************************************************
--			print (' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
--							+ ''''+ @FechaProcesoAnt +''' ,'+      RTRIM(@CodIBS) + ' , 
--						     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
--						  ' + ' 0 AS saldoIBS , ' +
--						  '' + ' 0,' +
						  
--			     ' FROM #tmpCartForwards'+ 
--				 ' WHERE  ' + @ParamWhere)

   		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  

    EXEC('IF EXISTS(SELECT * FROM ##tmpParamWhere) DROP TABLE ##tmpParamWhere')
  
	-- DROP TABLE ##tmpParamWhere
	
	-- SELECT * FROM CuadraturaContableDerivados


  END

GO

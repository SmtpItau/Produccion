USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_RentaFija]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   

CREATE PROCEDURE [dbo].[CuadraturaContable_RentaFija]
AS
BEGIN 

 DECLARE @Sistema AS VARCHAR(10)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT
 DECLARE @FechaProcesoAnt  AS CHAR(8)  -- Fecha valorización
 DECLARE @FechaProceso     AS CHAR(8)  -- Fecha Cartera


 SET @Sistema = 'BTR'

SELECT @FechaProceso	= acfecproc FROM Bacfwdsuda..Mfac
SELECT @FechaProcesoAnt = acfecante FROM Bacfwdsuda..Mfac 

-- Solo para prueba y validación de data en CorpSql05
--SET @FechaProceso    = '20140110'
--SET @FechaProcesoAnt = '20140109'



-- EXEC('IF EXISTS(SELECT * FROM ##tmpParamWhereRF) DROP TABLE ##tmpParamWhereRF')
  
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
SELECT   'Fecha'		   =   vm.fecha_valorizacion 
		,'Cartera'		   =   MDRS.codigo_carterasuper
		,'Operacion'	   =   vm.rmnumdocu 
		,'Item'			   =   vm.rmcorrela 
		,'RutEmisor'	   =   vm.rut_emisor 
		,'NombreEmisor'    =   e.emnombre 
		,'TipoInst'	       =   i.inserie 
		,'Nemotecnico'     =   vm.rminstser 
		,'Moneda'		   =   me.mnnemo
		,'Nominal'		   =   vm.valor_nominal 
		,'TirCompra'       =   vm.tasa_compra 
		,'TirMercado'      =   vm.tasa_mercado
		,'ValorPresente'   =   MDRS.rsvppresen -- valor de la posición del instrumento x hoy.
		,'Interes'	       =   MDRS.rsinteres
		,'Reajuste'	       =   MDRS.rsreajuste
		,'ValorMercado'    =   vm.valor_mercado
		,'AVR'		       =   vm.diferencia_mercado  --Valor Razonable -> dif. de valor prese. TIR compra - c/ valor pres. TIR Mercado. 
		,'FechaEmicion'    =   vm.tmfecemi 
		,'FechaVencimient' =   vm.tmfecven 
		,'TipoEmisor'	   =   e.emtipo 
		, MDRS.rsnumoper     
		, vm.rmnumoper 
 INTO #tmpRentaFija      
FROM    BacTraderSuda.dbo.VIEW_INSTRUMENTO AS i INNER JOIN
        BacTraderSuda.dbo.VALORIZACION_MERCADO AS vm ON i.incodigo = vm.rmcodigo INNER JOIN
        BacTraderSuda.dbo.VIEW_EMISOR AS e ON vm.rut_emisor = e.emrut INNER JOIN
        BacTraderSuda.dbo.VIEW_MONEDA AS me ON vm.moneda_emision = me.mncodmon INNER JOIN
        BacTraderSuda.dbo.MDRS AS MDRS ON vm.rmnumdocu = MDRS.rsnumdocu AND vm.rmcorrela = MDRS.rscorrela AND vm.rmnumoper = MDRS.rsnumoper
WHERE   (vm.fecha_valorizacion = @FechaProcesoAnt)  
	AND	(MDRS.rstipoper = 'dev') AND (vm.id_sistema = 'BTR') AND (MDRS.rsfecha = @FechaProceso) 
	AND (MDRS.rscartera NOT IN (115))
--- FILTROS:
 --AND (i.inserie = 'BR')  -- Tipo Instrumento
 --AND (MDRS.codigo_carterasuper = 'P')  -- CARTERA
 --   AND vm.rut_emisor = 97029000 --  rut emisor
 --   AND me.mnnemo =  'CLP' -- Moneda
 --   AND e.emtipo = 2  -- Tipo Emisor
	--AND   vm.diferencia_mercado  =  vm.diferencia_mercado -- AVR 



--------------------------------------------------------------------------------------------------------
------------------------------ SELECT CAMPOS DINAMICOS -------------------------------------------------

---- Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros, Parametros
	, r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  		dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  		dbo.Parametros_Detalle_RentaFija AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
			dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'BTR') AND (r.IdTipoCriterio IS NOT NULL)
	      AND pf.Sistema = 'BTR'

--	select * from #tmpParamSelect


------------------------------ WHERE CAMPOS DINAMICOS ---------------------------------------------------

-- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'BTR')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhereRF     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''BTR'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
   -- EXEC('select * from ##tmpParamWhereRF ')
   -- print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
   INSERT INTO  #tmpParametros
   SELECT  rf.CodIBS 
		   , pw.AVR        
		   + ' '      +  CASE WHEN  pw.IdTipoCriterio = 10 THEN '< 0' ELSE ' = '+ pw.AVR END 
		   + ' AND '  +  pw.Cartera    + ' = '''+ rf.Cartera 
		   + ''' AND '+  pw.TipoInst   + ' = '''+ rf.TipoInstrumento 
		   + ''' AND '+  pw.Moneda     + ' = '''+ rf.Moneda 
		   + ''' AND '+  pw.RutEmisor + ' = '''+ RTRIM(rf.TipoEmisor) + '''' AS ParamWhere
		   , ps.Parametros AS ParamSelect 
		   , rf.Moneda     AS ParamMoneda
    FROM ##tmpParamWhereRF AS pw INNER JOIN   #tmpParamSelect AS ps
		 ON pw.IdTipoCriterio = ps.IdTipoCriterio AND pw.Sistema = ps.Sistema INNER JOIN 
		 dbo.Parametros_Detalle_RentaFija AS rf ON pw.Sistema = rf.Sistema AND pw.IdTipoCriterio = rf.TipoCriterio AND ps.CodIBS = rf.CodIBS 

  -- SELECT * FROM  #tmpParametros order by CodIBS

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
DECLARE @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @ParamMoneda as varchar(10)  

	DELETE CuadraturaContableDerivados WHERE Sistema = @Sistema

	DECLARE cur CURSOR LOCAL READ_ONLY FAST_FORWARD FOR   
	SELECT DISTINCT CodIBS, ParamWhere, ParamSelect , ParamMoneda
	FROM #tmpParametros

	OPEN cur
	fetch next from cur into @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
	while @@FETCH_STATUS = 0
	BEGIN			
			INSERT INTO CuadraturaContableDerivados --#tmpResult  			
		    EXEC(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
							+ ''''+ @FechaProcesoAnt +''' ,
						   '+       @CodIBS + ' , 
						     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
						  '   + ' 0 AS saldoIBS ,' +
						  ''''+ @ParamMoneda  +''',' +
						  ''''+ @Sistema  +''',' +
						  '' + ' 0' +
			     ' FROM #tmpRentaFija'+ 
				 ' WHERE  ' + @ParamWhere)

--- **********************************************************************************
			--print (' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
			--				+ ''''+ @FechaProcesoAnt +''' ,
			--			   '+      RTRIM(@CodIBS)  + ' , 
			--			     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
			--			  ' + ' 0 AS saldoIBS ,' +
			--			  ''''+ @Sistema  +''',' +
			--			  '' + ' 0' +
			--     ' FROM #tmpRentaFija'+ 
			--	 ' WHERE  ' + @ParamWhere)

    		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect , @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  

	  EXEC('DROP TABLE ##tmpParamWhereRF')
	
	 --SELECT * FROM CuadraturaContableDerivados


  END

GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_RentaFijaExt]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [dbo].[CuadraturaContable_RentaFijaExt]
AS
BEGIN 

 DECLARE @Sistema AS VARCHAR(10)
 DECLARE @FechaProcesoAnt CHAR(8)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @Dolar AS FLOAT
 SET @Sistema = 'BTREX'
 
SELECT @FechaProcesoAnt = CONVERT(CHAR(8),acfecante,112) FROM Bacfwdsuda..mfac 

-- EXEC('IF EXISTS(SELECT * FROM ##tmpParamWhereRFExt) DROP TABLE ##tmpParamWhereRFExt')
  
 -- VALOR UF 
select @Dolar = vmptacmp 
from BacParamSuda..View_Valor_Moneda 
where vmfecha = @FechaProcesoAnt and vmcodigo = 994

--EXEC('DROP TABLE ##tmpParamWhereRFExt')

 CREATE TABLE #tmpParametros
	(
		CodIBS      int,
		ParamWhere	nvarchar(max),
		ParamSelect	varchar(50),
		ParamMoneda varchar(10),
	)

-- QUERY COMPILADO DE DATOS
SELECT 'Fecha'         = text_rsu.rsfecpro
	  , 'Cartera'       = text_rsu.codigo_carterasuper
	  , 'Operacion'     = text_rsu.rsnumdocu
	  , 'Item'		    = text_rsu.rscorrelativo
	  , 'RutEmisor'     = text_rsu.rsrutemis
	  , 'NombreEmisor'  = view_emisor.emnombre
	  , 'TipoIns'	    = text_rsu.cod_nemo
	  , 'Nemotecnico'   = text_rsu.cod_nemo
	  , 'Moneda'	    = view_moneda.MNNEMO
	  , 'Nominal'	    = text_rsu.rsnominal
	  , 'TIRCompra'     = text_rsu.rstir
	  , 'TirMercado'    = text_rsu.rstirmerc
	  , 'ValorPresente' = text_rsu.rsvppresen
	  , 'Interes'       = text_rsu.rsinteres
	  , 'Reajuste'      = text_rsu.rsreajuste
	  , 'ValorMercado'  = text_rsu.rsvalmerc
	  , 'AVR'	        = rsvalmerc-rsvppresen
	  , 'FechaEmicion'  = text_rsu.rsfecemis
	  , 'FechaVenc'     = text_rsu.rsfecvcto
	--  , 'TipoEmicion'   = view_emisor.emtipo
	--  , 'ValorPresente' = text_rsu.rsvppresenx
	  , 'TipoEmicion'   = CASE WHEN familia.Nom_Familia = 'CD' THEN 'CD' ELSE (CASE view_emisor.emtipo WHEN 3 THEN 'SOBERANOS' WHEN 4  THEN 'FEDERALES' ELSE 'EMPRESA' END) END 
INTO   #tmpRentaFijaExt
FROM    BacBonosExtSuda.dbo.text_rsu AS text_rsu INNER JOIN
        BacBonosExtSuda.dbo.view_emisor AS view_emisor ON text_rsu.rsrutemis = view_emisor.emrut INNER JOIN
        BacBonosExtSuda.dbo.view_moneda AS view_moneda ON text_rsu.rsmonemi = view_moneda.MNCODMON INNER JOIN
        BacBonosExtSuda.dbo.text_fml_inm AS familia ON text_rsu.cod_familia = familia.Cod_familia
WHERE        (text_rsu.rsfecpro = @FechaProcesoAnt) AND (text_rsu.rstipoper = 'dev')


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
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'BTREX') AND (r.IdTipoCriterio IS NOT NULL)
	      AND pf.Sistema = 'BTREX'

--	select * from #tmpParamSelect


-------------------------------- WHERE CAMPOS DINAMICOS ---------------------------------------------------

-- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'BTREX')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhereRFExt     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''BTREX'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
   -- EXEC('select * from ##tmpParamWhereRFExt ')
  --  print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
   INSERT INTO #tmpParametros 
   SELECT  rf.CodIBS , pw.AVR        + ' ' +   ' = ' + pw.AVR
    + ' AND ' + pw.Cartera    + ' = '''+ rf.Cartera 
	+ ''' AND '+ pw.Moneda     + ' = '''+ rf.Moneda 
	+ ''' AND '+ pw.TipoEmicion + ' = '''+ CASE RTRIM(rf.TipoEmisor) WHEN 3 THEN 'SOBERANOS' 
																	 WHEN 4  THEN 'FEDERALES' 
																	 WHEN 6  THEN 'UC' ELSE 'EMPRESA' END + ''''
	 AS ParamWhere 
   , CASE WHEN  ps.IdTipoCriterio = 10 THEN ps.Parametros + ' * ' + RTRIM(@Dolar) 
		  ELSE ps.Parametros END AS ParamSelect 
   ,  + rf.Moneda  AS ParamMoneda
   FROM ##tmpParamWhereRFExt AS pw INNER JOIN   #tmpParamSelect AS ps ON pw.IdTipoCriterio = ps.IdTipoCriterio
		AND pw.Sistema = ps.Sistema INNER JOIN   dbo.Parametros_Detalle_RentaFija AS rf ON pw.Sistema = rf.Sistema 
		AND pw.IdTipoCriterio = rf.TipoCriterio AND ps.CodIBS = rf.CodIBS 


--  SELECT * FROM  #tmpParametros order by CodIBS



------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
Declare @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @ParamMoneda as varchar(10) 


	DELETE CuadraturaContableDerivados WHERE Sistema = @Sistema

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
						     ISNULL(SUM('+ @ParamSelect+'),0),  
						  ' + ' 0 AS saldoIBS ,' +
						   ''''+ @ParamMoneda  +''',' +
						  ''''+ @Sistema  +''',' +
						  '' + ' 0' +
			     ' FROM #tmpRentaFijaExt'+ 
				 ' WHERE  ' + @ParamWhere)


------- **********************************************************************************
			--print (' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
			--				+ ''''+ @FechaProcesoAnt +''' ,
			--			   '+      RTRIM(@CodIBS) + ' , 
			--			     ISNULL(SUM('+ @ParamSelect+'),0),  
			--			  ' + ' 0 AS saldoIBS ' +
			--			  '' + ' 0' +
			--     ' FROM #tmpRentaFijaExt'+ 
			--	 ' WHERE  ' + @ParamWhere)

    		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect , @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  

	  EXEC('DROP TABLE ##tmpParamWhereRFExt')
	
--	-- SELECT * FROM CuadraturaContableDerivados


  END

GO

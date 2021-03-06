USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Pactos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [dbo].[CuadraturaContable_Pactos]
AS

 DECLARE @FechaProceso CHAR(8)  
 DECLARE @FechaProcesoAnt CHAR(8)    
 DECLARE @Sistema AS VARCHAR(10)
 
 SELECT @FechaProcesoAnt = CONVERT(CHAR(8),acfecante,112) FROM Bacfwdsuda..mfac 
 SELECT @FechaProceso    = CONVERT(CHAR(8),acfecproc,112) FROM Bacfwdsuda..mfac 

 
-- Solo para prueba y validación de data en CorpSql05
-- SET @FechaProcesoAnt =  '20140107'
-- SET @FechaProceso    =  '20140108'
 SET @Sistema	     = 'PACTOS'

BEGIN
-- tabla de Parametros
 CREATE TABLE #tmpParametros
	(
		CodIBS      int,
		ParamWhere	nvarchar(max),
		ParamSelect	varchar(50),
		ParamMoneda varchar(10),
	)


-- QUERY PRINCIPAL
	SELECT  'Fecha'		       =  MDRS.rsfecha
		  , 'FechaInicio'      =  MDRS.rsfecinip
		  , 'Rut'			   =  MDRS.rsrutcli
		  , 'Nombre'		   =  c.Clnombre
		  , 'NumOper'		   =  MDRS.rsnumoper
		  , 'Moneda'		   =  m.mnnemo
		  , 'Serie'		       =  i.inserie
		  , 'Emisor'		   =  MDRS.rsrutemis
		  , 'Instrumento'      =  MDRS.rsinstser
		  , 'Nominal'		   =  MDRS.rsnominal
		  , 'ValorInicio'      =  MDRS.rsvalinip
		  , 'Tasa'	           =  MDRS.rstaspact
		  , 'FechaVencimiento' =  MDRS.rsfecvtop
		  , 'Cartera'          =  MDRS.rscartera
		  , 'TipoCliente'      =  c.Cltipcli
	INTO #tmpPactos
	FROM    BacTraderSuda.dbo.MDRS AS MDRS with (nolock)  INNER JOIN
			BacTraderSuda.dbo.VIEW_CLIENTE AS c with (nolock) ON   MDRS.rsrutcli = c.Clrut AND MDRS.rscodcli = c.Clcodigo INNER JOIN
			BacTraderSuda.dbo.VIEW_MONEDA AS m with (nolock) ON   MDRS.rsmonpact = m.mncodmon INNER JOIN
			BacTraderSuda.dbo.VIEW_INSTRUMENTO AS i  with (nolock)  ON MDRS.rscodigo = i.incodigo
	WHERE   (MDRS.rsfecha = @FechaProceso) AND (MDRS.rstipoper = 'dev')
			AND (MDRS.rscartera IN ('112', '115')) AND (MDRS.rsrutcli <> 97029000)
	ORDER BY MDRS.rsinstser


-- select * from #tmpPactos
--------------------------------------------------------------------------------------------------------
------------------------------ SELECT CAMPOS DINAMICOS -------------------------------------------------
	SELECT c.Sistema, c.IdParametros, Parametros
	, r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc with (nolock) INNER JOIN
	  		dbo.Parametros_CriterioContable_TipoCriterio AS r with (nolock)  ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  		dbo.Parametros_Detalle_Pactos AS pf with (nolock)  ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
			dbo.Parametros_CriterioContable AS c with (nolock)  ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'PACTOS') AND (r.IdTipoCriterio IS NOT NULL)
	      AND pf.Sistema = 'PACTOS'

--	select * from #tmpParamSelect


------------------------------ WHERE CAMPOS DINAMICOS ---------------------------------------------------
-- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	DECLARE  @strSQLParamWHERE  VARCHAR(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'PACTOS')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhere     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc with (nolock) INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r with (nolock) ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c with (nolock) ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''PACTOS'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)


 -- Entrega de parametros @ParamSelect -¨@ParamWhere - @ParamMoneda paraCursor
    INSERT INTO #tmpParametros 
	SELECT   p.CodIBS
	     ,  pw.Moneda + ' = '''+  p.Moneda
		 + ''' AND ' + pw.Cartera+ ' = '+ p.Cartera 
		-- + ' AND ' + pw.Serie+ ' =  '''+ p.Serie + ''''
		+ ' AND ' + pw.Serie+ ' =  '+ CASE WHEN  p.Serie = '0' THEN pw.Serie ELSE  ''''+ p.Serie + '''' END 
          AS ParamWhere
		 ,  + ps.Parametros AS ParamSelect 
		 ,  + p.Moneda      AS ParamMoneda
	 FROM ##tmpParamWhere AS pw INNER JOIN #tmpParamSelect AS ps ON 
	      pw.IdTipoCriterio = ps.IdTipoCriterio AND pw.Sistema = ps.Sistema INNER JOIN 
		  dbo.Parametros_Detalle_Pactos AS p ON pw.Sistema = p.Sistema AND pw.IdTipoCriterio = p.TipoCriterio AND ps.CodIBS = p.CodIBS

 -- SELECT * FROM  #tmpParametros order by CodIBS


-------------------------------------------------------------------------------------------------------------
---------------------------------- CURSOR -------------------------------------------------------------------
	DECLARE @CodIBS AS INT, @ParamWhere AS VARCHAR(MAX), @ParamSelect AS VARCHAR(50) , @ParamMoneda AS VARCHAR(10) 

	DELETE CuadraturaContableDerivados WHERE Sistema = @Sistema

	DECLARE cur CURSOR LOCAL READ_ONLY FAST_FORWARD FOR   
	SELECT DISTINCT CodIBS, ParamWhere, ParamSelect, ParamMoneda
	FROM #tmpParametros

	OPEN cur
	FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
	WHILE @@FETCH_STATUS = 0
	BEGIN

	    	INSERT INTO CuadraturaContableDerivados 
		    EXEC(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
							+ ''''+ @FechaProcesoAnt +''' ,
						   '+       @CodIBS + ' , 
						     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
						  ' + ' 0 AS saldoIBS ,' +
						  ''''+ @ParamMoneda  +''',' +
						  ''''+ @Sistema  +''',' +
						  '' + ' 0' +
			     ' FROM #tmpPactos'+ 
				 ' WHERE  ' + @ParamWhere)


----- **********************************************************************************
			--PRINT (' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
			--				+ ''''+ @FechaProcesoAnt +''' ,
			--				'+      RTRIM(@CodIBS) + ' , 
			--			     ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
			--			  ' + ' 0 AS saldoIBS , ' +
			--			    ''''+ @ParamMoneda  +''',' +
			--				''''+ @Sistema  +''',' +
			--			    '' + ' 0' +					  
			--     ' FROM #tmpPactos'+ 
			--	 ' WHERE  ' + @ParamWhere)

   		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  
 

	DROP TABLE ##tmpParamWhere


END

GO

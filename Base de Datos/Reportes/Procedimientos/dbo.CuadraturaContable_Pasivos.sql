USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Pasivos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[CuadraturaContable_Pasivos]
AS
BEGIN

 DECLARE @Sistema AS VARCHAR(10)
 DECLARE @FechaProceso AS CHAR(8)
 DECLARE @FechaProcesoAnt AS CHAR(8)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT

 SELECT @FechaProcesoAnt = CONVERT(CHAR(8),acfecante,112) FROM Bacfwdsuda..mfac 
 SELECT @FechaProceso    = CONVERT(CHAR(8),acfecproc,112) FROM Bacfwdsuda..mfac 
 
 --SET @FechaProceso = '20130614' -- '20150414'
 --SET @FechaProcesoAnt = '20130613' --'20150413'
 SET @Sistema = 'PASIVOS'


  CREATE TABLE #tmpParametros
	(
		CodIBS      int,
		ParamWhere	nvarchar(max),
		ParamSelect	varchar(200),
		ParamMoneda varchar(10),
	)


-- QUERY COMPILADO DE DATOS
	SELECT 
		   'Serie'				     =  cp.nombre_serie 
		 , 'Valor_emision_pesos'     =  ISNULL(ABS(SUM(cp.valor_emision_pesos)),0)    -- H / Corfo - P - Capital Pesos 
		 , 'Reajuste_emision'	     =  ISNULL(ABS(SUM(cp.reajuste_emision)),0)       -- O / Corfo - T - reajuste pesos
		 , 'Descuento'			     =  ISNULL(ABS(SUM(cp.descuento)),0)			    -- I
		 , 'Interesdiaemision'       =  ISNULL(rp.interesdiaemision,0)			    -- L
		 , 'Interes_emision'         =  ISNULL(cp_diaAnt.interes_emision,0)		    -- N
		 , 'Valor_emision'		     =  ISNULL(rp.valor_emision,0)				    -- CORFO P - Capital Pesos		
		 , 'Interes_emision_actual'	 =  ISNULL(SUM(ISNULL(cp.interes_emision,0)),0)				-- Corfo - R
		 , 'Moneda'				     =  cp.moneda_emision 
		 , 'NemoMoneda'			     =  m.mnnemo
		 , 'Tipo_Bono'		         =  ISNULL(sp.Tipo_Bono,'')
	     , 'Numero_amortizacion'	 =  ISNULL(sp.numero_amortizacion, 0) 
		 , 'Interes_dia'		     =  ISNULL(ABS(ISNULL(cp_diaAnt.interes_emision,0)) + ABS(ISNULL(rp.interesdiaemision,0)),0)
		 , 'Interes_emision_V0808'   =  CASE WHEN  cp.nombre_serie  = 'UCOR-V0808'  THEN  ABS(ISNULL(cp_diaAnt.interes_emision,0))  ELSE 0  END 
		 , 'Interesdiaemision_V0808' =  CASE WHEN  cp.nombre_serie  = 'UCOR-V0808'  THEN  ABS(ISNULL(rp.interesdiaemision,0))	    ELSE 0  END  --Interesdiaemision
		 , 'Valor_emision_V0808'     =  CASE WHEN  cp.nombre_serie  = 'UCOR-V0808'  THEN  ABS(ISNULL(rp.valor_emision,0))	        ELSE 0  END  
		 , 'Descuento_V0808'		 =  CASE WHEN  cp.nombre_serie  = 'UCOR-V0808'  THEN  SUM(ISNULL(cp.descuento,0))	            ELSE 0  END  
 INTO #tmpPasivos
 FROM   MDPasivo.dbo.CARTERA_PASIVO_HISTORICA AS cp INNER JOIN
        (SELECT        nombre_serie, SUM(interesdiaemision) AS interesdiaemision, SUM(valor_emision) AS valor_emision
         FROM            MDPasivo.dbo.RESULTADO_PASIVO
         WHERE        (fecha_calculo = @FechaProcesoAnt) AND (tipo_operacion = 'DEV')
         GROUP BY nombre_serie) AS rp ON cp.nombre_serie = rp.nombre_serie INNER JOIN
        (SELECT        nombre_serie, SUM(interes_emision) AS interes_emision
         FROM            MDPasivo.dbo.CARTERA_PASIVO_HISTORICA
         WHERE        (fecha_cartera = @FechaProcesoAnt)
         GROUP BY nombre_serie) AS cp_diaAnt ON cp.nombre_serie = cp_diaAnt.nombre_serie INNER JOIN
    Bacfwdsuda.dbo.VIEW_MONEDA AS m ON cp.moneda_emision = m.mncodmon LEFT OUTER JOIN
    MDPasivo.dbo.SERIE_PASIVO AS sp ON cp.nombre_serie = sp.nombre_serie
WHERE        (cp.fecha_cartera = @FechaProceso)
GROUP BY cp.nombre_serie, rp.interesdiaemision, sp.Tipo_Bono, cp_diaAnt.interes_emision, rp.valor_emision, cp.moneda_emision, cp.moneda_emision, 
							sp.numero_amortizacion, m.mncodmon, m.mnnemo





	-- SELECT * FROM #tmpPasivos
--------------------------------------------------------------------------------------------------------
------------------------------ SELECT CAMPOS DINAMICOS -------------------------------------------------

---- Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros
		 , c.Parametros 
		 , r.IdTipoCriterio
		 , tc.nombre
		 , pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  	   dbo.Parametros_Detalle_Pasivos AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
		   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'PASIVOS')  AND (r.IdTipoCriterio IS NOT NULL)



--	select * from Parametros_Detalle_Pasivos where tipoCriterio = 18  --348002001
--  select * from #tmpParamSelect

------------------------------ WHERE CAMPOS DINAMICOS ---------------------------------------------------

 -- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS [' + RTRIM(Parametros) + ']'  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'PASIVOS')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhere     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''PASIVOS'')	AND TipoConsulta = ''W'''  +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
 --  EXEC('select * from ##tmpParamWhere ')
  -- print @strSQLParamWHERE
 
  -- CAMPOS CON Q COMPARAR EL WHERE
	 INSERT INTO #tmpParametros   
	 SELECT   pf.CodIBS,  pw.[Serie] + '  ' +  CASE WHEN RIGHT(pf.NombreSerie,1)  =  '*' THEN 'like''%''+SUBSTRING('''+  pf.NombreSerie +''', 0,LEN('''+  pf.NombreSerie +'''))+''%'     
																				          ELSE '= '''+  pf.NombreSerie +''   END 
		 + ''' AND Numero_amortizacion = '   +  CASE WHEN  pf.CodIBS = '419002001' THEN '40' 
													 WHEN  RIGHT(pf.NombreSerie,1) =  '*'  THEN  'Numero_amortizacion' 
													                   					   ELSE  'Numero_amortizacion'  END 


		 +  CASE  WHEN pf.TipoCriterio IN(26,28,30) THEN  ' AND Moneda = 998 '  -- UF
		          WHEN pf.TipoCriterio IN(27,29,31) THEN  ' AND Moneda = 994 '  -- DO
				  WHEN pf.TipoCriterio IN(33)       THEN  ' AND Moneda = 999 '  -- CLP
		    ELSE  ' '  END AS paramWhere

		 --, +  ps.Parametros AS ParamSelect 
		  --CASE WHEN  pf.CodIBS = '419002003' THEN (SELECT Parametros FROM  Parametros_CriterioContable  WHERE IdParametros = 63)  
				--  WHEN  pf.CodIBS = '419002005' THEN (SELECT Parametros FROM  Parametros_CriterioContable  WHERE IdParametros = 63)
				--								ELSE   
		, +	ps.Parametros AS ParamSelect 
			-- END AS ParamSelect 
		 --,  +      CASE WHEN ps.IdParametros = 1 THEN  pf.MonedaActiva 
		 --     ELSE CASE WHEN ps.IdParametros = 2 THEN  pf.MonedaPasiva 
			--  ELSE CASE WHEN ps.IdParametros = 3 THEN 'CLP' 	
		 --END END END AS ParamMoneda
		 ,  +   CASE  WHEN pf.TipoCriterio IN(26,28,30) THEN '998'  -- UF
		              WHEN pf.TipoCriterio IN(27,29,31) THEN '994'  -- DO
				      WHEN pf.TipoCriterio IN(33)       THEN '999'  -- CLP
				ELSE  ' '  END AS  ParamMoneda
	 FROM ##tmpParamWhere AS pw INNER JOIN #tmpParamSelect AS ps ON 
	      pw.IdTipoCriterio = ps.IdTipoCriterio AND pw.Sistema = ps.Sistema INNER JOIN 
		  dbo.Parametros_Detalle_Pasivos AS pf ON pw.Sistema = pf.Sistema AND pw.IdTipoCriterio = pf.TipoCriterio AND ps.CodIBS = pf.CodIBS

 -- PRINT @strSQLParamWHERE
 -- SELECT * FROM  #tmpParametros order by CodIBS
 -- select * from Parametros_Detalle_Pasivos 


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
	DECLARE @CodIBS AS INT, @ParamWhere AS VARCHAR(MAX), @ParamSelect AS VARCHAR(200) , @ParamMoneda AS VARCHAR(10) 

	DELETE CuadraturaContableDerivados WHERE Sistema = @Sistema

	DECLARE cur CURSOR LOCAL READ_ONLY FAST_FORWARD FOR   
	SELECT DISTINCT CodIBS, ParamWhere, ParamSelect, ParamMoneda
	FROM #tmpParametros

	OPEN cur
	fetch next from cur into @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
	while @@FETCH_STATUS = 0
	Begin

	    	INSERT INTO CuadraturaContableDerivados --#tmpResult  			
		    EXEC(' SELECT ' + ''''+ @FechaProceso +''' ,' 
							+ ''''+ @FechaProceso +''' ,
						   '+       @CodIBS + ' , 
						   '+		@ParamSelect+',  
						  ' + ' 0 AS saldoIBS ,' +
						  'NemoMoneda,' +
						  ''''+ @Sistema  +''',' +
						  '' + ' 0' +
			     ' FROM #tmpPasivos'+ 
				 ' WHERE  ' + @ParamWhere +
				 ' GROUP BY NemoMoneda')

----- **********************************************************************************
			--print (' SELECT ' + ''''+ @FechaProceso +''' ,' 
			--				+ ''''+ @FechaProceso +''' ,'+      RTRIM(@CodIBS) + ' , 
			--			    ' +		@ParamSelect+',  
			--				' + ' 0 AS saldoIBS ,' +
			--			  'NemoMoneda,' +
			--			  ''''+ @Sistema  +''',' +
			--			  '' + ' 0' + 
			--     ' FROM #tmpPasivos'+ 
			--	 ' WHERE  ' + @ParamWhere +
			--	 ' GROUP BY NemoMoneda')

   		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  

	DROP TABLE ##tmpParamWhere

  END

GO

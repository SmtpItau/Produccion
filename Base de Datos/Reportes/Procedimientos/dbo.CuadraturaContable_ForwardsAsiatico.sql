USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_ForwardsAsiatico]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaContable_ForwardsAsiatico]
AS
BEGIN 

 
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT
 DECLARE @FechaProcesoAnt CHAR(8)
 
 SELECT  @FechaProcesoAnt = [fechaant] FROM [CbMdbOpc].[dbo].[OpcionesGeneral]
 -- SET @FechaProcesoAnt = '20140110'


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

-- QUERY COMPILADO DE DATOS  - El llamado a los BFW Asiatico, esta compuesta por la cartera Opciones pero con el cód. estructura = 6
	SELECT DISTINCT
		  'Fecha_Respaldo'         = E.CaEncFechaRespaldo
		, 'Nro_Contrato'	       = E.CaNumContrato
		, 'Nro_Corr'	           = 0
		, 'EstCod'		           = E.CaEstado
		, 'EstructuraCod'          = E.CaCodEstructura
		, 'CarteraFinancieraCod'   = E.CaCarteraFinanciera
		, 'LibroCod'			   = E.CaLibro
		, 'CarteraNormativaCod'    = E.CaCarNormativa
		, 'SubCarteraNormativaCod' = E.CaSubCarNormativa
		, 'PayOffCod'              = '02'
		, 'CallPut'                = 'no ap'
		, 'CompraVenta'            = E.CaCVEstructura
		, 'FechaInicio'            = E.CaFechaContrato
		, 'FechaVcto'	           = D.CaFechaVcto
		, 'FechaEjercicio'         = D.CaFechaPagoEjer
		, 'MonedaSubyacente'       = D.CaCodMon1
		, 'Monto'		           = D.CaMontoMon1
		, 'CaMontoMon2'            = D.CaMontoMon2
		, 'PrecioStrike'           = D.CaStrike
		, 'Modalidad'              = D.CaModalidad
		, 'ValorRazonable'         = E.CaVr
		, 'PrimaInicialDet'        = E.CaPrimaInicialML
		, 'OpcEstDsc'              = O.OpcEstDsc
	INTO #tmpFwrAsiatico
	FROM  CbMdbOpc.dbo.CaRESDetContrato D
		, CbMdbOpc.dbo.CaRESEncContrato E
		, CbMdbOpc.dbo.OpcionEstructura O
	WHERE E.CaNumContrato = D.CaNumContrato
	  AND D.CaDetFechaRespaldo = E.CaEncFechaRespaldo 
	  AND E.CaCodEstructura = O.OpcEstCod 
	  AND ((E.CaCodEstructura = 6) 
	  AND (E.CaEncFechaRespaldo = @FechaProcesoAnt ) 
	  AND (D.CaFechaVcto > E.CaEncFechaRespaldo) 
	  AND (D.CaFechaPagoEjer > E.CaEncFechaRespaldo))

----------------------------------------------------------------------------------------------------------
-------------------------------- SELECT CAMPOS DINAMICOS -------------------------------------------------

------ Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros
		 , c.Parametros
		 , r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  		dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  		dbo.Parametros_Detalle_BFWAsisatico AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
			dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'BFWAS') AND (r.IdTipoCriterio IS NOT NULL)


-- select * from #tmpParamSelect



---------------------------------- WHERE CAMPOS DINAMICOS ---------------------------------------------------
---- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS '+ RTRIM(Parametros) +''  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'BFWAS')  AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhereBFWAS     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''BFWAS'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
  -- EXEC('select * from ##tmpParamWhereBFWAS')
  -- print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
     INSERT INTO #tmpParametros 
     SELECT   pOp.CodIBS  
			 , pw.CompraVenta + ' = '+ CASE WHEN pOp.CompraVenta <> 3 THEN +''''+ RTRIM(pOp.CompraVenta) +''''  ELSE pw.CompraVenta   END
			 + ' AND ' +  pw.CarteraNormativaCod + ' = ''' + pOp.CarteraNormativa 
			 + ''' AND ' + pw.ValorRazonable + ' ' +   CASE WHEN  pw.IdTipoCriterio = 5 THEN  '> 0'
														    WHEN  pw.IdTipoCriterio = 6 THEN  '< 0' 
													 ELSE ' = '+ pw.ValorRazonable END   AS paramWhere
	          , ps.Parametros AS ParamSelect 
			  ,  +      CASE  ps.IdParametros WHEN 30 THEN 'CLP'
							                  WHEN 31 THEN 'CLP'
										      WHEN 32 THEN 'CLP' END AS ParamMoneda
	FROM ##tmpParamWhereBFWAS AS pw INNER JOIN #tmpParamSelect AS ps ON pw.IdTipoCriterio = ps.IdTipoCriterio 
		 AND pw.Sistema = ps.Sistema INNER JOIN Parametros_Detalle_BFWAsisatico AS pOp ON pw.Sistema = pOp.Sistema 
		 AND pw.IdTipoCriterio = pOp.TipoCriterio AND ps.CodIBS = pOp.CodIBS

  -- SELECT * FROM #tmpParametros
	
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
Declare @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @Sistema AS VARCHAR(10) , @ParamMoneda as varchar(10) 
SET @Sistema = 'BFWAS'

	DELETE CuadraturaContableDerivados WHERE Sistema = 'BFWAS'

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
						  ' + ' 0 AS saldoIBS  ,' +
						   ''''+ @ParamMoneda  +''',' +
						   ''''+ @Sistema  +''', ' +
						  '' + '0' +
			     ' FROM #tmpFwrAsiatico'+ 
				 ' WHERE  ' + @ParamWhere)


----- **********************************************************************************
--				 --   print(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
--					--		+ ''''+ @FechaProcesoAnt +''' ,
--					--	   '+       RTRIM(@CodIBS) + ' , 
--					--	     ISNULL(SUM('+ @ParamSelect+'),0),  
--					--	  ' + ' 0 AS saldoIBS  ,' +
--					--	   ''''+ @ParamMoneda  +''',' +
--					--	  ''''+ @Sistema  +''',' +
--					--      '' + ' 0' +
--			  --   ' FROM #tmpFwrAsiatico'+ 
--				 --' WHERE  ' + @ParamWhere)

    		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect , @ParamMoneda
 
	END

CLOSE cur   
DEALLOCATE cur  

DROP TABLE ##tmpParamWhereBFWAS

--	 SELECT * FROM CuadraturaContableDerivados


  END

GO

USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Opciones]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   



CREATE PROCEDURE [dbo].[CuadraturaContable_Opciones]
AS
BEGIN 

 DECLARE @FechaProcesoAnt AS CHAR(8)
 DECLARE @strSQL AS Varchar(MAX)
 DECLARE  @strSQLParamSelect  varchar(MAX)
 DECLARE @ValorUF AS FLOAT

 SELECT  @FechaProcesoAnt =  CONVERT(CHAR(8),[fechaant],112) FROM [CbMdbOpc].[dbo].[OpcionesGeneral]
 --SET @FechaProcesoAnt = '20140414'


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
SELECT    'Fecha_Respaldo'        = E.CaEncFechaRespaldo
		, 'Nro_Contrato'          = D.CaNumContrato
		, 'Nro_Corr'              = D.CaNumEstructura
		, 'EstCod'		          = E.CaEstado
		, 'EstructuraCod'         = E.CaCodEstructura
		, 'CarteraFinancieraCod'  = E.CaCarteraFinanciera
		, 'LibroCod'	          = E.CaLibro
		, 'CarteraNormativaCod'   = E.CaCarNormativa
		, 'SubCarteraNormativaCod'= E.CaSubCarNormativa
		, 'PayOffCod'             = D.CaTipoPayOff
		, 'CallPut'	              = D.CaCallPut
		, 'CompraVenta'           = D.CaCVOpc
		, 'FechaInicio'           = D.CaFechaInicioOpc
		, 'FechaVcto'	          = D.CaFechaVcto
		, 'FechaEjercicio'	      = D.CaFechaPagoEjer
		, 'MonedaSubyacente'      = D.CaCodMon1
		, 'Monto'		          = D.CaMontoMon1
		, 'CaMontoMon2'           = D.CaMontoMon2
		, 'PrecioStrike'          = D.CaStrike
		, 'Modalidad'	          = D.CaModalidad
		, 'ValorRazonable'        = D.CaVrDet
		, 'PrimaInicialDet'       = D.CaPrimaInicialDetML
		, 'OpcEstDsc'		      = O.OpcEstDsc
		, 'Filtro'                = CASE WHEN E.CaEstado <> 'C' THEN CASE WHEN   D.CaVrDet > 0 THEN '+' + D.CaCVOpc +  D.CaCallPut +  E.CaCodEstructura  ELSE '-' + D.CaCVOpc +  D.CaCallPut +  E.CaCodEstructura END ELSE 'C' END 
INTO #tmpCartOpciones
FROM   CbMdbOpc.dbo.CaResDetContrato AS D INNER JOIN
       CbMdbOpc.dbo.CaResEncContrato AS E ON D.CaNumContrato = E.CaNumContrato AND D.CaDetFechaRespaldo = E.CaEncFechaRespaldo INNER JOIN
       CbMdbOpc.dbo.OpcionEstructura AS O ON E.CaCodEstructura = O.OpcEstCod
WHERE  (E.CaCodEstructura <> 6) 
		AND (E.CaEncFechaRespaldo = @FechaProcesoAnt) 
		AND (D.CaFechaVcto > @FechaProcesoAnt) 
		AND (D.CaFechaPagoEjer > @FechaProcesoAnt)


----------------------------------------------------------------------------------------------------------
-------------------------------- SELECT CAMPOS DINAMICOS -------------------------------------------------

------ Obtiene los parametros relacionados al tipo de criterio (SELECT)
	SELECT c.Sistema, c.IdParametros
		, c.Parametros
		, r.IdTipoCriterio, tc.nombre, pf.CodIBS
	INTO   #tmpParamSelect
	FROM   dbo.Parametros_TipoCriterio AS tc INNER JOIN
	  	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio INNER JOIN
	  	   dbo.Parametros_Detalle_Opciones AS pf ON tc.IdTipoCriterio = pf.TipoCriterio RIGHT OUTER JOIN
		   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros
	WHERE  (c.TipoConsulta = 'S') AND (c.Sistema = 'OPT') AND (r.IdTipoCriterio IS NOT NULL)

--	select * from #tmpParamSelect

------------------------------------ WHERE CAMPOS DINAMICOS ---------------------------------------------------

---- Obtiene los parametros relacionados al tipo de criterio (WHERE)   -  CAMPOS PARA WHERE
	Declare  @strSQLParamWHERE  varchar(MAX)

	SET @strSQLParamWHERE = ' SELECT c.Sistema, r.IdTipoCriterio, ' + 
							' ISNULL(MAX(CASE WHEN tc.nombre IS NOT NULL THEN tc.nombre ELSE ''-'' END), ''0'') AS tipoCriterio '	
	SELECT     @strSQLParamWHERE = @strSQLParamWHERE +
							', ISNULL(MAX(CASE WHEN c.IdParametros = ' + RTRIM(IdParametros) +' THEN c.Parametros ELSE ''-'' END), ''0'') AS '+ RTRIM(Parametros) +''  	    
	FROM Parametros_CriterioContable 
	WHERE (Sistema = 'OPT') AND TipoConsulta = 'W'

	SET @strSQLParamWHERE = @strSQLParamWHERE +
					   '     INTO ##tmpParamWhereOpc     '+
					   '     FROM  dbo.Parametros_TipoCriterio AS tc INNER JOIN ' +
					   '	   dbo.Parametros_CriterioContable_TipoCriterio AS r ON tc.IdTipoCriterio = r.IdTipoCriterio RIGHT OUTER JOIN ' +
					   '	   dbo.Parametros_CriterioContable AS c ON r.IdParametros = c.IdParametros ' +
					   ' WHERE        (c.Sistema = ''OPT'')			AND TipoConsulta = ''W''' +
					   ' GROUP BY c.Sistema, r.IdTipoCriterio  '

   EXEC (@strSQLParamWHERE)
  --EXEC('select * from ##tmpParamWhereOpc')
 -- print @strSQLParamWHERE


  -- CAMPOS CON Q COMPARAR EL WHERE
     INSERT INTO #tmpParametros 
     SELECT pOp.CodIBS  , pw.CompraVenta    + ' = ''' + CASE WHEN pOp.CompraVenta    = 1  THEN 'C'    ELSE 'V'   END 
	        + ''' AND ' + pw.CallPut        + ' = ''' + CASE WHEN pOp.CallPut        = 1  THEN 'CALL' ELSE 'PUT' END 
			+ ''' AND ' + pw.EstructuraCod  + ' = '   + CASE WHEN pOp.EstructuraCod  = 0  THEN 'EstructuraCod'   ELSE  RTRIM(pOp.EstructuraCod) END  
			+ ' AND '   + pw.ValorRazonable + ' '     + CASE WHEN  pw.IdTipoCriterio = 19 THEN '> 0' 
															 WHEN  pw.IdTipoCriterio = 20 THEN '< 0' ELSE ' = '+ pw.ValorRazonable END  AS paramWhere 
			, ps.Parametros AS ParamSelect 
			, +  CASE ps.IdParametros WHEN 23 THEN 'CLP'  
									  WHEN 24 THEN 'USD' 
									  WHEN 25 THEN 'CLP' END AS ParamMoneda
	FROM ##tmpParamWhereOpc AS pw INNER JOIN #tmpParamSelect AS ps ON pw.IdTipoCriterio = ps.IdTipoCriterio 
		AND pw.Sistema = ps.Sistema INNER JOIN Parametros_Detalle_Opciones AS pOp ON pw.Sistema = pOp.Sistema 
		AND pw.IdTipoCriterio = pOp.TipoCriterio AND ps.CodIBS = pOp.CodIBS


 --   SELECT * FROM  #tmpParametros order by CodIBS

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
Declare @CodIBS as int, @ParamWhere as varchar(MAX), @ParamSelect as varchar(50) , @Sistema AS VARCHAR(10), @ParamMoneda as varchar(10) 
SET @Sistema = 'OPT'

	DELETE CuadraturaContableDerivados WHERE Sistema = 'OPT'

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
					      ''''+ @Sistema  +''', ' +
						  '' + ' 0' +
			     ' FROM #tmpCartOpciones'+ 
				 ' WHERE  ' + @ParamWhere )


--- **********************************************************************************
				   -- print(' SELECT ' + ''''+ @FechaProcesoAnt +''' ,' 
							--+ ''''+ @FechaProcesoAnt +''' ,
						 --  '+       RTRIM(@CodIBS) + ' , 
						 --    ABS(ISNULL(SUM('+ @ParamSelect+'),0)),  
						 -- ' + ' 0 AS saldoIBS ,' +
					     --  ''''+ @ParamMoneda  +''',' +
						 -- '' + ' 0' +
						 -- ' FROM #tmpCartOpciones'+ 
						 -- ' WHERE  ' + @ParamWhere)

    		FETCH NEXT FROM cur INTO @CodIBS, @ParamWhere, @ParamSelect, @ParamMoneda		  
 
	END

CLOSE cur   
DEALLOCATE cur  

   EXEC('DROP TABLE ##tmpParamWhereOpc')

   --SELECT * FROM CuadraturaContableDerivados


  END

GO

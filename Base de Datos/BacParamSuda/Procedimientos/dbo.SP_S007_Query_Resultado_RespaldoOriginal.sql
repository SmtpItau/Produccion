USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S007_Query_Resultado_RespaldoOriginal]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_S007_Query_Resultado_RespaldoOriginal]
(
    @FechaDesde          DATETIME,
    @FechaHasta          DATETIME,
    @MedaDistibucion     INT = 1,
    @RutCliente          INT = 0
)
AS
BEGIN
	/*
	btr renta fija
	spot
	BFW
	SWAP
	OPCIONES
	*/
	
	SET NOCOUNT ON;
	
	DECLARE @dFechaProceso DATETIME
	SET @dFechaProceso = (
	        SELECT acfecproc
	        FROM   BacTraderSuda.dbo.MDAC WITH(NOLOCK)
	    );
	
	DECLARE @dFechaAnterior DATETIME
	SET @dFechaAnterior = (
	        SELECT acfecante
	        FROM   BacTraderSuda.dbo.MDAC WITH(NOLOCK)
	    );
	
	DECLARE @Tipo_Cambio DECIMAL
	SET @Tipo_Cambio = (
	        SELECT Tipo_Cambio
	        FROM   BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc
	        WHERE  vmc.Codigo_Moneda = 994
	               AND vmc.Fecha = (
	                       SELECT acfecante
	                       FROM   BacTraderSuda.dbo.VIEW_MFAC
	                   )
	    );
	
	CREATE TABLE #RESULTADOS_MESA
	(
		Modulo                CHAR(3),
		Producto              VARCHAR(50),
		Numero_Operacion      NUMERIC(9),
		Documento             NUMERIC(9),
		Correlativo           NUMERIC(21, 4),
		Serie                 VARCHAR(20),
		RutCliente            NUMERIC(12),
		CodCliente            INT,
		DvCliente             CHAR(1),
		NombreCliente         VARCHAR(150),
		TipoOperacion         VARCHAR(25),
		Monto                 NUMERIC(21, 4),
		MonTransada           CHAR(3),
		MonConversion         CHAR(3),
		TCCierre              NUMERIC(21, 4),
		TCCosto               NUMERIC(21, 4),
		ParidadCierre         NUMERIC(21, 4),
		ParidadCosto          NUMERIC(21, 4),
		MontoPesos            NUMERIC(21, 4),
		Operador              VARCHAR(15),
		MontoDolares          NUMERIC(21, 4),
		ResultadoMesa         NUMERIC(21, 4),
		Fecha                 DATETIME --> CHAR(10)
		,
		Relacionado           VARCHAR(35),
		FolioRelacionado      NUMERIC(9),
		FechaEmision          DATETIME,
		FechaVencimiento      DATETIME,
		SegmentoComercial     INT
	);
	
	
	CREATE INDEX #ix_orden ON #RESULTADOS_MESA(
	    fecha,
	    Modulo,
	    Producto,
	    RutCliente,
	    CodCliente,
	    Numero_Operacion,
	    Documento,
	    Correlativo
	);
	
	/* btr renta fija  */
	INSERT INTO #RESULTADOS_MESA
	EXEC SP_S007_Query_Resultado_C_BTR
	     @FechaDesde,
	     @FechaHasta,
	     @dFechaProceso,
	     @Tipo_Cambio;
	
	/* spot */
	INSERT INTO #RESULTADOS_MESA
	EXEC SP_S007_Query_Resultado_C_SPOT
	     @FechaDesde,
	     @FechaHasta,
	     @dFechaProceso;
	
	/* BFW */
	INSERT INTO #RESULTADOS_MESA
	EXEC SP_S007_Query_Resultado_C_BFW
	     @FechaDesde,
	     @FechaHasta,
	     @dFechaProceso,
	     @Tipo_Cambio;
	
	/*  SWAP     */
	INSERT INTO #RESULTADOS_MESA
	EXEC SP_S007_Query_Resultado_C_SWAP
	     @FechaDesde,
	     @FechaHasta,
	     @dFechaProceso;
	
	/*  OPCIONES  */
	INSERT INTO #RESULTADOS_MESA
	EXEC SP_S007_Query_Resultado_C_OPT
	     @FechaDesde,
	     @FechaHasta,
	     @dFechaProceso;
	
	
	/*  Informe Final  */
	
	SELECT Modulo,
	       Producto,
	       Numero_Operacion,
	       'Relacionado' = Relacionado --> CASE WHEN Relacionado = 'S' THEN 'REL. FORWARD' ELSE ' ' END
	       ,
	       'Folio Ref.' = Correlativo --> FolioRelacionado
	       ,
	       Serie,
	       RutCliente,
	       CodCliente,
	       DvCliente,
	       NombreCliente,
	       TipoOperacion,
	       Monto,
	       MonTransada,
	       MonConversion,
	       TCCierre,
	       TCCosto,
	       ParidadCierre,
	       ParidadCosto,
	       MontoPesos,
	       Operador,
	       MontoDolares,
	       ResultadoMesa,
	       Fecha,
	       Documento,
	       Correlativo,
	       FechaEmision,
	       FechaVencimiento,
	       'Otros' AS 'Division_IBS',
	       SegmentoComercial
	       INTO #TMP_RETORNO_ORDENADO
	FROM   #RESULTADOS_MESA
	       INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tgd
	            ON  tgd.tbcateg = CASE 
	                                   WHEN @MedaDistibucion = 1 THEN 9000
	                                   WHEN @MedaDistibucion = 2 THEN 9001
	                                   ELSE 9000
	                              END
	            AND tgd.tbglosa = operador
	WHERE  Modulo <> 'OPT'
	
	UNION
	
	SELECT Modulo,
	       Producto,
	       Numero_Operacion,
	       'Relacionado' = Relacionado --> CASE WHEN Relacionado = 'S' THEN 'REL. FORWARD' ELSE ' ' END
	       ,
	       'Folio Ref.' = Correlativo --> FolioRelacionado
	       ,
	       Serie,
	       RutCliente,
	       CodCliente,
	       DvCliente,
	       NombreCliente,
	       TipoOperacion,
	       Monto,
	       MonTransada,
	       MonConversion,
	       TCCierre,
	       TCCosto,
	       ParidadCierre,
	       ParidadCosto,
	       MontoPesos,
	       Operador,
	       MontoDolares,
	       ResultadoMesa,
	       Fecha,
	       Documento,
	       Correlativo,
	       FechaEmision,
	       FechaVencimiento,
	       'Altos Patrimonios' AS 'Division_IBS',
	       SegmentoComercial
	FROM   #RESULTADOS_MESA
	WHERE  Modulo = 'OPT';
	
	
	IF @RutCliente <> 0
	BEGIN
	    DELETE #TMP_RETORNO_ORDENADO
	    WHERE  RutCliente <> @RutCliente
	END;
	
	--> Para Institucionales se Eliminan las Opciones.
	IF @MedaDistibucion = 2
	BEGIN
	    DELETE 
	    FROM   #TMP_RETORNO_ORDENADO
	    WHERE  Modulo = 'OPT'
	END
	
	
	UPDATE #TMP_RETORNO_ORDENADO
	SET    Division_IBS = 'Altos Patrimonios'
	FROM   PivotalDivisionCliente
	WHERE  #TMP_RETORNO_ORDENADO.RutCliente = PivotalDivisionCliente.RutCliente
	
	
	SELECT Modulo                        AS 'Modulo',
	       Producto                      AS 'Producto',
	       Numero_Operacion              AS 'Numero_Operacion',
	       Relacionado                   AS 'Relacion',
	       Correlativo                   AS 'Correlativo',
	       Serie                         AS 'Serie',
	       LTRIM(RTRIM(STR(RutCliente)))
	       + LTRIM(RTRIM(DvCliente))     AS 'Rut_Cliente',
	       TipoOperacion                 AS 'Tipo_Operacion',
	       FORMAT(Monto, 'F2', 'es-cl')  AS 'Monto',
	       MonTransada                   AS 'Moneda_Transada',
	       MonConversion                 AS 'Moneda_Conversion',
	       ISNULL(TCCierre, 0)           AS 'TC_Cierre',
	       ISNULL(TCCosto, 0)            AS 'TC_Costo',
	       ISNULL(ParidadCierre, 0)      AS 'Paridad_Cierre',
	       ISNULL(ParidadCosto, 0)       AS 'Paridad_Costo',
	       FORMAT(MontoPesos, 'F2', 'es-cl') AS 'Monto_Pesos',
	       REPLACE(ISNULL(us.rutUsuario, ''), '-', '') AS 'Operador',
	       ISNULL(FORMAT(MontoDolares, 'F2', 'es-cl'), 0) AS 'Monto_Dolares',
	       ISNULL(FORMAT(ResultadoMesa, 'F2', 'es-cl'), 0) AS 'Resultado_Mesa',
	       CASE 
	            WHEN Monto <> 0 THEN ROUND((ResultadoMesa / Monto), 2)
	            ELSE 0
	       END                           AS 'Spread',
	       CONVERT(VARCHAR(10), Fecha, 126) AS 'Fecha',
	       DATEPART(MONTH, Fecha)        AS 'Mes',
	       '' AS 'Negocio',
	       ISNULL(
	           (
	               SELECT DISTINCT Segmento
	               FROM   PivotalDivisionsEgmento pds
	               WHERE  CodigoBAC = #TMP_RETORNO_ORDENADO.SegmentoComercial
	           ),
	           SPACE(1)
	       )                             AS 'Segmento_IBS',
	       '' AS 'Jefe_Grupo_IBS',
	       '' AS 'Ejecutivo_IBS',
	       '' AS 'Gerencia_IBS',
	       Division_IBS                  AS 'Division_IBS',
	       LTRIM(RTRIM(STR(RutCliente)))
	       + LTRIM(RTRIM(DvCliente))     AS 'RUT_Completo_IBS',
	       ISNULL(
	           (
	               SELECT DISTINCT prp.Resultado
	               FROM   PivotalResultadoProducto prp
	               WHERE  LTRIM(RTRIM(prp.Producto)) = LTRIM(RTRIM(#TMP_RETORNO_ORDENADO.Producto))
	           ),
	           SPACE(1)
	       )                             AS 'Resultados_Datos_Mesa' --->999999999</Resultados_Datos_Mesa>
	       ,
	       ISNULL(
	           (
	               SELECT DISTINCT pco.Canal
	               FROM   PivotalCanalOperador pco
	               WHERE  LTRIM(RTRIM(pco.Operador)) = LTRIM(RTRIM(#TMP_RETORNO_ORDENADO.Operador))
	           ),
	           SPACE(1)
	       )                             AS 'Canal_Datos_Mesa' --->XXXXX</Canal_Datos_Mesa>
	       ,
	       ISNULL(
	           (
	               SELECT DISTINCT ppa.AG
	               FROM   PivotalProductoAG ppa
	               WHERE  LTRIM(RTRIM(ppa.Producto)) = LTRIM(RTRIM(#TMP_RETORNO_ORDENADO.Producto))
	           ),
	           SPACE(1)
	       )                             AS 'Quien_entrega_AG_Datos_Mesa' --->XXXXXX</Quien_entrega_AG_Datos_Mesa>
	       ,
	       ISNULL(
	           (
	               SELECT CASE 
	                           WHEN pco.Operador <> '' THEN 'SI'
	                                --WHEN pco.Operador =		''		THEN 'NO'
	                                --ELSE 'NO'
	                      END
	               FROM   PivotalComexOperador pco
	               WHERE  LTRIM(RTRIM(pco.Operador)) = LTRIM(RTRIM(#TMP_RETORNO_ORDENADO.Operador))
	           ),
	           SPACE(1)
	       )                             AS 'Comex_Datos_Mesa',
	       ISNULL(
	           (
	               SELECT CASE 
	                           WHEN Clasificacion = 'Flow' THEN 'SI'
	                           WHEN Clasificacion = 'No Flow' THEN 'NO'
	                           ELSE '-'
	                      END
	               FROM   PivotalProductoFlow
	               WHERE  Familia = Producto
	           ),
	           'NO'
	       )                             AS 'Flow' --->SI</Flow>
	       ,
	       'SI' AS 'Flow_Segmento' --->SI</Flow_Segmento>
	FROM   #TMP_RETORNO_ORDENADO
	       LEFT JOIN BacParamSuda.dbo.USUARIO AS us
	            ON  Operador = us.usuario
	ORDER BY
	       Modulo,
	       Producto,
	       RutCliente,
	       CodCliente,
	       Numero_Operacion,
	       Documento,
	       Correlativo;
	
	SET NOCOUNT OFF;
END;

GO

USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPOMABCCH]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPOMABCCH]
   (   @Fecha       CHAR(08)
   ,   @Responsable CHAR(30)
   ,   @Telefono    NUMERIC(10) 
   )
AS
BEGIN

   SET NOCOUNT ON

DECLARE @Monto           FLOAT
       ,@TC_Ponderado    FLOAT
       ,@TC_Maximo       FLOAT
       ,@TC_Minimo       FLOAT
       ,@Tipo_Operacion  INTEGER
       ,@MtoGralUsd      FLOAT
       ,@MtoGralClp      FLOAT
       ,@Monto2          FLOAT
       ,@TC_Ponderado2   FLOAT
       ,@TC_Maximo2      FLOAT
       ,@TC_Minimo2      FLOAT

   SELECT monumope  as Operacion
   INTO   #Arbi_Empresas
   FROM   MEMO
   WHERE  motipmer  = 'EMPR'
   AND    mocodcnv  = 'USD'
   AND    mocodmon <> 'USD'

	DECLARE @dFechaProc	DATETIME
		SET @dFechaProc	= CONVERT(DATETIME, @Fecha, 112) 

	-->  Se crea para agregar las operaciones Externas
	CREATE TABLE #Tmp_Paso_Oma
	(	Dolar		NUMERIC(21,4)
	,	Pesos		NUMERIC(21,0)
	,	TCambio		NUMERIC(21,4)
	)
	-->  Se crea para agregar las operaciones Externas


----------------<< Crea Tabla OMA
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME = '#OMA' AND type = 'U')
   DROP TABLE #OMA
   CREATE TABLE #OMA( Codigo            CHAR ( 5) NULL
                     ,Tipo_Operacion    INTEGER   NULL
                     ,CInvNoFinanciero  FLOAT     NULL
                     ,Interbancario     FLOAT     NULL
                     ,RetExportacion    FLOAT     NULL
                     ,CInvFinanciero    FLOAT     NULL
                     ,BCCH              FLOAT     NULL            
                     ,Total             FLOAT     NULL 
                     ,Nombre            char (50) NULL
                     ,responsable       char (40) NULL
                     ,telefono          char (10) NULL
                     ,fechpro           char (10) NULL
                     ,hora              CHAR ( 8) NULL
                    )
----------------<<<<<<<<<<<<<<< C O M P R A S >>>>>>>>>>>>>>>--------------------
SELECT @Tipo_Operacion = 1
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'MONTO', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCPON', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMAX', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMIN', @Tipo_Operacion)

---------------<< Comercio Invisible No Financiero 

	-->     Se inserta las seleccion original del OMA Spot
	DELETE FROM #Tmp_Paso_Oma
	INSERT INTO #Tmp_Paso_Oma
	SELECT	Dolar		= moussme 
	,		Pesos		= momonpe
	,		TCambio		= moticam
	FROM	MEMO
	,		TBOMADELSUDA
	WHERE	mocodoma	= codi_opera
	AND   (	codi_oma	= 1						)        
	AND		motipope	= 'C'
	AND   ( moestatus	= ' ' OR moestatus = 'M') 
	AND		motipmer	<> 'CCBB'
	AND		monumope	NOT IN(SELECT Operacion FROM #Arbi_Empresas)
	-->     -----------------------------------------------

	-->     Se insertan las operaciones extarnas de compra
	INSERT INTO #Tmp_Paso_Oma
	SELECT	Dolar			= MtoDolares
	,		Pesos			= MtoPesos
	,		TCambio			= TipoCambio
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS
	WHERE	Fecha			= @dFechaProc
	AND		TipoTransaccion	= 'C'
	AND		Estado			= ''
	-->     -----------------------------------------------

	-->		Seccion de codigo original a excepcion del origen de los datos que se cambio por el contenido de la nueva tabla
	SELECT  @MtoGralUsd   = 0
	SELECT  @MtoGralClp   = 0
	SELECT  @Monto        = 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
	SELECT  @Monto2       = 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
	SELECT  @Monto        = ISNULL(SUM( Dolar   ),0)
	,		@TC_Ponderado = ISNULL(SUM( Pesos   ),0)    -- T/C Ponderado
	,		@TC_Maximo    = ISNULL(MAX( TCambio ),0)    -- T/C Maximo 
	,		@TC_Minimo    = ISNULL(MIN( TCambio ),0)    -- T/C Minimo
	FROM	#Tmp_Paso_Oma
	-->		---------------------------------------------------

	/*		--> Seccion Original, que se comenta para dejar evidencias de lo original hasta antes del cambio
SELECT @MtoGralUsd   = 0
SELECT @MtoGralClp   = 0
SELECT @Monto        = 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
SELECT @Monto2       = 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
SELECT @Monto        = ISNULL(SUM(moussme),0)
      ,@TC_Ponderado = ISNULL(SUM(momonpe),0)    -- T/C Ponderado
      ,@TC_Maximo    = ISNULL(MAX(moticam),0)    -- T/C Maximo 
      ,@TC_Minimo    = ISNULL(MIN(moticam),0)    -- T/C Minimo
FROM  MEMO
     ,TBOMADELSUDA
WHERE mocodoma  = codi_opera AND 
     (codi_oma  = 1 )        AND
      motipope  = 'C'        AND
     (moestatus = ' ' OR moestatus = 'M') 
 AND  motipmer <> 'CCBB'
 AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)
	*/		--------------------------------------------------------------------------------------------------
 
  
--------------------------------- CANJES ------------------------------------------------------
SELECT @Monto2        = ISNULL(SUM(moussme),0),
       @TC_Ponderado2 = ISNULL(SUM(moussme*motctra),0),    -- T/C Ponderado
       @TC_Maximo2    = ISNULL(MAX(motctra),0),    -- T/C Maximo 
       @TC_Minimo2    = ISNULL(MIN(motctra),0)     -- T/C Minimo
FROM   memo, view_cliente
WHERE  morutcli = clrut AND
       cltipcli = 4     AND
      (moestatus = ' ' OR moestatus = 'M') AND
       motipmer = 'CANJ'
AND   monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @Monto			= @Monto + @Monto2
SELECT @TC_Ponderado	= @TC_Ponderado + @TC_Ponderado2
SELECT @TC_Maximo		= ( CASE WHEN @TC_Maximo  = @TC_Maximo2           THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0 AND @TC_Maximo2 = 0 THEN 0
                           WHEN @TC_Maximo2 = 0                     THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0                     THEN @TC_Maximo2
                           WHEN @TC_Maximo2 > @TC_Maximo            THEN @TC_Maximo2
                           WHEN @TC_Maximo  > @TC_Maximo2           THEN @TC_Maximo
   ELSE 0
   END )
SELECT @TC_Minimo = ( CASE WHEN @TC_Minimo  = @TC_Minimo2           THEN @TC_Minimo
                           WHEN @TC_Minimo  = 0 AND @TC_Minimo2 = 0 THEN 0 
                           WHEN @TC_Minimo2 = 0                     THEN @TC_Minimo
                           WHEN @TC_Minimo  = 0                     THEN @TC_Minimo2
                           WHEN @TC_Minimo2 < @TC_Minimo            THEN @TC_Minimo2
                           WHEN @TC_Minimo  < @TC_Minimo2           THEN @TC_Minimo
                           ELSE 0 
                      END )

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion

----------------<< Interbancario
SELECT @Monto  = 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
SELECT @Monto2 = 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
FROM    MEMO, VIEW_CLIENTE
WHERE   mocodoma = 2     
   AND  motipope = 'C'   
   AND  morutcli = clrut 
   AND  cltipcli > 0     
   AND  cltipcli < 4     
   AND (moestatus = ' ' OR moestatus = 'M') 
   AND  motipmer <> 'CCBB'
   AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

--------------------------------- CANJES ------------------------------------------------------
SELECT @Monto2        = ISNULL(SUM(moussme),0),
       @TC_Ponderado2 = ISNULL(SUM(moussme*motctra),0),    -- T/C Ponderado
       @TC_Maximo2    = ISNULL(MAX(motctra),0),    -- T/C Maximo 
       @TC_Minimo2    = ISNULL(MIN(motctra),0)     -- T/C Minimo
FROM   memo, view_cliente
WHERE  morutcli = clrut AND
       cltipcli > 0     AND
       cltipcli < 4     AND
      (moestatus = ' ' OR moestatus = 'M') AND
       motipmer = 'CANJ'
   AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @Monto        = @Monto + @Monto2
SELECT @TC_Ponderado = @TC_Ponderado + @TC_Ponderado2
SELECT @TC_Maximo = ( CASE WHEN @TC_Maximo  = @TC_Maximo2           THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0 AND @TC_Maximo2 = 0 THEN 0
                           WHEN @TC_Maximo2 = 0                     THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0                     THEN @TC_Maximo2
                           WHEN @TC_Maximo2 > @TC_Maximo            THEN @TC_Maximo2
                           WHEN @TC_Maximo  > @TC_Maximo2           THEN @TC_Maximo
                           ELSE 0
                      END )
SELECT @TC_Minimo = ( CASE WHEN @TC_Minimo = @TC_Minimo2            THEN @TC_Minimo
                           WHEN @TC_Minimo = 0 AND @TC_Minimo2 = 0  THEN 0 
                           WHEN @TC_Minimo2 = 0                     THEN @TC_Minimo
                           WHEN @TC_Minimo  = 0                     THEN @TC_Minimo2
                           WHEN @TC_Minimo2 < @TC_Minimo            THEN @TC_Minimo2
                           WHEN @TC_Minimo < @TC_Minimo2            THEN @TC_Minimo
                           ELSE 0 
                      END )

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion

----------------<< Retornos de Exportacion
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
FROM   MEMO
      ,TBOMADELSUDA 
WHERE  mocodoma   = codi_opera AND 
       codi_oma   = 3          AND
       motipope   = 'C'        AND
      (moestatus  = ' ' OR moestatus = 'M')
   AND motipmer  <> 'CCBB'
   AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
FROM   memo
      ,TBOMADELSUDA 
WHERE  mocodoma  = codi_opera AND 
       codi_oma  = 4          AND
       motipope  = 'C'        AND
       motipmer  = 'EMPR'     AND
      (moestatus = ' ' OR moestatus = 'M')
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Compras al Banco Central
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo
 WHERE mocodoma      = 5    AND
       motipope      = 'C'  AND
      (moestatus     = ' ' OR moestatus = 'M')
  AND  motipmer <> 'CCBB'
  AND  monumope      NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET BCCH = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Total  = CASE @MtoGralUsd WHEN 0 THEN 0 ELSE (@MtoGralClp/@MtoGralUsd) END
          WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
-----------------<<<<<<<<<<<<<<< V E N T A S >>>>>>>>>>>>>>>---------------------

SELECT @MtoGralUsd   = 0
SELECT @MtoGralClp   = 0
SELECT @Tipo_Operacion = 2
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'MONTO', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCPON', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMAX', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMIN', @Tipo_Operacion)
----------------<< Comercio Invisible No Financiero 

	-->     Se inserta las seleccion original del OMA Spot
	DELETE FROM #Tmp_Paso_Oma
	INSERT INTO #Tmp_Paso_Oma
	SELECT	Dolar		= moussme 
	,		Pesos		= momonpe
	,		TCambio		= moticam
	FROM	MEMO
	,		TBOMADELSUDA 
	WHERE	mocodoma	= codi_opera 
	AND		codi_oma	= 6          
	AND		mocodoma   <> 10        
	AND		motipope	= 'V'        
	AND   (	moestatus	= ' ' OR moestatus = 'M'	)
	AND		motipmer	<> 'CCBB'
	AND		monumope	NOT IN(SELECT Operacion FROM #Arbi_Empresas)
	-->		------------------------------------------------------------

	-->     Se insertan las operaciones extarnas de compra
	INSERT INTO #Tmp_Paso_Oma
	SELECT	Dolar			= MtoDolares
	,		Pesos			= MtoPesos
	,		TCambio			= TipoCambio
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS
	WHERE	Fecha			= @dFechaProc
	AND		TipoTransaccion	= 'V'
	AND		Estado			= ''
	-->     -----------------------------------------------

	-->		Seccion de codigo original a excepcion del origen de los datos que se cambio por el contenido de la nueva tabla
	SELECT  @Monto			= 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
	SELECT  @Monto2			= 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
	SELECT  @Monto			= ISNULL(SUM( Dolar  ),0),
			@TC_Ponderado	= ISNULL(SUM( Pesos  ),0),    -- T/C Ponderado
			@TC_Maximo		= ISNULL(MAX( TCambio ),0),    -- T/C Maximo 
			@TC_Minimo		= ISNULL(MIN( TCambio ),0)     -- T/C Minimo
	FROM	#Tmp_Paso_Oma
	-->		---------------------------------------------------

	/*		--> Seccion Original, que se comenta para dejar evidencias de lo original hasta antes del cambio
SELECT @Monto  = 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
SELECT @Monto2 = 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma  = codi_opera AND 
       codi_oma  = 6          AND
       mocodoma  <> 10        AND 
       motipope  = 'V'        AND
      (moestatus = ' ' OR moestatus = 'M')
  AND  motipmer <> 'CCBB'
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)
	*/

---------------------------------------- CANJES ---------------------------------
SELECT @Monto2        = ISNULL(SUM(moussme),0),
       @TC_Ponderado2 = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo2    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo2    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo, view_cliente
 WHERE morutcli  = clrut AND
       cltipcli  = 4     AND
      (moestatus = ' ' OR moestatus = 'M') AND
       motipmer  = 'CANJ'
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)
      
SELECT @Monto        = @Monto + @Monto2
SELECT @TC_Ponderado = @TC_Ponderado + @TC_Ponderado2
SELECT @TC_Maximo = ( CASE WHEN @TC_Maximo = 0 AND @TC_Maximo2 = 0 THEN 0
                           WHEN @TC_Maximo2 = 0                    THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0                    THEN @TC_Maximo2
                           WHEN @TC_Maximo2 > @TC_Maximo           THEN @TC_Maximo2
                           WHEN @TC_Maximo  > @TC_Maximo2          THEN @TC_Maximo
                           ELSE 0
                      END )
SELECT @TC_Minimo = ( CASE WHEN @TC_Minimo = 0 AND @TC_Minimo2 = 0 THEN 0 
                           WHEN @TC_Minimo2 = 0                    THEN @TC_Minimo
                           WHEN @TC_Minimo  = 0                    THEN @TC_Minimo2
                           WHEN @TC_Minimo2 < @TC_Minimo           THEN @TC_Minimo2
                           WHEN @TC_Minimo < @TC_Minimo2           THEN @TC_Minimo
                           ELSE 0 
                      END )

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Interbancario
SELECT @Monto  = 0, @TC_Ponderado  = 0, @TC_Maximo  = 0, @TC_Minimo  = 0
SELECT @Monto2 = 0, @TC_Ponderado2 = 0, @TC_Maximo2 = 0, @TC_Minimo2 = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo, view_cliente
 WHERE mocodoma = 7     AND
       motipope = 'V'   AND
       morutcli = clrut AND
       cltipcli > 0     AND
       cltipcli < 4     AND
      (moestatus = ' ' OR moestatus = 'M')
  AND  motipmer <> 'CCBB'
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

---------------------------------------- CANJES ---------------------------------
SELECT @Monto2        = ISNULL(SUM(moussme),0),
       @TC_Ponderado2 = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo2    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo2    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo, view_cliente
 WHERE morutcli  = clrut AND
       cltipcli  > 0     AND
       cltipcli  < 4     AND
      (moestatus = ' ' OR moestatus = 'M') AND
       motipmer  = 'CANJ'
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)
      
SELECT @Monto        = @Monto + @Monto2
SELECT @TC_Ponderado = @TC_Ponderado + @TC_Ponderado2
SELECT @TC_Maximo = ( CASE WHEN @TC_Maximo = 0 AND @TC_Maximo2 = 0 THEN 0
                           WHEN @TC_Maximo2 = 0                    THEN @TC_Maximo
                           WHEN @TC_Maximo  = 0                    THEN @TC_Maximo2
                           WHEN @TC_Maximo2 > @TC_Maximo           THEN @TC_Maximo2
                           WHEN @TC_Maximo  > @TC_Maximo2          THEN @TC_Maximo
                           ELSE 0
                      END )
SELECT @TC_Minimo = ( CASE WHEN @TC_Minimo = 0 AND @TC_Minimo2 = 0 THEN 0 
                           WHEN @TC_Minimo2 = 0                    THEN @TC_Minimo
                           WHEN @TC_Minimo  = 0                    THEN @TC_Minimo2
                           WHEN @TC_Minimo2 < @TC_Minimo           THEN @TC_Minimo2
                           WHEN @TC_Minimo < @TC_Minimo2           THEN @TC_Minimo
                           ELSE 0 
                      END )

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Cobertura de Importaciones
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma  = codi_opera AND 
       codi_oma  = 8          AND
       motipope  = 'V'        AND
      (moestatus = ' ' OR moestatus = 'M')
  AND  motipmer <> 'CCBB'
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam),0)  -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma  = codi_opera AND 
       codi_oma  = 9          AND
       motipope  = 'V' AND
       motipmer  = 'EMPR'     AND
      (moestatus = ' ' OR moestatus = 'M')
  AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion

----------------<< Ventas al Banco Central
SELECT  @Monto = 0,   @TC_Ponderado = 0,   @TC_Maximo = 0,   @TC_Minimo = 0
SELECT  @Monto        = ISNULL(SUM(moussme),0),
        @TC_Ponderado = ISNULL(SUM(momonpe),0),    -- T/C Ponderado
        @TC_Maximo    = ISNULL(MAX(moticam),0),    -- T/C Maximo 
        @TC_Minimo    = ISNULL(MIN(moticam),0)     -- T/C Minimo
  FROM  MEMO
 WHERE  motipope  = 'V'
   AND  mocodoma  = 10
   AND (moestatus = ' ' OR moestatus = 'M')
   AND  motipmer <> 'CCBB'
   AND  monumope  NOT IN(SELECT Operacion FROM #Arbi_Empresas)

SELECT @MtoGralUsd   = @MtoGralUsd + @Monto
SELECT @MtoGralClp   = @MtoGralClp + @TC_Ponderado
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET BCCH = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Ok >>--------------
UPDATE #OMA SET CInvNoFinanciero = CONVERT(INT,(CInvNoFinanciero/1000)) ,
                Interbancario    = CONVERT(INT,(Interbancario/1000)) ,
                RetExportacion   = CONVERT(INT,(RetExportacion/1000)) , 
                CInvFinanciero   = CONVERT(INT,(CInvFinanciero/1000)) ,
                BCCH             = CONVERT(INT,(BCCH /1000))                 
          WHERE Codigo = 'MONTO' 

/*REQ.7619 CASS 07-01-2011
UPDATE #OMA SET CInvNoFinanciero = CONVERT(INT(15),(CInvNoFinanciero/1000)) ,
                Interbancario    = CONVERT(INT(15),(Interbancario/1000)) ,
                RetExportacion   = CONVERT(INT(15),(RetExportacion/1000)) , 
                CInvFinanciero   = CONVERT(INT(15),(CInvFinanciero/1000)) ,
                BCCH             = CONVERT(INT(15),(BCCH /1000))                 
          WHERE Codigo = 'MONTO' 
*/

UPDATE #OMA SET Total  = (CInvNoFinanciero + Interbancario + RetExportacion + CInvFinanciero + BCCH)
          WHERE Codigo = 'MONTO' 
UPDATE #OMA SET Total  = CASE @MtoGralUsd WHEN 0 THEN 0 ELSE (@MtoGralClp/@MtoGralUsd) END
          WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion

UPDATE #OMA SET nombre   = acnombre
              , telefono = @Telefono
              , fechpro  = convert(char(10), convert(datetime, @fecha,103),103)
              , hora     = CONVERT(CHAR(8),GETDATE(),108)
              , responsable=@Responsable 
from meac


SELECT * FROM #OMA --ORDER BY Tipo_Operacion,Codigo

END
GO

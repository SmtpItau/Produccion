USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[S_OMA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Stored Procedure dbo.s_OMA    Script Date: 06-01-2011 16:41:22 ******/

CREATE PROCEDURE [dbo].[S_OMA]( @Fecha DATETIME )
AS
BEGIN
DECLARE @Monto          FLOAT,
        @TC_Ponderado   FLOAT,
        @TC_Maximo      FLOAT,
        @TC_Minimo      FLOAT,
        @Tipo_Operacion INTEGER
----------------<< Crea Tabla OMA
IF EXISTS (SELECT name FROM sysobjects WHERE name = '#OMA' AND type = 'U')
   DROP TABLE #OMA
CREATE TABLE #OMA( Codigo            CHAR(5) NULL,
                   Tipo_Operacion    INTEGER NULL,
                   CInvNoFinanciero  FLOAT   NULL,
                   Interbancario     FLOAT   NULL,
                   RetExportacion    FLOAT   NULL,
                   CInvFinanciero    FLOAT   NULL,
                   BCCH              FLOAT   NULL,
                   Total             FLOAT   NULL )
----------------<<<<<<<<<<<<<<< C O M P R A S >>>>>>>>>>>>>>>--------------------
SELECT @Tipo_Operacion = 1
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'MONTO', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCPON', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMAX', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMIN', @Tipo_Operacion)
----------------<< Comercio Invisible No Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND (codigo_comercio LIKE '15%' OR (codigo_comercio = '177008' AND concepto = '014'))
   AND monto_dolares > 500000
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Interbancario
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas, tbInstitucionesFinancieras
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND interesado_rut  <> 97029000           -- Parametrizar, debe ser <> BCCH
   AND interesado_rut   = clrut AND interesado_codigo = clcodigo 
   AND operacion_moneda = 13
   AND ((codigo_comercio = '173002' AND concepto = '016')
     OR (codigo_comercio = '174009' AND concepto = '010'))
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Retornos de Exportacion
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND codigo_comercio LIKE '11%' 
   AND tipo_operacion_cambio IN (401,403,407,500)  -- segun tbOperacionesCambio (Vista)
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND (codigo_comercio LIKE '16%' 
    OR (codigo_comercio = '120006' AND concepto = '014')
    OR (codigo_comercio = '130001' AND concepto = '018'))
   AND monto_dolares > 500000
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Compras al Banco Central
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND (codigo_comercio = '172006' AND concepto = '011')
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET BCCH = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
-----------------<<<<<<<<<<<<<<< V E N T A S >>>>>>>>>>>>>>>---------------------
SELECT @Tipo_Operacion = 2
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'MONTO', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCPON', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMAX', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMIN', @Tipo_Operacion)
----------------<< Comercio Invisible No Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND codigo_comercio LIKE '25%' 
   AND monto_dolares > 500000
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Interbancario
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas, tbInstitucionesFinancieras
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND interesado_rut  <> 97029000           -- Parametrizar, debe ser <> BCCH
   AND interesado_rut   = clrut AND interesado_codigo = clcodigo 
   AND operacion_moneda = 13
   AND ((codigo_comercio = '273007' AND concepto = '014')
     OR (codigo_comercio = '274003' AND concepto = '019'))
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Cobertura de Importaciones
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND ((codigo_comercio = '210005' AND concepto = '019')
     OR (codigo_comercio = '220000' AND concepto = '012'))
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND (codigo_comercio LIKE '26%' 
    OR (codigo_comercio = '241008' AND concepto = '014')
    OR (codigo_comercio = '242101' AND concepto = '014')
    OR (codigo_comercio = '242209' AND concepto = '01K')
    OR (codigo_comercio = '240230' AND concepto = '015'))
   AND monto_dolares > 500000
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Compras al Banco Central
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(monto_dolares),0),
       @TC_Ponderado = ISNULL(SUM(monto_pesos  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(tipo_cambio  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(tipo_cambio  ),0)     -- T/C Minimo
  FROM tbPlanillas
 WHERE CONVERT(CHAR(8),planilla_fecha,112)   = CONVERT(CHAR(8),@Fecha,112)
   AND operacion_moneda = 13
   AND (codigo_comercio = '272000' AND concepto = '01K')
 GROUP BY operacion_moneda
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET BCCH = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET BCCH = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Ok >>--------------
UPDATE #OMA SET CInvNoFinanciero = (CInvNoFinanciero/1000) ,
                Interbancario    = (Interbancario   /1000) ,
                RetExportacion   = (RetExportacion  /1000) ,
                CInvFinanciero   = (CInvFinanciero  /1000) ,
                BCCH             = (BCCH            /1000)                 
          WHERE Codigo = 'MONTO' 
UPDATE #OMA SET Total = (CInvNoFinanciero + Interbancario + RetExportacion + CInvFinanciero + BCCH)
          WHERE Codigo = 'MONTO' 
SELECT * FROM #OMA ORDER BY Tipo_Operacion, Codigo
--DROP TABLE #OMA
END




GO

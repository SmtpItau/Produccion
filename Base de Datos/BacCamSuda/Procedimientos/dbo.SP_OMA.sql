USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OMA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OMA]( @Fecha char(08) )
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
                   Total             FLOAT   NULL, 
                   Nombre            char (50)null,
     responsable       char (40)null,
            telefono          char (8)null,
                   fechpro           char (10)null)
----------------<<<<<<<<<<<<<<< C O M P R A S >>>>>>>>>>>>>>>--------------------
SELECT @Tipo_Operacion = 1
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'MONTO', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCPON', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMAX', @Tipo_Operacion)
INSERT INTO #OMA(Codigo, Tipo_Operacion)  VALUES( 'TCMIN', @Tipo_Operacion)
---------------<< Comercio Invisible No Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM MEMO
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 1
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Interbancario
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
 WHERE mocodoma = 2 
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Retornos de Exportacion
sELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 3
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 4
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Compras al Banco Central
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
 WHERE mocodoma = 5 
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
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 6
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvNoFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvNoFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Interbancario
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo, view_cliente
 WHERE mocodoma = 7
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET Interbancario = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET Interbancario = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Cobertura de Importaciones
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 8
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET RetExportacion = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET RetExportacion = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Comercio Invisible Financiero 
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
    @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 9
SELECT @TC_Ponderado = CASE @Monto WHEN 0 THEN 0 ELSE (@TC_Ponderado/@Monto) END
UPDATE #OMA SET CInvFinanciero = @Monto        WHERE Codigo = 'MONTO' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Ponderado WHERE Codigo = 'TCPON' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Maximo    WHERE Codigo = 'TCMAX' AND Tipo_Operacion = @Tipo_Operacion
UPDATE #OMA SET CInvFinanciero = @TC_Minimo    WHERE Codigo = 'TCMIN' AND Tipo_Operacion = @Tipo_Operacion
----------------<< Ventas al Banco Central
SELECT @Monto = 0, @TC_Ponderado = 0, @TC_Maximo = 0, @TC_Minimo = 0
SELECT @Monto        = ISNULL(SUM(moussme),0),
       @TC_Ponderado = ISNULL(SUM(momonpe  ),0),    -- T/C Ponderado
       @TC_Maximo    = ISNULL(MAX(moticam  ),0),    -- T/C Maximo 
       @TC_Minimo    = ISNULL(MIN(moticam  ),0)     -- T/C Minimo
  FROM memo
      ,TBOMADELSUDA 
 WHERE mocodoma = codi_opera AND 
       codi_oma = 10
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
UPDATE #OMA SET nombre = acnombre, telefono = actelefo, fechpro =convert(char(10), convert(datetime, @fecha,103),103) from meac
SELECT * FROM #OMA ORDER BY Tipo_Operacion
END

GO

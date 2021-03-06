USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_INFORME_LECTURA_PAGOS_FFMM]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_SADP_INFORME_LECTURA_PAGOS_FFMM]  
 (   
  @dFecha  DATETIME  
 )  
AS  
BEGIN  
   
 SET NOCOUNT ON  
  
 DECLARE @cOrigen VARCHAR(5)  
  SET @cOrigen = 'FFMM'  
  
 --> Tabla de Paso para Sumatorias  
 CREATE TABLE #TMP_PASO_SUMA  
  ( Cantidad  NUMERIC(21)  NOT NULL DEFAULT(0)  
  , Monto   FLOAT   NOT NULL DEFAULT(0.0)  
  , FPago   INT    NOT NULL DEFAULT(0)  
  , MPago   INT    NOT NULL DEFAULT(0)  
  )  
  
 --> Tabla de Retorno Final  
 CREATE TABLE #TMP_RETORNO_PAGOS  
  ( Hoja   INT    NOT NULL DEFAULT(0)  
  , TituloHoja  VARCHAR(50)  NOT NULL DEFAULT('')  
  , Cuadro   INT    NOT NULL DEFAULT(0)  
  , Orden   INT    NOT NULL DEFAULT(0)  
  , Empresa   VARCHAR(5)  NOT NULL DEFAULT('')  
  , Fecha   DATETIME  NOT NULL DEFAULT('')  
  , Titulo   VARCHAR(50)  NOT NULL DEFAULT('')  
  , Concepto  VARCHAR(30)  NOT NULL DEFAULT('')  
  , Codigo   INT    NOT NULL DEFAULT(0)  
  , CLP_Can_Pagos NUMERIC(21)  NOT NULL DEFAULT(0.0)  
  , CLP_Monto  FLOAT   NOT NULL DEFAULT(0.0)  
  , USD_Can_Pagos NUMERIC(21)  NOT NULL DEFAULT(0.0)  
  , USD_Monto  FLOAT   NOT NULL DEFAULT(0.0)  
  , Total   FLOAT   NOT NULL DEFAULT(0.0)  
  , Enviados  INT    NOT NULL DEFAULT(0)  
  )  
 CREATE CLUSTERED INDEX #ix_Indice_Cluster_Orden ON #TMP_RETORNO_PAGOS (Hoja, Cuadro, Orden)  
  
  
 DECLARE @FormaPago TABLE( codigo INT, glosa VARCHAR(30))   
   
 INSERT INTO @FormaPago ( codigo, glosa)  
 SELECT codigo, glosa    
   FROM BacParamSuda.dbo.FORMA_DE_PAGO fp   
 WHERE fp.codigo   IN(5, 103, 134, 222, 128)  
   
 INSERT INTO @FormaPago ( codigo, glosa)  
 VALUES(0,'PENDIENTES')       
    
  
  
  
 -->  1.0. HOJA 1, CUADRO 1 (RESCATES)  
 INSERT INTO #TMP_RETORNO_PAGOS  
 SELECT Hoja    = 1  
  , TituloHoja   = 'INFORME DE LECTURA DE PAGOS AUTOMATICOS'  
  , Cuadro    = 1  
  , Orden    = CASE WHEN fp.codigo = 103 THEN 1  
          WHEN fp.codigo = 5  THEN 2  
          WHEN fp.codigo = 134 THEN 3  
          WHEN fp.codigo = 128 THEN 4  
          WHEN fp.codigo = 222 THEN 5  
          ELSE       6  
             END  
  , Empresa    = @cOrigen  
  , Fecha    = @dFecha  
  , Titulo    = 'RESCATES'  
  , Concepto   = CASE WHEN fp.codigo = 103 THEN 'Abono Cta/Cte.'  
            WHEN fp.codigo = 5 THEN 'Vale Vista'  
            WHEN fp.codigo = 134 THEN 'Combanc'  
            WHEN fp.codigo = 128 THEN 'Lbtr'  
            WHEN fp.codigo = 222 THEN 'Administrativa'  
            ELSE       'Pendiente'  
          END  
  , Codigo    = CASE WHEN fp.codigo = 8 THEN 0 ELSE fp.codigo END  
  , CLP_Can_Pagos  = 0  
  , CLP_Monto   = 0.0  
  , USD_Can_Pagos  = 0  
  , USD_Monto   = 0.0  
  , Total    = 0.0  
  , Enviados   = 0  
  FROM @FormaPago fp   
 --WHERE fp.codigo   IN(5, 103, 134, 222, 0,128,8)  
    
    
  
 -->  2.0. HOJA 1, CUADRO 2 (OPERACIONES MESA DINERO)  
 INSERT INTO #TMP_RETORNO_PAGOS  
 SELECT Hoja    = 1  
  , TituloHoja   = 'INFORME DE LECTURA DE PAGOS AUTOMATICOS'  
  , Cuadro    = 2  
    
  , Orden    = CASE WHEN fp.codigo = 103 THEN 1  
          WHEN fp.codigo = 5  THEN 2  
          WHEN fp.codigo = 134 THEN 3  
          WHEN fp.codigo = 128 THEN 4  
          WHEN fp.codigo = 222 THEN 5  
          ELSE       6  
          END  
  , Empresa    = @cOrigen  
  , Fecha    = @dFecha  
  , Titulo    = 'OPERACIONES MESA DE DINERO'  
    
  , Concepto   = CASE WHEN fp.codigo = 103 THEN 'Abono Cta/Cte.'  
            WHEN fp.codigo = 5 THEN 'Vale Vista'  
            WHEN fp.codigo = 134 THEN 'Combanc'  
            WHEN fp.codigo = 128 THEN 'Lbtr'  
            WHEN fp.codigo = 222 THEN 'Administrativa'  
            ELSE       'Pendiente'  
                 END  
                   
  , Codigo    = CASE WHEN fp.codigo = 12 THEN 0 ELSE fp.codigo END  
  , CLP_Can_Pagos  = 0  
  , CLP_Monto   = 0.0  
  , USD_Can_Pagos  = 0  
  , USD_Monto   = 0.0  
  , Total    = 0.0  
  , Enviados   = 0  
  FROM @FormaPago fp   
 --WHERE fp.codigo   IN(5, 103, 134, 222,128, 0)  
   
   
 -->  2.0. CREACION DE CADA UNO DE LOS CONCEPTOS DE OPERACIONES DE MESA DE DINERO  
 INSERT INTO #TMP_RETORNO_PAGOS  
 SELECT Hoja    = 2  
  , TituloHoja   = 'INFORME DE PAGOS REALIZADOS (ENVIADOS)'  
  , Cuadro    = 1  
  , Orden    = CASE WHEN fp.codigo = 103 THEN 1  
            WHEN fp.codigo = 5 THEN 2  
            WHEN fp.codigo = 134 THEN 3  
            WHEN fp.codigo = 128 THEN 4  
            WHEN fp.codigo = 222 THEN 5  
            ELSE       6  
          END  
  , Empresa    = @cOrigen  
  , Fecha    = @dFecha  
  , Titulo    = 'RESCATES'  
  , Concepto   = CASE WHEN fp.codigo = 103 THEN 'Abono Cta/Cte.'  
            WHEN fp.codigo = 5 THEN 'Vale Vista'  
            WHEN fp.codigo = 134 THEN 'Combanc'  
            WHEN fp.codigo = 128 THEN 'Lbtr'  
            WHEN fp.codigo = 222 THEN 'Administrativa'  
            ELSE       'Pendiente'  
          END  
  , Codigo    = CASE WHEN fp.codigo = 12 THEN 0   
            WHEN fp.codigo = 13 THEN -1  
            ELSE fp.codigo   
                END  
  , CLP_Can_Pagos  = 0  
  , CLP_Monto   = 0.0  
  , USD_Can_Pagos  = 0  
  , USD_Monto   = 0.0  
  , Total    = 0.0  
  , Enviados   = 0  
  FROM @FormaPago fp   
 --WHERE fp.codigo   IN(5, 103, 134, 128,222,0)  
   
  
  
  
 -->  2.0. CREACION DE CADA UNO DE LOS CONCEPTOS DE OPERACIONES DE MESA DE DINERO  
 INSERT INTO #TMP_RETORNO_PAGOS  
 SELECT Hoja    = 2  
  , TituloHoja   = 'INFORME DE PAGOS REALIZADOS (ENVIADOS)'  
  , Cuadro    = 2  
  , Orden    = CASE WHEN fp.codigo = 103 THEN 1  
            WHEN fp.codigo = 5 THEN 2  
            WHEN fp.codigo = 134 THEN 3  
            WHEN fp.codigo = 128 THEN 4  
            WHEN fp.codigo = 222 THEN 5  
            ELSE       6  
          END    
  , Empresa    = @cOrigen  
  , Fecha    = @dFecha  
  , Titulo    = 'OPERACIONES MESA DE DINERO'  
  , Concepto   = CASE WHEN fp.codigo = 103 THEN 'Abono Cta/Cte.'  
            WHEN fp.codigo = 5 THEN 'Vale Vista'  
            WHEN fp.codigo = 134 THEN 'Combanc'  
            WHEN fp.codigo = 128 THEN 'Lbtr'  
            WHEN fp.codigo = 222 THEN 'Administrativa'  
            ELSE       'Pendiente'  
          END  
  , Codigo    = CASE WHEN fp.codigo = 12 THEN 0   
            WHEN fp.codigo = 13 THEN -1  
            ELSE fp.codigo   
                END  
  , CLP_Can_Pagos  = 0  
  , CLP_Monto   = 0.0  
  , USD_Can_Pagos  = 0  
  , USD_Monto   = 0.0  
  , Total    = 0.0  
  , Enviados   = 0  
 FROM @FormaPago fp   
 --WHERE fp.codigo   IN(5, 103, 134, 128,222,0)  
   
   
   
  
 --> ********************************************* <--  
 --> HOJA 1 CUADRO 1 -- RESCATES       <--  
 --> ********************************************* <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
    
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda   
  FROM BacParamSuda.dbo.MDLBTR   md  
  INNER JOIN SADP_DETALLE_PAGOS	dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND dp.iSecuencia = md.Secuencia
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion = 'RES'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
  
  
/*  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion = 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
  
*/  
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 1  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 1  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
 --> ********************************************* <--  
 --> HOJA 1 CUADRO 2 -- OPERACIONES MESA DE DINERO <--  
 --> ********************************************* <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
    
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion  <> 'RES'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
/*  
  UNION  
  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion  <> 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 1  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 1  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
 --> ********************************************* <--  
 --> HOJA 2 CUADRO 1 -- RESCATES ENVIADOS    <--  
 --> ********************************************* <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
    
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda   
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM', 'OP')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion = 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
/*  
  UNION  
  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM', 'OP')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion = 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  TRUNCATE TABLE #TMP_PASO_SUMA  
    
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = -1  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   IN('OP')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion = 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999  
    
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
  
  
  
 --> ********************************************* <--  
 --> HOJA 2 CUADRO 2 -- OPERACIONES MESA DE DINERO <--  
 --> ********************************************* <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
    
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion  <> 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
  
/*  UNION  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion  <> 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  TRUNCATE TABLE #TMP_PASO_SUMA  
  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = -1  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   IN('OP')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion   <> 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999  
    
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 2  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
  
  
 --> ************************************************* <--  
 --> HOJA 3 CUADRO 1 Y 2 -- OPERACIONES MESA DE DINERO <--  
 --> ************************************************* <--  
  INSERT INTO #TMP_RETORNO_PAGOS  
  SELECT Hoja     = 3  
   , TituloHoja    = 'INFORME DE CARGA DE PAGOS MANUALES'  
   , Cuadro     = Cuadro   
   , Orden     = Orden  
   , Empresa     = Empresa  
   , Fecha     = Fecha  
   , Titulo     = Titulo  
   , Concepto    = Concepto  
   , Codigo     = Codigo  
   , CLP_Can_Pagos   = 0  
   , CLP_Monto    = 0  
   , USD_Can_Pagos   = 0  
   , USD_Monto    = 0.0  
   , Total     = 0.0  
   , Enviados    = 0  
  FROM #TMP_RETORNO_PAGOS   
  WHERE Hoja     = 1  
  
 --> CARGA SUMAS HOJA 3 CUADRO 1 -- RESCATES <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR     md  
    INNER JOIN SADP_DETALLE_PAGOS   dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion  AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion   = 'RES'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
/*  
  UNION  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion   = 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 3  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 3  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
 --> CARGA SUMAS HOJA 3 CUADRO 2 -- RESCATES <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR     md  
    INNER JOIN SADP_DETALLE_PAGOS   dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion  <> 'RES'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
  
/*  UNION  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion  <> 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 3  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 3  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
  
 --> ************************************************* <--  
 --> HOJA 4 CUADRO 1 Y 2 -- OPERACIONES MESA DE DINERO <--  
 --> ************************************************* <--  
  INSERT INTO #TMP_RETORNO_PAGOS  
  SELECT Hoja     = 4  
   , TituloHoja    = 'INFORME DE PAGOS REALIZADO MANUALES'  
   , Cuadro     = Cuadro   
   , Orden     = Orden  
   , Empresa     = Empresa  
   , Fecha     = Fecha  
   , Titulo     = Titulo  
   , Concepto    = Concepto  
   , Codigo     = Codigo  
   , CLP_Can_Pagos   = 0  
   , CLP_Monto    = 0  
   , USD_Can_Pagos   = 0  
   , USD_Monto    = 0.0  
   , Total     = 0.0  
   , Enviados    = 0  
  FROM #TMP_RETORNO_PAGOS   
  WHERE Hoja     = 2  
  
  
 --> CARGA SUMAS HOJA 4 CUADRO 1 -- RESCATES <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR     md  
    INNER JOIN SADP_DETALLE_PAGOS   dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion   = 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
  
/*  UNION  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion   = 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  TRUNCATE TABLE #TMP_PASO_SUMA  
/*  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = -1  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   IN('OP')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139, 105, 5)  
  AND  md.tipo_operacion   = 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 999  
    
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 1  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  
  
 --> CARGA SUMAS HOJA 4 CUADRO 2 -- RESCATES <--  
  TRUNCATE TABLE #TMP_PASO_SUMA  
  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = dp.iFormaPago  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR     md  
    INNER JOIN SADP_DETALLE_PAGOS   dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(103, 5,222,0,128,134)  
  AND  md.tipo_operacion  <> 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iFormaPago, dp.iMoneda  
  
/*  UNION  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = 134  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   NOT IN('APM')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139)  
  AND  md.tipo_operacion  <> 'RES'  
  AND  md.estado_envio  = 'E'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 999    
  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
  TRUNCATE TABLE #TMP_PASO_SUMA  
/*  
  INSERT INTO #TMP_PASO_SUMA  
  SELECT Cantidad   = COUNT(1)  
   , Monto    = SUM( dp.nMonto )  
   , Pago    = -1  
   , MPago    = dp.iMoneda  
  FROM BacParamSuda.dbo.MDLBTR   md  
    INNER JOIN SADP_DETALLE_PAGOS dp ON dp.cModulo = md.sistema AND dp.nContrato = md.numero_operacion AND md.Secuencia=dp.iSecuencia  
    INNER JOIN SADP_MOVIMIENTOS_MANUALES mm ON mm.dFechaCarga = md.fecha AND mm.sOrigen = dp.cModulo AND mm.iOperOriginal = dp.nContrato  
  WHERE md.fecha   = @dFecha  
  AND  md.sistema   = @cOrigen   
  AND  dp.cEstado   IN('OP')  
  AND  dp.iFormaPago  IN(128, 129, 130, 132, 133, 134, 135, 136, 137, 138, 139, 105, 5)  
  AND  md.tipo_operacion  <> 'RES'  
  GROUP BY md.sistema, dp.iMoneda  
*/  
  UPDATE #TMP_RETORNO_PAGOS  
  SET  CLP_Can_Pagos  = Cantidad  
  ,  CLP_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 999  
    
  UPDATE #TMP_RETORNO_PAGOS  
  SET  USD_Can_Pagos  = Cantidad  
  ,  USD_Monto   = Monto  
  FROM #TMP_PASO_SUMA  
  WHERE Hoja    = 4  
  AND  Cuadro    = 2  
  AND  Codigo    = FPago  
  AND  MPago    = 13    
  
 --> ********************************************* <--  
 -->     RETORNO        <--  
 --> ********************************************* <--  
  
 SELECT Hoja  
  , TituloHoja  
  , Cuadro  
  , Orden  
  , Empresa  
  , Fecha  
  , Titulo  
  , Concepto = UPPER(Concepto)  
  , Codigo  
  , CLP_Can_Pagos  
  , CLP_Monto  
  , USD_Can_Pagos  
  , USD_Monto  
  , Total  
  , Enviados  
 FROM #TMP_RETORNO_PAGOS  
  
END

GO

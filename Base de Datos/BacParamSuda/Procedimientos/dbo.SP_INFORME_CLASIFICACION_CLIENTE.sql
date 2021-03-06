USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CLASIFICACION_CLIENTE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_CLASIFICACION_CLIENTE]
   (   @nRutCliente INTEGER 	= 0	
   ,   @nCodigoCli  INTEGER 	= 0
   ,   @Operador    VARCHAR(15) = ''
   )
AS
BEGIN	

   SET NOCOUNT ON

   DECLARE @FecProceso   CHAR(10)
       SET @FecProceso 	 = (SELECT CONVERT(CHAR(10), acfecproc, 103) FROM BacFwdSuda.dbo.MFAC with(nolock) )
   DECLARE @FecEmision   CHAR(10)
       SET @FecEmision   = (SELECT CONVERT(CHAR(10), GETDATE(), 103))
   DECLARE @HoraEmision  CHAR(10)
       SET @HoraEmision  = (SELECT CONVERT(CHAR(10), GETDATE(), 108))

   CREATE TABLE #TMP_CLASIFICACION_CLIENTE
   (   Rut             NUMERIC(12)
   ,   Codigo          INTEGER
   ,   Nombre          VARCHAR(50)
   ,   Segmento        INTEGER
   ,   Descripcion     VARCHAR(30)
   ,   Codi_Actual     INTEGER
   ,   Clas_Actual     VARCHAR(6)
   ,   Fech_Actual     DATETIME
   ,   Porcentaje_Act  NUMERIC(21,4)
   ,   Codi_Anterior   INTEGER
   ,   Clas_Anterior   VARCHAR(6)
   ,   Fech_Anterior   DATETIME
   ,   Porcentaje_Ant  NUMERIC(21,4)
   ,   EstadoClas      VARCHAR(30)
   ,   EstadoLinea     VARCHAR(30)
   ,   MensajeEstado   VARCHAR(100)
   )

   CREATE TABLE #TMP_OPERACIONES
   (   RutCliente          NUMERIC(12)
   ,   CodCliente          INTEGER
   ,   ModOrigen           CHAR(3)
   ,   NumOperacion        NUMERIC(9) 
   ,   Nocional            FLOAT
   ,   Threshold_Actual    FLOAT
   ,   Threshold_Anterior  FLOAT
   ,   AplicaThreshold     CHAR(1)
   ,   MontoREC            FLOAT
   ,   AVR                 FLOAT
   )

   INSERT INTO #TMP_CLASIFICACION_CLIENTE
   SELECT Rut             = clien.clrut
   ,      Codigo          = clien.clcodigo
   ,      Nombre          = SUBSTRING(clien.clnombre, 1, 50)
   ,      Segmento        = clien.seg_comercial
   ,      Descripcion     = ISNULL(segme.SgmDesc, '')
   ,      Codi_Actual     = tbdet.tbvalor
   ,      Clas_Actual     = tblca.valor
   ,      Fech_Actual     = tblca.fecha
   ,      Porcentaje_Act  = 0.0
   ,      Codi_Anterior   = tbdet.tbvalor
   ,      Clas_Anterior   = tblca.valor
   ,      Fech_Anterior   = tblca.fecha
   ,      Porcentaje_Ant  = 0.0
   ,      EstadoClas      = ''
   ,      EstadoLinea     = CASE WHEN ligen.Bloqueado = 'S' THEN 'LINEA BLOQUEADA'
                                 WHEN clien.Bloqueado = 'S' THEN 'CLIENTE CLOQUEADO'
                                 ELSE                            'DISPONIBLE' 
                            END
   ,      MensajeEstado   = CASE WHEN ligen.Bloqueado = 'S' THEN ISNULL( SUBSTRING(motivo_bloqueo, 1, 100), '')
                                 WHEN clien.Bloqueado = 'S' THEN ISNULL( SUBSTRING(motivo_bloqueo, 1, 100), '')
                                 ELSE                            ''
                            END
   FROM   BacParamSuda.dbo.CLIENTE                          clien with(nolock)
          INNER JOIN BacParamSuda.dbo.TBLCLASIFICARIESGO    tblca with(nolock) ON tblca.rutcliente  = clien.clrut AND tblca.codcliente     = clien.clcodigo
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tbdet with(nolock) ON tbdet.tbcateg     = 103         AND tbdet.tbcodigo1      = tblca.Valor
          LEFT  JOIN BacLineas.dbo.LINEA_GENERAL            ligen with(nolock) ON ligen.rut_cliente = clien.clrut AND ligen.codigo_cliente = clien.clcodigo
          INNER JOIN BacParamSuda.dbo.TBL_SEGMENTOSCOMERCIALES segme with(nolock) ON segme.SgmCod      = clien.seg_comercial --PRD-8800

   WHERE  tblca.Fecha     = (SELECT MAX(Actual.fecha) FROM BacParamSuda.dbo.TBLCLASIFICARIESGO Actual with(nolock)
                                                     WHERE Actual.RutCliente = tblca.rutcliente 
                                                       AND Actual.CodCliente = tblca.CodCliente)
   AND  ((clien.clrut  = @nRutCliente and clien.clcodigo = @nCodigoCli)
      or (@nRutCliente = 0            and @nCodigoCli    = 0)
        )

 SELECT TOP 1 RutCliente, CodCliente, valor, fecha, codclas = tbdet.tbvalor
     INTO #TMP_PENCLAS
     FROM BacParamSuda.dbo.TBLCLASIFICARIESGO with(nolock)
          INNER JOIN #TMP_CLASIFICACION_CLIENTE                                ON Rut = RutCliente AND Codigo = CodCliente
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tbdet with(nolock) ON tbdet.tbcateg = 103 and tbdet.tbcodigo1 = valor
     WHERE Fecha < Fech_Actual
  ORDER BY Fecha DESC

   UPDATE #TMP_CLASIFICACION_CLIENTE
   SET    Codi_Anterior   = codclas
   ,      Clas_Anterior   = valor
   ,      Fech_Anterior   = fecha
   FROM   #TMP_PENCLAS
   WHERE  Rut             = RutCliente
   AND    Codigo          = CodCliente

   UPDATE #TMP_CLASIFICACION_CLIENTE
   SET    EstadoClas      = CASE WHEN Codi_Actual = Codi_Anterior THEN 'SIN VARIACION'
                                 WHEN Codi_Actual < Codi_Anterior THEN 'ALZA'
                                 WHEN Codi_Actual > Codi_Anterior THEN 'BAJA'
                            END

   UPDATE #TMP_CLASIFICACION_CLIENTE
      SET Porcentaje_Act  = Actual.Porcentaje 
      ,   Porcentaje_Ant  = Anterios.Porcentaje 
    FROM  #TMP_CLASIFICACION_CLIENTE                          clasifica
          INNER JOIN BacParamSuda.dbo.TBL_TABLAS_DE_REDUCCION Anterios with(nolock) ON Anterios.Segmento = clasifica.Segmento AND Anterios.Nacional = clasifica.Codi_Anterior
          INNER JOIN BacParamSuda.dbo.TBL_TABLAS_DE_REDUCCION Actual   with(nolock) ON Actual.Segmento   = clasifica.Segmento AND Actual.Nacional   = clasifica.Codi_Actual

   INSERT INTO #TMP_OPERACIONES
   SELECT RutCliente          = cartera.cacodigo
   ,      CodCliente          = cartera.cacodcli
   ,      ModOrigen           = 'BFW'
   ,      NumOperacion        = cartera.canumoper
   ,      Nocional            = cartera.camtomon1
   ,      Threshold_Actual    = ISNULL(thopAct.Threshold_Aplicado, 0.0)
   ,      Threshold_Anterior  = ISNULL(hophist.Threshold_Aplicado, 0.0)
   ,      AplicaThreshold     = CASE WHEN cartera.threshold = '' THEN 'N' ELSE cartera.threshold END
   ,      MontoREC            = ISNULL(thopAct.Rec, 0.0)
   ,      AVR                 = ISNULL(cartera.fval_obtenido, 0.0)
   FROM   BacFwdSuda.dbo.MFCA                                           cartera with(nolock)
          INNER JOIN #TMP_CLASIFICACION_CLIENTE                         clasifi              ON clasifi.Rut = cartera.cacodigo AND clasifi.Codigo    = cartera.cacodcli
          LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION           thopAct with(nolock) ON thopAct.Sistema = 'BFW' AND thopAct.Numero_Operacion = cartera.canumoper
          LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION_HISTORICO hophist with(nolock) ON hophist.Sistema = 'BFW' AND hophist.Numero_Operacion = cartera.canumoper

   SELECT documento  = numero_operacion
      ,   correla    = MIN(numero_flujo)
   INTO   #tmp_cart_swap
   FROM   BacSwapSuda.dbo.CARTERA               carte with(nolock)
          INNER JOIN #TMP_CLASIFICACION_CLIENTE clasi ON clasi.Rut = carte.rut_cliente and clasi.codigo = carte.codigo_cliente
   WHERE  tipo_flujo = 1
   GROUP BY numero_operacion

   INSERT INTO #TMP_OPERACIONES
   SELECT RutCliente          = cartera.rut_cliente
   ,      CodCliente          = cartera.codigo_cliente
   ,      ModOrigen           = 'PCS'
   ,      NumOperacion        = cartera.numero_operacion
   ,      Nocional            = cartera.compra_capital
   ,      Threshold_Actual    = ISNULL(thopAct.Threshold_Aplicado, 0.0)
   ,      Threshold_Anterior  = ISNULL(hophist.Threshold_Aplicado, 0.0)
   ,      AplicaThreshold     = CASE WHEN cartera.threshold = '' THEN 'N' ELSE cartera.threshold END
   ,      MontoREC            = ISNULL(thopAct.Rec, 0.0)
   ,      AVR                 = ISNULL(cartera.valor_razonableclp, 0.0)
   FROM   BacSwapSuda.dbo.CARTERA   cartera
          INNER JOIN #tmp_cart_swap ON documento = cartera.numero_operacion and correla = cartera.numero_flujo and tipo_flujo = 1
          LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION           thopAct with(nolock) ON thopAct.Sistema = 'PCS' AND thopAct.Numero_Operacion = cartera.numero_operacion
          LEFT  JOIN BacParamSuda.dbo.TBL_THRESHOLD_OPERACION_HISTORICO hophist with(nolock) ON hophist.Sistema = 'PCS' AND hophist.Numero_Operacion = cartera.numero_operacion
  
   SELECT Rut                 = clie.Rut
   ,      Codigo              = clie.Codigo
   ,      Nombre              = clie.Nombre
   ,      Segmento            = clie.Segmento
   ,      Descripcion         = clie.Descripcion
   ,      Codi_Actual         = clie.Codi_Actual
   ,      Clas_Actual         = CASE WHEN clie.Clas_Actual   = '' THEN '--' ELSE clie.Clas_Actual   END
   ,      Fech_Actual         = clie.Fech_Actual
   ,      Porcentaje_Act      = clie.Porcentaje_Act
   ,      Codi_Anterior       = clie.Codi_Anterior
   ,      Clas_Anterior       = CASE WHEN clie.Clas_Anterior = '' THEN '--' ELSE clie.Clas_Anterior END
   ,      Fech_Anterior       = clie.Fech_Anterior
   ,      Porcentaje_Ant      = clie.Porcentaje_Ant
   ,      EstadoClas          = clie.EstadoClas
   ,      EstadoLinea         = clie.EstadoLinea
   ,      MensajeEstado       = clie.MensajeEstado
   ,      ModOrigen           = Oper.ModOrigen
   ,      NumOperacion        = Oper.NumOperacion
   ,      Nocional            = Oper.Nocional
   ,      Threshold_Actual    = Oper.Threshold_Actual
   ,      Threshold_Anterior  = Oper.Threshold_Anterior
   ,      AplicaThreshold     = Oper.AplicaThreshold
   ,      MontoREC            = Oper.MontoREC
   ,      AVR                 = Oper.AVR
   ,      FechaProceso        = @FecProceso
   ,      FechaEmision        = @FecEmision
   ,      HoraEmision         = @HoraEmision
   ,      Usuario             = @Operador
   FROM   #TMP_CLASIFICACION_CLIENTE  clie
          INNER JOIN #TMP_OPERACIONES Oper ON Oper.RutCliente = clie.rut and Oper.CodCliente = clie.codigo
   ORDER BY RutCliente, AplicaThreshold

END
GO

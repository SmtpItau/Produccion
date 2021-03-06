USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_APLICA_REDUCCION_THRESHOLD]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_APLICA_REDUCCION_THRESHOLD]
   (   @iRutCliente   NUMERIC(9)
   ,   @iCodCliente   INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @CalsRiesgo      VARCHAR(6)
   DECLARE @CodClasRiesgo   INTEGER

   SELECT  @CalsRiesgo      = clclsbif
   ,       @CodClasRiesgo   = tbtasa
   FROM    BacParamSuda.dbo.CLIENTE
           INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ON tbcateg = 103 AND tbcodigo1 = clclsbif
   WHERE   clrut            = @iRutCliente
      AND  clcodigo         = @iCodCliente 

   IF @CodClasRiesgo >= 20
      RETURN

   SELECT DISTINCT
          Modulo            = 'BFW'
      ,   Operacion         = cartera.canumoper
      ,   Puntero           = Identity(int)
   INTO   #TMP_CARTERA
   FROM   BacFwdSuda.dbo.MFCA                                 cartera   with(nolock)
          INNER JOIN BacParamSuda.dbo.TBL_REDUCCION_THRESHOLD Reduccion with(nolock) ON Reduccion.Sistema          = 'BFW'
                                                                                    AND Reduccion.Numero_Operacion = cartera.canumoper
                                                                                    AND Reduccion.PosicionInical   = 1
   WHERE  cartera.cacodigo          = @iRutCliente
   AND    cartera.cacodcli          = @iCodCliente

   INSERT INTO #TMP_CARTERA
      (   Modulo, Operacion   )
   SELECT DISTINCT
          Modulo                 = 'PCS'
      ,   Operacion              = cartera.numero_operacion
   FROM   BacSwapSuda.dbo.CARTERA                             Cartera   with(nolock)
          INNER JOIN BacParamSuda.dbo.TBL_REDUCCION_THRESHOLD Reduccion with(nolock) ON Reduccion.Sistema          = 'PCS'
                                                                                    AND Reduccion.Numero_Operacion = cartera.numero_operacion
                                                                                    AND Reduccion.PosicionInical   = 1
   WHERE  cartera.rut_cliente    = @iRutCliente
   AND    cartera.codigo_cliente = @iCodCliente

   DELETE TBL_THRESHOLD_OPERACION_HISTORICO
     FROM TBL_THRESHOLD_OPERACION                            threshold
    WHERE TBL_THRESHOLD_OPERACION_HISTORICO.Sistema          = threshold.Sistema
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Producto         = threshold.Producto
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Rut_Cliente      = threshold.Rut_Cliente
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Cod_Cliente      = threshold.Cod_Cliente
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Numero_Operacion = threshold.Numero_Operacion
/*
    WHERE TBL_THRESHOLD_OPERACION_HISTORICO.Fecha            = @dFechaProceso
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Sistema          = threshold.Sistema
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Producto         = threshold.Producto
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Rut_Cliente      = threshold.Rut_Cliente
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Cod_Cliente      = threshold.Cod_Cliente
      AND TBL_THRESHOLD_OPERACION_HISTORICO.Numero_Operacion = threshold.Numero_Operacion
*/

   INSERT INTO TBL_THRESHOLD_OPERACION_HISTORICO
      (   Fecha
      ,   Sistema
      ,   Producto
      ,   Rut_Cliente
      ,   Cod_Cliente
      ,   Numero_Operacion
      ,   Threshold_Propuesto
      ,   Threshold_Aplicado
      ,   Rec
      )
   SELECT Fecha               = @dFechaProceso
      ,   Sistema             = Sistema
      ,   Producto            = Producto
      ,   Rut_Cliente         = Rut_Cliente
      ,   Cod_Cliente         = Cod_Cliente
      ,   Numero_Operacion    = Numero_Operacion
      ,   Threshold_Propuesto = Threshold_Propuesto
      ,   Threshold_Aplicado  = Threshold_Aplicado
      ,   Rec                 = Rec
     FROM TBL_THRESHOLD_OPERACION
    WHERE Rut_Cliente         = @iRutCliente
      AND Cod_Cliente         = @iCodCliente

   UPDATE BacParamSuda.dbo.TBL_REDUCCION_THRESHOLD
      SET PosicionActual   = 0
     FROM #TMP_CARTERA
    WHERE Sistema          = Modulo
      AND Numero_Operacion = Operacion

   UPDATE BacParamSuda.dbo.TBL_REDUCCION_THRESHOLD
      SET PosicionActual   = 1
     FROM #TMP_CARTERA
    WHERE Sistema          = Modulo
      AND Numero_Operacion = Operacion
      AND Clasificacion    = @CodClasRiesgo

   SELECT Modulo           = TBLOperac.Modulo
      ,   Contrato         = TBLOperac.Operacion
      ,   Aplicado         = Threshold.Threshold_Aplicado
      ,   Recalculado      = ThresOper.Threshold
     INTO #TBL_REDUCCION
     FROM #TMP_CARTERA                       TBLOperac with(nolock)
          INNER JOIN TBL_THRESHOLD_OPERACION Threshold with(nolock) ON Threshold.Sistema          = TBLOperac.Modulo
                                                                   AND Threshold.Numero_Operacion = TBLOperac.Operacion
          INNER JOIN TBL_REDUCCION_THRESHOLD ThresOper with(nolock) ON ThresOper.Sistema          = Threshold.Sistema 
                                                                   AND ThresOper.Numero_Operacion = Threshold.Numero_Operacion 
                                                                   AND ThresOper.PosicionActual   = 1
    WHERE Threshold.Rut_Cliente      = @iRutCliente
      AND Threshold.Cod_Cliente      = @iCodCliente

   UPDATE TBL_THRESHOLD_OPERACION
      SET Threshold_Aplicado = Recalculado
     FROM #TBL_REDUCCION
    WHERE Sistema            = Modulo
      AND Numero_Operacion   = Contrato

END
GO

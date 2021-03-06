USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDAHISTORICOTHRESHOLD]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESPALDAHISTORICOTHRESHOLD]
   (   @FechaProc   CHAR(8)   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #tmpThr
   (   Sistema		      CHAR(3)
   ,   Numero_operacion	      NUMERIC(5)
   ,   Producto		      VARCHAR(5)
   ,   Rut_Cliente	      NUMERIC(9)
   ,   Cod_Cliente	      INT
   ,   Threshold_Propuesto    FLOAT
   ,   Threshold_Aplicado     FLOAT
   ,   Rec		      FLOAT
   )

   INSERT INTO #tmpThr(Sistema, Numero_operacion, Producto, Rut_Cliente, Cod_Cliente)
   SELECT DISTINCT 'PCS', numero_operacion, tipo_swap, rut_cliente, codigo_cliente
   FROM   Cartera
   WHERE  Fecha_termino = @FechaProc

   UPDATE #tmpThr
      SET Threshold_Propuesto = a.Threshold_Propuesto
      ,   Threshold_Aplicado  = a.Threshold_Aplicado
      ,   Rec                 = a.Rec
   FROM   BacParamsuda.dbo.TBL_THRESHOLD_OPERACION a, #tmpThr t
   WHERE  a.Sistema           = 'PCS' 
   AND    a.Producto          = t.Producto
   AND    a.Numero_Operacion  = t.Numero_Operacion 

   -- Borrar aquellos movimientos en que no se pudieron actualizar los valores de Threshold, 
   -- porque no están en TBL_THRESHOLD_OPERACION
   DELETE #tmpThr
    WHERE Threshold_Propuesto IS NULL

   -- Traspasar los movimientos al historico de Threshold
   INSERT INTO BacParamsuda.dbo.TBL_THRESHOLD_OPERACION_HISTORICO
   SELECT @FechaProc
      ,   t.Sistema      ,   t.Producto
      ,   t.Rut_Cliente
      ,   t.Cod_Cliente
      ,   t.Numero_Operacion
      ,   t.Threshold_Propuesto
      ,   t.Threshold_Aplicado
      ,   t.Rec
   FROM   #tmpThr t

   IF @@Error = 0
      DELETE BacParamsuda.dbo.TBL_THRESHOLD_OPERACION
        FROM #tmpThr t, BacParamsuda.dbo.TBL_THRESHOLD_OPERACION a
       WHERE a.Sistema = t.Sistema 
         AND a.Numero_Operacion = t.Numero_Operacion 
         AND a.Producto = t.Producto

   DROP TABLE #tmpThr

END
GO

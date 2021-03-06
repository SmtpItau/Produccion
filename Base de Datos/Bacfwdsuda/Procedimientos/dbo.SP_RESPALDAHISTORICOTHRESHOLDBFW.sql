USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDAHISTORICOTHRESHOLDBFW]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESPALDAHISTORICOTHRESHOLDBFW]  
   (   @FechaProc   DATETIME   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   CREATE TABLE #tmpThr  
   (   Sistema   CHAR(3)  
   ,   Numero_operacion         NUMERIC(9) --> NUMERIC(5)  
   ,   Producto          VARCHAR(5)  
   ,   Rut_Cliente  NUMERIC(9)  
   ,   Cod_Cliente  INT  
   ,   Threshold_Propuesto FLOAT  
   ,   Threshold_Aplicado FLOAT  
   ,   Rec   FLOAT  
   )  
  
   INSERT INTO #tmpThr  
   (      Sistema  
   ,      Numero_operacion  
   ,      Producto  
   ,      Rut_Cliente  
   ,      Cod_Cliente  
   )  
   SELECT Sistema          = 'BFW'  
   ,      Numero_operacion = canumoper  
   ,      Producto         = cacodpos1  
   ,      Rut_Cliente      = cacodigo  
   ,      Cod_Cliente      = cacodcli  
   FROM   BacFwdSuda.dbo.MFCA with(nolock)  
   WHERE  cafecvcto        = @FechaProc  
  
   UPDATE #tmpThr  
      SET Threshold_Propuesto = a.Threshold_Propuesto  
        , Threshold_Aplicado  = a.Threshold_Aplicado  
        , Rec                 = a.Rec  
     FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION a  
        , #tmpThr                                  t  
    WHERE a.Sistema           = 'BFW'   
      AND a.Producto          = t.Producto  
      AND a.Numero_Operacion  = t.Numero_Operacion   
  
  
   -- Borrar aquellos movimientos en que no se pudieron actualizar los valores de Threshold,   
   -- porque no están en TBL_THRESHOLD_OPERACION  
   DELETE FROM #tmpThr  
  WHERE Threshold_Propuesto IS NULL  
  
   DELETE FROM #tmpThr  
         WHERE Numero_operacion IN( SELECT Numero_Operacion FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION_HISTORICO WHERE Sistema = 'BFW' )  
  
   -- Traspasar los movimientos al historico de Threshold  
   INSERT INTO BacParamsuda.dbo.TBL_THRESHOLD_OPERACION_HISTORICO  
   SELECT @FechaProc  
   ,      t.Sistema  
   ,      t.Producto  
   ,      t.Rut_Cliente  
   ,      t.Cod_Cliente  
   ,      t.Numero_Operacion  
   ,      t.Threshold_Propuesto  
   ,      t.Threshold_Aplicado  
   ,      t.Rec  
   FROM   #tmpThr t  
  
   IF @@ERROR = 0  
   BEGIN  
      DELETE BacParamsuda.dbo.TBL_THRESHOLD_OPERACION  
        FROM #tmpThr t  
           , BacParamsuda.dbo.TBL_THRESHOLD_OPERACION a  
       WHERE a.Sistema          = t.Sistema  
         AND a.Producto         = t.Producto  
         AND a.Numero_Operacion = t.Numero_Operacion   
  
   END  
  
END
GO

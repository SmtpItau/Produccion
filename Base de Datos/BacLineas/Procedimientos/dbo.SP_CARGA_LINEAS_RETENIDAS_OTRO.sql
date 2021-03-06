USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LINEAS_RETENIDAS_OTRO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_LINEAS_RETENIDAS_OTRO]
   (   @dfechacarga   DATETIME   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   /*  
   DELETE FROM BacLineas.dbo.LINEAS_RETENIDAS  
         WHERE (Fecha = @dfechacarga AND estado_liberacion = 'N')  
  
   DELETE FROM BacLineas.dbo.LINEAS_RETENIDAS  
         WHERE ((fecha_pago = @dfechacarga AND estado_liberacion = 'N')  
      OR  (fecha_pago < @dfechacarga)  
         )  
   print 'Lineas Retenidas Eliminadas'  
   */  
  
   DELETE DATOSLINGRABAR  
   WHERE  dFecvctop < @dfechacarga  
  
   EXECUTE SP_RETIENE_LINEAS_INVEX  
-- print 'Inversiones Ok'  
  
   /*  
   EXECUTE SP_RETIENE_LINEAS_SWAP  
   print 'Swap Ok'  
  
   EXECUTE SP_RETIENE_LINEAS_FORWARD  
   print 'Forward Ok'  
   */  
   -- PROD-13828
   -- se ejecutará por Rut desde SP_RECALCALCULO_LINEAS_SPOT_OTRO 
   -- EXECUTE SP_RETIENE_LINEAS_SPOT
   -- print 'Spot Ok'
  
   EXECUTE SP_RETIENE_LINEAS_TRADER   @dfechacarga , 'BTR'  
-- print 'Renta Fija Ok'  
  
-- Calcula fecha de Vencimiento   --  
   DECLARE @iRegistros  INTEGER  
   ,       @iRegistro   INTEGER  
   ,       @dFechaVcto  DATETIME  
   ,       @iDiasVal    INTEGER  
   ,       @FormaPago   INTEGER     
   ,       @FechaPaso   DATETIME  
  
   SELECT  DISTINCT Forma_pago , fecha_pago   
   INTO    #tmpRecalc_Vcto  
   FROM    BacLineas..LINEAS_RETENIDAS  
   WHERE   Fecha         = @dfechacarga  
   AND    (forma_pago    > 0 and forma_pago <> 5)  
   AND     id_sistema    NOT IN('BCC')   
   ORDER BY Forma_pago  
     
   SELECT  @iRegistros  = COUNT(1)  
   ,       @iRegistro   = 1  
   FROM    #tmpRecalc_Vcto  
  
   WHILE @iRegistros >= @iRegistro  
   BEGIN  
      SET ROWCOUNT @iRegistro  
  
      SELECT @iDiasVal    = CASE WHEN DiasLineas = 0 THEN DiasValor  ELSE DiasLineas END  
      ,      @dFechaVcto  = fecha_pago  
      ,      @FormaPago   = forma_pago  
      FROM   #tmpRecalc_Vcto   
             LEFT JOIN BacParamSuda..FORMA_DE_PAGO ON forma_pago = codigo  
  
      SET ROWCOUNT 0  
  
      EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @dFechaVcto , @iDiasVal , @dFechaVcto OUTPUT  
  
      UPDATE LINEAS_RETENIDAS  
      SET    fecha_pago = @dFechaVcto  
      WHERE  Fecha      = @dfechacarga  
      AND    forma_pago = @FormaPago  
      AND    id_sistema NOT IN('BCC')   
  
      UPDATE DATOSLINGRABAR  
      SET    dFecvctop  = @dFechaVcto  
      WHERE  dFecvctop  = @dfechacarga  
      AND    dFecPro    = @dfechacarga  
      AND    formapago  = @FormaPago  
  
      SET    @iRegistro = @iRegistro + 1  
   END  
  
   RETURN  
END  
GO

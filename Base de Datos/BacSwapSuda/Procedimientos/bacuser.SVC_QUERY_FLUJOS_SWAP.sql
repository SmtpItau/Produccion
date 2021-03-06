USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [bacuser].[SVC_QUERY_FLUJOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [bacuser].[SVC_QUERY_FLUJOS_SWAP]
   (   @dFechaDesde   DATETIME
   ,   @dFechaHasta   DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT  Contrato = numero_operacion
      ,    Flujo    = numero_flujo
      ,    Tipo     = CASE WHEN tipo_flujo = 1 THEN 'ACTIVO' ELSE 'PASIVO' END
      ,    Producto = CASE WHEN tipo_swap  = 1 THEN 'IRS'
                           WHEN tipo_swap  = 2 THEN 'CCS'
                           WHEN tipo_swap  = 3 THEN 'FRA'
                           WHEN tipo_swap  = 4 THEN 'ICP'
                      END
      ,    Fecha    = fecha_vence_flujo
      ,    Moneda   = CASE WHEN tipo_flujo = 1 THEN compra_moneda else venta_moneda end 
      ,    Monto    = compra_capital
   FROM    BacSwapSuda.dbo.CARTERA 
   WHERE   fecha_vence_flujo BETWEEN @dFechaDesde AND @dFechaHasta
ORDER BY   tipo_swap, numero_operacion, numero_flujo, fecha_vence_flujo

END
GO

USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SVC_LEER_CONTRATO_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SVC_LEER_CONTRATO_SWAP]
   (   @nNumero_Contrato   NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_FLUJOS_SWAP
   (   Tipo_Flujo     INTEGER
   ,   Numero_Flujo   NUMERIC(3)
   ,   Fecha_Inicio   CHAR(10)
   ,   Fecha_Termino  CHAR(10)
   ,   Fecha_Pago     CHAR(10)
   ,   Interes        NUMERIC(21,4)
   ,   Amortizacion   NUMERIC(21,4)
   ,   Cuota          NUMERIC(21,4)
   ,   Saldo          NUMERIC(21,4)
   ,   Plazo          NUMERIC(9)
       CONSTRAINT [Pk_TMP_FLUJOS_SWAP] PRIMARY KEY CLUSTERED
       (   Numero_Flujo,   Tipo_Flujo   )
   )

   INSERT INTO #TMP_FLUJOS_SWAP
   SELECT Tipo_Flujo       = Tipo_Flujo
      ,   Numero_Flujo     = Numero_flujo
      ,   Fecha_Inicio     = CONVERT(CHAR(10), Fecha_inicio_flujo, 103)
      ,   Fecha_Termino    = CONVERT(CHAR(10), Fecha_Vence_Flujo, 103)
      ,   Fecha_Pago       = CONVERT(CHAR(10), FechaLiquidacion, 103)
      ,   Interes          = CASE WHEN Tipo_Flujo = 1 THEN Compra_interes  ELSE venta_interes  END
      ,   Amortizacion     = CASE WHEN Tipo_Flujo = 1 THEN Compra_amortiza ELSE venta_amortiza END
      ,   Cuota            = CASE WHEN Tipo_Flujo = 1 THEN Compra_interes  ELSE venta_interes  END
                           + CASE WHEN Tipo_Flujo = 1 THEN Compra_amortiza ELSE venta_amortiza END
      ,   Saldo            = CASE WHEN Tipo_Flujo = 1 THEN compra_saldo    ELSE venta_saldo    END
      ,   Plazo            = datediff( day, Fecha_inicio_flujo, Fecha_Vence_Flujo)
     FROM BacSwapSuda.dbo.CARTERA with(nolock)
    WHERE numero_operacion = @nNumero_Contrato

   INSERT INTO #TMP_FLUJOS_SWAP
   SELECT Tipo_Flujo       = Tipo_Flujo
      ,   Numero_Flujo     = Numero_flujo
      ,   Fecha_Inicio     = CONVERT(CHAR(10), Fecha_inicio_flujo, 103)
      ,   Fecha_Termino    = CONVERT(CHAR(10), Fecha_Vence_Flujo, 103)
      ,   Fecha_Pago       = CONVERT(CHAR(10), FechaLiquidacion, 103)
      ,   Interes          = CASE WHEN Tipo_Flujo = 1 THEN Compra_interes  ELSE venta_interes  END
      ,   Amortizacion     = CASE WHEN Tipo_Flujo = 1 THEN Compra_amortiza ELSE venta_amortiza END
      ,   Cuota            = CASE WHEN Tipo_Flujo = 1 THEN Compra_interes  ELSE venta_interes  END
                           + CASE WHEN Tipo_Flujo = 1 THEN Compra_amortiza ELSE venta_amortiza END
      ,   Saldo            = CASE WHEN Tipo_Flujo = 1 THEN compra_saldo    ELSE venta_saldo    END
      ,   Plazo            = datediff( day, Fecha_inicio_flujo, Fecha_Vence_Flujo)
     FROM BacSwapSuda.dbo.CARTERAHIS with(nolock)
    WHERE numero_operacion = @nNumero_Contrato

   SELECT Tipo_Flujo = CASE WHEN Tipo_Flujo = 1 THEN 'Recibimos' ELSE 'Entregamos' END
   ,      Numero_Flujo
   ,      Fecha_Inicio
   ,      Fecha_Termino
   ,      Fecha_Pago
   ,      Interes
   ,      Amortizacion
   ,      Cuota
   ,      Saldo
   ,      Plazo
   FROM   #TMP_FLUJOS_SWAP
 ORDER BY Tipo_Flujo, Numero_Flujo

END
GO

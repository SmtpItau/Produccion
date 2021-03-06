USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_LEE_CARTERA_SWAP]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_LEE_CARTERA_SWAP]
   (   @dFecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dProceso   DATETIME
       SET @dProceso   = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

/*
   IF @dFecha < @dProceso 
   BEGIN

      SELECT clnombre
         ,   numero_operacion
         ,   numero_flujo
         ,   tipo_flujo
         ,   compra_capital
        FROM BacSwapSuda.dbo.CARTERARES with(nolock)
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente
       WHERE Fecha_Proceso     = @dFecha
         AND Fecha_Vence_Flujo = @dFecha
    ORDER BY clnombre

   END ELSE
   BEGIN
   */
      SELECT clnombre
         ,   tipo_swap
         ,   numero_operacion
         ,   numero_flujo
         ,   tipo_flujo
         ,   Moneda        = CASE WHEN tipo_flujo = 1 THEN compra_moneda   ELSE venta_moneda   END
         ,   Capital       = CASE WHEN tipo_flujo = 1 THEN compra_capital  ELSE venta_capital  END
         ,   Amortizacion  = CASE WHEN tipo_flujo = 1 THEN compra_amortiza ELSE venta_amortiza END
         ,   Saldo         = CASE WHEN tipo_flujo = 1 THEN compra_saldo    ELSE venta_saldo    END
         ,   Interes       = CASE WHEN tipo_flujo = 1 THEN compra_interes  ELSE venta_interes  END
         ,   spread        = CASE WHEN tipo_flujo = 1 THEN compra_spread   ELSE venta_spread   END
        FROM BacSwapSuda.dbo.CARTERA with(nolock)
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente and clcodigo = codigo_cliente
       WHERE Fecha_Vence_Flujo = @dFecha
    ORDER BY clnombre

--   END

END
GO

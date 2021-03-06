USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DURATION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DURATION]( @Numero  NUMERIC(10) ,  
                              @TipOpe     CHAR( 1) ,
                              @Fecha      DATETIME ,
                              @Duration      FLOAT = 0.0 OUTPUT )
WITH RECOMPILE
AS
BEGIN

     DECLARE @Flujo     INTEGER ,
             @Monto       FLOAT ,
             @Tasa        FLOAT ,
             @Base      INTEGER ,
             @fecVence DATETIME

     --<< Datos para calcular Duration
     SELECT 'Flujo'  = numero_flujo,
            'Monto'  = CASE @TipOpe WHEN 'C' THEN compra_saldo + compra_amortiza         ELSE venta_saldo + venta_amortiza         END,
            'Interes'= CASE @TipOpe WHEN 'C' THEN compra_interes                         ELSE venta_interes                        END,
            'Tasa'   = CASE @TipOpe WHEN 'C' THEN compra_valor_tasa_hoy                  ELSE venta_valor_tasa_hoy                 END,
            'Spread' = CASE @TipOpe WHEN 'C' THEN compra_spread                          ELSE venta_spread                         END,
            'Base'   = CASE @TipOpe WHEN 'C' THEN compra_base                            ELSE venta_base                           END,
            'dTasa'  = CASE @TipOpe WHEN 'C' THEN compra_valor_tasa_hoy + compra_spread  ELSE venta_valor_tasa_hoy + venta_spread  END,
            'dMonto' = CASE @TipOpe WHEN 'C' THEN compra_amortiza                        ELSE venta_amortiza                       END,
            'Tenor'  = DATEDIFF(day, @Fecha, fecha_vence_flujo)
       INTO #Duration
       FROM Cartera
      WHERE numero_operacion = @Numero
        AND estado_flujo     = 1      -- Vigente
      ORDER BY numero_flujo

     --<< Valida existencia de Flujos
     IF (SELECT COUNT(*) FROM #Duration) = 0
         RETURN

     --<< Flujo Vigente
     SELECT @Flujo = MIN(flujo) FROM #Duration

     --<< Calcula Tasa de Interes para Flujo Vigente
     SELECT @fecVence = DATEADD(day, Tenor, @Fecha),
            @Tasa     = dTasa,
            @Base     = Base
       FROM #Duration
      WHERE Flujo = @Flujo

     EXECUTE dbo.SP_BASEINTERES @Base, @Fecha, @fecVence, @Tasa, @Tasa OUTPUT  

     UPDATE #Duration SET Interes = ROUND( Monto * @Tasa * 1. , 2 )
                    WHERE Flujo   = @Flujo
      
     --<< Calcula Intereses a la fecha

     UPDATE #Duration SET Monto = POWER( 1. + ( Tasa / 100. ) , Tenor / 365. )

     UPDATE #Duration SET dMonto = ( dMonto + Interes ) * ( 1. / Monto )
                    WHERE  Monto <> 0

     --<< Total Intereses actualizados

     SELECT @Monto = SUM(dMonto) FROM #Duration

     --<< Proporcionalidad

     UPDATE #Duration SET  Monto = ( dMonto / @Monto ) * ( Tenor / 360. )
                    WHERE @Monto <> 0

     --<< Duration

     SELECT @Duration = SUM(Monto) FROM #Duration

     IF EXISTS (SELECT 1 FROM sysobjects WHERE name = 'TEST' and type = 'U')
        SELECT * FROM #Duration  -- PENDIENTE quitar

     SELECT 'Duration' = @Duration 

END
GO

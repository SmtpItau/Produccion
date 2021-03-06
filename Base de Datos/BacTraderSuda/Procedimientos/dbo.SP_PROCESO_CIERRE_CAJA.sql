USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESO_CIERRE_CAJA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_PROCESO_CIERRE_CAJA]
                                  ( @Fecha_Hoy DATETIME ,
                                    @Fecha_Man DATETIME )
AS
BEGIN
   DECLARE @Saldo_Flujo_Caja     FLOAT   ,
           @Control_Error        INTEGER
   SELECT @Control_Error  = 0
   /* ACTUALIZA FLUJO CAJA PESOS ---------------------------------------------------- */
   SELECT @Saldo_Flujo_Caja = SUM ( CASE  
                                      WHEN tipo_movimiento = 'C' THEN monto * -1.0
                                      WHEN tipo_movimiento = 'A' THEN monto
                                    END )
     FROM GEN_FLUJO_CAJA
    WHERE fecha_pago = @Fecha_Hoy
      AND moneda     = '$$' or moneda = 'CLP'--O CLP
   INSERT GEN_FLUJO_CAJA( fecha_operacion   ,
                          fecha_pago        ,
                          moneda            ,
                          tipo_operacion    ,
                          operacion         ,
                          rut_cliente       ,
                          codigo_rut        ,
                          monto             ,
                          forma_pago        ,
                          tipo_movimiento   )
                  VALUES( @Fecha_Man        ,
                          @Fecha_Man        ,
                          '$$'              ,
                          'SAL'             ,
                          0                 ,
                          0                 ,
                          0                 ,
                          (CASE WHEN @Saldo_Flujo_Caja > 0 THEN @Saldo_Flujo_Caja
                           ELSE                                 @Saldo_Flujo_Caja * -1.0
                          END)              ,
                          ''                ,
                          (CASE WHEN @Saldo_Flujo_Caja > 0 THEN 'A'
                           ELSE                                 'C'
                          END)              )
   IF @@ERROR <> 0
   BEGIN
      SELECT @Control_Error = 1
      PRINT 'ERROR_PROC FALLA ACTUALIZA FLUJO CAJA (PESOS)'
      GOTO FIN_PROCEDIMIENTO
   END
   /* ACTUALIZA FLUJO CAJA DOLARES -------------------------------------------------- */
                
   SELECT @Saldo_Flujo_Caja = SUM ( CASE  
                                      WHEN tipo_movimiento = 'C' THEN monto * -1.0
                                      WHEN tipo_movimiento = 'A' THEN monto
                                    END )
     FROM GEN_FLUJO_CAJA
    WHERE fecha_pago = @Fecha_Hoy
      AND moneda     = 'USD'
   INSERT GEN_FLUJO_CAJA( fecha_operacion   ,
                          fecha_pago        ,
                          moneda            ,
                          tipo_operacion    ,
                          operacion         ,
                          rut_cliente       ,
                          codigo_rut        ,
                          monto             ,
                          forma_pago        ,
                          tipo_movimiento   )
                  VALUES( @Fecha_Man        ,
                          @Fecha_Man        ,
                          'USD'             ,
                          'SAL'             ,
                          0                 ,
                          0                 ,
                          0                 ,
                          (CASE WHEN @Saldo_Flujo_Caja > 0 THEN @Saldo_Flujo_Caja
                           ELSE                                 @Saldo_Flujo_Caja * -1.0
                          END)              ,
                          ''                ,
                          (CASE WHEN @Saldo_Flujo_Caja > 0 THEN 'A'
                           ELSE                                 'C'
                          END)              )
   IF @@ERROR <> 0
   BEGIN
      SELECT @Control_Error = 1
      PRINT 'ERROR_PROC FALLA ACTUALIZA FLUJO CAJA (DOLARES)'
      GOTO FIN_PROCEDIMIENTO
   END
   FIN_PROCEDIMIENTO:
IF @Control_Error <> 0 
      ROLLBACK TRANSACTION
   ELSE
      COMMIT TRANSACTION
   RETURN @Control_Error
END
--SELECT * FROM GEN_FLUJO_CAJA
--UPDATE GEN_FLUJO_CAJA SET RUT_CLIENTE = 0 WHERE OPERACION = 18
--SELECT * FROM GEN_PAGOS_OPERACION
--SELECT * FROM MECC
--SELECT * FROM GEN_MOVIMIENTO_CTA_CTE


GO

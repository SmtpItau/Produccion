USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJOINTERBANCARIO_GRABA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJOINTERBANCARIO_GRABA]
            (
             @rut_cliente      NUMERIC(9)
            ,@codigo_cliente   NUMERIC(9)   
            ,@fecha_proceso    DATETIME
            ,@codigo_producto  VARCHAR(5)
            ,@monto_operacion  NUMERIC(19)          
            )
AS
BEGIN
      SET NOCOUNT ON
      
      IF NOT EXISTS ( SELECT 1 FROM FLUJO_INTERBANCARIO WHERE rut_cliente = @rut_cliente AND fecha_proceso = @fecha_proceso AND codigo_producto = @codigo_producto) BEGIN
            
            INSERT INTO FLUJO_INTERBANCARIO
                  (
                   rut_cliente
                  ,codigo_cliente
                  ,fecha_proceso
                  ,codigo_producto
                  ,monto_operacion
                  )
            VALUES
                  (
                   @rut_cliente
                  ,@codigo_cliente
                  ,@fecha_proceso
                  ,@codigo_producto
                  ,@monto_operacion
                  )
            SELECT 'INSERTA'
      END ELSE BEGIN
            UPDATE FLUJO_INTERBANCARIO SET
                   rut_cliente                           = @rut_cliente
                  ,codigo_cliente                   = @codigo_cliente
                  ,fecha_proceso                   = @fecha_proceso
                  ,codigo_producto                   = @codigo_producto
                  ,monto_operacion                   = @monto_operacion
            
            WHERE rut_cliente = @rut_cliente AND fecha_proceso = @fecha_proceso AND codigo_producto = @codigo_producto
            
            SELECT 'MODIFICA'
      END
      SET NOCOUNT OFF
END


GO

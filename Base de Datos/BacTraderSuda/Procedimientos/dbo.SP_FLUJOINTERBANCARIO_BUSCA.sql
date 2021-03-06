USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJOINTERBANCARIO_BUSCA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJOINTERBANCARIO_BUSCA]
            (
             @rut_cliente      NUMERIC(9)
            ,@fecha_proceso    DATETIME
            ,@codigo_producto  CHAR(5)
            )
            
AS
BEGIN
      SET NOCOUNT ON
      IF EXISTS (SELECT 1 FROM FLUJO_INTERBANCARIO WHERE rut_cliente = @rut_cliente AND codigo_producto = @codigo_producto) BEGIN
            SELECT 
                   rut_cliente
                  ,codigo_cliente
                  ,fecha_proceso
                  ,codigo_producto
                  ,monto_operacion
            FROM FLUJO_INTERBANCARIO 
            WHERE rut_cliente = @rut_cliente 
            AND codigo_producto = @codigo_producto
            AND SUBSTRING(CONVERT(CHAR(8),fecha_proceso,112),5,2) = SUBSTRING(CONVERT(CHAR(8),@fecha_proceso,112),5,2)  
            AND SUBSTRING(CONVERT(CHAR(8),fecha_proceso,112),1,4) = SUBSTRING(CONVERT(CHAR(8),@fecha_proceso,112),1,4) 
      END ELSE BEGIN
            SELECT 'NO EXISTE'
      END
      SET NOCOUNT OFF
END


GO

USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_PENDIENTE]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRANSFERENCIA_PENDIENTE]
         (      
                @FECHA_OPERACION             DATETIME
               ,@FPAGO_ENTRE                 NUMERIC(2)
               ,@FPAGO_RECIB                 NUMERIC(2)
               ,@ID_SISTEMA                  CHAR(3)
               ,@TIPO_MERCADO                CHAR(4)
               ,@NUMERO_OPERACION            NUMERIC(9) 
               ,@CODIGO_MONEDA               CHAR(3)
               ,@CODIGO_MONEDA_CNV           CHAR(3)
               ,@MONTO_ORIGINAL              NUMERIC(19,4)
               ,@MONTO_DOLARES               NUMERIC(19,4)
               ,@TIPO_CAMBIO                 NUMERIC(10,4)
               ,@PARIDAD                     NUMERIC(10,4)
               ,@RUT_CLIENTE                 NUMERIC(9)
               ,@CODIGO_CLIENTE              NUMERIC(9)
               ,@TIPO_OPERACION              CHAR(1)
               ,@CASA_MATRIZ              NUMERIC(5)
               ,@MONTO_FINAL              NUMERIC(19,4)
               ,@DIAS                        NUMERIC(9)
         )
AS 
BEGIN   
   
         DECLARE @FECHA_VENCIMIENTO       DATETIME
         DECLARE @MONTO_PESOS             NUMERIC(19,4)
         DECLARE @CODIGO_PAIS             NUMERIC(5)
         DECLARE @CODIGO_PLAZA            NUMERIC(5)
         DECLARE @CODIGO_SWIFT            VARCHAR(10)
         DECLARE @FORMA_PAGO              NUMERIC(2)
         DECLARE @ESTADO_TRANSFERENCIA    VARCHAR(1)
         DECLARE @DVALORE                 NUMERIC(2)
         DECLARE @DVALORR                 NUMERIC(2)
         DECLARE @CODIGO_PRODUCTO         CHAR(5)
         DECLARE @MONE1                   NUMERIC(5)
         DECLARE @MONE2                   NUMERIC(5)
         SELECT @CODIGO_PRODUCTO        =    @TIPO_MERCADO
         SELECT @NUMERO_OPERACION       = ( SELECT accorope      FROM MEAC )
         SELECT @MONE1                  = ( SELECT mncodmon      FROM VIEW_MONEDA WHERE mnnemo = @CODIGO_MONEDA )
         SELECT @MONE2                  = ( SELECT mncodmon      FROM VIEW_MONEDA WHERE mnnemo = @CODIGO_MONEDA_CNV )
         SELECT @MONTO_PESOS            = ( @MONTO_DOLARES * @TIPO_CAMBIO )
         SELECT @CODIGO_PAIS            = ( SELECT codigo_pais   FROM VIEW_CORRESPONSAL WHERE rut_cliente = @RUT_CLIENTE )
         SELECT @CODIGO_PLAZA           = ( SELECT codigo_plaza  FROM VIEW_CORRESPONSAL WHERE rut_cliente = @RUT_CLIENTE )
         SELECT @CODIGO_SWIFT           = ( SELECT codigo_swift  FROM VIEW_CORRESPONSAL WHERE rut_cliente = @RUT_CLIENTE )
         SELECT @ESTADO_TRANSFERENCIA   = 'P'
         SELECT @DVALORE           = ( SELECT diasvalor FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGO_ENTRE )
         SELECT @DVALORR           = ( SELECT diasvalor FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGO_RECIB )
   SET NOCOUNT ON
   DECLARE @SW  INTEGER
   SELECT @SW = (CASE @TIPO_MERCADO
                      WHEN 'ARBI' THEN 2
                      ELSE 1
                  END)
   WHILE 0 < @SW 
   BEGIN
         IF @TIPO_OPERACION = 'V'
            BEGIN                        
            SELECT @FECHA_VENCIMIENTO = DATEADD( DAY , @DVALORE , @FECHA_OPERACION )
            SELECT @FORMA_PAGO        = @FPAGO_ENTRE
         END 
         ELSE BEGIN
            SELECT @FECHA_VENCIMIENTO = DATEADD( DAY , @DVALORR , @FECHA_OPERACION )
            SELECT @FORMA_PAGO        = @FPAGO_RECIB
         END
      INSERT TRANSFERENCIA_PENDIENTE
            (
                fecha_operacion             
               ,fecha_vencimiento           
               ,id_sistema 
               ,tipo_mercado 
               ,codigo_producto 
               ,numero_operacion 
               ,codigo_moneda 
               ,monto_original        
               ,monto_dolares         
               ,monto_pesos           
               ,tipo_cambio  
               ,paridad      
               ,rut_cliente 
               ,codigo_cliente 
               ,codigo_pais 
               ,codigo_plaza 
               ,codigo_swift 
               ,forma_pago 
               ,Estado_transferencia 
               ,tipo_operacion   
               ,monto_final
               ,casa_matriz
            )
      VALUES
            (
                @FECHA_OPERACION
               ,@FECHA_VENCIMIENTO
               ,@ID_SISTEMA
               ,@TIPO_MERCADO
               ,@CODIGO_PRODUCTO
               ,@NUMERO_OPERACION
               ,CASE @TIPO_MERCADO 
                     WHEN 'ARBI' THEN CASE @SW 
                                          WHEN 1 THEN @MONE2
                                          WHEN 2 THEN @MONE1
                                      END
                     ELSE @MONE1
                END
               ,@MONTO_ORIGINAL
               ,@MONTO_DOLARES
               ,@MONTO_PESOS
               ,@TIPO_CAMBIO
               ,@PARIDAD
               ,@RUT_CLIENTE
               ,@CODIGO_CLIENTE
               ,CASE @TIPO_MERCADO WHEN 'ARBI' THEN @CODIGO_PAIS  ELSE 0  END
               ,CASE @TIPO_MERCADO WHEN 'ARBI' THEN @CODIGO_PLAZA ELSE 0  END
               ,CASE @TIPO_MERCADO WHEN 'ARBI' THEN @CODIGO_SWIFT ELSE '' END
               ,@FORMA_PAGO
               ,@ESTADO_TRANSFERENCIA
               ,@TIPO_OPERACION
               ,@MONTO_FINAL
               ,@CASA_MATRIZ
            )
      SELECT  @SW   = @SW - 1
      SELECT  @TIPO_OPERACION = CASE @TIPO_OPERACION  WHEN 'V' THEN 'C'   ELSE 'V' END
   END
   SET NOCOUNT OFF
END



GO

USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_SWIFT_MOVIMIENTO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_SWIFT_MOVIMIENTO]
         ( 
                @RUT_CL         NUMERIC(9)
               ,@TIPO_M         CHAR(4)
               ,@TIPO_O         CHAR(1)
               ,@ESTADO         CHAR(1)
               ,@VALUTA         DATETIME
               ,@FECH_O         DATETIME
               ,@MONEDA         CHAR(3)
               ,@MON_O          NUMERIC(19,4)
               ,@MON_U          NUMERIC(19,4)
               ,@TIP_C          NUMERIC(19,4)
               ,@PARID          NUMERIC(19,4)
               ,@SWIFTT         CHAR(10)
         )
AS
BEGIN
DECLARE @COD_CLI           CHAR(35)
DECLARE @COD_MON           NUMERIC(5)
DECLARE @CODIGO_PRODUCTO   CHAR(5)
DECLARE @CODIGO_PAIS       NUMERIC(5)
DECLARE @CODIGO_PLAZA      NUMERIC(5)
DECLARE @CODIGO_SWIFT      VARCHAR(10)
IF @RUT_CL = (SELECT acrut FROM meac) BEGIN
   SELECT @COD_CLI         = 1
END
ELSE BEGIN
   SELECT @COD_CLI         = isnull(( SELECT clcodigo        FROM VIEW_CLIENTE       WHERE clrut           = @RUT_CL ),'0')
END
SELECT @COD_MON         = isnull(( SELECT mncodmon        FROM VIEW_MONEDA        WHERE mnnemo          = @MONEDA ),'0')
SELECT @CODIGO_PRODUCTO = ISNULL(( SELECT codigo_producto FROM VIEW_PRODUCTO      WHERE id_sistema      = 'BCC' 
                                                                                  AND codigo_producto   = @TIPO_M ), '')
SELECT @CODIGO_PAIS     = ISNULL(( SELECT clpais          FROM VIEW_CLIENTE       WHERE clrut           = @RUT_CL 
                                                                                  AND clcodigo          = @COD_CLI), 0 )
SELECT @CODIGO_PLAZA    = 0 --ISNULL(( SELECT codigo_plaza    FROM VIEW_CORRESPONSAL  WHERE codigo_pais     = @CODIGO_PAIS 
--                                                                                  AND rut_cliente       = @RUT_CL ),0)
SELECT @CODIGO_SWIFT    = @SWIFTT 
--SELECT @CODIGO_SWIFT    = ISNULL(( SELECT codigo_swift    FROM VIEW_CORRESPONSAL  WHERE codigo_pais     = @CODIGO_PAIS 
--                                                                                  AND codigo_plaza      = @CODIGO_PLAZA
--                      AND rut_cliente       = @RUT_CL ), '0')
IF NOT EXISTS( SELECT 1 FROM SWIFT_MOVIMIENTO WHERE fecha_operacion   = @FECH_O
                                                AND fecha_vencimiento = @VALUTA
                                                AND id_sistema        = 'BCC' 
                                                AND tipo_mercado      = @TIPO_M
                                                AND codigo_producto   = @CODIGO_PRODUCTO
                                                AND tipo_operacion    = @TIPO_O
                                                AND codigo_moneda     = @COD_MON
                                                AND estado_swift      = @ESTADO
                                                AND rut_cliente       = @RUT_CL
                                                AND codigo_cliente    = @COD_CLI ) 
 
BEGIN
   INSERT SWIFT_MOVIMIENTO
     ( 
       fecha_operacion
      ,fecha_vencimiento
      ,id_sistema
      ,codigo_producto
      ,tipo_mercado
      ,codigo_moneda
      ,tipo_operacion
      ,monto_original
      ,monto_dolares
      ,tipo_cambio
      ,paridad
      ,rut_cliente
      ,codigo_cliente
      ,codigo_pais
      ,codigo_plaza
      ,codigo_swift
      ,estado_swift
      )
   VALUES
      ( 
        @FECH_O
       ,@VALUTA
       ,'BCC'
       ,@CODIGO_PRODUCTO
       ,@TIPO_M
       ,@COD_MON
       ,@TIPO_O
       ,@MON_O
       ,@MON_U
       ,@TIP_C
       ,@PARID
       ,@RUT_CL
       ,@COD_CLI
       ,@CODIGO_PAIS
       ,ISNULL(@CODIGO_PLAZA,0)
       ,@CODIGO_SWIFT
       ,@ESTADO
      )
END
ELSE BEGIN
   
   UPDATE SWIFT_MOVIMIENTO
      SET monto_original     = @MON_O
         ,monto_dolares      = @MON_U
         ,tipo_cambio        = @TIP_C
         ,paridad            = @PARID
   WHERE fecha_operacion     = @FECH_O
     AND fecha_vencimiento   = @VALUTA
     AND codigo_producto     = @CODIGO_PRODUCTO
     AND tipo_mercado        = @TIPO_M
     AND codigo_moneda       = @COD_MON
     AND tipo_operacion      = @TIPO_O
     AND rut_cliente = @RUT_CL
END
END



GO

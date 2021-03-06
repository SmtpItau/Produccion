USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_DETALLE_INTERESES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_DETALLE_INTERESES]
                    (
                        @PLANILLA_FECHA          CHAR(8)         ,
                        @PLANILLA_NUMERO         NUMERIC(6)      ,
                        @CORRELATIVO   NUMERIC(3)      ,
                        @CONCEPTO_CAPITAL        CHAR(3)         ,
                        @CAPITAL                 NUMERIC(15,2)   ,
                        @TIPO_INTERES            CHAR(2)         ,
                        @CODIGO_BASE_TASA        NUMERIC(1)      ,
                        @TASA_INTERES_ANUAL      NUMERIC(9,6)    ,
                        @FECHA_INICIAL           CHAR(8)         ,
                        @FECHA_FINAL             CHAR(8)         ,
                        @MONTO_INTERES           NUMERIC(13,2)   ,
                        @INDICA_PAGO_EXTERIOR    NUMERIC(1)
                     )
AS
BEGIN
set nocount on
   BEGIN TRANSACTION
   DECLARE @FECHA DATETIME
   SELECT @FECHA = CONVERT(DATETIME,@PLANILLA_FECHA + ' ' + CONVERT(CHAR(5),GETDATE(),108))
   SELECT @FECHA
   IF @CORRELATIVO = 0 
      SELECT @CORRELATIVO = 1
   IF EXISTS (SELECT planilla_fecha,planilla_numero,correlativo
               FROM TBDETALLEINTERESES
              WHERE CONVERT(CHAR(8),planilla_fecha,112) = @PLANILLA_FECHA  AND
                    planilla_numero = @PLANILLA_NUMERO AND correlativo = @CORRELATIVO)
      BEGIN       -- Actualizando
   SELECT 'ACTUALIZANDO ...'
   UPDATE TBDETALLEINTERESES
      SET fecha                = GETDATE(),
          planilla_fecha       = @PLANILLA_FECHA,
          planilla_numero      = @PLANILLA_NUMERO,
          correlativo       = @CORRELATIVO,
          concepto_capital     = @CONCEPTO_CAPITAL,
          capital              = @CAPITAL,
          tipo_interes         = @TIPO_INTERES,
           codigo_base_tasa     = @CODIGO_BASE_TASA,
          tasa_interes_anual   = @TASA_INTERES_ANUAL,
          fecha_inicial        = @FECHA_INICIAL,
          fecha_final          = @FECHA_FINAL,
          monto_interes        = @MONTO_INTERES,
          indica_pago_exterior = @INDICA_PAGO_EXTERIOR
    WHERE CONVERT(CHAR(8),planilla_fecha,112) = @PLANILLA_FECHA AND
          planilla_numero = @PLANILLA_NUMERO AND 
          correlativo     = @CORRELATIVO
          IF @@error<>0
             BEGIN
                 ROLLBACK TRANSACTION
                 SELECT 'NO UPDATE'
                 RETURN
             END
      END
   ELSE
      BEGIN       -- Actualizando
   SELECT 'INSERTANDO ...'
      INSERT TBDETALLEINTERESES(
            fecha,
            planilla_fecha,
            planilla_numero,
            correlativo,
            concepto_capital,
            capital,
            tipo_interes,
            codigo_base_tasa,
            tasa_interes_anual,
            fecha_inicial,
            fecha_final,
            monto_interes,
            indica_pago_exterior )
  VALUES(
            GETDATE(),
            @PLANILLA_FECHA,
            @PLANILLA_NUMERO,
            @CORRELATIVO,
            @CONCEPTO_CAPITAL,
            @CAPITAL,
            @TIPO_INTERES,
            @CODIGO_BASE_TASA,
            @TASA_INTERES_ANUAL,
            @FECHA_INICIAL,
            @FECHA_FINAL,
            @MONTO_INTERES,
            @INDICA_PAGO_EXTERIOR )
          IF @@error<>0
             BEGIN
                 ROLLBACK TRANSACTION
                 SELECT 'NO INSERT'
                 RETURN
             END
      END
   COMMIT TRANSACTION
   SELECT 'OK'
set nocount off
END

GO

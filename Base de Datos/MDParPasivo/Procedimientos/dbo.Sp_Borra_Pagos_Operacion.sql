USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borra_Pagos_Operacion]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_Borra_Pagos_Operacion] ( @tipo_operacion       CHAR(4)     ,
                                       @operacion            NUMERIC(10) )
AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


DECLARE @fecha_hoy DATETIME

SELECT @fecha_hoy = Fecha_Proceso FROM DATOS_GENERALES

DELETE GEN_MOVIMIENTO_CTA_CTE 

 WHERE tipo_operacion   = @tipo_operacion

   AND operacion        = @operacion 
   AND fecha_movimiento = @fecha_hoy
         
IF @@ERROR <> 0 
BEGIN
   PRINT "ERROR_PROC FALLA BORRANDO MOVIMIENTO DE CUENTA CORRIENTE"
   RETURN 1
END

IF EXISTS( SELECT 1 FROM GEN_PAGOS_OPERACION WHERE tipo_operacion = @tipo_operacion
                                               AND operacion      = @operacion )
BEGIN

   DELETE GEN_PAGOS_OPERACION WHERE tipo_operacion = @tipo_operacion 
                                AND operacion      = @operacion      
                                AND fecha_pago     = @fecha_hoy
   IF @@ERROR <> 0
   BEGIN
      PRINT "ERROR_PROC FALLA BORRANDO DETALLE DE PAGOS OPERACION"
      RETURN 1
   END

END

UPDATE GEN_OPERACIONES SET cerrada = "N" WHERE tipo_operacion = @tipo_operacion
                                           AND operacion      = @operacion
                                           AND fecha_pago     = @fecha_hoy
IF @@ERROR <> 0
BEGIN
   PRINT "ERROR_PROC FALLA ACTUALIZANDO MARCA CERRADA EN OPERACIONES"
   RETURN 1
END 

RETURN 0
 
END   /* FIN PROCEDIMIENTO */

-- SP_HELP GEN_PAGOS_OPERACION
-- DELETE GEN_PAGOS_OPERACION

-- SP_ANULA_PAGOS_OPERACION 'OP','CI', 10445, 0,'O'


GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_OPERACION_TESORERIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BORRA_OPERACION_TESORERIA]
                                        ( @ID_Sistema         CHAR(3)     ,
                                          @Tipo_Operacion     CHAR(4)     ,
                                          @Operacion          NUMERIC(10) )
AS
BEGIN
SET NOCOUNT ON
DECLARE @Cerrada  CHAR(1)
SELECT @Cerrada = cerrada
  FROM GEN_OPERACIONES
 WHERE id_sistema     = @ID_Sistema
   AND tipo_operacion = @Tipo_Operacion
   AND operacion      = @Operacion
IF @Cerrada = 'S'
BEGIN
   SET NOCOUNT OFF
   PRINT 'ERROR_PROC OPERACION YA LIQUIDADA POR TESORERIA.'
   SELECT 'ERR'
   RETURN 2
END
DELETE GEN_OPERACIONES
 WHERE id_sistema     = @ID_Sistema
   AND tipo_operacion = @Tipo_Operacion
   AND operacion      = @Operacion
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   PRINT 'ERROR_PROC FALLA BORRANDO OPERACION TESORERIA.'
   SELECT 'ERR'
   RETURN 1
END
DELETE GEN_FLUJO_CAJA
 WHERE tipo_operacion = @Tipo_Operacion
   AND operacion      = @Operacion
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   PRINT 'ERROR_PROC FALLA BORRANDO FLUJO DE CAJA.'
   SELECT 'ERR'
   RETURN 1
END
DELETE GEN_TRANSFER_MX
 WHERE
 id_sistema = @ID_Sistema
   AND operacion  = @Operacion
IF @@ERROR <> 0
BEGIN
   SET NOCOUNT OFF
   PRINT 'ERROR_PROC FALLA BORRANDO TRANSFERENCIAS M/X.'
   SELECT 'ERR'
   RETURN 1
END
SET NOCOUNT OFF
SELECT 'OK'
RETURN 0
END   /* FIN PROCEDIMIENTO */

GO

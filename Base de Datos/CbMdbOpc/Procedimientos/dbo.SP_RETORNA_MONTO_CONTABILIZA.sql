USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_MONTO_CONTABILIZA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[SP_RETORNA_MONTO_CONTABILIZA]
   (   @ID_Sistema       CHAR(3)    
   ,   @Tipo_Movimiento  CHAR(3)    
   ,   @Tipo_Operacion   CHAR(5)    
   ,   @Operacion        NUMERIC(10)
   ,   @Folio            NUMERIC(10)
   ,   @Correlativo      NUMERIC(03)
   ,   @Codigo_Campo     NUMERIC(03)
   ,   @Reversa          NUMERIC(1) 
   ,   @Monto            NUMERIC(18,2) OUTPUT 
   ) 
AS
BEGIN
-- 17 de Septiembre Modifica Tipos de Datos
   DECLARE @Cmd_Sql       VARCHAR(355)
   ,       @Nombre_Campo  VARCHAR(250)

   SELECT @Nombre_Campo              = Nombre_Campo_Tabla
   FROM   BacParamSudaCAMPO_CNT 
   WHERE  ID_Sistema                 = @ID_Sistema
   AND    Tipo_Movimiento            = @Tipo_Movimiento
   AND    Tipo_Operacion             = @Tipo_Operacion
   AND    Codigo_Campo               = @Codigo_Campo
   AND    Tipo_Administracion_Campo  = 'F'

   DELETE CntContabilizaPaso

   IF @@ERROR <> 0
   BEGIN
      PRINT "ERROR_PROC FALLA BORRANDO CONTABILIZA PASO."
      RETURN 1
   END
   -- Ver si esto se puede hacer en una temporal
   /* BUSCA EL VALOR DEL CAMPO A CONTABILIZAR ---------------------------------------------- */
   SELECT @Cmd_Sql = "INSERT CNTContabilizaPaso( Monto ) SELECT " + RTRIM(@Nombre_Campo)
   SELECT @Cmd_Sql = @Cmd_Sql + " FROM CntContabiliza WHERE "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntSisCod = '" + RTRIM(@ID_Sistema)      + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntTipoMovimiento = '" + RTRIM(@Tipo_Movimiento) + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntTipoOperacion = '" + RTRIM(@Tipo_Operacion)  + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntContrato = " + LTRIM(STR(@Operacion))  + "  AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntFolio = " + LTRIM(STR(@Folio))  + "  AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "CntComponente = " + LTRIM(STR(@Correlativo))
     /* + "  AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Reversa = " + LTRIM(STR(@Reversa)) */
   --select 'debug' , @Cmd_Sql 
   EXECUTE (@Cmd_Sql)

   IF @@ERROR <> 0
   BEGIN
      PRINT "ERROR_PROC FALLA ACTUALIZANDO CONTABILIZA PASO CON MONTO."

      RETURN 1
   END
   SELECT @Monto = ISNULL(Monto, 0) FROM CNTContabilizaPaso
END
/* FIN PROCEDIMIENTO */

GO

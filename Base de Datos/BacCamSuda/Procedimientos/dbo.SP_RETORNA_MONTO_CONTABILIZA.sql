USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_MONTO_CONTABILIZA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_RETORNA_MONTO_CONTABILIZA]
       (
        @ID_Sistema       CHAR(3),
        @Tipo_Movimiento  CHAR(3)    ,
        @Tipo_Operacion   CHAR(5)    ,
        @Operacion        NUMERIC(10),
        @Correlativo      NUMERIC(03),
        @Documento        NUMERIC(10),
        @Codigo_Campo     NUMERIC(03), 
        @Monto            NUMERIC(18,2) OUTPUT
       ) 
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @Cmd_Sql       VARCHAR(255)
   DECLARE @Nombre_Campo  CHAR(30)
   SELECT @Nombre_Campo = Nombre_Campo_Tabla
          FROM VIEW_CAMPO_CNT
          WHERE ID_Sistema                = @ID_Sistema
            AND Tipo_Movimiento           = @Tipo_Movimiento
            AND Tipo_Operacion            = @Tipo_Operacion
            AND Codigo_Campo              = @Codigo_Campo
            AND Tipo_Administracion_Campo = 'F'
   DELETE BAC_CNT_CONTABILIZA_PASO
   IF @@ERROR <> 0 BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
      RETURN 1
   END
   /* BUSCA EL VALOR DEL CAMPO A CONTABILIZAR ---------------------------------------------- */

/* REQ.7619 CASS 06-01-2011
   SELECT @Cmd_Sql = "INSERT BAC_CNT_CONTABILIZA_PASO( Monto ) SELECT " + RTRIM(@Nombre_Campo)
   SELECT @Cmd_Sql = @Cmd_Sql + " FROM BAC_CNT_CONTABILIZA WHERE "
   SELECT @Cmd_Sql = @Cmd_Sql + "ID_Sistema = '" + RTRIM(@ID_Sistema)      + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Tipo_Movimiento = '" + RTRIM(@Tipo_Movimiento) + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Tipo_Operacion = '" + RTRIM(@Tipo_Operacion)  + "' AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Operacion =  " + LTRIM(STR(@Operacion))  + "  AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Correlativo =  " + LTRIM(STR(@Correlativo))+ "  AND "
   SELECT @Cmd_Sql = @Cmd_Sql + "Documento =  " + LTRIM(STR(@Documento))  
*/
   SELECT @Cmd_Sql = 'INSERT BAC_CNT_CONTABILIZA_PASO( Monto ) SELECT ' + RTRIM(@Nombre_Campo)
   SELECT @Cmd_Sql = @Cmd_Sql + ' FROM BAC_CNT_CONTABILIZA WHERE '
   SELECT @Cmd_Sql = @Cmd_Sql + 'ID_Sistema = ''' + RTRIM(@ID_Sistema)      + ''' AND '
   SELECT @Cmd_Sql = @Cmd_Sql + 'Tipo_Movimiento = ''' + RTRIM(@Tipo_Movimiento) + ''' AND '
   SELECT @Cmd_Sql = @Cmd_Sql + 'Tipo_Operacion = ''' + RTRIM(@Tipo_Operacion)  + ''' AND '
   SELECT @Cmd_Sql = @Cmd_Sql + 'Operacion =  ' + LTRIM(STR(@Operacion))  + '  AND '
   SELECT @Cmd_Sql = @Cmd_Sql + 'Correlativo =  ' + LTRIM(STR(@Correlativo))+ '  AND '
   SELECT @Cmd_Sql = @Cmd_Sql + 'Documento =  ' + LTRIM(STR(@Documento))  


--IF @Tipo_Operacion = 'TM' SELECT @Cmd_Sql
   EXECUTE (@Cmd_Sql)
   IF @@ERROR <> 0 BEGIN
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO CONTABILIZA PASO CON MONTO.'
      RETURN 1
   END
   SELECT @Monto = ISNULL(Monto, 0) FROM BAC_CNT_CONTABILIZA_PASO
   SET NOCOUNT OFF
   RETURN 0
END   /* FIN PROCEDIMIENTO */




GO

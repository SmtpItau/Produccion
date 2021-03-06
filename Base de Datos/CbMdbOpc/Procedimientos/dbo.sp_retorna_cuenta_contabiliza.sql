USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[sp_retorna_cuenta_contabiliza]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_retorna_cuenta_contabiliza]( @ID_Sistema             CHAR(3)    ,
                                           @Tipo_Movimiento        CHAR(3)    ,
                                           @Tipo_Operacion         CHAR(5)    ,
                                           @Operacion              NUMERIC(10),
                                           @Correlativo            NUMERIC(03),
                                           @Folio_Perfil           NUMERIC(10),
                                           @Correlativo_Perfil     NUMERIC(03),
                                           @Codigo_Campo_Variable  NUMERIC(03),
                                           @nMonto                 NUMERIC(18,2),
                                           @Codigo_Cuenta          CHAR(20)   OUTPUT, 
                                            @Valor_Campo           VARCHAR(250)OutPut ) 
AS
BEGIN
-- Se modifican tipos de datos
-- MAP Entrega 13 Nov., se trasmite código de campo para indicacion llenado de perfiles

DECLARE @Cmd_Sql       VARCHAR(255),
        @Nombre_Campo  VARCHAR(250)    
--        @Valor_Campo   VARCHAR(250)
--SET NOCOUNT ON         --ADO
--<< Captura nombre de Campo en Cartera o Movimiento si es Variable
SELECT @Nombre_Campo = Nombre_Campo_Tabla
  FROM bacParamSudacampo_cnt 
 WHERE ID_Sistema                = @ID_Sistema
   AND Tipo_Movimiento           = @Tipo_Movimiento
   AND Tipo_Operacion            = @Tipo_Operacion
   AND Codigo_Campo              = @Codigo_Campo_Variable
   AND Tipo_Administracion_Campo = "V"
DELETE CntContabilizaPaso
IF @@ERROR <> 0
BEGIN
     PRINT "ERROR_PROC FALLA BORRANDO CONTABILIZA PASO."
     RETURN 1
END
IF @Codigo_Campo_Variable<>519 BEGIN
SELECT @Cmd_Sql = "INSERT CntContabilizaPaso ( Valor_Campo ) "
SELECT @Cmd_Sql = @Cmd_Sql + "SELECT " + RTRIM(@Nombre_Campo) + " FROM CntContabiliza WHERE "
SELECT @Cmd_Sql = @Cmd_Sql + "CntSisCod      = '" + RTRIM(@ID_Sistema)      + "' AND "
SELECT @Cmd_Sql = @Cmd_Sql + "CntTipoMovimiento = '" + RTRIM(@Tipo_Movimiento) + "' AND "
SELECT @Cmd_Sql = @Cmd_Sql + "CntTipoOperacion  = '" + RTRIM(@Tipo_Operacion)  + "' AND "
SELECT @Cmd_Sql = @Cmd_Sql + "CntContrato       =  " + LTRIM(STR(@Operacion))  + "  AND "
SELECT @Cmd_Sql = @Cmd_Sql + "CntComponente     =  " + LTRIM(STR(@Correlativo))
EXECUTE (@Cmd_Sql)
IF @@ERROR <> 0     --select * from CntContabiliza
BEGIN
     PRINT "ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON VALOR CAMPO."
     RETURN 1
END
SELECT @Valor_Campo = ""
SELECT @Valor_Campo = ISNULL(Valor_Campo, "") FROM CntContabilizaPaso
end
DELETE CntCOntabilizaPaso
IF @@ERROR <> 0
BEGIN
     PRINT "ERROR_PROC FALLA BORRANDO CONTABILIZA PASO."
     RETURN 1
END
IF @Codigo_Campo_Variable=519 BEGIN
   IF @nMonto > 0 bEGIN
      select @Valor_Campo=1
   end  ELSE   begin
      select @Valor_Campo=2
   end
END 
SELECT @Cmd_Sql = "INSERT CntCOntabilizaPaso( Codigo_Cuenta ) "
SELECT @Cmd_Sql = @Cmd_Sql + "SELECT Codigo_Cuenta FROM BacParamSudaperfil_variable_cnt WHERE "
SELECT @Cmd_Sql = @Cmd_Sql + "Folio_Perfil       =  " + RTRIM(STR(@Folio_Perfil)) + " AND "
SELECT @Cmd_Sql = @Cmd_Sql + "Valor_Dato_Campo   = '" + RTRIM(@Valor_Campo)       + "' AND "
SELECT @Cmd_Sql = @Cmd_Sql + "Correlativo_Perfil =  " + RTRIM(STR(@Correlativo_Perfil))
EXECUTE (@Cmd_Sql)
IF @@ERROR <> 0
BEGIN
     PRINT "ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON CUENTA."
     RETURN 1
END
SELECT @Codigo_Cuenta = ""
SELECT @Codigo_Cuenta = ISNULL(Codigo_Cuenta, "") FROM CntCOntabilizaPaso
END   /* FIN PROCEDIMIENTO */

GO

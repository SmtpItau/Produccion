USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]( @ID_Sistema             CHAR(3)    ,
                                           @Tipo_Movimiento        CHAR(3)    ,
                                           @Tipo_Operacion         CHAR(5)    ,
                                           @Operacion              NUMERIC(10),
                                           @Correlativo            NUMERIC(03),
                                           @Folio_Perfil           NUMERIC(10),
                                           @Correlativo_Perfil     NUMERIC(03),
                                           @Codigo_Campo_Variable  NUMERIC(03),
                                           @nMonto                 NUMERIC(18,2),
                                           @Codigo_Cuenta          CHAR(20)   OUTPUT ) 
AS
BEGIN
DECLARE @Cmd_Sql       VARCHAR(255),
        @Nombre_Campo  CHAR(30)    ,
        @Valor_Campo   CHAR(40)

   --<< Captura nombre de Campo en Cartera o Movimiento si es Variable

 SELECT @Nombre_Campo = Nombre_Campo_Tabla
   FROM view_campos_cnt 
  WHERE ID_Sistema                = @ID_Sistema
    AND Tipo_Movimiento           = @Tipo_Movimiento
    AND Tipo_Operacion            = @Tipo_Operacion
    AND Codigo_Campo              = @Codigo_Campo_Variable
    AND Tipo_Administracion_Campo  = 'V'

 DELETE BAC_CNT_CONTABILIZA_PASO

IF @@ERROR <> 0
BEGIN
     PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
     RETURN 1
END
IF @Codigo_Campo_Variable<>519 BEGIN
SELECT @Cmd_Sql = 'INSERT BAC_CNT_CONTABILIZA_PASO( Valor_Campo ) '
-- SELECT @Cmd_Sql = @Cmd_Sql + 'SELECT            ''' + RTRIM( @Nombre_Campo )     + ''' FROM BAC_CNT_CONTABILIZA WHERE '
SELECT @Cmd_Sql = @Cmd_Sql + 'SELECT   ' + RTRIM(@Nombre_Campo ) + ' FROM BAC_CNT_CONTABILIZA WHERE '
SELECT @Cmd_Sql = @Cmd_Sql + 'ID_Sistema      = ''' +  RTRIM( @ID_Sistema ) + '''     AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Tipo_Movimiento = ''' + RTRIM( @Tipo_Movimiento ) + ''' AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Tipo_Operacion  = ''' + RTRIM( @Tipo_Operacion )+ '''   AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Operacion       = ''' + LTRIM(STR( @Operacion ))+ '''   AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Correlativo     = ' + LTRIM(STR( @Correlativo )) 
EXECUTE (@Cmd_Sql)


--print @Cmd_Sql

IF @@ERROR <> 0
BEGIN

     PRINT 'ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON VALOR CAMPO.'
     RETURN 1
END
SELECT @Valor_Campo = ''
SELECT @Valor_Campo = ISNULL(Valor_Campo, '') FROM BAC_CNT_CONTABILIZA_PASO
end
DELETE BAC_CNT_CONTABILIZA_PASO
IF @@ERROR <> 0
BEGIN
     PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
     RETURN 1
END
IF @Codigo_Campo_Variable=519 BEGIN
   IF @nMonto > 0 bEGIN
      select @Valor_Campo=1
   end  ELSE   begin
      select @Valor_Campo=2
   end
END 
SELECT @Cmd_Sql = 'INSERT BAC_CNT_CONTABILIZA_PASO( Codigo_Cuenta ) '
SELECT @Cmd_Sql = @Cmd_Sql + 'SELECT Codigo_Cuenta FROM view_perfil_variable_cnt WHERE '
SELECT @Cmd_Sql = @Cmd_Sql + 'Folio_Perfil       = ''' + RTRIM(STR( @Folio_Perfil ))+ '''  AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Valor_Dato_Campo   = ''' + RTRIM( @Valor_Campo )+ '''        AND '
SELECT @Cmd_Sql = @Cmd_Sql + 'Correlativo_Perfil = ' + RTRIM(STR( @Correlativo_Perfil))
EXECUTE (@Cmd_Sql)
IF @@ERROR <> 0
BEGIN
     PRINT 'ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON CUENTA.'
     RETURN 1
END
SELECT @Codigo_Cuenta = ''
SELECT @Codigo_Cuenta = ISNULL(Codigo_Cuenta, '') FROM BAC_CNT_CONTABILIZA_PASO
END   /* FIN PROCEDIMIENTO */
GO

USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]( @ID_Sistema             CHAR(3)    ,
                                                @Tipo_Movimiento        CHAR(3)    ,
                                                @Tipo_Operacion         CHAR(5)    ,
                                                @Operacion              NUMERIC(10),
                                                @Correlativo            NUMERIC(03),
                                                @Documento              NUMERIC(10),
                                                @Folio_Perfil           NUMERIC(10),
                                                @Correlativo_Perfil     NUMERIC(03),
                                                @Codigo_Campo_Variable  NUMERIC(03),
                                                @Codigo_Cuenta          CHAR(20)   OUTPUT ) 
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Cmd_Sql       VARCHAR(255)
	DECLARE @Nombre_Campo  CHAR(30)
	DECLARE @Valor_Campo   CHAR(40)

	SELECT	@Nombre_Campo = Nombre_Campo_Tabla
	FROM	VIEW_CAMPO_CNT 
	WHERE	ID_Sistema                = @ID_Sistema            AND
		Tipo_Movimiento           = @Tipo_Movimiento       AND
		Tipo_Operacion            = @Tipo_Operacion        AND
		Codigo_Campo              = @Codigo_Campo_Variable AND
		Tipo_Administracion_Campo = 'V'
--SELECT	* from VIEW_CAMPO_CNT
	DELETE BAC_CNT_CONTABILIZA_PASO

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
		RETURN 1
	END


	SELECT @Cmd_Sql='INSERT BAC_CNT_CONTABILIZA_PASO( Valor_Campo ) ' +
			'SELECT ' + RTRIM(@Nombre_Campo) + ' FROM BAC_CNT_CONTABILIZA WHERE ' +
			'ID_Sistema = ''' + RTRIM(@ID_Sistema)      + ''' AND ' +
			'Tipo_Movimiento = ''' + RTRIM(@Tipo_Movimiento) + ''' AND ' +
			'Tipo_Operacion = ''' + RTRIM(@Tipo_Operacion)  + ''' AND ' +
			'Operacion =  ' + LTRIM(STR(@Operacion))  + '  AND ' +
			'Correlativo =  ' + LTRIM(STR(@Correlativo))--+ '  AND ' +
--			'Documento =  ' + LTRIM(STR(@Documento))

--select @Cmd_Sql
-- select Operacion,Documento , * from bac_cnt_contabiliza

	EXECUTE (@Cmd_Sql)

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON MONTO.'
		RETURN 1
	END


	SELECT @Valor_Campo = ''
	SELECT @Valor_Campo = ISNULL(Valor_Campo, '') FROM BAC_CNT_CONTABILIZA_PASO

	DELETE BAC_CNT_CONTABILIZA_PASO

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
		RETURN 1
	END

	SELECT @Cmd_Sql='INSERT BAC_CNT_CONTABILIZA_PASO( Codigo_Cuenta ) ' +
			'SELECT Codigo_Cuenta FROM VIEW_PERFIL_VARIABLE_CNT WHERE ' +
			'Folio_Perfil     =  ' + RTRIM(STR(@Folio_Perfil)) + ' AND ' +
			'correlativo_perfil =  ' + RTRIM(STR(@Correlativo_Perfil)) + ' AND ' +
			'Valor_Dato_Campo = ''' + RTRIM(@Valor_Campo)       + ''''

	EXECUTE (@Cmd_Sql)

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON MONTO.'
		RETURN 1
	END

	SELECT @Codigo_Cuenta = ''
	SELECT @Codigo_Cuenta = ISNULL(Codigo_Cuenta, '') FROM BAC_CNT_CONTABILIZA_PASO

	RETURN 0

END 

GO

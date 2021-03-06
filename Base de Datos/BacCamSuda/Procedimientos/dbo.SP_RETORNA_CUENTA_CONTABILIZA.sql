USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_CUENTA_CONTABILIZA]	(	@ID_Sistema             CHAR(3)    
						,	@Tipo_Movimiento        CHAR(3)    
						,	@Tipo_Operacion         CHAR(5)    
						,	@Operacion              NUMERIC(10)
						,	@Correlativo            NUMERIC(03)
						,	@Documento              NUMERIC(10)
						,	@Folio_Perfil           NUMERIC(10)
						,	@Correlativo_Perfil     NUMERIC(03)
						,	@Codigo_Campo_Variable  NUMERIC(03)
						,	@Codigo_Cuenta          CHAR(20)	OUTPUT
						,	@Valor_Campo            VARCHAR(30)	OUTPUT
						)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@Cmd_Sql       VARCHAR(255)
	,	@Nombre_Campo	CHAR(30)
--	,	@Valor_Campo	CHAR(40)
	,	@Concepto	VARCHAR(70)
	,	@Fecha_Hoy	DATETIME

	SELECT @Fecha_Hoy = ACFECPRO FROM MEAC

	SELECT	@Nombre_Campo = Nombre_Campo_Tabla
	,	@Concepto	= LTRIM(RTRIM(ISNULL(descripcion_campo,'No Encontrado')))
          FROM  VIEW_CAMPO_CNT 
          WHERE ID_Sistema                = @ID_Sistema            AND
                Tipo_Movimiento           = @Tipo_Movimiento       AND
                Tipo_Operacion            = @Tipo_Operacion        AND
                Codigo_Campo              = @Codigo_Campo_Variable AND
                Tipo_Administracion_Campo = 'V'

	DELETE BAC_CNT_CONTABILIZA_PASO

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR_PROC FALLA BORRANDO CONTABILIZA PASO.'
		RETURN 1
	END

/* -->REQ.7619 CASS 05-01-2011

   SELECT @Cmd_Sql = "INSERT BAC_CNT_CONTABILIZA_PASO( Valor_Campo ) " +
                     "SELECT " + RTRIM(@Nombre_Campo) + " FROM BAC_CNT_CONTABILIZA WHERE " +
                     "ID_Sistema = '" + RTRIM(@ID_Sistema)      + "' AND " +
                     "Tipo_Movimiento = '" + RTRIM(@Tipo_Movimiento) + "' AND " +
                     "Tipo_Operacion = '" + RTRIM(@Tipo_Operacion)  + "' AND " +
                     "Operacion =  " + LTRIM(STR(@Operacion))  + "  AND " +
                     "Correlativo =  " + LTRIM(STR(@Correlativo))+ "  AND " +
                      "Documento =  " + LTRIM(STR(@Documento))
*/

     SELECT @Cmd_Sql = 'INSERT BAC_CNT_CONTABILIZA_PASO( Valor_Campo ) ' +
                     'SELECT ' + RTRIM(@Nombre_Campo) + ' FROM BAC_CNT_CONTABILIZA WHERE ' +
                     'ID_Sistema=''' + RTRIM(@ID_Sistema) + ''' AND ' +
                     'Tipo_Movimiento=''' + RTRIM(@Tipo_Movimiento)	 + ''' AND ' +
                     'Tipo_Operacion=''' + RTRIM(@Tipo_Operacion)	 + ''' AND ' +
                     'Operacion=' + LTRIM(STR(@Operacion))	 + ' AND ' +
                     'Correlativo=' + LTRIM(STR(@Correlativo))	 + ' AND ' +
                     'Documento=' + LTRIM(STR(@Documento))


   EXECUTE (@Cmd_Sql)

--PRINT @Cmd_Sql

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

/*-->REQ.7619 CASS 05-01-2011
   SELECT @Cmd_Sql = "INSERT BAC_CNT_CONTABILIZA_PASO( Codigo_Cuenta ) " +
                     "SELECT Codigo_Cuenta FROM VIEW_PERFIL_VARIABLE_CNT WHERE " +
                     "Folio_Perfil     =  " + RTRIM(STR(@Folio_Perfil)) + " AND " +
                     "correlativo_perfil =  " + RTRIM(STR(@Correlativo_Perfil)) + " AND " +
                     "Valor_Dato_Campo = '" + RTRIM(@Valor_Campo)       + "'"

*/

SELECT @Cmd_Sql =    'INSERT BAC_CNT_CONTABILIZA_PASO( Codigo_Cuenta ) ' +
                     'SELECT Codigo_Cuenta FROM VIEW_PERFIL_VARIABLE_CNT WHERE ' +
                     'Folio_Perfil     =  '  + RTRIM(STR(@Folio_Perfil))	   + ' AND ' +
                     'correlativo_perfil =  ' + RTRIM(STR(@Correlativo_Perfil)) + ' AND ' +
                     'Valor_Dato_Campo = ''' + RTRIM(@Valor_Campo)			   + ''''



   EXECUTE (@Cmd_Sql)
--print @Cmd_Sql
   IF @@ERROR <> 0 BEGIN
      PRINT 'ERROR_PROC FALLA ACTUALIZANDO ARCHIVO PASO CON MONTO.'
      RETURN 1
   END



	SELECT @Codigo_Cuenta = ''
	SELECT @Codigo_Cuenta = ISNULL(Codigo_Cuenta, '') FROM BAC_CNT_CONTABILIZA_PASO

	IF LTRIM(RTRIM(@Codigo_Cuenta)) = '' BEGIN 
		IF NOT EXISTS(SELECT 1 FROM BAC_CNT_ERRORES WHERE MENSAJE = 'CONDICION DE PERFIL VARIABLE NO ENCONTRADA' 
									+ '		PERFIL NÂº: ' + LTRIM(RTRIM(CONVERT(CHAR,@Folio_Perfil)))
									+ '		LINEA. PERFIL: ' + LTRIM(RTRIM(CONVERT(CHAR,@Correlativo_Perfil)))
									+ '		CONCEPTO: ' + LTRIM(RTRIM(@Concepto))
									+ '		VALOR NO ECONTRADO: ' + LTRIM(RTRIM(@Valor_Campo)))  BEGIN


/*			DECLARE @MENSAJE2 VARCHAR(256)

			SELECT @MENSAJE2  = LTRIM(RTRIM(CONVERT(CHAR,@Folio_Perfil))) + LTRIM(RTRIM(CONVERT(CHAR,@Correlativo_Perfil)))
					+ LTRIM(RTRIM(@Concepto))
					+  + LTRIM(RTRIM(@Valor_Campo))

			PRINT @MENSAJE2
*/					

--                   PRINT @Codigo_Campo_Variable

			INSERT INTO BAC_CNT_ERRORES 
			VALUES
			(	@Fecha_Hoy
			,	2
			,	'CONDICION DE PERFIL VARIABLE NO ENCONTRADA' 
				+ '		PERFIL NÂº: ' + ISNULL(LTRIM(RTRIM(CONVERT(CHAR,@Folio_Perfil))),'')
				+ '		LINEA. PERFIL: ' + ISNULL(LTRIM(RTRIM(CONVERT(CHAR,@Correlativo_Perfil))),'')
				+ '		CONCEPTO: ' + ISNULL(LTRIM(RTRIM(@Concepto)),'')
				+ '		VALOR NO ECONTRADO: ' + ISNULL(LTRIM(RTRIM(@Valor_Campo)),'')
			)
		END
	END
	ELSE IF LEN(LTRIM(RTRIM(@Codigo_Cuenta))) < 9 BEGIN
		IF NOT EXISTS(SELECT 1 FROM BAC_CNT_ERRORES WHERE MENSAJE = 'CUENTA CONTABLE DE PERFIL NO ACTUALIZADA'	
										+ '		PERFIL NÂº: ' + LTRIM(RTRIM(CONVERT(CHAR,@Folio_Perfil)))
										+ '		LINEA. PERFIL: ' + LTRIM(RTRIM(CONVERT(CHAR,@Correlativo_Perfil)))
										+ '		CONCEPTO: ' + LTRIM(RTRIM(@Concepto)))  BEGIN

--	                PRINT @Codigo_Campo_Variable

			INSERT INTO BAC_CNT_ERRORES 
			VALUES
			(	@Fecha_Hoy
			,	2
			,	'CUENTA CONTABLE DE PERFIL NO ACTUALIZADA'	+ '		PERFIL NÂº: ' + LTRIM(RTRIM(CONVERT(CHAR,@Folio_Perfil)))
										+ '		LINEA. PERFIL: ' + LTRIM(RTRIM(CONVERT(CHAR,@Correlativo_Perfil)))
										+ '		CONCEPTO: ' + LTRIM(RTRIM(@Concepto))
			)
		END
	END


   RETURN 0
END   /* FIN PROCEDIMIENTO */



GO

USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Consulta_Tablas]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--   sp_consulta_tablas  'GEN_TABLAS1', 'PSVINGBONEM  60', '', ''


CREATE PROCEDURE [dbo].[Sp_Consulta_Tablas] 
                               ( @ARCHIVO    CHAR(25) ,
                                 @FILTRO     CHAR(20) ,
				 @TIPO_MOVT  CHAR(03) = '' ,
				 @TIPO_OPER  CHAR(05) = '' )
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	DECLARE	@FECHA_DESDE     CHAR(08)
	,	@FECHA_HASTA     CHAR(08)
	,	@TABLA           CHAR(30)
	,	@FILTROS         CHAR(30)
	,	@PROCESO         VARCHAR(250)
	,	@CAMPOS          VARCHAR(150)
	,	@ID_SISTEMA      CHAR(03)
	,	@TIPO_MOVIMIENTO CHAR(03)
	,	@TIPO_OPERACION  CHAR(05)

	IF @ARCHIVO = 'BAC_CNT_MOVIMIENTO'
	BEGIN
		SELECT	GLOSA_OPERACION
		,	TIPO_OPERACION
		FROM	MOVIMIENTO_CNT
		WHERE	ID_SISTEMA      = @FILTRO
		AND	TIPO_MOVIMIENTO = 'MOV'
	END
	IF @ARCHIVO = 'BAC_CNT_SISTEMAS'
	BEGIN
		SELECT	NOMBRE_SISTEMA
		,	ID_SISTEMA 
		FROM	SISTEMA_CNT
		WHERE	OPERATIVO = 'S'
	END
	IF @ARCHIVO = 'CON_PLAN_CUENTAS1'
		SELECT	CUENTA
		,	DESCRIPCION
		,	GLOSA
		,	TIPO_MONEDA
		,	CTA_SBIF
		,	TIPO_CUENTA
		,	CON_CENTRO_COSTO
		FROM	PLAN_DE_CUENTA
		WHERE cuenta = @filtro
		ORDER BY cuenta
	IF @archivo = 'CON_CAMPOS_PERFIL'
	BEGIN
		SELECT	CONVERT( CHAR(3), codigo_campo )
		,	descripcion_campo
		,	* 
		FROM	CAMPO_CNT
		WHERE	id_sistema			= SUBSTRING(@filtro,1,3)
		AND	tipo_movimiento			= SUBSTRING(@filtro,4,3)
		AND	tipo_administracion_campo	='F'
		AND	tipo_operacion			= RTRIM(SUBSTRING(@filtro,7,5))
	END
	IF @archivo = 'BAC_CNT_PERFIL'
	BEGIN
		SELECT	CONVERT(CHAR(10),folio_perfil)
		,	glosa_perfil
		FROM	PERFIL_CNT
		WHERE	((ID_SISTEMA = @filtro) OR (@filtro = ''))
		ORDER BY folio_perfil
	END
	IF @archivo = 'GEN_TABLAS1'
	BEGIN
		SELECT @id_sistema      = SUBSTRING(@filtro,1,3)
		SELECT @tipo_movimiento = SUBSTRING(@filtro,4,3)
		SELECT @tipo_operacion  = RTRIM(SUBSTRING(@filtro,7,5))
		SELECT @filtro          = SUBSTRING(@filtro,12,5)


		SELECT	@tabla   = tabla_campo
		,	@campos  = isnull(campos_tablas,' ')
		,	@filtros = isnull(campo_tabla  ,' ')   
		FROM	campo_cnt
		WHERE	codigo_campo   = CONVERT(NUMERIC(05),@filtro )
		AND	id_sistema      = @id_sistema  
		AND	tipo_movimiento = @tipo_movimiento
		AND	tipo_operacion  = @tipo_operacion

		SELECT @proceso = 'SELECT '+ LTRIM(RTRIM(@campos)) + ' FROM ' + LTRIM(RTRIM(@tabla)) + ' ' + RTRIM(@filtros)
		EXECUTE (@proceso)
	END

	IF @archivo = 'MDCL_BANCOS'
	BEGIN
		SELECT	STR(cod_inst,4)
		,	clnombre 
		FROM	CLIENTE 
		WHERE	cltipcli  = 1
		AND	cod_inst <> 0
	END
	IF @archivo = 'LIQMX'
	BEGIN
		SELECT	mnnemo
		,	mnglosa
		FROM	MONEDA
		WHERE	(mnmx = 'C' OR mncodmon = 999)
	END
	IF @archivo = 'MDFP_TESOR'
	BEGIN
		SELECT	CONVERT(CHAR(5),codigo)
		,	glosa
		FROM FORMA_DE_PAGO
		WHERE cc2756 = (CASE WHEN RTRIM(@filtro) = '$$' THEN 'N' ELSE 'S' END)
	END
	IF @archivo = 'BAC_CNT_CAMPOS'
	BEGIN
		SELECT	codigo_campo
		,	descripcion_campo
		,	id_sistema  
		,	nombre_campo_tabla
		,	tipo_administracion_campo
		FROM	CAMPO_CNT 
		WHERE	(@filtro = '' OR id_sistema = @filtro) 
		AND	(@tipo_movt = '' OR tipo_movimiento  = @tipo_movt)
		AND	(@tipo_oper = '' OR tipo_operacion   = @tipo_oper)
	END
	IF @archivo = 'CON_PLAN_CUENTAS'
		SELECT	cuenta
		,	descripcion
		,	glosa
		,	tipo_moneda
		,	tipo_cuenta
		FROM PLAN_DE_CUENTA
		ORDER BY cuenta

	SET NOCOUNT OFF
END



GO

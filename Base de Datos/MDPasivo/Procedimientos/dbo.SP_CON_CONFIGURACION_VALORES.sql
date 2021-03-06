USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONFIGURACION_VALORES]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_CONFIGURACION_VALORES]
			(
			@iProducto		CHAR(05)	,
			@iTipo_Operacion	CHAR(05) = ' '
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE	@ctipo_operacion                Char            (1)		,
		@ccodigo_moneda                 Char            (3)		,
		@nmonto_operacion               Numeric         (19,4)		,
		@nforma_pago_entre              Numeric         (19,0)		,
		@nforma_pago_recib              Numeric         (19,0)		,
		@ncodigo_oma		        Numeric         (19,0)		,
		@ctipo_pago                     Char            (1)		,
		@ccontabiliza                   Char            (1)		,
		@ccodigo_comercio               Char            (5)		,
		@ccodigo_area                   Char            (5)		,
		@nparidad                       Numeric         (19,4)		,
		@nForma_Pago_Cli_Nac            Numeric         (19,0)		,
		@nForma_Pago_Cli_Ext            Numeric         (19,0)		,
		@ctipo_retiro                   Char            (1)		,
		@ntipo_cambio                   Numeric         (19,4)		,
		@ccontramoneda                  Char            (3)		,
		@nnumero_dias                   Numeric         (19,0)		,
		@ncodigo_pais                   Numeric         (19,0)		,
		@ctipo_modalidad                Char            (1)		,
		@ctipo_compensacion             Char            (3)		,
		@ccolocacion_capt               Char            (1)		,
		@cfunding                       Char            (5)		,
		@ncapital                    	Numeric         (19,0)		,
		@ninteres                     	Numeric         (19,0)		,
		@ntipo_caretra                  Numeric         (19,0)		,
		@ntipo_tasa                     Numeric         (19,0)		,
		@ntipo_periodo                  Numeric         (19,0)		,
		@nPais				NUMERIC		(05,0)		,
		@nPlaza				NUMERIC		(05,0)	


	SELECT	@ctipo_operacion	= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 1 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))	AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccodigo_moneda		= ISNULL(CONVERT(CHAR(3),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 2 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))	AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nmonto_operacion	= ISNULL(CONVERT(NUMERIC(19,4),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 3 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nforma_pago_entre	= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 4 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nforma_pago_recib	= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 5 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ncodigo_oma		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 6 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ctipo_pago		= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 7 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccontabiliza		= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 8 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccodigo_comercio	= ISNULL(CONVERT(CHAR(5),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 9 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccodigo_area		= ISNULL(CONVERT(CHAR(5),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 10 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nparidad		= ISNULL(CONVERT(NUMERIC(19,4),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 11 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nForma_Pago_Cli_Nac	= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 12 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nForma_Pago_Cli_Ext	= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 13 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ctipo_retiro		= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 14 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ntipo_cambio		= ISNULL(CONVERT(NUMERIC(19,4),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 15 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccontramoneda		= ISNULL(CONVERT(CHAR(3),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 16 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nnumero_dias		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 17 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ncodigo_pais		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 18 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ctipo_modalidad	= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 19 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ctipo_compensacion	= ISNULL(CONVERT(CHAR(3),valor_caracter), ' ')FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 20 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ccolocacion_capt	= ISNULL(CONVERT(CHAR(1),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 21 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@cfunding		= ISNULL(CONVERT(CHAR(5),valor_caracter), ' ') FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 22 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ncapital		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 23 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ninteres		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 24 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ntipo_caretra		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 25 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ntipo_tasa		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 26 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@ntipo_periodo		= ISNULL(CONVERT(NUMERIC(19,0),valor_numerico), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 27 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nPais			= ISNULL(CONVERT(NUMERIC(05,0),valor_NUMERICo), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 28 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion
	SELECT	@nPlaza			= ISNULL(CONVERT(NUMERIC(05,0),valor_NUMERICo), 0) FROM CONFIGURACION_DE_VALORES  WITH (NOLOCK) WHERE correlativo = 29 AND LTRIM(RTRIM(codigo_producto)) = LTRIM(RTRIM(@iProducto))AND Tipo_Operacion = @iTipo_Operacion

        IF @ccodigo_moneda = ' ' BEGIN
           SELECT @ccodigo_moneda = '0'
        END

	IF (@ctipo_operacion) IS NULL BEGIN
		SELECT	@ctipo_operacion	= ' '
	END
	IF (@ccodigo_moneda) IS NULL BEGIN
		SELECT	@ccodigo_moneda		= 0
	END
	IF (@nmonto_operacion) IS NULL BEGIN
		SELECT	@nmonto_operacion	= 0
	END
	IF (@nforma_pago_entre) IS NULL BEGIN
		SELECT	@nforma_pago_entre	= 0
	END
	IF (@nforma_pago_recib) IS NULL BEGIN
		SELECT	@nforma_pago_recib	= 0
	END
	IF (@ncodigo_oma) IS NULL BEGIN
		SELECT	@ncodigo_oma		= 0
	END
	IF (@ctipo_pago) IS NULL BEGIN
		SELECT	@ctipo_pago		= ' '
	END
	IF (@ccontabiliza) IS NULL BEGIN
		SELECT	@ccontabiliza		= ' '
	END
	IF (@ccodigo_comercio) IS NULL BEGIN
		SELECT	@ccodigo_comercio	= ' '
	END
	IF (@ccodigo_area) IS NULL BEGIN
		SELECT	@ccodigo_area		= ' '
	END
	IF (@nparidad) IS NULL BEGIN
		SELECT	@nparidad		= 0
	END
	IF (@nForma_Pago_Cli_Nac) IS NULL BEGIN
		SELECT	@nForma_Pago_Cli_Nac	= 0
	END
	IF (@nForma_Pago_Cli_Ext) IS NULL BEGIN
		SELECT	@nForma_Pago_Cli_Ext	= 0
	END
	IF (@ctipo_retiro) IS NULL BEGIN
		SELECT	@ctipo_retiro		= ' '
	END
	IF (@ntipo_cambio) IS NULL BEGIN
		SELECT	@ntipo_cambio		= 0
	END
	IF (@ccontramoneda) IS NULL BEGIN
		SELECT	@ccontramoneda		= ' '
	END
	IF (@nnumero_dias) IS NULL BEGIN
		SELECT	@nnumero_dias		= 0
	END
	IF (@ncodigo_pais) IS NULL BEGIN
		SELECT	@ncodigo_pais		= 0
	END
	IF (@ctipo_modalidad) IS NULL BEGIN
		SELECT	@ctipo_modalidad	= ' '
	END
	IF (@ctipo_compensacion) IS NULL BEGIN
		SELECT	@ctipo_compensacion	= ' '
	END
	IF (@ccolocacion_capt) IS NULL BEGIN
		SELECT	@ccolocacion_capt	= ' '
	END
	IF (@cfunding) IS NULL BEGIN
		SELECT	@cfunding		= ' '
	END
	IF (@ncapital) IS NULL BEGIN
		SELECT	@ncapital		= 0
	END
	IF (@ninteres) IS NULL BEGIN
		SELECT	@ninteres		= 0
	END
	IF (@ntipo_caretra) IS NULL BEGIN
		SELECT	@ntipo_caretra		= 0
	END
	IF (@ntipo_tasa) IS NULL BEGIN
		SELECT	@ntipo_tasa		= 0
	END
	IF (@ntipo_periodo) IS NULL BEGIN
		SELECT	@ntipo_periodo		= 0
	END
	IF (@nPais) IS NULL BEGIN
		SELECT @nPais = 0
	END
	IF (@nPlaza) IS NULL BEGIN 
		SELECT @nPlaza = 0
	END	

	CREATE TABLE #Temp
			(
			tipo_operacion                 	Char            (1)		,
			codigo_moneda                  	Char            (3)		,
			monto_operacion                	Numeric         (19,4)		,
			forma_pago_entre               	Numeric         (19,0)		,
			forma_pago_recib               	Numeric         (19,0)		,
			codigo_oma                     	Numeric         (19,0)		,
			tipo_pago                      	Char            (1)		,
			contabiliza                    	Char            (1)		,
			codigo_comercio                	Char            (5)		,
			codigo_area                    	Char            (5)		,
			paridad                        	Numeric         (19,4)		,
			Forma_Pago_Cli_Nac             	Numeric         (19,0)		,
			Forma_Pago_Cli_Ext             	Numeric         (19,0)		,
			tipo_retiro                    	Char            (1)		,
			moticam                        	Numeric         (19,4)		,
			contramoneda                   	Char            (3)		,
			numero_dias                    	Numeric         (19,0)		,
			codigo_pais                    	Numeric         (19,0)		,
			tipo_modalidad                 	Char            (1)		,
			compensacion                   	Char            (3)		,
			colocacion                     	Char            (1)		,
			funding                      	Char            (5)		,
			capital                    	Numeric         (19,0)		,
			interes                     	Numeric         (19,0)		,
			tipo_cartera                    Numeric         (19,0)		,
			tipo_tasa                       Numeric         (19,0)		,
			tipo_periodo                    Numeric         (19,0)		,
			Pais				NUMERIC		(05,0)		,
			Plaza				NUMERIC		(05,0)
			)

		INSERT INTO #Temp
			(
			tipo_operacion		,
			codigo_moneda		,
			monto_operacion		,
			forma_pago_entre	,
			forma_pago_recib	,
			codigo_oma		,
			tipo_pago		,
			contabiliza		,
			codigo_comercio		,
			codigo_area		,
			paridad			,
			Forma_Pago_Cli_Nac	,
			Forma_Pago_Cli_Ext	,
			tipo_retiro		,
			moticam			,
			contramoneda		,
			numero_dias		,
			codigo_pais		,
			tipo_modalidad		,
			compensacion		,
			colocacion		,
			funding			,
			capital			,
			interes			,
			tipo_cartera		,
			tipo_tasa		,
			tipo_periodo		,
			Pais			,
			Plaza
			)
		VALUES
			(
			@ctipo_operacion	,
			@ccodigo_moneda		,
			@nmonto_operacion	,
			@nforma_pago_entre	,
			@nforma_pago_recib	,
			@ncodigo_oma		,
			@ctipo_pago		,
			@ccontabiliza		,
			@ccodigo_comercio	,
			@ccodigo_area		,
			@nparidad		,
			@nForma_Pago_Cli_Nac	,
			@nForma_Pago_Cli_Ext	,
			@ctipo_retiro		,
			@ntipo_cambio		,
			@ccontramoneda		,
			@nnumero_dias		,
			@ncodigo_pais		,
			@ctipo_modalidad	,
			@ctipo_compensacion	,
			@ccolocacion_capt	,
			@cfunding		,
			@ncapital		,
			@ninteres		,
			@ntipo_caretra		,
			@ntipo_tasa		,
			@ntipo_periodo		,
			@nPais			,
			@nPlaza
			)

	SELECT * FROM #Temp
	
END




GO

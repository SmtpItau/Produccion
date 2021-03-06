USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_lineas_traspasolineas]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_lineas_traspasolineas]
			(
			@cOperador_Ap		CHAR	(15)	,
			@dFecPro		DATETIME	,
			@cCodigo_Grupo		CHAR	(10)	,
			@nRutcli		NUMERIC	(09,0)	,
			@nCodigo		NUMERIC	(09,0)	,
			@nNumoper		NUMERIC	(10,0)	,
			@nNumdocu		NUMERIC	(10,0)	,
			@nCorrela		NUMERIC	(10,0)	,
			@cCodigo_GrupoTras	CHAR	(10)	,
			@nMonto			NUMERIC	(19,4)	,
			@dFeciniop		DATETIME	,
			@dFecvctop		DATETIME	,
			@cUsuario		CHAR	(15)	,
			@cUsuAutori		CHAR	(15)	,
			@cTipo_Riesgo		CHAR	(01)
			)

AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	DECLARE @nNumTras	NUMERIC	(09,0)
	DECLARE @ccontrolaplazo	CHAR	(01)
	DECLARE @GlosaExcepcion	VARCHAR	(100)
	DECLARE @cProducto	CHAR	(05)
	DECLARE @cCompartido	CHAR	(01)


	SELECT	@cCompartido 	= Compartido
       	FROM	LINEA_SISTEMA
	WHERE	rut_cliente	= @nRutcli 
	AND	codigo_cliente	= @nCodigo
	AND	Codigo_Grupo	= @cCodigo_Grupo


	IF @cCompartido = 'N'
		SELECT @cTipo_Riesgo = 'C'

	SELECT 	@nNumTras = MAX(numerotraspaso)
	FROM	LINEA_TRASPASO

	SELECT 	@nNumTras = ISNULL(@nNumTras,0)+1

	INSERT INTO LINEA_TRASPASO
		(
		NumeroTraspaso		,
		NumeroOperacion		,
		NumeroDocumento		,
		NumeroCorrelativo	,
		Rut_Cliente		,
		Codigo_Cliente		,
		Codigo_grupo		,
		GrupoRecibio		,
		TipoOperacion		,
		FechaInicio		,
		FechaVencimiento	,
		Operador		,
		MontoTraspasado		,
		UsuarioAutorizo		,
		Activo			,
		Hora_Traspaso		,
		tipo_riesgo
		)
	VALUES
		(
		@nNumTras		,
		@nNumoper		,
		@nNumdocu		,
		@nCorrela		,
		@nRutcli		,
		@nCodigo		,
		@cCodigo_GrupoTras	,
		@cCodigo_Grupo		,
		' '			,	-- tipooperacion
		@dFeciniop		,
		@dFecvctop		,
		@cUsuario		,
		@nMonto			,
		@cUsuAutori		,
		'S'			,
		CONVERT(CHAR(10),GETDATE(),108),
		@cTipo_Riesgo
		)

	UPDATE	LINEA_SISTEMA
	SET	totaltraspaso	= totaltraspaso + @nMonto	,
		totalocupado	= totalocupado + @nMonto
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_GrupoTras


	IF @cTipo_Riesgo = 'S' --OR @cTipo_Riesgo = ' '
		UPDATE	LINEA_SISTEMA
		SET	SinRiesgoocupado= SinRiesgoocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_GrupoTras
	ELSE
		UPDATE	LINEA_SISTEMA
		SET	ConRiesgoocupado= ConRiesgoocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_GrupoTras


	SELECt @ccontrolaplazo = 'N'

	SELECT	@ccontrolaplazo	= controlaplazo
	FROM	LINEA_SISTEMA
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_GrupoTras


	IF @ccontrolaplazo = 'S'
	BEGIN


		UPDATE	LINEA_POR_PLAZO
		SET	totaltraspaso	= totaltraspaso + @nMonto	,
			totalocupado	= totalocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_GrupoTras
		AND	plazodesde 	<=DATEDIFF(day, @dFecPro, @dFecvctop)

	END


	SELECt @ccontrolaplazo = 'N'


	UPDATE	LINEA_SISTEMA
	SET	totalrecibido	= totalrecibido + @nMonto ,
         	totalocupado	= totalocupado  - @nMonto               
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_Grupo


	SELECT	@ccontrolaplazo	= controlaplazo
	FROM	LINEA_SISTEMA
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_Grupo


	IF @ccontrolaplazo = 'S' BEGIN

		UPDATE	LINEA_POR_PLAZO
		SET	totalrecibido	= totalrecibido + @nMonto ,
                  	totalocupado	= totalocupado  - @nMonto               
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_Grupo
		AND	plazodesde 	<=DATEDIFF(day, @dFecPro, @dFecvctop)

	END


	UPDATE LINEA_TRANSACCION_DETALLE
	SET	Error 			= 'N'
	WHERE	Codigo_Grupo		= @cCodigo_Grupo
	AND	NumeroOperacion 	= @nNumoper
	AND	NumeroDocumento 	= @nNumdocu
	AND	NumeroCorrelativo 	= @nCorrela
	AND	codigo_excepcion 	= 'T'

	EXECUTE SP_LINEAS_ACTUALIZA @dFecPro

SET NOCOUNT OFF
END

GO

USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_ActualizarTraspasoLineas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Lineas_ActualizarTraspasoLineas]
			(	
			@dFecPro 	DATETIME	,
			@cGrupo_Recibio	CHAR	(10)	,
			@cCodigo_grupo	CHAR	(10)	,
			@nRutcli	NUMERIC	(09,0)	,
			@nCodigo	NUMERIC	(09,0)	,
			@nNumoper	NUMERIC	(10,0)	,
			@nNumdocu	NUMERIC	(10,0)	,
			@nCorrela	NUMERIC	(10,0)	,
			@nMonto		NUMERIC	(19,4)	,
			@dFeciniop	DATETIME	,
			@dFecvctop	DATETIME	,
			@cUsuario	CHAR	(10)	,
			@cUsuAutori	CHAR	(10)    ,
			@cTipo_Riesgo	CHAR	(1)	,
			@Fecha_Proceso	DATETIME
			)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	DECLARE @nNumTras 	NUMERIC(09,0)
	DECLARE @ccontrolaplazo	CHAR(01)
     
	SELECT 	@nNumTras = MAX(numerotraspaso)
	FROM	LINEA_TRASPASO

	SELECT 	@nNumTras = ISNULL(@nNumTras,0)+1

	INSERT	INTO LINEA_TRASPASO
		(
		NumeroTraspaso,
		NumeroOperacion,
		NumeroDocumento,
		NumeroCorrelativo,
		Rut_Cliente,
		Codigo_Cliente,
		Codigo_Grupo	,
		GrupoRecibio	,
		TipoOperacion,
		FechaInicio,
		FechaVencimiento,
		Operador,
		MontoTraspasado,
		UsuarioAutorizo,
		Activo,
		Hora_Traspaso,
                tipo_riesgo)

	VALUES(	@nNumTras	,
		@nNumoper	,
		@nNumdocu	,
		@nCorrela	,
		@nRutcli	,
		@nCodigo	,
		@cGrupo_Recibio	,
		@cCodigo_grupo	,
		' '		,	-- tipooperacion
		@dFeciniop	,
		@dFecvctop	,
		@cUsuario	,
		@nMonto		,
		@cUsuAutori	,
		'S'		,
		CONVERT(CHAR(10),GETDATE(),108),
                @cTipo_Riesgo
				)


	UPDATE	LINEA_SISTEMA
	SET	totaltraspaso	= totaltraspaso + @nMonto	,
		totalocupado	= totalocupado + @nMonto
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cGrupo_Recibio


	IF @cTipo_Riesgo = 'S' --OR @cTipo_Riesgo = ' '

		UPDATE	LINEA_SISTEMA
		SET	SinRiesgoocupado= SinRiesgoocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cGrupo_Recibio

	ELSE
		UPDATE	LINEA_SISTEMA
		SET	ConRiesgoocupado= ConRiesgoocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cGrupo_Recibio

	SELECt @ccontrolaplazo = 'N'

	SELECT	@ccontrolaplazo	= controlaplazo
	FROM	LINEA_SISTEMA
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cGrupo_Recibio


	IF @ccontrolaplazo = 'S'
	BEGIN

		UPDATE	LINEA_POR_PLAZO
		SET	totaltraspaso	= totaltraspaso + @nMonto	,
			totalocupado	= totalocupado + @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cGrupo_Recibio
		AND	plazodesde 	<=DATEDIFF(day, @dFecPro, @dFecvctop)

	END


	SELECt @ccontrolaplazo = 'N'


	UPDATE	LINEA_SISTEMA
	SET	totalrecibido	= totalrecibido + @nMonto ,
         	totalocupado	= totalocupado  - @nMonto               
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_grupo

	IF @cTipo_Riesgo = 'S' --OR @cTipo_Riesgo = ' '
		UPDATE	LINEA_SISTEMA
		SET	SinRiesgoocupado= SinRiesgoocupado - @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_grupo
	ELSE
		UPDATE	LINEA_SISTEMA
		SET	ConRiesgoocupado= ConRiesgoocupado - @nMonto
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_grupo



	SELECT	@ccontrolaplazo	= controlaplazo
	FROM	LINEA_SISTEMA
	WHERE	rut_cliente	= @nRutcli
	AND 	codigo_cliente	= @nCodigo
	AND 	Codigo_Grupo	= @cCodigo_grupo


	IF @ccontrolaplazo = 'S'
	BEGIN

		UPDATE	LINEA_POR_PLAZO
		SET	totalrecibido	= totalrecibido + @nMonto ,
                  	totalocupado	= totalocupado  - @nMonto               
		WHERE	rut_cliente	= @nRutcli
		AND 	codigo_cliente	= @nCodigo
		AND 	Codigo_Grupo	= @cCodigo_grupo
		AND	plazodesde 	<=DATEDIFF(day, @dFecPro, @dFecvctop)

	END

	EXECUTE Sp_Lineas_Actualiza

	SET NOCOUNT OFF
END



GO

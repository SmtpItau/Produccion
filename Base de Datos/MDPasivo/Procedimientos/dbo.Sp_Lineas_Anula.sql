USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Anula]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Anula]
			(	@csistema	CHAR	(03)	,
				@nnumoper	NUMERIC	(10,0)	)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @Contador		INTEGER
	DECLARE @sw			CHAR	(01)
	DECLARE @ctranssaccion		CHAR	(15)
	DECLARE @ctipo_detalle		CHAR	(01)
	DECLARE @cactualizo_linea	CHAR	(01)
	DECLARE @nmontotransaccion	NUMERIC	(19,4)
	DECLARE @nmontoREBAJA		NUMERIC	(19,4)
	DECLARE @ctipo_movimiento	CHAR	(01)
	DECLARE @nrutcli		NUMERIC	(09,0)
	DECLARE @ncodigo		NUMERIC	(09,0)
	DECLARE @nplazodesde		NUMERIC	(09,0)
	DECLARE @nplazohasta		NUMERIC	(09,0)
	DECLARE @csistematras		CHAR	(03)
	DECLARE @nmonto			NUMERIC	(19,4)
	DECLARE @dfecvctop		DATETIME
	DECLARE @ccontrolaplazo		CHAR	(01)
	DECLARE @nRutcasamatriz		NUMERIC	(09,0)
	DECLARE @nCodigocasamatriz	NUMERIC	(09,0)
	DECLARE	@cCodigo_Grupo		CHAR	(10)
	DECLARE	@cTipo_Riesgo		CHAR	(1)
	DECLARE	@dFecIni		DATETIME
	DECLARE	@dFecVen		DATETIME
	DECLARE @nRutcli_Aux		NUMERIC(09,0)


	SELECT	@nmontoREBAJA = 0

	SELECT 	TOP 1 @cCodigo_Grupo = Codigo_Grupo
	FROM	LINEA_TRANSACCION WITH (NOLOCK)
	WHERE	NumeroOperacion 	= @nNumoper
-- select * from LINEA_TRANSACCION_DETALLE

	DECLARE cursor_Rev CURSOR 
	LOCAL
	FORWARD_ONLY STATIC
	FOR
	SELECT 	A.Linea_Transsaccion	,
		A.NumeroCorre_Detalle	,
		A.Tipo_Detalle		,
		A.Actualizo_Linea	,
		A.MontoTransaccion	,
		A.Tipo_Movimiento	,
		B.Rut_Cliente		,
		B.Codigo_Cliente	,
		A.PlazoDesde		,
		A.PlazoHasta		,
		B.Tipo_Riesgo		,
		B.FechaInicio		,
		B.FechaVencimiento	,
		A.Codigo_Grupo
	FROM	LINEA_TRANSACCION_DETALLE	AS A  WITH (NOLOCK)
	INNER JOIN LINEA_TRANSACCION		AS B  WITH (NOLOCK) ON
		A.Id_Sistema		= @cSistema	 AND
		A.NumeroOperacion 	= @nNumoper	 AND
--		A.Codigo_Grupo		= @cCodigo_Grupo AND
		A.Codigo_Grupo		= B.Codigo_Grupo AND
		A.Id_Sistema		= B.Id_Sistema	 AND
		A.NumeroOperacion 	= B.NumeroOperacion      AND
		A.NumeroDocumento 	= B.NumeroDocumento      AND
		A.NumeroCorrelativo 	= B.NumeroCorrelativo

	OPEN cursor_Rev 

	WHILE (1=1) BEGIN

		FETCH NEXT FROM cursor_Rev 
		INTO	@cTranssaccion		,
			@Contador		,
			@cTipo_Detalle		,
			@cActualizo_Linea	,
			@nMontoTransaccion	,
			@cTipo_Movimiento	,
			@nRutcli		,
			@nCodigo		,
			@nPlazoDesde		,
			@nPlazoHasta		,
			@cTipo_Riesgo		,
			@dFecIni		,
			@dFecVen		,
			@cCodigo_Grupo



		IF (@@fetch_status <> 0) BEGIN
			BREAK
		END


		SELECT	@nRutcasamatriz		= rutcasamatriz		,
			@nCodigocasamatriz	= codigocasamatriz
	       	FROM	LINEA_GENERAL  WITH (NOLOCK)
		WHERE	rut_cliente		= @nRutcli 
		AND 	codigo_cliente		= @nCodigo

		SET @nRutcli_AUX = @nRutcli

		IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S' BEGIN


			IF @cTranssaccion = 'MATRIZ' BEGIN
				UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
				SET	totalocupado		= totalocupado - @nMontoTransaccion,
					Sinriesgoocupado	= Sinriesgoocupado - @nMontoTransaccion
				WHERE	rutcasamatriz 		= @nRutcasamatriz
				AND 	codigocasamatriz	= @nCodigocasamatriz
			END

			IF @cTranssaccion = 'MAT_SR' BEGIN
				UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
				SET	Sinriesgoocupado	= Sinriesgoocupado    - @nMontoTransaccion
				WHERE	rutcasamatriz 		= @nRutcasamatriz
				AND 	codigocasamatriz	= @nCodigocasamatriz
			END

			IF @cTranssaccion = 'MAT_CR' BEGIN
				UPDATE	LINEA_AFILIADO WITH (ROWLOCK)
				SET	Conriesgoocupado	= Conriesgoocupado    - @nMontoTransaccion
				WHERE	rutcasamatriz 		= @nRutcasamatriz
				AND 	codigocasamatriz	= @nCodigocasamatriz
			END

		
			IF @cTranssaccion = 'LINGEN' BEGIN
				UPDATE	LINEA_GENERAL WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
			END



			IF @cTranssaccion = 'LINSIS' BEGIN
				UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINSSR' BEGIN
				UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINSCR' BEGIN
				UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					ConRiesgoOcupado= ConRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINPZO' BEGIN
				UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	>= plazodesde
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	<= plazohasta
			END


			IF @cTranssaccion = 'LINPSR' BEGIN
				UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	>= plazodesde
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	<= plazohasta
			END



			IF @cTranssaccion = 'LINPCR' BEGIN
				UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
				SET	totalocupado	= totalocupado  - @nMontoTransaccion,
					ConRiesgoOcupado= ConRiesgoOcupado - @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	>= plazodesde
				AND	DATEDIFF(DAY,@dFecIni,@dFecVen)	<= plazohasta
			END



		END
	END

	CLOSE cursor_rev
	DEALLOCATE cursor_rev

	UPDATE	LINEA_TRANSACCION WITH (ROWLOCK)
	SET	activo = 'N'
	WHERE 	Id_Sistema		= @cSistema
--	AND	Codigo_Grupo		= @CCodigo_Grupo
	AND	NumeroOperacion 	= @nNumoper

	EXECUTE SP_LINEAS_ACTUALIZA @nRutcli_AUX

END

GO

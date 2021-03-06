USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_lineas_rebaja]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_lineas_rebaja]
			(
			@dFecPro	DATETIME	,
			@cSistema	CHAR	(03)	,
			@nNumoper	NUMERIC	(10,0)	,
			@nNumdocu	NUMERIC	(10,0)	,
			@nCorrela	NUMERIC	(03,0)	,
			@nFactor	FLOAT		,
			@cCodigo_Grupo	CHAR	(10)	,
			@nNumoper_venta	NUMERIC	(10,0)	,
			@cProducto	CHAR	(05)
			)
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
	DECLARE @cTipo_Riesgo		CHAR(1)

	DECLARE @nCorrelaDetalle	NUMERIC	(09,0)


	SET	@nmontoREBAJA = 0
	SET	@nCorrelaDetalle = 0

	SELECT 	@cCodigo_Grupo = Codigo_Grupo
	FROM	LINEA_TRANSACCION WITH(NOLOCK)
	WHERE	NumeroOperacion 	= @nNumoper	 AND
		NumeroDocumento 	= @nNumdocu	 AND
		NumeroCorrelativo 	= @nCorrela	 AND
		Id_Sistema		= @cSistemA


	DECLARE cursor_Rev SCROLL CURSOR FOR
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
		B.Tipo_Riesgo
	FROM	LINEA_TRANSACCION_DETALLE	AS A  WITH(NOLOCK)
	INNER JOIN LINEA_TRANSACCION		AS B  WITH(NOLOCK) ON
		A.Id_Sistema		= @cSistema	 AND
		A.NumeroOperacion 	= @nNumoper	 AND
		A.NumeroDocumento 	= @nNumdocu	 AND
		A.NumeroCorrelativo 	= @nCorrela	 AND
		A.Codigo_Grupo		= @cCodigo_Grupo AND
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
			@cTipo_Riesgo


		IF (@@fetch_status <> 0) BEGIN
			BREAK
		END



		SELECT	@nRutcasamatriz		= rutcasamatriz		,
			@nCodigocasamatriz	= codigocasamatriz
	       	FROM	LINEA_GENERAL  WITH(NOLOCK)
		WHERE	rut_cliente		= @nRutcli 
		AND 	codigo_cliente		= @nCodigo





		IF @cTipo_Movimiento = 'S'
			SET @nMontoTransaccion = @nMontoTransaccion * (-1)


		SET @nMontoTransaccion = ROUND(@nMontoTransaccion * @nFactor,0)

		IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S' BEGIN


			IF @cTranssaccion = 'LINGEN' BEGIN

				UPDATE	LINEA_GENERAL
				SET	totalocupado	= totalocupado  + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo

			END


			IF @cTranssaccion = 'LINSIS' BEGIN
				UPDATE	LINEA_SISTEMA
				SET	totalocupado	= totalocupado  + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINSSR' BEGIN
				UPDATE	LINEA_SISTEMA
				SET	totalocupado	= totalocupado  + @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINSCR' BEGIN
				UPDATE	LINEA_SISTEMA
				SET	totalocupado	= totalocupado  + @nMontoTransaccion,
					ConRiesgoOcupado= ConRiesgoOcupado + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
			END



			IF @cTranssaccion = 'LINPZO' BEGIN
				UPDATE	LINEA_POR_PLAZO
				SET	totalocupado	= totalocupado  + @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	@nPlazoDesde	= plazodesde
				AND	@nplazohasta	= plazohasta
			END


			IF @cTranssaccion = 'LINPSR' BEGIN
				UPDATE	LINEA_POR_PLAZO
				SET	totalocupado	= totalocupado  + @nMontoTransaccion,
					SinRiesgoOcupado= SinRiesgoOcupado + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	@nPlazoDesde	= plazodesde
				AND	@nplazohasta	= plazohasta

			END



			IF @cTranssaccion = 'LINPCR' BEGIN
				UPDATE	LINEA_POR_PLAZO
				SET	totalocupado	= totalocupado  + @nMontoTransaccion,
					ConRiesgoOcupado= ConRiesgoOcupado + @nMontoTransaccion
				WHERE	rut_cliente	= @nRutcli
				AND	codigo_cliente	= @nCodigo
				AND	codigo_grupo	= @ccodigo_grupo
				AND	@nPlazoDesde	= plazodesde
				AND	@nplazohasta	= plazohasta

			END


			SET	@nmontoREBAJA = @nMontoTransaccion


			IF ( @cSistema = 'BTR' AND @cProducto IN ('VP','RFM') ) OR ( @cSistema = 'INV' AND @cProducto = 'VPI' )
			BEGIN

				SELECT	@nCorrelaDetalle = ISNULL(MAX(NumeroCorre_Detalle),0)+1
				FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
				WHERE 	Id_Sistema		= @cSistema
				AND	NumeroOperacion 	= @nNumoper_venta
				AND	NumeroDocumento 	= @nNumdocu
				AND	NumeroCorrelativo 	= @nCorrela


				IF @nCorrelaDetalle=1
				BEGIN

					INSERT	INTO	LINEA_TRANSACCION
					SELECT	@nNumoper_venta,
						NumeroDocumento,
						NumeroCorrelativo,
						Rut_Cliente,
						Codigo_Cliente,
						Id_Sistema,
						Codigo_Grupo,
						Tipo_Operacion,
						Tipo_Riesgo,
						FechaInicio,
						FechaVencimiento,
						@nmontoREBAJA,  --MontoOriginal
						TipoCambio,
						MatrizRiesgo,
						@nmontoREBAJA,  --MontoTransaccion,
						Operador,
						'N',				--Activo
						codigo_moneda 
					FROM	LINEA_TRANSACCION  WITH(NOLOCK)
					WHERE 	Id_Sistema		= @cSistema
					AND	NumeroOperacion 	= @nNumoper
					AND	NumeroDocumento 	= @nNumdocu
					AND	NumeroCorrelativo 	= @nCorrela


				END



				INSERT	INTO LINEA_TRANSACCION_DETALLE
				SELECT	@nNumoper_venta,
					NumeroDocumento,
					NumeroCorrelativo,
					@nCorrelaDetalle,
					Id_Sistema,
					Codigo_Producto,
					Codigo_Grupo,
					'L',
					'R',
					Linea_Transsaccion,
					@nmontoREBAJA, --MontoTransaccion
					0,
					PlazoDesde,
					PlazoHasta,
					Actualizo_Linea,
					'', 			--Error,
					'', 			--codigo_excepcion,
					'', 			--Mensaje_Error,
					codigo_moneda
				FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
				WHERE 	Id_Sistema		= @cSistema
				AND	NumeroOperacion 	= @nNumoper
				AND	NumeroDocumento 	= @nNumdocu
				AND	NumeroCorrelativo 	= @nCorrela
				AND	NumeroCorre_Detalle	= @Contador


			END
			ELSE
			BEGIN


				SELECT	@nCorrelaDetalle = ISNULL(MAX(NumeroCorre_Detalle),0)+1
				FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
				WHERE 	Id_Sistema		= @cSistema
				AND	NumeroOperacion 	= @nNumoper
				AND	NumeroDocumento 	= @nNumdocu
				AND	NumeroCorrelativo 	= @nCorrela

				INSERT	INTO LINEA_TRANSACCION_DETALLE
				SELECT	@nNumoper,
					NumeroDocumento,
					NumeroCorrelativo,
					@nCorrelaDetalle,
					Id_Sistema,
					Codigo_Producto,
					Codigo_Grupo,
					'L',
					'R',
					Linea_Transsaccion,
					@nmontoREBAJA, 		--MontoTransaccion
					0,
					PlazoDesde,
					PlazoHasta,
					Actualizo_Linea,
					'', 			--Error,
					'', 			--codigo_excepcion,
					'', 			--Mensaje_Error,
					codigo_moneda
				FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
				WHERE 	Id_Sistema		= @cSistema
				AND	NumeroOperacion 	= @nNumoper
				AND	NumeroDocumento 	= @nNumdocu
				AND	NumeroCorrelativo 	= @nCorrela
				AND	NumeroCorre_Detalle	= @Contador

			END





		END
	END

	CLOSE cursor_rev
	DEALLOCATE cursor_rev

	UPDATE	LINEA_TRANSACCION
	SET	MontoTransaccion = MontoTransaccion - (MontoTransaccion * @nFactor),
		MontoOriginal    = MontoOriginal    - (MontoTransaccion * @nFactor)
	WHERE 	Id_Sistema		= @cSistema
	AND	Codigo_Grupo		= @CCodigo_Grupo
	AND	NumeroOperacion 	= @nNumoper
	AND	NumeroDocumento 	= @nNumdocu
	AND	NumeroCorrelativo 	= @nCorrela



	UPDATE	LINEA_TRANSACCION_DETALLE
	SET	MontoTransaccion = MontoTransaccion - (MontoTransaccion * @nFactor)
	WHERE 	Id_Sistema		= @cSistema
	AND	NumeroOperacion 	= @nNumoper
	AND	NumeroDocumento 	= @nNumdocu
	AND	NumeroCorrelativo 	= @nCorrela
	AND	Codigo_Grupo		= @CCodigo_Grupo
	AND	Tipo_Detalle 		= 'L'
	AND	Tipo_Movimiento 	= 'S'


-- SELECT * FROM LINEA_TRANSACCION_DETALLE WHERE ID_SISTEMA='btr'
-- SELECT * FROM LINEA_TRANSACCION WHERE ID_SISTEMA='btr'

/*

	IF ( @cSistema = 'BTR' AND @cProducto = 'VP' ) OR ( @cSistema = 'INV' AND @cProducto = 'VPI' )
	BEGIN

		INSERT	INTO	LINEA_TRANSACCION
		SELECT	@nNumoper_venta,
			NumeroDocumento,
			NumeroCorrelativo,
			Rut_Cliente,
			Codigo_Cliente,
			Id_Sistema,
			Codigo_Grupo,
			Tipo_Operacion,
			Tipo_Riesgo,
			FechaInicio,
			FechaVencimiento,
			@nmontoREBAJA,  --MontoOriginal
			TipoCambio,
			MatrizRiesgo,
			@nmontoREBAJA,  --MontoTransaccion,
			Operador,
			'N',				--Activo
			codigo_moneda 
		FROM	LINEA_TRANSACCION  WITH(NOLOCK)
		WHERE 	Id_Sistema		= @cSistema
		AND	NumeroOperacion 	= @nNumoper
		AND	NumeroDocumento 	= @nNumdocu
		AND	NumeroCorrelativo 	= @nCorrela
		AND	Codigo_Grupo		= @CCodigo_Grupo



		INSERT	INTO LINEA_TRANSACCION_DETALLE
		SELECT	@nNumoper_venta,
			NumeroDocumento,
			NumeroCorrelativo,
			1,
			Id_Sistema,
			Codigo_Producto,
			Codigo_Grupo,
			Tipo_Detalle,
			'R',
			'VENTA',	--Linea_Transsaccion
			@nmontoREBAJA, --MontoTransaccion
			0,
			PlazoDesde,
			PlazoHasta,
			Actualizo_Linea,
			'', 			--Error,
			'', 			--codigo_excepcion,
			'', 			--Mensaje_Error,
			codigo_moneda
		FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
		WHERE 	Id_Sistema		= @cSistema
		AND	NumeroOperacion 	= @nNumoper
		AND	NumeroDocumento 	= @nNumdocu
		AND	NumeroCorrelativo 	= @nCorrela
		AND	Codigo_Grupo		= @CCodigo_Grupo
		AND	Tipo_Detalle = 'L'
		AND	Tipo_Movimiento = 'S'
		AND	Linea_Transsaccion='LINGEN'

	END
	ELSE
	BEGIN



		SELECT	@nCorrelaDetalle = MAX(NumeroCorre_Detalle)+1
		FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
		WHERE 	Id_Sistema		= @cSistema
		AND	NumeroOperacion 	= @nNumoper
		AND	NumeroDocumento 	= @nNumdocu
		AND	NumeroCorrelativo 	= @nCorrela


		INSERT	INTO LINEA_TRANSACCION_DETALLE
		SELECT	@nNumoper,
			NumeroDocumento,
			NumeroCorrelativo,
			@nCorrelaDetalle,
			Id_Sistema,
			Codigo_Producto,
			Codigo_Grupo,
			Tipo_Detalle,
			'R',
			'ANTCI',		--Linea_Transsaccion
			@nmontoREBAJA, 		--MontoTransaccion
			0,
			PlazoDesde,
			PlazoHasta,
			Actualizo_Linea,
			'', 			--Error,
			'', 			--codigo_excepcion,
			'', 			--Mensaje_Error,
			codigo_moneda
		FROM	LINEA_TRANSACCION_DETALLE  WITH(NOLOCK)
		WHERE 	Id_Sistema		= @cSistema
		AND	NumeroOperacion 	= @nNumoper
		AND	NumeroDocumento 	= @nNumdocu
		AND	NumeroCorrelativo 	= @nCorrela
		AND	Codigo_Grupo		= @CCodigo_Grupo
		AND	Tipo_Detalle 		= 'L'
		AND	Tipo_Movimiento 	= 'S'
		AND	Linea_Transsaccion	= 'LINGEN'


	END
*/

	EXECUTE SP_LINEAS_ACTUALIZA  --@dFecPro


END

GO

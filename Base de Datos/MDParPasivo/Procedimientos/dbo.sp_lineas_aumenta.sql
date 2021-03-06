USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_lineas_aumenta]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_lineas_aumenta]
			(
			@cSistema		CHAR	(03)	,
			@nNumoper		NUMERIC	(10,0)	,
			@nNumdocu		NUMERIC	(10,0)	,
			@nCorrela		NUMERIC	(03,0)	,
			@ccodigo_grupo		CHAR	(10)	,
			@cTranssaccion		CHAR	(15)	,
			@nRutcli		NUMERIC	(09,0)	,
			@nCodigo		NUMERIC	(09,0)	,
			@nmontotransaccion	NUMERIC	(19,4)	,
			@nPlazoDesde		NUMERIC	(09,0)	,
			@nPlazoHasta		NUMERIC	(09,0)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

/*
	DECLARE @Contador		INTEGER
	DECLARE @sw			CHAR	(01)
	DECLARE @ctranssaccion		CHAR	(15)
	DECLARE @ctipo_detalle		CHAR	(01)
	DECLARE @cactualizo_linea	CHAR	(01)
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
	DECLARE	@cCodigo_Grupo		CHAR	(10)


	SELECT	@nmontoREBAJA = 0

	SELECT 	@cCodigo_Grupo = Codigo_Grupo
	FROM	LINEA_TRANSACCION
	WHERE	NumeroOperacion 	= @nNumoper	 AND
		NumeroDocumento 	= @nNumdocu	 AND
		NumeroCorrelativo 	= @nCorrela	 AND
		Id_Sistema		= @cSistemA


	DECLARE cursor_Rev SCROLL CURSOR FOR
	SELECT 	A.Linea_Transsaccion	,
		A.NumeroCorre_Detalle	,
		A.Tipo_Detalle		,
		A.Actualizo_Linea	,
		A.Tipo_Movimiento	,
		B.Rut_Cliente		,
		B.Codigo_Cliente	,
		A.PlazoDesde		,
		A.PlazoHasta		,
		B.Tipo_Riesgo
	FROM	LINEA_TRANSACCION_DETALLE	AS A
	INNER JOIN LINEA_TRANSACCION		AS B ON
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


-- select * from LINEA_TRANSACCION_DETALLE
-- select * from LINEA_TRANSACCION

	OPEN cursor_Rev 

	WHILE (1=1) BEGIN

		FETCH NEXT FROM cursor_Rev 
		INTO	@cTranssaccion		,
			@Contador		,
			@cTipo_Detalle		,
			@cActualizo_Linea	,
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
	       	FROM	LINEA_GENERAL
		WHERE	rut_cliente		= @nRutcli 
		AND 	codigo_cliente		= @nCodigo



		IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S' BEGIN

*/


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

/*

		END

	END


	CLOSE cursor_rev
	DEALLOCATE cursor_rev

*/

	IF @cTranssaccion = 'LINGEN' BEGIN
		UPDATE	LINEA_TRANSACCION
		SET	MontoTransaccion = MontoTransaccion + @nmontotransaccion,
			MontoOriginal    = MontoOriginal    + @nmontotransaccion
		WHERE 	Id_Sistema		= @cSistema
		AND	Codigo_Grupo		= @CCodigo_Grupo
		AND	NumeroOperacion 	= @nNumoper
		AND	NumeroDocumento 	= @nNumdocu
		AND	NumeroCorrelativo 	= @nCorrela
	END


	UPDATE	LINEA_TRANSACCION_DETALLE
	SET	MontoTransaccion = MontoTransaccion + @nmontotransaccion
	WHERE 	Id_Sistema		= @cSistema
	AND	NumeroOperacion 	= @nNumoper
	AND	NumeroDocumento 	= @nNumdocu
	AND	NumeroCorrelativo 	= @nCorrela
	AND	Tipo_Detalle 		= 'L'
	AND	Tipo_Movimiento 	= 'S'
	AND	Linea_Transsaccion	= @cTranssaccion
	AND	PlazoDesde		= @nPlazoDesde
	AND	PlazoHasta		= @nPlazoHasta

END


-- select * from linea_general
-- select * from linea_sistema






GO

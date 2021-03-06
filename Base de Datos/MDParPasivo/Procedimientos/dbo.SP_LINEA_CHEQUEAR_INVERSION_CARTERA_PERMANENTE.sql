USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_INVERSION_CARTERA_PERMANENTE]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_INVERSION_CARTERA_PERMANENTE]
				(
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nNumoper	NUMERIC	(10)	)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	SET NOCOUNT ON

   SET DATEFORMAT dmy

	DECLARE	@nTotalDisponible	NUMERIC	(19,4)	,
		@nMonto			NUMERIC	(19,4)	,
		@nRut_emisor		NUMERIC	(9)	,
		@cCarteraSuper		CHAR	(01)	,
		@nMoneda_Emision 	NUMERIC	(03)

	DECLARE Cursor_INVERSION_INSTRUMENTO SCROLL CURSOR FOR
	SELECT	Rut_emisor		,
		Moneda_Emision		,
		SUM(MontoTransaccion)	,
		codigo_carterasuper
	FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
	WHERE	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema
	AND	Codigo_Producto = @cProducto
	AND	codigo_carterasuper	= 'P'
	GROUP BY
		Rut_emisor		,
		Moneda_Emision		,
		codigo_producto		,
		codigo_carterasuper

	OPEN Cursor_INVERSION_INSTRUMENTO

	WHILE (1=1)
	BEGIN
		FETCH NEXT FROM Cursor_INVERSION_INSTRUMENTO
		INTO	@nRut_emisor	,
			@nMoneda_Emision,
			@nMonto		,
			@cCarteraSuper
		IF (@@fetch_status <> 0)
		BEGIN
			BREAK
		END

		SET	@nTotalDisponible	= 0
		SELECT	@nTotalDisponible	= (Limite_Inversion_Cartera_Asignado - Limite_Inversion_Cartera_Ocupado)
	       	FROM	DATOS_GENERALES

		IF @nTotalDisponible < @nMonto
			INSERT INTO #TEMP1 SELECT 'MONTO OPERACION SOBREPASA LIMITE INVERSION CARTERA PERMANENTE'
	END

	CLOSE Cursor_INVERSION_INSTRUMENTO
	DEALLOCATE Cursor_INVERSION_INSTRUMENTO
END








GO

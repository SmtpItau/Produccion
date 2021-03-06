USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRABARERROR]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRABARERROR]
				(
				@cSistema	CHAR	(03)	,
				@nNumoper	NUMERIC	(10,0)
				)
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE	@Error	CHAR(1)

	SELECT @Error = 'N'

/*	SELECT	@Error = 'S'
	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	Error = 'S'
	AND	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema

	IF @Error = 'S'
	BEGIN
*/
		SELECT	Mensaje_Error,
			MontoExceso
		FROM	LINEA_TRANSACCION_DETALLE WITH (NOLOCK)
		WHERE 	Error = 'S'
		AND	NumeroOperacion	= @nNumoper
		AND	Id_Sistema	= @cSistema

--	END

END



GO

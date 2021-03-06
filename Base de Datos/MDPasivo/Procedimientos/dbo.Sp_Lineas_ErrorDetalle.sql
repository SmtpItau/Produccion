USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_ErrorDetalle]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Lineas_ErrorDetalle]
				(
				@cSistema	CHAR	(03)	,
				@nNumoper	NUMERIC	(10,0)	,
				@nNumdocu	NUMERIC	(10,0)	,
				@nCorrela	NUMERIC	(10,0)
				)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	SELECT	Mensaje_Error,
		MontoExceso
	FROM	LINEA_TRANSACCION_DETALLE
	WHERE 	Error = 'S'
	AND	NumeroDocumento	  = @nNumdocu
	AND	NumeroOperacion	  = @nNumoper
	AND	NumeroCorrelativo = @nCorrela
--	AND	Id_Sistema	  = @cSistema

SET NOCOUNT OFF
END


GO

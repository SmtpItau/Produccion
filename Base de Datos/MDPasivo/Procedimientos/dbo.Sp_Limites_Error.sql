USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limites_Error]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Limites_Error] (
				@cSistema	CHAR	(03)	,
				@nNumoper	NUMERIC	(10,0)
			)
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT	Mensaje, Monto 
	FROM	LIMITE_TRANSACCION_ERROR
	WHERE 	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema

		
	SET NOCOUNT OFF

END


-- select * from VIEW_CONTROL_FINANCIERO
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_MATRIZ_ATRIBUCION
-- select * from VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO
-- select * from VIEW_LIMITE_TRANSACCION
-- select * from VIEW_LIMITE_TRANSACCION_ERROR






GO

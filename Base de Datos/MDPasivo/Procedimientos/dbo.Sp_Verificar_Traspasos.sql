USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Verificar_Traspasos]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Verificar_Traspasos]
			(
			@dFecha		DATETIME	,
			@cCodigo_Grupo	CHAR(10)	,
			@nNumoper	NUMERIC(10,0)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	SELECT	descripcion	,
		MontoTraspasado
	FROM	LINEA_TRASPASO	AS a  WITH (NOLOCK),
		GRUPO_PRODUCTO	AS b   WITH (NOLOCK)
	WHERE	FechaInicio	= @dFecha		AND
		GrupoRecibio	= @cCodigo_Grupo	AND
		NumeroOperacion = @nNumoper		AND
		a.GrupoRecibio	= b.Codigo_Grupo

END



GO

USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_OperacionesXSistema]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_OperacionesXSistema]
			(
			@rut_cliente	NUMERIC	(09)	,
			@codigo_cliente	NUMERIC	(09)	,
			@Codigo_Grupo	CHAR	(10)
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	SELECT	NumeroOperacion		,
		L.Codigo_Grupo		,
		'descripcion'	= A.descripcion,
		Tipo_Operacion		,
		'Operacion'	= (CASE WHEN tipo_operacion = 'C' THEN 'COMPRA'
					WHEN tipo_operacion = 'V' THEN 'VENTA'
					ELSE ' '
				   END)	,
		FechaInicio		,
		FechaVencimiento	,
		MontoOriginal		,
		MontoTransaccion	,
		Operador		,
		Activo
	FROM LINEA_TRANSACCION	AS L WITH (NOLOCK)
	INNER JOIN GRUPO_PRODUCTO AS A WITH (NOLOCK) ON
		activo		 = 'S'			AND
		L.rut_cliente	 = @rut_cliente		AND
		L.codigo_cliente = @codigo_cliente	AND
		L.Codigo_Grupo	 = @Codigo_Grupo	AND
		L.Codigo_Grupo	 = A.Codigo_Grupo
	ORDER BY NumeroOperacion

END
GO

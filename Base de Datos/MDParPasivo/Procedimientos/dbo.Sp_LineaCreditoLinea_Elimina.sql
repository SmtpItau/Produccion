USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoLinea_Elimina]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LineaCreditoLinea_Elimina]
		(
		@rutcliente	NUMERIC(9)	,
		@codcliente	NUMERIC(9)	,
		@Codigo_Grupo	CHAR(10) =' '
		)
AS BEGIN


	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	IF @Codigo_Grupo = ' ' BEGIN
		DELETE LINEA_POR_PLAZO
		WHERE	rut_cliente	= @rutcliente	AND
			codigo_cliente	= @codcliente
		RETURN
	END

	IF EXISTS(SELECT 1 FROM LINEA_TRANSACCION WITH (NOLOCK) WHERE	rut_cliente = @rutcliente	AND
									Codigo_Grupo= @Codigo_Grupo) BEGIN
		SELECT 'NO'
		RETURN
	END
		
	DELETE LINEA_POR_PLAZO	WHERE	rut_cliente	= @rutcliente	AND
					codigo_cliente	= @codcliente	AND
					Codigo_Grupo	= @Codigo_Grupo

END



GO

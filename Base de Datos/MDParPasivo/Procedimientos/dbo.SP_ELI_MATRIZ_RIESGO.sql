USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_MATRIZ_RIESGO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELI_MATRIZ_RIESGO]
					(	@id_sistema		CHAR(3)
					,	@cod_producto		CHAR(5)
					,	@cod_instrumento	NUMERIC(5) = 0
					,	@codigo_moneda		NUMERIC(5)
					,	@codigo_moneda2		NUMERIC(5)
					)
AS
BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT dmy	

	IF EXISTS(SELECT 1 FROM MATRIZ_RIESGO WHERE	id_sistema		= @id_sistema
		  			      AND	codigo_producto		= @cod_producto
		  			      AND	codigo_instrumento	= @cod_instrumento
		  			      AND	codigo_moneda 		= @codigo_moneda
		  			      AND	codigo_moneda2		= @codigo_moneda2)
	BEGIN
		DELETE MATRIZ_RIESGO WHERE id_sistema		= @id_sistema
		  		     AND   codigo_producto	= @cod_producto
		  		     AND   codigo_instrumento	= @cod_instrumento
		  		     AND   codigo_moneda 	= @codigo_moneda
		  		     AND   codigo_moneda2	= @codigo_moneda2
		SELECT 1
	END
	ELSE
	BEGIN
		SELECT 0
	END
	
	SET NOCOUNT OFF
END


GO

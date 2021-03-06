USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOAD_ERROR_LIMPERMANENCIA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOAD_ERROR_LIMPERMANENCIA]
	(	@nNumOper	NUMERIC(9)	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	DISTINCT
			Mostrar			= CASE	WHEN nIdRelacion = 0 then upper( mensaje )
									ELSE 'Instrumento Antecede Limite Permanencia : ' + ltrim(rtrim( Instrumento ))
									+ ' Plazo limite ' + ltrim(rtrim( PlazoLimite ))
									+ ' Dias ' + ltrim(rtrim( PlazoActual ))
								END
	FROM	BacLineas.dbo.MENSAJES_LIMITE_PERMANENCIA mlp with(nolock)
	WHERE	NumOperacion	= @nNumOper

END


GO

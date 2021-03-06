USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Activo_Cliente]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Graba_Activo_Cliente]
				     (
					@nRut_cliente		NUMERIC	(09,0)	,
					@nCodigo_cliente	NUMERIC	(09,0)	, 
					@nActivo_circulante	NUMERIC	(19,2)	,
					@iEstado		INTEGER		,
					@nCap_U$$			NUMERIC	(19,2)	

				     ) 
AS

BEGIN
	SET NOCOUNT ON

	UPDATE	LIMITE_TOTAL_ENDEUDAMIENTO
	SET	activo_circulante	= @nActivo_circulante	,
		Captaciones_Dolares	= @nCap_U$$,
		estado			= @iEstado
	WHERE	rut_cliente=@nRut_cliente AND codigo_cliente=@nCodigo_cliente

	SET NOCOUNT OFF
END

GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINACLIENTESENDEUDA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINACLIENTESENDEUDA]
		(	@rut    NUMERIC(9,0)	,
			@codigo NUMERIC(9,0)
		)
AS
BEGIN

	SET NOCOUNT ON

	DELETE	cliente_endeudamiento
	WHERE 	rut_cliente 	= @rut 		AND
		codigo_cliente 	= @codigo	AND
		Utilizado	= 0

	SET NOCOUNT OFF

END
GO

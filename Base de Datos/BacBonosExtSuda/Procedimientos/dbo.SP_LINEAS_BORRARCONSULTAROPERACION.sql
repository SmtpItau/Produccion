USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_BORRARCONSULTAROPERACION]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_BORRARCONSULTAROPERACION]
				(
				@cSistema	CHAR	(03)	,
				@nNumPantalla	NUMERIC(10)	
				)
AS
BEGIN

	SET NOCOUNT ON

	DELETE VIEW_LINEA_CHEQUEAR
	WHERE	NumeroOperacion		= @nNumPantalla		AND
		Id_Sistema		= @cSistema

	SET NOCOUNT OFF

END

GO

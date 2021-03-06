USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_VALOR_MONEDACONTABLE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OBTENER_VALOR_MONEDACONTABLE]
	(	@codMoneda VARCHAR(5),
		@ValorBuscado FLOAT OUTPUT
	)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @nCodMoneda VARCHAR(5)
	
	IF @codMoneda = '13'
		SELECT @nCodMoneda = '994'
	ELSE
		SELECT @nCodMoneda = @codMoneda

	DECLARE @tmenos1 DATETIME

	SELECT @tmenos1 = ACFECANT
	FROM Baccamsuda..meac
	WHERE ACRUT = 97023000

	IF @tmenos1 IS NULL
		SELECT @ValorBuscado = NULL
	ELSE
		SELECT @ValorBuscado = Tipo_Cambio
		FROM Bacparamsuda..VALOR_MONEDA_CONTABLE
		WHERE Fecha = @tmenos1
		AND Codigo_Moneda = @nCodMoneda
END
GO

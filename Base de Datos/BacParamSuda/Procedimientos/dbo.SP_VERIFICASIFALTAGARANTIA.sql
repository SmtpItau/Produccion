USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICASIFALTAGARANTIA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VERIFICASIFALTAGARANTIA]
	(	@rutCliente 	NUMERIC(9),
		@codCliente 	NUMERIC(5),
		@montoOperacion	NUMERIC(19,4)
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @falta	NUMERIC(19,4),
		@sobra		NUMERIC(19,4),
		@totGar	NUMERIC(19,4)

	SELECT 	@totGar = SUM(ValorPresente)
	FROM Bacparamsuda.dbo.tbl_cartera_garantia a,
	Bacparamsuda.dbo.tbl_mov_garantia b
	WHERE b.RutCliente = @rutCliente
	AND b.CodCliente = @codCliente
	AND a.NumeroOperacion = b.NumeroOperacion
	AND b.TipoMovimiento = 'I'
	AND b.Estado = 'V'
	AND a.NumeroOperacion NOT IN (SELECT NumeroOperacion FROM tbl_registro_garantias)

	IF @totGar = @montoOperacion
		SELECT 	@falta = 0.0,
			@sobra = 0.0
	ELSE IF @totGar > @montoOperacion
		SELECT 	@falta = 0.0,
			@sobra = @totGar - @montoOperacion
	ELSE
		SELECT 	@falta = @montoOperacion - @totGar,
			@sobra = 0.0

	IF @falta > 0.0
		SELECT 'SI' AS 'Falta',
		@falta AS 'Falta', @totGar AS 'Total Garantías'
	ELSE
		SELECT 'NO' AS 'Falta',
		@sobra AS 'Sobra', @totGar AS 'Total Garantías'
END
GO

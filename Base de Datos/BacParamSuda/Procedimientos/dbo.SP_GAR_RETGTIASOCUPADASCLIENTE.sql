USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_RETGTIASOCUPADASCLIENTE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_RETGTIASOCUPADASCLIENTE]
	(	@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT 	aso.FolioAsocia,
		car.NumeroOperacion,
		car.Instrumento,
		(SELECT mnnemo FROM BacParamsuda..MONEDA WHERE det.MonedaEmision = mncodmon) AS 'Moneda',
		car.Nominal,
		enc.FactorAditivo,
		det.FactorMultiplicativo,
		det.FechaEmision,
		det.FechaVencimiento,
		car.ValorPresente
	FROM 	tbl_Cartera_Garantia car,
		tbl_mov_garantia enc,
		tbl_mov_garantia_detalle det,
		tbl_gar_AsociacionGtia aso
	WHERE	enc.RutCliente = @rutCliente AND
		enc.CodCliente = @codCliente AND
		enc.NumeroOperacion = car.NumeroOperacion AND
		enc.NumeroOperacion = det.NumeroOperacion AND
		det.Correlativo     = car.Correlativo     AND
		aso.NumeroGarantia = car.NumeroOperacion
	ORDER BY aso.FolioAsocia, car.NumeroOperacion
	SET NOCOUNT OFF
END
GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGARANTIASCLIENTEOCUPADAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGARANTIASCLIENTEOCUPADAS]
	(	@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT 	car.NumeroOperacion,
		car.Instrumento,
		(SELECT mnnemo FROM BacParamsuda.dbo.MONEDA WHERE det.MonedaEmision = mncodmon) AS 'Moneda',
		car.Nominal,
		enc.FactorAditivo,
		det.FactorMultiplicativo,
		det.FechaEmision,
		det.FechaVencimiento,
		car.ValorPresente,
		(reg.Sistema + '-'+CONVERT(VARCHAR(9),reg.OperacionSistema))
	FROM 	tbl_Cartera_Garantia car,
		tbl_mov_garantia enc,
		tbl_mov_garantia_detalle det,
		tbl_registro_garantias reg
	WHERE	enc.RutCliente = @rutCliente AND
		enc.CodCliente = @codCliente AND
		enc.NumeroOperacion = car.NumeroOperacion AND
		enc.NumeroOperacion = det.NumeroOperacion AND
		det.Correlativo     = car.Correlativo     AND		/*agregado*/
		reg.NumeroOperacion = car.NumeroOperacion

	SET NOCOUNT OFF
END
GO

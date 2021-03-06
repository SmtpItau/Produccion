USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGTIASDISPINTERCAMBIO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGTIASDISPINTERCAMBIO]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 	b.NumeroOperacion,
		b.Instrumento,
		c.mnnemo,
		b.Nominal,
		b.FechaEmision,
		b.FechaVencimiento,
		b.ValorPresente
		, a.TipoGarantia 
	FROM 	Bacparamsuda.dbo.tbl_mov_garantia a,
		Bacparamsuda.dbo.tbl_mov_garantia_detalle b,
		Bacparamsuda.dbo.MONEDA c,
		BacParamsuda.dbo.TABLA_GENERAL_DETALLE d
	WHERE	a.RutCliente = @rutCliente AND
		a.CodCliente = @codCliente AND
		a.TipoMovimiento = 'I' AND
		a.Estado = 'V' AND
		c.mncodmon = b.MonedaEmision AND
		a.NumeroOperacion = b.NumeroOperacion AND
		d.tbcateg = 8700 AND
		d.nemo = 'C' AND
		a.TipoGarantia = d.tbcodigo1 AND
		a.NumeroOperacion NOT IN (SELECT NumeroOperacion FROM Bacparamsuda.dbo.tbl_registro_garantias
						WHERE RutCliente = @rutCliente AND CodCliente = @codCliente)
	ORDER BY a.NumeroOperacion
	SET NOCOUNT OFF
END
GO

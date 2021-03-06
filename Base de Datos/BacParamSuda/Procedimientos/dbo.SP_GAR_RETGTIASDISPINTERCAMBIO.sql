USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_RETGTIASDISPINTERCAMBIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_RETGTIASDISPINTERCAMBIO]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON

	CREATE TABLE #tmpGtiasDisp(
		NumeroGarantia	NUMERIC(9),
		Instrumento	VARCHAR(12),
		MonedaNemo	CHAR(8),
		Nominal		NUMERIC(13),
		FEmision	DATETIME,
		FVcto		DATETIME,
		ValorPresente	NUMERIC(13),
		TipoGarantia	TINYINT,
		SumaValorPte	NUMERIC(18)
		)
	INSERT INTO #tmpGtiasDisp

	SELECT 	b.NumeroOperacion,
		b.Instrumento,
		c.mnnemo,
		b.Nominal,
		b.FechaEmision,
		b.FechaVencimiento,
		b.ValorPresente,
		a.TipoGarantia,
		0
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
		a.NumeroOperacion NOT IN (SELECT NumeroGarantia FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
					  WHERE RutCliente = @rutCliente AND CodCliente = @codCliente)

	UPDATE #tmpGtiasDisp
	SET 	SumaValorPte = (SELECT SUM(ValorPresente) FROM #tmpGtiasDisp b WHERE a.NumeroGarantia = b.NumeroGarantia)
	FROM #tmpGtiasDisp a

	SELECT * FROM #tmpGtiasDisp
	ORDER BY NumeroGarantia

	SET NOCOUNT OFF
END
GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGARANTIASCLIENTE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGARANTIASCLIENTE]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)	
	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT 	b.Instrumento,
		c.mnnemo,
		b.Nominal,
		b.TIR,
		b.VPAR,
		b.FechaVencimiento,
		b.ValorPresente
	FROM	Bacparamsuda.dbo.tbl_mov_garantia a,
		Bacparamsuda.dbo.tbl_mov_garantia_detalle b,
		Bacparamsuda.dbo.MONEDA c
	WHERE	a.RutCliente = @rutCliente AND
		a.CodCliente = @codCliente AND
		a.TipoMovimiento = 'I' AND
		a.Estado = 'V' AND
		c.mncodmon = b.MonedaEmision AND
		a.NumeroOperacion = b.NumeroOperacion
END
GO

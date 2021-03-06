USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_GARANTIASPORTIPO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_GARANTIASPORTIPO]
	(	@rutCliente NUMERIC(9),
		@codCliente INTEGER,
		@fechaVcto DATETIME,
		@tipoGar CHAR(1)
	)
AS
BEGIN
	SET NOCOUNT ON
	IF @tipoGar = 'O'
	BEGIN
		SELECT 	a.Clrut, 
			a.Cldv, 
			a.Clcodigo, 
			a.Clnombre, 
			o.Folio AS 'NumGtia', 
			d.Numdocu, 
			o.FechaVigencia, 
			m.mnnemo, 
			d.Nemotecnico AS 'Instrumento', 
			d.Nominal, 
			d.TIR, 
			d.ValorPresente, 
			@fechaVcto AS 'FechaVcto', 
			@tipoGar AS 'TipoGtia'
		FROM 	Bacparamsuda.dbo.CLIENTE a,
			Bacparamsuda.dbo.tbl_Garantias_Otorgadas o,
		     	Bacparamsuda.dbo.tbl_Garantias_Otorgadas_Detalle d,
			Bacparamsuda.dbo.MONEDA m
		WHERE 	o.RutCliente = @rutCliente
		AND	o.CodCliente = @codCliente
		AND	o.Folio = d.Folio
		AND	a.ClRut = @rutCliente
		AND	a.Clcodigo = @codCliente
		AND	m.mncodmon = 999
		AND	o.FechaVigencia <= @fechaVcto
	END
	ELSE
	BEGIN
		SELECT 	a.Clrut, 
			a.Cldv, 
			a.Clcodigo, 
			a.Clnombre, 
			g.NumeroOperacion AS 'NumGtia', 
			'',
			g.FechaVigencia, 
			m.mnnemo, 
			d.Instrumento, 
			d.Nominal, 
			d.TIR, 
			d.ValorPresente, 
			@fechaVcto AS 'FechaVcto',
			@tipoGar AS 'TipoGtia'
		FROM 	Bacparamsuda.dbo.CLIENTE a,
			Bacparamsuda.dbo.tbl_mov_Garantia g,
			Bacparamsuda.dbo.tbl_mov_Garantia_detalle d,
			Bacparamsuda.dbo.MONEDA m
		WHERE	g.RutCliente = @rutCliente
		AND	g.CodCliente = @codCliente
		AND	a.ClRut = @rutCliente
		AND	a.Clcodigo = @codCliente
		AND	d.NumeroOperacion = g.NumeroOperacion
		AND	m.mncodmon = d.MonedaEmision
		AND	g.FechaVigencia <= @fechaVcto
	END
END
GO

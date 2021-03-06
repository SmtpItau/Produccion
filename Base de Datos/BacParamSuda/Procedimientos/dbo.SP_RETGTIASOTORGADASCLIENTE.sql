USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGTIASOTORGADASCLIENTE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGTIASOTORGADASCLIENTE]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT 	b.Folio,
		b.Correlativo,
		b.Nemotecnico,
		di.dinemmon,
		a.RutCliente,
		a.CodCliente,
		a.Fecha AS 'FechaInicio',
		a.FechaVigencia AS 'FechaVcto',
		b.Nominal,
		b.ValorPresente,
		b.NumDocu,
		b.TIR,
		b.VPAR,
		a.TipoGarantia
       FROM 	BacParamSuda.dbo.tbl_Garantias_Otorgadas a,
		BacParamSuda.dbo.tbl_Garantias_Otorgadas_Detalle b,
		BacTraderSuda.dbo.MDDI di WITH (NOLOCK),
		Bacparamsuda.dbo.TABLA_GENERAL_DETALLE d
	WHERE 	a.RutCliente = @rutCliente AND
		a.CodCliente = @codCliente AND
		b.Folio      = a.Folio AND
		di.dinumdocu = b.Numdocu AND
		di.dicorrela = b.Correlativo AND
		d.tbcateg = 8700 AND
		d.nemo = 'O' AND
		a.TipoGarantia = d.tbcodigo1 AND
		b.Folio NOT IN (SELECT FolioGtia FROM BacParamSuda.dbo.tbl_relacion_VentaCorta_Garantias
				WHERE RutCliente = @rutCliente AND CodCliente = @codCliente)		
	ORDER BY b.Folio, b.Nemotecnico
	SET NOCOUNT OFF
END

GO

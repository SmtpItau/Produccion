USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_PAPELETAMOVTODIARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_PAPELETAMOVTODIARIO]
		(	
			@iFolio NUMERIC(10),
			@iTipo	CHAR(1)
		)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@iFechaDia	DATETIME

	SELECT @iFechaDia = acfecproc
	FROM BacTradersuda.dbo.mdac

	CREATE TABLE #tmpInfMovDiario(
		TipoGarantia	CHAR(1)		
	,	RutCliente	NUMERIC(9)
	,	CodCliente	NUMERIC(5)
	,	NomCliente	VARCHAR(70)
	,	NumGarantia	NUMERIC(10)
	,	FechaConst	DATETIME
	,	Serie		CHAR(12)
	,	NomEmisor	CHAR(40)
	,	FechaEmision	DATETIME
	,	Vcto		DATETIME
	,	nomMoneda	CHAR(8)
	,	Nominal		NUMERIC(21,4)
	,	NominalVigente	NUMERIC(21,4)
	,	TasaMercado	NUMERIC(8,4)
	,	ValorPresente	NUMERIC(21,0)
	,	FechaVigencia	DATETIME
		)
	/*
		Primero, las Garantías Constituidas
	*/
	IF @iTipo = 'C'
		INSERT INTO #tmpInfMovDiario
		SELECT 	'C',
			enc.RutCliente,
			enc.CodCliente,
			cl.clnombre AS 'NomCliente',
			det.NumeroOperacion AS 'NumeroGtia',
			enc.Fecha AS 'FechaConst',
			det.Instrumento AS 'Serie',
			emi.emgeneric,
			det.FechaEmision,
			det.FechaVencimiento AS 'Vcto',
			mon.mnnemo AS 'NemMoneda',
			car.Nominal AS 'NominalVigente',
			car.Nominal AS 'Nominal',
			det.TIR AS 'TasaMercado',
			det.ValorPresente,
			enc.FechaVigencia	
		FROM 	BacParamsuda.dbo.tbl_mov_garantia enc,
			BacParamsuda.dbo.tbl_mov_garantia_detalle det,
			BacParamsuda.dbo.tbl_cartera_garantia car,
			BacParamsuda.dbo.CLIENTE cl,
			BacParamsuda.dbo.MONEDA mon,
			BacParamsuda.dbo.EMISOR emi
		WHERE	enc.NumeroOperacion 	= @iFolio
		AND	enc.Fecha 		= @iFechaDia
		AND	enc.NumeroOperacion 	= det.NumeroOperacion
		AND	enc.Estado 		= 'V'
		AND	emi.emrut 		= det.RutEmision
		AND	cl.clrut 		= enc.rutCliente
		AND	cl.clcodigo 		= enc.CodCliente
		AND	car.NumeroOperacion 	= det.NumeroOperacion
		AND	car.Correlativo 	= det.Correlativo
		AND	car.Instrumento 	= det.Instrumento
		AND	mon.mncodmon 		= det.MonedaEmision

	ELSE
		INSERT INTO #tmpInfMovDiario
		SELECT 	'O',
			enc.RutCliente,
			enc.CodCliente,
			cl.clnombre AS 'NomCliente',
			det.Folio AS 'NumeroGtia',
			enc.Fecha AS 'FechaConst',
			det.Nemotecnico AS 'Serie',
			di.digenemi,
			cp.cpfecemi AS 'FechaEmision',
			cp.cpfecven AS 'Vcto',
			di.dinemmon AS 'NemoMoneda',
			cp.cpnominal AS 'NominalVigente',
			det.Nominal AS 'Nominal',
			det.TIR AS 'TasaMercado',
			det.ValorPresente,
			enc.FechaVigencia
		FROM 	BacParamsuda.dbo.tbl_garantias_otorgadas enc,
			BacParamsuda.dbo.tbl_garantias_otorgadas_detalle det,
			BacParamsuda.dbo.CLIENTE cl,
			BacTradersuda.dbo.mdcp cp,
			BacTradersuda.dbo.MDDI di
		WHERE   enc.Folio	= @iFolio
		AND	enc.Fecha 	= @iFechaDia
		AND	det.Folio 	= @iFolio
		AND	cl.clrut 	= enc.RutCliente
		AND	cl.clcodigo 	= enc.CodCliente
		AND	cp.cpnumdocu 	= det.Numdocu
		AND	cp.cpcorrela 	= det.Correlativo
		AND	cp.cpinstser 	= det.Nemotecnico
		AND	di.dinumdocu	= det.Numdocu
		AND	di.dicorrela	= det.Correlativo

	SELECT * FROM #tmpInfMovDiario
	ORDER BY TipoGarantia, RutCliente, CodCliente, NumGarantia

	SET NOCOUNT OFF
END
GO

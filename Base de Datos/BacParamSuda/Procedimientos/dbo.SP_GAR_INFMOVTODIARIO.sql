USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_INFMOVTODIARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_INFMOVTODIARIO]
		(	
			@FechaDia DATETIME = NULL
		)
AS
BEGIN
	SET NOCOUNT ON

	IF @FechaDia IS NULL
		SELECT @FechaDia = acfecproc
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
		)
	/*
		Primero, las Garantías Constituidas
	*/
	INSERT INTO #tmpInfMovDiario
	SELECT 	'C',						---Tipo Garantia
		enc.RutCliente,					---RutCliente
		enc.CodCliente,					---CodCliente
		cl.clnombre AS 'NomCliente',			---NomCliente
		det.NumeroOperacion AS 'NumeroGtia',		---NumGarantia
		enc.Fecha AS 'FechaConst',			---FechaConst
		det.Instrumento AS 'Serie',			---Serie
		emi.emgeneric,					---NomEmisor
		det.FechaEmision,				---FechaEmision
		det.FechaVencimiento AS 'Vcto',			---Vcto
		mon.mnnemo AS 'NemoMoneda',			---nomMoneda
		car.Nominal AS 'Nominal',			---Nominal	
		car.Nominal AS 'NominalVigente',		---NominalVigente
		det.TIR AS 'TasaMercado',			---TasaMercado
		det.ValorPresente				---ValorPresente
	FROM 	BacParamsuda.dbo.tbl_mov_garantia enc,
		BacParamsuda.dbo.tbl_mov_garantia_detalle det,
		BacParamsuda.dbo.tbl_cartera_garantia car,
		BacParamsuda.dbo.CLIENTE cl,
		BacParamsuda.dbo.EMISOR emi,
		BacParamsuda.dbo.MONEDA mon
	WHERE	enc.Fecha = @FechaDia
	AND	enc.NumeroOperacion = det.NumeroOperacion
	AND	enc.Estado = 'V'
	AND	emi.emrut = det.RutEmision
	AND	cl.clrut = enc.rutCliente
	AND	cl.clcodigo = enc.CodCliente
	AND	car.NumeroOperacion = det.NumeroOperacion
	AND	car.Correlativo = det.Correlativo
	AND	car.Instrumento = det.Instrumento
	AND	mon.mncodmon = det.MonedaEmision

	/*
		Luego, las Garantías Otorgadas
	*/


	INSERT INTO #tmpInfMovDiario
	SELECT 	'O',						---TipoGarantia
		enc.RutCliente,					---RutCliente
		enc.CodCliente,					---CodCliente
		cl.clnombre AS 'NomCliente',			---NomCliente
		det.Folio AS 'NumeroGtia',			---NumGarantia
		enc.Fecha AS 'FechaConst',			---FechaConst
		det.Nemotecnico AS 'Serie',			---Serie
		di.digenemi,					---NomEmisor
		cp.cpfecemi AS 'FechaEmision',			---FechaEmision
		cp.cpfecven AS 'Vcto',				---Vcto
		di.dinemmon AS 'NemoMoneda',			---nomMoneda
		det.Nominal AS 'Nominal',			---Nominal
		cp.cpnominal AS 'NominalVigente',		---NominalVigente	
		det.TIR AS 'TasaMercado',			---TasaMercado
		det.ValorPresente				---ValorPresente
	FROM 	BacParamsuda.dbo.tbl_garantias_otorgadas enc,
		BacParamsuda.dbo.tbl_garantias_otorgadas_detalle det,
		BacParamsuda.dbo.CLIENTE cl,
		BacTradersuda.dbo.mdcp cp,
		BacTradersuda.dbo.MDDI di
	WHERE	enc.Fecha = @FechaDia
	AND	enc.Folio = det.Folio
	AND	cl.clrut = enc.RutCliente
	AND	cl.clcodigo = enc.CodCliente
	AND	cp.cpnumdocu = det.Numdocu
	AND	cp.cpcorrela = det.Correlativo
	AND	cp.cpinstser = det.Nemotecnico
	AND	di.dinumdocu = det.Numdocu
	AND	di.dicorrela = det.Correlativo

	SELECT * FROM #tmpInfMovDiario
	ORDER BY TipoGarantia, RutCliente, CodCliente, NumGarantia
	SET NOCOUNT OFF
END
GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_LEERMDTM1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_LEERMDTM1]	(	@cSistema	CHAR (03) 
					,	@dFecha		DATETIME
					)
AS
BEGIN


	SET NOCOUNT ON

	DECLARE	@nRutcart	NUMERIC (09)
	,	@dfecfmes	DATETIME 
	,	@acfecproc	DATETIME 
	,	@acfecprox	DATETIME 
	,	@acfecante	DATETIME 
	,	@dFecha2	DATETIME 
	,	@sw_tasa	CHAR(1)
	,	@dFecFMesProx   DATETIME 
	,	@dPrimerDiaProxMes	DATETIME
	,	@dUltDiaMes		DATETIME

	SELECT @nRutcart = acrutprop
	FROM MDAC
	
	SELECT	@acfecante  = acfecante
	,	@acfecproc  = acfecproc
	,	@acfecprox  = acfecprox
 	FROM MDAC

	SELECT	@dPrimerDiaProxMes	= SUBSTRING(CONVERT(CHAR(8),@acfecprox,112),1,6)+'01'
	SELECT	@dUltDiaMes		= DATEADD(DAY,-1,@dPrimerDiaProxMes)

	IF (SELECT COUNT(1) FROM TASA_MERCADO WHERE fecha_proceso = @dFecha) = 0 BEGIN
		SELECT	@dFecha = @acfecante
	END

	IF MONTH(@acfecante) < MONTH(@acfecproc) AND SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),7,2) <> '01' BEGIN -- INICIO DE MES ESPECIAL
		SELECT @dFecha = DATEADD(DAY, -1,(SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),1,6)+'01'))
	END

		SELECT	diinstser     
		,	digenemi     
		,	'fecven'     = CONVERT(CHAR(10),cpfecven,103)
		,	'tmarcierre' = CONVERT(NUMERIC (08,4),0) 
		,	'tmarkciere' = CONVERT(NUMERIC (08,4),0) 
		,	'tmark1'     = CONVERT(NUMERIC (08,4),0) 
		,	'tmark2'     = CONVERT(NUMERIC (08,4),0) 
		,	'emrut'      = CONVERT(NUMERIC (09,0),0) 
		,	incodigo     
		,	mncodmon     
		,	'nominal' = ISNULL(SUM(cpnominal),0) 
		,	dirutcart
		INTO	#TEMPO
		FROM	MDDI
		,	MDCP
		,	VIEW_INSTRUMENTO
		,	VIEW_MONEDA
		WHERE	ditipoper	= 'CP' 
		AND	(cpnumdocu	= dinumdocu AND cpcorrela = dicorrela) 
		AND	incodigo	= cpcodigo 
		AND	dirutcart	= @nRutcart 
		AND	dinemmon	= mnnemo 
		AND	cpcodigo	<> 98
		GROUP 
		BY	diinstser
		,	digenemi
		,	cpfecven
		,	incodigo
		,	mncodmon
		,	dirutcart

		UPDATE	#TEMPO 
		SET	emrut = view_emisor.emrut
		FROM	view_emisor
		WHERE	emgeneric = digenemi
  
		UPDATE	#TEMPO
		SET	nominal = nominal + ISNULL((SELECT	SUM(vinominal) 
							FROM	MDVI 
							WHERE	viinstser = diinstser 
							and	vitipoper = 'CP'),0)

		DELETE #TEMPO WHERE nominal <= 0
 
		UPDATE	#TEMPO 
		SET	tmarcierre =  ISNULL(tasa_mercado,0) 
		FROM	TASA_MERCADO
		WHERE	fecha_proceso	= @dFecha
		AND	id_sistema	= @cSistema 
		AND	tminstser	= diinstser 
		AND	tmgenemis	= digenemi   

		UPDATE #TEMPO 
		SET	tmarkciere = ISNULL(tasa_market,0) 
		FROM	TASA_MERCADO 
		WHERE	@dFecha		= fecha_proceso 
		AND	@cSistema	= id_sistema 
		AND	diinstser	= tminstser 
		AND	tmgenemis	= digenemi

		UPDATE #TEMPO 
		SET	tmark1     = ISNULL(tasa_market1,0)
		FROM	TASA_MERCADO 
		WHERE	@dFecha		= fecha_proceso 
		AND	@cSistema	= id_sistema 
		AND	diinstser	= tminstser 
		AND	tmgenemis	= digenemi
	
		UPDATE #TEMPO 
		SET	tmark2     = ISNULL(tasa_market2,0)
		FROM	TASA_MERCADO 
		WHERE	@dFecha		= fecha_proceso 
		AND	@cSistema	= id_sistema 
		AND	diinstser	= tminstser 
		AND	tmgenemis	= digenemi

		SELECT	diinstser 
		,	digenemi 
		,	fecven  
		,	tmarcierre 
		,	tmarkciere 
		,	tmark1  
		,	tmark2  
		,	emrut  
		,	incodigo 
		,	mncodmon 
		,	nominal  
		,	dirutcart
		FROM	#TEMPO
		ORDER 
		BY	diinstser

	SET NOCOUNT OFF
END

GO

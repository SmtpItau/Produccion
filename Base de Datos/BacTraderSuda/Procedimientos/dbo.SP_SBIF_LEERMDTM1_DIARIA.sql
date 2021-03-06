USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_LEERMDTM1_DIARIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_LEERMDTM1_DIARIA]	(	@cSistema	CHAR(03) 
						,	@dFecha		DATETIME
						)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @nRutcart NUMERIC (09)

	DECLARE @dfecfmes        DATETIME 
	,	@acfecproc       DATETIME 
	,	@acfecprox       DATETIME  
	,	@dFecha2         DATETIME 
	,	@sw_tasa         CHAR(1)  
	,	@x               INTEGER  
	,	@max             INTEGER  
	,	@TASA            INTEGER  
	,	@numero          INTEGER  
	,	@correla         INTEGER  
	,	@cpfeccomp       DATETIME 
	,	@dFecFMesAnt     DATETIME
	,	@acfecant	DATETIME
	,	@dPrimerDiaMes	DATETIME
	,	@dUltDiaMesAnt	DATETIME

	DECLARE	@dFecFMesProx	DATETIME
	,	@Total_reg	NUMERIC(10)
	,	@sw		CHAR(1)

	SELECT @nRutcart = acrutprop
	FROM MDAC

	SELECT	@acfecproc	= acfecproc
	,	@acfecprox	= acfecprox
	,	@acfecant	= acfecante
	FROM	MDAC

	SELECT @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
	SELECT @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )

	SELECT @dfecfmes = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
	SELECT @dFecFMesAnt = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@acfecprox)) * -1, CONVERT(DATETIME,@acfecprox))

	SELECT	diinstser
	,	digenemi
	,	'fecven'	= CONVERT(CHAR(10),cpfecven,103) 
	,	'tmarcierre'	= CONVERT(NUMERIC (08,4),0)      
	,	'tmarkciere'	= CONVERT(NUMERIC (08,4),0)      
	,	'tmark1'	= CONVERT(NUMERIC (08,4),0)      
	,	'tmark2'	= CONVERT(NUMERIC (08,4),0)      
	,	'emrut'		= CONVERT(NUMERIC (09,0),0)      
	,	incodigo
	,	mncodmon
	,	'nominal'	= ISNULL(cpnominal,0)
	,	dirutcart
	,	ditircomp
	,	cpfeccomp
	,	dinumdocu
	,	dicorrela
	INTO	#TEMPO
	FROM	MDDI
	,	MDCP
	,	VIEW_INSTRUMENTO
	,	VIEW_MONEDA
	WHERE	ditipoper	= 'CP'      
	AND	(cpnumdocu	= dinumdocu	AND cpcorrela	= dicorrela AND cpnumdocuo = dinumdocuo) 
	AND	incodigo	= cpcodigo
	AND	dirutcart	= @nRutcart 
	AND	dinemmon	= mnnemo    
	AND	cpcodigo	<> 98 
	AND	(dinominal	> 0 OR EXISTS(SELECT 1 FROM MDVI WHERE Vinumdocu = Dinumdocu and Vicorrela = dicorrela))
	ORDER 
	BY	diinstser

	UPDATE	#TEMPO
	SET	nominal = nominal + vinominal 
	FROM	MDVI 
	WHERE	diinstser	= viinstser
	AND	dinumdocu	= vinumdocu
	AND	dicorrela	= vicorrela

	DELETE	#TEMPO 
	WHERE	nominal <= 0

	UPDATE	#TEMPO 
	SET	emrut	= view_emisor.emrut
	FROM	view_emisor
	WHERE	emgeneric	= digenemi

	UPDATE	#TEMPO 
	SET	tmarcierre = ISNULL(tasa_mercado,0) 
	FROM	TASA_MERCADO_DIARIA
	WHERE	fecha_proceso	 = @dFecha
	AND	id_sistema	 = @cSistema 
	AND	tminstser	 = diinstser 
	AND	tmgenemis	 = digenemi  

	IF DATEPART(MONTH, @acfecproc) > DATEPART(MONTH , @acfecant) BEGIN -- PRIMER DIA HABIL DEL MES
		SELECT	@dPrimerDiaMes	= SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),1,6) + '01' --PRIMER DIA DEL MES
		SELECT	@dUltDiaMesAnt	= DATEADD(DAY,-1,@dPrimerDiaMes)
		SELECT	@acfecant	= @dUltDiaMesAnt

		UPDATE	#TEMPO 
		SET	tmarcierre = ISNULL(tasa_mercado,0) 
		FROM	TASA_MERCADO
		WHERE	fecha_proceso	 = @acfecant
		AND	id_sistema	 = @cSistema 
		AND	tminstser	 = diinstser 
		AND	tmgenemis	 = digenemi 
		AND	tmarcierre 	 = 0.0

		UPDATE	#TEMPO 
		SET	tmarkciere	= ISNULL((	SELECT TOP 1 tasa_market 
						 	FROM	TASA_MERCADO
						 	WHERE	fecha_proceso	= @acfecant
						 	AND	id_sistema	= @cSistema
						 	AND	tminstser	= diinstser
						 	AND	tmgenemis	= digenemi),0)
		UPDATE	#TEMPO 
		SET	tmark1		= ISNULL((	SELECT TOP 1  tasa_market1 
							FROM	TASA_MERCADO 
							WHERE	fecha_proceso	= @acfecant
							AND	id_sistema	= @cSistema 
							AND	tminstser	= diinstser 
							AND	tmgenemis	= digenemi ),0)
		UPDATE	#TEMPO 
		SET	tmark2		= ISNULL((	SELECT TOP 1  tasa_market2 
							FROM	TASA_MERCADO 
							WHERE	fecha_proceso	= @acfecant
							AND	id_sistema	= @cSistema 
							AND	tminstser	= diinstser 
							AND	tmgenemis	= digenemi ),0)
	END
	ELSE BEGIN
		UPDATE	#TEMPO 
		SET	tmarcierre = ISNULL(tasa_mercado,0) 
		FROM	TASA_MERCADO_DIARIA
		WHERE	fecha_proceso	 = @acfecant
		AND	id_sistema	 = @cSistema 
		AND	tminstser	 = diinstser 
		AND	tmgenemis	 = digenemi 
		AND	tmarcierre 	 = 0.0

		UPDATE	#TEMPO 
		SET	tmarkciere	= ISNULL((	SELECT TOP 1 tasa_market 
						 	FROM	TASA_MERCADO_DIARIA 
						 	WHERE	fecha_proceso	= @dFecha
						 	AND	id_sistema	= @cSistema
						 	AND	tminstser	= diinstser
						 	AND	tmgenemis	= digenemi),0)	
		UPDATE	#TEMPO 
		SET	tmark1		= ISNULL((	SELECT TOP 1  tasa_market1 
							FROM	TASA_MERCADO_DIARIA 
							WHERE	fecha_proceso	= @dFecha 
							AND	id_sistema	= @cSistema 
							AND	tminstser	= diinstser 
							AND	tmgenemis	= digenemi ),0)
		UPDATE	#TEMPO 
		SET	tmark2		= ISNULL((	SELECT TOP 1  tasa_market2 
							FROM	TASA_MERCADO_DIARIA 
							WHERE	fecha_proceso	= @dFecha 
							AND	id_sistema	= @cSistema 
							AND	tminstser	= diinstser 
							AND	tmgenemis	= digenemi ),0)
	END
				
	SELECT  diinstser 
	,	digenemi 
	,	fecven  
	,	tmarcierre 
	,	tmarkciere 
	,	tmark1  
	,	tmark2  
	,	emrut  
	,	incodigo 
	,	mncodmon 
	,	'nominal' = SUM(nominal) 
	,	dirutcart  
	,	'FecCompra' = ''
	FROM	#TEMPO
	GROUP	
	BY	diinstser 
	,	digenemi 
	,	fecven  
	,	tmarcierre 
	,	tmarkciere 
	,	tmark1  
	,	tmark2  
	,	emrut  
	,	incodigo 
	,	mncodmon 
	,	dirutcart
	ORDER 
	BY	diinstser

	SET NOCOUNT OFF

END

GO

USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_LEERMDTM1_NUEVO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SBIF_LEERMDTM1_NUEVO]
	(   @cSistema    CHAR(03)
	,   @dFecha      DATETIME
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @nRutcart			NUMERIC(09)
	DECLARE @dfecfmes			DATETIME
	DECLARE @acfecproc			DATETIME
	DECLARE @acfecprox			DATETIME
	DECLARE @acfecante			DATETIME
	DECLARE @dFecha2			DATETIME
	DECLARE @sw_tasa			CHAR(1)
	DECLARE @dFecFMesProx		DATETIME
	DECLARE @dPrimerDiaProxMes	DATETIME
	DECLARE @dUltDiaMes			DATETIME

	SELECT  @nRutcart			= acrutprop
		,	@acfecante			= acfecante
		,	@acfecproc			= acfecproc
		,	@acfecprox			= acfecprox
	FROM    MDAC

	SET     @dPrimerDiaProxMes	= SUBSTRING(CONVERT(CHAR(8),@acfecprox,112),1,6) + '01'
	SET     @dUltDiaMes			= DATEADD(DAY,-1,@dPrimerDiaProxMes)

	/*	
	IF (SELECT COUNT(1) FROM TASA_MERCADO WHERE fecha_proceso = @dFecha) = 0 
	BEGIN
		SET @dFecha    = @acfecante
	END
	*/

	/*
	IF MONTH(@acfecante) < MONTH(@acfecproc) AND SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),7,2) <> '01' 
	BEGIN -- INICIO DE MES ESPECIAL
		SET @dFecha    = DATEADD(DAY, -1,(SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),1,6)+'01'))
	END
	*/

	/*
	IF	( MONTH (@acfecproc ) <> MONTH( @acfecprox ) )
	BEGIN	--	SI ES FIN DE MES ESPECIAL
		SET @dFecha    = DATEADD(DAY, -1,(SUBSTRING(CONVERT(CHAR(8),@acfecproc,112),1,6)+'01'))
	END
	*/

	declare @dLastMonthDay		datetime
		set	@dLastMonthDay		= dateadd( month, (day(@acfecproc)*-1), @acfecproc)

	if ( month( @acfecproc ) <> month( @acfecprox ) ) and ( @acfecproc = @dLastMonthDay )
	begin
		set	@dFecha	= @dLastMonthDay
	end


	-->		Lee el Sw de Configuracion de Garantias
	DECLARE @iActivaCicloGarantias	INT
	SELECT	@iActivaCicloGarantias	= BacTraderSuda.dbo.Fx_Sw_Garantias(4)
	-->		Si @iActivaCicloGarantias = 0 ; esta Apagado	Garantias
	-->		Si @iActivaCicloGarantias = 1 ; esta Encendido	Garantias

	SELECT 'diinstser'   = diinstser
	,      'digenemi'    = digenemi
	,      'fecven'      = cpfecven
	,      'tmarcierre'  = CONVERT(NUMERIC(08,4),0)
	,      'tmarkciere'  = CONVERT(NUMERIC(08,4),0)
	,      'tmark1'      = CONVERT(NUMERIC(08,4),0)
	,      'tmark2'      = CONVERT(NUMERIC(08,4),0)
	,      'emrut'       = CONVERT(NUMERIC(09,0),0)
	,      'incodigo'    = incodigo
	,      'mncodmon'    = mncodmon
	,      'nominal'     = ISNULL(SUM(cpnominal),0)
	,      'dirutcart'   = dirutcart
	,      'CurvaPrinc'  = SPACE(20)
	,      'CurvaAlter'  = SPACE(20)
	,      'Spread'      = SPACE(1)
	,      'CurvaSpread' = SPACE(20)
	,      'vValorCurvaP'= CONVERT(FLOAT, 0.0)
	,      'vValorCurvaS'= CONVERT(FLOAT, 0.0)
	,      'Mascara'     = cpmascara
	,      'nTasEmision' = 0.0
	,      'cSeriado'    = cpseriado
	,      'TipoCurva'   = '--'
	,      'Puntero'     = identity(Int)
	INTO	#TEMPO
	FROM	MDDI
			INNER JOIN MDCP             ON cpnumdocu = dinumdocu AND cpcorrela = dicorrela
			LEFT  JOIN VIEW_INSTRUMENTO ON cpcodigo  = incodigo
			LEFT  JOIN VIEW_MONEDA      ON mnnemo    = dinemmon
	WHERE	ditipoper    = 'CP'
	AND		dirutcart    = @nRutcart
	AND		cpcodigo    <> 98
	and		cpfecven	>= @dFecha
--	AND		diinstser	 = 'DES5510103'
	GROUP 
	BY		diinstser
	,		digenemi
	,		cpfecven
	,		incodigo
	,		mncodmon
	,		dirutcart
	,		cpseriado
	,		cpcodigo
	,		cpmascara

	UPDATE	#TEMPO
	SET		emrut		= VIEW_EMISOR.emrut
	FROM	VIEW_EMISOR
	WHERE	emgeneric	= digenemi

	UPDATE	#TEMPO
	SET		nominal		= nominal + ISNULL((	SELECT	SUM(vinominal) FROM	MDVI WHERE viinstser = diinstser and vitipoper = 'CP') ,0)

	-->	Garantias
	if @iActivaCicloGarantias = 1
	begin
		UPDATE	#TEMPO
			SET	nominal		= #TEMPO.nominal + Garantia.Nominal
		FROM	(	SELECT	Serie	= val.Serie
						,	Nominal	= SUM( val.Nominal )
					FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
							inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
							inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																										and val.Garantia_Correlativo = det.CorrelativoGarantia
					WHERE	(		enc.TipoMovimiento	= '23'
					and		not (	det.Instrumento		= 'EFECTIVO'	)
							)
					GROUP 
					BY		val.Serie
				)	Garantia
		WHERE	diinstser	= Garantia.Serie
	end
	-->	Garantias
	
	DELETE   #TEMPO
	WHERE    nominal	<=	0

	UPDATE  #TEMPO
	SET     tmarcierre     =  ISNULL(tasa_mercado,0)
	FROM	TASA_MERCADO
	WHERE   fecha_proceso  = @dFecha
	AND	    id_sistema	   = @cSistema
	AND	    tminstser	   = diinstser
	AND	    tmgenemis	   = digenemi

	UPDATE  #TEMPO
	SET	    tmarkciere     = ISNULL(tasa_market,0)
	FROM	TASA_MERCADO
	WHERE   fecha_proceso  = @dFecha
	AND	    id_sistema     = @cSistema
	AND	    diinstser	   = tminstser
	AND	    tmgenemis	   = digenemi

	UPDATE  #TEMPO
	SET	    tmark1			= ISNULL(tasa_market1,0)
	FROM	TASA_MERCADO
	WHERE	fecha_proceso	= @dFecha
	AND		id_sistema		= @cSistema
	AND		diinstser		= tminstser
	AND		tmgenemis		= digenemi

	UPDATE	#TEMPO
	SET		tmark2			= ISNULL(tasa_market2,0)
	FROM	TASA_MERCADO 
	WHERE	fecha_proceso	= @dFecha
	AND		id_sistema		= @cSistema
	AND		diinstser		= tminstser
	AND		tmgenemis		= digenemi

	DECLARE @iFound              INTEGER
	DECLARE @cModulo             CHAR(3)
	DECLARE @cProducto           VARCHAR(5)
	DECLARE @iMoneda             INTEGER
	DECLARE @cInstrumento        VARCHAR(20)
	DECLARE @cEmisor             VARCHAR(20)
	DECLARE @cCurvaPrincipal     VARCHAR(20)
	DECLARE @cCurvaAlternativa   VARCHAR(20)
	DECLARE @sSpread             CHAR(1)
	DECLARE @cCurvaSpread        VARCHAR(20)
	DECLARE @iDias               NUMERIC(9)
	DECLARE @vCurvaProducto      FLOAT
	DECLARE @vCurvaSpread        FLOAT
	DECLARE @nRutEmi             NUMERIC(10)
	DECLARE @Seriado             CHAR(1)
	DECLARE @Serie               VARCHAR(20)
	DECLARE @nTasa               FLOAT
	DECLARE @nCodigo             INTEGER

	DECLARE @nTasaPromPond       FLOAT
	SET     @nTasaPromPond       = 0.0

	DECLARE @iRegistros          NUMERIC(9)
	DECLARE @iContador           NUMERIC(9)

	SELECT  @iRegistros          = MAX(Puntero)
	,       @iContador           = MIN(Puntero)
	FROM    #TEMPO

	WHILE     @iRegistros       >= @iContador
	BEGIN
		SELECT	@cModulo           = 'BTR'
		,		@cProducto         = 'CP'
		,		@iMoneda           = t.mncodmon
		,		@cInstrumento      = i.inserie
		,		@cEmisor           = t.digenemi
		,		@cCurvaPrincipal   = ''
		,		@cCurvaAlternativa = ''
		,		@sSpread           = ''
		,		@cCurvaSpread      = ''
		,		@vCurvaProducto    = 0.0
		,		@vCurvaSpread      = 0.0
		,		@iDias             = DATEDIFF(DAY,@acfecproc,fecven)
		,		@Seriado           = cSeriado
		,		@Serie             = CASE WHEN i.incodigo IN(15,20) THEN mascara ELSE diinstser END
		,		@nTasa             = 0.0
		,		@nCodigo           = i.incodigo
		,		@nRutEmi           = emrut
		FROM	#TEMPO t
				LEFT JOIN BacParamSuda..INSTRUMENTO i ON i.incodigo = t.incodigo
		WHERE	t.Puntero          = @iContador

		IF @Seriado = 'S'
		BEGIN
			/*
			SET @nTasa = ISNULL((SELECT setasemi FROM BacParamSuda..SERIE WITH (NOLOCK)
							   WHERE seserie = @nCodigo and semascara = @Serie AND serutemi = @nRutEmi),0.0)
			*/
			SET @nTasa = ISNULL((	SELECT	setasemi 
									FROM	BacParamSuda.dbo.Serie with(nolock)
									WHERE	secodigo	= @nCodigo 
									AND		semascara	= @Serie
									AND		serutemi	= @nRutEmi)	,0.0)
		END

		SET     @nTasaPromPond	= 0.0
		EXECUTE BacParamSuda.dbo.SP_LEE_TASA_PONDERADA @acfecproc, 'IRF', @Serie, @cEmisor, @nTasaPromPond OUTPUT

		IF @nTasaPromPond <> 0.0
		BEGIN
			UPDATE #TEMPO
			SET    CurvaPrinc   = ''
			,      CurvaAlter   = ''
			,      Spread       = ''
			,      CurvaSpread  = ''
			,      vValorCurvaP = @nTasaPromPond
			,      vValorCurvaS = 0.0
			,      TipoCurva    = 'TM'
			WHERE  Puntero      = @iContador
		END ELSE
		BEGIN
			EXECUTE @iFound = BacParamSuda..SP_RETORNA_CURVAS_PRODUCTO	@cModulo
																	,	@cProducto
																	,	'C' 
																	,	@iMoneda
																	,	@cInstrumento
																	,	@cEmisor
																	,	@iDias 
																	,	@cCurvaPrincipal     OUTPUT
																	,	@cCurvaAlternativa   OUTPUT
																	,	@sSpread             OUTPUT
																	,	@cCurvaSpread        OUTPUT
																	,	@vCurvaProducto      OUTPUT
																	,	@vCurvaSpread        OUTPUT
																	,	0
																	,	@nTasa
			DECLARE @cTipoCurva		CHAR(2)
			SET		@cTipoCurva		= 'MC'

			SELECT	@cTipoCurva		= 'TM'
			FROM	BacParamSuda.dbo.CURVAS 
			WHERE	FechaGeneracion = @acfecproc 
			AND		CodigoCurva		= @cCurvaPrincipal 
			AND		Dias			= @iDias 
			AND		Origen			= 'TM'

			UPDATE #TEMPO
			SET    CurvaPrinc   = @cCurvaPrincipal
			,      CurvaAlter   = @cCurvaAlternativa
			,      Spread       = @sSpread
			,      CurvaSpread  = @cCurvaSpread
			,      vValorCurvaP = @vCurvaProducto
			,      vValorCurvaS = @vCurvaSpread
			,      TipoCurva    = @cTipoCurva
			WHERE  Puntero      = @iContador
		END

		SET @iContador = @iContador + 1
	END

	UPDATE	#TEMPO 
	SET		vValorCurvaP	= ISNULL(tasa_mercado, 0.0)
	FROM	TASA_MERCADO
	WHERE	fecha_proceso	= @dFecha
	AND		id_sistema		= @cSistema
	AND		tminstser		= diinstser
	AND		tmgenemis		= digenemi
	AND	(	vValorCurvaP	+ vValorCurvaS	) = 0.0

	SELECT  /*01*/	diinstser
		,	/*02*/	digenemi
		,	/*03*/	fecven
		,	/*04*/	tmarcierre
		,	/*05*/	tmarkciere
		,	/*06*/	tmark1
		,	/*07*/	tmark2
		,	/*08*/	emrut
		,	/*09*/	incodigo
		,	/*10*/	mncodmon
		,	/*11*/	nominal
		,	/*12*/	dirutcart
		,	/*13*/	CurvaPrinc
		,	/*14*/	CurvaAlter
		,	/*15*/	Spread
		,	/*16*/	CurvaSpread
		,	/*17*/	vValorCurvaP
		,	/*18*/	vValorCurvaS
		,	/*19*/	vValorCurvaP + vValorCurvaS as TasaMercado
		,	/*20*/	Plazo		= DATEDIFF(DAY,@acfecproc,fecven)
		,	/*21*/	TipoCurva
		,	/*22*/	Registros	= (SELECT COUNT(1) FROM #TEMPO)
	FROM	#TEMPO
	ORDER 
	BY		case when (vValorCurvaP + vValorCurvaS) = 0.0 then 2 else 1 end
		,	diinstser

END
GO

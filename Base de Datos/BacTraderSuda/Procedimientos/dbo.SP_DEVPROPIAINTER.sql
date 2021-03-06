USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVPROPIAINTER]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DEVPROPIAINTER]
	(   @dFechoy        DATETIME
	,   @dFecprox       DATETIME
	,   @fTe_pcdus      FLOAT
	,   @fTe_pcduf      FLOAT
	,   @fTe_ptf        FLOAT
	,	@cDevengo_dolar	CHAR(01)
	)
AS
BEGIN

	SET NOCOUNT ON ;    

	DECLARE @fTasemi				FLOAT    
		,	@fBasemi				FLOAT    
		,	@fTasest				FLOAT    
		,	@fNominal				FLOAT    
		,	@fTir					FLOAT    
		,	@fTirBCaps				FLOAT    
		,	@fPvp					FLOAT    
		,	@fMT					FLOAT    
		,	@fMTUM					FLOAT    
		,	@fMT_cien				FLOAT    
		,	@fVan					FLOAT    
		,	@fVpar					FLOAT    
		,	@fIntucup				FLOAT    
		,	@fAmoucup				FLOAT    
		,	@fSalucup				FLOAT    
		,	@fIntpcup				FLOAT    
		,	@fAmopcup				FLOAT    
		,	@fSalpcup				FLOAT    
		,	@fDurat					FLOAT    
		,	@fConvx					FLOAT    
		,	@fDurmo					FLOAT    
		,	@fTasaFloat				FLOAT    
		,	@fNomiReal				FLOAT    
		,	@fValmon_Hoy			FLOAT    
		,	@fValmon_Man			FLOAT    
		,	@fValmon_Com			FLOAT    
		,	@fValmon_Cup			FLOAT    
		,	@fCapital				FLOAT    
		,	@fCapital_UM			FLOAT    
		,	@fFactor				FLOAT    
		,	@fValcupo				FLOAT    
		,	@fIntcupo				FLOAT    
		,	@fAmocupo				FLOAT    
		,	@fMonto					FLOAT    
		,	@nValorpara				FLOAT    
		,	@fIpc_Mes				FLOAT    
		,	@fIpc_Hoy				FLOAT    
		,	@fIpc_cp				FLOAT    
		,	@fIpc_in				FLOAT    
		,	@fIpc_pr				FLOAT    
		,	@fVparDEV				FLOAT    
		,	@fNocionalPm			FLOAT    
		,	@fValcomu				FLOAT  ;    

	DECLARE @TipDev					CHAR(03)    
		,	@cProg					CHAR(10)    
		,	@cInstser				CHAR(10)    
		,	@cInstcam				CHAR(10)    
		,	@cMascara				CHAR(10)    
		,	@cSeriado				CHAR(01)    
		,	@cCartera				CHAR(03)    
		,	@xTipOper				CHAR(03)    
		,	@cMes					CHAR(02)    
		,	@cAno					CHAR(04)    
		,	@sw_contab				CHAR(01)    
		,	@sw_deven				CHAR(01)    
		,	@cTipo_Moneda_papel		CHAR(01) ;    
    
	DECLARE @iModcal				INTEGER    
		,	@iCodigo				INTEGER    
		,	@iMonemi				INTEGER    
		,	@nNumucup				INTEGER    
		,	@nNumpcup				INTEGER    
		,	@nError					INTEGER    
		,	@iCupon					INTEGER    
		,	@iPago_Nohabil			INTEGER    
		,	@iX						INTEGER     
		,	@nContador				INTEGER    
		,	@nDecimal				INTEGER    
		,	@nMes					INTEGER    
		,	@nAno					INTEGER    
		,	@nMes_a					INTEGER    
		,	@iAst					INTEGER  ;    

	DECLARE @dFeccomp				DATETIME    
		,	@dFecDevengo			DATETIME    
		,	@dFec_cp				DATETIME    
		,	@dFec_in				DATETIME    
		,	@dFec_pr				DATETIME    
		,	@dFechaLiquida			DATETIME    
		,	@dFecpro				DATETIME    
		,	@dFecucup				DATETIME    
		,	@dFecpcup				DATETIME    
		,	@dFecemi				DATETIME    
		,	@dFecven				DATETIME    
		,	@dFeccal				DATETIME ;    

	DECLARE @nReacup				NUMERIC(19,4)    
		,	@nIntcup				NUMERIC(19,4)    
		,	@nDifcup				NUMERIC(19,4)    
		,	@nPagCupo				NUMERIC(19,4)    
		,	@nPagCup				NUMERIC(19,4)    
		,	@nDifReaCup				NUMERIC(19,0)    
		,	@nIntdif				NUMERIC(19,0)    
		,	@nIntPordia				NUMERIC(19,0)    
		,	@nInteres_RealCup		NUMERIC(19,0)    
		,	@nRutcart				NUMERIC(09,0)    
		,	@nTipcart				NUMERIC(05,0)    
		,	@nNumdocu				NUMERIC(10,0)    
		,	@nNumoper				NUMERIC(10,0)    
		,	@nCorrela				NUMERIC(03,0)    
		,	@nValcomp				NUMERIC(19,4)    
		,	@nVpresen				NUMERIC(19,4)    
		,	@nInteres				NUMERIC(19,4)    
		,	@nReajuste				NUMERIC(19,0)    
		,	@nIntMes				NUMERIC(19,4)    
		,	@nReaMes				NUMERIC(19,0)    
		,	@nIntdia				NUMERIC(19,4)    
		,	@nReadia				NUMERIC(19,0)    
		,	@nValoraTasaEmi			NUMERIC(19,4)    
		,	@nPrimaDctoTot			NUMERIC(19,0)    
		,	@nPrimaDctoDia			NUMERIC(19,0)    
		,	@valorpar_lchr			NUMERIC(19,4)    
		,	@nValPste_Pagomañana	NUMERIC(19,4)    
		,	@nInteresvpar			NUMERIC(19,0)    
		,	@xx						NUMERIC(18,4)    
		,	@xx1					NUMERIC(18,4)    
		,	@nPrimaDesc				NUMERIC(19,4)    
		,	@nRea_cp				NUMERIC(19,0)    
		,	@nRea_pr				NUMERIC(19,0)    
		,	@frutemis				NUMERIC(09)    
		,	@nRutBanco				NUMERIC(09)    
		,	@nCodBanco				NUMERIC(05) ;    
    
	DECLARE @dFechaAnterior			DATETIME

	-->		Lee el Sw de Configuracion de Garantias
	DECLARE @iActivaCicloGarantias	INT
	SELECT	@iActivaCicloGarantias	= BacTraderSuda.dbo.Fx_Sw_Garantias(4)
	-->		Si @iActivaCicloGarantias = 0 ; esta Apagado	Garantias
	-->		Si @iActivaCicloGarantias = 1 ; esta Encendido	Garantias

	--> Recupera Fecha T-2  para devengo de BCAPS-F
	IF @cDevengo_dolar = 'S'
	BEGIN
		CREATE TABLE ##MDACPASO 
		(   Fecha   DATETIME   )

		DECLARE @cSql		VARCHAR(100)
			SET @cSql		= (	SELECT ' INSERT INTO ##MDACPASO SELECT acfecante FROM MDAC'
							+	CASE	WHEN LEN( DATEPART(MONTH, acfecante) ) = 1 THEN '0' + LTRIM(RTRIM( DATEPART(MONTH, acfecante) ))
										ELSE LTRIM(RTRIM( DATEPART(MONTH, acfecante) ))
									END
							+	CASE	WHEN LEN( DATEPART(DAY, acfecante) ) = 1 THEN '0' + LTRIM(RTRIM( DATEPART(DAY, acfecante) ))
										ELSE LTRIM(RTRIM( DATEPART(DAY, acfecante) ))
									END
							FROM MDAC )
		EXECUTE (@cSql)

		SELECT  @dFechaAnterior = fecha from ##MDACPASO
		DROP TABLE ##MDACPASO 
	END

	IF @cDevengo_dolar = 'S'
		IF NOT EXISTS( SELECT * FROM MDDI WHERE CHARINDEX(RTRIM(dinemmon),'DA-DO-ICPR-ICP') > 0) 
		BEGIN
			SELECT 'SI','No Existen Documentos en dolares'
			RETURN
		END ELSE
			SELECT @dFecDevengo = @dFecHoy;

	SELECT	@nRutBanco	= rcrut
		,	@nCodBanco	= rccodcar
	FROM	VIEW_ENTIDAD;

	UPDATE	MDAC
		SET acsw_pc		= '1';

	SELECT	@sw_contab	= acsw_co
		,   @sw_deven	= acsw_dvprop
		,   @fIpc_Mes	= ac_ipcmes
		,   @dFecpro	= CASE  WHEN acsw_rc = '0' AND @cDevengo_dolar = 'S' THEN acfecante ELSE acfecproc END
	FROM	MDAC;

    --> Variables Chequeo Fin de Mes no Habil
	SET @iX    = 0
    SET @nMes  = 0
    SET @cMes  = ''

	SELECT	@fIpc_hoy	= vmvalor
	FROM	VIEW_VALOR_MONEDA
	WHERE	vmcodigo	= 502
	AND		vmfecha		= DATEADD(MONTH, -1, DATEADD(DAY,(DATEPART(DAY,@dFechoy) * -1) +1, @dFechoy));

	SET		@fIpc_hoy	= ISNULL(@fIpc_hoy, @fIpc_Mes);

	IF @fIpc_hoy = 0.0
		SET @fIpc_hoy = @fIpc_Mes

	/*	__________________________________________________________________
		Se realiza la validación de las monedas necesarias para el proceso
		================================================================== 
	*/

	WHILE @iX <= DATEDIFF(DAY,@dFecHoy,@dFecProx)
	BEGIN
		SET @nValorpara = 0.0 ;

		IF @cDevengo_dolar = 'N'
		BEGIN
			SET @nvalorpara = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 AND vmfecha = DATEADD(DAY,@iX,@dFecHoy) )

			IF @nValorpara IS NULL OR @nValorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor U.F. ' + CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103) + ' NO Existe'
				RETURN
			END

			SET @nValorpara = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=997 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) )

			IF @nvalorpara IS NULL OR @nvalorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor I.V.P. ' + CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103) + ' NO Existe'
				RETURN
			END
		END

		IF @cDevengo_dolar = 'S'
		BEGIN
			SET @nValorpara = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) )

			IF @nValorpara IS NULL OR @nValorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
				RETURN
			END

			--> VB+-22/06/2010 Control de Monedas de ICP
			SET @nValorpara = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=800 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) )
			IF @nValorpara IS NULL OR @nValorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor ICP '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
				RETURN
			END

			SET @nValorpara = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=801 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) )
			IF @nValorpara IS NULL OR @nValorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor ICP Real '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
				RETURN
			END
			--> VB+- End
		END

		SET @iX = @iX + DATEDIFF(DAY,@dFechoy,@dFecprox)
	END

	IF @cDevengo_dolar = 'N'
	BEGIN
		DELETE	FROM MDRS
		WHERE	rsfecha   = @dFecprox
		AND	(	rscartera = '111' OR rscartera = '114')
		AND	(	rsmonemi  = 999   OR rsmonemi  = 998 OR rsmonemi = 997 OR rsmonemi = 13)

		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
			RETURN
		END
		
		-->	Solo si Garantias esta Activado Status = ON
		if @iActivaCicloGarantias = 1
		begin
			DELETE	FROM MDRS
			WHERE	rsfecha   = @dFecprox
			AND	(	rscartera = '159')
			AND	(	rsmonemi  = 999   OR rsmonemi  = 998 OR rsmonemi = 997 OR rsmonemi = 13)

			if @@error <> 0
			begin
				select 'NO','No se pudieron eliminar registros de tabla resultado para Garantias.'
				return
			end
		end
		-->	Solo si Garantias esta Activado Status = ON
				
	END ELSE
	BEGIN
		DELETE	FROM MDRS
		WHERE	rsfecha   = @dFecprox
		AND	(	rscartera = '111' OR rscartera = '114')
		AND (	rsmonemi <> 999	 AND rsmonemi <> 998 AND rsmonemi  <> 997 AND rsmonemi  <> 13 )
    
		IF @@ERROR<>0
		BEGIN
			SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
			RETURN
		END
		
		-->	Solo si Garantias esta Activado Status = ON
		if @iActivaCicloGarantias = 1
		begin
			DELETE	FROM MDRS
			WHERE	rsfecha   = @dFecprox
			AND	(	rscartera = '159' )
			AND (	rsmonemi <> 999	 AND rsmonemi <> 998 AND rsmonemi  <> 997 AND rsmonemi  <> 13 )

			if @@error<>0
			begin
				select 'NO','No se pudieron eliminar registros de tabla resultado para Garantias'
				return
			end
		end
		-->	Solo si Garantias esta Activado Status = ON
	END

	-->		Garantias
	EXECUTE SP_AGRUPA_TBL_VALORIZACION
	-->		Garantias

	SELECT 'rutcart'		= cprutcart
	,      'tipcart'		= cptipcart
	,      'instser'		= cpinstser
	,      'instcam'		= cpinstser
	,      'mascara'		= cpmascara
	,      'feccomp'		= cpfeccomp
	,      'tircomp'		= cptircomp
	,      'nominal'		= SUM(cpnominal)
	,      'valcomp'		= SUM(cpcapitalc)
	,      'valcomu'		= SUM(cpvalcomu)
	,      'intdia'			= CONVERT(NUMERIC(19,4),0)
	,      'readia'			= CONVERT(NUMERIC(19,4),0)
	,      'interes'		= SUM(cpinteresc)
	,      'reajuste'		= SUM(cpreajustc)
	,      'interesmes'		= SUM(cpintermes)
	,      'reajustemes'	= sum(cpreajumes)
	,      'readifmes'		= CONVERT(NUMERIC(19,4),0)
	,      'seriado'		= cpseriado
	,      'codigo'			= cpcodigo
	,      'valptehoy'		= SUM(cpvptirc)
	,      'valpteman'		= CONVERT(NUMERIC(19,2),0)
	,      'amocup'			= CONVERT(FLOAT,0)
	,      'intcup'			= CONVERT(FLOAT,0)
	,      'reacup'			= CONVERT(FLOAT,0)
	,      'flujo'			= CONVERT(FLOAT,0)
	,      'duration'		= CONVERT(FLOAT,0)
	,      'durmodif'		= CONVERT(FLOAT,0)
	,      'convex'			= CONVERT(FLOAT,0)
	,      'tasa_float'		= CONVERT(FLOAT,0)
	,      'monemi'			= CONVERT(INTEGER,0)
	,      'basemi'			= CONVERT(FLOAT,0)
	,      'tasemi'			= CONVERT(FLOAT,0)
	,      'fecemi'			= cpfecemi
	,      'fecven'			= cpfecven
	,      'cupon'			= CONVERT(INTEGER,0)
	,      'pvpcomp'		= (CASE WHEN LEFT(cpinstser, 4 ) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END)
	,      'numucup'		= CONVERT(FLOAT,0)
	,      'numpcup'		= CONVERT(FLOAT,0)
	,      'fecucup'		= cpfecucup
	,      'fecpcup'		= cpfecpcup
	,      'condpacto'		= CONVERT(CHAR(01),'')
	,      'flag'			= CONVERT(CHAR(01),'N')
	,      'cup'			= CONVERT(FLOAT,0)
	,      'numdocu'		= cpnumdocu
	,      'correla'		= cpcorrela
	,      'PrimaDcto'		= cpprimadesc
	,      'tasaEmis'		= cpvaltasemi
	,      'valordia'		= CONVERT(FLOAT,0)
	,      'valorpar'		= CONVERT(FLOAT,0)
	,      'Moneda_papel'	= CONVERT(CHAR(01),'')
	,      'Decimales'		= CONVERT(INTEGER,0)
	,      'Nreg'			= CONVERT(NUMERIC(10),0)
	,      'FechaLiquida'	= CASE WHEN Fecha_PagoMañana > @dFechoy THEN Fecha_PagoMañana ELSE @dFechoy END
	,      'VentaPM'		= 'N'
	,      'TipoDev'		= CAST( 'DEV' AS CHAR(03) )
	,      'RutEmis'		= CONVERT(NUMERIC(9),0)
	INTO	#TEMPORAL
	FROM	MDCP
	WHERE	cprutcart		> 0
	AND		cpfecven		>= @dFechoy
	GROUP
	BY		cprutcart
	,		cptipcart
	,		cpinstser
	,		cpmascara
	,		cpfeccomp
	,		cptircomp
	,		cpseriado
	,		cpcodigo
	,		cpfecemi
	,		cpfecven
	,		cpfecucup
	,		cpfecpcup
	,		cpnumdocu
	,		cpcorrela
	,		(CASE WHEN LEFT(cpinstser,4) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END)
	,		cpprimadesc
	,		cpvaltasemi
	,		Fecha_PagoMañana

	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
		RETURN
	END

	IF @dFechoy = @dFecpro
	BEGIN
		SELECT	'virutcart'   = virutcart
			,	'vinumdocu'   = vinumdocu
			,	'vicorrela'   = vicorrela
			,	'vinominal'   = SUM(vinominal)
			,	'vivalcomp'   = SUM(vivalcomp)
			,	'vivalcomu'   = SUM(vivalcomu)
			,	'vivptirc'    = SUM(vivptirc)
			,	'viinteresv'  = SUM(viinteresv)		-->	@nreajusto
			,	'vireajustv'  = SUM(vireajustv)
			,	'viintermesv' = SUM(viintermesv)
			,	'vireajumesv' = SUM(vireajumesv)
		INTO	#TMPVI
		FROM	MDVI
		GROUP
		BY		virutcart
		,		vinumdocu
		,		vicorrela

		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede obtener los movimientos VI'
			RETURN
		END

		UPDATE	#TEMPORAL
		SET		nominal     = nominal     + vinominal
		,		valcomp     = valcomp     + vivalcomp
		,		valcomu     = valcomu     + vivalcomu
		,		valptehoy   = valptehoy   + vivptirc
		,		interes     = interes     + viinteresv
		,		reajuste    = reajuste    + vireajustv
		,		interesmes	= interesmes  + viintermesv
		,		reajustemes	= reajustemes + vireajumesv
		FROM	#TMPVI
		WHERE	virutcart   = rutcart
		AND		vinumdocu   = numdocu
		AND		vicorrela   = correla
		AND		TipoDev     = 'DEV'

		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede actualizar los movimientos VI en el devengamiento'
			RETURN
		END

		-->	Solo si Garantias esta Activado Status = ON
		if @iActivaCicloGarantias = 1
		begin
			-->		Garantia
			SELECT	'virutcart'		= 97023000
				,	'vinumdocu'		= val.NumeroDocumento
				,	'vicorrela'		= val.CorrelativoDocumento
				,	'vinominal'		= SUM( val.Nominal )
				,	'vivalcomp'		= SUM( val.ValorCompra )
				,	'vivalcomu'		= SUM( val.ValorCompraUm )
				,	'vivptirc'		= SUM( VAL.ValorProxProceso)		-->	SUM( val.ValorProceso )
				,	'viinteresv'	= SUM( val.Interes_Acum )		-->	SUM( val.InteresCompra )
				,	'vireajustv'	= SUM( val.Reajuste_Acum )		-->	SUM( val.ReajusteCompra )
				,	'viintermesv'	= SUM( val.InteresAcumCp )
				,	'vireajumesv'	= SUM( val.ReajusteAcumCp )
			INTO	#TMPVI_Garantia
			FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
					inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
					inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																								and val.Garantia_Correlativo = det.CorrelativoGarantia
			WHERE	(		enc.TipoMovimiento	= '23'
			and		not (	det.Instrumento		= 'EFECTIVO'	)
					)
			and		det.Nominal					> 0		--> Indica que aun tene Instrumentos Vigenetes en Garantias
			GROUP
			BY		val.Garantia_Numero
				,	val.NumeroDocumento
				,	val.CorrelativoDocumento

			IF @@ERROR <> 0
			BEGIN
				SELECT 'NO', 'No se Puede obtener los movimientos VI'
				RETURN
			END

			UPDATE	#TEMPORAL
			SET		nominal     = nominal     + vinominal
			,		valcomp     = valcomp     + vivalcomp
			,		valcomu     = valcomu     + vivalcomu
			,		valptehoy   = valptehoy   + vivptirc
			,		interes     = interes     + viinteresv
			,		reajuste    = reajuste    + vireajustv
			,		interesmes	= interesmes  + viintermesv
			,		reajustemes	= reajustemes + vireajumesv
			FROM	#TMPVI_Garantia
			WHERE	virutcart   = rutcart
			AND		vinumdocu   = numdocu
			AND		vicorrela   = correla
			AND		TipoDev     = 'DEV'

			IF @@ERROR <> 0
			BEGIN
				SELECT 'NO', 'No se Puede actualizar los movimientos VI en el devengamiento'
				RETURN
			END
			-->	Garantia
		end
		-->	Solo si Garantias esta Activado Status = ON

	END ELSE
    BEGIN
		SELECT	'rscartera'			= rscartera
			,	'rstipopero'		= rstipopero
			,	'rsfecha'			= rsfecha
			,	'rsrutcart'			= rsrutcart
			,	'rsnumdocu'			= rsnumdocu
			,	'rscorrela'			= rscorrela
			,	'rsnominal'			= ISNULL(SUM(rsnominal),0)
			,	'rsvalcomp'			= ISNULL(SUM(rsvalcomp),0)
			,	'rsvalcomu'			= ISNULL(SUM(rsvalcomu),0)
			,	'rsvppresenx'		= SUM(rsvppresenx)
			,	'rsinteres_acum'	= SUM(rsinteres_acum)
			,   'rsreajuste_acum'	= SUM(rsreajuste_acum)
			,   'rsintermes'		= SUM(rsintermes)
			,   'rsreajumes'		= SUM(rsreajumes)
			,   'rstipoper'			= rstipoper
		INTO	#TMPRS_TMP
		FROM	MDRS
		WHERE	rsfecha				= @dFecHoy
		AND		rstipopero			= 'CP'
		AND		rscartera			= '111'
		GROUP
		BY		rscartera
			,	rstipopero
			,	rsfecha
			,	rsrutcart
			,	rsnumdocu
			,	rscorrela
			,	rstipoper

		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede obtener el devengamiento de fin de mes'    
			RETURN
		END

		UPDATE	#TEMPORAL    
		SET		valptehoy   = rsvppresenx
		,		interes     = rsinteres_acum
		,		reajuste    = rsreajuste_acum
		,		interesmes  = rsintermes
		,		reajustemes = rsreajumes
		FROM	#TMPRS_TMP
		WHERE	rsfecha     = @dFecHoy
		AND		rscartera   = '111'
		AND		rstipopero  = 'CP'
		AND		rutcart     = rsrutcart
		AND		numdocu     = rsnumdocu
		AND		correla     = rscorrela
		AND		rsTipOper   = TipoDev
    
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede actualizar el devengamiento de fin de mes'
			RETURN
		END

		INSERT INTO #TMPRS_TMP
		SELECT	'rscartera'       = rscartera
			,	'rstipopero'      = rstipopero
			,	'rsfecha'         = rsfecha
			,	'rsrutcart'       = rsrutcart
			,	'rsnumdocu'       = rsnumdocu
			,	'rscorrela'       = rscorrela
			,	'rsnominal'       = ISNULL(SUM(rsnominal),0)
			,	'rsvalcomp'       = ISNULL(SUM(rsvalcomp),0)
			,	'rsvalcomu'       = ISNULL(SUM(rsvalcomu),0)
			,	'rsvppresenx'     = ISNULL(SUM(rsvppresenx),0)
			,	'rsinteres_acum'  = ISNULL(SUM(rsinteres_acum),0)
			,	'rsreajuste_acum' = ISNULL(SUM(rsreajuste_acum),0)
			,	'rsintermes'      = ISNULL(SUM(rsintermes),0)
			,	'rsreajumes'      = ISNULL(SUM(rsreajumes),0)
			,	'rstipoper'       = rstipoper
		FROM	MDRS    
		WHERE	rsfecha           = @dFecHoy
		AND		rscartera         = '114'
		AND		rstipopero        = 'VI'
		GROUP
		BY		rscartera
			,   rstipopero
			,   rsfecha
			,   rsrutcart
			,   rsnumdocu
			,   rscorrela
			,   rstipoper

		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede obtener el devengamiento de la instrumentos intermediados del fin de mes'
			RETURN
		END

		UPDATE	#TEMPORAL
		SET		nominal     = nominal		+ rsnominal
		,		valcomp     = valcomp		+ rsvalcomp
		,		valcomu     = valcomu		+ rsvalcomu
		,		valptehoy   = valptehoy		+ rsvppresenx
		,		interes     = interes		+ rsinteres_acum
		,		reajuste    = reajuste		+ rsreajuste_acum
		,		interesmes  = interesmes	+ rsintermes
		,		reajustemes	= reajustemes	+ rsreajumes
		FROM	#TMPRS_TMP
		WHERE	rsfecha     = @dFecHoy
		AND		rstipopero  = 'VI'
		AND		rscartera   = '114'
		AND		rutcart     = rsrutcart
		AND		numdocu     = rsnumdocu
		AND		correla		= rscorrela
    
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede actualizar el devengamiento de la instrumentos intermediados del fin de mes'
			RETURN
		END

		-->	Solo si Garantias esta Activado Status = ON
		if @iActivaCicloGarantias = 1
		begin
			-->	Garantias
			INSERT INTO #TMPRS_TMP
			SELECT	'rscartera'       = rscartera
				,	'rstipopero'      = rstipopero
				,	'rsfecha'         = rsfecha
				,	'rsrutcart'       = rsrutcart
				,	'rsnumdocu'       = rsnumdocu
				,	'rscorrela'       = rscorrela
				,	'rsnominal'       = ISNULL(SUM(rsnominal),0)
				,	'rsvalcomp'       = ISNULL(SUM(rsvalcomp),0)
				,	'rsvalcomu'       = ISNULL(SUM(rsvalcomu),0)
				,	'rsvppresenx'     = ISNULL(SUM(rsvppresenx),0)
				,	'rsinteres_acum'  = ISNULL(SUM(rsinteres_acum),0)
				,	'rsreajuste_acum' = ISNULL(SUM(rsreajuste_acum),0)
				,	'rsintermes'      = ISNULL(SUM(rsintermes),0)
				,	'rsreajumes'      = ISNULL(SUM(rsreajumes),0)
				,	'rstipoper'       = rstipoper
			FROM	MDRS    
			WHERE	rsfecha           = @dFecHoy
			AND		rscartera         = '159'
			AND		rstipoper         = 'DEV' -->	AND		rstipopero  = 'DEV'
			GROUP
			BY		rscartera
				,   rstipopero
				,   rsfecha
				,   rsrutcart
				,   rsnumdocu
				,   rscorrela
				,   rstipoper

			IF @@ERROR <> 0
			BEGIN
				SELECT 'NO', 'No se Puede obtener el devengamiento de la instrumentos intermediados del fin de mes'
				RETURN
			END

			UPDATE	#TEMPORAL
			SET		nominal     = nominal		+ rsnominal
			,		valcomp     = valcomp		+ rsvalcomp
			,		valcomu     = valcomu		+ rsvalcomu
			,		valptehoy   = valptehoy		+ rsvppresenx
			,		interes     = interes		+ rsinteres_acum
			,		reajuste    = reajuste		+ rsreajuste_acum
			,		interesmes  = interesmes	+ rsintermes
			,		reajustemes	= reajustemes	+ rsreajumes
			FROM	#TMPRS_TMP
			WHERE	rsfecha     = @dFecHoy
			AND		rscartera   = '159'
			AND		rstipoper   = 'DEV'		-->	AND		rstipopero  = 'DEV'
			AND		rutcart     = rsrutcart
			AND		numdocu     = rsnumdocu
			AND		correla		= rscorrela
	    
			IF @@ERROR <> 0
			BEGIN
				SELECT 'NO', 'No se Puede actualizar el devengamiento de la instrumentos intermediados del fin de mes'
				RETURN
			END
			--> Garantias
		end
		-->	Solo si Garantias esta Activado Status = ON
	END

	DELETE	FROM #TEMPORAL     
	WHERE	nominal <= 0;    

	UPDATE	#TEMPORAL
	SET		monemi		= semonemi
	,		basemi		= sebasemi
	,		tasemi		= setasemi
	,		rutemis		= serutemi
	FROM	VIEW_SERIE
	WHERE	semascara	= Mascara
    AND		seriado		= 'S';

	UPDATE	#TEMPORAL
    SET		tasemi		= nstasemi
	,		monemi		= nsmonemi
	,		basemi		= nsbasemi
	,		fecemi		= nsfecemi
    ,		rutemis		= nsrutemi
	FROM	VIEW_NOSERIE
	WHERE	seriado		= 'N'
	AND		rutcart		= nsrutcart
	AND		numdocu		= nsnumdocu
	AND		correla		= nscorrela;
  
	IF @cDevengo_dolar = 'N'    
	BEGIN    
		DELETE	FROM	#temporal
		WHERE	monemi	<> 999     
		AND		monemi	<> 998     
		AND		monemi	<> 997     
		AND		monemi	<> 13;
	END ELSE    
	BEGIN    
		DELETE	FROM	#temporal
		WHERE	monemi	= 999
		OR		monemi	= 998
		OR		monemi	= 997
		OR		monemi	= 13;
	END

	SELECT	*
		,	'nRegi'	= IDENTITY(NUMERIC(10))
	INTO	#TEMPORAL22
	FROM	#TEMPORAL

	DELETE	FROM #TEMPORAL

	INSERT	INTO #TEMPORAL
	SELECT  rutcart,    tipcart,     instser,   instcam,   mascara,  feccomp,   tircomp,   nominal,      valcomp,   valcomu, intdia,  readia,   interes,   reajuste
        ,   interesmes, reajustemes, readifmes, seriado,   codigo,   valptehoy, valpteman, amocup,       intcup,    reacup,  flujo,   duration, durmodif,  convex
        ,   tasa_float, monemi,      basemi,    tasemi,    fecemi,   fecven,    cupon,     pvpcomp,      numucup,   numpcup, fecucup, fecpcup,  condpacto, flag
        ,   cup,        numdocu,     correla,   PrimaDcto, tasaEmis, valordia,  valorpar,  Moneda_papel, Decimales, nRegi,   FechaLiquida, VentaPM, TipoDev, rutemis
	FROM	#TEMPORAL22
    ORDER
	BY		nRegi

	SET		@iX			= 0;    
    SET		@nContador	= (SELECT MAX(Nreg) FROM #TEMPORAL);

	WHILE @iX <= @nContador    
	BEGIN    
		SET @iX			= @iX + 1;
		SET	@cInstser	= '*';

		SELECT	@nRutcart			= rutcart
		,		@nTipcart			= tipcart
		,		@cInstser			= instser
		,		@cInstcam			= instser
		,		@fNominal			= nominal
		,		@fTir				= tircomp
		,		@iCodigo			= codigo
		,		@dFecemi			= fecemi
		,		@dFecven			= fecven
		,		@fTasest			= tasa_float
		,		@nValcomp			= valcomp
		,		@fValcomu			= valcomu
		,		@nVpresen			= valptehoy
		,		@nIntMes			= interesmes
		,		@nReaMes			= reajustemes
		,		@nInteres			= interes
		,		@nReajuste			= reajuste
		,		@fPvp				= pvpcomp
		,		@fMt				= 0.0
		,		@fMtum				= 0.0
		,		@fMt_cien			= 0.0
		,		@fVan				= 0.0
		,		@fVpar				= 0.0
		,		@nNumucup			= 0
		,		@dFecucup			= ISNULL(fecucup,'')
		,		@fIntucup			= 0.0
		,		@fAmoucup			= 0.0
		,		@fSalucup			= 0.0
		,		@nNumpcup			= 0
		,		@dFecpcup			= ISNULL(fecpcup,'')
		,		@fIntpcup			= 0.0
		,		@fAmopcup			= 0.0
		,		@fSalpcup			= 0.0
		,		@iAst				= 0
		,		@iPago_NoHabil		= 0
		,		@cSeriado			= seriado
		,		@cMascara			= mascara
		,		@dFeccomp			= feccomp
		,		@cProg				= 'SP_' + inprog
		,		@fDurat				= 0.0
		,		@fConvx				= 0.0
		,		@fDurmo				= 0.0
		,		@fValmon_Hoy		= 1.0
		,		@fValmon_Man		= 1.0
		,		@fValmon_Com		= 1.0
		,		@fValmon_Cup		= 1.0
		,		@iMonemi			= monemi
		,		@fTasemi			= tasemi
		,		@fBasemi			= basemi
		,		@dFecemi			= fecemi
		,		@frutemis			= rutemis
		,		@fTasest			= 0.0
		,		@nError				= 0
		,		@iCupon				= 0
		,		@fTasaFloat			= 0.0
		,		@iModcal			= 2
		,		@fAmocupo			= 0.0
		,		@fIntcupo			= 0.0
		,		@nReacup			= 0.0
		,		@nDifReaCup			= 0.0
		,		@nPagcup			= 0.0
		,		@fAmocupo			= 0.0
		,		@fValcupo			= 0.0
		,		@nIntcup			= 0.0
		,		@nReacup			= 0.0
		,		@nPagcup			= 0.0
		,		@nIntdia			= 0.0
		,		@nReadia			= 0.0
		,		@fMonto				= 0.0
		,		@nIntdif			= 0.0
		,		@nNumdocu			= numdocu
		,		@nCorrela			= correla
		,		@nPrimaDctoDia		= 0
		,		@nValoraTasaEmi		= tasaEmis
		,		@nPrimaDctoTot		= PrimaDcto
		,		@valorpar_lchr		= 0
		,		@dFechaLiquida		= FechaLiquida
		,		@nValPste_Pagomañana= valptehoy
		FROM	#TEMPORAL
		,		VIEW_INSTRUMENTO
		WHERE	codigo             = incodigo
		AND		Nreg               = @iX;

		IF @cInstser = '*'
		BEGIN
			BREAK
		END

		SELECT	@cTipo_Moneda_papel = CASE	WHEN mnmx = 'C' THEN '0' ELSE '1' END
			,	@nDecimal           = mndecimal
		FROM	VIEW_MONEDA
		WHERE	mncodmon			= @iMonemi

		--> Inicio LH1
		--> Se revisa si las Letras vienen con un o mas Cupon(es) Cortado(s) tanto las de Vivienda como las de Fines Generales    
		IF (@dFecprox >= @dFecpcup AND @dFecpcup > @dFechoy) AND @iCodigo = 20 AND (CHARINDEX('*',@cInstser) <> 0 OR CHARINDEX('&',@cInstser) <> 0)
		BEGIN
			SET @iAst = 1
			IF CHARINDEX('*',@cInstser) <> 0 --** (*) **--
			BEGIN
				IF SUBSTRING(@cInstser,7,2)='**'
					SET @cInstser = SUBSTRING(@cInstser,1,6)+' *'+SUBSTRING(@cInstser,9,2)
				ELSE
					SET @cInstser = SUBSTRING(@cInstser,1,6)+'01'+SUBSTRING(@cInstser,9,2)
			END

			IF CHARINDEX('&',@cInstser)<>0 --** (&) **--    
			BEGIN    
				IF SUBSTRING(@cInstser,7,2)='&&'    
					SET @cInstser = SUBSTRING(@cInstser,1,6)+' &'+SUBSTRING(@cInstser,9,2)    
				ELSE
				BEGIN
					SET @nMes   = CONVERT(INTEGER,SUBSTRING(@cInstser,9,2))
					SET @nMes_a = DATEPART(MONTH,@dFechoy)

					IF @nMes>@nMes_a
						SET @nAno	= DATEPART(YEAR,@dFechoy) - 1
					ELSE
						SET @nAno	= DATEPART(YEAR,@dFechoy)

					SET @cAno		= CONVERT(CHAR,@nAno)
					SET @cInstser	= SUBSTRING(@cInstser,1,6)+SUBSTRING(@cInstser,9,2)+SUBSTRING(@cAno,3,2)
				END
			END
		END

		--> Fin Revision LH1    
		--> Inicio BR1     
		--> Datos unicamente para los Bonos de reconocimientos    
		IF @iCodigo = 888
		BEGIN
			SET @fIpc_pr = 0
			SET @fIpc_in = 0
			SET @fIpc_cp = 0
			SET @dFec_cp = @dFeccomp - DATEPART(DAY,@dFeccomp) 
			SET @dFec_cp = @dFec_cp  - DATEPART(DAY,@dFec_cp) + 1 --** Fecha Emisi¢n BR **--    
			SET @dFec_in = @dFechoy  - DATEPART(DAY,@dFechoy)    
			SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in)    
			SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in) + 1 --** Fecha Dev.2 meses atras Ant    
			SET @dFec_pr = @dFechoy  - DATEPART(DAY,@dFechoy)    
			SET @dFec_pr = @dFec_pr  - DATEPART(DAY,@dFec_pr) + 1 --** Fecha Dev.1 mes atras    
			SET @fIpc_cp = 1    
			SET @fIpc_in = 0    
			SET @fIpc_pr = 0    
			SET @fIpc_cp = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_cp)    
			SET @fIpc_in = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_in)    
			SET @fIpc_pr = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_pr)    
		END
		--> Fin BR1

		IF @cProg<>'SP_'
		BEGIN
			IF @iMonemi<>999
			BEGIN
				--> Se debe incorporar el tema de los BCAPS-F <---  
				IF LEFT( @cInstser, 7 ) = 'BCAPS-F'   
				BEGIN       
					SET @fValmon_Hoy = (SELECT tipo_cambio FROM bacparamsuda.dbo.valor_moneda_contable WHERE Codigo_Moneda = @iMonemi AND fecha = @dFechaAnterior)
                    SET @fValmon_Man = (SELECT tipo_cambio FROM bacparamsuda.dbo.valor_moneda_contable WHERE Codigo_Moneda = @iMonemi AND fecha = @dFechoy)
				END ELSE   
				BEGIN  
					SET @fValmon_Hoy = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFechoy)
					SET @fValmon_Man = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecprox)
				END

				SET @fTasest	=	CASE	WHEN @iCodigo = 1 THEN	@fTe_pcdus
											WHEN @iCodigo = 2 THEN	@fTe_pcduf
											WHEN @iCodigo = 5 THEN	@fTe_ptf
											ELSE					CONVERT(FLOAT,0)
										END
			END

			SET @dFeccal = @dFecprox

			IF @dFecven < @dFecprox
				SET @dFeccal = @dFecven

			IF @frutemis = @nRutBanco AND @iCodigo = 20
			BEGIN
				SET @fVparDEV = 0.0;

				EXECUTE @nError = @cProg @iModcal, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest    
								, @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT    
								, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT    
								, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT     

				SET @fVparDEV	= ROUND( @fVpar, 8)
				SET @fMt		= ROUND((@fNominal * (@fVparDEV / 100.0)) *  @fValmon_Man, 0)
			END ELSE    
				EXECUTE @nError = @cProg @iModcal, @dFeccal,@iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest    
								, @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT    
								, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT    
								, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT    

			IF LEFT( @cInstser, 7 ) = 'BCAPS-F'
				SET @fmt= ROUND(@fMTUM * @fValmon_Man,0)

			IF @iMonemi <> 999 AND @iMonemi <> 13
			BEGIN
				--> El cupon para los BCAPS-F se paga a Observado
				SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
				SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
			END    

			IF (@dFecprox >= @dFecucup AND @dFechoy < @dFecucup) AND @iAst = 0 AND @dFechaLiquida = @dFechoy    
			BEGIN
				SET @iCupon    = 1 ;    

				IF @iMonemi <> 999 AND @iMonemi<>13    
				BEGIN
					SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup    
					SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp    
				END

				IF @cSeriado = 'S'    
				BEGIN
					IF @dFecucup > @dFechoy AND @dFecucup < @dFecprox  
						SET @iPago_Nohabil = 1

					SET @fIntucup =      ((@fIntucup * @fNominal) / CONVERT(FLOAT,100))    
					SET @fAmoucup =      ((@fAmoucup * @fNominal) / CONVERT(FLOAT,100))    
					SET @fIntcupo = ROUND( @fIntucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms    
					SET @fAmocupo = ROUND( @fAmoucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms    
					SET @nPagcup  = ROUND((@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms    

					IF @dFecucup <> @dFecprox    
						SET @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms    
					ELSE    
						SET @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms    

					SET @fValcupo = @fIntcupo + @fAmocupo    
				END
			END
      
			IF @dFechaLiquida > @dFechoy
			BEGIN
				SET @fMt       = @nValPste_Pagomañana
				SET @nVpresen  = @nValPste_Pagomañana
				SET @nReadia   = 0
			END ELSE
				SET @nReadia   = ROUND((@fValmon_Man - @fValmon_Hoy) * @fValcomu, 0)

			IF @iMonemi=800 OR @iMonemi=801 --> Documentos emitidos en ICP o ICP real no Generan Reajustes
			BEGIN
				SET @nReadia   = 0
			END

			IF @iCodigo=888
			BEGIN
				SELECT @fIpc_cp = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
				IF @fIpc_cp = 0
				BEGIN
					SELECT @fIpc_cp = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
				END

				SELECT @dFec_in = DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))    
				SELECT @fIpc_in = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_in),0)    
				SELECT @dFec_pr = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))    
				SELECT @fIpc_pr = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_pr),0)    
				SELECT @nReadia = 0    

				IF @fIpc_pr <> 0 AND @fIpc_pr <> @fIpc_in
				BEGIN
					IF @dFechaLiquida > @dFechoy
						SET @nReadia = 0
					ELSE
						SET @nReadia = ROUND(( @fIpc_pr - @fIpc_in ) * ROUND(@nValcomp/@fIpc_cp, CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END),  (CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END) )
				END ELSE
				BEGIN    
					SET @nReadia = 0
				END
				IF @dFecven < @dFecprox
					SET @iCupon = 1
			END

			IF @iCodigo = 888 AND @fIpc_mes <> @fIpc_hoy AND @dFeccomp < @dFechoy
			BEGIN
				IF @dFechaLiquida > @dFechoy
					SET @nIntdia = 0
				ELSE
					SET @nIntdia = @fMt - @nVpresen - @nReadia

				SET @nInteres   = @nInteres  + @nIntdia
				SET @nReajuste  = @nReajuste + @nReadia
			END ELSE
			BEGIN
				IF @iCodigo = 888
					SET @nReadia = 0

				IF @dFechaLiquida > @dFechoy
					SET @nIntdia = 0
				ELSE
					SET @nIntdia = ROUND(@fMt - @nVpresen - @nReadia + @nPagcup,CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END)

				SET @nInteres   = @nInteres  + @nIntdia
				SET @nReajuste  = @nReajuste + @nReadia
			END
      
			IF DATEPART(MONTH,@dFechoy)<>DATEPART(MONTH,@dFecprox)
			BEGIN
				SET @nIntMes = 0.0
				SET @nReaMes = 0.0
			END

			SET @nIntMes = @nIntMes + @nIntdia
			SET @nReaMes = @nReaMes + @nReadia
       
			--** Capitalizacion **--    
			IF @dFecucup > @dFechoy AND @dFecucup < @dFecprox
			BEGIN
				IF isnull(@fValmon_Cup,0) = 0
					SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecprox
			END
    
			IF @iCupon = 1
			BEGIN
				IF @cSeriado = 'S'
				BEGIN
					SET @nInteres_RealCup = @nInteres     

					IF @iPago_NoHabil = 1
					BEGIN
						SET @nIntPordia       = @nIntdia  / DATEDIFF(DAY,@dFechoy,@dFecprox)
						SET @nInteres_RealCup = @nInteres - @nIntdia + (@nIntPordia * DATEDIFF(DAY,@dFechoy,@dFecucup) )
					END

					SET @fFactor     = (((@fIntucup * @fValmon_Cup) - @nInteres_RealCup) / ISNULL(@fValmon_Cup,1))
					SET @fCapital_UM = @fAmoucup + @fFactor
					SET @fCapital    = ROUND( @fCapital_UM * @fValmon_Com, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)
					SET @nReacup     = ROUND((@fValmon_Cup - @fValmon_Com) * @fCapital_UM, 0)
					SET @nIntcup     = @nInteres_RealCup

					SET @nDifcup     = @nPagcup  - (@fCapital + @nReacup + @nIntcup)    
					SET @fCapital    = @fCapital + @nDifcup    
					SET @nReacup     = @nReacup  + ROUND((@fValmon_Man-@fValmon_Cup) * @fCapital_UM, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)    
					SET @nIntcup     = @nPagcup  - @fCapital - @nReacup    
					SET @fAmocupo    = @fCapital    
					SET @nDifReaCup  = @nPagcupo - (@fAmocupo + @nIntcup + @nReacup)    
					SET @nPagcup     = @nPagcupo    
				END ELSE
				BEGIN
					SET @fAmocupo    = @nValcomp
					SET @fValcupo    = @nValcomp + @nInteres + @nReajuste
					SET @nIntcup     = @nInteres
					SET @nReacup     = @nReajuste
					SET @nPagcup     = @fValcupo
				END
			END
		END

		IF @iCupon=1 AND @cSeriado = 'S'
		BEGIN
			SET @nReajuste = @nReajuste - @nReacup
			SET @nValcomp  = ISNULL(@nValcomp - ISNULL(@fCapital,1),1)
			SET @fValcomu  = ROUND(@nValcomp / ISNULL(@fValmon_com,1) ,4 )
			SET @nInteres  = @nInteres  - @nIntcup
		END

		IF @frutemis = @nRutBanco AND @iCodigo = 20
		BEGIN
			SET @nPrimaDctoDia = ROUND(@nPrimaDctoTot / DATEDIFF(day, @dFeccomp, @dFecven),0)    
		END

		UPDATE	#TEMPORAL
		SET		instser			= @cInstcam
		,		instcam			= @cInstser
		,		valcomp			= @nValcomp
		,		valcomu			= @fValcomu
		,		intdia			= @nIntdia
		,		readia			= @nReadia
		,		interesmes		= @nIntMes
		,		reajustemes		= @nReaMes
		,		interes			= @nInteres
		,		reajuste		= @nReajuste
		,		readifmes		= @nDifReaCup
		,		valptehoy		= @nVpresen
		,		valpteman		= @fMt
		,		amocup			= @fAmocupo
		,		intcup			= @nIntcup
		,		reacup			= @nReacup
		,		flujo			= @nPagcup
		,		duration		= @fDurat
		,		durmodif		= @fDurmo
		,		convex			= @fConvx
		,		tasa_float		= @fTasaFloat
		,		tasemi			= @fTasemi
		,		monemi			= @iMonemi
		,		basemi			= @fBasemi
		,		cupon			= @iCupon
		,		pvpcomp			= @fPvp
		,		numucup			= @nNumucup
		,		numpcup			= @nNumpcup
		,		fecucup			= @dFecucup
		,		fecpcup			= @dFecpcup
		,		flag			= 'S'
		,		cup				= @fIntpcup + @fAmopcup
		,		PrimaDcto		= @nPrimaDctoTot
		,		tasaEmis		= @nValoraTasaEmi
		,		valordia		= @nPrimaDctoDia
		,		valorpar		= @fVpar
		,		Moneda_papel	= @cTipo_moneda_papel
		,		Decimales		= @nDecimal
		WHERE	@nRutcart		= rutcart
		AND		@nNumdocu		= numdocu
		AND		@nCorrela		= correla
		AND		Nreg			= @iX
	
		IF @@ERROR<>0
		BEGIN
			SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
			RETURN
		END
	END
	

	INSERT INTO MDRS
	(		rsfecha
	,		rsrutcart
	,		rstipcart
	,		rsnumdocu
	,		rscorrela
	,		rsnumoper
	,		rscartera
	,		rstipoper
	,		rsinstser
	,		rsrutcli
	,		rscodcli
	,		rsvppresen
	,		rsvppresenx
	,		rscupamo
	,		rscupint
	,		rscuprea
	,		rsflujo
	,		rsfecprox
	,		rsfecctb
	,		rsnominal
	,		rstir
	,		rstasfloat
	,		rsmonpact
	,		rsmonemi
	,		rstasemi
	,		rsbasemi
	,		rscodigo
	,		rsinteres
	,		rsreajuste
	,		rsintermes
	,		rsreajumes
	,		rsinteres_acum
	,		rsreajuste_acum
	,		rsforpagv
	,		rsvalcomp
	,		rsvalcomu
	,		rsvalvenc
	,		rsdurat
	,		rsdurmod
	,		rsconvex
	,		rsnumucup
	,		rsnumpcup
	,		rsfecucup
	,		rsfecpcup
	,		rsvpcomp
	,		rstipopero
	,		rsfeccomp
	,		rsdifrea
	,		rsinstcam
	,		rsfecinip
	,		rsfecvtop
	,		rsvalvtop
	,		rsrutemis
	,		rsvalinip
	,		rstaspact
	,		rsmascara
	,		rsfecemis
	,		rsfecvcto
	,		rstipoletra
	,		rsvalcompcp
	,		rsvalcomucp
	,		rsinterescp
	,		rsreajustecp
	,		rsinteres_acumcp
	,		rsreajuste_acumcp
	,		MDRS.codigo_carterasuper
	,		prima_descuento_dia
	,		prima_descuento_total
	,		valor_tasa_emision
	,		valor_par
	,		rsforpagi
	,		rsid_libro
	)
	SELECT	@dFecprox
	,		cprutcart
	,		cptipcart
	,		cpnumdocu
	,		cpcorrela
	,		cpnumdocu
	,		'111'
	,		'DEV'
	,		cpinstser
	,		cprutcli
	,		cpcodcli
	,		isnull(cpvptirc,0)
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		@dFecprox
	,		@dFechoy
	,		cpnominal
	,		cptircomp
	,		0.0
	,		mncodmon
	,		mncodmon
	,		0.0
	,		0.0
	,		cpcodigo
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0
	,		cpvalcomp
	,		cpvalcomu
	,		0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		''
	,		''
	,		0.0
	,		'CP'
	,		cpfeccomp
	,		0.0
	,		''
	,		''
	,		''
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		cpmascara
	,		cpfecemi
	,		cpfecven
	,		cptipoletra
	,		cpvalcomp
	,		cpvalcomu
	,		0
	,		0
	,		cpinteresc
	,		cpreajustc
	,		MDCP.codigo_carterasuper
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0
	,		MDCP.id_libro
	FROM	MDCP
			INNER JOIN MDDI ON dirutcart = cprutcart AND dinumdocu = cpnumdocu AND dicorrela = cpcorrela
	,		VIEW_MONEDA    
	WHERE	cpnominal > 0
	AND		dinemmon  = mnnemo
	AND		CHARINDEX(STR(mncodmon,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999- 13' ELSE '988-994-995-800-801' END) > 0

    
	IF @@ERROR<>0
	BEGIN
		SELECT 'NO','Problemas al Insertar Operaciones CP al MDRS'
		RETURN
	END

	--Z >
	INSERT	INTO MDRS
	(		rsfecha
	,		rsrutcart
	,		rstipcart
	,		rsnumdocu
	,		rscorrela
	,		rsnumoper
	,		rscartera
	,		rstipoper
	,		rsinstser
	,		rsrutcli
	,		rscodcli
	,		rsvppresen
	,		rsvppresenx
	,		rscupamo
	,		rscupint
	,		rscuprea
	,		rsflujo
	,		rsfecprox
	,		rsfecctb
	,		rsnominal
	,		rstir
	,		rstasfloat
	,		rsmonpact
	,		rsmonemi
	,		rstasemi
	,		rsbasemi
	,		rscodigo
	,		rsinteres
	,		rsreajuste
	,		rsintermes
	,		rsreajumes
	,		rsinteres_acum
	,		rsreajuste_acum
	,		rsforpagv
	,		rsvalcomp
	,		rsvalcomu
	,		rsvalvenc
	,		rsdurat
	,		rsdurmod
	,		rsconvex
	,		rsnumucup
	,		rsnumpcup
	,		rsfecucup
	,		rsfecpcup
	,		rsvpcomp
	,		rstipopero
	,		rsfeccomp
	,		rsdifrea
	,		rsinstcam
	,		rsfecinip
	,		rsfecvtop
	,		rsvalvtop
	,		rsrutemis
	,		rsvalinip
	,		rstaspact
	,		rsmascara
	,		rsfecemis
	,		rsfecvcto
	,		rsvalcompcp
	,		rsvalcomucp
	,		rsinterescp
	,		rsreajustecp
	,		rsinteres_acumcp
	,		rsreajuste_acumcp
	,		MDRS.codigo_carterasuper
	,		prima_descuento_dia
	,		prima_descuento_total
	,		valor_tasa_emision
	,		valor_par
	,		rsforpagi
	,		rsid_libro
	)
	SELECT	@dFecprox
	,		virutcart
	,		cptipcart
	,		vinumdocu
	,		vicorrela
	,		vinumoper
	,		'114'
	,		'DEV'
	,		viinstser
	,		virutcli
	,		vicodcli
	,		ISNULL(vivptirc,0)
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		@dFecprox
	,		@dFechoy
	,		vinominal
	,		vitircomp
	,		0.0
	,		vimonpact
	,		vimonemi
	,		0.0
	,		0.0
	,		vicodigo
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0
	,		vivalcomp
	,		vivalcomu
	,		0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		''
	,		''
	,		0.0
	,		'VI'
	,		vifeccomp
	,		0.0
	,		''
	,		vifecinip
	,		vifecvenp
	,		vivalvenp
	,		virutemi
	,		vivalinip
	,		0.0
	,		vimascara
	,		vifecemi
	,		vifecven
	,		vivalcomp
	,		vivalcomu
	,		0
	,		0
	,		viinteresv
	,		vireajustv
	,		MDVI.codigo_carterasuper
	,		0.0
	,		0.0
	,		0.0
	,		0.0
	,		0
	,		mdvi.id_libro
	FROM	MDVI
			INNER JOIN MDCP ON cpnumdocu = vinumdocu AND cpcorrela = vicorrela
	WHERE	vitipoper = 'CP'     
	AND		CHARINDEX(STR(vimonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999- 13' ELSE '988-994-995-800-801' END) > 0
    		
	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO','Problemas al Insertar Operaciones IN al MDRS'
		RETURN
	END

	-->	Solo si Garantias esta Activado Status = ON
	if @iActivaCicloGarantias = 1
	begin
		-->		Garantia
		INSERT INTO MDRS
		(		rsfecha
		,		rsrutcart
		,		rstipcart
		,		rsnumdocu
		,		rscorrela
		,		rsnumoper
		,		rscartera
		,		rstipoper
		,		rsinstser
		,		rsrutcli
		,		rscodcli
		,		rsvppresen
		,		rsvppresenx
		,		rscupamo
		,		rscupint
		,		rscuprea
		,		rsflujo
		,		rsfecprox
		,		rsfecctb
		,		rsnominal
		,		rstir
		,		rstasfloat
		,		rsmonpact
		,		rsmonemi
		,		rstasemi
		,		rsbasemi
		,		rscodigo
		,		rsinteres
		,		rsreajuste
		,		rsintermes
		,		rsreajumes
		,		rsinteres_acum
		,		rsreajuste_acum
		,		rsforpagv
		,		rsvalcomp
		,		rsvalcomu
		,		rsvalvenc
		,		rsdurat
		,		rsdurmod
		,		rsconvex
		,		rsnumucup
		,		rsnumpcup
		,		rsfecucup
		,		rsfecpcup
		,		rsvpcomp
		,		rstipopero
		,		rsfeccomp
		,		rsdifrea
		,		rsinstcam
		,		rsfecinip
		,		rsfecvtop
		,		rsvalvtop
		,		rsrutemis
		,		rsvalinip
		,		rstaspact
		,		rsmascara
		,		rsfecemis
		,		rsfecvcto
		,		rstipoletra
		,		rsvalcompcp
		,		rsvalcomucp
		,		rsinterescp
		,		rsreajustecp
		,		rsinteres_acumcp
		,		rsreajuste_acumcp
		,		MDRS.codigo_carterasuper
		,		prima_descuento_dia
		,		prima_descuento_total
		,		valor_tasa_emision
		,		valor_par
		,		rsforpagi
		,		rsid_libro
		)

		SELECT	rsfecha						= @dFecprox
		,		rsrutcart					= MDCP.cprutcart
		,		rstipcart					= MDCP.cptipcart
		,		rsnumdocu					= MDCP.cpnumdocu
		,		rscorrela					= MDCP.cpcorrela
		,		rsnumoper					= Gar.NumeroGarantia
		,		rscartera					= '159'
		,		rstipoper					= 'DEV'
		,		rsinstser					= MDCP.cpinstser
		,		rsrutcli					= Gar.RutCliente		-->	0
		,		rscodcli					= Gar.CodCliente		-->	0
		,		rsvppresen					= isnull(Gar.ValorPresente,0)	-->  isnull(cpvptirc,0)
		,		rsvppresenx					= 0.0
		,		rscupamo					= 0.0
		,		rscupint					= 0.0
		,		rscuprea					= 0.0
		,		rsflujo						= 0.0
		,		rsfecprox					= @dFecprox
		,		rsfecctb					= @dFechoy
		,		rsnominal					= Gar.Nominal					-->	cpnominal
		,		rstir						= MDCP.cptircomp
		,		rstasfloat					= 0.0
		,		rsmonpact					= Mon.mncodmon
		,		rsmonemi					= Mon.mncodmon
		,		rstasemi					= 0.0
		,		rsbasemi					= 0.0
		,		rscodigo					= MDCP.cpcodigo
		,		rsinteres					= 0.0
		,		rsreajuste					= 0.0
		,		rsintermes					= 0.0
		,		rsreajumes					= 0.0
		,		rsinteres_acum				= 0.0
		,		rsreajuste_acum				= 0.0
		,		rsforpagv					= 0
		,		rsvalcomp					= Gar.Valor_Compra		-->	cpvalcomp
		,		rsvalcomu					= Gar.Valor_Compra_Um	--> cpvalcomu
		,		rsvalvenc					= 0
		,		rsdurat						= 0.0
		,		rsdurmod					= 0.0
		,		rsconvex					= 0.0
		,		rsnumucup					= 0.0
		,		rsnumpcup					= 0.0
		,		rsfecucup					= ''
		,		rsfecpcup					= ''	
		,		rsvpcomp					= 0.0
		,		rstipopero					= 'CP'
		,		rsfeccomp					= MDCP.cpfeccomp
		,		rsdifrea					= 0.0
		,		rsinstcam					= ''
		,		rsfecinip					= ''
		,		rsfecvtop					= ''
		,		rsvalvtop					= 0.0
		,		rsrutemis					= 0.0
		,		rsvalinip					= 0.0
		,		rstaspact					= 0.0
		,		rsmascara					= MDCP.cpmascara
		,		rsfecemis					= MDCP.cpfecemi
		,		rsfecvcto					= MDCP.cpfecven
		,		rstipoletra					= MDCP.cptipoletra
		,		rsvalcompcp					= Gar.Valor_Compra			-->	cpvalcomp
		,		rsvalcomucp					= Gar.Valor_Compra_Um		--> cpvalcomu
		,		rsinterescp					= 0
		,		rsreajustecp				= 0
		,		rsinteres_acumcp			= Gar.Interes_Acum			-->	cpinteresc
		,		rsreajuste_acumcp			= Gar.Reajuste_Acum			--> cpreajustc
		,		codigo_carterasuper			= MDCP.codigo_carterasuper
		,		prima_descuento_dia			= 0.0
		,		prima_descuento_total		= 0.0
		,		valor_tasa_emision			= 0.0
		,		valor_par					= 0.0
		,		rsforpagi					= 0
		,		rsid_libro					= MDCP.id_libro
		FROM	MDCP MDCP with(nolock)
				inner join MDDI MDDI with(nolock)	On	MDDI.dirutcart = MDCP.cprutcart 
													AND MDDI.dinumdocu = MDCP.cpnumdocu 
													AND MDDI.dicorrela = MDCP.cpcorrela

				inner join	(	SELECT	NumDocuBac		= val.NumeroDocumento
									,	CorrelaBac		= val.CorrelativoDocumento
									,	ValorPresente	= val.ValorProxProceso	--	ValorProceso
									,	Nominal			= val.Nominal
									,	Valor_Compra	= val.ValorCompra
									,	Valor_Compra_Um	= val.ValorCompraUm
									,	Interes_Dia		= val.InteresCompra
									,	Reajuste_Dia	= val.ReajusteCompra
									,	NumeroGarantia	= val.Garantia_Numero
								--	,	CorrelaGarantia	= val.Garantia_Correlativo
									,	Interes_Acum	= val.Interes_Acum
									,	Reajuste_Acum	= val.Reajuste_Acum
									,	RutCliente		= enc.RutCliente
									,	CodCliente		= enc.CodigoCliente
								FROM	bdbomesa.Garantia.TBL_CarteraGarantia				enc	with(nolock)
										inner join Tbl_Valorizacion_Instrumento_Agrupada	val with(nolock) On val.Garantia_Numero	= enc.NumeroGarantia

							)	Gar		On	Gar.NumDocuBac	= MDCP.cpnumdocu
										and Gar.CorrelaBac	= MDCP.cpcorrela

			/*	inner join (	SELECT	NumDocuBac		= val.NumeroDocumento
									,	CorrelaBac		= val.CorrelativoDocumento
									,	ValorPresente	= val.ValorProxProceso	--	ValorProceso
									,	Nominal			= val.Nominal
									,	Valor_Compra	= val.ValorCompra
									,	Valor_Compra_Um	= val.ValorCompraUm
									,	Interes_Dia		= val.InteresCompra
									,	Reajuste_Dia	= val.ReajusteCompra
									,	NumeroGarantia	= val.Garantia_Numero
									,	CorrelaGarantia	= val.Garantia_Correlativo
									,	Interes_Acum	= val.Interes_Acum
									,	Reajuste_Acum	= val.Reajuste_Acum
									,	RutCliente		= enc.RutCliente
									,	CodCliente		= enc.CodigoCliente
								FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
										inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
										inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																													and val.Garantia_Correlativo = det.CorrelativoGarantia
								WHERE	(		enc.TipoMovimiento	= '23'
								and		not (	det.Instrumento		= 'EFECTIVO'	)
										)
								and		det.Nominal					> 0		--> Indica que aun tene Instrumentos Vigenetes en Garantias

							)	Gar		On	Gar.NumDocuBac	= MDCP.cpnumdocu
										and Gar.CorrelaBac	= MDCP.cpcorrela
			*/

			,	BacParamSuda.dbo.Moneda Mon with(nolock)
		WHERE	MDDI.dinemmon  = Mon.mnnemo
		AND		CHARINDEX(STR(Mon.mncodmon,3),CASE WHEN @cDevengo_dolar = 'N' THEN '997-998-999- 13' ELSE '988-994-995-800-801' END) > 0
		-->		Garantia
	end
	-->	Solo si Garantias esta Activado Status = ON

	UPDATE #TEMPORAL
	SET		intdia      = 0
	,		readia      = 0
	,		interes     = 0
	,		reajuste    = 0
	,		interesmes  = 0
	,		reajustemes = 0
	WHERE	mascara		= 'FMUTUO'


	UPDATE	MDRS
	SET		rsinstser				= instser
	,		rsinstcam				= instcam

	,		rsvppresen				= CASE	WHEN rsmonemi = 13 THEN ROUND(valptehoy * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(valptehoy * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)    
										END

	,		rsvppresenx				= CASE	WHEN rsmonemi = 13 THEN ROUND(valpteman * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(valpteman * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)    
										END
	,		rscupamo				= CASE	WHEN rsmonemi = 13 THEN ROUND(amocup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(amocup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
										END    
	,		rscupint				= CASE  WHEN rsmonemi = 13 THEN ROUND(intcup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(intcup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
										END    
	,		rscuprea				= CASE	WHEN rsmonemi = 13 THEN ROUND(reacup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(reacup    * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
										END
	,		rsflujo					= CASE	WHEN rsmonemi = 13 THEN ROUND(flujo     * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(flujo     * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
										END
	,		rstasfloat				= tasa_float
	,		rstasemi				= ISNULL(tasemi, 0.0)
	,		rsbasemi				= ISNULL(basemi, 0.0)
	,		rsinteres				= CASE	WHEN rsmonemi = 13 THEN ROUND(intdia  *(rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE					ROUND(intdia  *(rsnominal/nominal),0)
										END
	,		rsreajuste				= ROUND(readia * (rsnominal/nominal),0)
	,		rsintermes				= CASE  WHEN rsmonemi = 13 THEN ISNULL( ROUND(interesmes * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)    
											ELSE							ROUND(interesmes * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
										END
	,		rsreajumes				= ISNULL( ROUND(reajustemes *(rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
	,		rsinteres_acum			= CASE	WHEN rsmonemi = 13 THEN ISNULL( ROUND(interes * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
											ELSE					ISNULL( ROUND(interes * (rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
										END    
	,		rsreajuste_acum			= ISNULL(ROUND(reajuste *(rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
	,		rsforpagv				= 0.0
	,		rsvalcomp				= CASE	WHEN rscodigo  = 13 AND cupon = 1 THEN	ROUND(valcomp *(rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											WHEN rscodigo <> 13 AND cupon = 1 THEN	ROUND(valcomp *(rsnominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
											ELSE									rsvalcomp
										END
	,		rsvalcomu				= CASE	WHEN rscodigo =  13  AND cupon = 1	THEN ROUND(valcomu *(rsnominal/nominal),2)
											WHEN monemi	  =  999 AND cupon = 1	THEN ROUND(valcomu *(rsnominal/nominal),0)
											WHEN monemi   <> 999 AND cupon = 1	THEN ROUND(valcomu *(rsnominal/nominal),4)
											ELSE									ISNULL(rsvalcomu,1)
										END
	,		rsdurat					= duration
	,		rsdurmod				= durmodif
	,		rsconvex				= convex
	,		rsnumucup				= numucup
	,		rsnumpcup				= numpcup
	,		rsfecucup				= fecucup
	,		rsfecpcup				= fecpcup
	,		rsvpcomp				= pvpcomp
	,		rsdifrea				= ISNULL(readifmes, 0)    
	,		rsvalvenc				= CASE	WHEN seriado  = 'N' AND rscodigo <> 888 THEN rsnominal
											WHEN                    rscodigo <> 888 THEN ROUND((cup*rsnominal)/100.0,4)
											ELSE										 cup
										END
	,		prima_descuento_total	= CASE	WHEN rsmonemi=13 THEN isnull( ROUND(PrimaDcto  *(rsnominal/nominal),2), 0 )
											ELSE                          ROUND(PrimaDcto  *(rsnominal/nominal),0)
										END
	,		prima_descuento_dia		= CASE	WHEN rsmonemi=13 THEN isnull( ROUND(valordia *(rsnominal/nominal),2), 0 )    
											ELSE                          ROUND(valordia *(rsnominal/nominal) * DATEDIFF(day, @dFechoy, @dFecprox),0)    
										END
	,		valor_tasa_emision		= CASE	WHEN rsmonemi=13 THEN ISNULL( ROUND(tasaEmis *(rsnominal/nominal),2),0)
											ELSE                          ROUND(tasaEmis *(rsnominal/nominal),0)
										END
	,		valor_par				= valorpar
	,		rsrutemis				= rutemis
    FROM	#TEMPORAL
	WHERE	rsfecha					= @dFecprox
	AND		rscartera				IN('111', '114', '159')
	AND		rsrutcart				= rutcart
	AND		rstipcart				= tipcart
	AND		rsinstser				= instser
	AND		rsfeccomp				= feccomp
	AND		rstir					= tircomp
	AND		numdocu					= rsnumdocu
	AND		correla					= rscorrela
	AND		rstipoper				= TipoDev
    
	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO', 'Problemas al Actualizar Tabla MDRS con Devengamiento'
		RETURN
	END
	
	SELECT	*
	INTO	#TEMPORAL2
	FROM	MDRS
	WHERE	rsfecha		= @dFecprox
	AND		rstipoper	= 'DEV'
	AND		rsflujo		> 0
	AND		rscartera	IN('111', '114', '159')
	AND		CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999- 13' ELSE '988-994-995-800-801' END)>0    

	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO','Problemas al Generar Temporal con Vencimientos'
		RETURN
	END

	UPDATE #TEMPORAL2 SET rstipoper = CASE WHEN rstipoper = 'DEV' THEN 'VC' ELSE 'VCP' END

	UPDATE #TEMPORAL2 SET rsnominal = rsnominal
	
	INSERT INTO MDRS
	SELECT * FROM #TEMPORAL2

	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO','Problemas al Insertar Vencimientos al MDRS'
		RETURN
	END

	UPDATE	MDRS
    SET		rsflujo   = rscupamo + rscupint + rscuprea
	WHERE	rstipoper = 'VC'
	AND		rsfecha   = @dFecprox

	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO','Problemas al Insertar Vencimientos al MDRS'
        RETURN
	END

	SELECT	@nContador	= COUNT(1) 
	FROM	MDRS
	WHERE	rsfecha		= @dFecprox
	AND		rstipoper	IN('VC','VCP')
	AND		rscartera	IN('111', '114', '159')
	AND		CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999- 13' ELSE '988-994-995' END) > 0    

	SET		@ix        = 0
	SET		@nContador = (SELECT COUNT(1)	FROM	MDRS
											WHERE	rsfecha = @dFecprox
											AND		rstipoper IN('VC' ,'VCP')
											AND		rscartera IN('111','114', '159')
											AND		CHARINDEX( STR(rsmonemi,3) , CASE	WHEN @cDevengo_dolar = 'N' THEN '997-998-999- 13'
																						ELSE							'988-994-995-800-801'
																					END) > 0)
	IF @nContador > 0
	BEGIN
		WHILE @nContador >= @ix
		BEGIN
			SET @cInstser = '*'
			SET @ix       = @ix + 1

			SET ROWCOUNT @ix    

			SELECT	@cInstser		= rsinstser
			,		@nRutcart		= rsrutcart
			,		@cCartera		= rscartera
			,		@nNumdocu		= rsnumdocu
			,		@nNumoper		= rsnumoper
			,		@nCorrela		= rscorrela
			,		@nValcomp		= rsvalcompcp
			,		@fValcomu		= rsvalcomucp
			,		@nInteres		= rsinteres_acumcp
			,		@nReajuste		= rsreajuste_acumcp
			,		@nIntdia		= rsinteres
			,		@nReadia		= rsreajuste
			,		@cSeriado		= inmdse
			,		@xTipOper		= rstipoper
			FROM	MDRS
			,		VIEW_INSTRUMENTO
			WHERE	rsfecha			= @dFecprox
			AND		rstipoper		IN('VC', 'VCP')
			AND		rscartera		IN('111','114', '159')
			AND		rscodigo		= incodigo
			AND		CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999- 13' ELSE '988-994-995' END) > 0

			SET ROWCOUNT 0    
    
			IF @cInstser = '*'
				BREAK

			UPDATE	MDRS
			SET		rsvalcomp       = @nValcomp
			,		rsvalcomu       = @fValcomu
			,		rsinteres_acum  = @nInteres  + @nIntdia
			,		rsreajuste_acum = @nReajuste + @nReadia
			,		rscupamo        = 0
			,		rscupint        = 0
			,		rscuprea        = 0
			,		rsvppresenx     = CASE WHEN @cSeriado='N' THEN 0 ELSE rsvppresenx END
			WHERE	rsfecha         = @dFecprox
			AND		rscartera       = @cCartera
			AND		rstipoper       IN('DEV','DVP')
			AND		rsnumdocu       = @nNumdocu
			AND		rsnumoper       = @nNumoper
			AND		rscorrela		= @nCorrela

			IF @@ERROR <> 0
			BEGIN
				SELECT 'NO','Problemas al Actualizar Tabla MDRS con K Devengamiento'
				RETURN
			END
			
		END --> While
	END		--> IF    


	EXECUTE SP_BUSCA_TASA @dFecprox, @dFecpcup, @dFechoy
	EXECUTE dbo.SP_DEVPROPIAINTER_PM @dFechoy	,	@dFecprox	
												,   @fTe_pcdus         ,   @fTe_pcduf         ,   @fTe_ptf           ,   @cDevengo_dolar     
	UPDATE	MDAC
    SET		acsw_dvprop = '1';

	--> se incluye el devengo para las transacciones Intramesa  ------------------------------------------------------------------------------------------
	EXECUTE dbo.SP_DEVPROPIAINTRAMESA @dFechoy, @dFecprox, @cDevengo_dolar
    -- ---------------------------------------------------------------------------------------------------------------------------------------------------

	SELECT 'SI','Proceso de Devengamiento ha finalizado en forma correcta'

	SET NOCOUNT OFF

	RETURN

END


GO
